From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 11/17] Add platform files for MSVC porting
Date: Mon, 14 Sep 2009 15:11:24 +0200
Message-ID: <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:11 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMg-0004O6-Kt
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:06 +0200
Received: by qyk30 with SMTP id 30so3477056qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ybVUlD0GztCzWpJMY3W0azopd+zbtHpdGVOE8C0aSpA=;
        b=2KS/4wT+IaDxinDsKduw1Vi8iSV6vrgLQgPN38W8T6/mj2YusaIgkSbQS/T5AjWr5L
         SUuWIaeMqbwC3PD78EAOxdDhly21dzjxm0vV3xTtmt5iee7Gbv3DSH+U5axbjzVtKlzW
         Nh4YEgZUD5ZykywAa5s4OAoPkK5RdS4k7BKg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=CHqbPyBhImpcKFiy1HjZJLE1+NiaL7az6vjeiTfNL0Atcgr1ENYFtro3Dry05SSDRC
         2xCjv//5o8nIczWpnPIADwW/KzNDE5FlSijLmnDZ7aeaaj1tJHLq/9shgtitTIFMGUfR
         2+uZCYOK3yz3dyfa7aF3gIXExYkrqWiZcrekU=
Received: by 10.229.77.203 with SMTP id h11mr505803qck.2.1252933980035;
        Mon, 14 Sep 2009 06:13:00 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr6969yqd.0;
	Mon, 14 Sep 2009 06:12:53 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.161.31 with SMTP id n31mr866997ebo.5.1252933972181; Mon, 14 Sep 2009 06:12:52 -0700 (PDT)
Received: by 10.211.161.31 with SMTP id n31mr866996ebo.5.1252933972154; Mon, 14 Sep 2009 06:12:52 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144]) by gmr-mx.google.com with ESMTP id 16si1290826ewy.7.2009.09.14.06.12.51; Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) client-ip=74.125.78.144;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.144 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 3so466452eyh.4 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=A0cpsqlm1QaiRoq4jkZjmJR7ouzKAdzRL/eME/TcRc8=; b=vum+Pn2MOlKM9XQT/TTchwcUIIRlnA+louKAklyD5boWItCsaY1WgentdIdEhERz+f 63ZF6eBD5BYfPhBeE+WIb7BADd1aBaX9ZIYh+XZiHgUvWzaBu3176lRnOIfCLK9AePTT P3r7r5iKkFgqKt8iakFYnI0uq8VHMN0VVv608=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=mLGMusfM1E2te46ScQ5ADEChKFrB6EjuiHzpp0HmVZ2YB8MQCoytGAKBr4EPPcjB/U YISf9tOeKHIitgj7Li9pDT8bf+uCy2hsqAS6/NT9A9Rv9xG+qiWKFGJVOlO2wOOHtSCn v0k3E9oeyVE8VFdDwgdi+Svipx8o3hc9IcEAE=
Received: by 10.211.129.20 with SMTP id g20mr3245574ebn.14.1252933971047; Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.49 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128467>


From: Frank Li <lznuaa@gmail.com>

Add msvc.c and msvc.h to build git under MSVC

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/msvc.c     |   35 +++++++++++++++++++++++++++++++++
 compat/msvc.h     |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h |    3 ++
 3 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 compat/msvc.c
 create mode 100644 compat/msvc.h

diff --git a/compat/msvc.c b/compat/msvc.c
new file mode 100644
index 0000000..ac04a4c
--- /dev/null
+++ b/compat/msvc.c
@@ -0,0 +1,35 @@
+#include "../git-compat-util.h"
+#include "win32.h"
+#include <conio.h>
+#include "../strbuf.h"
+
+DIR *opendir(const char *name)
+{
+	int len;
+	DIR *p;
+	p = (DIR*)malloc(sizeof(DIR));
+	memset(p, 0, sizeof(DIR));
+	strncpy(p->dd_name, name, PATH_MAX);
+	len = strlen(p->dd_name);
+	p->dd_name[len] = '/';
+	p->dd_name[len+1] = '*';
+
+	if (p == NULL)
+		return NULL;
+
+	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
+
+	if (p->dd_handle == -1) {
+		free(p);
+		return NULL;
+	}
+	return p;
+}
+int closedir(DIR *dir)
+{
+	_findclose(dir->dd_handle);
+	free(dir);
+	return 0;
+}
+
+#include "mingw.c"
diff --git a/compat/msvc.h b/compat/msvc.h
new file mode 100644
index 0000000..6daf313
--- /dev/null
+++ b/compat/msvc.h
@@ -0,0 +1,55 @@
+#ifndef __MSVC__HEAD
+#define __MSVC__HEAD
+
+/* Define minimize windows version */
+#define WINVER 0x0500
+#define _WIN32_WINNT 0x0500
+#define _WIN32_WINDOWS 0x0410
+#define _WIN32_IE 0x0700
+#define NTDDI_VERSION NTDDI_WIN2KSP1
+#include <winsock2.h>
+#include <direct.h>
+#include <process.h>
+#include <malloc.h>
+
+/* porting function */
+#define inline __inline
+#define __inline__ __inline
+#define __attribute__(x)
+#define va_copy(dst, src)     ((dst) = (src))
+
+static __inline int strcasecmp (const char *s1, const char *s2)
+{
+	int size1 = strlen(s1);
+	int sisz2 = strlen(s2);
+	return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
+}
+
+#undef ERROR
+#undef stat
+#undef _stati64
+#include "compat/mingw.h"
+#undef stat
+#define stat _stati64
+#define _stat64(x,y) mingw_lstat(x,y)
+
+/*
+   Even though _stati64 is normally just defined at _stat64
+   on Windows, we specify it here as a proper struct to avoid
+   compiler warnings about macro redefinition due to magic in
+   mingw.h. Struct taken from ReactOS (GNU GPL license).
+*/
+struct _stati64 {
+	_dev_t  st_dev;
+	_ino_t  st_ino;
+	unsigned short st_mode;
+	short   st_nlink;
+	short   st_uid;
+	short   st_gid;
+	_dev_t  st_rdev;
+	__int64 st_size;
+	time_t  st_atime;
+	time_t  st_mtime;
+	time_t  st_ctime;
+};
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e5e9f39..8ea444f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,9 @@
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
 #endif	/* __MINGW32__ */
+#ifdef _MSC_VER
+#include "compat/msvc.h"
+#endif
 
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
-- 
1.6.2.1.418.g33d56.dirty
