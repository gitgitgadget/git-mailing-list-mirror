From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 09/15] Add platform files for MSVC porting
Date: Wed, 16 Sep 2009 10:20:25 +0200
Message-ID: <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:22 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplR-0004oA-AL
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:21 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so12827760ywh.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ybVUlD0GztCzWpJMY3W0azopd+zbtHpdGVOE8C0aSpA=;
        b=Oi5QMk4xVumKBHrRbubvC1ckh89a4xmq8frugZD2AszXKpsyhXTD94GOam1jVZSyQo
         FBPiixrSq5SigmNo3LYTJNGykozePc8hUf/q9xMQPaBYJY5u38xhkD3WtD9hZRtuHlEL
         tJnwWHpUe3ZJ0toAgE6fKvqE5uTl7maaMGxZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=LijOX3e/sh+kGm+R4evObkiu4Wc1OgWcjYCIkJJWoWJQWJpfQ6RBE3pwq6kdK5UACU
         LNlxH+mEx3qFLVAwHsnQTSCnc1GiTgLzPwqPw6zdJ7mYqxUXYBaCsPWOrZChLjYKJmNa
         pZNZZXc7yrpm8pSCecSwJ6SChqbwWA+pRnwIc=
Received: by 10.91.15.15 with SMTP id s15mr901471agi.10.1253089274859;
        Wed, 16 Sep 2009 01:21:14 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7044yqa.0;
	Wed, 16 Sep 2009 01:21:04 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.21 with SMTP id 21mr241882ebf.9.1253089263805; Wed, 16 Sep 2009 01:21:03 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr241881ebf.9.1253089263767; Wed, 16 Sep 2009 01:21:03 -0700 (PDT)
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com [209.85.219.222]) by gmr-mx.google.com with ESMTP id 14si1701175ewy.5.2009.09.16.01.21.02; Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.222 as permitted sender) client-ip=209.85.219.222;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.222 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f222.google.com with SMTP id 22so4500227ewy.38 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=A0cpsqlm1QaiRoq4jkZjmJR7ouzKAdzRL/eME/TcRc8=; b=I5tcJk7mNE6FMnGRqqVpXMTm1SklNmrMbumee0gCVfyJcDdkTjsefOispxooxI0ygd Hwx3AW+vn/Uf24nqlLRGWukyaS9AMsKEFsd8fVlLJrgYBWRwsNpgYWpl4inURagoWZPl QSa9BbyRyZt0MJl2rD1Vvx3FbVAjipwQ3etjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=sLVgKRYbbucReow26PcUWlMMYHnByhkeH5jv5MCDkc3U/6Rewsuk7klHGcL1frG5KP +5iogVxa5sxLQ/QIBCdaVH1fTh6AdosKzZkNcfXGJ+rgmz+kVeXmjArV3ug/kXWSiPF6 QFAXTg76idbz693A6KJk6uwRwQ3zFh5ku5tGo=
Received: by 10.211.174.13 with SMTP id b13mr9594831ebp.73.1253089262572; Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.01 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128625>


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
