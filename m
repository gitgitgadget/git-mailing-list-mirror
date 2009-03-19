From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 08:16:10 -0700
Message-ID: <20090319151610.GO23521@spearce.org>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkK14-0001zR-7k
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbZCSPQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbZCSPQN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:16:13 -0400
Received: from george.spearce.org ([209.20.77.23]:39175 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbZCSPQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:16:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C68D838221; Thu, 19 Mar 2009 15:16:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113781>

Pat Notz <patnotz@gmail.com> wrote:
> On Thu, Mar 19, 2009 at 7:50 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> > Pat Notz venit, vidit, dixit 19.03.2009 14:43:
> >> On Thu, Mar 19, 2009 at 7:33 AM, Michael J Gruber
> >> <git@drmicha.warpmail.net> wrote:
> >>>
> >>> Also, they need push tracking for pushing through ssh, which is a common
> >>> requirement for many large projects. Do we have something to support
> >>> that? git-notes comes to my mind.
> >>>
> >>> Their current approach is writing to a single log file (receive-hook).
> >>> That may support a linear push history best, but looking up who pushed
> >>> what, given "what"?
> >>
> >> That's also something we do. ?Since the post-receive hook gives you
> >> the refname and the old and new refs you should have everything you
> >> need. ?We basically record the user name, UTC timestamp and the ref
> >> info. ?With a little bit more scripting you should be able to figure
> >> everything else out (though post-receive isn't called for local
> >> commits).

Why are people reinventing the reflog, and core.logallrefupdates ?

> > I know the info is there. It might just make more sense to have it in
> > the git repo the way notes are/will be: It's public, it's connected to
> > the commits, it's tamper proof (anyone would notice rewrites).
> 
> Ahh, yes.  We'd like that too.

Eclipse is also talking about Git, and has a similar problem.

Anytime you start talking about "who put what" though, you get into a
"where, and why does it matter?"

Imagine you are Eclipse Foundation or GNOME, you need to know which
authorized developer put the code on your servers.

But imagine you are an ISV like Oracle or IBM and you consume
code from the upstream project (Eclipse), put it on your servers,
add some "extra sauce", and distribute the result in some form.
Who put what on the Eclipse server isn't relevant, but what employee
your clone to use 3.4.1 instead of 3.4.0 matters a whole lot more.
For the most part, you just trust the upstream to do their own
IP tracking and diligence, as they have the contributor license
agreements, and you don't.

Its a thorny problem.  We've talked about trying to add some sort
of GnuPG signature into a push stream (for example) to allow the
server to store a record of who-did-what-when and later distribute
that back.

  http://thread.gmane.org/gmane.comp.version-control.git/71849

-- 
Shawn.
