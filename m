Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31E30FC1A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836008; cv=none; b=kWaZvkcDAntPKkqov6R6Zt2uYBebaj4eMVes1OcNQ+a3ZcvyKk5CD07XpEyHU09Bu7a3SPXBmLOm7Y67vW4SodPC5Cjm67l3RonmUyJ0K7HH3zy0gQ/h/rTj4AkeErydVO4ZZVf2F2RoGaQrA4Ksl8IS0DxmOIvFgg9HzGgGRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836008; c=relaxed/simple;
	bh=/z29bl10f+P2SGRs6j1tVZzqn7uF8p0KT47J/wK2NWc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r7Qab3UJEFEpJ/nOs6Mz22PpOxNqNAGaFPOK7OwoY04iv0HGPQQCM5wfbRpdJ4E5xIyVdLUjNT7YU0ox0S83LcZ6Hm/Ve+jU54TVcLD9bVQkC4DVNjuIbMaDiczOYfRWW4bojc5ldv/P01PuGbHUmGrTCZKI4Ry0Xfk6V75SyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcoEBqCZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcoEBqCZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso26519205e9.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775836005; x=1776440805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jbyjRX8zzOIT/TyWk4w5JA5EH1SxHIp4Y1ZTCM7U1A=;
        b=BcoEBqCZT+91hlqjnpm01dFp23qXlolxn0hX3FCI1xarrgfWUCW546pDXqjr78Xi/s
         YbnmdL2kjQkSsn8Rxt7jbhNOJ+uWfzDpM9kWUKuaFf/giN6fAP2NhchzwMcWKYTdOAyx
         vvU7LLAyhbZLizCp2mZ21WoyRVncQ7mkie5XLY9tALmReYuKjnSmtTodKO0eqhxMEk/5
         GCYKXCODWbi5BTidMKh3eLDtUd8xYeHq/FdhIj5RFp1AV27S/ujxYH4B08+ZAVUYrU28
         2f8fJlUY6KjHht8O0DjRJd7hyhzRmvQItQ5BQUXo9sSa25NeQImQi34Gl1D2vDc7DvSb
         DzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775836005; x=1776440805;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jbyjRX8zzOIT/TyWk4w5JA5EH1SxHIp4Y1ZTCM7U1A=;
        b=a/jMSTC6xADNMk2tLUZcTVnMDkvhkDaZ49WeA9doMnaDnMw3mqA0xRorDTZtR5Iu5b
         k2WQyO2Cvgkwi9f5ie4xDI3w94HXKnFQuB5Kka+4ZadRfbq91jNSx6o/8Ts4/Zp3NiEU
         V9BcMMcJw1j8MdgPLgL8oc7YhiJpr97+ptGU16dbSrEreXzEefOPLHVYX+lHbyFY7u3Y
         xXYWTvveB65qY/6YdkJECS861q5XeiUqPchhSeH9G6O+8+IoPdoSrFI17RJOuAoxDCwF
         dgvdCFTHV5Jh/zW15JU9kt4FYVXNOWm1SI7nzrJRtQyFTIEZi0yc288o3GQkP/a6aqvn
         KyFw==
X-Gm-Message-State: AOJu0Yy9BGiXx25kPfAikB/nFSWF7HsPvTIVj7/WHFDBhvj5O6BMAGH3
	pmtpoBJo0m3RHdbQ3qzLcPfpmkl1EzyQmuA/e4FD2OJWbGdQSNVMG8Fw
X-Gm-Gg: AeBDieu3Qr2wdVbXFqiTOlZae1CmNwJc/1OdHRkew5NqMuzrO207dx2Y7ofTjQsgcB/
	QuuQVdwXIUxdEDL+rN+DGf7XQpiC7SLn5b4tLtIqCytV8whP18Z9OP5nyuBb26rPWrNIL+UpARq
	xitr9Rh2ty21U3bu/447EgCao6OtJtfHxXRt+WXbDnUNw0TCKlFRckIMiCGtAT3J+rbpgqD4ERx
	VVoLA3IHKEjxs4Dgl2TIE8Kr0tgHWIUsb1Wkh229Mwj3yuqi8356xZn75tVXXxlL+w1NBm/r/km
	JPQXfjIPfISSzOQpTdM6VaMCAXN/1RJuDOYohA6vbA/McnzHgfa+i1uVkecUwMt+ctkUgM/jpt8
	8vECv28PB2J/sIkfawV77wE02mgurL7HUzGgF16ALaR7/hq1KXdOwz1p03Ahj/uXD2Wzd8nSLmq
	GsHl65tSNRprcMcW0Xj9WGyP0881JbNj3ZLQepaiV+MRV+NxWBUX+FTKgrwA6OZrdYbx/gk+ZjJ
	Ao=
X-Received: by 2002:a05:600d:8453:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488d68ae9b7mr38005705e9.11.1775836004618;
        Fri, 10 Apr 2026 08:46:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3d4dbsm78779565e9.14.2026.04.10.08.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:46:44 -0700 (PDT)
Message-ID: <0b67d2fb-3041-4fed-9002-44b7b2e7ecd3@gmail.com>
Date: Fri, 10 Apr 2026 16:46:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 8/8] meson: precompile "git-compat-util.h"
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
 <adkZGavssyxWj27a@szeder.dev>
Content-Language: en-US
In-Reply-To: <adkZGavssyxWj27a@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/04/2026 16:36, SZEDER Gábor wrote:
> On Thu, Mar 19, 2026 at 06:33:27AM +0100, Patrick Steinhardt wrote:
>> Every compilation unit in Git is expected to include "git-compat-util.h"
>> first, either directly or indirectly via "builtin.h". This header papers
>> over differences between platforms so that we can expect the typical
>> POSIX functions to exist. Furthermore, it provides functionality that we
>> end up using everywhere.
>>
>> This header is thus quite heavy as a consequence. Preprocessing it as a
>> standalone unit via `clang -E git-compat-util.h` yields over 23,000
>> lines of code overall. Naturally, it takes quite some time to compile
>> all of this.
>>
>> Luckily, this is exactly the kind of use case that precompiled headers
>> aim to solve: instead of recompiling it every single time, we compile it
>> once and then link the result into the executable. If include guards are
>> set up properly it means that the file won't need to be reprocessed.
>>
>> Set up such a precompiled header for "git-compat-util.h" and wire it up
>> via Meson. This causes Meson to implicitly include the precompiled
>> header in all compilation units. With GCC and Clang for example this is
>> done via the "-include" statement [1].
>>
>> This leads to a significant speedup when performing full builds:
>>
>>    Benchmark 1: ninja (rev = HEAD~)
>>    Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
>>    Range (min … max):   14.195 s … 14.633 s    10 runs
>>
>>    Benchmark 2: ninja (rev = HEAD)
>>      Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
>>      Range (min … max):   10.030 s … 10.433 s    10 runs
>>
>>    Summary
>>      ninja (rev = HEAD) ran
>>        1.40 ± 0.02 times faster than ninja (rev = HEAD~)
>>
>> [1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>   meson.build         | 2 ++
>>   tools/precompiled.h | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index cd00be1c23..2002f4795e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1760,6 +1760,7 @@ libgit = declare_dependency(
>>         c_args: libgit_c_args + [
>>           '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>>         ],
>> +      c_pch: 'tools/precompiled.h',
>>         dependencies: libgit_dependencies,
>>         include_directories: libgit_include_directories,
>>       ),
> 
> Well, I don't do meson, but...
> 
> If I understand this right, this section here compiles all the source
> files listed in "libgit_sources" using our new precompiled header.
> But "libgit_sources" contains all source files under "reftable/",
> which, with the sole exception of "reftable/system.c", don't include
> "git-compat-util.h".
> 
> Now, building the reftable sources with "git-compat-util.h" included
> through the precompiled header apparently didn't cause any compilation
> errors...
> But I think that's just accidental, and if a source file doesn't
> include "git-compat-util.h", then it shouldn't be compiled with the
> precompiled header.

FWIW I agree it would be better to keep the same includes when building 
with precompiled headers. There is some discussion about this starting 
at 
https://lore.kernel.org/git/2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com/

Thanks

Phillip

> 
>> @@ -1820,6 +1821,7 @@ test_dependencies = [ ]
>>   
>>   git_builtin = executable('git',
>>     sources: builtin_sources + 'git.c',
>> +  c_pch: 'tools/precompiled.h',
>>     dependencies: [libgit_commonmain],
>>     install: true,
>>     install_dir: git_exec_path,
>> diff --git a/tools/precompiled.h b/tools/precompiled.h
>> new file mode 100644
>> index 0000000000..b2bec0d2b4
>> --- /dev/null
>> +++ b/tools/precompiled.h
>> @@ -0,0 +1 @@
>> +#include "git-compat-util.h"
>>
>> -- 
>> 2.53.0.959.g497ff81fa9.dirty
>>

