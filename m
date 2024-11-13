Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020B166302
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515462; cv=none; b=lls8KtIbL7rFw7/ZJQrWtOMHiWz5/c/qtdEugyYY8CMi2d8FpIOZaa8aYtXx+Gqx5YpEXL9deMnR7D613F66qygQ+n407CAwitKrQeVybskSfx1hzYej7rb29tLUg94MgtRxr73L8frJoBrI70+SLouS3HA5QcrRs2cx0H9mkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515462; c=relaxed/simple;
	bh=wkXC3uLqm8ReJIxhOXZpnRWNBS4NwOo7HaZdrUXSKwk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aa1DRjslaN5yK9sXCqiqdMFIuJqG8qI2hkpNGek9/A8d5Dwg1OxJ6ea+R9k27a6StG8felBwUSq7ddCZPiF1Kq4s9KBGmA3wlpCbLVH9j/HJ1Wnnap/Sa2y020jKkrzLFWJ0XWUrbvcCq2Y+P4bE03csZZEurFbU2R//TLagZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QebQscnl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QebQscnl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so62203535e9.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515459; x=1732120259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY0jo3abr+Aj/15OWFq1nGmwZxnw3bPfrcfjnXt7GJA=;
        b=QebQscnlKhxswuzxZcVUEZYR+aVGpqhzSD45dwpZUeEHLEwOYfN4RFox41HZ3kkr+t
         ho+KLjaePi1SJr1ZyeACJ9lcB3dpXk4GQb/oHFUgE3I6L9dkg9mxBtMC1SoPoJx+muGE
         qWVe0azz8L1FBaVlN0vFEoVq74tFZQ5f9c20cdcWXg7/d3ma8txNGdqbtTRZdzbZfPW1
         iOuO+PhEIbT21WtVwXPy/IpVaw334QPMGnj1sa8mtJqfC2iSOIxK+dEnqwZd3zfKg7C1
         iLZAp+JmuGQkQAHFFnci1Ce7Ls0tQD2DoPPJM7QbblieRyC09C8fOqsoC6sh/rT2Cyxt
         dCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515459; x=1732120259;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY0jo3abr+Aj/15OWFq1nGmwZxnw3bPfrcfjnXt7GJA=;
        b=E/vYE417x3zG/KXkETgwQU0Q1jlu//VLR3PL8BmAjBOuLEdGGhDWgF5PRFUI/jbFRX
         IPmWwsM84VnbjRqFVV2/NBorE+7pj3FVzI1/DNc6JQilce10MZwpvAlYJqxR/PRJjsex
         tR/O//maHIYrYNSeaALzv9OJVHVOjbaQThFpMZGM7qaJvRzMlRFIKb83xcgP8Id6mCbX
         l4NBGODGaTDoGgwSXhokzRKpBp11mcx15RFFrCTvNeCAkV7liYM5Ur8+mxZSwFETK9/7
         gCD4BYjkUrl4/MPdALkB0zHRiQ43HvwbB282MwE7vHI6wZqnN3zS/DGTf1Baw9fDqzA+
         L9dA==
X-Forwarded-Encrypted: i=1; AJvYcCXxwsgNAVKB/jdqt10bScCWV4UeaDPeDf4EsDiqHlKRUMlwc9xiSca8goU4YbHxe7AVPbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWuxBq34zGCScFryKtwR0TXPxMFhy50N2/ZcNEi+k2MFfEwD2
	tUjWY9PN0+Rc2T+5kM3FiW5I6MhxsUIBEM6smSX5yhy3byR8g0Bw
X-Google-Smtp-Source: AGHT+IF0uJKmiWHT7N0KF/PHthdPbx0d+x8aD/3wFyX3r/IhaI9OCLEaV0bxSZ7qQn7gy65rfa9gOQ==
X-Received: by 2002:a05:6000:79b:b0:382:d0b:1f2c with SMTP id ffacd0b85a97d-3820df88144mr2900432f8f.41.1731515458324;
        Wed, 13 Nov 2024 08:30:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea7c3sm19227022f8f.80.2024.11.13.08.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:30:57 -0800 (PST)
Message-ID: <cf51bd62-0573-42ba-8784-643bde347d10@gmail.com>
Date: Wed, 13 Nov 2024 16:30:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v6 18/19] Introduce support for the Meson build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>,
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <20241112-pks-meson-v6-18-648b30996827@pks.im>
Content-Language: en-US
In-Reply-To: <20241112-pks-meson-v6-18-648b30996827@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 12/11/2024 17:03, Patrick Steinhardt wrote:

I had a read through to see what the meson syntax was like and it
seems to be quite nice. I've left a couple of comments below. It's
an impressive amount of work to get to this stage, it's a bit
daunting that replicating everything in our current Makefile is
even more work!

> +#      # Set up a build directory with 'address' and 'undefined' sanitizers
> +#      # using Clang.
> +#      $ CC=clang meson setup -Db_sanitize=address,undefined

Unfortunately when building with this the tests fail with

==217115==ASan runtime does not come first in initial library list; you should either link runtime to your application or manually preload it with LD_PRELOAD.
./test-lib.sh: line 1080: 217115 Aborted                 (core dumped) git switch -C primary
error: last command exited with $?=134

because we don't wire up -Db_sanitize to SANITIZE_ADDRESS in
GIT-BUILD-OPTIONS. The Makefile sets a few other build options as well
with SANATIZE=address which we should replicate here. I was suprised
meson wont allow -Db_sanitize=address,leak.

I assume that it would be possible to set some default CFLAGS to match
the Makefile and have something like DEVELOPER and DEVOPTS if we adopt
this? As a contributor it's really convenient to be able to set
DEVELOPER=1 and have a sane set of compiler flags. It's really good for
the project as it makes it easy for everyone to compile their code with
a standard set of warnings enabled.

> +if compiler.compiles('''
> +  #include <inttypes.h>
> +
> +  void func(void)
> +  {
> +    uintmax_t x = 0;
> +  }
> +''', name: 'uintmax_t')
> +  libgit_c_args += '-DNO_UINTMAX_T'
> +endif

I think the logic is backwards here - shouldn't we be defining
NO_UINTMAX_T if it does not compile? uintptr_t is optional so we
should be checking for that and defining NO_UINTPTR_T if it's missing
as well I think.

> +if compiler.run('''
> +  #include <stdio.h>
> +
> +  int main(int argc, const char **argv)
> +  {
> +    FILE *f = fopen(".", "r");
> +    return f ? 0 : 1;
> +  }
> +''', name: 'fread reads directories').returncode() == 0
> +  libgit_c_args += '-DFREAD_READS_DIRECTORIES'
> +  libgit_sources += 'compat/fopen.c'
> +endif

This checks a property of the build host so should it be guarded with
if not meson.is_cross_build() as below?

> +# Build a separate library for "version.c" so that we do not have to rebuild
> +# everything when the current Git commit changes. TODO: this only gets set up
> +# at configuration time, so we do not notice version changes unless the build
> +# instructions get regenerated. We should refactor the source file such that we
> +# can substitute tags in the file via `vcs_tag()`.

There are three version dependent strings GIT_VERSION,
GIT_BUILT_FROM_COMMIT and GIT_USER_AGENT - can vcs_tag() handle all
three or do we want a script that writes a header?

Best Wishes

Phillip

