From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 21:16:13 +0100
Message-ID: <m2obw7dg1e.fsf@igel.home>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
	<m2sjlkcgyl.fsf@igel.home> <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:16:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrKq-0004sm-Eb
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1KSUQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:16:20 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43999 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab1KSUQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 15:16:19 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7EEA3188A166;
	Sat, 19 Nov 2011 21:18:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id AD3F31C00046;
	Sat, 19 Nov 2011 21:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id vNlkyPoW27Bt; Sat, 19 Nov 2011 21:16:14 +0100 (CET)
Received: from igel.home (ppp-88-217-98-198.dynamic.mnet-online.de [88.217.98.198])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 19 Nov 2011 21:16:14 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9163ECA29C; Sat, 19 Nov 2011 21:16:13 +0100 (CET)
X-Yow: Is this where people are HOT and NICE and they give you TOAST for
 FREE??
In-Reply-To: <7v39dkj5ad.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 19 Nov 2011 11:11:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185705>

Junio C Hamano <gitster@pobox.com> writes:

> We have relied on fstat(-1, &st) to correctly error out, and if MSVC build
> crashes, it is a bug in its fstat() emulation, I would think.

fileno(stdout) is alread wrong if stdout was closed.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
