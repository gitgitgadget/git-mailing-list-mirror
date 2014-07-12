From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 11/17] trace: add 'file:line' to all trace output
Date: Sat, 12 Jul 2014 02:05:03 +0200
Message-ID: <53C07BAF.6040807@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBK7XQGPAKGQEM3GEH6Q@googlegroups.com Sat Jul 12 02:05:01 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBK7XQGPAKGQEM3GEH6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBK7XQGPAKGQEM3GEH6Q@googlegroups.com>)
	id 1X5koH-0005Pm-5J
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:05:01 +0200
Received: by mail-lb0-f192.google.com with SMTP id w7sf187024lbi.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=cy8NAggYE8QEi1K/fF3fLs3vsRb8ateRHOVBwE0vWo4=;
        b=oBOJtH+glNjNO/S1kMJ84AwDl08izCo2DKtl4U15AOXbZm/mmYsSVAHoC38B/sau55
         Voml1o86HQ1N837lyM0OKnzVZBKjNwvWmV8bgtebsB2eIljxMwzFEpbOs1lOv6rc61t5
         CUlhEYPvA0RHCoF8qq5gU35spplzglSkhmfjG3p3YEEjDnsw7eono2eX0EPtSnifSjcc
         XiecbfEC0zr9xOAP4EUsGF1a9KbBOWqVogt3hj0eoAseq+pgm5CKY/APRh+cKRIEzsrq
         QjRRqJN1/VZcvDFg8GP8DOIFxZt0/+LybT/nLW/gwFJ2gfZbfymfHZGx0ehdhEjWldi6
         Higw==
X-Received: by 10.180.75.143 with SMTP id c15mr30621wiw.13.1405123500121;
        Fri, 11 Jul 2014 17:05:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.169 with SMTP id gn9ls158499wib.10.gmail; Fri, 11 Jul
 2014 17:04:59 -0700 (PDT)
X-Received: by 10.180.39.196 with SMTP id r4mr810597wik.4.1405123499496;
        Fri, 11 Jul 2014 17:04:59 -0700 (PDT)
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id x7si7385wiw.1.2014.07.11.17.04.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:04:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233 as permitted sender) client-ip=2a00:1450:400c:c05::233;
Received: by mail-wi0-f179.google.com with SMTP id cc10so22824wib.6
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:04:59 -0700 (PDT)
X-Received: by 10.180.13.139 with SMTP id h11mr9156749wic.40.1405123499412;
        Fri, 11 Jul 2014 17:04:59 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hq20sm387603wib.0.2014.07.11.17.04.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:04:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253366>

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

Print 'file:line ' as prefix to each trace line. Align the remaining trace
output at column 40 to accommodate 18 char file names + 4 digit line
number (currently there are 30 *.c files of length 18 and just 11 of 19).
Trace output from longer source files (e.g. builtin/receive-pack.c) will
not be aligned.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 git-compat-util.h |  4 ++++
 trace.c           | 72 +++++++++++++++++++++++++++++++++++++++++++++----------
 trace.h           | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 12 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..4dd065d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -704,6 +704,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
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
index e8ce619..f013958 100644
--- a/trace.c
+++ b/trace.c
@@ -85,7 +85,8 @@ void trace_disable(struct trace_key *key)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
+static int prepare_trace_line(const char *file, int line,
+			      struct trace_key *key, struct strbuf *buf)
 {
 	static struct trace_key trace_bare = TRACE_KEY_INIT(BARE);
 	struct timeval tv;
@@ -108,6 +109,14 @@ static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
 	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
 		    tm.tm_sec, (long) tv.tv_usec);
 
+#ifdef HAVE_VARIADIC_MACROS
+	/* print file:line */
+	strbuf_addf(buf, "%s:%d ", file, line);
+	/* align trace output (column 40 catches most files names in git) */
+	while (buf->len < 40)
+		strbuf_addch(buf, ' ');
+#endif
+
 	return 1;
 }
 
@@ -121,49 +130,52 @@ static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 	strbuf_release(buf);
 }
 
-static void trace_vprintf(struct trace_key *key, const char *format, va_list ap)
+static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
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
 
-	if (!prepare_trace_line(NULL, &buf))
+	if (!prepare_trace_line(file, line, NULL, &buf))
 		return;
 
-	va_start(ap, format);
 	strbuf_vaddf(&buf, format, ap);
-	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
 	print_trace_line(NULL, &buf);
 }
 
-void trace_strbuf(struct trace_key *key, const struct strbuf *data)
+void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
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
-	trace_vprintf(NULL, format, ap);
+	trace_vprintf_fl(NULL, 0, NULL, format, ap);
 	va_end(ap);
 }
 
@@ -171,10 +183,46 @@ void trace_printf_key(struct trace_key *key, const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_vprintf(key, format, ap);
+	trace_vprintf_fl(NULL, 0, key, format, ap);
+	va_end(ap);
+}
+
+void trace_argv_printf(const char **argv, const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
 	va_end(ap);
 }
 
+void trace_strbuf(const char *key, const struct strbuf *data)
+{
+	trace_strbuf_fl(NULL, 0, key, data);
+}
+
+#else
+
+void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
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
index b4800e7..7a5ba2e 100644
--- a/trace.h
+++ b/trace.h
@@ -17,6 +17,8 @@ extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 
+#ifndef HAVE_VARIADIC_MACROS
+
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 
@@ -28,4 +30,64 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
+#else
+
+/*
+ * Macros to add file:line - see above for C-style declarations of how these
+ * should be used.
+ */
+
+/*
+ * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
+ * default is __FILE__, as it is consistent with assert(), and static function
+ * names are not necessarily unique.
+ *
+ * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is supplied
+ * by the preprocessor as a string literal, and __FUNCTION__ is filled in by
+ * the compiler as a string constant.
+ */
+#ifndef TRACE_CONTEXT
+# define TRACE_CONTEXT __FILE__
+#endif
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
+	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
+
+#define trace_printf_key(key, ...) \
+	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
+
+#define trace_argv_printf(argv, ...) \
+	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)
+
+#define trace_strbuf(key, data) \
+	trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data)
+
+/* backend functions, use non-*fl macros instead */
+__attribute__((format (printf, 4, 5)))
+extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
+				const char *format, ...);
+__attribute__((format (printf, 4, 5)))
+extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
+				 const char *format, ...);
+extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
+			    const struct strbuf *data);
+
+#endif /* HAVE_VARIADIC_MACROS */
+
 #endif /* TRACE_H */
-- 
2.0.0.406.g2e9ef9b

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
