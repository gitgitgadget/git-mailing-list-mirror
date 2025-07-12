Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB69DDBC
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752335195; cv=none; b=Miqlj9DJAsUvIBOzAzqoJKL7tt0GooPvXDLaSZ9HXBBj4TGgylwpVn8JF/6sBxjxKeru1VcJ9pxHqFi30X4phCM9ylo/VXTkjDLEPtCxSzPSpFWuDPg6ZWBFP6uH/EIr7sdudlc/2jX3kT/qLi9ntTvHPmLXFkcw8nJfK+8jiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752335195; c=relaxed/simple;
	bh=jTpu6oZ0l3eLxmPhg6za1MJLo8YyS1ltGLEpw3jtv3c=;
	h=From:To:Cc:In-Reply-To:References:Subject:MIME-Version:Date:
	 Message-Id:Content-Type; b=OTvkGemn9hqy72+U8XiHbWZcjQECYx3aR5lWe+ncDkxYQvzJg8nn05saWEFCI85kZj4SAQKI+yTRNChg13oDw/lOtkYvCliMd9AxuKh+5hFKSZQBOyvooQPOtwE2AyzuPY7bX7ULRnwt7yvgEfUAp1ceYKgnJzoyBdjtpk0CzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=hBsO7hM4; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="hBsO7hM4"
Received: from mail-nwsmtp-mxback-production-main-29.vla.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-29.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:e88:0:640:8b42:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id C8A3562178;
	Sat, 12 Jul 2025 18:41:01 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c0f:1610:0:640:ac18:0 [2a02:6b8:c0f:1610:0:640:ac18:0])
	by mail-nwsmtp-mxback-production-main-29.vla.yp-c.yandex.net (mxback/Yandex) with HTTPS id LeKQpn8MniE0-jw267YdK;
	Sat, 12 Jul 2025 18:41:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1752334861; bh=m/gUvbNPdlJIPJLBZ9PclVdV8uIGs1Og1KDyrGtnpx4=;
	h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
	b=hBsO7hM4MWBvuyzFuVFf+/wZOVStK7iXrhfd+mIBDLqI9AK0L2Tbv1UAp+gwRHg+K
	 njrdnXng/C36ygoVVxAe7+XhkZzKMwFbN88QbssNqtRanZ7AWPKNTxV5N/IPbZ/EtW
	 W/BaYtZVZVvnGpKWdxbwvhaFrb4Ak1qrULU0Dy4s=
Authentication-Results: mail-nwsmtp-mxback-production-main-29.vla.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by mail-sendbernar-production-main-77.vla.yp-c.yandex.net (sendbernar/Yandex) with HTTPS id 5882f267e3bd692e0a76bc3d900e9e37;
	Sat, 12 Jul 2025 18:41:00 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
In-Reply-To: <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com>
References: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net> <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com>
Subject: Re: git 2.50 and 2.50.1 src fails to compile in rhel 6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 12 Jul 2025 18:41:00 +0300
Message-Id: <8795721752334860@mail-sendbernar-production-main-77.vla.yp-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8


I/m soorry for the noob quesion but how do I get the patched version of the sane-ctype.h? I/m not sure where exactly to apply the patch to. I only see the diff, and not the whole file itself. And what are the chances of this patch being merged to master branch
> 
>> Hello everyone! I'm having trouble compilig git source since version 2.50 , for RHEL 6 (both in redhat 6-6 and 6.10).
>> the same source compiles fine in RHEL8 (Red Hat Enterprise Linux release 8.10 (Ootpa))
>> first compiler complans about missing random.h in compat/posix.h ,if you copy missing random.h file to RHEL6 machine to the /usr/include/sys directory then errors change to whole bunch of other errors like
>> error: expected declaration specifiers or ‘...’ before numeric constant
>>
>> 45 | #define toupper(x) sane_case((unsigned char)(x), 0)
>> both working and non working systems have same gcc 13-4.0 . Last version that compiles in both rhel 6 and rhel 8 is 2.49.1 Any ideas ?
> 
> There is a patch to fix this issue available at
> https://lore.kernel.org/git/xmqqtt3j69r8.fsf@gitster.g/
> 
> Thanks
> 
> Phillip
> 
>> git-2.50.1# make -j $(nproc) configure && ./configure && make -j $(nproc) && make -j $(nproc) install && make -j $(nproc) clean
>> GIT_VERSION=2.50.1
>> GEN configure
>> configure: Setting lib to 'lib' (the default)
>> configure: Will try -pthread then -lpthread to enable POSIX Threads.
>> configure: CHECKS for site configuration
>> checking for gcc... /usr/local/gcc-13.4.0/bin/gcc-13.4
>> checking whether the C compiler works... yes
>> checking for C compiler default output file name... a.out
>> checking for suffix of executables...
>> checking whether we are cross compiling... no
>> checking for suffix of object files... o
>> checking whether the compiler supports GNU C... yes
>> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... yes
>> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... none needed
>> checking for stdio.h... yes
>> checking for stdlib.h... yes
>> checking for string.h... yes
>> checking for inttypes.h... yes
>> checking for stdint.h... yes
>> checking for strings.h... yes
>> checking for sys/stat.h... yes
>> checking for sys/types.h... yes
>> checking for unistd.h... yes
>> checking for size_t... yes
>> checking for working alloca.h... yes
>> checking for alloca... yes
>> configure: CHECKS for programs
>> checking whether the compiler supports GNU C... (cached) yes
>> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... (cached) yes
>> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... (cached) none needed
>> checking for inline... inline
>> checking if linker supports -R... no
>> checking if linker supports -Wl,-rpath,... yes
>> checking for gar... no
>> checking for ar... ar
>> checking for gtar... gtar
>> checking for gnudiff... no
>> checking for gdiff... no
>> checking for diff... diff
>> checking for asciidoc... no
>> configure: CHECKS for libraries
>> checking for SHA1_Init in -lcrypto... yes
>> checking for curl_global_init in -lcurl... yes
>> checking for curl-config... curl-config
>> configure: Setting CURL_LDFLAGS to '-L/usr/local/lib -lcurl'
>> checking for XML_ParserCreate in -lexpat... yes
>> checking for iconv in -lc... yes
>> checking for deflateBound in -lz... yes
>> checking for socket in -lc... yes
>> checking for inet_ntop... yes
>> checking for inet_pton... yes
>> checking for hstrerror... yes
>> checking for basename in -lc... yes
>> checking if libc contains libintl... yes
>> checking for libintl.h... yes
>> configure: CHECKS for header files
>> checking for sys/select.h... yes
>> checking for poll.h... yes
>> checking for sys/poll.h... yes
>> checking for inttypes.h... (cached) yes
>> checking for old iconv()... no
>> checking whether iconv omits bom for utf-16 and utf-32... no
>> configure: CHECKS for typedefs, structures, and compiler characteristics
>> checking for socklen_t... yes
>> checking for struct itimerval... yes
>> checking for struct stat.st_mtimespec.tv_nsec... no
>> checking for struct stat.st_mtim.tv_nsec... yes
>> checking for struct dirent.d_type... yes
>> checking for struct passwd.pw_gecos... yes
>> checking for struct sockaddr_storage... yes
>> checking for struct addrinfo... yes
>> checking for getaddrinfo... yes
>> checking for library containing getaddrinfo... none required
>> checking how to run the C preprocessor... /usr/local/gcc-13.4.0/bin/gcc-13.4 -E
>> checking for grep that handles long lines and -e... /bin/grep
>> checking for egrep... /bin/grep -E
>> checking whether the platform regex supports REG_STARTEND... yes
>> checking whether system succeeds to read fopen'ed directory... yes
>> checking whether snprintf() and/or vsnprintf() return bogus value... no
>> checking whether the platform uses typical file type bits... yes
>> configure: CHECKS for library functions
>> checking for libgen.h... yes
>> checking for paths.h... yes
>> checking for libcharset.h... no
>> checking for strings.h... (cached) yes
>> checking for locale_charset in -liconv... no
>> checking for locale_charset in -lcharset... no
>> checking for sysinfo... yes
>> checking for clock_gettime... no
>> checking for CLOCK_MONOTONIC... yes
>> checking for sync_file_range... yes
>> checking for library containing sync_file_range... none required
>> checking for setitimer... yes
>> checking for library containing setitimer... none required
>> checking for strcasestr... yes
>> checking for library containing strcasestr... none required
>> checking for memmem... yes
>> checking for library containing memmem... none required
>> checking for strlcpy... no
>> checking for uintmax_t... yes
>> checking for strtoumax... yes
>> checking for library containing strtoumax... none required
>> checking for setenv... yes
>> checking for library containing setenv... none required
>> checking for unsetenv... yes
>> checking for library containing unsetenv... none required
>> checking for mkdtemp... yes
>> checking for library containing mkdtemp... none required
>> checking for initgroups... yes
>> checking for library containing initgroups... none required
>> checking for getdelim... yes
>> checking for library containing getdelim... none required
>> checking for BSD sysctl... no
>> checking for POSIX Threads with ''... no
>> checking for POSIX Threads with '-mt'... no
>> checking for POSIX Threads with '-pthread'... yes
>> configure: creating ./config.status
>> config.status: creating config.mak.autogen
>> config.status: executing config.mak.autogen commands
>> * new build flags
>> * new link flags
>> CC base85.o
>> CC bisect.o
>> * new prefix flags
>> CC blame.o
>> CC blob.o
>> CC bloom.o
>> CC branch.o
>> CC bulk-checkin.o
>> CC bundle-uri.o
>> CC bundle.o
>> CC cache-tree.o
>> CC cbtree.o
>> CC chdir-notify.o
>> CC checkout.o
>> CC chunk-format.o
>> CC color.o
>> CC column.o
>> In file included from compat/posix.h:449,
>> from git-compat-util.h:26,
>> from checkout.c:3:
>> compat/../sane-ctype.h:29:60: error: expected expression before ‘]’ token
>> 29 | #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>> | ^
>> 0)
>> | ^
>> make: *** [Makefile:2821: cbtree.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> make: *** [Makefile:2821: base85.o] Error 1
>> make: *** [Makefile:2821: chdir-notify.o] Error 1
>> make: *** [Makefile:2821: chunk-format.o] Error 1
>> make: *** [Makefile:2821: blob.o] Error 1
>> make: *** [Makefile:2821: color.o] Error 1
>> make: *** [Makefile:2821: checkout.o] Error 1
>> make: *** [Makefile:2821: column.o] Error 1
>> make: *** [Makefile:2821: bulk-checkin.o] Error 1
>> make: *** [Makefile:2821: branch.o] Error 1
>> make: *** [Makefile:2821: cache-tree.o] Error 1
>> make: *** [Makefile:2821: bloom.o] Error 1
>> make: *** [Makefile:2821: bundle-uri.o] Error 1
>> make: *** [Makefile:2821: bundle.o] Error 1
>> make: *** [Makefile:2821: bisect.o] Error 1
>> make: *** [Makefile:2821: blame.o] Error 1
