From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/22] git-compat-util.h: add the FORMATPRINTF macro
Date: Thu, 11 Feb 2016 12:38:38 +0000
Message-ID: <1455194339-859-2-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXl-0000DJ-HN
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbcBKMjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33792 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcBKMjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so10437963wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1hfxJpGvRGUgcgXzYcyprb6mw7ahzSTt9RPg/spRZc=;
        b=Kk4Vf6VELQS30VyoXVUjq8oYBDDXIiDxTx6VsUjuhFx1rszJ9ox0Yr00DkyTvnj0Mz
         vNMLJQNkspjX6YdUBvsa5FgbF/CqojoDzc0TkhgMVmQcz8BfzhB44dgHKdKDROfVMWAM
         Y1/rv2rHfH61wmUow9z5dfrLgkdzvYZIohrLg3rluytircyU6ETg5Q4MJVwXxuvyP27e
         /l8Z+Kp0kQf3imQ+viQQR+soZo92bWJ/cQc+o/xXPi/STgKGZEVar1bNXlRSDiK12iNy
         I7gRitaDQbEP6fBEXAgfGeZGEcHWxJ6ynaBMeoQLumfJMXssncUuzaQSQnsOCAW2EfP1
         f4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k1hfxJpGvRGUgcgXzYcyprb6mw7ahzSTt9RPg/spRZc=;
        b=O8eQ2fX0GQBVGJb/ujAK+mKDi6upy5vsyn6dk+4ux64ppK8INXIORPI7uyYxgybEJG
         W0MbJZtmh+LFosigZ0t9CphXjGp6MQ0JV0H1DBow5OQpczzj65xl36tQHSuG5Zw+Cggw
         5PneXiUCwd1wJIwMPpjtFNv30+07xRGm1/0ScoupHX/hato/DHNcFaNOcohtR9FxrpbS
         7xIvcSMA7E0wlHOGZscQcOlRV60qW23TagtG6LKgteZ+zImoPbvdHPGr7ALB1ybjIw5O
         F+gh1MRQOu3TFq+Cvie0KZxBQpQs+OlPY9w+zOKdAHM4cGDBP4tivqCHrt+n3dDYdHHx
         gqIQ==
X-Gm-Message-State: AG10YOQv492F414mnlONlzmFidnNhHDSuojg/kdWvy3DaOrR/GXswornPiyNpt0vIUwrlA==
X-Received: by 10.194.243.103 with SMTP id wx7mr50169859wjc.136.1455194358592;
        Thu, 11 Feb 2016 04:39:18 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:18 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285976>

Add the FORMATPRINTF macro for declaring the gcc function attribute 'format printf'
for code style consistency with similar macro that git already use for other gcc
attributes.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-compat-util.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 693a336..17349d9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -388,6 +388,8 @@ static inline char *git_find_last_dir_sep(const char *path)
 #endif
 #endif
 
+#define FORMATPRINTF(a,b) __attribute__((format (printf, a, b)))
+
 /* The sentinel attribute is valid from gcc version 4.0 */
 #if defined(__GNUC__) && (__GNUC__ >= 4)
 #define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
@@ -404,11 +406,11 @@ struct strbuf;
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
-extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void usagef(const char *err, ...) FORMATPRINTF(1,2);
+extern NORETURN void die(const char *err, ...) FORMATPRINTF(1,2);
+extern NORETURN void die_errno(const char *err, ...) FORMATPRINTF(1,2);
+extern int error(const char *err, ...) FORMATPRINTF(1,2);
+extern void warning(const char *err, ...) FORMATPRINTF(1,2);
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
@@ -759,7 +761,7 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
 /* in ctype.c, for kwset users */
-- 
2.5.0
