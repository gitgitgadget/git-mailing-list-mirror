From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v3 0/3] Stream fd to clean filter, GIT_MMAP_LIMIT
Date: Thu, 21 Aug 2014 18:05:07 +0200
Message-ID: <1408637110-15669-1-git-send-email-prohaska@zib.de>
Cc: Junio C Hamano <gitster@pobox.com>, peff@peff.net,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 18:06:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKUsm-0007SA-W3
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 18:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbaHUQGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 12:06:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:55755 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbaHUQGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 12:06:31 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7LG5ZPJ021629;
	Thu, 21 Aug 2014 18:05:35 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7LG5Xg4021594;
	Thu, 21 Aug 2014 18:05:34 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 53F618CF.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F618CF.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F618CF.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255620>

I revised the testing approach as discussed.  Patch 2/3 adds GIT_MMAP_LIMIT,
which allows testing of memory expectations together with GIT_ALLOC_LIMIT.

The rest is unchanged compared to v2.

Steffen Prohaska (3):
  convert: Refactor would_convert_to_git() to single arg 'path'
  Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
  convert: Stream from fd to required clean filter instead of mmap

 convert.c             | 60 +++++++++++++++++++++++++++++++++++++++++++++------
 convert.h             | 10 ++++++---
 sha1_file.c           | 46 ++++++++++++++++++++++++++++++++++++---
 t/t0021-conversion.sh | 24 ++++++++++++++++-----
 4 files changed, 123 insertions(+), 17 deletions(-)

-- 
2.1.0.6.gb452461
