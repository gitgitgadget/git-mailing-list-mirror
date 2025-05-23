Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E61A315A
	for <git@vger.kernel.org>; Fri, 23 May 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748030898; cv=none; b=F+8ayK10/jxhnfMg5wPqTdIdkJ/uKTvtuej5769A6wRkd54VRFOILUT7J4zTEEu9+IM1v9gH0NdERk7wBpdTm4eg26lza6M+pP3UPxJk5uGXkVrLcrcHMKUIsMYGVwRLfKAuVhIVmRTsxYJHeXuauZfzr8HOeHIc51d/ek7toGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748030898; c=relaxed/simple;
	bh=bHooQxQDRMZuiwjhn1Miw+gGO5RIHgzJxzByfwwAHJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sei7GPsEHiP7JLCs4WQK85PAcsss6aFcoqH+h65fvRtVAdp9RY4dLWLA/dHjf1C2ZQ3MVYdmrAGhQdmcB6sX3pSkzyNBsT+LXMtZpkjVkntLTNu698JAtncZMmkQOcp3fvHGcX1w8+6EKC4uzs2jUhlikVXYzDXnzxAXzNPhOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ef0537741dso317506d6.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 13:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748030893; x=1748635693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP8Yb4/ILBBe/g3X6vfquTJywsB9RfBoD33M9FzI6EU=;
        b=M9oX+zltiMEKscUlWOL63yGeAtieaOUzzZh7as9QKChFnIHSYKHtX6VL7A6aawQJ02
         0K+Yk28ARj/JgruhOFYmeE+wYhovWuCpc9+sSVN03VGlsyupw/pgXCbl2OsJE7hYcoyn
         oLoM6LIaXgZ0i/zRxZ4xEosW1OgR+6HDpteQ+ZplN6vP14eqcpjsE8xDfQy95P9d419w
         FsLzG660mkaeHhc02hLpfJWrB3IKiMRDMINuC/2bh3L2pc02HT2odzEm2NwFQimj5SNi
         PNqwgHMEwkEW4GyIFGVH4yFBKpvFrCMJyrSAcblcO2O/Bx5jPSkF0jWQ6C2YongNuFoG
         UNJg==
X-Gm-Message-State: AOJu0YwOc45Hcm2qOrEjyUov94BH+zh9PDdlkws1atb728jV++07mD8F
	OXp8fnswxCPKv9Qx1nessJAqyfZsOIdklSRhj6aHE47RERtugTy36L4R/IvFwtIjc1XYXCjIOWl
	/YDUhAULhi/2ZQ2+RrNNU6yz3IFl1xZ4=
X-Gm-Gg: ASbGncujK1J51fT0XuWVnlhz0rf9SQkIa8+Ebj9OsSUsiCfpuGiVNxFL/XDdgMoFl2T
	qOSK0ikqN/MXkkCVc03UxGUONvaXvYraF0EKZYx9/58wX3aPib4zY/IWIUI0R69672wItQQUTt8
	KTrHNhKQy5D3ILENoCCfEPtnhJ+64EIcz6BVnmnKpNhTpjMgkycSpxeOeyOOq4eBvVNA==
X-Google-Smtp-Source: AGHT+IFlX78+bwRgYSgXQ/90u8f5m+7eur3tZLsYbGf8qKcOgCWx+D9CNoVPZiYMqQriDmCiHDqlHCXudJRHeKp7ewk=
X-Received: by 2002:a05:6214:5095:b0:6f8:daec:8b7c with SMTP id
 6a1803df08f44-6fa9d32662bmr4567766d6.6.1748030893615; Fri, 23 May 2025
 13:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523193722.68344-1-mark@chromium.org>
In-Reply-To: <20250523193722.68344-1-mark@chromium.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 23 May 2025 16:08:02 -0400
X-Gm-Features: AX0GCFvNRef3U5VSfjA-Amm3FijUdGI9lmJZGTM_fdFkZ4pGCzkJW671dRGxc2w
Message-ID: <CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 3:37=E2=80=AFPM Mark Mentovai <mark@chromium.org> w=
rote:
> $pfx is the basis for the expectation that launchd plist paths formed by
> `git maintenance start` will be compared against. These paths are formed
> in `git maintenance` by builtin/gc.c launchctl_service_filename(), which
> calls path.c interpolate_path() with real_home =3D 1, causing abspath.c
> strbuf_realpath() to resolve a canonical absolute path. Since $pfx is
> not determined according to the same realpath semantics, when t7900 is
> run from a working directory that contains a symbolic link in its path,
> the realpath operation will produce a different path than $pfx contains,
> although both paths logically reference the same directory. The test
> fails in this case.
>
> Base $pfx on the physical working directory (pwd -P), with all symbolic
> links fully resolved, so that the path that the test expects matches
> what `git maintenance` generates, even when running from a working
> directory whose path contains a symbolic link.
>
> Signed-off-by: Mark Mentovai <mark@chromium.org>
> ---
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> @@ -882,7 +882,7 @@ test_expect_success 'stop preserves surrounding sched=
ule' '
>  test_expect_success 'start and stop macOS maintenance' '
>         # ensure $HOME can be compared against hook arguments on all plat=
forms
> -       pfx=3D$(cd "$HOME" && pwd) &&
> +       pfx=3D$(cd "$HOME" && pwd -P) &&

Okay, this seems like the minimum fix[*], and -P is POSIX.

However, have you tested this on Windows? I ask because, despite the
test's name, this and most of the tests in this script, are actually
run on all platforms, and because `pwd` is overridden by a shell
function for MinGW on Windows:

    # t/test-lib.sh
    ...
    # git sees Windows-style pwd
    pwd () {
        builtin pwd -W
    }

My quick testing suggests that this patch's change might be problematic:

    # on Windows
    $ pwd
    /home/me
    $ pwd -W
    C:/msys64/home/me
    $ pwd -P
    /home/me
    $ pwd -W -P
    /home/me

FOOTNOTES

[*]: In the long run, a better fix would probably be for the tests to
sanitize the output of the Git command, replacing (via `sed`) the
actual emitted path with some placeholder, such as "%HOME%" or
something, and then have the tests look for (`grep` or whatnot)
needles using that literal placeholder rather than trying to perfectly
match the path emitted by Git. This approach makes sense since these
tests are about overall functionality of git-maintenance, not about
the specific path in which the person happens to be running the tests.
