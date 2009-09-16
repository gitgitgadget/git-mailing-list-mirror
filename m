From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 08/15] Add MinGW header files to build git with MSVC
Date: Wed, 16 Sep 2009 10:20:24 +0200
Message-ID: <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:22 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplQ-0004rX-I5
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:20 +0200
Received: by ywh4 with SMTP id 4so12827951ywh.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=j2ib8Ryt7IVNX1c+jOtohTuXdpCXIY0DIycdtsVKl2s=;
        b=hvizC64qgmP5dMgtLPedubpykkZ/c5A7pQIYfSVmypP8dwzCAiqRsCwvVIL2TKr/X6
         nt0z5H61ZJ2oI8gecgYRAXXhn7x3N6Ansv0jWNDVZHvBOg2aSs9Y/ko3AR+fr2WgUFqz
         MZMztFHFIdhktxwrYW6MHPS14L+iETYskz/VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=h3A3TGsuqkJJ4N9S/jzYHTMdOfWGtc6h5LKMe8cXzPMSThC5ftK+FGjbgsUL/QaW1f
         OIZ1iADYpqoF0kAoQiJXiVX5v7ygjeiQHpVYyWzNU6qX3ogcUCk/CL3lUl38KqZe+QN0
         yzKb3LkxRMzeTKwCz52E7MDAbnjptb9R7fOsc=
Received: by 10.101.131.33 with SMTP id i33mr1928436ann.26.1253089273723;
        Wed, 16 Sep 2009 01:21:13 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr7043yqn.0;
	Wed, 16 Sep 2009 01:21:03 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.3.25 with SMTP id 25mr1589661ebc.14.1253089262403; Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
Received: by 10.210.3.25 with SMTP id 25mr1589660ebc.14.1253089262374; Wed, 16 Sep 2009 01:21:02 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25]) by gmr-mx.google.com with ESMTP id 14si1701331ewy.5.2009.09.16.01.21.01; Wed, 16 Sep 2009 01:21:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.25 as permitted sender) client-ip=74.125.78.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.25 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 22so909275eye.43 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=nk/FhBtRR6zV1MQz3azotpq1qa7K/MZZeux3tLfVMF8=; b=j99GVBl+Y0OF/HlGm1hK4EfvWgoXOQgUafDfUzWG8M8LN9wN8uVhXBE1fA55fJc/Qb es7yko104i6KnP0DL+kWC3SVgelMi3WSoqt7vcI0lAsalCfu5JMHfyJq4g4H03ZBuhk/ 77b4Nj4YmZVQa12XtQT0Rhh/fyyzJclMJ6XT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=v4/odQEggWJe3f2734sPDjKa05tJaBV/pL/JYE/WD246MOSx+mrGYZ0KXngzXu5BtK JltC7f8OYF34Wyy4Nh1A7jQN7AT5qytW2XipysrykemC5hb/rI/l+GjTfjKoG75tEMux 2rx/NunnB1W8f4Q7b3PU2wZ6+8+5r36ml9HEw=
Received: by 10.211.130.19 with SMTP id h19mr9817554ebn.54.1253089261153; Wed, 16 Sep 2009 01:21:01 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.59 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128624>


From: Frank Li <lznuaa@gmail.com>

Added the header files dirent.h, unistd.h and utime.h
Add alloca.h, which simply includes malloc.h, which defines alloca

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/vcbuild/include/alloca.h    |    1 +
 compat/vcbuild/include/dirent.h    |  128 ++++++++++++++++++++++++++++++++++++
 compat/vcbuild/include/sys/utime.h |   34 ++++++++++
 compat/vcbuild/include/unistd.h    |   92 ++++++++++++++++++++++++++
 compat/vcbuild/include/utime.h     |    1 +
 5 files changed, 256 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/include/alloca.h
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/sys/utime.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/include/utime.h

diff --git a/compat/vcbuild/include/alloca.h b/compat/vcbuild/include/alloca.h
new file mode 100644
index 0000000..c0d7985
--- /dev/null
+++ b/compat/vcbuild/include/alloca.h
@@ -0,0 +1 @@
+#include <malloc.h>
diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
new file mode 100644
index 0000000..440618d
--- /dev/null
+++ b/compat/vcbuild/include/dirent.h
@@ -0,0 +1,128 @@
+/*
+ * DIRENT.H (formerly DIRLIB.H)
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ *
+ * The mingw-runtime package and its code is distributed in the hope that it
+ * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
+ * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
+ * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You are free to use this package and its code without limitation.
+ */
+#ifndef _DIRENT_H_
+#define _DIRENT_H_
+#include <io.h>
+
+#define PATH_MAX 512
+
+#define __MINGW_NOTHROW
+
+#ifndef RC_INVOKED
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct dirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	char		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ * dd_stat field is now int (was short in older versions).
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	struct _finddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct dirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+	 * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	char			dd_name[PATH_MAX+3];
+} DIR;
+
+DIR* __cdecl __MINGW_NOTHROW opendir (const char*);
+struct dirent* __cdecl __MINGW_NOTHROW readdir (DIR*);
+int __cdecl __MINGW_NOTHROW closedir (DIR*);
+void __cdecl __MINGW_NOTHROW rewinddir (DIR*);
+long __cdecl __MINGW_NOTHROW telldir (DIR*);
+void __cdecl __MINGW_NOTHROW seekdir (DIR*, long);
+
+
+/* wide char versions */
+
+struct _wdirent
+{
+	long		d_ino;		/* Always zero. */
+	unsigned short	d_reclen;	/* Always zero. */
+	unsigned short	d_namlen;	/* Length of name in d_name. */
+	wchar_t		d_name[FILENAME_MAX]; /* File name. */
+};
+
+/*
+ * This is an internal data structure. Good programmers will not use it
+ * except as an argument to one of the functions below.
+ */
+typedef struct
+{
+	/* disk transfer area for this dir */
+	//struct _wfinddata_t	dd_dta;
+
+	/* dirent struct to return from dir (NOTE: this makes this thread
+	 * safe as long as only one thread uses a particular DIR struct at
+	 * a time) */
+	struct _wdirent		dd_dir;
+
+	/* _findnext handle */
+	long			dd_handle;
+
+	/*
+	 * Status of search:
+	 *   0 = not started yet (next entry to read is first entry)
+	 *  -1 = off the end
+	 *   positive = 0 based index of next entry
+	 */
+	int			dd_stat;
+
+	/* given path for dir with search pattern (struct is extended) */
+	wchar_t			dd_name[1];
+} _WDIR;
+
+
+
+_WDIR* __cdecl __MINGW_NOTHROW _wopendir (const wchar_t*);
+struct _wdirent*  __cdecl __MINGW_NOTHROW _wreaddir (_WDIR*);
+int __cdecl __MINGW_NOTHROW _wclosedir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wrewinddir (_WDIR*);
+long __cdecl __MINGW_NOTHROW _wtelldir (_WDIR*);
+void __cdecl __MINGW_NOTHROW _wseekdir (_WDIR*, long);
+
+
+#ifdef	__cplusplus
+}
+#endif
+
+#endif	/* Not RC_INVOKED */
+
+#endif	/* Not _DIRENT_H_ */
diff --git a/compat/vcbuild/include/sys/utime.h b/compat/vcbuild/include/sys/utime.h
new file mode 100644
index 0000000..582589c
--- /dev/null
+++ b/compat/vcbuild/include/sys/utime.h
@@ -0,0 +1,34 @@
+#ifndef	_UTIME_H_
+#define	_UTIME_H_
+/*
+ * UTIME.H
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ *
+ * The mingw-runtime package and its code is distributed in the hope that it
+ * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
+ * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
+ * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You are free to use this package and its code without limitation.
+ */
+
+/*
+ * Structure used by _utime function.
+ */
+struct _utimbuf
+{
+	time_t	actime;		/* Access time */
+	time_t	modtime;	/* Modification time */
+};
+
+#ifndef	_NO_OLDNAMES
+/* NOTE: Must be the same as _utimbuf above. */
+struct utimbuf
+{
+	time_t	actime;
+	time_t	modtime;
+};
+#endif	/* Not _NO_OLDNAMES */
+
+#endif
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
new file mode 100644
index 0000000..2a4f276
--- /dev/null
+++ b/compat/vcbuild/include/unistd.h
@@ -0,0 +1,92 @@
+#ifndef _UNISTD_
+#define _UNISTD_
+
+/* Win32 define for porting git*/
+
+#ifndef _MODE_T_
+#define	_MODE_T_
+typedef unsigned short _mode_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _mode_t	mode_t;
+#endif
+#endif	/* Not _MODE_T_ */
+
+#ifndef _SSIZE_T_
+#define _SSIZE_T_
+typedef long _ssize_t;
+
+#ifndef	_OFF_T_
+#define	_OFF_T_
+typedef long _off_t;
+
+#ifndef	_NO_OLDNAMES
+typedef _off_t	off_t;
+#endif
+#endif	/* Not _OFF_T_ */
+
+
+#ifndef	_NO_OLDNAMES
+typedef _ssize_t ssize_t;
+#endif
+#endif /* Not _SSIZE_T_ */
+
+typedef signed char int8_t;
+typedef unsigned char   uint8_t;
+typedef short  int16_t;
+typedef unsigned short  uint16_t;
+typedef int  int32_t;
+typedef unsigned   uint32_t;
+typedef long long  int64_t;
+typedef unsigned long long   uint64_t;
+
+typedef long long  intmax_t;
+typedef unsigned long long uintmax_t;
+
+typedef int64_t off64_t;
+
+#define STDOUT_FILENO 1
+#define STDERR_FILENO 2
+
+/* Some defines for _access nAccessMode (MS doesn't define them, but
+ * it doesn't seem to hurt to add them). */
+#define	F_OK	0	/* Check for file existence */
+/* Well maybe it does hurt.  On newer versions of MSVCRT, an access mode
+   of 1 causes invalid parameter error. */
+#define	X_OK	0	/* MS access() doesn't check for execute permission. */
+#define	W_OK	2	/* Check for write permission */
+#define	R_OK	4	/* Check for read permission */
+
+#define	_S_IFIFO	0x1000	/* FIFO */
+#define	_S_IFCHR	0x2000	/* Character */
+#define	_S_IFBLK	0x3000	/* Block: Is this ever set under w32? */
+#define	_S_IFDIR	0x4000	/* Directory */
+#define	_S_IFREG	0x8000	/* Regular */
+
+#define	_S_IFMT		0xF000	/* File type mask */
+
+#define	_S_IXUSR	_S_IEXEC
+#define	_S_IWUSR	_S_IWRITE
+#define	_S_IRUSR	_S_IREAD
+#define	_S_ISDIR(m)	(((m) & _S_IFMT) == _S_IFDIR)
+
+#define	S_IFIFO		_S_IFIFO
+#define	S_IFCHR		_S_IFCHR
+#define	S_IFBLK		_S_IFBLK
+#define	S_IFDIR		_S_IFDIR
+#define	S_IFREG		_S_IFREG
+#define	S_IFMT		_S_IFMT
+#define	S_IEXEC		_S_IEXEC
+#define	S_IWRITE	_S_IWRITE
+#define	S_IREAD		_S_IREAD
+#define	S_IRWXU		_S_IRWXU
+#define	S_IXUSR		_S_IXUSR
+#define	S_IWUSR		_S_IWUSR
+#define	S_IRUSR		_S_IRUSR
+
+
+#define	S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
+#define	S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
+#define	S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
+
+#endif
diff --git a/compat/vcbuild/include/utime.h b/compat/vcbuild/include/utime.h
new file mode 100644
index 0000000..8285f38
--- /dev/null
+++ b/compat/vcbuild/include/utime.h
@@ -0,0 +1 @@
+#include <sys/utime.h>
-- 
1.6.2.1.418.g33d56.dirty
