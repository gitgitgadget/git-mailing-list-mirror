Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D104195B1A
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752315940; cv=none; b=OiT7e1NhlUKfkxrQsVQ9DRnVe5HeFI7t6i/J+C/tlRfclZnHJYMtVB0ctZA9wH8PU6u4xQmhMOaJANS46VUjPrSPEyD9QOTfBu4laZNqYa/fsUtdpjz+ziwTy9Qizbggo0Dgj7kn+InrQwPAEd0Ri5vFpZiXJ80PXXkgLnd/2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752315940; c=relaxed/simple;
	bh=f5PN5EUjIaPqICCp+M3gQNMTDD7skt9pXtui5FR15EU=;
	h=From:To:Subject:MIME-Version:Date:Message-Id:Content-Type; b=qX5t4asmXo/yL9sSXjU60fnbhWBNRC+PTJpG+ILrg/V59UbS7afpQE/d40/8V7xD4Ww69hCkESf6EZsgMLq/PrB9JF/56KYvJD+Zjxcj2jOarPXY9YivTtp2AYsUbeccZ+cXbflgC4yGCf8h+LzUjsiPd0ZDLX2xobYU4s8bOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru; spf=pass smtp.mailfrom=ieml.ru; dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b=dpC4Vqk+; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieml.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieml.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieml.ru header.i=@ieml.ru header.b="dpC4Vqk+"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id C9F7863CDE
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 13:20:06 +0300 (MSK)
Received: from mail-nwsmtp-mxback-production-main-75.iva.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-75.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:172d:0:640:f98a:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id D779B609A1
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 13:19:56 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c0c:8b14:0:640:643d:0 [2a02:6b8:c0c:8b14:0:640:643d:0])
	by mail-nwsmtp-mxback-production-main-75.iva.yp-c.yandex.net (mxback/Yandex) with HTTPS id pJFUlO7MfiE0-F3TTD1cU;
	Sat, 12 Jul 2025 13:19:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieml.ru; s=mail;
	t=1752315596; bh=U2p4Yuwqew75ajyP1bgYEaDAFMgh4Oo+cZr4jLzlU1w=;
	h=Message-Id:Date:Subject:To:From;
	b=dpC4Vqk+9+h+Ruijugg6pnlI8CBHFYBCAkMzRhq0IfDxy8FeqOfYlUMz2GPnpDbFM
	 2VVrmQit0sDM3Kq2J8X9orvLPygVeMffj1GoWg0RXu2YBM7vSX8+Hh3ukRkS+dryRJ
	 JS7HjmhR5qgUTr+Bmkj0G8HqW2Ol1wxbDEQ4mIHY=
Authentication-Results: mail-nwsmtp-mxback-production-main-75.iva.yp-c.yandex.net; dkim=pass header.i=@ieml.ru
Received: by sb3hpb4oycqcuvtz.iva.yp-c.yandex.net (sendbernar/Yandex) with HTTPS id d7fe0c163184e5e5845179853b890111;
	Sat, 12 Jul 2025 13:19:56 +0300
From: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
To: git@vger.kernel.org
Subject: git  2.50 and 2.50.1  src fails to compile in rhel 6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 12 Jul 2025 13:19:56 +0300
Message-Id: <8515891752315596@sb3hpb4oycqcuvtz.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

Hello everyone! I'm having trouble compilig git source since version 2.50 ,  for RHEL 6 (both in redhat 6-6 and 6.10).
the same source  compiles fine in  RHEL8 (Red Hat Enterprise Linux release 8.10 (Ootpa))
first compiler complans about missing random.h in compat/posix.h ,if you copy missing random.h file to RHEL6 machine to the /usr/include/sys directory  then errors change to  whole bunch of other errors like  
error: expected declaration specifiers or ‘...’ before numeric constant
 
   45 | #define toupper(x) sane_case((unsigned char)(x), 0)
both working and non working systems have same gcc 13-4.0 . Last version that compiles  in both rhel 6 and rhel 8 is 2.49.1 Any ideas ?
 
 
 git-2.50.1# make  -j $(nproc) configure && ./configure && make -j $(nproc) && make -j $(nproc) install && make -j $(nproc) clean
GIT_VERSION=2.50.1
    GEN configure
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
checking for gcc... /usr/local/gcc-13.4.0/bin/gcc-13.4
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... yes
checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... none needed
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for size_t... yes
checking for working alloca.h... yes
checking for alloca... yes
configure: CHECKS for programs
checking whether the compiler supports GNU C... (cached) yes
checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... (cached) yes
checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... (cached) none needed
checking for inline... inline
checking if linker supports -R... no
checking if linker supports -Wl,-rpath,... yes
checking for gar... no
checking for ar... ar
checking for gtar... gtar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... no
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for curl_global_init in -lcurl... yes
checking for curl-config... curl-config
configure: Setting CURL_LDFLAGS to '-L/usr/local/lib -lcurl'
checking for XML_ParserCreate in -lexpat... yes
checking for iconv in -lc... yes
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
checking if libc contains libintl... yes
checking for libintl.h... yes
configure: CHECKS for header files
checking for sys/select.h... yes
checking for poll.h... yes
checking for sys/poll.h... yes
checking for inttypes.h... (cached) yes
checking for old iconv()... no
checking whether iconv omits bom for utf-16 and utf-32... no
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct itimerval... yes
checking for struct stat.st_mtimespec.tv_nsec... no
checking for struct stat.st_mtim.tv_nsec... yes
checking for struct dirent.d_type... yes
checking for struct passwd.pw_gecos... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking how to run the C preprocessor... /usr/local/gcc-13.4.0/bin/gcc-13.4 -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking whether the platform regex supports REG_STARTEND... yes
checking whether system succeeds to read fopen'ed directory... yes
checking whether snprintf() and/or vsnprintf() return bogus value... no
checking whether the platform uses typical file type bits... yes
configure: CHECKS for library functions
checking for libgen.h... yes
checking for paths.h... yes
checking for libcharset.h... no
checking for strings.h... (cached) yes
checking for locale_charset in -liconv... no
checking for locale_charset in -lcharset... no
checking for sysinfo... yes
checking for clock_gettime... no
checking for CLOCK_MONOTONIC... yes
checking for sync_file_range... yes
checking for library containing sync_file_range... none required
checking for setitimer... yes
checking for library containing setitimer... none required
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for memmem... yes
checking for library containing memmem... none required
checking for strlcpy... no
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for initgroups... yes
checking for library containing initgroups... none required
checking for getdelim... yes
checking for library containing getdelim... none required
checking for BSD sysctl... no
checking for POSIX Threads with ''... no
checking for POSIX Threads with '-mt'... no
checking for POSIX Threads with '-pthread'... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
config.status: executing config.mak.autogen commands
    * new build flags
    * new link flags
    CC base85.o
    CC bisect.o
    * new prefix flags
    CC blame.o
    CC blob.o
    CC bloom.o
    CC branch.o
    CC bulk-checkin.o
    CC bundle-uri.o
    CC bundle.o
    CC cache-tree.o
    CC cbtree.o
    CC chdir-notify.o
    CC checkout.o
    CC chunk-format.o
    CC color.o
    CC column.o
In file included from compat/posix.h:449,
                 from git-compat-util.h:26,
                 from checkout.c:3:
compat/../sane-ctype.h:29:60: error: expected expression before ‘]’ token
   29 | #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
      |                                                            ^
  0)
      |                                                  ^
make: *** [Makefile:2821: cbtree.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile:2821: base85.o] Error 1
make: *** [Makefile:2821: chdir-notify.o] Error 1
make: *** [Makefile:2821: chunk-format.o] Error 1
make: *** [Makefile:2821: blob.o] Error 1
make: *** [Makefile:2821: color.o] Error 1
make: *** [Makefile:2821: checkout.o] Error 1
make: *** [Makefile:2821: column.o] Error 1
make: *** [Makefile:2821: bulk-checkin.o] Error 1
make: *** [Makefile:2821: branch.o] Error 1
make: *** [Makefile:2821: cache-tree.o] Error 1
make: *** [Makefile:2821: bloom.o] Error 1
make: *** [Makefile:2821: bundle-uri.o] Error 1
make: *** [Makefile:2821: bundle.o] Error 1
make: *** [Makefile:2821: bisect.o] Error 1
make: *** [Makefile:2821: blame.o] Error 1
