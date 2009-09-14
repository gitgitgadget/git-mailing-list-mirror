From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 10/17] Add MinGW header files to build git with MSVC
Date: Mon, 14 Sep 2009 15:11:23 +0200
Message-ID: <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:14 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMm-0004Dd-Nf
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:12 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so3476534qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=j2ib8Ryt7IVNX1c+jOtohTuXdpCXIY0DIycdtsVKl2s=;
        b=gOFSiLXokw9ZlFFCf9Q3PtaJZaHcpC5cIaIdKQIDP24qAbvFflK45Z5/cddJ69Mpog
         cBtAiQkEsDr0CbvdV5cyACVI7C0r7puBSZl97lRmasiIIFqp9j0n8OmQaxgc2boq2Yzb
         qf05QclQROKQAVatk9uTcfUzsLNxVCQvT34Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=g1N2GjhwBzr1UAQ2yWQ8RZvR7S6+raTReLXE9MTnala0iZY6hEM2RzBQBF71FhWc2X
         d1F8Id/z3vb6uaPXRTcvv0arz68Xv/LY3+VYstxN4W0/qQiePL2hI4O8MWZnaFkur/24
         AkLiEt/6slxe4n8pQrbD2WN8cCkfcMU3IUYto=
Received: by 10.224.124.131 with SMTP id u3mr540955qar.28.1252933986481;
        Mon, 14 Sep 2009 06:13:06 -0700 (PDT)
Received: by 10.176.151.15 with SMTP id y15gr6968yqd.0;
	Mon, 14 Sep 2009 06:12:53 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.146.33 with SMTP id y33mr696193ebn.6.1252933971431; Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
Received: by 10.211.146.33 with SMTP id y33mr696192ebn.6.1252933970421; Mon, 14 Sep 2009 06:12:50 -0700 (PDT)
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com [209.85.219.220]) by gmr-mx.google.com with ESMTP id 14si1297305ewy.1.2009.09.14.06.12.49; Mon, 14 Sep 2009 06:12:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) client-ip=209.85.219.220;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.220 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f220.google.com with SMTP id 20so2254568ewy.21 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=nk/FhBtRR6zV1MQz3azotpq1qa7K/MZZeux3tLfVMF8=; b=uC8hZzBhhJk3V+WY6nXrW+qIyNAyQx3QGvKNryr8Po2ZdFn5Rya6PbI3Zy+5ZfRBJ4 p9RAVNRuBRM7VFoIPZIqKbR+Q6daJ2E5phKuZRJm8epBdGh1qMTv7cbIZkKWRgVKDV5J psh9k/IXa7k+GwQ1j5Leupe0v702p+WCluPnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=AL35EkVI7uVHDL09NGgoiW+W25ZYDFZUxjZU7Z+rap9y+VHSuRnYFjayTeaKRMmkzK Tl/kB+Q2in7htLfM29fDYn+tlxNoJiYTb+tsf0/uCeEGO8i0leZxanmv3vdQojmwR51c hh+1lBQjY0JS0wcdhcpUDrpYh2phaZyezAw3M=
Received: by 10.210.96.21 with SMTP id t21mr3176426ebb.4.1252933969290; Mon, 14 Sep 2009 06:12:49 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.47 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128469>


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
