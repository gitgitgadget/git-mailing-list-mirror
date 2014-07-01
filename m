From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 01/16] trace: move trace declarations from
 cache.h to new trace.h
Date: Wed, 02 Jul 2014 00:55:15 +0200
Message-ID: <53B33C53.5040403@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBU7YZSOQKGQEUFNXX3Y@googlegroups.com Wed Jul 02 00:55:17 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBU7YZSOQKGQEUFNXX3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBU7YZSOQKGQEUFNXX3Y@googlegroups.com>)
	id 1X26xI-0000Qi-Ee
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:55:16 +0200
Received: by mail-lb0-f184.google.com with SMTP id u10sf1109058lbd.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=D5FWjNEaA5mvBCQ/qDnocuY3tBL2pfuXgOqDrZOIjso=;
        b=rrCRlHitYGoFQIT/caDq1wvaZfGL/xC5TVhAWMP8HGRy65kxFLpAAjpzER6OxbSiPE
         BeDiCGiGUI9GHuK0h9H9+ZbS7vqsdpN9TeDe1Ylnhfylt9Dbrnh9CFE+C5F5CmwvKKvW
         Wz3d+yfJF4NNLeGoX0RI7DXUr72tXGyJidmPlDLB0Wv9It82qgSMJpbDX1V6e9oeS4hV
         fq0QPAhXgk4a7JiIWhAWbmQBB0kwI+7V3qQyG8sc0Nmae77agq9w116oo5zXss9LT75t
         mjNgnE4zA9AXZlK2e4zZ6mwnYhG2CERRIGXquaeLTB/ICoA9wVU/L1778ULLCC9zu2w6
         AbCg==
X-Received: by 10.152.6.99 with SMTP id z3mr1665laz.36.1404255316234;
        Tue, 01 Jul 2014 15:55:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.201 with SMTP id n9ls426371lag.2.gmail; Tue, 01 Jul
 2014 15:55:15 -0700 (PDT)
X-Received: by 10.112.40.1 with SMTP id t1mr672973lbk.19.1404255315114;
        Tue, 01 Jul 2014 15:55:15 -0700 (PDT)
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com [2a00:1450:400c:c03::234])
        by gmr-mx.google.com with ESMTPS id x7si811450wiw.1.2014.07.01.15.55.15
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:55:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234 as permitted sender) client-ip=2a00:1450:400c:c03::234;
Received: by mail-we0-f180.google.com with SMTP id x48so10320423wes.39
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:55:15 -0700 (PDT)
X-Received: by 10.194.92.115 with SMTP id cl19mr55822741wjb.29.1404255314994;
        Tue, 01 Jul 2014 15:55:14 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 20sm49170786wjt.42.2014.07.01.15.55.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:55:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252749>

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
2.0.0.406.ge74f8ff

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
