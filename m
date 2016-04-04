From: santiago@nyu.edu
Subject: [PATCH v4 4/6] tag.c: Replace varialbe name for readability
Date: Mon,  4 Apr 2016 18:22:13 -0400
Message-ID: <1459808535-8895-5-git-send-email-santiago@nyu.edu>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 00:22:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anCtG-0007cZ-UU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbcDDWWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:22:31 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36122 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370AbcDDWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:22:28 -0400
Received: by mail-qg0-f48.google.com with SMTP id f52so68621200qga.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvEsJJaEqoKSKs6u1vRWZd/SIm/ZRKTPEplsujMWjgA=;
        b=aEvWZTNhwrJ3ocuKXYXPeOtPu1ZRzRZO8hugpysXUSHpTiVWxsEyATBxuIw+fkHe93
         sRqXAt4JLjk4uZTZdDsbIXtpC0go5BfPV7UA2i9HMAaaR2/t/ThauaL6mAg4783eYtAm
         bxWbhiG5UHctCxFfZ8m4WPd462o/b96WqRf5aqtVe/HF9tcvatEjIqmV/54UaOo1EgVF
         FsrkN9PbVP3dm2LiWRZEgEnsDkTHi5iVQ4GDu0KPpYxrP9HyyrlMazrqD7JvkdTBo1xa
         HvJtR1iXJbD/QMN6VEH/dMcHg5jGoNkYe4lescF1gRn47ixCr4rPW6PzRcmN1u+haU1/
         AoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvEsJJaEqoKSKs6u1vRWZd/SIm/ZRKTPEplsujMWjgA=;
        b=k0dd/Hw6MgKOOn8ppXJFXm/dY3Wspg0f5qaekVRqUVQLyRorF/JA8oJxYqR+ProPct
         FFzTfJKYv2fYJvIgDgUCOGrVnWypwB8wuW0mkAJKPYQXgkusSJq1chYBC7UlyX7pSMfO
         LiQDQeVQkUA839SFHGFZDVAORVysgEgc/yVMq2Q5LS2f6QmklLAUXePQpmEAQz2c0fFW
         D1IqTaVaG93jDHDUce/Yjvt+nwbTWRnGPckzONC7ci8gIIoFeCy4ybFryl/6R9AM8m1f
         +vIwkrwBWe4nDTAoFeacis85cx3DbEr8L/AgpTSSYVm1+qQLzuMssHc27dFAeXYohQY5
         pMEw==
X-Gm-Message-State: AD7BkJKmtAlNQM1NtTGiMUJn0A53s1UL6G9KRr3ZjAwlGdzRmYckDmp2RqCSuvNTz+v7hAOD
X-Received: by 10.140.35.115 with SMTP id m106mr15123192qgm.13.1459808547264;
        Mon, 04 Apr 2016 15:22:27 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id h9sm13180670qhh.29.2016.04.04.15.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 15:22:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290729>

From: Santiago Torres <santiago@nyu.edu>

The run_gpg_verify function has two variables size, and len. This may
come off as confusing when reading the code. We clarify which one
pertains to the length of the tag headers by renaming len to
payload_length.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
	Note: this used to be part of the previous patch on v3. I moved the
renaming part to a single patch to simplify the review. 

 tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tag.c b/tag.c
index 81e86e6..f6443db 100644
--- a/tag.c
+++ b/tag.c
@@ -9,20 +9,21 @@ const char *tag_type = "tag";
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
-	int len;
+	int payload_length;
 	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	len = parse_signature(buf, size);
+	payload_length = parse_signature(buf, size);
 
-	if (size == len) {
+	if (size == payload_length) {
 		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
+			write_in_full(1, buf, payload_length);
 		return error("no signature found");
        }
 
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	ret = check_signature(buf, payload_length, buf + payload_length,
+				size - payload_length, &sigc);
 	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
-- 
2.8.0
