Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F884310779
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322209; cv=none; b=LCaxTiTZgMdZ4t+xvUdCu0X3HoF+jP9RAAW0Cxdiw5Dhpj2uCafHVlMRNT4qcMf3ZYcUeTKhFjFYWAJqulWtsYI4F4IMLIlSfWjoguWVjBEIGsir1sjjIUFaC1YH4hQU4lIf2aZAL3lObYuq4RBt3ZnqokF/p0tWwwWoe7FG0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322209; c=relaxed/simple;
	bh=D6OfW3tWnaa0bbLRMuiYfM0F7Fq5HCRA01vLha993T4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fUhSeZcjRpVPKV5GJizQ+BjVnKBoR84YipihBWNimoPEjTgCISTim9Mw7E12OE0fiYzFZgyjmlXbnrbAYvsNQXuTG3SC6fysVMOthr03ZHOLOWkP5quiohz8RvyNjZnYxPx3BsD9CYJmFeRS5Y1cz1+aHeOEAG6q0Tr0E066Jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBCit4oG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBCit4oG"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1469c1b83so1376196a12.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322206; x=1787927006; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=avnwTnfwb8aa2zWK8O48r81kpmCWRlQcDs07jg18wU0=;
        b=rBCit4oGxRw0JA4OqTrmCua8KiKNjtsWCG6g3CFoIW4+skd76d75hrl4rtZc9g7BWM
         rRNHa+KbrjZ5Kvz53fAXsRUrP2WKTjLuu6y2ahXG0T49RkXY2wys/o5HA0zWdu6MxQwn
         wDYMEpW184ZUq6sXJw1WXu/V9hshhenG21niNP3922shQAC7XW2BZXc5kGBLXnVnx6KY
         0bD6+zc2bCtd3Xf468rPAg2rkPa9gTnRmWS2NDP6CcxKLN0Xi8R8ogOPM0UlS/x4iUul
         AEb1se8QJD5vU6zGvMvRq0xH43SEzdE80B2AsgnftEp9lspeiVabo1ktv3fV7nWxj3pN
         LoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322206; x=1787927006;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avnwTnfwb8aa2zWK8O48r81kpmCWRlQcDs07jg18wU0=;
        b=m8I/ZoMZNFR52tadACXkk9cxWranlPCMzYMmHZu1ZLnw2lCWwP4aoG71oF23OkhBNc
         rDhvKllVBGfoD2F9uc7T9MLu1SrTyPgmGsbhRINW8S9jM5G7wKO0hUknguK70HV+qSg0
         VotCNxHhbxn3v2TDOuOsE6dC0w9p3KbGVkITsl7LbnsgbgqlByXrWgbK+c+bKnqIZ3Cv
         iTNoRrE+mBneatJpwNmUe8uAc/f/vhwIvsOQbVR5Fj4fYsyFgk07BbBF4jaBhKAp8VXk
         QobLAfVptnr2rX4RIzU7IIq9gWXOT9fSbBEvpgwLHv7Dn57HdNfWAHVmQNV42g9CqqA2
         wQwg==
X-Gm-Message-State: AFuF++kWF4l9Jb2ZTo6AWE7jAA9THnTq8+XuGL4AcRATa6tkvVEeijQL
	jPgc+RBTqgek5suXKE5dMMGQEM7v+fzSIBGRLv4a04jcLvAsWnx6fLhja+9lmQ==
X-Gm-Gg: AR+sD10FAYq5+xt36P1DQERVne/dBUUDmgrkJRjTlLTOD/ICQkirapHKtvdTaQrRS6G
	GvuhFffH/xDkn3b+oJzzbIweMuL+AQQY2e3/BMMcLOywx/GKWKYTYQ0H6f8i0YEVS8DLkETe1J5
	pibldku28tBu6MIEw8JiLnFGqRvavn+SMe5S8+pf75jejfXt1yTuUHEThtt6qKpz6Ued5+xRsGs
	rBpliz943jCDdJlGPsWQ6hl/2fSr0WQ6YGZvEUZVNJYKg/YadUqdOH3VbluLgwx0b0QSVfMaMwu
	M6eZ5c1IoaJ21rsk8VCb3gSWf3WhKCU193NRjf0lqy/csCxRv9YYNVY9i1YQ6dY9QFPyKJWpTC6
	OZ6D0fdKqT3ppBJgumE/G1MM2YBotnAh3mCse49RNsnSFWHN3/aiVtQ2BveHpmiB0mQo7HjoKqX
	ON8Bwmip7ZFe8YatEu31iihVvNm4fc8lJssCusJ+Ca/O7UqDeOeignYZDeRM0iE6QPMTt26qBE
X-Received: by 2002:a05:6a00:b94:b0:84a:2c46:3fdb with SMTP id d2e1a72fcca58-851f9ce2a0dmr9437845b3a.5.1787322205876;
        Fri, 21 Aug 2026 07:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([128.85.45.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d369cf91sm3007721b3a.58.2026.08.21.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:23:25 -0700 (PDT)
Message-Id: <13aa80bc0167aae05498bac1c59846274ee00e9d.1787322203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
From: "Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 14:23:21 +0000
Subject: [PATCH 1/3] compat/posix: introduce utimensat(2) wrapper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alexey Samsonov <vonosmas@gmail.com>,
    Alexey Samsonov <vonosmas@gmail.com>

From: Alexey Samsonov <vonosmas@gmail.com>

In POSIX.1-2008, utime(3p) was marked as obsolescent in favor of
utimensat(2) and futimens(2). In the recent POSIX.1-2024 (Issue 8)
specification, <utime.h> and utime(3p) were officially removed.

utimensat(2) operates on `struct timespec` rather than the second-only
`struct utimbuf`, allowing sub-second timestamp updates while also
providing support for UTIME_NOW and UTIME_OMIT flags to selectively
update or preserve individual access and modification timestamps.

Introduce a compatibility layer for utimensat(2):
- Provide fallback definitions for AT_FDCWD, UTIME_NOW, and UTIME_OMIT
  in case the system headers lack them.
- Introduce `ST_ATIME_NSEC(st)` to complement `ST_MTIME_NSEC(st)` and
  `ST_CTIME_NSEC(st)`.
- Implement `git_utimensat()` in `compat/utimensat.c` as a fallback using
  utimes(2) on platforms that define NO_UTIMENSAT.
- Implement `mingw_utimensat()` in `compat/mingw.c` converting `struct
  timespec` to Windows FILETIME with 100ns precision.
- Wire up NO_UTIMENSAT support in Makefile, meson.build,
  contrib/buildsystems/CMakeLists.txt, and configure.ac.

Subsequent commits will migrate callers across the codebase to
utimensat(2) and drop the legacy <utime.h> header.

Signed-off-by: Alexey Samsonov <vonosmas@gmail.com>
---
 Makefile                            |  6 ++++
 compat/mingw-posix.h                |  2 ++
 compat/mingw.c                      | 52 +++++++++++++++++++++++++----
 compat/posix.h                      | 21 ++++++++++++
 compat/utimensat.c                  | 39 ++++++++++++++++++++++
 configure.ac                        |  6 ++++
 contrib/buildsystems/CMakeLists.txt |  8 +++--
 meson.build                         |  2 ++
 8 files changed, 127 insertions(+), 9 deletions(-)
 create mode 100644 compat/utimensat.c

diff --git a/Makefile b/Makefile
index d4b775953d..64909d48b2 100644
--- a/Makefile
+++ b/Makefile
@@ -70,6 +70,8 @@ include shared.mak
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define NO_UTIMENSAT if you don't have utimensat.
+#
 # Define MKDIR_WO_TRAILING_SLASH if your mkdir() can't deal with trailing slash.
 #
 # Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
@@ -2049,6 +2051,10 @@ ifdef NO_WRITEV
 	COMPAT_CFLAGS += -DNO_WRITEV
 	COMPAT_OBJS += compat/writev.o
 endif
+ifdef NO_UTIMENSAT
+	COMPAT_CFLAGS += -DNO_UTIMENSAT
+	COMPAT_OBJS += compat/utimensat.o
+endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 2d989fd762..aab91d76db 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -386,6 +386,8 @@ int mingw_fstat(int fd, struct stat *buf);
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
+int mingw_utimensat(int fd, const char *path, const struct timespec times[2], int flag);
+#define utimensat mingw_utimensat
 size_t mingw_strftime(char *s, size_t max,
 		   const char *format, const struct tm *tm);
 #define strftime mingw_strftime
diff --git a/compat/mingw.c b/compat/mingw.c
index 4c2f26d454..d09a976191 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1391,22 +1391,33 @@ int mingw_fstat(int fd, struct stat *buf)
 	}
 }
 
-static inline void time_t_to_filetime(time_t t, FILETIME *ft)
+static inline void timespec_to_filetime(const struct timespec *ts, FILETIME *ft)
 {
-	long long winTime = t * 10000000LL + 116444736000000000LL;
+	long long winTime = (long long)ts->tv_sec * 10000000LL + (ts->tv_nsec / 100) + 116444736000000000LL;
 	ft->dwLowDateTime = winTime;
 	ft->dwHighDateTime = winTime >> 32;
 }
 
-int mingw_utime (const char *file_name, const struct utimbuf *times)
+int mingw_utimensat(int fd, const char *path, const struct timespec times[2], int flag)
 {
 	FILETIME mft, aft;
+	FILETIME *paft = &aft, *pmft = &mft;
 	int rc;
 	DWORD attrs;
 	wchar_t wfilename[MAX_PATH];
 	HANDLE osfilehandle;
 
-	if (xutftowcs_path(wfilename, file_name) < 0)
+	if (fd != AT_FDCWD) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if (flag) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if (xutftowcs_path(wfilename, path) < 0)
 		return -1;
 
 	/* must have write permission */
@@ -1433,14 +1444,25 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	}
 
 	if (times) {
-		time_t_to_filetime(times->modtime, &mft);
-		time_t_to_filetime(times->actime, &aft);
+		if (times[0].tv_nsec == UTIME_NOW)
+			GetSystemTimeAsFileTime(&aft);
+		else if (times[0].tv_nsec == UTIME_OMIT)
+			paft = NULL;
+		else
+			timespec_to_filetime(&times[0], &aft);
+
+		if (times[1].tv_nsec == UTIME_NOW)
+			GetSystemTimeAsFileTime(&mft);
+		else if (times[1].tv_nsec == UTIME_OMIT)
+			pmft = NULL;
+		else
+			timespec_to_filetime(&times[1], &mft);
 	} else {
 		GetSystemTimeAsFileTime(&mft);
 		aft = mft;
 	}
 
-	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
+	if (!SetFileTime(osfilehandle, NULL, paft, pmft)) {
 		errno = EINVAL;
 		rc = -1;
 	} else
@@ -1458,6 +1480,22 @@ revert_attrs:
 	return rc;
 }
 
+int mingw_utime(const char *file_name, const struct utimbuf *times)
+{
+	struct timespec ts[2];
+	struct timespec *tsp = NULL;
+
+	if (times) {
+		ts[0].tv_sec = times->actime;
+		ts[0].tv_nsec = 0;
+		ts[1].tv_sec = times->modtime;
+		ts[1].tv_nsec = 0;
+		tsp = ts;
+	}
+
+	return mingw_utimensat(AT_FDCWD, file_name, tsp, 0);
+}
+
 #undef strftime
 size_t mingw_strftime(char *s, size_t max,
 		      const char *format, const struct tm *tm)
diff --git a/compat/posix.h b/compat/posix.h
index 71cc731620..3cac1751aa 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -348,6 +348,24 @@ struct git_iovec {
 ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt);
 #endif
 
+#ifndef AT_FDCWD
+#define AT_FDCWD (-100)
+#endif
+#ifndef UTIME_NOW
+#define UTIME_NOW ((1L << 30) - 1L)
+#endif
+#ifndef UTIME_OMIT
+#define UTIME_OMIT ((1L << 30) - 2L)
+#endif
+
+#ifdef NO_UTIMENSAT
+#ifdef utimensat
+#undef utimensat
+#endif
+#define utimensat git_utimensat
+int git_utimensat(int fd, const char *path, const struct timespec times[2], int flag);
+#endif
+
 #ifdef NO_SETENV
 #define setenv gitsetenv
 int gitsetenv(const char *, const char *, int);
@@ -502,13 +520,16 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 
 #ifdef NO_NSEC
 #undef USE_NSEC
+#define ST_ATIME_NSEC(st) 0
 #define ST_CTIME_NSEC(st) 0
 #define ST_MTIME_NSEC(st) 0
 #else
 #ifdef USE_ST_TIMESPEC
+#define ST_ATIME_NSEC(st) ((unsigned int)((st).st_atimespec.tv_nsec))
 #define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
 #define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
 #else
+#define ST_ATIME_NSEC(st) ((unsigned int)((st).st_atim.tv_nsec))
 #define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
 #define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
 #endif
diff --git a/compat/utimensat.c b/compat/utimensat.c
new file mode 100644
index 0000000000..e4c8e8d0b6
--- /dev/null
+++ b/compat/utimensat.c
@@ -0,0 +1,39 @@
+#include "../git-compat-util.h"
+
+int git_utimensat(int fd, const char *path, const struct timespec times[2], int flag)
+{
+	struct timeval tv[2];
+	struct timeval *tvp = NULL;
+
+	if (fd != AT_FDCWD) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if (flag) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	if (times) {
+		for (int i = 0; i < 2; i++) {
+			if (times[i].tv_nsec == UTIME_NOW) {
+				struct timeval now;
+				gettimeofday(&now, NULL);
+				tv[i] = now;
+			} else if (times[i].tv_nsec == UTIME_OMIT) {
+				struct stat st;
+				if (stat(path, &st) < 0)
+					return -1;
+				tv[i].tv_sec = (i == 0) ? st.st_atime : st.st_mtime;
+				tv[i].tv_usec = (i == 0) ? ST_ATIME_NSEC(st) / 1000 : ST_MTIME_NSEC(st) / 1000;
+			} else {
+				tv[i].tv_sec = times[i].tv_sec;
+				tv[i].tv_usec = times[i].tv_nsec / 1000;
+			}
+		}
+		tvp = tv;
+	}
+
+	return utimes(path, tvp);
+}
diff --git a/configure.ac b/configure.ac
index cfb50112bf..a37a53f5b5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1146,6 +1146,12 @@ GIT_CHECK_FUNC(mkdtemp,
 [NO_MKDTEMP=YesPlease])
 GIT_CONF_SUBST([NO_MKDTEMP])
 #
+# Define NO_UTIMENSAT if you don't have utimensat in the C library.
+GIT_CHECK_FUNC(utimensat,
+[NO_UTIMENSAT=],
+[NO_UTIMENSAT=YesPlease])
+GIT_CONF_SUBST([NO_UTIMENSAT])
+#
 # Define NO_INITGROUPS if you don't have initgroups in the C library.
 GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=],
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8f56203f34..bb1d96802d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -380,9 +380,9 @@ set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
 	setenv mkdtemp poll pread memmem writev)
 
-#unsetenv,hstrerror are incompatible with windows build
+#unsetenv,hstrerror,utimensat are incompatible with windows build (provided by compat/mingw.c)
 if(NOT WIN32)
-	list(APPEND function_checks unsetenv hstrerror)
+	list(APPEND function_checks unsetenv hstrerror utimensat)
 endif()
 
 foreach(f ${function_checks})
@@ -428,6 +428,10 @@ if(NOT HAVE_WRITEV)
 endif()
 
 if(NOT WIN32)
+	if(NOT HAVE_UTIMENSAT)
+		list(APPEND compat_SOURCES compat/utimensat.c)
+	endif()
+
 	if(NOT HAVE_UNSETENV)
 		list(APPEND compat_SOURCES compat/unsetenv.c)
 	endif()
diff --git a/meson.build b/meson.build
index d86f2acd2b..a98f63a46c 100644
--- a/meson.build
+++ b/meson.build
@@ -1475,6 +1475,8 @@ else
     'unsetenv' : ['unsetenv.c'],
     # provided by compat/mingw.c.
     'getpagesize' : [],
+    # provided by compat/mingw.c.
+    'utimensat' : ['utimensat.c'],
   }
 
   if get_option('b_sanitize').contains('address') or get_option('b_sanitize').contains('leak')
-- 
gitgitgadget

