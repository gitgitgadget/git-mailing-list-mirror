Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844913C9438
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835421; cv=none; b=oo9xm6Sbzdxug4PFqr2KmrxSnSVnoEhE4/AGRJGOodIJb5H/n1JU1U1ltuTI9avTNwUSbGy/ZiBmUgKKvZZ02fxWr26IxOlgoM56aWrR3DmVwTfOckUuatPwdOcnAsh6LL+odJ0+FiP4olwoy254daXuCzpDzJAO8Re1EaP37JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835421; c=relaxed/simple;
	bh=kveYGtHLDDTOFwafvkS3QTFsiVm5XaSyb4RPPs8HiNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5QE3v/nvKF3HseBMLLiM9DYGhMsYbGhtp8G6A8rJsFIo7GymfD4l8wWV2AYzD9ZeZekqKUKwNjcoDKX08O6n13XpdrJUm7tFyRUcGXxT7BBDqgZxi+OZfhsQk1XJ6QnkEnF12QiXrSDCATaIZftpHzHllRO3kcUr0HVhX/oQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwZ1ftT6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwZ1ftT6"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1636824f8f.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835419; x=1776440219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BpSyCwFAxPpSpoe+PsNd4aG4fod/5YdJyWLA7d0XC+Y=;
        b=nwZ1ftT6ckFqK+7xqwefQ5/1n4Bogt5/t0GgXDknEfDgTMNJ6GTz8xmcwVHwCJpngk
         05JZ5dPfRtVTIIzPeOP1MWseEzFVHtE11ppEPoMhiU9rJbATd42fb94VBjq+nir0is5F
         pVozQbeMkncFW2FLUA/68geKSHfER4QhqU6hbUxyuaH3yIN3RRVetxnJxZBorYBEp18N
         Sssx7o1Krd4TqSmjGmrxFfBLwJafwLaF/4tqFcO1KsgjgHlP+WakgF2xOYFkJh7NxsF5
         LBd0oCTGHKx7TweYV00gqdLQgFg+RJdvCZIoZFHMGhSe8INOKIF5XEYJnpFxK8u7uszb
         LCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835419; x=1776440219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpSyCwFAxPpSpoe+PsNd4aG4fod/5YdJyWLA7d0XC+Y=;
        b=fyytuFw1E9RoTQoz+jMRrx8uGBs1wfoQbLfvguknIZLL8niKWfqhDy+V/Zp34deCIb
         b4vMl7KjHUMvB8yijaEeSWqGLNo9HD7PybH9EYqrOJ0BF6b/phoQpEp49N8a+Qo//u40
         LPUeKdEfcYz9CBUO052n7s7ae6rIPqJagrDCvutgZRSdcvr4Y9BLkl0vqsW3LiIPruPA
         ED7M2z5yqHd3I8K3BaoA0giOZD0zXViPNCbISkQh/gMgmgdLR0hyaEZs3GvMS588HQ51
         wfpOhIb0d/ayPe3ntphKf65mJuaLo/YATOUuB8wTqjUruvGQb1Crg8L0ndBSaWYI21kq
         CYDA==
X-Gm-Message-State: AOJu0Yy5hiJG65YhEKrkWNIKgE3NozGLQhTFWb4aaMoXUjX5xM7iN9UR
	MlXnBc8UjfuikmIxCSwnXXdhmh6gJlqJ3xwDpwqwHX2pbhXjFzLwRfVc
X-Gm-Gg: AeBDieuOLxqSYzSmxY3TI9naqqWLuy9j3w+tEEmwobYfegnwv73E9JMbAM5YFe6S5VU
	mKh1n457o5/PRAlXkA84i0TWBWewQtJCQ3rGAyzmwY18UQu9Ot67lrjzFWNUnZ7m9ybraQBLVxO
	VP1+KN9gVO2RaoXxe0raUm/Y8Gu9pG1oC8lCBWnOkuqqIpKJHUcPMaIfGiTkJlcbaFilOiAmseE
	xMmxlQZIHjl29GOEOBZYrNNbCNKANJNVmagvHi25GcVUjl3BMlxXVpkcu0Xlaqsbu0exNh2y7/9
	eTLqYMOadCvmsoNxm/OXS4VUlmXYpUZxsUDgucREExcg9PmiAVd0tQQkn5FSPhzZAJZvieq7KcZ
	NhKpIq83uL8+cc5O1qssU0qJRjQmqBAu5FEBQRR7th9Qn4FgtcLRXDu74v3UFf3QMKPQeXJZjAH
	NAdDYJSZMFH9HwSYeuRnyIZoDqk5MjkGFwl4Bm0cjcn3NGHjeixjN/
X-Received: by 2002:a05:6000:2dc7:b0:43c:f793:f1c0 with SMTP id ffacd0b85a97d-43d642da86emr5452045f8f.31.1775835418650;
        Fri, 10 Apr 2026 08:36:58 -0700 (PDT)
Received: from localhost (62-165-238-49.pool.digikabel.hu. [62.165.238.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm8963302f8f.35.2026.04.10.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:36:58 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:36:57 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 8/8] meson: precompile "git-compat-util.h"
Message-ID: <adkZGavssyxWj27a@szeder.dev>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>

On Thu, Mar 19, 2026 at 06:33:27AM +0100, Patrick Steinhardt wrote:
> Every compilation unit in Git is expected to include "git-compat-util.h"
> first, either directly or indirectly via "builtin.h". This header papers
> over differences between platforms so that we can expect the typical
> POSIX functions to exist. Furthermore, it provides functionality that we
> end up using everywhere.
> 
> This header is thus quite heavy as a consequence. Preprocessing it as a
> standalone unit via `clang -E git-compat-util.h` yields over 23,000
> lines of code overall. Naturally, it takes quite some time to compile
> all of this.
> 
> Luckily, this is exactly the kind of use case that precompiled headers
> aim to solve: instead of recompiling it every single time, we compile it
> once and then link the result into the executable. If include guards are
> set up properly it means that the file won't need to be reprocessed.
> 
> Set up such a precompiled header for "git-compat-util.h" and wire it up
> via Meson. This causes Meson to implicitly include the precompiled
> header in all compilation units. With GCC and Clang for example this is
> done via the "-include" statement [1].
> 
> This leads to a significant speedup when performing full builds:
> 
>   Benchmark 1: ninja (rev = HEAD~)
>   Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
>   Range (min … max):   14.195 s … 14.633 s    10 runs
> 
>   Benchmark 2: ninja (rev = HEAD)
>     Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
>     Range (min … max):   10.030 s … 10.433 s    10 runs
> 
>   Summary
>     ninja (rev = HEAD) ran
>       1.40 ± 0.02 times faster than ninja (rev = HEAD~)
> 
> [1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build         | 2 ++
>  tools/precompiled.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index cd00be1c23..2002f4795e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1760,6 +1760,7 @@ libgit = declare_dependency(
>        c_args: libgit_c_args + [
>          '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>        ],
> +      c_pch: 'tools/precompiled.h',
>        dependencies: libgit_dependencies,
>        include_directories: libgit_include_directories,
>      ),

Well, I don't do meson, but...

If I understand this right, this section here compiles all the source
files listed in "libgit_sources" using our new precompiled header.
But "libgit_sources" contains all source files under "reftable/",
which, with the sole exception of "reftable/system.c", don't include
"git-compat-util.h".

Now, building the reftable sources with "git-compat-util.h" included
through the precompiled header apparently didn't cause any compilation
errors...
But I think that's just accidental, and if a source file doesn't
include "git-compat-util.h", then it shouldn't be compiled with the
precompiled header.


> @@ -1820,6 +1821,7 @@ test_dependencies = [ ]
>  
>  git_builtin = executable('git',
>    sources: builtin_sources + 'git.c',
> +  c_pch: 'tools/precompiled.h',
>    dependencies: [libgit_commonmain],
>    install: true,
>    install_dir: git_exec_path,
> diff --git a/tools/precompiled.h b/tools/precompiled.h
> new file mode 100644
> index 0000000000..b2bec0d2b4
> --- /dev/null
> +++ b/tools/precompiled.h
> @@ -0,0 +1 @@
> +#include "git-compat-util.h"
> 
> -- 
> 2.53.0.959.g497ff81fa9.dirty
> 
