Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E679A27CB02
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840774; cv=none; b=KISENinPSeB8wZlLgHRWcZcSlB7m5dl1kdSTvdScEAAcGnA4gHOVwsewOcqkuWtBvSnT9WTKW0iiwKWsSXrSZuUug0wsjtOHyoyCsAUGauLZqsTJfG/NN+pCE2p+aKLIO6f2hw61hXP5udhEK3jw173tK6w4kYWueMeSJvOBYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840774; c=relaxed/simple;
	bh=E2MNk22Fw5IEPHrI6l2pfUdNgs7gYtvr4YvgrIZuDzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBcNz/WE+2iV9+KBnZR0+Y3Gs0p6Yl6PhBoc3CF0II6ACIP7ybmrLtHo2VHqVkDGqmm6gR+gPJRsVFf6gtngh+vWFwPIwaD/UiXMjH44zol+rh5ROWtxaJ+uU3h+QRhiPfzkjhniMeXsb8c+LE97tKDsngjfq0mM0zK2JhPcilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qjm/a0aX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qjm/a0aX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450dd065828so10903715e9.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750840769; x=1751445569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0hfwTeaWaH74VCVDaPre7k5M4rEdMcCV/hTI7LZ8OD0=;
        b=Qjm/a0aXqGoyjoapRqRLH+9sGThxX1rx12GErSR1jftJ6S3yxxFVceqIQeipUE0mao
         cu1IfkYEsTNI7SMO3YthrP+zokizED4amFU6nWTG1/t4jEIuMChmdtBD2JN2rH/GOo/N
         tUv2Rs7YQzUMqCH5tqlZVSLPQ/rW0NzCvG+nIhdXv/fROfLggepzA+tlnRkD/L/fbW2O
         W+NOhcCPgK5SejpDvK11U9Oq+pY2o4R7iDSMFKQZaev5rs3bqt/ZyMxI2HsjMwBQxSdG
         phA/WVnM+uKfK63ZwPknzkFk3miioqM6KgjHXWcjsh3GbfCOIYX63xGkkQJD/jak4WJJ
         pbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750840769; x=1751445569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hfwTeaWaH74VCVDaPre7k5M4rEdMcCV/hTI7LZ8OD0=;
        b=ORcSDco6vZGgfonZ34hsBRi9n+7l6WsF5did/zwvI9vdJQ0IMw6He76+Rm7IdbgBEq
         zHp9tXVwPvlhC26enywKt0d77GIUAk9b7iuyKZ+sMIlyKaR26XDy73RCh3LiNmvZMmUr
         OkVNxEav2zsCXLSvVv3LnPzRCwLvjhCATYrBU/QdHImsmqkS7fg4FjI9W3z+1K76eRvb
         w8rpBuKDMbccJOWpPT3VPh7o3rsdxlvDpMduPnEM5KcoYcQaQdTzrwe+bhkeb1r1GC27
         nomPSjPa5GkZhbMv7A/80Cz7Z1ouZ8FODTe/Zno2wiQTrGmV9tm84ZwVbF2XXOc3/uSf
         sYRA==
X-Forwarded-Encrypted: i=1; AJvYcCWiwkV7wUmwP3pvMMWcm5y9dXOZBOqVxsTCHxk6g3Bb6ElK43i4/gDTtIUIpUtnpVI8ad4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnNsRO6WOQJByNfvTf6IJrpsOoHTKUg721zp6fzC9I4HSnu09
	ZDUpKkK+LuDJu3AaAZua+KBvcmex5VHb5w427Xhw/O5tpMiN69lYpEcFvxQIHQ==
X-Gm-Gg: ASbGncvH3wXnGtDsHEAEipZNyX3BpEY70U1hsX0NmObATHH2gtUds6RBdWGcX0A6pkS
	yEmEhQbuzk9CMtpCOXVZehdBQ8N7cRf2lReWDRQypwXhFgnb7SwJo9lTK7CXVZdt9lpdOKSlOMd
	vWhppBM7FsZIw/QjVHEFLVUED5smBPB6zaFBp5MlORPRcBzM3X9H0r/we/11UBjVQ4lLwhV977x
	/8TQLGgBspflTyspVj33TW2s3pcj8OPGRDsOcmrsYOi+0NL/neLCaqbybp3Kcf9v0kURjufgpJe
	fARR2bzcBaxSEuO3WLv+AfmIAbXxwBeoCtVFN9BeIKqIth51uN2gv+wPRZ2uIV0s6bDI9SSM2w+
	FjIW7/vhOkzQNAL31Y/YCEzHMi0+bsO/R4d42Cw==
X-Google-Smtp-Source: AGHT+IFMxp57aH2QxYu7gqg1uFKEW12oOSVB/3KuPAaDpfZDVaS7YZcHVsDwOMD4OtLyipdw3uM8rA==
X-Received: by 2002:a05:600c:1e1e:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-45381b0632dmr20784515e9.31.1750840768773;
        Wed, 25 Jun 2025 01:39:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6c21sm12739475e9.29.2025.06.25.01.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:39:28 -0700 (PDT)
Message-ID: <907a79d1-da2e-4c8e-963f-05c6e313643f@gmail.com>
Date: Wed, 25 Jun 2025 09:39:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] daemon: explicitly allow EINTR during poll()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 08:35, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> This series addresses and ambiguity that is at least visible in OpenBSD,
> where zombie proceses would only be cleared after a new connection is
> received.

There is still a race where a child that exits after it has been checked 
in check_dead_children() but before we call poll() will not be collected 
until a new connection is received or a child exits while we're polling. 
If we used the self-pipe trick described on the select(2) man page [1] 
we would avoid that race and would not need to mess with SA_RESTART and 
so would not need to introduce USE_NON_POSIX_SIGNAL.

Best Wishes

Phillip

[1] https://www.man7.org/linux/man-pages/man2/select.2.html
> The underlying problem is that when this code was originally introduced,
> SA_RESTART was not widely implemented, and the signal() call usually
> implemented SysV like semantics, at least until it started being
> reimplemented by calling sigaction() internally.
> 
> Changes since v1
> 
>   * Almost all references to siginterrupt has been removed and a better named
>     variable used instead
>   * Changes had been anstracted to minimize ifdefs and their introduction
>     staged more naturally
> 
> Carlo Marcelo Arenas Belón (3):
>    compat/posix.h: track SA_RESTART fallback
>    daemon: use sigaction() to install child_handler()
>    daemon: explicitly allow EINTR during poll()
> 
>   Makefile             |  6 +++++
>   compat/mingw-posix.h |  1 -
>   compat/posix.h       |  8 +++++++
>   config.mak.uname     |  7 +++---
>   configure.ac         | 17 +++++++++++++++
>   daemon.c             | 52 +++++++++++++++++++++++++++++++++++++++-----
>   meson.build          |  4 ++++
>   7 files changed, 85 insertions(+), 10 deletions(-)
> 
> 
> base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v2
> Pull-Request: https://github.com/git/git/pull/2002
> 
> Range-diff vs v1:
> 
>   1:  2b5a58e53ac ! 1:  e82b7425bbc compat/posix.h: track SA_RESTART fallback
>       @@ Metadata
>         ## Commit message ##
>            compat/posix.h: track SA_RESTART fallback
>        
>       -    Systems without SA_RESTART where using custom CFLAGS instead of
>       -    the standard header file.
>       +    Systems without SA_RESTART are using custom CFLAGS or headers
>       +    instead of the standard header file.
>        
>       -    Consolidate that, so it will be easier to use in a future commit.
>       +    Correct that, and invent a Makefile variable to track the
>       +    exceptions which will become handy in the next commits.
>        
>            Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>        
>       + ## Makefile ##
>       +@@ Makefile: include shared.mak
>       + # when attempting to read from an fopen'ed directory (or even to fopen
>       + # it at all).
>       + #
>       ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>       ++# prefer to use ANSI C signal() over POSIX sigaction()
>       ++#
>       + # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
>       + # when a signal is received (as opposed to restarting).
>       + #
>       +@@ Makefile: ifdef FREAD_READS_DIRECTORIES
>       + 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
>       + 	COMPAT_OBJS += compat/fopen.o
>       + endif
>       ++ifdef USE_NON_POSIX_SIGNAL
>       ++	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
>       ++endif
>       + ifdef OPEN_RETURNS_EINTR
>       + 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
>       + endif
>       +
>       + ## compat/mingw-posix.h ##
>       +@@ compat/mingw-posix.h: struct sigaction {
>       + 	sig_handler_t sa_handler;
>       + 	unsigned sa_flags;
>       + };
>       +-#define SA_RESTART 0
>       +
>       + struct itimerval {
>       + 	struct timeval it_value, it_interval;
>       +
>         ## compat/posix.h ##
>        @@ compat/posix.h: char *gitdirname(char *);
>         #define NAME_MAX 255
>         #endif
>         
>       -+/* On most systems <signal.h> would have given us this, but
>       ++/*
>       ++ * On most systems <signal.h> would have given us this, but
>        + * not on some systems (e.g. NonStop, QNX).
>        + */
>        +#ifndef SA_RESTART
>       -+#define SA_RESTART 0	/* disabled for sigaction() */
>       ++# define SA_RESTART 0	/* disabled for sigaction() */
>        +#endif
>        +
>         typedef uintmax_t timestamp_t;
>       @@ compat/posix.h: char *gitdirname(char *);
>         #define parse_timestamp strtoumax
>        
>         ## config.mak.uname ##
>       +@@ config.mak.uname: ifeq ($(uname_S),Windows)
>       + 	NO_STRTOUMAX = YesPlease
>       + 	NO_MKDTEMP = YesPlease
>       + 	NO_INTTYPES_H = YesPlease
>       ++	USE_NON_POSIX_SIGNAL = YesPlease
>       + 	CSPRNG_METHOD = rtlgenrandom
>       + 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
>       + 	# so we don't need this:
>        @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
>         	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>         
>       @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
>         	# Apparently needed in compat/fnmatch/fnmatch.c.
>         	COMPAT_CFLAGS += -DHAVE_STRING_H=1
>         	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>       +@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
>       + 	NO_MMAP = YesPlease
>       + 	NO_POLL = YesPlease
>       + 	NO_INTPTR_T = UnfortunatelyYes
>       ++	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
>       + 	CSPRNG_METHOD = openssl
>       + 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>       + 	SHELL_PATH = /usr/coreutils/bin/bash
>       +@@ config.mak.uname: ifeq ($(uname_S),MINGW)
>       + 	NEEDS_LIBICONV = YesPlease
>       + 	NO_STRTOUMAX = YesPlease
>       + 	NO_MKDTEMP = YesPlease
>       ++	USE_NON_POSIX_SIGNAL = YesPlease
>       + 	NO_SVN_TESTS = YesPlease
>       +
>       + 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
>        @@ config.mak.uname: ifeq ($(uname_S),MINGW)
>                 endif
>         endif
>       @@ config.mak.uname: ifeq ($(uname_S),MINGW)
>         	EXPAT_NEEDS_XMLPARSE_H = YesPlease
>         	HAVE_STRINGS_H = YesPlease
>         	NEEDS_SOCKET = YesPlease
>       +@@ config.mak.uname: ifeq ($(uname_S),QNX)
>       + 	NO_PTHREADS = YesPlease
>       + 	NO_STRCASESTR = YesPlease
>       + 	NO_STRLCPY = YesPlease
>       ++	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
>       + endif
>       +
>       + ## configure.ac ##
>       +@@ configure.ac: fi
>       + GIT_CONF_SUBST([ICONV_OMITS_BOM])
>       + fi
>       +
>       ++# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>       ++# prefer using ANSI C signal() over POSIX sigaction()
>       ++
>       ++AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
>       ++	AC_COMPILE_IFELSE(
>       ++		[AC_LANG_PROGRAM([#include <signal.h>], [[
>       ++		#ifdef SA_RESTART
>       ++		#endif
>       ++		siginterrupt(SIGCHLD, 1)
>       ++		]])],[ac_cv_siginterrupt=yes],[
>       ++			ac_cv_siginterrupt=no
>       ++			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
>       ++		]
>       ++	)
>       ++])
>       ++GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
>       ++
>       + ## Checks for typedefs, structures, and compiler characteristics.
>       + AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
>       + #
>       +
>       + ## meson.build ##
>       +@@ meson.build: else
>       +   build_options_config.set('NO_EXPAT', '1')
>       + endif
>       +
>       ++if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
>       ++  libgit_c_args += '-DUSE_NON_POSIX_SIGNAL'
>       ++endif
>       ++
>       + if not compiler.has_header('sys/select.h')
>       +   libgit_c_args += '-DNO_SYS_SELECT_H'
>       + endif
>   2:  2e8c4643a60 ! 2:  05d945aa1e5 daemon: use sigaction() to install child_handler()
>       @@ Commit message
>            In a future change, the flags used for processing SIGCHLD will need to
>            be updated, which is only possible by using sigaction().
>        
>       -    Replace the call, which hs the added benefit of using BSD semantics
>       -    reliably and therefore not needing the rearming call.
>       +    Factor out the call to set the signal handler and use sigaction instead
>       +    of signal for the systems that allow that, which has the added benefit
>       +    of using BSD semantics reliably and therefore not needing the rearming
>       +    call.
>        
>            Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>        
>         ## daemon.c ##
>       -@@ daemon.c: static void child_handler(int signo UNUSED)
>       +@@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>       + 		add_child(&cld, addr, addrlen);
>       + }
>       +
>       +-static void child_handler(int signo UNUSED)
>       ++static void child_handler(int signo MAYBE_UNUSED)
>       + {
>         	/*
>       - 	 * Otherwise empty handler because systemcalls will get interrupted
>       - 	 * upon signal receipt
>       +-	 * Otherwise empty handler because systemcalls will get interrupted
>       +-	 * upon signal receipt
>        -	 * SysV needs the handler to be rearmed
>       ++	 * Otherwise empty handler because systemcalls should get interrupted
>       ++	 * upon signal receipt.
>         	 */
>        -	signal(SIGCHLD, child_handler);
>       ++#ifdef USE_NON_POSIX_SIGNAL
>       ++	/*
>       ++	 * SysV needs the handler to be rearmed, but this is known
>       ++	 * to trigger infinite recursion crashes at least in AIX.
>       ++	 */
>       ++	signal(signo, child_handler);
>       ++#endif
>         }
>         
>         static int set_reuse_addr(int sockfd)
>        @@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>       + 	}
>       + }
>       +
>       ++#ifndef USE_NON_POSIX_SIGNAL
>       ++
>       ++static void set_signal_handler(struct sigaction *psa)
>       ++{
>       ++	sigemptyset(&psa->sa_mask);
>       ++	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
>       ++	psa->sa_handler = child_handler;
>       ++	sigaction(SIGCHLD, psa, NULL);
>       ++}
>       ++
>       ++#else
>       ++
>       ++static void set_signal_handler(struct sigaction *psa UNUSED)
>       ++{
>       ++	signal(SIGCHLD, child_handler);
>       ++}
>       ++
>         static int service_loop(struct socketlist *socklist)
>         {
>       - 	struct pollfd *pfd;
>        +	struct sigaction sa;
>       + 	struct pollfd *pfd;
>         
>         	CALLOC_ARRAY(pfd, socklist->nr);
>       -
>        @@ daemon.c: static int service_loop(struct socketlist *socklist)
>         		pfd[i].events = POLLIN;
>         	}
>         
>        -	signal(SIGCHLD, child_handler);
>       -+	sigemptyset(&sa.sa_mask);
>       -+	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
>       -+	sa.sa_handler = child_handler;
>       -+	sigaction(SIGCHLD, &sa, NULL);
>       ++	set_signal_handler(&sa);
>         
>         	for (;;) {
>         		check_dead_children();
>   3:  a450bdb0066 ! 3:  b737e0389df daemon: explicitly allow EINTR during poll()
>       @@ Commit message
>            might not return with -1 and set errno to EINTR when a signal is
>            received.
>        
>       -    Since the logic to reap zombie childs relies om those interruptions
>       +    Since the logic to reap zombie childs relies on those interruptions
>            make sure to explicitly disable SA_RESTART around this function.
>        
>       -    Add a Makefile flag for portability to systems that don't have the
>       -    functionality to change those flags or where it is not needed.
>       -
>            Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>        
>       - ## Makefile ##
>       -@@ Makefile: include shared.mak
>       - # Define NO_PREAD if you have a problem with pread() system call (e.g.
>       - # cygwin1.dll before v1.5.22).
>       - #
>       -+# Define NO_SIGINTERRUPT if you don't have siginterrupt() or SA_RESTART
>       -+# or if your signal(SIGCHLD) implementation doesn't set SA_RESTART.
>       -+#
>       - # Define NO_SETITIMER if you don't have setitimer()
>       - #
>       - # Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval
>       -@@ Makefile: ifdef NO_PREAD
>       - 	COMPAT_CFLAGS += -DNO_PREAD
>       - 	COMPAT_OBJS += compat/pread.o
>       - endif
>       -+ifdef NO_SIGINTERRUPT
>       -+	COMPAT_CFLAGS += -DNO_SIGINTERRUPT
>       -+endif
>       - ifdef NO_FAST_WORKING_DIRECTORY
>       - 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
>       - endif
>       -
>       - ## config.mak.uname ##
>       -@@ config.mak.uname: ifeq ($(uname_S),Windows)
>       - 	NO_STRTOUMAX = YesPlease
>       - 	NO_MKDTEMP = YesPlease
>       - 	NO_INTTYPES_H = YesPlease
>       -+	NO_SIGINTERRUPT = YesPlease
>       - 	CSPRNG_METHOD = rtlgenrandom
>       - 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
>       - 	# so we don't need this:
>       -@@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
>       - 	NO_PREAD = YesPlease
>       - 	NO_MMAP = YesPlease
>       - 	NO_POLL = YesPlease
>       -+	NO_SIGINTERRUPT = UnfortunatelyYes
>       - 	NO_INTPTR_T = UnfortunatelyYes
>       - 	CSPRNG_METHOD = openssl
>       - 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>       -@@ config.mak.uname: ifeq ($(uname_S),MINGW)
>       - 	NEEDS_LIBICONV = YesPlease
>       - 	NO_STRTOUMAX = YesPlease
>       - 	NO_MKDTEMP = YesPlease
>       -+	NO_SIGINTERRUPT = YesPlease
>       - 	NO_SVN_TESTS = YesPlease
>       -
>       - 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
>       -@@ config.mak.uname: ifeq ($(uname_S),QNX)
>       - 	NO_PTHREADS = YesPlease
>       - 	NO_STRCASESTR = YesPlease
>       - 	NO_STRLCPY = YesPlease
>       -+	NO_SIGINTERRUPT = UnfortunatelyYes
>       - endif
>       -
>       - ## configure.ac ##
>       -@@ configure.ac: GIT_CHECK_FUNC(getdelim,
>       - [HAVE_GETDELIM=])
>       - GIT_CONF_SUBST([HAVE_GETDELIM])
>       - #
>       -+# Define NO_SIGINTERRUPT if you don't have siginterrupt.
>       -+GIT_CHECK_FUNC(siginterrupt,
>       -+[NO_SIGINTERRUPT=],
>       -+[NO_SIGINTERRUPT=YesPlease])
>       -+GIT_CONF_SUBST([NO_SIGINTERRUPT])
>       - #
>       - # Define NO_MMAP if you want to avoid mmap.
>       - #
>       -
>         ## daemon.c ##
>       -@@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>       - 		add_child(&cld, addr, addrlen);
>       +@@ daemon.c: static void set_signal_handler(struct sigaction *psa)
>       + 	sigaction(SIGCHLD, psa, NULL);
>         }
>         
>       --static void child_handler(int signo UNUSED)
>       -+static void child_handler(int signo)
>       - {
>       - 	/*
>       --	 * Otherwise empty handler because systemcalls will get interrupted
>       --	 * upon signal receipt
>       -+	 * Empty handler because systemcalls should get interrupted
>       -+	 * upon signal receipt.
>       - 	 */
>       -+#ifdef NO_SIGINTERRUPT
>       -+	/* SysV needs the handler to be rearmed */
>       -+	signal(signo, child_handler);
>       -+#endif
>       ++static void set_sa_restart(struct sigaction *psa, int enable)
>       ++{
>       ++	if (enable)
>       ++		psa->sa_flags |= SA_RESTART;
>       ++	else
>       ++		psa->sa_flags &= ~SA_RESTART;
>       ++	sigaction(SIGCHLD, psa, NULL);
>       ++}
>       ++
>       + #else
>       +
>       + static void set_signal_handler(struct sigaction *psa UNUSED)
>       +@@ daemon.c: static void set_signal_handler(struct sigaction *psa UNUSED)
>       + 	signal(SIGCHLD, child_handler);
>         }
>         
>       - static int set_reuse_addr(int sockfd)
>       -@@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>       -
>       ++static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
>       ++{
>       ++}
>       ++
>       ++#endif
>       ++
>         static int service_loop(struct socketlist *socklist)
>         {
>       --	struct pollfd *pfd;
>       -+#ifndef NO_SIGINTERRUPT
>         	struct sigaction sa;
>       -+#endif
>       -+	struct pollfd *pfd;
>       -
>       - 	CALLOC_ARRAY(pfd, socklist->nr);
>       -
>        @@ daemon.c: static int service_loop(struct socketlist *socklist)
>       - 		pfd[i].events = POLLIN;
>       - 	}
>       -
>       -+#ifdef NO_SIGINTERRUPT
>       -+	signal(SIGCHLD, child_handler);
>       -+#else
>       - 	sigemptyset(&sa.sa_mask);
>       - 	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
>       - 	sa.sa_handler = child_handler;
>       - 	sigaction(SIGCHLD, &sa, NULL);
>       -+#endif
>       -
>         	for (;;) {
>         		check_dead_children();
>         
>       -+#ifndef NO_SIGINTERRUPT
>       -+		sa.sa_flags &= ~SA_RESTART;
>       -+		sigaction(SIGCHLD, &sa, NULL);
>       -+#endif
>       ++		set_sa_restart(&sa, 0);
>         		if (poll(pfd, socklist->nr, -1) < 0) {
>         			if (errno != EINTR) {
>         				logerror("Poll failed, resuming: %s",
>       @@ daemon.c: static int service_loop(struct socketlist *socklist)
>         			}
>         			continue;
>         		}
>       -+#ifndef NO_SIGINTERRUPT
>       -+		sa.sa_flags |= SA_RESTART;
>       -+		sigaction(SIGCHLD, &sa, NULL);
>       -+#endif
>       ++		set_sa_restart(&sa, 1);
>         
>         		for (size_t i = 0; i < socklist->nr; i++) {
>         			if (pfd[i].revents & POLLIN) {
>       -
>       - ## meson.build ##
>       -@@ meson.build: checkfuncs = {
>       -   'setenv' : ['setenv.c'],
>       -   'mkdtemp' : ['mkdtemp.c'],
>       -   'initgroups' : [],
>       -+  'siginterrupt' : [],
>       -   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
>       -   'pread' : ['pread.c'],
>       - }
> 

