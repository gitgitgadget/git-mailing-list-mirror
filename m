Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C0247280
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451828; cv=none; b=Q9ldJVFcZwAyQNZ/bqzXXOy9PqY4ehvOd/n6QUrJMTtvWAyY6DZn5keqhbDgISMyp2NEuFrXnk+iAdPTI2wAVY4vBWLT7Y24sFIKivdPJyq5wUdPRLNufuAvnu+AShWdxDQVGIcfXWF4/t5g7Ko3S9QfBhXE4Z8C0rHQhT8lE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451828; c=relaxed/simple;
	bh=ImkC0CD+QTRdDyH7PtFIfapjrg9DoW8dObgZi0gOnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2bONpQsCNsKdVy6Uwz7XrDChGf6XJmZCBHLp4qRgXNLZinA9UKzgnxWJUr4STcRc2hIvoZIrKU46W9cagamIOoS9ET1bxF9qVE72ZLkhgE7qa7lhrszMHLG26+/K767w2dn6JCLp5mKLREjaEP7kQJDwVjCIBbo/RyAWsQMnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alRuEcpB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alRuEcpB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ade456b6abso653432b3a.3
        for <git@vger.kernel.org>; Thu, 11 Dec 2025 03:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765451826; x=1766056626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dzTgj8zvd/ywRSE9ZVxM6aXWAQTiboepUuuQw6mqeVU=;
        b=alRuEcpBX4qhyUOLrERYYOKOrTAWP+edzAS9oq2ezTvSKRpfEBvIx2DfpBAWukJxcj
         2XsTEwMp+TFEfeD4rG+jV/xldE8+r/4k3gJrFSwa5Yyjm6gUKIc/iL9uik4YsM0FF8GK
         JA7Z00IsnLzvQc2hEsN91NRTPViqSl6g6zJ1SW+6A26fvoHmtlY4obl++e8+Q7nLUv7k
         l5yWB+cZpmWQOPqFtXUrqRIbHOwlwRLtVF9xdsJsv2TY2sc2o1s3nVCbcRSgO/HGygy9
         ByQR8nmFhX7G05Nv0lMaGUC81G8ymPm6aL4BWSlozZ0WQ5AORbWGeuDLXQfF5d7IJLbr
         pZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765451826; x=1766056626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzTgj8zvd/ywRSE9ZVxM6aXWAQTiboepUuuQw6mqeVU=;
        b=pr75Tl4g/BUNgYfXo/ZztLXpbfLrsc9CXzpQ4dJFxwCBOvOJpf/JwzqZaevu7+bYp9
         PJ9mEmCizCflK/4ogR8DS8prsnOoF42+ChdQT6dfETuxZOkdYLB6BH9FplDql0jcilD2
         Xi0xYJmpyZQhyqbWX8GOs/UFQ9tA788ALSwwFDhj3JiFDfxQG1jxTC6u5PgR5liuVf7n
         NbN3XUKxo5QRY8U1hEuZxPtqBPMKEtWRjvhooiyaWr3exlUj0MWwwVQ/dP05+rAodCrA
         9d6beoWZwv+M5LqkYwcEOCImhLk4Yzmc8y9NivzQtwChLNvEqnYJCzD8VGj6HzOlOM8F
         Mmww==
X-Forwarded-Encrypted: i=1; AJvYcCX8JMrOfB7Gpx98ztq6/+3qmui/ktd8CJVv6GLZkBaU42ibF/6Q431Fb4B8INtuP2hqWaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CpzVrycvMWrraoKEQeT+FocbCGaJqNWtfX2ELcVyX1XFfMfM
	v9+akVIFtp0R4tuPcGwE/L6sekGhj4zNR2LOwtbQ3o/wBc3WWnjlFf8n
X-Gm-Gg: AY/fxX7ebvgHd1ITzJ7EBRmg0x8qLT53ou1bN1hL3z7vKpJ9jXCmgD4+9EKw8okh+K7
	1JEeJAKDl4FUOhxjiUpUZyXbbMVfx3cVAEm6k2xHHe/mJA/rSnuKDcFuaCkg/Y9zeMj6I5cYlQG
	U0wWm4/QiOfciCBAhxmLo33pN2Ht9kqVc9LDEl8pDVVkB/BMyaAEFMJ2iDC/68Guv78dIH03YMx
	/IwlRF5uCJOkcBmz+Ug3yeOnSmJuMXJapB+s2tTRmYsVHryZJJ6/h1rJ6Q2C9N448lScMzH0iDt
	2QMNflF9FsP8h3u4UBFukcUTD0S6f4f+KA4sMoWZCZXDBVHJbQvfOFjxQd+y4vIKrtQPM/pzrtB
	+cMs7QWHlDIwsdimfMoOyVX8oZ7HsmmQT174Idcf2ebPYett6UNjXC5GQWPugSrQKPT5QgBbJXv
	w3/MXsyGV9IHRw3SlzGb4jbkBdut6UELnAc0LxpEL65bD3oOhIL07WPUsNDU/5zkl79W8vEOp5Y
	gdQZQooQ+Twkcgn0EfxtwFtzaU0gbat/T44HxA=
X-Google-Smtp-Source: AGHT+IFhZd6/avVi02JvHJALQc/rVtvVpbJqg+HyOCBMALC5NR3W682unU2+/bFGWYrnJPyONRPx7Q==
X-Received: by 2002:a05:7022:2385:b0:119:e56b:91ed with SMTP id a92af1059eb24-11f296a4086mr4199676c88.30.1765451826016;
        Thu, 11 Dec 2025 03:17:06 -0800 (PST)
Received: from Carlos-MacBook-Air.local ([2601:640:8e80:3680:4def:aa81:a197:84f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ffae2sm5624849c88.9.2025.12.11.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 03:17:05 -0800 (PST)
Date: Thu, 11 Dec 2025 03:17:03 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
Message-ID: <vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
 <1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
 <xmqq7buthgq4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7buthgq4.fsf@gitster.g>

On Thu, Dec 11, 2025 at 11:53:07AM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> >> Slightly off topic, but should another patch that adds a `NO_HOMEBREW`
> >> Makefile flag similar to `NO_FINK` or `NO_APPLE_PORTS` be added to help
> >> drive this?
> >
> > Sounds like a it could be useful to someone.
> 
> Hmph, how?  When you personally use fink or homebrew or whatever,
> but are building binaries for others?

correct; I think microsoft's git keeps a patch to do something like
that for other dependencies already.

the OS (at least up to the point were they drop support for Intel)
has EVERYTHING compiled as a fat binary.

% file /bin/ls
/bin/ls: Mach-O universal binary with 2 architectures: [x86_64:Mach-O 64-bit executable x86_64] [arm64e:Mach-O 64-bit executable arm64e]
/bin/ls (for architecture x86_64):	Mach-O 64-bit executable x86_64
/bin/ls (for architecture arm64e):	Mach-O 64-bit executable arm64e

it gets even more interesting when you look at the older releases
that also include support for 32-bit Intel/ARM/PowerPC.

> I am looking at relevant parts of Makefile
> 
> # Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
> # installed in /sw, but don't want GIT to link against any libraries
> # installed there.  If defined you may specify your own (or Fink's)
> # include directories and library directories by defining CFLAGS
> # and LDFLAGS appropriately.
> #
> # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
> # have DarwinPorts installed in /opt/local, but don't want GIT to
> # link against any libraries installed there.  If defined you may
> # specify your own (or DarwinPort's) include directories and
> # library directories by defining CFLAGS and LDFLAGS appropriately.
> 
> and notice that /opt/local/ is mentioned for DarwinPorts.  The patch
> that started this thread talks about defaulting ICONVDIR to that of
> Homebrew if available, but the new code checks /opt/homebrew and
> then /usr/local/ (and let it override it).  Should the log message
> be talking about DarwinPorts as well?
> 
> 
>     As a workaround, set the default libiconv location to
>     /opt/homebrew when the user has one from Homebrew, or
>     to /opt/local when the user has one from MacPorts.
> 
> or something along the line?

Since the original patch was only meant to help with Homebrew it
might not be worth mentioning the OTHER package managers IMHO.

I am hoping also there might be someone else that might be using
PKGSRC (usually in NetBSD)  or even gentoo's portage for that.

But I agree with you that the way we assume Homebrew is THE user
package manager that the OS uses might be problematic long term.

> By the way, for macOS newbies (like me), I wonder if a patch like
> the attached may help?

Did I read that correctly and you had found yourself forced into
running macOS at least somewhere?

> ----- >8 -----
> Subject: [PATCH] Makefile: help macOS novices by mentioning MacPorts
> 
> Since Aug 2006, the DarwinPorts project renamed themselves as
> MacPorts.  Those who are not intimately familiar with the Opensource
> ecosystem around macOS from olden days, the name DarwinPorts may not
> ring a bell, even when they are using MacPorts.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git c/Makefile w/Makefile
> index 7e0f77e298..be027218a5 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -95,7 +95,8 @@ include shared.mak
>  # and LDFLAGS appropriately.
>  #
>  # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
> -# have DarwinPorts installed in /opt/local, but don't want GIT to
> +# have DarwinPorts (which is an old name for MacPorts) installed
> +# in /opt/local, but don't want GIT to
>  # link against any libraries installed there.  If defined you may
>  # specify your own (or DarwinPort's) include directories and
>  # library directories by defining CFLAGS and LDFLAGS appropriately.
> 

It took years, but I woukd be honoured to provide a:

Reviewed-by: Carlo Marcelo Arenas Belon <carenas@gmail.com>

Carlo

PS. Sorry about the mispelling of my own name, but had yet to figure
out how to configure UTF-8 correctly in my latest setup.
