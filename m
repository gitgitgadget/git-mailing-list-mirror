Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0632A1A4
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752318784; cv=none; b=kjvdrkoNKwAMvCbzhkGJ/T9NZvcNE6ZUgLNFfP7dqR2RJoRQqwVTkRj8JmqL8FXvHP7+vIdVH9av/EU6VYrya3mMY6PmsnjnFmf+G5Kl/6JaDyBEjECGFdq5IjQZQ6NySd2ftEf7RNgRAgltGo/M7Q1fhsDtctj81bIAPuFkTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752318784; c=relaxed/simple;
	bh=/z9la2J+vYVhP+Z3+1Xjqr0TsEqMKrMs1SjXQSIvYrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aOsBEDQzMGXvhUWAsQZs1tFaqag5ZVGkqdBlwHVhFWu2cnmB8UACrLPbs8KrBTNP0Ctd/L7YbqWxHgW/009DK9nsiJDsGcQJha24dUxveK98D9xK/ecY04HCcrjcr5aCp9nc7gl/FKzgUnttV2p1dGlaT8NiHWlW2junjyx/Ak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkgob/Dp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkgob/Dp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2477935f8f.2
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752318780; x=1752923580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pjYCU9CSLn7muNOxpA46WLWZ8xjm2B2AM8rpbGajplI=;
        b=Rkgob/DpsvYvCMWbIYmadYA3LSDBWyG5M0tp1UHd9Ls8ZldAcX+6ugRajg5n+FeLni
         g9BzWmMHEzk37peirv9mekiBlvuIzJLlOXLKBdOGcXimc0YJACEQHRugXSV3HqcsAFZ+
         vCK41Q9wrPygKSl6+7iFZAFZynbSXRtTJkoGfnIlc8uVO78Zo1tgf8rrEs3LHK5iP6HC
         4ifNMTinopTVxzJuq+lcBuaBhmn9ltU/feaZL6WcfWbyigl6vawV/Te4tYggn04S5bfd
         sjdnYcqoYEeq4cP31MIq++G3uMVADDhVySM6k+yRIpUdKNN+2SCjq7sP9TxRRrdCuMpl
         hL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752318780; x=1752923580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjYCU9CSLn7muNOxpA46WLWZ8xjm2B2AM8rpbGajplI=;
        b=sab+EZZzeKgCBbf/J1QN3MkGvt79Xqlnt57RDC72JArTDN/i31ZDOoFvrgf3LLNg3F
         +bc2ea2OxpjpoquKQ1UHVS0vSyjzKRStZ79ugIpIoW5EEfHVxYuE3fGPq/2ITSPewJn9
         uX5C3LL2KHIblQh5Vc5UFXPltzk7/ErCiLiFDPa9gPt8MdbpSYOWanwAjX4gc2oEwE40
         guO/HCRvdYuzF8+uV3Lfk149cnq6dl1Rl1+R65ghRsO5q86OASFVhWl6h7jN8iF8NuXs
         6EDhcw5XLCbM2nL78DklxcBO5n+7ZvqmxdwBEEtqh27Ng5knIFJusGrbruP5enufmwQr
         oxNA==
X-Forwarded-Encrypted: i=1; AJvYcCXwexrwQCvQDSRc89CUrtyijzko7+xZ2hedrYiMQMi2jOI7CpTy94hcby5NbcTCKu6PZZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsh6jyx/UpxvroCGIoHU9/BbClYE8tCmzQnyGhWaeFZP82MqbI
	p88TW/84Mv6puAKrJmGW0Kia2WbB/teFnIQMSMou/KC1cMbP4e9VzJDEec9Dcg==
X-Gm-Gg: ASbGnctJABvHkXHLoEY0c61XiXqxL9NBxjuCIiCYLkhx7x06SEg+QorRT+xZOdEn1qP
	mMjZMU60BxE+OIC1s4wgmavq5z0Wc9dWyTtkWvmjnYfMIviYHB0D+39rZaBVvmuse9K8SwIXenv
	Uis9GzrXvCua6HRvlPIO9pctolAr10SZk6jXdoDZZnA6UnYJPBWL10J74wcrs7bzjmzZTHrYL4E
	QO3Hm/MMgVASsBE2j+3Us+8xhINbrFEcxolodocUhRSP5wEyHGhIoMhMXcpEt96fwAkRqGpoeaQ
	cJ1jJvT2ltGKxugfsB0X4Z3DvT+FRwwjlIDb+w0rAMbQcdY/n3DDDaXXTvpdDyCPS35n+VNzIA+
	6x/80UUkNfxOso2ARz0PDmt97IkkvncIhAywTERVFwkoMQabpIiVusvTg94TVkkMBpvqbTD3dIj
	Q5
X-Google-Smtp-Source: AGHT+IFdM0g/blMcimuvUnTgryhG2pxddVVu2mZuhdY8sFiZiv3Fsrijapv2UKZw+mm2XVHCRrf8Pg==
X-Received: by 2002:a05:6000:4b19:b0:3a3:5ae4:6e81 with SMTP id ffacd0b85a97d-3b5f2dac5cdmr5046903f8f.8.1752318780246;
        Sat, 12 Jul 2025 04:13:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21fdsm7049916f8f.33.2025.07.12.04.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 04:12:59 -0700 (PDT)
Message-ID: <f636840b-ec66-4059-9d0c-3cca07d42007@gmail.com>
Date: Sat, 12 Jul 2025 12:12:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git 2.50 and 2.50.1 src fails to compile in rhel 6
To: =?UTF-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>,
 git@vger.kernel.org
References: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <1615371752315594@mail-sendbernar-production-main-92.sas.yp-c.yandex.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/07/2025 11:19, Азат Усманов wrote:
> Hello everyone! I'm having trouble compilig git source since version 2.50 ,  for RHEL 6 (both in redhat 6-6 and 6.10).
> the same source  compiles fine in  RHEL8 (Red Hat Enterprise Linux release 8.10 (Ootpa))
> first compiler complans about missing random.h in compat/posix.h ,if you copy missing random.h file to RHEL6 machine to the /usr/include/sys directory  then errors change to  whole bunch of other errors like
> error: expected declaration specifiers or ‘...’ before numeric constant
>   
>     45 | #define toupper(x) sane_case((unsigned char)(x), 0)
> both working and non working systems have same gcc 13-4.0 . Last version that compiles  in both rhel 6 and rhel 8 is 2.49.1 Any ideas ?

There is a patch to fix this issue available at 
https://lore.kernel.org/git/xmqqtt3j69r8.fsf@gitster.g/

Thanks

Phillip
>   
>   git-2.50.1# make  -j $(nproc) configure && ./configure && make -j $(nproc) && make -j $(nproc) install && make -j $(nproc) clean
> GIT_VERSION=2.50.1
>      GEN configure
> configure: Setting lib to 'lib' (the default)
> configure: Will try -pthread then -lpthread to enable POSIX Threads.
> configure: CHECKS for site configuration
> checking for gcc... /usr/local/gcc-13.4.0/bin/gcc-13.4
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether the compiler supports GNU C... yes
> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... yes
> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... none needed
> checking for stdio.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for strings.h... yes
> checking for sys/stat.h... yes
> checking for sys/types.h... yes
> checking for unistd.h... yes
> checking for size_t... yes
> checking for working alloca.h... yes
> checking for alloca... yes
> configure: CHECKS for programs
> checking whether the compiler supports GNU C... (cached) yes
> checking whether /usr/local/gcc-13.4.0/bin/gcc-13.4 accepts -g... (cached) yes
> checking for /usr/local/gcc-13.4.0/bin/gcc-13.4 option to enable C11 features... (cached) none needed
> checking for inline... inline
> checking if linker supports -R... no
> checking if linker supports -Wl,-rpath,... yes
> checking for gar... no
> checking for ar... ar
> checking for gtar... gtar
> checking for gnudiff... no
> checking for gdiff... no
> checking for diff... diff
> checking for asciidoc... no
> configure: CHECKS for libraries
> checking for SHA1_Init in -lcrypto... yes
> checking for curl_global_init in -lcurl... yes
> checking for curl-config... curl-config
> configure: Setting CURL_LDFLAGS to '-L/usr/local/lib -lcurl'
> checking for XML_ParserCreate in -lexpat... yes
> checking for iconv in -lc... yes
> checking for deflateBound in -lz... yes
> checking for socket in -lc... yes
> checking for inet_ntop... yes
> checking for inet_pton... yes
> checking for hstrerror... yes
> checking for basename in -lc... yes
> checking if libc contains libintl... yes
> checking for libintl.h... yes
> configure: CHECKS for header files
> checking for sys/select.h... yes
> checking for poll.h... yes
> checking for sys/poll.h... yes
> checking for inttypes.h... (cached) yes
> checking for old iconv()... no
> checking whether iconv omits bom for utf-16 and utf-32... no
> configure: CHECKS for typedefs, structures, and compiler characteristics
> checking for socklen_t... yes
> checking for struct itimerval... yes
> checking for struct stat.st_mtimespec.tv_nsec... no
> checking for struct stat.st_mtim.tv_nsec... yes
> checking for struct dirent.d_type... yes
> checking for struct passwd.pw_gecos... yes
> checking for struct sockaddr_storage... yes
> checking for struct addrinfo... yes
> checking for getaddrinfo... yes
> checking for library containing getaddrinfo... none required
> checking how to run the C preprocessor... /usr/local/gcc-13.4.0/bin/gcc-13.4 -E
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking whether the platform regex supports REG_STARTEND... yes
> checking whether system succeeds to read fopen'ed directory... yes
> checking whether snprintf() and/or vsnprintf() return bogus value... no
> checking whether the platform uses typical file type bits... yes
> configure: CHECKS for library functions
> checking for libgen.h... yes
> checking for paths.h... yes
> checking for libcharset.h... no
> checking for strings.h... (cached) yes
> checking for locale_charset in -liconv... no
> checking for locale_charset in -lcharset... no
> checking for sysinfo... yes
> checking for clock_gettime... no
> checking for CLOCK_MONOTONIC... yes
> checking for sync_file_range... yes
> checking for library containing sync_file_range... none required
> checking for setitimer... yes
> checking for library containing setitimer... none required
> checking for strcasestr... yes
> checking for library containing strcasestr... none required
> checking for memmem... yes
> checking for library containing memmem... none required
> checking for strlcpy... no
> checking for uintmax_t... yes
> checking for strtoumax... yes
> checking for library containing strtoumax... none required
> checking for setenv... yes
> checking for library containing setenv... none required
> checking for unsetenv... yes
> checking for library containing unsetenv... none required
> checking for mkdtemp... yes
> checking for library containing mkdtemp... none required
> checking for initgroups... yes
> checking for library containing initgroups... none required
> checking for getdelim... yes
> checking for library containing getdelim... none required
> checking for BSD sysctl... no
> checking for POSIX Threads with ''... no
> checking for POSIX Threads with '-mt'... no
> checking for POSIX Threads with '-pthread'... yes
> configure: creating ./config.status
> config.status: creating config.mak.autogen
> config.status: executing config.mak.autogen commands
>      * new build flags
>      * new link flags
>      CC base85.o
>      CC bisect.o
>      * new prefix flags
>      CC blame.o
>      CC blob.o
>      CC bloom.o
>      CC branch.o
>      CC bulk-checkin.o
>      CC bundle-uri.o
>      CC bundle.o
>      CC cache-tree.o
>      CC cbtree.o
>      CC chdir-notify.o
>      CC checkout.o
>      CC chunk-format.o
>      CC color.o
>      CC column.o
> In file included from compat/posix.h:449,
>                   from git-compat-util.h:26,
>                   from checkout.c:3:
> compat/../sane-ctype.h:29:60: error: expected expression before ‘]’ token
>     29 | #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>        |                                                            ^
>    0)
>        |                                                  ^
> make: *** [Makefile:2821: cbtree.o] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** [Makefile:2821: base85.o] Error 1
> make: *** [Makefile:2821: chdir-notify.o] Error 1
> make: *** [Makefile:2821: chunk-format.o] Error 1
> make: *** [Makefile:2821: blob.o] Error 1
> make: *** [Makefile:2821: color.o] Error 1
> make: *** [Makefile:2821: checkout.o] Error 1
> make: *** [Makefile:2821: column.o] Error 1
> make: *** [Makefile:2821: bulk-checkin.o] Error 1
> make: *** [Makefile:2821: branch.o] Error 1
> make: *** [Makefile:2821: cache-tree.o] Error 1
> make: *** [Makefile:2821: bloom.o] Error 1
> make: *** [Makefile:2821: bundle-uri.o] Error 1
> make: *** [Makefile:2821: bundle.o] Error 1
> make: *** [Makefile:2821: bisect.o] Error 1
> make: *** [Makefile:2821: blame.o] Error 1
> 

