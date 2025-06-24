Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27F2D1907
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774130; cv=none; b=bD1+hEjRmf9b+B+XB2ZqsFdQ2m5qa3Q7JQv/l18+kClo5EjgxfC5Kzv9vr9w+cgYmSvV3X/ZEfWYXu+Ki++NC7AryaXBCxjla1tOnUDc+Q1lMxJduUvdHMjki5emZV//fcqgBotSkEdmV8qOG1km76sUrhd1xsCwIly5lnHjoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774130; c=relaxed/simple;
	bh=lD3BWCVKxECJIaPvq62Z94xR6GcjvJb2CU1AZv59zDM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OnIz3pB3/4CXhDthy7sYUafx3B6RRBB79y7+4Zj35CU1pj/4EHrysQR87G12opuSUbCBa0L/M9VO/Ly0vdezwYk9EBIMLY1PBprr85lxySemfLut91qsYrKrrqR0tj1t5HhlI7Y7Mq2QIdDoP3dJbhY2ZNWCx+wcPGUzMbd8z/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSvlPHN9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSvlPHN9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so36309355e9.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750774127; x=1751378927; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBDblChVKmAR5GXSYumLBycyvOR5TjcOKkQd5draCo4=;
        b=BSvlPHN9b6jctpzSk+KUuvueSUsSJKxn8alPH4quZJ4CwoAsDzgNlAM3wShS7o3385
         U6kQuPnd5YKF+csuL5vNu9wPwUJHSbZG7QjQnyMHSgnFRZPHobPswvw1VuaCbRvH6SAY
         OZOJ4eAJvrRUF4uoYL2qzcSjvbKg9GQ9whRvZdogrcx17sYU0FLPIWGbSUymUevkooMg
         e+vx2QtDg/CXqUWf3TXZ9wjzvSGYqJyNQN3Ttr5KRO/ncaZPAN0suYxuTbue73ALztQA
         7RW06jKrEgoMN1uApUyLQQwnHJIJjP06ikxhBMppTAtE87a05poUP5c5O+hi0rF1S9Ca
         2Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774127; x=1751378927;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBDblChVKmAR5GXSYumLBycyvOR5TjcOKkQd5draCo4=;
        b=Xl7WpjWelyl0rZ8+Ckwk/2qBy67F9lJM36s2gDCj805WvWokU8LIyYKy/qW4pdjRag
         81OSPMWfD4qOqnIBDeNAJbiJFVq/cEjQnQvlMNF9l3cxOJCtDla1dmpcQT+7VmiIcWLJ
         1u/vcS5mzFhe/TjNP74v37NOFw61V0YB2BQodEMN1ywO20KBxqUb5Gdu1gHxLcT7SjFf
         0OP/dDqbx6wkV5iN0r2XMtrvFiYASQZyii3rFDvLRZ1A2x1lKqUF1n9DyjX6JRkkvpMu
         fVAU38PKPFJxUUyFLNF5ilgGB7Zpo3aJcOQYHlEDnUgifd3FlB0+VaTSI9I5ak+EDwWV
         bVGA==
X-Gm-Message-State: AOJu0Yxvgsgoc64Ng50RiZw987HJdHPZeZa4GZ79J1DJU+dlhKiujvhD
	rVQu+0NFNmeLiS/jmZ5UPCU6ku2L/u4baMBhKtndngjMrIoN3fF6XIOQ5ogHUA==
X-Gm-Gg: ASbGnctnPXSUNz/X9qwF9X8/I/m/9ksMmx1athHUPKiZ8gGd0DsEXWFpQDi6AlWHFx6
	BpB3ICnjUl8vTlaLa/WDT294io7WXqz8/W7eqn/rs2gK8f5pqymiR4D0sZGVoA6QrLG2+uK/Fw1
	xFyQcxuKlHuiJuruK49VM6/iXb0Szc0MdmxnDl0pHtEERenZadS+DcbITJTUblMs6KkZ3x2lffe
	QMfeelo0he3w5lqV0IhhM56oeO/i8nebXxR7QfXYEhmMnenM0EZ5SO60RaDor3NSMchitzBbHoo
	2+M1nzO5DNjwOEUgT6GwM1BXcyapmhyC4BhGJ61PtCedghjLkDpu9OB0jY54GFvDeZ/QuD4nOA=
	=
X-Google-Smtp-Source: AGHT+IF1mgLdvzoVvaF9b85KzpPYKw5j5dXKHxO7zUeyV0/mN0qHUOmFFnyvHTG6/1iC4+eVG+9ZlQ==
X-Received: by 2002:a05:600c:a319:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-4537cd8e312mr24853745e9.14.1750774126329;
        Tue, 24 Jun 2025 07:08:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97adf3sm175241315e9.8.2025.06.24.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:08:45 -0700 (PDT)
Message-Id: <a450bdb0066912d135dd242090b012de0bc18180.1750774122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 14:08:42 +0000
Subject: [PATCH 3/3] daemon: explicitly allow EINTR during poll()
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
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

If the setup for the SIGCHLD signal handler sets SA_RESTART, poll()
might not return with -1 and set errno to EINTR when a signal is
received.

Since the logic to reap zombie childs relies om those interruptions
make sure to explicitly disable SA_RESTART around this function.

Add a Makefile flag for portability to systems that don't have the
functionality to change those flags or where it is not needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile         |  6 ++++++
 config.mak.uname |  4 ++++
 configure.ac     |  5 +++++
 daemon.c         | 26 ++++++++++++++++++++++----
 meson.build      |  1 +
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 70d1543b6b86..d489f94dc6f0 100644
--- a/Makefile
+++ b/Makefile
@@ -144,6 +144,9 @@ include shared.mak
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
+# Define NO_SIGINTERRUPT if you don't have siginterrupt() or SA_RESTART
+# or if your signal(SIGCHLD) implementation doesn't set SA_RESTART.
+#
 # Define NO_SETITIMER if you don't have setitimer()
 #
 # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
@@ -1902,6 +1905,9 @@ ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
 endif
+ifdef NO_SIGINTERRUPT
+	COMPAT_CFLAGS += -DNO_SIGINTERRUPT
+endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 52160ef5cb07..e824b45a4020 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -486,6 +486,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_INTTYPES_H = YesPlease
+	NO_SIGINTERRUPT = YesPlease
 	CSPRNG_METHOD = rtlgenrandom
 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
 	# so we don't need this:
@@ -661,6 +662,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_PREAD = YesPlease
 	NO_MMAP = YesPlease
 	NO_POLL = YesPlease
+	NO_SIGINTERRUPT = UnfortunatelyYes
 	NO_INTPTR_T = UnfortunatelyYes
 	CSPRNG_METHOD = openssl
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
@@ -697,6 +699,7 @@ ifeq ($(uname_S),MINGW)
 	NEEDS_LIBICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_SIGINTERRUPT = YesPlease
 	NO_SVN_TESTS = YesPlease
 
 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
@@ -791,4 +794,5 @@ ifeq ($(uname_S),QNX)
 	NO_PTHREADS = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
+	NO_SIGINTERRUPT = UnfortunatelyYes
 endif
diff --git a/configure.ac b/configure.ac
index f6caab919a3e..2abb2a32cd1e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1192,6 +1192,11 @@ GIT_CHECK_FUNC(getdelim,
 [HAVE_GETDELIM=])
 GIT_CONF_SUBST([HAVE_GETDELIM])
 #
+# Define NO_SIGINTERRUPT if you don't have siginterrupt.
+GIT_CHECK_FUNC(siginterrupt,
+[NO_SIGINTERRUPT=],
+[NO_SIGINTERRUPT=YesPlease])
+GIT_CONF_SUBST([NO_SIGINTERRUPT])
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
diff --git a/daemon.c b/daemon.c
index d870ad2f63c1..542e63822391 100644
--- a/daemon.c
+++ b/daemon.c
@@ -912,12 +912,16 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo UNUSED)
+static void child_handler(int signo)
 {
 	/*
-	 * Otherwise empty handler because systemcalls will get interrupted
-	 * upon signal receipt
+	 * Empty handler because systemcalls should get interrupted
+	 * upon signal receipt.
 	 */
+#ifdef NO_SIGINTERRUPT
+	/* SysV needs the handler to be rearmed */
+	signal(signo, child_handler);
+#endif
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1118,8 +1122,10 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 
 static int service_loop(struct socketlist *socklist)
 {
-	struct pollfd *pfd;
+#ifndef NO_SIGINTERRUPT
 	struct sigaction sa;
+#endif
+	struct pollfd *pfd;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
 
@@ -1128,14 +1134,22 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
+#ifdef NO_SIGINTERRUPT
+	signal(SIGCHLD, child_handler);
+#else
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
 	sa.sa_handler = child_handler;
 	sigaction(SIGCHLD, &sa, NULL);
+#endif
 
 	for (;;) {
 		check_dead_children();
 
+#ifndef NO_SIGINTERRUPT
+		sa.sa_flags &= ~SA_RESTART;
+		sigaction(SIGCHLD, &sa, NULL);
+#endif
 		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
@@ -1144,6 +1158,10 @@ static int service_loop(struct socketlist *socklist)
 			}
 			continue;
 		}
+#ifndef NO_SIGINTERRUPT
+		sa.sa_flags |= SA_RESTART;
+		sigaction(SIGCHLD, &sa, NULL);
+#endif
 
 		for (size_t i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
diff --git a/meson.build b/meson.build
index 7fea4a34d684..54942db151e8 100644
--- a/meson.build
+++ b/meson.build
@@ -1361,6 +1361,7 @@ checkfuncs = {
   'setenv' : ['setenv.c'],
   'mkdtemp' : ['mkdtemp.c'],
   'initgroups' : [],
+  'siginterrupt' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
 }
-- 
gitgitgadget
