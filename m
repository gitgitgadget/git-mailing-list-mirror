From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] MSVC: fix t0040-parse-options crash
Date: Sun, 30 Mar 2014 10:29:04 +0200
Message-ID: <m2wqfcm6nj.fsf@linux-m68k.org>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
	<1396123762-28673-1-git-send-email-marat@slonopotamus.org>
	<7vtxago359.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 10:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUB7s-0001vU-0Z
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 10:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbaC3I3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 04:29:14 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45099 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbaC3I3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 04:29:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fxVMT4VCbz4KK28;
	Sun, 30 Mar 2014 10:29:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fxVMT4F7szbc65;
	Sun, 30 Mar 2014 10:29:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id xtq-0saCA4uC; Sun, 30 Mar 2014 10:29:08 +0200 (CEST)
X-Auth-Info: KjQOohwm616y6iIyCctX0yleB4HQF7s6Zbd6f+oyXpI=
Received: from linux.local (ppp-93-104-157-147.dynamic.mnet-online.de [93.104.157.147])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 30 Mar 2014 10:29:08 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 8F28A1E55C4; Sun, 30 Mar 2014 10:29:05 +0200 (CEST)
X-Yow: It was a JOKE!!  Get it??  I was receiving messages
 from DAVID LETTERMAN!!  YOW!!
In-Reply-To: <7vtxago359.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 29 Mar 2014 19:01:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245455>

Junio C Hamano <gitster@pobox.com> writes:

> As OPT_SET_PTR() is about setting the pointer value to intptr_t defval,
> a follow-up patch on top of this fix (see attached) may not be a bad
> thing to have, but that patch alone will not fix this issue without
> dropping the unneeded and unwanted cast to unsigned long.

Wouldn't it make sense to change defval into a union to avoid the cast?
(The intptr_t type may be too narrow for other values to be put there.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
