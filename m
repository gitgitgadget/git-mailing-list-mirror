From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 09/14] Add platform files for MSVC porting
Date: Tue, 15 Sep 2009 15:44:12 +0200
Message-ID: <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:21 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLQ-0007MF-UH
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:21 +0200
Received: by ywh4 with SMTP id 4so11220816ywh.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ybVUlD0GztCzWpJMY3W0azopd+zbtHpdGVOE8C0aSpA=;
        b=2tArSnJJmSTCPeaDSFsNdlhTGAaAWP4yrwwAEEcwwdTVVduHTKTwXKSBDsXvfrO6Kb
         +vhbRAEwVyG/3zi2QYMUsA/+Y7/jLOoUpxeUdBgEomkWtS3TRkdo2OZ0FmOKnU5ZgMIa
         7ahCZlERO92mOKZr8DAqLzW8j0yPu8xPr5yjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=oKAnO3M14TWPcTh1oPoVOH+ZNGPwIFYt0Y/gqRskfEv5lyNCZJ7QsX+pT6t5084/Bi
         qXZB0ftviHk5vw/abxbkgFKpXclX0ay0XCLX0rsTZKJf+dKhdrMONrvQq7eaIM8sUQGc
         n3LtZNApukATat2wDljrvcTer4qzEJGBqkTnQ=
Received: by 10.101.84.9 with SMTP id m9mr1741478anl.27.1253022308257;
        Tue, 15 Sep 2009 06:45:08 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7017yqi.0;
	Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.7.17 with SMTP id 17mr132287ebg.3.1253022292258; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received: by 10.210.7.17 with SMTP id 17mr132286ebg.3.1253022292205; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com [209.85.219.218]) by gmr-mx.google.com with ESMTP id 15si1528119ewy.4.2009.09.15.06.44.51; Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.218 as permitted sender) client-ip=209.85.219.218;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.218 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f218.google.com with SMTP id 18so1658524ewy.43 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=A0cpsqlm1QaiRoq4jkZjmJR7ouzKAdzRL/eME/TcRc8=; b=d+W/uKD9Q6tNni+YgkBZTv0V2XpqNRhw8hnQ2mGLSgcrNIYyYNe+KszVro9B6W4yVt yXDzrJIPmS5P0PH+lI1DAOc2IVTw9a4QAXIRBk1DPuB9XNPTvUL/D3Vh5Me0XngP1ZjC +4rddSz2D42EXWCqHs5gChpoAqDkCnrQ8t5WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=oMb6ixOgxY/m52Kf2509BqnrMJ0wMZzkVf37i6uP84CJyC6ENo7OOxSqpuGEqOZ02M 6t1GYv3jh16DCDaHfYbfD7CiPiXSMN8Ilh0nwRN/zo4IDtfQoY6xG+425WioLAlHcRTe fQJYTVqFsz40nrgUSs6SFKUAWEgTSFSN5Uf+U=
Received: by 10.211.147.10 with SMTP id z10mr898617ebn.28.1253022289698; Tue, 15 Sep 2009 06:44:49 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.48 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128554>


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
