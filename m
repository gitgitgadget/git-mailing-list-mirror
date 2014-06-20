From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 01/11] trace: move trace declarations from
 cache.h to new trace.h
Date: Fri, 20 Jun 2014 23:04:06 +0200
Message-ID: <53A4A1C6.3060307@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBRODSKOQKGQED5EAK3Y@googlegroups.com Fri Jun 20 23:04:06 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBRODSKOQKGQED5EAK3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBRODSKOQKGQED5EAK3Y@googlegroups.com>)
	id 1Wy5yg-0002zV-Eb
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:04:06 +0200
Received: by mail-we0-f192.google.com with SMTP id u57sf478284wes.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ENbjDGed0azfty0bDcPoAASoOejzDBHJAQhEU3BU7Dk=;
        b=yzx8neYFipKF31R2Qc6bdB3MoCXrGPp3kitwh5QEWDPwdnW1HwswImMHKdzNbrtLGf
         AbP3gRhuaTBgURwZxAj/ljHP3Dfef+QH47wuAGFbmlxN24io2LzWLxzQSi+ZBavJye2+
         3Ha3caTcUdAJ+iwsy1iZXZTcJG0LzPlzb6qEPpu+l5Ifg0RNE/c1KkF5a6Qjp2uzS4YC
         tI7BgmGk3V88QSQIWort9AKXZ75ngwv3EvVP3tqwV37kMsMcTp1fftE+/w4EJF34Jf9e
         nDPLseYj1E+Q0Yb7mo/KK3zKGrsrHtdQkXerS1ia3ApqULIAARz88Bb5ZRpKbNl6Zjhd
         DqyA==
X-Received: by 10.152.234.137 with SMTP id ue9mr22516lac.15.1403298246183;
        Fri, 20 Jun 2014 14:04:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.194 with SMTP id m2ls191360lam.104.gmail; Fri, 20 Jun
 2014 14:04:04 -0700 (PDT)
X-Received: by 10.112.50.203 with SMTP id e11mr1655lbo.23.1403298244833;
        Fri, 20 Jun 2014 14:04:04 -0700 (PDT)
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com [2a00:1450:400c:c00::22c])
        by gmr-mx.google.com with ESMTPS id x7si225503wiw.1.2014.06.20.14.04.04
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:04:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c as permitted sender) client-ip=2a00:1450:400c:c00::22c;
Received: by mail-wg0-f44.google.com with SMTP id x13so4238432wgg.27
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:04:04 -0700 (PDT)
X-Received: by 10.194.59.65 with SMTP id x1mr7187271wjq.60.1403298244749;
        Fri, 20 Jun 2014 14:04:04 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lk7sm16828859wjb.24.2014.06.20.14.04.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:04:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252280>

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
2.0.0.402.g13b8b25

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
