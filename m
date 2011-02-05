From: david@lang.hm
Subject: Re: moving to a git-backed wiki
Date: Fri, 4 Feb 2011 23:00:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102042259520.8162@asgard.lang.hm>
References: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org> <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org> <20110131225529.GC14419@sigill.intra.peff.net> <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com> <20110201201144.GA16003@sigill.intra.peff.net>
 <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com> <4D488DCD.3080305@eaglescrag.net> <4D4929F4.3020805@snarc.org> <4D4A11D7.4040103@eaglescrag.net> <20110203174518.GA14871@sigill.intra.peff.net> <20110204143421.GA6449@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 08:00:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plc8H-0007So-Bp
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 08:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab1BEHAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 02:00:22 -0500
Received: from mail.lang.hm ([64.81.33.126]:40330 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab1BEHAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 02:00:20 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p1570Gvl011259;
	Fri, 4 Feb 2011 23:00:16 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20110204143421.GA6449@gnu.kitenet.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166077>

On Fri, 4 Feb 2011, Joey Hess wrote:

> Jeff King wrote:
>> If it sounds like I'm handwaving away scalability problems, I am. I'd be
>> curious to see some performance numbers for gollum or ikiwiki versus
>> more traditional wiki formats.
>
> Ikiwiki builds static pages, this tends to mean it doesn't have
> performance, because there is little more to perform than
> httpd < file > network :)
> So I've routinely had ikiwiki sites slashdotted, and not noticed.

I think you mean it doesn't have performance _problems_ ;-)

David Lang

> Ikiwiki is not enormously fast in the rare cases when it does have to
> run as a CGI, but little of that has to do with git. About the worst
> case is that saving a page edit leads to a git commit -- if git
> decides to gc the repository right then, it could make the save stall
> for a while. There are easy ways to avoid that. (ie, git gc in cron job)
> In general, though ikiwiki as a CGI is fast enough to not be annoying --
> although it won't scale to a site the size of wikipedia.
>
> Since I'm lazy, ikiwiki does not include a history or diff viewer. It
> just points off to gitweb or a similar tool. As you say, gitweb can be
> fast enough, and really most wiki users do read their current content,
> or maybe make an edit; digging in the history is comparatively rare.
> And once users realize the wiki is in git, they can use gitk to dig in
> the history without using any server resources. :)
>
> The feature I like best with using git for a wiki (besides ease of
> branching) is that it can actually make a legitimate use of the
> woefully underused git push over git:// feature. Ikiwiki can be
> configured to check such pushes, running via the pre-receive hook. This
> allows it to limit the changes that can be pushed anonymously to changes
> that could be made using the web interface. So if you've chosen to lock
> some pages, or virus filter attachments, or whatever, in the web side of
> the wiki, that all applies to the anonymous git pushes too. Details at
> <http://ikiwiki.info/tips/untrusted_git_push/>
>
>
