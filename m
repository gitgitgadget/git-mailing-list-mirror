From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 03/16] compat: add inet_pton and inet_ntop prototypes
Date: Fri, 22 Oct 2010 02:35:14 +0200
Message-ID: <1287707727-5780-4-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com,
	Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCFuYPmBBoExAmgkg@googlegroups.com Fri Oct 22 02:36:46 2010
Return-path: <msysgit+bncCOPdven-DxCFuYPmBBoExAmgkg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCFuYPmBBoExAmgkg@googlegroups.com>)
	id 1P95cj-0002Um-Cw
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:45 +0200
Received: by mail-ww0-f58.google.com with SMTP id 28sf120656wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=JsLYgsnoWOBRlX2ZTsnMQ/YqcCq02KuL3OEcPlL/lV0=;
        b=qSVJ3pR3RGXSHlNjBnKI4wSsM/Pr3Qxo0uE4DD1zpOn1sP2+7ehY/FahPGdCi5wmRO
         rrsEcULV90yF7GjPGPhYezsWdQgBz0xyS1FHGxkm0f+0ADf2Ng0+MmfKzO8G5WRU5at4
         m8pFfnbZNrIGK2PI5ooXjZiB9yeo01vCGen3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=M/RsjAAb4Ah6UD3SMGEPN1lCAq6U76pXZr+j51FGFwdD9ySQ21+4ZclOWR1DYSBOeg
         v/4KkkI59BlO8IiaPWFcNXj+V3bflT8z0CXsjigU+Kk54jMzjYgOlBD/Bxx8amr/JK37
         Ke5UckKOSjoGoooxAPERzeJ1vsNyKXQwfeT+w=
Received: by 10.216.173.84 with SMTP id u62mr237452wel.14.1287707781430;
        Thu, 21 Oct 2010 17:36:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.3.29 with SMTP id 29ls269324eeg.0.p; Thu, 21 Oct 2010
 17:36:20 -0700 (PDT)
Received: by 10.14.53.12 with SMTP id f12mr159744eec.0.1287707780688;
        Thu, 21 Oct 2010 17:36:20 -0700 (PDT)
Received: by 10.14.53.12 with SMTP id f12mr159743eec.0.1287707780653;
        Thu, 21 Oct 2010 17:36:20 -0700 (PDT)
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com [209.85.215.51])
        by gmr-mx.google.com with ESMTP id z6si1450807eeh.6.2010.10.21.17.36.19;
        Thu, 21 Oct 2010 17:36:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.51 as permitted sender) client-ip=209.85.215.51;
Received: by ewy22 with SMTP id 22so246511ewy.24
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:19 -0700 (PDT)
Received: by 10.213.28.206 with SMTP id n14mr913843ebc.50.1287707779487;
        Thu, 21 Oct 2010 17:36:19 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2483143eeh.20.2010.10.21.17.36.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.51 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159613>

From: Mike Pape <dotzenlabs@gmail.com>

Windows doesn't have inet_pton and inet_ntop, so
add prototypes in git-compat-util.h for them.

At the same time include git-compat-util.h in
the sources for these functions, so they use the
network-wrappers from there on Windows.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile           |    2 ++
 compat/inet_ntop.c |    6 +++---
 compat/inet_pton.c |    8 +++++---
 git-compat-util.h  |    8 ++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d9d9419..2aa067a 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,9 +1398,11 @@ endif
 endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
+	BASIC_CFLAGS += -DNO_INET_NTOP
 endif
 ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
+	BASIC_CFLAGS += -DNO_INET_PTON
 endif
 
 ifdef NO_ICONV
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index f444982..e5b46a0 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 4078fc0..2ec995e 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
@@ -41,7 +41,9 @@
  */
 
 static int inet_pton4(const char *src, unsigned char *dst);
+#ifndef NO_IPV6
 static int inet_pton6(const char *src, unsigned char *dst);
+#endif
 
 /* int
  * inet_pton4(src, dst)
diff --git a/git-compat-util.h b/git-compat-util.h
index e192831..56dce85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -387,6 +387,14 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 }
 #endif
 
+#ifdef NO_INET_PTON
+int inet_pton(int af, const char *src, void *dst);
+#endif
+
+#ifdef NO_INET_NTOP
+const char *inet_ntop(int af, const void *src, char *dst, size_t size);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 typedef void (*try_to_free_t)(size_t);
-- 
1.7.3.1.199.g72340
