From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] sha1_file.c: zlib can only process 4GB at a time
Date: Wed, 08 Jun 2011 21:16:44 +0200
Message-ID: <m2vcwgf80z.fsf@igel.home>
References: <7v1uz42liw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:17:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOFQ-0004KS-8z
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1FHTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:16:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47337 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1FHTQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:16:47 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 30D741C00A47;
	Wed,  8 Jun 2011 21:16:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 2BA671C0016D;
	Wed,  8 Jun 2011 21:16:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Pbv82DRVBSZ7; Wed,  8 Jun 2011 21:16:44 +0200 (CEST)
Received: from igel.home (ppp-88-217-111-39.dynamic.mnet-online.de [88.217.111.39])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed,  8 Jun 2011 21:16:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 60A0CCA29C; Wed,  8 Jun 2011 21:16:44 +0200 (CEST)
X-Yow: ..  One FISHWICH coming up!!
In-Reply-To: <7v1uz42liw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 08 Jun 2011 12:03:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175446>

Junio C Hamano <gitster@pobox.com> writes:

> +#define ZLIB_BUF_MAX ((1UL << ((sizeof(uInt) * 8))) - 1)

This is undefined if unsigned long has 32 bits.

#define ZLIB_BUF_MAX ((uInt)-1)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
