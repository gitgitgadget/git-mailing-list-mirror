From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 20 Oct 2007 13:29:31 +0200
Message-ID: <4719E69B.3020906@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail .com>	 <Pine.LNX.4.64.0710130130380.25221@racer.site> <1192827476.4522.93.camel@cacharro.xalalinux.org> <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Federico Mena Quintero <federico@novell.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjCWd-0006U2-Gl
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbXJTL3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755299AbXJTL3i
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:29:38 -0400
Received: from mail.op5.se ([193.201.96.20]:58160 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbXJTL3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:29:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 02B221730580;
	Sat, 20 Oct 2007 13:28:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iObsi3YL1mfu; Sat, 20 Oct 2007 13:28:56 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 083C1173057C;
	Sat, 20 Oct 2007 13:28:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61822>

Steffen Prohaska wrote:
> 
> On Oct 20, 2007, at 10:03 AM, Andreas Ericsson wrote:
> 
>>
>> Personally, I can't help but think that the numerous times I've heard "oh
>> gods, that's a lot of commands" should finally mean something. I've 
>> started
>> taking a look at which of them one can bundle together. If we can drop 
>> the
>> porcelainish commands down to ~30 or so, and hide the plumbing from 
>> git-<tab>
>> listings, the initial hurdle people have to jump would be 
>> significantly lower.
> 
> Maybe we could group commands into more categories?
> 
> plumbing: should be hidden from the 'normal' user. Porcelain
>   should be sufficient for every standard task.
> 

Agreed. /usr/libexec/git/ seems to me to be the ideal spot for
it.

> core porcelain: this is what everyone needs who works in a
>   pure git based workflow based on push/pull. You can't use
>   git without these commands. But these commands are already
>   sufficient to solve most of your tasks.
> 

Agreed.

> mail porcelain: the list will probably hate me for this, but
>   I think all commands needed to create and send patches per
>   mail are not essential. I suspect that I'll _never_ ask
>   my colleagues at work to send me a patch by mail. They'll
>   always push it to a shared repo.
> 

Disagreed, for obvious reasons. Many OSS projects are patch-centric
and developed much like git. OTOH, having to run "git format-patch"
rather than "git-format-patch" probably isn't so hampering that we
can't live with it.

> import/export: Many commands are only used for importing
>   from or exporting to other version control systems. Examples
>   are git-cvs*, git-svn*. They are not needed once you switched
>   to git.
> 

But very nifty for incremental imports. I track several CVS repos
that I continuously import. They're also self-explanatory, so
they don't add much to the clutter. Same reasons as above though;
there's no real reason not to invoke them as "git cvsimport" rather
than "git-cvsimport".

> admin: Some commands are not used in a typical workflow. For
>   example git-filter-branch or git-fsck have a more admin
>   flavor.
> 

git-filter-branch could definitely live its life hidden somewhere.
git-fsck probably should stay with the plumbing, as it's used by
other porcelainish programs more often than run directly by the
user.

> There might be more categories. I am not sure because there
> a quite a few commands that I _never_ used and have no clear
> idea about what they do.
> 
> 
> So here are a few questions:
> 
> Could we find a small set of core porcelain commands that
> completely cover a typical workflow? The core section of the
> manual should only refer to those commands. Absolutely no
> plumbing should be needed to tweak things. In principle, a
> typical user should be able to work if _all other_ commands
> except for core porcelain are hidden from his PATH.
> 

Note that this is already possible, using a libexec-dir and
passing --exec-dir to the git wrapper. The only thing that isn't
done is deciding what's *definitely* plumbing. Once that's defined,
the makefile can install plumbing to a separate directory and
the /usr/bin/git-<tab> should shrink by roughly half.

> Another section in the manual should describe a workflow based
> on sending patches around. Obviously the mail porcelain is
> needed for this.
> 
> ... and so forth.
> 
> I don't know if we really want to hide the commands from PATH.
> But maybe we should consider grouping them into subdirectories,
> or provide another way to for the user to focus on the core
> porcelain.
> 

Hiding the really core plumbing and getting rid of redundant
programs (git-am, git-apply, git-applypatch, ...) would do wonders,
methinks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
