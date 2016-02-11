From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 19/22] trace.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:56 +0000
Message-ID: <1455194339-859-20-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXC-000869-8o
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbcBKMjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33776 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbcBKMjd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so10464470wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/+YOjoSq8SU8VBYUMclMbKRarnDi25peWr6gV0bKZk=;
        b=Aml/cLcKkDzVNbSrr6xlNhGYDNITX5fZmLqY32Hrtz5SyiSjVtbexvZGQFDkFhIoa0
         7NW9ClTdbNbfN56pMExynaZpSOav7u7dSQlOKWR28JJ1xqixq2KQQRelv1U9zyF3YjNc
         szN8rdszQ7kQY6+imrvZtRygQcSE+YKSvdyMr8Z/Z+i1WuBDhMDlFV1g46aNmryh5sXK
         tSZj//pm0RfpoJI8ogORHTNMcAr/e+B3md6DYG6ZHPYsIwE7QAS/2dZzIZ/Llq02qcxM
         6+FOgy3vIUd/3zNE4nF6hC70QKqi/JiOhFnvqFEpETTlZQJvcJ62MQd7LEbzD2vu7Z4Z
         TlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/+YOjoSq8SU8VBYUMclMbKRarnDi25peWr6gV0bKZk=;
        b=GJGVLgWypsFZzPjvUDgor1JoyfKChiNgQy3JEH/OOL8uqNSjdo91j+qUvaIUN6WvtY
         crCnOUtXu2AG6s9utypZHHWHcA+ykc/q3rFD6OW/V6cAyZuhdNwWtseOLArY1SIA5W/7
         FIn/bWyx69lX/2Fmpzc0KK6FcBn3uUFy9PxNLd/hwIYf53f0sk9udRDaiIfYu/QGZ6Rp
         gZtKCk2xW6sCgDMKRGDanjk2pG2IZ5oTH+e3BMVb8lEoBUyWLkQgLNCwIv4qKagxLS7m
         pMeldRS6VD7+xR+UqYelsuUZQFOGL8CcsMvaneoCPTyrGQT1ZhExfgr9eyqjQUPb45kq
         If4A==
X-Gm-Message-State: AG10YOQlPHNEppFdt1wgmW5QfE+REw92p9jrgvCPrD/U0wqn3PhjAHLNi0uroqs04083rg==
X-Received: by 10.28.179.130 with SMTP id c124mr18012802wmf.76.1455194372521;
        Thu, 11 Feb 2016 04:39:32 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:32 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285964>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 trace.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/trace.h b/trace.h
index 179b249..14df130 100644
--- a/trace.h
+++ b/trace.h
@@ -22,23 +22,23 @@ extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
 
 #ifndef HAVE_VARIADIC_MACROS
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 extern void trace_printf(const char *format, ...);
 
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void trace_printf_key(struct trace_key *key, const char *format, ...);
 
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void trace_performance(uint64_t nanos, const char *format, ...);
 
 /* Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled. */
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 extern void trace_performance_since(uint64_t start, const char *format, ...);
 
 #else
@@ -97,15 +97,15 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 			     __VA_ARGS__)
 
 /* backend functions, use non-*fl macros instead */
-__attribute__((format (printf, 4, 5)))
+FORMATPRINTF(4,5)
 extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 				const char *format, ...);
-__attribute__((format (printf, 4, 5)))
+FORMATPRINTF(4,5)
 extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
-__attribute__((format (printf, 4, 5)))
+FORMATPRINTF(4,5)
 extern void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
 
-- 
2.5.0
