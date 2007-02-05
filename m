From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 05 Feb 2007 10:33:49 +0100
Organization: At home
Message-ID: <eq6tj6$80m$2@sea.gmane.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 10:32:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE0DN-0002Qv-Vy
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 10:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbXBEJcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 04:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbXBEJcm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 04:32:42 -0500
Received: from main.gmane.org ([80.91.229.2]:43534 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbXBEJcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 04:32:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HE0D8-0006Hg-VX
	for git@vger.kernel.org; Mon, 05 Feb 2007 10:32:30 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 10:32:30 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 10:32:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38737>

Junio C Hamano wrote:

> We seem to have accumulated some crufts, duplicated and/or
> disused features.  I think we should start planning deprecation
> and removal.
> 
> Here are potential candidates we might want to mark as
> "scheduled for removal".  Note that I threw in a bit more than
> what I seriously consider bloat, so your favorite may appear in
> the list.
> 
> * git-applymbox and git-applypatch
> 
>   Does anybody rely on them?  I think new users are all using
>   git-am (this is just what _I_ think -- please consider this
>   message as a poll to voice your objection).

If I remember correctly there are here because Linus is used to
their interface and prefers git-applymbox to git-am. I'm not sure
for example if git-am --interactive is on the par of git-applymbox -q
option (BTW. if we remove git-applymbox, we would have to remove
reference to it in git-am(1): "--interactive: Run interactively,
just like git-applymbox"). git-am also lack all git-applymbox
signoff options.

> * git-whatchanged
> 
>   This has been identical to git-log with different default
>   options.

I agree. Perhaps we should add in the documentation of git-log,
or/and in documentation of git-config, an example of "whatchanged"
alias...

> * git-p4import, git-quiltimport and contrib/gitview
> 
>   These have seen almost no activity since their appearance.  It
>   could be that they are already perfect and many people are
>   using them happily, but I find it a bit hard to believe.

I agree with removal of gitview; I'd rather leave importers, even
if they haven's seen any activity. If they import correctly, what
is to work on more?

> * git-diff-stages
> 
>   Judging from the fact that nobody complained what it does is
>   not accessible from "git diff" wrapper, I suspect nobody is
>   interested in comparing the stages while merging (I certainly
>   do not use it myself).

I think you can always use "git diff <stage1>:<file> <stage2>:<file>".
I'm not sure if it is useful or not (perhaps it is not advertised).

> * git-lost-found
> 
>   Although it has served us well, I think it is about to outlive
>   its usefulness, thanks to the recent "reflog by default"
>   change.

I agree. If it is needed, perhaps this functionality should be made
as an option to git-fsck.

> * contrib/colordiff
> 
>   This has long outlived its usefulness.

I agree.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
