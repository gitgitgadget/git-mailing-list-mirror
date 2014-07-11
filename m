From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 02/17] trace: consistently name the format parameter
Date: Sat, 12 Jul 2014 01:58:33 +0200
Message-ID: <53C07A29.8000506@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBJXUQGPAKGQENY3YA2A@googlegroups.com Sat Jul 12 01:58:32 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBJXUQGPAKGQENY3YA2A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJXUQGPAKGQENY3YA2A@googlegroups.com>)
	id 1X5khz-0007cw-VQ
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 01:58:32 +0200
Received: by mail-wg0-f61.google.com with SMTP id x12sf188413wgg.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=5vWwNxoG4OrCIdwP8cvbdUsYYGA/Vw7ssD6YUK5kgHM=;
        b=KVapXMTiG8L+a0ld1S3tRkHUhPfFlw2QOxPvq+EEwfmHzIYpJvrwEx3au2YmyJZpxZ
         zHYSOFJv0DQuWRmqcVzXHDkhswbtB3AjW1ddeFgXJKLB/qAOEkm9me0WTUkHBJYrSfZM
         AMezd1w3Ut46R7kOx+04EHgko21YtPjJ79zrbnrImtnsvQHfj5IgtGrdjNLbrIEdTgFJ
         iG8uoYdtF5o5xdRyNEh3bPq0mYdBNY2+dF1uoqrPqNvfBcq3m/PBjVZfKIKe+5m/h8d3
         PMzFdhthzqhPI230Sh3pPzUJAQQBb61lv4fdo6rALRMhLpb5gXoPBjCh7s/bed5L2xCg
         gyjA==
X-Received: by 10.152.179.227 with SMTP id dj3mr20204lac.0.1405123111456;
        Fri, 11 Jul 2014 16:58:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.204.101 with SMTP id kx5ls123584lac.56.gmail; Fri, 11 Jul
 2014 16:58:29 -0700 (PDT)
X-Received: by 10.152.26.41 with SMTP id i9mr140910lag.8.1405123109499;
        Fri, 11 Jul 2014 16:58:29 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id d9si3955wie.3.2014.07.11.16.58.29
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:58:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-f174.google.com with SMTP id d1so16290wiv.13
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 16:58:29 -0700 (PDT)
X-Received: by 10.194.90.201 with SMTP id by9mr2853302wjb.94.1405123109406;
        Fri, 11 Jul 2014 16:58:29 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj8sm8208473wjb.5.2014.07.11.16.58.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:58:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253357>

The format parameter to trace_printf functions is sometimes abbreviated
'fmt'. Rename to 'format' everywhere (consistent with POSIX' printf
specification).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 22 +++++++++++-----------
 trace.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/trace.c b/trace.c
index 08180a9..37a7fa9 100644
--- a/trace.c
+++ b/trace.c
@@ -62,7 +62,7 @@ static int get_trace_fd(const char *key, int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-static void trace_vprintf(const char *key, const char *fmt, va_list ap)
+static void trace_vprintf(const char *key, const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -70,25 +70,25 @@ static void trace_vprintf(const char *key, const char *fmt, va_list ap)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	strbuf_vaddf(&buf, fmt, ap);
+	strbuf_vaddf(&buf, format, ap);
 	trace_strbuf(key, &buf);
 	strbuf_release(&buf);
 }
 
 __attribute__((format (printf, 2, 3)))
-void trace_printf_key(const char *key, const char *fmt, ...)
+void trace_printf_key(const char *key, const char *format, ...)
 {
 	va_list ap;
-	va_start(ap, fmt);
-	trace_vprintf(key, fmt, ap);
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
 	va_end(ap);
 }
 
-void trace_printf(const char *fmt, ...)
+void trace_printf(const char *format, ...)
 {
 	va_list ap;
-	va_start(ap, fmt);
-	trace_vprintf("GIT_TRACE", fmt, ap);
+	va_start(ap, format);
+	trace_vprintf("GIT_TRACE", format, ap);
 	va_end(ap);
 }
 
@@ -106,7 +106,7 @@ void trace_strbuf(const char *key, const struct strbuf *buf)
 		close(fd);
 }
 
-void trace_argv_printf(const char **argv, const char *fmt, ...)
+void trace_argv_printf(const char **argv, const char *format, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
@@ -117,8 +117,8 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	va_start(ap, fmt);
-	strbuf_vaddf(&buf, fmt, ap);
+	va_start(ap, format);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
diff --git a/trace.h b/trace.h
index 6cc4541..8fea50b 100644
--- a/trace.h
+++ b/trace.h
@@ -11,7 +11,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 __attribute__((format (printf, 2, 3)))
-extern void trace_printf_key(const char *key, const char *fmt, ...);
+extern void trace_printf_key(const char *key, const char *format, ...);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
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
