Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24C28F93E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070369; cv=none; b=YOgWy0HiXaxzOlFdvlsDjE2+WxJ2huh9UhK8ODQ8upHbWrNtxybKKk/FUIbIrJj8/Fu8ZBVKl7il6MPI/QR+C7J35sHc7OHbSKoBsqAmHDlH1DA8x/k/PI81nLDJb5AT3H8Z+gLyHE5V+HAJp0mBjwhqhewo73kn1BBjIsVKL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070369; c=relaxed/simple;
	bh=Y7Je1xlubIqWEliuIeiAkZEfA+cRXFqRpT7nPmouKH0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E07ZL8M982fT2PILNQV5/xtgn9K6SsvvZHb7b49FYZ7c/ozkAXKkWEpntznMo/s/k4TLxdH9J/fW2yS2YhUw7XLMJFsZ848QUN2ORn423MsfMBM/uCQ6o9dI5EP+tJDQZ+UwY1Aq9362BWALUIPxIkutxEckVbIhWXWkhnUH7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d49LKpkt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d49LKpkt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso42131245e9.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070366; x=1752675166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8PFvj2tQh5HQkwzP9iwdlwrqPg1nZULDhb7rSlpSKE=;
        b=d49LKpktnkL843vyKaXeOfy23nCsCXDUX0ojzG2pRh83yjxQs4PeOD6A7bD/mbw1bs
         3DT1vj95Z44aTa557GY4uJ24uuwCysFy2zUBGgkTUqPbveQp7oyyPpsNLnLeARBkYRtd
         i/bOuyuoNIrZ4X4tiAgvLii0q6Vdmc5bargmJ2ZHPKw5D0SpNI4SXC49yxjffiSFnGTw
         oQX5JXJBZsJ1R/pkEO4N8Uj2hejEZ0lr13ZmBiNSHPH955ugjwNqfh89JezrpVW1UlbT
         ar2wwK6mmt9bHPeT7OgJujBJ6tzzgEAJbL/XWGmJjGQaRAC/FreS8PjE1wdmFwJ1JAmn
         a+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070366; x=1752675166;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8PFvj2tQh5HQkwzP9iwdlwrqPg1nZULDhb7rSlpSKE=;
        b=pFmUMm+QvFM1ne2y7f3LEUd6Y8WCZo5V7eGBRYx5/kjzKL+nA+UGBBJZZz0/WW4Sw6
         TzLZ6YT8lcscgjPl67CDqCs+WrPHsvDrELkbgXdsy26IEzzl0/y3tIg84K0gLZ7iywsG
         eXvhZ6SGFBbmVo5dGkSetFdFjM0F7MznPVD3fv5wIcaUFeNuwjiqGEY0OkRTt1XOjWyM
         NVNvzxTr1BgAzcVcQdGkSrmEaJm40BKCU2jz0Rh/iYvPCBuvd2alTONskb1eAeXMbq8Q
         bkBGF4JyBiN1ARboFfHKpTWHGuyuvaTVuFB0XvtNt8cWmsJUCVlFG+W1Hhpuh6peCcki
         3R4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdLTxh9uZmTemmcum6exAoBiqJ6ffTSHntanQffswHTcm+ccSVWQ+5+PMKhoqgVz+OlzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYAwxnnESmux/e5YdGVzigmZyFqv2xi5fA29vJQDjnY+vhIH1
	H2B/JKE6klvrMe97eDuFXmdTMFNBiT+y4VqksYaY3r7uEARiEAF9YkPK
X-Gm-Gg: ASbGncvBfB1ycgpqG+q2pchLxUKnDpJYIAvfuYFKe8XkwpsSD/9D5U+Pm0SfvZvkIHB
	zXzOQ7hJYbYAvKMZCQrYCN+RtWKb5V5xnujpjWU0LWBC855ia73y+tjXklXJ3GG8L8IORCAETTa
	CSuJXBzOHx0Ye3I81YbFv36zEuVYHOb96UPBaVWwctlKXeBjW0XmATjZrtYTVdJPyJahatH6FRr
	wBnfU8Wj1LaNxLPq+fQx8HuIaLS5WJD2+/TxCgyYxc3goX6C32NeJ0cAlreb2F4Bi9lOr8hxAiZ
	KDMfvOacUa+g33g+z64xC37bMur0TYOOKwl/mnvkYrNPgVgIKUWpvoEds4qA9cOo1yw3yt0r2PF
	SSxJJ7JPaxwAfv+AnVCp6zMEAxNkUh2CqIivNDg==
X-Google-Smtp-Source: AGHT+IFHXEGWMdzV1EitRt+7MgZ8qi2JSjl9UYs5K0feFae9KQhKZLjJTNr9VLSSDrN7IEB/tM7IEQ==
X-Received: by 2002:a05:600c:4755:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-454d535c142mr24778575e9.22.1752070365684;
        Wed, 09 Jul 2025 07:12:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516f1sm24149245e9.16.2025.07.09.07.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 07:12:45 -0700 (PDT)
Message-ID: <b1027221-3e17-40d2-b293-4b1625fa095d@gmail.com>
Date: Wed, 9 Jul 2025 15:12:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] daemon: explicitly allow EINTR during poll()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> This series addresses and ambiguity that is at least visible in OpenBSD,
> where zombie proceses would only be cleared after a new connection is
> received.
> 
> The underlying problem is that when this code was originally introduced,
> SA_RESTART was not widely implemented, and the signal() call usually
> implemented SysV like semantics, at least until it started being
> reimplemented by calling sigaction() internally.

I'm all in favor of using sigaction() but I think the SA_RESTART parts 
of this series are an unnecessary complication that has the potential to 
hide bugs as we support platforms without SA_RESTART. Your EINTR patches 
have all been about efficiency rather than correctness so I think my 
initial assessment that the existing code handles EINTR correctly was 
probably true. As I said in my comments on patch 3 I think we can 
happily drop patches 1 and 4.

Thanks

Phillip


> Changes since v2
> 
>   * Add a new patch 2 that modifies windows' sigaction so there is no more
>     need for a fallback
>   * Hopefully no more silly mistakes and a variable that finally makes sense
> 
> Changes since v1
> 
>   * Almost all references to siginterrupt has been removed and a better named
>     variable used instead
>   * Changes had been abstracted to minimize ifdefs and their introduction
>     staged more naturally
> 
> Carlo Marcelo Arenas Belón (4):
>    compat/posix.h: track SA_RESTART fallback
>    compat/mingw: allow sigaction(SIGCHLD)
>    daemon: use sigaction() to install child_handler()
>    daemon: explicitly allow EINTR during poll()
> 
>   Makefile             |  5 +++++
>   compat/mingw-posix.h |  2 +-
>   compat/mingw.c       |  4 +++-
>   compat/posix.h       |  8 ++++++++
>   config.mak.uname     |  7 ++++---
>   configure.ac         | 16 ++++++++++++++++
>   daemon.c             | 33 ++++++++++++++++++++++++++++-----
>   meson.build          |  4 ++++
>   8 files changed, 69 insertions(+), 10 deletions(-)
> 
> 
> base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v3
> Pull-Request: https://github.com/git/git/pull/2002
> 
> Range-diff vs v2:
> 
>   1:  e82b7425bbc ! 1:  ae1ca6bb2b2 compat/posix.h: track SA_RESTART fallback
>       @@ Makefile: include shared.mak
>         # when attempting to read from an fopen'ed directory (or even to fopen
>         # it at all).
>         #
>       -+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>       -+# prefer to use ANSI C signal() over POSIX sigaction()
>       ++# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
>        +#
>         # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
>         # when a signal is received (as opposed to restarting).
>       @@ Makefile: ifdef FREAD_READS_DIRECTORIES
>         	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
>         	COMPAT_OBJS += compat/fopen.o
>         endif
>       -+ifdef USE_NON_POSIX_SIGNAL
>       -+	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
>       ++ifdef NO_RESTARTABLE_SIGNALS
>       ++	COMPAT_CFLAGS += -DNO_RESTARTABLE_SIGNALS
>        +endif
>         ifdef OPEN_RETURNS_EINTR
>         	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
>       @@ compat/posix.h: char *gitdirname(char *);
>        + * not on some systems (e.g. NonStop, QNX).
>        + */
>        +#ifndef SA_RESTART
>       -+# define SA_RESTART 0	/* disabled for sigaction() */
>       ++# define SA_RESTART 0 /* disabled for sigaction() */
>        +#endif
>        +
>         typedef uintmax_t timestamp_t;
>       @@ config.mak.uname: ifeq ($(uname_S),Windows)
>         	NO_STRTOUMAX = YesPlease
>         	NO_MKDTEMP = YesPlease
>         	NO_INTTYPES_H = YesPlease
>       -+	USE_NON_POSIX_SIGNAL = YesPlease
>       ++	NO_RESTARTABLE_SIGNALS = YesPlease
>         	CSPRNG_METHOD = rtlgenrandom
>         	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
>         	# so we don't need this:
>       @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
>         	NO_MMAP = YesPlease
>         	NO_POLL = YesPlease
>         	NO_INTPTR_T = UnfortunatelyYes
>       -+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
>       ++	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
>         	CSPRNG_METHOD = openssl
>         	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>         	SHELL_PATH = /usr/coreutils/bin/bash
>       @@ config.mak.uname: ifeq ($(uname_S),MINGW)
>         	NEEDS_LIBICONV = YesPlease
>         	NO_STRTOUMAX = YesPlease
>         	NO_MKDTEMP = YesPlease
>       -+	USE_NON_POSIX_SIGNAL = YesPlease
>       ++	NO_RESTARTABLE_SIGNALS = YesPlease
>         	NO_SVN_TESTS = YesPlease
>         
>         	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
>       @@ config.mak.uname: ifeq ($(uname_S),QNX)
>         	NO_PTHREADS = YesPlease
>         	NO_STRCASESTR = YesPlease
>         	NO_STRLCPY = YesPlease
>       -+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
>       ++	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
>         endif
>        
>         ## configure.ac ##
>       @@ configure.ac: fi
>         GIT_CONF_SUBST([ICONV_OMITS_BOM])
>         fi
>         
>       -+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>       -+# prefer using ANSI C signal() over POSIX sigaction()
>       ++# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
>        +
>        +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
>        +	AC_COMPILE_IFELSE(
>        +		[AC_LANG_PROGRAM([#include <signal.h>], [[
>       -+		#ifdef SA_RESTART
>       -+		#endif
>       -+		siginterrupt(SIGCHLD, 1)
>       -+		]])],[ac_cv_siginterrupt=yes],[
>       ++			#ifdef SA_RESTART
>       ++			restartable signals supported
>       ++			#endif
>       ++		]])],[
>        +			ac_cv_siginterrupt=no
>       -+			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
>       -+		]
>       ++			NO_RESTARTABLE_SIGNALS=UnfortunatelyYes
>       ++		], [ac_cv_siginterrupt=yes]
>        +	)
>        +])
>       -+GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
>       ++GIT_CONF_SUBST([NO_RESTARTABLE_SIGNALS])
>        +
>         ## Checks for typedefs, structures, and compiler characteristics.
>         AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
>       @@ meson.build: else
>         endif
>         
>        +if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
>       -+  libgit_c_args += '-DUSE_NON_POSIX_SIGNAL'
>       ++  libgit_c_args += '-DNO_RESTARTABLE_SIGNALS'
>        +endif
>        +
>         if not compiler.has_header('sys/select.h')
>   -:  ----------- > 2:  3f63479119f compat/mingw: allow sigaction(SIGCHLD)
>   2:  05d945aa1e5 ! 3:  c66bda461f4 daemon: use sigaction() to install child_handler()
>       @@ Commit message
>            In a future change, the flags used for processing SIGCHLD will need to
>            be updated, which is only possible by using sigaction().
>        
>       -    Factor out the call to set the signal handler and use sigaction instead
>       -    of signal for the systems that allow that, which has the added benefit
>       -    of using BSD semantics reliably and therefore not needing the rearming
>       -    call.
>       +    Replace signal() with an equivalent invocation of sigaction(), which
>       +    has the added benefit of using BSD semantics reliably and therefore
>       +    not needing the rearming call in the signal handler.
>        
>            Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>        
>         ## daemon.c ##
>        @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>       - 		add_child(&cld, addr, addrlen);
>       - }
>       -
>       --static void child_handler(int signo UNUSED)
>       -+static void child_handler(int signo MAYBE_UNUSED)
>       + static void child_handler(int signo UNUSED)
>         {
>         	/*
>        -	 * Otherwise empty handler because systemcalls will get interrupted
>       @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addr
>        +	 * upon signal receipt.
>         	 */
>        -	signal(SIGCHLD, child_handler);
>       -+#ifdef USE_NON_POSIX_SIGNAL
>       -+	/*
>       -+	 * SysV needs the handler to be rearmed, but this is known
>       -+	 * to trigger infinite recursion crashes at least in AIX.
>       -+	 */
>       -+	signal(signo, child_handler);
>       -+#endif
>         }
>         
>         static int set_reuse_addr(int sockfd)
>        @@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>       - 	}
>       - }
>         
>       -+#ifndef USE_NON_POSIX_SIGNAL
>       -+
>       -+static void set_signal_handler(struct sigaction *psa)
>       -+{
>       -+	sigemptyset(&psa->sa_mask);
>       -+	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
>       -+	psa->sa_handler = child_handler;
>       -+	sigaction(SIGCHLD, psa, NULL);
>       -+}
>       -+
>       -+#else
>       -+
>       -+static void set_signal_handler(struct sigaction *psa UNUSED)
>       -+{
>       -+	signal(SIGCHLD, child_handler);
>       -+}
>       -+
>         static int service_loop(struct socketlist *socklist)
>         {
>        +	struct sigaction sa;
>       @@ daemon.c: static int service_loop(struct socketlist *socklist)
>         	}
>         
>        -	signal(SIGCHLD, child_handler);
>       -+	set_signal_handler(&sa);
>       ++	sigemptyset(&sa.sa_mask);
>       ++	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
>       ++	sa.sa_handler = child_handler;
>       ++	sigaction(SIGCHLD, &sa, NULL);
>         
>         	for (;;) {
>         		check_dead_children();
>   3:  b737e0389df ! 4:  851d663be0b daemon: explicitly allow EINTR during poll()
>       @@ Commit message
>            Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>        
>         ## daemon.c ##
>       -@@ daemon.c: static void set_signal_handler(struct sigaction *psa)
>       - 	sigaction(SIGCHLD, psa, NULL);
>       +@@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>       + 	}
>         }
>         
>       ++#ifndef NO_RESTARTABLE_SIGNALS
>       ++
>        +static void set_sa_restart(struct sigaction *psa, int enable)
>        +{
>        +	if (enable)
>       @@ daemon.c: static void set_signal_handler(struct sigaction *psa)
>        +	sigaction(SIGCHLD, psa, NULL);
>        +}
>        +
>       - #else
>       -
>       - static void set_signal_handler(struct sigaction *psa UNUSED)
>       -@@ daemon.c: static void set_signal_handler(struct sigaction *psa UNUSED)
>       - 	signal(SIGCHLD, child_handler);
>       - }
>       -
>       ++#else
>       ++
>        +static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
>        +{
>        +}
> 

