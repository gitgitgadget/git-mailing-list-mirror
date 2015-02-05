From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] Makefile: Also add a symlink fallback to installing ALL_PROGRAMS
Date: Thu, 5 Feb 2015 16:52:33 +0100
Message-ID: <CAHGBnuPtzQeqNoHiwNoaH3j9OWXq-jopjwwdStS-0mnX_9mzww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJOjP-0003G6-77
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 16:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062AbbBEPwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 10:52:35 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:32860 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757846AbbBEPwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 10:52:34 -0500
Received: by mail-yk0-f173.google.com with SMTP id 142so3531170ykq.4
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 07:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=jrneAwP25kP4fobTr1sPZzb6jx2SkPol1F7F/txt5UQ=;
        b=vJL672/xPRXiCdNBorPjwdjt+G0l7PHWdL0Q5Itwk4cEYsX+rw2IewsyjWnLscJa0p
         EqZA8Ca1KLqsEt7ic1orOyEy6WDUo8fYoyOUqa4z8bgvFNnIwWYcqgGLI2QZbXjvLjSh
         +RC98uzfo4N/N430e5W/BVzRqT48gsRloY9Jf/bBZtJX9dpBx1sy2neTfyFjyqc9vMo/
         5wCeyI0Yz9pC5Yyz65BSxIlnSV4fBC3Qotd06DsZSOo9BvtrNK6bMqA2Ttj21r9uzbuQ
         tsPAMqH0+Q0J8ig/hq764e928E9qpBQ5MPtni3mLsEs4ul61p8kPe/Act+2xCmKHXrku
         wSDA==
X-Received: by 10.236.24.129 with SMTP id x1mr1790070yhx.118.1423151553860;
 Thu, 05 Feb 2015 07:52:33 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 07:52:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263375>

We do this for BUILT_INS and REMOTE_CURL_ALIASES, so we should do so here,
too.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 21f23cb..d2849c3 100644
--- a/Makefile
+++ b/Makefile
@@ -2258,6 +2258,7 @@ endif
         $(RM) "$$execdir/$$p" && \
         test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
         ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
+        ln -s "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
         cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
       done; \
     } && \
-- 
2.1.2-mingw-1
