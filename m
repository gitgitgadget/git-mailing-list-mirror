From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Mon, 06 Aug 2007 18:10:10 +0200
Message-ID: <86bqdkbq59.fsf@lola.quinscape.zz>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?AF1190=04E2-A0F4-4?= =?ISO-8859-1?Q?79F-B0A1-50B2C72?=
	=?ISO-8859-1?Q?78995@yahoo.ca>?= <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?Pine=04.LNX.4.64.0?= =?ISO-8859-1?Q?708031121000.147?=
	=?ISO-8859-1?Q?81@racer.site>?= <7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 18:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II5A7-0008DI-LS
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 18:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbXHFQK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbXHFQK0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 12:10:26 -0400
Received: from main.gmane.org ([80.91.229.2]:42160 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbXHFQK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 12:10:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1II59x-0000JP-5a
	for git@vger.kernel.org; Mon, 06 Aug 2007 18:10:21 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 18:10:21 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 18:10:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Ff5rQjFrlItd37ITELvrj/NtlMc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55157>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> But I'd really think that what should be done (if anything has to be done 
>> at all) is to introduce a config variable which triggers the same logic in 
>> git-diff as was introduced in 2b5f9a8c0cff511f2bb0833b1ee02645b79323f4.
>
> Sorry, I don't follow at all.  The diff toolchain works all
> inside core without having to write a temporary index out, which
> was the issue the commit you are quoting was about.
>
> In any case, enough discussion.  Here is an updated patch, which
> I _could_ be pursuaded to consider for inclusion after v1.5.3
> happens, if there are enough agreements and Acks.

Ack, ack, ack.  The current default behavior is plainly unusable.  For
example, I've rsynced -a a tree including .git, and suddenly git-diff
goes out of kilter.  And stops doing so when running git-status once.

This is the worst kind of "unpredictable", and I don't care one bit
that there are conceivable use cases.

I don't even think it prudent to _offer_ the --show-touched option in
a porcelain such as git-diff as long as purportedly read-only
porcelain commands like git-status can trash the state: what is
reported is not actually "touched" but something internal to the
operation of git.

At least not without a notice in the manual that this option might or
might not work, depending on what one did previously.

-- 
David Kastrup
