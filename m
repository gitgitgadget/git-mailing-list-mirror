From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4 0/4] Stream fd to clean filter, GIT_MMAP_LIMIT, GIT_ALLOC_LIMIT
Date: Fri, 22 Aug 2014 16:01:19 +0200
Message-ID: <1408716083-9093-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:03:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKpRE-0002Js-5D
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 16:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbaHVOD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 10:03:27 -0400
Received: from mailer.zib.de ([130.73.108.11]:33709 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbaHVOD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 10:03:26 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1wmC009781;
	Fri, 22 Aug 2014 16:01:58 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1vrR009676;
	Fri, 22 Aug 2014 16:01:57 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
X-Miltered: at mailer.zib.de with ID 53F74D56.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F74D56.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F74D56.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255673>

Only changes since PATCH v3: Use ssize_t to store limits.

Steffen Prohaska (4):
  convert: Refactor would_convert_to_git() to single arg 'path'
  Introduce GIT_MMAP_LIMIT to allow testing expected mmap size
  Change GIT_ALLOC_LIMIT check to use ssize_t for consistency
  convert: Stream from fd to required clean filter instead of mmap

 convert.c             | 60 +++++++++++++++++++++++++++++++++++++++++++++------
 convert.h             | 10 ++++++---
 sha1_file.c           | 46 ++++++++++++++++++++++++++++++++++++---
 t/t0021-conversion.sh | 24 ++++++++++++++++-----
 wrapper.c             |  8 +++----
 5 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.1.0.6.gb452461
