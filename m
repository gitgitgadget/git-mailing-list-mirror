From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 08:02:53 +0200
Message-ID: <5087848D.7060400@viscovery.net>
References: <5082A1F1.3080303@tilera.com> <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk> <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk> <alpine.LFD.2.02.1210232232070.2756@ionos> <20121023205119.GA27729@sigill.intra.peff.net> <alpine.LFD.2.02.1210232307480.2756@ionos> <20121023214717.GA29306@sigill.intra.peff.net> <522C1DF17AF50042AD8AE87F7887BD3D0B60880C30@exch.hq.tensilica.com> <20121023222318.GA3055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marc Gauthier <marc@tensilica.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQu3z-0000T0-A5
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 08:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab2JXGDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 02:03:22 -0400
Received: from so.liwest.at ([212.33.55.24]:54341 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402Ab2JXGDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 02:03:21 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TQu3K-0002rr-74; Wed, 24 Oct 2012 08:02:54 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 864101660F;
	Wed, 24 Oct 2012 08:02:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121023222318.GA3055@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208287>

Am 10/24/2012 0:23, schrieb Jeff King:
> For the fold-on-rebase idea, I'd think you would want something similar,
> like setting rebase.foldNotes to "foo" to say "refs/notes/foo contains
> pseudo-headers that should be folded in like a signed-off-by".

If you are rebasing anyway, you can already use interactive rebase's
--autosquash option:

# a late ACK came in:
git commit --allow-empty -m'squash! tile: support GENERIC_

Acked-by: A U Thor <author@example.com>'

git rebase -i --keep-empty --autosquash $forkpoint

Requires git 1.7.11 for --keep-empty and requires to edit out the
'squash!...' headers when the editor appears during the rebase.

-- Hannes
