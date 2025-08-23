Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFE25CC73
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955384; cv=none; b=BBysjVO/C+iOHQGBcYb/4KOd79WdE72F/IyPq4Iq9GoxmLHiBvKRRWR6t0o5a0FqDBRPd55VSTmyeuj/VaKnt+LgT/OYoJaYCXVtQA7XJs+asbMqnfxyrSPNNAj9rtV2xPTGKdYPJti2us4niFUV9c+YanhiOUMlGGu3HmbAp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955384; c=relaxed/simple;
	bh=5ZFDHy2UtWp+nCrp7zmLw/h39N6fiKKnCmP8rHNhw0E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=qkiE7ZPw7oq692awfSMsVdWPeC9BSvc/FX4HWKpZkmmPBvGi29MOrwFgngb674j9G9eUpkwX5TZNLglaB88UDksXP3HWUreme3Jb6m8qxcPApDR6qGru7HLuvD+sToFjOglPIuHzad+5DYJCY0qarVNKCuu/RGYMHP5V9N5MRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN1VkJqE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN1VkJqE"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so129436f8f.0
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755955380; x=1756560180; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHzS5Cybqhy1y3kjPn+/qk9QIk346Ybiky8YfPEQ43s=;
        b=iN1VkJqEh1RSubfyWt8s85gPz4553MDvkBvRklQAff5r+PjVl5ET1bs5XHwP0vys18
         yL8IXH0WOlCpkR+T+CH0j0hJuvrKIO4WUzDdpPmKRk4O0S2bV+1b9y08qrAwSgo+1GdP
         p1VElmgWYaO5Jlc0vLerZZENiZ+ORq99tX3MQr7FaoTS4cWxI5rS5jhAfUltMTB4KAIi
         arb7R9x+bfheqD8O78U767TGsOyuoakkJHGrpO+OmR302AjncffyvIEU0Op1dHpTTf9O
         t1oMwxHZXyZ7eqUE+6oJWGkzyx/QV4oRIwI9wiWTy/Wfo4PA6YXfKDVX1LmVnUvDEO+6
         DEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755955380; x=1756560180;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHzS5Cybqhy1y3kjPn+/qk9QIk346Ybiky8YfPEQ43s=;
        b=WxH8RAZtc23e4ha6HGLygFUAFQxA8Qy7my7KRJUM7+zYxX1RZ99vJHTqV80GInOtU0
         +aiPMNerQyiBze8ioY2bJKcqmFrujdAEzuje31IblFcFayOTRq3CbZuF08O6ovRkfBai
         efsYuf1VLN79L3frG9HSEYHufYvr/VexWPCEXoSSsYdT61LLHNwwgm1qw/boKE1+ukiF
         1ojbmU1w2SsFo145jWTjVLqN8nlF486x6CombSln0Qj3gpfL6rCwzpxEwSyuobORfenz
         7H2bjAgntmm11CDLLsbFXDzWBz2Fjl73LsqL04k6w8GnnW/VFgu9lXl8Ne/v49dH0eHO
         SB7Q==
X-Gm-Message-State: AOJu0YzBbm96Q5twHY/Kp8iqYbMKRpkYbU4bQZX1W+USm5ABfCqDWPuR
	lBWderpNNfbZMHC5ntjBy5uopPCfzChyRnKRALrDtoz2kImJWxKm/fbMr3UFyA==
X-Gm-Gg: ASbGncviB6aGeL3LFjs/qzDR6/7WUlE0gAvvoqGEPuKkJwMkcay9idI2GxHlKoMNUBi
	zpiAAqb+8PhH//OuZZtfTSXOUHPfO0RVP17uGg1bhz6IfX6Zg8LXo4T2D5b9yVjqWOZOrTyPh3p
	suC9+6XBQMZMFD2hl6+C5t55o7F0jyqCire5jbRfSdJEd9c9out+bBFaTw0E4b24kCK/8Z1Ma24
	Y42yJuTAAQlD52nClIUl2/5RefG+7EWYLheVqdpW+rakqj3OArLJnkCrRJYamu69Cgn5QXROTBC
	mah1Pqg1/ylICLDeQpb56GqL1oZpOvndxncI0RiLuEPueoFjEYGNag9zXGECnRc8yCfP4LBEkVq
	xwG4cxaq3fNTyMeWDAgW6otJshfo=
X-Google-Smtp-Source: AGHT+IEUGs7m56EnE3iN7S5wgnjSQ4DELCejLIGGS3AYN5UNCtcbNUj5udgAmirGcLb6PkhpE5SoWg==
X-Received: by 2002:a05:6000:26c2:b0:3c3:ae31:7183 with SMTP id ffacd0b85a97d-3c5dc734292mr3570342f8f.34.1755955379865;
        Sat, 23 Aug 2025 06:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5757378dsm34883835e9.15.2025.08.23.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:22:59 -0700 (PDT)
Message-Id: <493f69caddacea3f31e458fc5c5c1e151d28b6f3.1755955378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 13:22:56 +0000
Subject: [PATCH 1/2] progress: replace setitimer() with alarm()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>,
    Johannes Sixt <j6t@kdbg.org>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

setitimer() was marked obsolescent by IEEE Std 1003.1-2017 and is
no longer available in the latest edition.

While other alternatives of high fidelity are available, its use
in progress only requires whole second intervals, so it can be
cleanly replaced by a simpler alarm(); do that.

MinGW provided its own version of setitimer() so add an equivalent
implementation for alarm(), but do the minimum changes required in
the timer thread to adapt to the new interface.

Remove the compatibility layer for setitimer() and its related
struct that are no longer needed, and adjust the build system.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile             | 12 ------------
 compat/mingw-posix.h |  9 +--------
 compat/mingw.c       | 46 ++++++++++++++++----------------------------
 compat/posix.h       | 17 ----------------
 configure.ac         | 13 -------------
 meson.build          | 16 ---------------
 progress.c           | 11 +++--------
 7 files changed, 21 insertions(+), 103 deletions(-)

diff --git a/Makefile b/Makefile
index e11340c1ae77..059382624c0e 100644
--- a/Makefile
+++ b/Makefile
@@ -142,11 +142,6 @@ include shared.mak
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
-# Define NO_SETITIMER if you don't have setitimer()
-#
-# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
-# This also implies NO_SETITIMER
-#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -1888,13 +1883,6 @@ endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
-ifdef NO_STRUCT_ITIMERVAL
-	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
-	NO_SETITIMER = YesPlease
-endif
-ifdef NO_SETITIMER
-	COMPAT_CFLAGS += -DNO_SETITIMER
-endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 631a20868489..7626fbe90172 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -98,11 +98,6 @@ struct sigaction {
 #define SA_RESTART 0
 #define SA_NOCLDSTOP 1
 
-struct itimerval {
-	struct timeval it_value, it_interval;
-};
-#define ITIMER_REAL 0
-
 struct utsname {
 	char sysname[16];
 	char nodename[1];
@@ -131,8 +126,6 @@ static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
 static inline pid_t fork(void)
 { errno = ENOSYS; return -1; }
 #endif
-static inline unsigned int alarm(unsigned int seconds UNUSED)
-{ return 0; }
 static inline int fsync(int fd)
 { return _commit(fd); }
 static inline void sync(void)
@@ -183,6 +176,7 @@ char *mingw_locate_in_PATH(const char *cmd);
  * implementations of missing functions
  */
 
+unsigned alarm(unsigned seconds);
 int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
 int mkstemp(char *template);
@@ -193,7 +187,6 @@ struct tm *localtime_r(const time_t *timep, struct tm *result);
 #endif
 int getpagesize(void);	/* defined in MinGW's libgcc.a */
 struct passwd *getpwuid(uid_t uid);
-int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 int uname(struct utsname *buf);
diff --git a/compat/mingw.c b/compat/mingw.c
index 8538e3d1729d..199f68ca6d9a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2432,15 +2432,17 @@ static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
  * the thread to terminate by setting the timer_event to the signalled
  * state.
  * But ticktack() interrupts the wait state after the timer's interval
- * length to call the signal handler.
+ * length to call the signal handler if it still set.
  */
 
 static unsigned __stdcall ticktack(void *dummy UNUSED)
 {
+	sig_handler_t fn = timer_fn;
+
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
-		mingw_raise(SIGALRM);
-		if (one_shot)
+		if (one_shot || timer_fn != fn)
 			break;
+		mingw_raise(SIGALRM);
 	}
 	return 0;
 }
@@ -2478,37 +2480,23 @@ static void stop_timer_thread(void)
 	timer_thread = NULL;
 }
 
-static inline int is_timeval_eq(const struct timeval *i1, const struct timeval *i2)
+unsigned alarm(unsigned seconds)
 {
-	return i1->tv_sec == i2->tv_sec && i1->tv_usec == i2->tv_usec;
-}
-
-int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
-{
-	static const struct timeval zero;
-	static int atexit_done;
-
-	if (out)
-		return errno = EINVAL,
-			error("setitimer param 3 != NULL not implemented");
-	if (!is_timeval_eq(&in->it_interval, &zero) &&
-	    !is_timeval_eq(&in->it_interval, &in->it_value))
-		return errno = EINVAL,
-			error("setitimer: it_interval must be zero or eq it_value");
-
-	if (timer_thread)
-		stop_timer_thread();
+	static bool atexit_done;
 
-	if (is_timeval_eq(&in->it_value, &zero) &&
-	    is_timeval_eq(&in->it_interval, &zero))
-		return 0;
-
-	timer_interval = in->it_value.tv_sec * 1000 + in->it_value.tv_usec / 1000;
-	one_shot = is_timeval_eq(&in->it_interval, &zero);
 	if (!atexit_done) {
 		atexit(stop_timer_thread);
-		atexit_done = 1;
+		atexit_done = true;
 	}
+
+	timer_interval = seconds * 1000;
+	one_shot = !seconds;
+	if (timer_thread) {
+		if (!seconds)
+			stop_timer_thread();
+		return 0;
+	}
+
 	return start_timer_thread();
 }
 
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b83..83af92d820f2 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -198,23 +198,6 @@ static inline time_t git_time(time_t *tloc)
 }
 #define time git_time
 
-#ifdef NO_STRUCT_ITIMERVAL
-struct itimerval {
-	struct timeval it_interval;
-	struct timeval it_value;
-};
-#endif
-
-#ifdef NO_SETITIMER
-static inline int git_setitimer(int which UNUSED,
-				const struct itimerval *value UNUSED,
-				struct itimerval *newvalue UNUSED) {
-	return 0; /* pretend success */
-}
-#undef setitimer
-#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
-#endif
-
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
diff --git a/configure.ac b/configure.ac
index cfb50112bf81..6b04aa37a82c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -872,13 +872,6 @@ case $ac_cv_type_socklen_t in
 esac
 GIT_CONF_SUBST([SOCKLEN_T])
 
-#
-# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval.
-AC_CHECK_TYPES([struct itimerval],
-[NO_STRUCT_ITIMERVAL=],
-[NO_STRUCT_ITIMERVAL=UnfortunatelyYes],
-[#include <sys/time.h>])
-GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
 #
 # Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exists.
 # Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor
@@ -1097,12 +1090,6 @@ GIT_CHECK_FUNC(sync_file_range,
 	[HAVE_SYNC_FILE_RANGE=])
 GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
 
-#
-# Define NO_SETITIMER if you don't have setitimer.
-GIT_CHECK_FUNC(setitimer,
-[NO_SETITIMER=],
-[NO_SETITIMER=YesPlease])
-GIT_CONF_SUBST([NO_SETITIMER])
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
diff --git a/meson.build b/meson.build
index 5dd299b4962d..f33f20312511 100644
--- a/meson.build
+++ b/meson.build
@@ -1348,22 +1348,6 @@ else
     error('Native regex support requested but not found')
 endif
 
-# setitimer and friends are provided by compat/mingw.c.
-if host_machine.system() != 'windows'
-  if not compiler.compiles('''
-    #include <sys/time.h>
-    void func(void)
-    {
-      struct itimerval value;
-    }
-  ''', name: 'struct itimerval')
-    libgit_c_args += '-DNO_STRUCT_ITIMERVAL'
-    libgit_c_args += '-DNO_SETITIMER'
-  elif not compiler.has_function('setitimer')
-    libgit_c_args += '-DNO_SETITIMER'
-  endif
-endif
-
 if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: '#include <sys/stat.h>')
   libgit_c_args += '-DUSE_ST_TIMESPEC'
 elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix: '#include <sys/stat.h>')
diff --git a/progress.c b/progress.c
index 8d5ae70f3a9e..71b305d1625d 100644
--- a/progress.c
+++ b/progress.c
@@ -67,12 +67,12 @@ void progress_test_force_update(void)
 static void progress_interval(int signum UNUSED)
 {
 	progress_update = 1;
+	alarm(1);
 }
 
 static void set_progress_signal(void)
 {
 	struct sigaction sa;
-	struct itimerval v;
 
 	if (progress_testing)
 		return;
@@ -85,20 +85,15 @@ static void set_progress_signal(void)
 	sa.sa_flags = SA_RESTART;
 	sigaction(SIGALRM, &sa, NULL);
 
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
+	alarm(1);
 }
 
 static void clear_progress_signal(void)
 {
-	struct itimerval v = {{0,},};
-
 	if (progress_testing)
 		return;
 
-	setitimer(ITIMER_REAL, &v, NULL);
+	alarm(0);
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
 }
-- 
gitgitgadget

