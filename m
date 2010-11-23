From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 6/6] win32: use our own dirent.h
Date: Tue, 23 Nov 2010 19:38:29 +0100
Message-ID: <1290537509-360-7-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDblLDnBBoE67whdw@googlegroups.com Tue Nov 23 19:39:47 2010
Return-path: <msysgit+bncCOPdven-DxDblLDnBBoE67whdw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDblLDnBBoE67whdw@googlegroups.com>)
	id 1PKxmN-0007Yx-EU
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:47 +0100
Received: by mail-ww0-f58.google.com with SMTP id 40sf3016877wwj.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=6lYoriEzFMVqjcCPhK5kFVe66/is48TD1g5l0jYfMD8=;
        b=C8uhg3484g9giGUnH1jZSWzh9QWhnGxOv/TerQOjjti7SdTS1u3EbmucZ1etCdStiX
         PPDdXLeaOVbT4Yz2v8WVDNolfmBUwnhleMfY9fGNAldmFYY4dS98EOMNVIubz6oZkjYp
         oZPzoXu06DsBnbUkbDJA8yKwAAkcJJgHnz/5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=BhQ755aKV0+sOLAwhtHgeinrqdGQNq3VyWRoHAdmWIGTYoeI+8J6oGZw0OFEb6QtGa
         3PRr2XdPQAFRzwHwlyig8ouSagDGoqW1tTrxsJzFgWOPQziqFEghferbkBAa7jmOzcNZ
         kzmhnXb5R8bhBbn+qPerxyiiep4+yqJgxdW9Q=
Received: by 10.216.56.16 with SMTP id l16mr2651wec.15.1290537563801;
        Tue, 23 Nov 2010 10:39:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.25.20 with SMTP id y20ls1436847eey.1.p; Tue, 23 Nov 2010
 10:39:23 -0800 (PST)
Received: by 10.14.48.2 with SMTP id u2mr1028048eeb.21.1290537562892;
        Tue, 23 Nov 2010 10:39:22 -0800 (PST)
Received: by 10.14.48.2 with SMTP id u2mr1028047eeb.21.1290537562841;
        Tue, 23 Nov 2010 10:39:22 -0800 (PST)
Received: from mail-ey0-f175.google.com (mail-ey0-f175.google.com [209.85.215.175])
        by gmr-mx.google.com with ESMTP id t6si2092171eeh.0.2010.11.23.10.39.21;
        Tue, 23 Nov 2010 10:39:21 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender) client-ip=209.85.215.175;
Received: by eya28 with SMTP id 28so4736408eya.6
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:21 -0800 (PST)
Received: by 10.213.19.5 with SMTP id y5mr2060786eba.72.1290537558679;
        Tue, 23 Nov 2010 10:39:18 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm6070555eeh.9.2010.11.23.10.39.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:18 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162009>

The mingw-runtime implemenation of opendir, readdir and closedir
sets errno to 0 on success, something that POSIX explicitly
forbids. 3ba7a06 ("A loose object is not corrupt if it cannot be
read due to EMFILE") introduce a dependency on this behaviour,
leading to a broken "git clone" on Windows.

compat/mingw.c contains an implementation of readdir, and
compat/msvc.c contains implementations of opendir and closedir.

Move these to compat/win32/dirent.[ch], and change to our own DIR
structure at the same time.

This provides a generic Win32-implementation of opendir, readdir
and closedir which works on both MinGW and MSVC and does not reset
errno, and as a result git clone is working again on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                        |    7 ++-
 compat/mingw.c                  |   60 ------------------
 compat/mingw.h                  |   29 ---------
 compat/msvc.c                   |   52 ----------------
 compat/vcbuild/include/dirent.h |  128 ---------------------------------------
 compat/win32/dirent.c           |  108 +++++++++++++++++++++++++++++++++
 compat/win32/dirent.h           |   24 +++++++
 7 files changed, 137 insertions(+), 271 deletions(-)
 delete mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/win32/dirent.c
 create mode 100644 compat/win32/dirent.h

diff --git a/Makefile b/Makefile
index ca1d1fe..765aad4 100644
--- a/Makefile
+++ b/Makefile
@@ -499,6 +499,7 @@ LIB_H += compat/mingw.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/sys/poll.h
+LIB_H += compat/win32/dirent.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -1086,7 +1087,9 @@ ifeq ($(uname_S),Windows)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o compat/win32/sys/poll.o
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o \
+		compat/win32/pthread.o compat/win32/syslog.o \
+		compat/win32/sys/poll.o compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1158,7 +1161,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o
+		compat/win32/sys/poll.o compat/win32/dirent.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/mingw.c b/compat/mingw.c
index d8fd5d8..bee6054 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1566,63 +1566,3 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 	errno = EINVAL;
 	return -1;
 }
-
-#ifndef NO_MINGW_REPLACE_READDIR
-/* MinGW readdir implementation to avoid extra lstats for Git */
-struct mingw_DIR
-{
-	struct _finddata_t	dd_dta;		/* disk transfer area for this dir */
-	struct mingw_dirent	dd_dir;		/* Our own implementation, including d_type */
-	long			dd_handle;	/* _findnext handle */
-	int			dd_stat; 	/* 0 = next entry to read is first entry, -1 = off the end, positive = 0 based index of next entry */
-	char			dd_name[1]; 	/* given path for dir with search pattern (struct is extended) */
-};
-
-struct dirent *mingw_readdir(DIR *dir)
-{
-	WIN32_FIND_DATAA buf;
-	HANDLE handle;
-	struct mingw_DIR *mdir = (struct mingw_DIR*)dir;
-
-	if (!dir || !dir->dd_handle) {
-		errno = EBADF; /* No set_errno for mingw */
-		return NULL;
-	}
-
-	if (dir->dd_handle == (long)INVALID_HANDLE_VALUE && dir->dd_stat == 0)
-	{
-		DWORD lasterr;
-		handle = FindFirstFileA(dir->dd_name, &buf);
-		lasterr = GetLastError();
-		dir->dd_handle = (long)handle;
-		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
-			errno = err_win_to_posix(lasterr);
-			return NULL;
-		}
-	} else if (dir->dd_handle == (long)INVALID_HANDLE_VALUE) {
-		return NULL;
-	} else if (!FindNextFileA((HANDLE)dir->dd_handle, &buf)) {
-		DWORD lasterr = GetLastError();
-		FindClose((HANDLE)dir->dd_handle);
-		dir->dd_handle = (long)INVALID_HANDLE_VALUE;
-		/* POSIX says you shouldn't set errno when readdir can't
-		   find any more files; so, if another error we leave it set. */
-		if (lasterr != ERROR_NO_MORE_FILES)
-			errno = err_win_to_posix(lasterr);
-		return NULL;
-	}
-
-	/* We get here if `buf' contains valid data.  */
-	strcpy(dir->dd_dir.d_name, buf.cFileName);
-	++dir->dd_stat;
-
-	/* Set file type, based on WIN32_FIND_DATA */
-	mdir->dd_dir.d_type = 0;
-	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-		mdir->dd_dir.d_type |= DT_DIR;
-	else
-		mdir->dd_dir.d_type |= DT_REG;
-
-	return (struct dirent*)&dir->dd_dir;
-}
-#endif // !NO_MINGW_REPLACE_READDIR
diff --git a/compat/mingw.h b/compat/mingw.h
index 35d9813..2283071 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -322,35 +322,6 @@ int main(int argc, const char **argv) \
 } \
 static int mingw_main(c,v)
 
-#ifndef NO_MINGW_REPLACE_READDIR
-/*
- * A replacement of readdir, to ensure that it reads the file type at
- * the same time. This avoid extra unneeded lstats in git on MinGW
- */
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-
-struct mingw_dirent
-{
-	long		d_ino;			/* Always zero. */
-	union {
-		unsigned short	d_reclen;	/* Always zero. */
-		unsigned char   d_type;		/* Reimplementation adds this */
-	};
-	unsigned short	d_namlen;		/* Length of name in d_name. */
-	char		d_name[FILENAME_MAX];	/* File name. */
-};
-#define dirent mingw_dirent
-#define readdir(x) mingw_readdir(x)
-struct dirent *mingw_readdir(DIR *dir);
-#endif // !NO_MINGW_REPLACE_READDIR
-
 /*
  * Used by Pthread API implementation for Windows
  */
diff --git a/compat/msvc.c b/compat/msvc.c
index fdbfb70..71843d7 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -3,56 +3,4 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-DIR *opendir(const char *name)
-{
-	DWORD attrs = GetFileAttributes(name);
-	int len;
-	DIR *p;
-
-	/* check for valid path */
-	if (attrs == INVALID_FILE_ATTRIBUTES) {
-		errno = ENOENT;
-		return NULL;
-	}
-
-	/* check if it's a directory */
-	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
-		errno = ENOTDIR;
-		return NULL;
-	}
-
-	/* check that the pattern won't be too long for FindFirstFileA */
-	len = strlen(name);
-	if (is_dir_sep(name[len - 1]))
-		len--;
-	if (len + 2 >= MAX_PATH) {
-		errno = ENAMETOOLONG;
-		return NULL;
-	}
-
-	p = malloc(sizeof(DIR) + len + 2);
-	if (!p)
-		return NULL;
-
-	memset(p, 0, sizeof(DIR) + len + 2);
-	strcpy(p->dd_name, name);
-	p->dd_name[len] = '/';
-	p->dd_name[len+1] = '*';
-
-	p->dd_handle = (long)INVALID_HANDLE_VALUE;
-	return p;
-}
-int closedir(DIR *dir)
-{
-	if (!dir) {
-		errno = EBADF;
-		return -1;
-	}
-
-	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
-		FindClose((HANDLE)dir->dd_handle);
-	free(dir);
-	return 0;
-}
-
 #include "mingw.c"
diff --git a/compat/vcbuild/include/dirent.h b/compat/vcbuild/include/dirent.h
deleted file mode 100644
index 440618d..0000000
--- a/compat/vcbuild/include/dirent.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * DIRENT.H (formerly DIRLIB.H)
- * This file has no copyright assigned and is placed in the Public Domain.
- * This file is a part of the mingw-runtime package.
- *
- * The mingw-runtime package and its code is distributed in the hope that it
- * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
- * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
- * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You are free to use this package and its code without limitation.
- */
-#ifndef _DIRENT_H_
-#define _DIRENT_H_
-#include <io.h>
-
-#define PATH_MAX 512
-
-#define __MINGW_NOTHROW
-
-#ifndef RC_INVOKED
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct dirent
-{
-	long		d_ino;		/* Always zero. */
-	unsigned short	d_reclen;	/* Always zero. */
-	unsigned short	d_namlen;	/* Length of name in d_name. */
-	char		d_name[FILENAME_MAX]; /* File name. */
-};
-
-/*
- * This is an internal data structure. Good programmers will not use it
- * except as an argument to one of the functions below.
- * dd_stat field is now int (was short in older versions).
- */
-typedef struct
-{
-	/* disk transfer area for this dir */
-	struct _finddata_t	dd_dta;
-
-	/* dirent struct to return from dir (NOTE: this makes this thread
-	 * safe as long as only one thread uses a particular DIR struct at
-	 * a time) */
-	struct dirent		dd_dir;
-
-	/* _findnext handle */
-	long			dd_handle;
-
-	/*
-	 * Status of search:
-	 *   0 = not started yet (next entry to read is first entry)
-	 *  -1 = off the end
-	 *   positive = 0 based index of next entry
-	 */
-	int			dd_stat;
-
-	/* given path for dir with search pattern (struct is extended) */
-	char			dd_name[PATH_MAX+3];
-} DIR;
-
-DIR* __cdecl __MINGW_NOTHROW opendir (const char*);
-struct dirent* __cdecl __MINGW_NOTHROW readdir (DIR*);
-int __cdecl __MINGW_NOTHROW closedir (DIR*);
-void __cdecl __MINGW_NOTHROW rewinddir (DIR*);
-long __cdecl __MINGW_NOTHROW telldir (DIR*);
-void __cdecl __MINGW_NOTHROW seekdir (DIR*, long);
-
-
-/* wide char versions */
-
-struct _wdirent
-{
-	long		d_ino;		/* Always zero. */
-	unsigned short	d_reclen;	/* Always zero. */
-	unsigned short	d_namlen;	/* Length of name in d_name. */
-	wchar_t		d_name[FILENAME_MAX]; /* File name. */
-};
-
-/*
- * This is an internal data structure. Good programmers will not use it
- * except as an argument to one of the functions below.
- */
-typedef struct
-{
-	/* disk transfer area for this dir */
-	//struct _wfinddata_t	dd_dta;
-
-	/* dirent struct to return from dir (NOTE: this makes this thread
-	 * safe as long as only one thread uses a particular DIR struct at
-	 * a time) */
-	struct _wdirent		dd_dir;
-
-	/* _findnext handle */
-	long			dd_handle;
-
-	/*
-	 * Status of search:
-	 *   0 = not started yet (next entry to read is first entry)
-	 *  -1 = off the end
-	 *   positive = 0 based index of next entry
-	 */
-	int			dd_stat;
-
-	/* given path for dir with search pattern (struct is extended) */
-	wchar_t			dd_name[1];
-} _WDIR;
-
-
-
-_WDIR* __cdecl __MINGW_NOTHROW _wopendir (const wchar_t*);
-struct _wdirent*  __cdecl __MINGW_NOTHROW _wreaddir (_WDIR*);
-int __cdecl __MINGW_NOTHROW _wclosedir (_WDIR*);
-void __cdecl __MINGW_NOTHROW _wrewinddir (_WDIR*);
-long __cdecl __MINGW_NOTHROW _wtelldir (_WDIR*);
-void __cdecl __MINGW_NOTHROW _wseekdir (_WDIR*, long);
-
-
-#ifdef	__cplusplus
-}
-#endif
-
-#endif	/* Not RC_INVOKED */
-
-#endif	/* Not _DIRENT_H_ */
diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
new file mode 100644
index 0000000..7a0debe
--- /dev/null
+++ b/compat/win32/dirent.c
@@ -0,0 +1,108 @@
+#include "../git-compat-util.h"
+#include "dirent.h"
+
+struct DIR {
+	struct dirent dd_dir; /* includes d_type */
+	HANDLE dd_handle;     /* FindFirstFile handle */
+	int dd_stat;          /* 0-based index */
+	char dd_name[1];      /* extend struct */
+};
+
+DIR *opendir(const char *name)
+{
+	DWORD attrs = GetFileAttributesA(name);
+	int len;
+	DIR *p;
+
+	/* check for valid path */
+	if (attrs == INVALID_FILE_ATTRIBUTES) {
+		errno = ENOENT;
+		return NULL;
+	}
+
+	/* check if it's a directory */
+	if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
+		errno = ENOTDIR;
+		return NULL;
+	}
+
+	/* check that the pattern won't be too long for FindFirstFileA */
+	len = strlen(name);
+	if (is_dir_sep(name[len - 1]))
+		len--;
+	if (len + 2 >= MAX_PATH) {
+		errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	p = malloc(sizeof(DIR) + len + 2);
+	if (!p)
+		return NULL;
+
+	memset(p, 0, sizeof(DIR) + len + 2);
+	strcpy(p->dd_name, name);
+	p->dd_name[len] = '/';
+	p->dd_name[len+1] = '*';
+
+	p->dd_handle = INVALID_HANDLE_VALUE;
+	return p;
+}
+
+struct dirent *readdir(DIR *dir)
+{
+	WIN32_FIND_DATAA buf;
+	HANDLE handle;
+
+	if (!dir || !dir->dd_handle) {
+		errno = EBADF; /* No set_errno for mingw */
+		return NULL;
+	}
+
+	if (dir->dd_handle == INVALID_HANDLE_VALUE && dir->dd_stat == 0) {
+		DWORD lasterr;
+		handle = FindFirstFileA(dir->dd_name, &buf);
+		lasterr = GetLastError();
+		dir->dd_handle = handle;
+		if (handle == INVALID_HANDLE_VALUE && (lasterr != ERROR_NO_MORE_FILES)) {
+			errno = err_win_to_posix(lasterr);
+			return NULL;
+		}
+	} else if (dir->dd_handle == INVALID_HANDLE_VALUE) {
+		return NULL;
+	} else if (!FindNextFileA(dir->dd_handle, &buf)) {
+		DWORD lasterr = GetLastError();
+		FindClose(dir->dd_handle);
+		dir->dd_handle = INVALID_HANDLE_VALUE;
+		/* POSIX says you shouldn't set errno when readdir can't
+		   find any more files; so, if another error we leave it set. */
+		if (lasterr != ERROR_NO_MORE_FILES)
+			errno = err_win_to_posix(lasterr);
+		return NULL;
+	}
+
+	/* We get here if `buf' contains valid data.  */
+	strcpy(dir->dd_dir.d_name, buf.cFileName);
+	++dir->dd_stat;
+
+	/* Set file type, based on WIN32_FIND_DATA */
+	dir->dd_dir.d_type = 0;
+	if (buf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+		dir->dd_dir.d_type |= DT_DIR;
+	else
+		dir->dd_dir.d_type |= DT_REG;
+
+	return &dir->dd_dir;
+}
+
+int closedir(DIR *dir)
+{
+	if (!dir) {
+		errno = EBADF;
+		return -1;
+	}
+
+	if (dir->dd_handle != INVALID_HANDLE_VALUE)
+		FindClose(dir->dd_handle);
+	free(dir);
+	return 0;
+}
diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
new file mode 100644
index 0000000..927a25c
--- /dev/null
+++ b/compat/win32/dirent.h
@@ -0,0 +1,24 @@
+#ifndef DIRENT_H
+#define DIRENT_H
+
+typedef struct DIR DIR;
+
+#define DT_UNKNOWN 0
+#define DT_DIR     1
+#define DT_REG     2
+#define DT_LNK     3
+
+struct dirent {
+	long d_ino;                      /* Always zero. */
+	char d_name[FILENAME_MAX];       /* File name. */
+	union {
+		unsigned short d_reclen; /* Always zero. */
+		unsigned char  d_type;   /* Reimplementation adds this */
+	};
+};
+
+DIR *opendir(const char *dirname);
+struct dirent *readdir(DIR *dir);
+int closedir(DIR *dir);
+
+#endif /* DIRENT_H */
-- 
1.7.3.2.493.gc8738
