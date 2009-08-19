From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 07/12] Add Unix header files to build git at MSVC.
Date: Wed, 19 Aug 2009 23:52:42 +0800
Message-ID: <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV6-0002JE-J9
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbZHSPy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbZHSPy1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:54:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:42860 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZHSPy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:54:26 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1311212rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=m8tQGPxwWNdWTsmi8CVC5swSquh+KZHBI/srdLottcI=;
        b=aw+HnCXenPKAI5a14pvurmk7hw5iZH5ch3AuZT7lFnGQfGOhJnLtHARgE3rBrURUIT
         9vaIQBZhylhNeh98rxUryIZh5O8qiDorS8VieTjIRmSu47WBWvbZDuvHycy/gy0l3Ak0
         GWXRofF88YDzOQwCPwSnQYadTF3ZBC/NNm6Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BoWaqZ0kJuOJzJHmiVtuX+/zX9+vKkOsymr0kW8b8zinjPAtPJka2vavEL0A/7XAEW
         mvXcovuqdxp86oELaaErv8fu/fN+4hlBASeQN8QY900t+XdmU1b9A2KkbW15i04rJ99W
         EO9ed/xkl5W12eh1C672VUt1PEABoHMg4ICpk=
Received: by 10.140.188.19 with SMTP id l19mr3853603rvf.48.1250697267677;
        Wed, 19 Aug 2009 08:54:27 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id g22sm83997rvb.2.2009.08.19.08.54.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:54:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126556>

Add head files direct.h, unistd.h and time.h to build git
Under MSVC.
These file coming from mingw header file.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/vcbuild/include/dirent.h |  127 +++++++++++++++++++++++++++++++++++++++
 compat/vcbuild/include/unistd.h |   92 ++++++++++++++++++++++++++++
 compat/vcbuild/sys/time.h       |   21 +++++++
 3 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/vcbuild/include/unistd.h
 create mode 100644 compat/vcbuild/sys/time.h

diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
new file mode 100644
index 0000000..a6b6f4c
--- /dev/null
+++ b/compat/vcbuild/include/dirent.h
@@ -0,0 +1,127 @@
+/*
+ * DIRENT.H (formerly DIRLIB.H)
+ * This file has no copyright assigned and is placed in the Public Domain.
+ * This file is a part of the mingw-runtime package.
+ * No warranty is given; refer to the file DISCLAIMER within the package.
+ *
+ */
+#ifndef _DIRENT_H_
+#define _DIRENT_H_
+
+/* All the headers include this file. */
+//#include <_mingw.h>
+
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
+         * Status of search:
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
+         * Status of search:
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
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
new file mode 100644
index 0000000..a0f59e6
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
\ No newline at end of file
diff --git a/compat/vcbuild/sys/time.h b/compat/vcbuild/sys/time.h
new file mode 100644
index 0000000..6ed82c0
--- /dev/null
+++ b/compat/vcbuild/sys/time.h
@@ -0,0 +1,21 @@
+#ifndef	_UTIME_H_
+#define	_UTIME_H_
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
-- 
1.6.4.msysgit.0
