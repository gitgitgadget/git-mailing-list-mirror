From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 18/22] strbuf.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:55 +0000
Message-ID: <1455194339-859-19-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXA-000869-BU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbcBKMje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36230 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbcBKMjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id 128so10426853wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKEzSzs0DDrqoWGBWIPtdRHuLN7IGYYneeaq3kJPDzM=;
        b=uDEp/v6afUp1eMIrVF1ygh2g18tAiUj000g0XOuiPv62SFxk+NoDp0utMtZ1SMcqbO
         C396xCQW6sgHI10xVJxs2Tph+ejY6u/JzdC3VSgGMA4YhWzqL5hneBIUjlW2d7+a86rl
         zxKrBK+weUb7WaSntCibDM2k2xFYSkP0WN+0v66AOdE0y7zoX7SbswFx82/vWEkanjE2
         JoCo9ntw8cd4eQiH+3m6z0JGb0ppL3Sp3aZnqExOZF7a9jvZPjDsjVF2kMA83dHMaXZQ
         T5BLm6ylW91ZZV6tE9ToHPO6BSQcvzTgEa0h52Z2xltJKrdqICj7KUorijt5TvOfXz0X
         nBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NKEzSzs0DDrqoWGBWIPtdRHuLN7IGYYneeaq3kJPDzM=;
        b=TNoKVLc0aeSckko5LJaIsvwk2eUQ9PYa8EuwwyDjEo1vJeY+YJPJrBvAM17uxIHJob
         UEnjp+hVe0gcTa45hrvc1fmaEWifjn4A77vDv2Z5SEdgw1CsGToN4FdM8Zk1JXFp+jy3
         Bzt7xoY6Ct1yjdaTCsh2DpdY5Rntud6bkVyCctKP/hhNK9i6QSSFC1OSrG69+q7fkeJo
         /8gquXcQn4VHAZdIfJgM/wqa1RTIWkkppuaUMt/ALSMZQT4Wykqt+EDWZ8MV2HrMHVGX
         8BNgbfHvm//QfjCDwWQ8zLsAb+w2WkD0mqvzEUBRZfjofJDQ1R4MbiHycaoVB2piptWv
         2yPw==
X-Gm-Message-State: AG10YOQ+bCq/BCHW9ElBo0bQHraclBYkC2sCByvQ+qS50D2KlVQJJxpQQC+3fh8AvwZEyQ==
X-Received: by 10.194.60.145 with SMTP id h17mr36806072wjr.47.1455194371838;
        Thu, 11 Feb 2016 04:39:31 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:31 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285963>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 strbuf.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index f72fd14..c887dab 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -331,17 +331,17 @@ extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
 /**
  * Add a formatted string to the buffer.
  */
-__attribute__((format (printf,2,3)))
+FORMATPRINTF(2,3)
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 
 /**
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 
-__attribute__((format (printf,2,0)))
+FORMATPRINTF(2,0)
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
@@ -556,9 +556,9 @@ extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
 
-__attribute__((format (printf,1,2)))
+FORMATPRINTF(1,2)
 extern int printf_ln(const char *fmt, ...);
-__attribute__((format (printf,2,3)))
+FORMATPRINTF(2,3)
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
@@ -567,9 +567,9 @@ char *xstrdup_tolower(const char *);
  * Create a newly allocated string using printf format. You can do this easily
  * with a strbuf, but this provides a shortcut to save a few lines.
  */
-__attribute__((format (printf, 1, 0)))
+FORMATPRINTF(1,0)
 char *xstrvfmt(const char *fmt, va_list ap);
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 char *xstrfmt(const char *fmt, ...);
 
 #endif /* STRBUF_H */
-- 
2.5.0
