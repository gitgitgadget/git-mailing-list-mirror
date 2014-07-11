From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 01/17] trace: move trace declarations from
 cache.h to new trace.h
Date: Sat, 12 Jul 2014 01:57:52 +0200
Message-ID: <53C07A00.6010708@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB7PTQGPAKGQEDKJCOXY@googlegroups.com Sat Jul 12 01:57:50 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB7PTQGPAKGQEDKJCOXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB7PTQGPAKGQEDKJCOXY@googlegroups.com>)
	id 1X5khK-0006x2-MY
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 01:57:50 +0200
Received: by mail-we0-f183.google.com with SMTP id w62sf147553wes.20
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=GwmsXDE/x2TZIGf6vEj1qciXvwBKddT82l3DzIX26h0=;
        b=LYKQijcApBqNb4ddaQOjtBT2t+SniLNSWLhpi3zMMXy5uWIIuktdqTxhRl6RcLPmMF
         EMZ5USKAXBnTzSZz6MZsJqUc0dkGMcURlX5O8mv3dqMIUm0ZswfKl/7Qh0aZFu7kDk/D
         VC18iFElfTbR+ZdL9DWXzAT91jy1MCsjXMieZmDtMw87ySA3boaY76RhCK6BQeryf5Gz
         VSlcIzeUfN/XQm2v+rmxjc7r2XLEP48kkRCASWJFMTkbsSE0vXuVnIWtuBeA3S34wsFN
         iNVTPsP5Lvr2yQwvfSJhrQdIAdliuaUODH0notR1UW9IIshTexLPuYhEy7zaVnVVILK/
         h0gw==
X-Received: by 10.180.184.99 with SMTP id et3mr30657wic.4.1405123069687;
        Fri, 11 Jul 2014 16:57:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.11.196 with SMTP id s4ls159967wib.45.canary; Fri, 11 Jul
 2014 16:57:48 -0700 (PDT)
X-Received: by 10.180.85.39 with SMTP id e7mr817891wiz.0.1405123068953;
        Fri, 11 Jul 2014 16:57:48 -0700 (PDT)
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com [2a00:1450:400c:c03::22a])
        by gmr-mx.google.com with ESMTPS id m9si9459wiw.0.2014.07.11.16.57.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:57:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a as permitted sender) client-ip=2a00:1450:400c:c03::22a;
Received: by mail-we0-f170.google.com with SMTP id w62so1480654wes.29
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 16:57:48 -0700 (PDT)
X-Received: by 10.195.13.102 with SMTP id ex6mr2780566wjd.48.1405123068886;
        Fri, 11 Jul 2014 16:57:48 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fw4sm271716wib.19.2014.07.11.16.57.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:57:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253356>

Also include direct dependencies (strbuf.h and git-compat-util.h for
__attribute__) so that trace.h can be used independently of cache.h, e.g.
in test programs.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h | 13 ++-----------
 trace.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 11 deletions(-)
 create mode 100644 trace.h

diff --git a/cache.h b/cache.h
index cbe1935..466f6b3 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "trace.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1377,17 +1378,7 @@ extern void *alloc_tag_node(void);
 extern void *alloc_object_node(void);
 extern void alloc_report(void);
 
-/* trace.c */
-__attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
-__attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
-extern void trace_repo_setup(const char *prefix);
-extern int trace_want(const char *key);
-__attribute__((format (printf, 2, 3)))
-extern void trace_printf_key(const char *key, const char *fmt, ...);
-extern void trace_strbuf(const char *key, const struct strbuf *buf);
-
+/* pkt-line.c */
 void packet_trace_identity(const char *prog);
 
 /* add */
diff --git a/trace.h b/trace.h
new file mode 100644
index 0000000..6cc4541
--- /dev/null
+++ b/trace.h
@@ -0,0 +1,17 @@
+#ifndef TRACE_H
+#define TRACE_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+__attribute__((format (printf, 1, 2)))
+extern void trace_printf(const char *format, ...);
+__attribute__((format (printf, 2, 3)))
+extern void trace_argv_printf(const char **argv, const char *format, ...);
+extern void trace_repo_setup(const char *prefix);
+extern int trace_want(const char *key);
+__attribute__((format (printf, 2, 3)))
+extern void trace_printf_key(const char *key, const char *fmt, ...);
+extern void trace_strbuf(const char *key, const struct strbuf *buf);
+
+#endif /* TRACE_H */
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
