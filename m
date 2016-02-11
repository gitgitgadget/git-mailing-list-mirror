From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/22] cache.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:45 +0000
Message-ID: <1455194339-859-9-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXJ-000869-4u
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbcBKMjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33859 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbcBKMjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id p63so10438413wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GarDjJQ3mtjv8KcH5SwUk3YHDKyEAs77Lu7oHMWgJkc=;
        b=Zzr9Fkqc0kWjmYKhFcjX1uP97poF8AfU3MOyfSOWb3O5ToFY3VrtIdmdvlUXaIShNB
         xsFuUks3kUEwt+tIiRKD5BE6sn3bqXmUX/jyAi//Lbf8QYVPSncrMfmvfr0TYcR05nCQ
         ZuAT4hxnl9E0MOJifi0un4umjQSRGmZiWaMG+PMh6j8DGneCHhAHTAMyK1JkY2iilF64
         gl33LcoTou/cjHcEE3cVMLFFIpShFDcrksybvhcfaBnmaqTKsMBrOPTuheh4F0gC9/ij
         T92DsCHfSyoxucpt5cvM+x036xhc0D8Xo6gk6Ar9Q7kliyIJOeZHxnR3U69SZ39QGKal
         C/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GarDjJQ3mtjv8KcH5SwUk3YHDKyEAs77Lu7oHMWgJkc=;
        b=ZldszAkYegCR3OLnxRjXpuLZv5HJRhQ+Jysfrg2PhQMwKU0WSBit6wbVV6NFDip7p3
         UrEH5mcA/p6yp2/r2PZ/oe3hKtk3BdZyzy8L29xx+cnqKYiPIItqF3BJtKnONWD2U3Gp
         ONa+lnRBfbxs51lA3lv6kxK3ZLY+zCRElQ89H/YDyRMqARi7GvZONW0TPiqTzX1VEFgJ
         Fws/UlmWwojZBwaRNWApAp7BcGjNUCaJ+GIwyXWgVfPAF/ob1MFZdJnHWytC2A9tROEy
         E/qJ8OWLeQPCDXYciy/wKYtQ7jQwMqsoDJCrmEQgcZ8kMcgL/Jo1iyeuU6G52KL5kSe5
         V3SQ==
X-Gm-Message-State: AG10YOTPCuVJ6SGdGM9F/nD88yxF2SOpGKuFs5ej/qywMfL4tbQUHgHu8YbencJyVN+K2Q==
X-Received: by 10.28.127.5 with SMTP id a5mr18284344wmd.32.1455194364099;
        Thu, 11 Feb 2016 04:39:24 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:23 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285969>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 cache.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 553b04b..fb29154 100644
--- a/cache.h
+++ b/cache.h
@@ -763,24 +763,24 @@ extern int check_repository_format(void);
  * using the safer "dup" or "strbuf" formats below (in some cases, the
  * unsafe versions have already been removed).
  */
-extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *mkpath(const char *fmt, ...) FORMATPRINTF(1,2);
+extern const char *git_path(const char *fmt, ...) FORMATPRINTF(1,2);
 
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
+	FORMATPRINTF(3,4);
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+	FORMATPRINTF(2,3);
 extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+	FORMATPRINTF(2,3);
 extern void strbuf_git_path_submodule(struct strbuf *sb, const char *path,
 				      const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
+	FORMATPRINTF(3,4);
 extern char *git_pathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
+	FORMATPRINTF(1,2);
 extern char *mkpathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
+	FORMATPRINTF(1,2);
 extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+	FORMATPRINTF(2,3);
 
 extern void report_linked_checkout_garbage(void);
 
@@ -1630,7 +1630,7 @@ struct key_value_info {
 	int linenr;
 };
 
-extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+extern NORETURN void git_die_config(const char *key, const char *err, ...) FORMATPRINTF(2,3);
 extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 extern int committer_ident_sufficiently_given(void);
@@ -1643,7 +1643,7 @@ extern const char *git_mailmap_blob;
 
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void fprintf_or_die(FILE *, const char *fmt, ...);
 
 #define COPY_READ_ERROR (-2)
-- 
2.5.0
