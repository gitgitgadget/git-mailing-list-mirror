From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Makefile: fix default regex settings on Darwin
Date: Fri, 10 May 2013 22:08:33 -0700
Message-ID: <1368248913-95188-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 07:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub237-0007au-Rv
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 07:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab3EKFIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 01:08:46 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35401 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab3EKFIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 01:08:45 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so3229783pdi.19
        for <git@vger.kernel.org>; Fri, 10 May 2013 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=A/6gYw2jMRFsNvcps4UEDicN3S+awe4UKeUm+8HIdMw=;
        b=ap+fHYBYr4t8MfvKAvsOp4OcXnQFIQtUBWC+LV2CAQ0cMWX0F8O+Q4lVsPNOkCzj/t
         /atfpBvoQCxFk9kh3VgaEwSLHf4qoGK0ktdv2LNfdEuRW8QaGP3m9IZDFmZiQnB5wyBE
         XcLW1CegNz3rPnb5guFKQEaHWuZfmggPDb8PAX3VE4CvcufgnX8Q5wHwR+5ghZ3JtUSx
         Y1hTx2E3H8ohRQGhb6NTFbMSS7F3THmvCrQMXHfA7+GRwZrnklrCZmHmn0EMmAW/OM7K
         ROW3/DYPnChoduPShhRaXgTzBrsv1pDactEuolBSG/8H2GKTVzOXwaLq3pKke7ZbUSrS
         YqKw==
X-Received: by 10.68.245.6 with SMTP id xk6mr20238432pbc.41.1368248924711;
        Fri, 10 May 2013 22:08:44 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id vv6sm5529717pab.6.2013.05.10.22.08.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 22:08:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.47.g6e51a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223928>

t0070-fundamental.sh fails on Mac OS X 10.8 by default.
Fix it by using Git's regex library.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
"make test" fails right now; this fixes it.
t0070-fundamental is how far it got last time.
It's still running now.. :-)

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 7e12999..4a462c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1057,6 +1057,7 @@ ifeq ($(uname_S),Darwin)
 	COMMON_DIGEST_SHA1 = YesPlease
 	COMMON_DIGEST_HMAC = YesPlease
 	PTHREAD_LIBS =
+	NO_REGEX = YesPlease
 endif
 
 ifndef CC_LD_DYNPATH
-- 
1.8.3.rc1.47.g6e51a5f
