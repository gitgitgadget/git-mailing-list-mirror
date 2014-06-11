From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 01/11] trace: move trace declarations from
 cache.h to new trace.h
Date: Wed, 11 Jun 2014 09:56:49 +0200
Message-ID: <53980BC1.3000109@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBQUX4COAKGQE5VZ3ZCQ@googlegroups.com Wed Jun 11 09:56:52 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBQUX4COAKGQE5VZ3ZCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBQUX4COAKGQE5VZ3ZCQ@googlegroups.com>)
	id 1WudOt-0004i4-Cv
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:56:51 +0200
Received: by mail-wi0-f192.google.com with SMTP id n3sf48188wiv.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=yHUziIrz63R+pfN2UnUmADleyjB0Btowi4qfXlKdFPA=;
        b=MLBpyQiQ77lzgHSDFTiVbP5I3MTDoewoVlNeQbN9eg6er5/fq4+ae07G6vbrPlrrr5
         /rkVZvh0KL91TbcDs4zh9LHoDFmOi1P+TbHntTAMu6j7uJvwid6Xg+YmU/7wF/GN0RlX
         SR/hVuTt1yhKx+bDbDLg7oeXOeqD+Eea1xbqfiGhSrcEH5zLH1OH0eAOA07hoAp5NkDf
         VKfFTCWi7rFjC7/s5UFSERp+yAEEQUFogx2i9t7MpDRWNeO0f+VKYLM0lx9DlreTutWF
         Z6NKeVrR1v11XygO40MZEEmg9XFhpxpmTF8u3ZAsWdnOKDfNJH3FquxQ5X3kZSI4W6pA
         2h7g==
X-Received: by 10.180.75.178 with SMTP id d18mr128492wiw.13.1402473411137;
        Wed, 11 Jun 2014 00:56:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.36.134 with SMTP id q6ls228631wij.48.canary; Wed, 11 Jun
 2014 00:56:50 -0700 (PDT)
X-Received: by 10.180.88.169 with SMTP id bh9mr4313907wib.5.1402473410002;
        Wed, 11 Jun 2014 00:56:50 -0700 (PDT)
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com [2a00:1450:400c:c00::22b])
        by gmr-mx.google.com with ESMTPS id pk3si851122wic.0.2014.06.11.00.56.49
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:56:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b as permitted sender) client-ip=2a00:1450:400c:c00::22b;
Received: by mail-wg0-f43.google.com with SMTP id b13so3732779wgh.2
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:56:49 -0700 (PDT)
X-Received: by 10.180.12.135 with SMTP id y7mr47597900wib.39.1402473409931;
        Wed, 11 Jun 2014 00:56:49 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ci54sm57931849eeb.19.2014.06.11.00.56.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:56:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251330>

Also include direct dependencies (strbuf.h and git-compat-util.h for
__attribute__) so that trace.h can be used independently of cache.h, e.g.
in test programs.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h | 13 ++-----------
 trace.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 11 deletions(-)
 create mode 100644 trace.h

diff --git a/cache.h b/cache.h
index 1e4b4f0..79ac940 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "trace.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
@@ -1378,17 +1379,7 @@ extern void *alloc_tag_node(void);
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
