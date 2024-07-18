Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A77EF10
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292390; cv=none; b=fzMA3tr0ez38emVrCusOndTV5TZdpx5qQu1MoID02WJVf4LTweblBmvn1k1fZVm15wRKyFFfD30MyaVKU1V+lQPf+IaYLspM8hnvxi3wvgnWV/MVClmKFSRunEKeEgWrJiTrZi8cWSIxWUGNG+waKa77X8RkoMvCD4vaqKtpOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292390; c=relaxed/simple;
	bh=q1Qr03QAKh8qCzjXnZUScnvv0ctZwxIVYI1Mhnbah5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLTC+vOmDSlp4QVBiCuQ1tHYOragkViVau84KAI8Ce3HfX0wtfkn6vXsf49+wl/6uYVAXwYscrhO3l2KGQ4bL2dpVgkkGT9UBHHmC1rAQ4xYvbIkqYMbq3odrXaT4EUF9gvlfbxD09szZmWAHEc7DSTFqMZHsM+mGWQ6Gaajy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TheI7PLc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TheI7PLc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc424901dbso5372365ad.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721292388; x=1721897188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQPC+1V24rDHdWYxjopi7PyTl8x/loOMY8cGHqCGJWg=;
        b=TheI7PLcGkIbBAMGNEmzQfXxZ2VvQ6ER2Hi0sZJ6IIGeFzUyC9T3f25cd9NxyQtAp0
         udOuDTnX2ZuxGRrDqbG/2Ck1uWLnJrWTweHoA+54bb+x2UAPPmkK60MribwFZwsuHAjI
         QPiEiCCQSUr65Sitz2URiLNt9GbBw3Z5U/HkeoaSo9DfMBF0IbBwMYu3XgkUYT97YCSZ
         FEsMY/if8NuFC4HoJM1dSK4mx0d0tRKXchkEvVJBL0zE2ZWzk67IL80wOysbibCBSF5G
         7YI8ZJ5gheN/YRUpAfXC7d6P4foI253U6JjKiwBKaWvJE46n+V2EsAzJR3bxfnmqhbk8
         xGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292388; x=1721897188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQPC+1V24rDHdWYxjopi7PyTl8x/loOMY8cGHqCGJWg=;
        b=jMoa5qrSD3zcbC2iti4Sgnt1hWagEuim1fQJ7sVSoU3TQmUXnvTbFxVzBt6bZ3mvei
         8H4mDxxlHR8xPbypZWVGJHHiK2DQEq0idhHgenfPZFjqvdQwAqu3IhjFOYTSR6P26xU4
         tTZ9+SUktF7I6kPyAC5dshBz9NoQQ1Wdj7FQuV6oyZ1rClhzkggLk3pqfX78hExPUk1V
         kaLO6tLy8A8KJC5fONLWsfAQ8RkfVUZ/sLGR5WZL6IY9gF4xuiRrn0gmNvuc+9I6HEk2
         r5CKO5995dgGbrB/cjPEkvJf9/AbseiUvIaCX4LTBHfbOJZFx1qe6071028K+UJ1cCyr
         wGwg==
X-Forwarded-Encrypted: i=1; AJvYcCWck7W0qjEsyN5wv/78fYJ9GpqT1B+3+yO9NrZ4XT/G2IOSFki/2Y9rmB1BkmoPgO5zQKImYcpz5kH6kwx4iVsme3Xc
X-Gm-Message-State: AOJu0YwdTi5BAi02RJdETgAR9qke8T+afyJk6oa580iNiq5uxQnzQGQh
	7MBYa+xbbUkiMUlC7ONUCZJd8arPcATc6JZD2lMFSvTutFB01kHLDsJczg==
X-Google-Smtp-Source: AGHT+IH3Jbj6Mx4JQDFrj+Syhzsx4AuGtEI4Kchm15NXkLYBFD0lRSPIRbtYYeJbT3yZIj8CGJrz+g==
X-Received: by 2002:a17:903:22c7:b0:1fb:3e8c:95a6 with SMTP id d9443c01a7336-1fc4e6b7a01mr28863785ad.40.1721292387593;
        Thu, 18 Jul 2024 01:46:27 -0700 (PDT)
Received: from localhost ([14.191.223.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc530bcsm87792995ad.278.2024.07.18.01.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:46:27 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:46:24 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
Message-ID: <ZpjWYHvCa_Sb_wwk@danh.dev>
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
 <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
 <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
 <xmqq5xt33a10.fsf@gitster.g>
 <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
 <ZpiAcJuAH50UlHIX@danh.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpiAcJuAH50UlHIX@danh.dev>

On 2024-07-18 09:39:44+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2024-07-18 01:02:54+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> > 
> > 
> > On 17/07/2024 23:53, Junio C Hamano wrote:
> > [snip]
> > > That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
> > > Luc's patch is a sufficient fix without any downsides, no?
> > > 
> > 
> > Yes, assuming you're only concerned with 'make sparse' usage.
> > 
> > BTW, I didn't expect it to take this long for this issue to come
> > back to the list! I expected it to almost immediately cause
> > problems with the sparse ci job, when the version of Ubuntu was
> > updated to the LTS (now previous LTS!). So, I just found a simple
> > solution for now (which turned into 2 years).
> 
> Well, yeah, -Wno-vla would work, I used that macro __STDC_NO_VLA__
> because I'm not sure Git want to use vla or not, so I only tried to
> disable it for system headers.

Eh, I replied too soon, -Wno-vla doesn't work with my compiler:

     $ rm -f builtin/am.sp && make V=1 builtin/am.sp
     cgcc -no-compile -I. -I.   -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pipe -O2 -g -march=native  -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"git-compat-util.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"'  \
            -Wsparse-error \
            -std=gnu99 -Wno-universal-initializer -Wno-vla builtin/am.c && \
     >builtin/am.sp
    builtin/am.c: note: in included file (through git-compat-util.h, builtin.h):
    /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
    /usr/include/regex.h:682:41: error: bad constant expression type
    make: *** [Makefile:3263: builtin/am.sp] Error 1

    $ gcc --version
    gcc (GCC) 13.2.0
    Copyright (C) 2023 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.



-- 
Danh
