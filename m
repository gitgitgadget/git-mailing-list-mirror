From: David Kastrup <dak@gnu.org>
Subject: Re: Proposal about --help options and man calls
Date: Thu, 19 Jul 2007 01:28:47 +0200
Organization: Organization?!?
Message-ID: <85ejj5wats.fsf@lola.goethe.zz>
References: <85y7hdwfds.fsf@lola.goethe.zz> <7v644h715y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 01:29:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBIxA-0007jx-LL
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbXGRX3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936606AbXGRX27
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:28:59 -0400
Received: from main.gmane.org ([80.91.229.2]:47661 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936040AbXGRX26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 19:28:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBIwv-0001dD-Ht
	for git@vger.kernel.org; Thu, 19 Jul 2007 01:28:53 +0200
Received: from dslb-084-061-086-214.pools.arcor-ip.net ([84.61.86.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 01:28:53 +0200
Received: from dak by dslb-084-061-086-214.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 01:28:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-086-214.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:UGD9RphsITgHJmoDQDgapyd3Ib4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52909>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Frequently, git somecommand --help will call the man command to
>> display help pages.  I think that when it does so, it should pass the
>> value of the GIT_PAGER variable copied into the PAGER variable: the
>> paging happens on behalf of git here.
>
> Hmph.  Is that to help people who uses GIT_PAGER but no PAGER,
> or have both but set it differently (setting both and in the
> same way does not make much sense).  But what it means is that
> "git command --help" and "man git-command" would be paged
> differently.  I highly doubt it is really desirable.
>
> What's the reason to set GIT_PAGER and PAGER differently to begin
> with?  Can people give examples of the reason why?

If I call command --help, I don't want a pager barfing at me.  Never.
I have scrollback for that.  It is my choice when I page and when I
page not.  There are manual pages who go through 50 pages or so,
however.  There are commands that fundamentally are connected with a
pager.  man is, for example.  But most cases where git calls a pager
(and that includes his way of calling man without getting asked for it
explicitly) utterly surprise me.  So I set GIT_PAGER to cat and hoped
that it would get git to behave.  Sometimes it does, sometimes it
doesn't.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
