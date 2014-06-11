From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 08/11] trace: add 'file:line' to all trace output
Date: Wed, 11 Jun 2014 10:00:36 +0200
Message-ID: <53980CA4.9050101@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBJMZ4COAKGQEUFIEQSQ@googlegroups.com Wed Jun 11 10:00:38 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBJMZ4COAKGQEUFIEQSQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJMZ4COAKGQEUFIEQSQ@googlegroups.com>)
	id 1WudSY-0008EZ-IA
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 10:00:38 +0200
Received: by mail-lb0-f184.google.com with SMTP id n15sf928351lbi.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=KEyIfrYJ0i4TtFMCjLcs9Sjp2kTtQpE8kT76kRxtYsU=;
        b=Xy2SHKV5bHaA7OsClRKGh6oOs0MtAmJC6LYke7uSaV/jywi9hCUMK59a3lEI5qlBZa
         PmngrjIdeSHEY7b4D0seQoJRR9W2GmZL7oR585GHUM3pljzWXouAsPFqIkY7UfuexHJ4
         DEU3U/7Abyxo8x4xrFQrPvrYIL/Ro2/kiAE5pOtM2+z3WIQ/0JeRChsAoq3aWjWMIZ7X
         vkrnr12We9fPbY4ihFQLWerZK6+R8+5psNPel9KU0Dbe+8GdobxLLvJ5ND6DwLpWRu7y
         Sck+eMdZ61GNl5xR6IzszbqwvmRR6u8RRSIgi0qAYNfh5+cRMopBWYKhL/ckKiy3FTvB
         kDXQ==
X-Received: by 10.152.23.165 with SMTP id n5mr141153laf.5.1402473638400;
        Wed, 11 Jun 2014 01:00:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.22.131 with SMTP id d3ls398392laf.95.gmail; Wed, 11 Jun
 2014 01:00:37 -0700 (PDT)
X-Received: by 10.152.8.194 with SMTP id t2mr48384laa.7.1402473637280;
        Wed, 11 Jun 2014 01:00:37 -0700 (PDT)
Received: from mail-we0-x232.google.com (mail-we0-x232.google.com [2a00:1450:400c:c03::232])
        by gmr-mx.google.com with ESMTPS id x7si1266773wiw.1.2014.06.11.01.00.37
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:00:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::232 as permitted sender) client-ip=2a00:1450:400c:c03::232;
Received: by mail-we0-f178.google.com with SMTP id p10so6618560wes.9
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 01:00:37 -0700 (PDT)
X-Received: by 10.194.190.42 with SMTP id gn10mr49391980wjc.9.1402473637107;
        Wed, 11 Jun 2014 01:00:37 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj41sm57955153eeb.34.2014.06.11.01.00.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:00:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251337>

This is useful to see where trace output came from.

Add 'const char *file, int line' parameters to the printing functions and
rename them to *_fl.

Add trace_printf* and trace_strbuf macros resolving to the *_fl functions
and let the preprocessor fill in __FILE__ and __LINE__.

As the trace_printf* functions take a variable number of arguments, this
requires variadic macros (i.e. '#define foo(...) foo_impl(__VA_ARGS__)'.
Though part of C99, it is unclear whether older compilers support this.
Thus keep the old functions and only enable variadic macros for GNUC and
MSVC 2005+ (_MSC_VER 1400). This has the nice side effect that the old
C-style declarations serve as documentation how the macros are to be used.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 git-compat-util.h |  4 ++++
 trace.c           | 69 +++++++++++++++++++++++++++++++++++++++++++++----------
 trace.h           | 49 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7849d31..e5a773b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -700,6 +700,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
+#if defined(__GNUC__) || (_MSC_VER >= 1400)
+#define HAVE_VARIADIC_MACROS 1
+#endif
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Always returns the return value of unlink(2).
diff --git a/trace.c b/trace.c
index c86d33c..231e24a 100644
--- a/trace.c
+++ b/trace.c
@@ -77,7 +77,8 @@ static void do_trace_print(const char *key, const struct strbuf *buf)
 		close(fd);
 }
 
-static int prepare_trace_line(const char *key, struct strbuf *buf)
+static int prepare_trace_line(const char *file, int line, const char *key,
+			      struct strbuf *buf)
 {
 	struct timeval tv;
 	struct tm tm;
@@ -95,6 +96,11 @@ static int prepare_trace_line(const char *key, struct strbuf *buf)
 	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
 		    tm.tm_sec, tv.tv_usec);
 
+#ifdef HAVE_VARIADIC_MACROS
+	/* print file:line */
+	strbuf_addf(buf, "%s:%d ", file, line);
+#endif
+
 	return 1;
 }
 
@@ -108,49 +114,52 @@ static void print_trace_line(const char *key, struct strbuf *buf)
 	strbuf_release(buf);
 }
 
-static void trace_vprintf(const char *key, const char *format, va_list ap)
+static void trace_vprintf_fl(const char *file, int line, const char *key,
+			     const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!prepare_trace_line(key, &buf))
+	if (!prepare_trace_line(file, line, key, &buf))
 		return;
 
 	strbuf_vaddf(&buf, format, ap);
 	print_trace_line(key, &buf);
 }
 
-void trace_argv_printf(const char **argv, const char *format, ...)
+static void trace_argv_vprintf_fl(const char *file, int line,
+				  const char **argv, const char *format,
+				  va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list ap;
 
-	if (!prepare_trace_line("GIT_TRACE", &buf))
+	if (!prepare_trace_line(file, line, "GIT_TRACE", &buf))
 		return;
 
-	va_start(ap, format);
 	strbuf_vaddf(&buf, format, ap);
-	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
 	print_trace_line("GIT_TRACE", &buf);
 }
 
-void trace_strbuf(const char *key, const struct strbuf *data)
+void trace_strbuf_fl(const char *file, int line, const char *key,
+		     const struct strbuf *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!prepare_trace_line(key, &buf))
+	if (!prepare_trace_line(file, line, key, &buf))
 		return;
 
 	strbuf_addbuf(&buf, data);
 	print_trace_line(key, &buf);
 }
 
+#ifndef HAVE_VARIADIC_MACROS
+
 void trace_printf(const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf("GIT_TRACE", format, ap);
+	trace_vprintf_fl(NULL, 0, "GIT_TRACE", format, ap);
 	va_end(ap);
 }
 
@@ -158,10 +167,46 @@ void trace_printf_key(const char *key, const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf(key, format, ap);
+	trace_vprintf_fl(NULL, 0, key, format, ap);
 	va_end(ap);
 }
 
+void trace_argv_printf(const char **argv, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
+	va_end(ap);
+}
+
+void trace_strbuf(const char *key, const struct strbuf *data)
+{
+	trace_strbuf_fl(NULL, 0, key, data);
+}
+
+#else
+
+void trace_printf_key_fl(const char *file, int line, const char *key,
+			 const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_vprintf_fl(file, line, key, format, ap);
+	va_end(ap);
+}
+
+void trace_argv_printf_fl(const char *file, int line, const char **argv,
+			  const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_argv_vprintf_fl(file, line, argv, format, ap);
+	va_end(ap);
+}
+
+#endif /* HAVE_VARIADIC_MACROS */
+
+
 static const char *quote_crnl(const char *path)
 {
 	static char new_path[PATH_MAX];
diff --git a/trace.h b/trace.h
index 5c7f2dc..916dc2b 100644
--- a/trace.h
+++ b/trace.h
@@ -7,6 +7,8 @@
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 
+#ifndef HAVE_VARIADIC_MACROS
+
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 
@@ -18,4 +20,51 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(const char *key, const struct strbuf *data);
 
+#else
+
+/*
+ * Macros to add file:line - see above for C-style declarations of how these
+ * should be used.
+ */
+
+/*
+ * Note: with C99 variadic macros, __VA_ARGS__ must include the last fixed
+ * parameter ('format' in this case). Otherwise, a call without variable
+ * arguments will have a surplus ','. E.g.:
+ *
+ *  #define foo(format, ...) bar(format, __VA_ARGS__)
+ *  foo("test");
+ *
+ * will expand to
+ *
+ *  bar("test",);
+ *
+ * which is invalid (note the ',)'). With GNUC, '##__VA_ARGS__' drops the
+ * comma, but this is non-standard.
+ */
+
+#define trace_printf(...) \
+	trace_printf_key_fl(__FILE__, __LINE__, "GIT_TRACE", __VA_ARGS__)
+
+#define trace_printf_key(key, ...) \
+	trace_printf_key_fl(__FILE__, __LINE__, key, __VA_ARGS__)
+
+#define trace_argv_printf(argv, ...) \
+	trace_argv_printf_fl(__FILE__, __LINE__, argv, __VA_ARGS__)
+
+#define trace_strbuf(key, data) \
+	trace_strbuf_fl(__FILE__, __LINE__, key, data)
+
+/* backend functions, use non-*fl macros instead */
+__attribute__((format (printf, 4, 5)))
+extern void trace_printf_key_fl(const char *file, int line, const char *key,
+				const char *format, ...);
+__attribute__((format (printf, 4, 5)))
+extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
+				 const char *format, ...);
+extern void trace_strbuf_fl(const char *file, int line, const char *key,
+			    const struct strbuf *data);
+
+#endif /* HAVE_VARIADIC_MACROS */
+
 #endif /* TRACE_H */
-- 
1.9.2.msysgit.0.501.gaeecf09

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
