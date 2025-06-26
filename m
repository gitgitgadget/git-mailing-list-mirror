Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBD2957A9
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927994; cv=none; b=I1sCM5XMcKFHS9qVi8h7QxwaD73/uvKX0ht04Rert34o3jfVwftdAvb7BDNsO+DnUUTSnGE+aPxHu0DMyP0mDuK0yBzMaV8Zu/ka3678Ci0dXNOZwhpfFTojxw9n9CAP1cSGpKXCtPwFDCFR8yijYj/0iaTCsHRiKCw9viGOh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927994; c=relaxed/simple;
	bh=4+kzV610WHle1hIZJ/I4WgM5Wly/hERsZhTt1JFpYug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=pMV/VGHZTHt7dq59TyPTHHHykSPEfmOByLVH8PTvdOILpNo+xW7Bpntnsvql1G5HMuw9xxfimbtae8og+aMCRRM/xzEobf4YJp+EM6N4LTYIld+Gj3hb7BsfaePkzfgX9S53TKr4ev/+sNR3Zx6AHslnpjgExiHyWhzXOwufuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJDi2YYN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJDi2YYN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453749af004so3651075e9.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927991; x=1751532791; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhsJQ/tHqmNQLr0TJ3e9p34SG8c3RmLmqCl1i1UpDxk=;
        b=hJDi2YYNuHLuaoKuHXUNxXBYGJ1yTCODErJHSAxBPMlOAonwr3B8Y/QPEIU4SNfssd
         xVsJZH7gFNowZMpFJq3jqjXTJNOGNDeD1AtJxlvHDy0N8J8cbTH/5gT0F0oAk+FCuILr
         vSJgLK+tB495EcQ32jEJqb5zpQkREHnPqd/hEix5YxeszqdCgG/Hg4JY8F0jP4C1958w
         UcPRbNH3V//Kq5DHGpp4eVOB35vgOBsgtD3Jl8y7K0S1YRMhqhiiXZ0jKnLf/fLQ518z
         MKebuRcAyTaEKjFZVV37z2Y4zf+0BZxJ1tYs8tLj2flZasDUh5vpvZsDx9KnJYdrteWR
         E4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927991; x=1751532791;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhsJQ/tHqmNQLr0TJ3e9p34SG8c3RmLmqCl1i1UpDxk=;
        b=iJH3OEh8NqWznQUEB/fpoLUQl3Wu8JDV4JFYm/5ZX8DO3Pp8ssy5C99ezlJc+a/eCk
         KAA0038+JaZ7g4vrEN+Gn+5bIDwJ64Yebhxg/R0gNEPIc4svvk/FuCdeOXp2qNbe7kMI
         6vTjRPTEAohIUd3We6pP0BFjC02LElYPzESV8HbwJLSdaHXEtYf22RHMPyu4v+ve0OBN
         h/4KlsPekX5swZFIt/WszsIEB3N2OTBZTnKZmDer7o3jKo4nB8xkp+ndEFEXXvs8y+6A
         NWQVzFJDlO2PVI2T++iBx1G9rveOkMX/vZLOO7jM/lnlGhTKfxktB8DnHq9PMhkD9moZ
         NdUw==
X-Gm-Message-State: AOJu0YwX+A6kNuPkDOg11/8ArBrWoHjAA2F2tso9lvOT0B9RmPeBAJ8F
	X4u9DcKdya2V0EUCvSycpnlE8J3zYwKkr958iDXdAKR+vwNPa6WGGUR60TU9Xg==
X-Gm-Gg: ASbGncs4SPMazNcmF5Lnl+FBYM/YUN7Rsj43tfVs7Aumhmz5yfc1bWFnYmaUhER9vog
	OV8UxpgTGMXuoeo/kvszuZEeudSPB6NRFbXe+dc6IYAqdLtZaHa2e2uj8T4LOZJRNaMTE3y/u+k
	DJG5ZqtZc8BcPGm5PI4dJ1vdG2wx0CPxf1IjM3t1V2zd8l/GeemFxJWvs0D8oPTJE71DiFDGojR
	WSK2GOxSAqK6VSEg1kvLXPt1+0RolZiyDM66zSiG8hBj9YOB4xoY8p4mPa9djoByTr8lpAc20FT
	RDX++/niCCn/mN+NyXkbocxZWPnOGnjbpa2ShMhtN+IeosUyY3MNfnpkDomt+VA=
X-Google-Smtp-Source: AGHT+IHi2VcdDlKivV5BZwrU2HVKysup1aiL/OfQ4hMF2c8eKeEaI8LNGVyMpJ8ac2b9MgmJ+PxCrg==
X-Received: by 2002:a5d:584a:0:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3a6ed601d8emr5267461f8f.26.1750927990400;
        Thu, 26 Jun 2025 01:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805112asm6768007f8f.9.2025.06.26.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:53:09 -0700 (PDT)
Message-Id: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 08:53:04 +0000
Subject: [PATCH v3 0/4] daemon: explicitly allow EINTR during poll()
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
    Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>

This series addresses and ambiguity that is at least visible in OpenBSD,
where zombie proceses would only be cleared after a new connection is
received.

The underlying problem is that when this code was originally introduced,
SA_RESTART was not widely implemented, and the signal() call usually
implemented SysV like semantics, at least until it started being
reimplemented by calling sigaction() internally.

Changes since v2

 * Add a new patch 2 that modifies windows' sigaction so there is no more
   need for a fallback
 * Hopefully no more silly mistakes and a variable that finally makes sense

Changes since v1

 * Almost all references to siginterrupt has been removed and a better named
   variable used instead
 * Changes had been abstracted to minimize ifdefs and their introduction
   staged more naturally

Carlo Marcelo Arenas Belón (4):
  compat/posix.h: track SA_RESTART fallback
  compat/mingw: allow sigaction(SIGCHLD)
  daemon: use sigaction() to install child_handler()
  daemon: explicitly allow EINTR during poll()

 Makefile             |  5 +++++
 compat/mingw-posix.h |  2 +-
 compat/mingw.c       |  4 +++-
 compat/posix.h       |  8 ++++++++
 config.mak.uname     |  7 ++++---
 configure.ac         | 16 ++++++++++++++++
 daemon.c             | 33 ++++++++++++++++++++++++++++-----
 meson.build          |  4 ++++
 8 files changed, 69 insertions(+), 10 deletions(-)


base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v3
Pull-Request: https://github.com/git/git/pull/2002

Range-diff vs v2:

 1:  e82b7425bbc ! 1:  ae1ca6bb2b2 compat/posix.h: track SA_RESTART fallback
     @@ Makefile: include shared.mak
       # when attempting to read from an fopen'ed directory (or even to fopen
       # it at all).
       #
     -+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
     -+# prefer to use ANSI C signal() over POSIX sigaction()
     ++# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
      +#
       # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
       # when a signal is received (as opposed to restarting).
     @@ Makefile: ifdef FREAD_READS_DIRECTORIES
       	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
       	COMPAT_OBJS += compat/fopen.o
       endif
     -+ifdef USE_NON_POSIX_SIGNAL
     -+	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
     ++ifdef NO_RESTARTABLE_SIGNALS
     ++	COMPAT_CFLAGS += -DNO_RESTARTABLE_SIGNALS
      +endif
       ifdef OPEN_RETURNS_EINTR
       	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
     @@ compat/posix.h: char *gitdirname(char *);
      + * not on some systems (e.g. NonStop, QNX).
      + */
      +#ifndef SA_RESTART
     -+# define SA_RESTART 0	/* disabled for sigaction() */
     ++# define SA_RESTART 0 /* disabled for sigaction() */
      +#endif
      +
       typedef uintmax_t timestamp_t;
     @@ config.mak.uname: ifeq ($(uname_S),Windows)
       	NO_STRTOUMAX = YesPlease
       	NO_MKDTEMP = YesPlease
       	NO_INTTYPES_H = YesPlease
     -+	USE_NON_POSIX_SIGNAL = YesPlease
     ++	NO_RESTARTABLE_SIGNALS = YesPlease
       	CSPRNG_METHOD = rtlgenrandom
       	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
       	# so we don't need this:
     @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
       	NO_MMAP = YesPlease
       	NO_POLL = YesPlease
       	NO_INTPTR_T = UnfortunatelyYes
     -+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
     ++	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
       	CSPRNG_METHOD = openssl
       	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
       	SHELL_PATH = /usr/coreutils/bin/bash
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
       	NEEDS_LIBICONV = YesPlease
       	NO_STRTOUMAX = YesPlease
       	NO_MKDTEMP = YesPlease
     -+	USE_NON_POSIX_SIGNAL = YesPlease
     ++	NO_RESTARTABLE_SIGNALS = YesPlease
       	NO_SVN_TESTS = YesPlease
       
       	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
     @@ config.mak.uname: ifeq ($(uname_S),QNX)
       	NO_PTHREADS = YesPlease
       	NO_STRCASESTR = YesPlease
       	NO_STRLCPY = YesPlease
     -+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
     ++	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
       endif
      
       ## configure.ac ##
     @@ configure.ac: fi
       GIT_CONF_SUBST([ICONV_OMITS_BOM])
       fi
       
     -+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
     -+# prefer using ANSI C signal() over POSIX sigaction()
     ++# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
      +
      +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
      +	AC_COMPILE_IFELSE(
      +		[AC_LANG_PROGRAM([#include <signal.h>], [[
     -+		#ifdef SA_RESTART
     -+		#endif
     -+		siginterrupt(SIGCHLD, 1)
     -+		]])],[ac_cv_siginterrupt=yes],[
     ++			#ifdef SA_RESTART
     ++			restartable signals supported
     ++			#endif
     ++		]])],[
      +			ac_cv_siginterrupt=no
     -+			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
     -+		]
     ++			NO_RESTARTABLE_SIGNALS=UnfortunatelyYes
     ++		], [ac_cv_siginterrupt=yes]
      +	)
      +])
     -+GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
     ++GIT_CONF_SUBST([NO_RESTARTABLE_SIGNALS])
      +
       ## Checks for typedefs, structures, and compiler characteristics.
       AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
     @@ meson.build: else
       endif
       
      +if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
     -+  libgit_c_args += '-DUSE_NON_POSIX_SIGNAL'
     ++  libgit_c_args += '-DNO_RESTARTABLE_SIGNALS'
      +endif
      +
       if not compiler.has_header('sys/select.h')
 -:  ----------- > 2:  3f63479119f compat/mingw: allow sigaction(SIGCHLD)
 2:  05d945aa1e5 ! 3:  c66bda461f4 daemon: use sigaction() to install child_handler()
     @@ Commit message
          In a future change, the flags used for processing SIGCHLD will need to
          be updated, which is only possible by using sigaction().
      
     -    Factor out the call to set the signal handler and use sigaction instead
     -    of signal for the systems that allow that, which has the added benefit
     -    of using BSD semantics reliably and therefore not needing the rearming
     -    call.
     +    Replace signal() with an equivalent invocation of sigaction(), which
     +    has the added benefit of using BSD semantics reliably and therefore
     +    not needing the rearming call in the signal handler.
      
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
       ## daemon.c ##
      @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
     - 		add_child(&cld, addr, addrlen);
     - }
     - 
     --static void child_handler(int signo UNUSED)
     -+static void child_handler(int signo MAYBE_UNUSED)
     + static void child_handler(int signo UNUSED)
       {
       	/*
      -	 * Otherwise empty handler because systemcalls will get interrupted
     @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addr
      +	 * upon signal receipt.
       	 */
      -	signal(SIGCHLD, child_handler);
     -+#ifdef USE_NON_POSIX_SIGNAL
     -+	/*
     -+	 * SysV needs the handler to be rearmed, but this is known
     -+	 * to trigger infinite recursion crashes at least in AIX.
     -+	 */
     -+	signal(signo, child_handler);
     -+#endif
       }
       
       static int set_reuse_addr(int sockfd)
      @@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
     - 	}
     - }
       
     -+#ifndef USE_NON_POSIX_SIGNAL
     -+
     -+static void set_signal_handler(struct sigaction *psa)
     -+{
     -+	sigemptyset(&psa->sa_mask);
     -+	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
     -+	psa->sa_handler = child_handler;
     -+	sigaction(SIGCHLD, psa, NULL);
     -+}
     -+
     -+#else
     -+
     -+static void set_signal_handler(struct sigaction *psa UNUSED)
     -+{
     -+	signal(SIGCHLD, child_handler);
     -+}
     -+
       static int service_loop(struct socketlist *socklist)
       {
      +	struct sigaction sa;
     @@ daemon.c: static int service_loop(struct socketlist *socklist)
       	}
       
      -	signal(SIGCHLD, child_handler);
     -+	set_signal_handler(&sa);
     ++	sigemptyset(&sa.sa_mask);
     ++	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
     ++	sa.sa_handler = child_handler;
     ++	sigaction(SIGCHLD, &sa, NULL);
       
       	for (;;) {
       		check_dead_children();
 3:  b737e0389df ! 4:  851d663be0b daemon: explicitly allow EINTR during poll()
     @@ Commit message
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
       ## daemon.c ##
     -@@ daemon.c: static void set_signal_handler(struct sigaction *psa)
     - 	sigaction(SIGCHLD, psa, NULL);
     +@@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
     + 	}
       }
       
     ++#ifndef NO_RESTARTABLE_SIGNALS
     ++
      +static void set_sa_restart(struct sigaction *psa, int enable)
      +{
      +	if (enable)
     @@ daemon.c: static void set_signal_handler(struct sigaction *psa)
      +	sigaction(SIGCHLD, psa, NULL);
      +}
      +
     - #else
     - 
     - static void set_signal_handler(struct sigaction *psa UNUSED)
     -@@ daemon.c: static void set_signal_handler(struct sigaction *psa UNUSED)
     - 	signal(SIGCHLD, child_handler);
     - }
     - 
     ++#else
     ++
      +static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
      +{
      +}

-- 
gitgitgadget
