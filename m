From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Tue, 07 Aug 2007 08:41:04 +0200
Message-ID: <86d4xzaltr.fsf@lola.quinscape.zz>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org> <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 08:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIIkp-0008Ku-B9
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbXHGGlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 02:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbXHGGlQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:41:16 -0400
Received: from main.gmane.org ([80.91.229.2]:34981 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbXHGGlP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 02:41:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIIkj-0000JN-BK
	for git@vger.kernel.org; Tue, 07 Aug 2007 08:41:13 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 08:41:13 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 08:41:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:6DNXb6CUVlf4fKT+fuxnEUfu/bQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55226>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Doing a "git diff" cannot actually update the index (since it very
>> much has to work on a read-only setup too), which is why the index
>> _stays_ stale unless something is done (eg "git status") to refresh
>> it. And it's that stale index that continues to make for bad
>> performance without any indication of why that is a problem.
>
> Indeed.
>
> At least, I am now glad to know that somebody else is of the same
> opinion as I am.

I don't want a system to tell me when it is shooting itself in the
foot.  It should not be doing this in the first place.

File systems have automatic fsck procedures enforced regularly, too,
to keep them operative. If git finds that it is getting inefficient,
it should just mark the index as "regenerate at next access".  And
then do it.

-- 
David Kastrup
