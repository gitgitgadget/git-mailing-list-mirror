Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDF3F7E94
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527617; cv=pass; b=qR7YFRz2vQuc708/9tT7fv3ai33KeIa7ygpzW2+B5DK/n3IZGr+NeKJDJlWJH3WBM0L3CtBCmIWHyy8Qsk/IkoaJVPtpSH6eJ86RWrK0WvOzRKlnyI7F5vWdk5bko5Zup5PQDhPC6/7E0jCjtwoFVWvdr68IFH6j5zztesKcgCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527617; c=relaxed/simple;
	bh=iHKThpzcrNGZ9mem82LRVTPSV3bFQyjCoRy26BuKz8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKMfwV46QB/sv9c9vyx5g299HUHiRhq4VFv7t/U9G7i5TKUXNKtojFCbI/V21IjN/SObdW1oiwH75aV1kIiKKUZitnIDIQnrduIPXqFWjNZNWRSmpTXfmsL23/DlAUTulEz32fXyUeCuBpsGJ5t6NVnUCAjAokAINaol/cWQ4nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxWjTpU1; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxWjTpU1"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a3ba1653fso8965307b3.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 05:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774527615; cv=none;
        d=google.com; s=arc-20240605;
        b=Xj8IvyEVuMl8hwweFt6YKAlJKg1i6gWNvkGtUw4XNbvZgJu05RnEwEZMAWTIxa6gel
         EGJe5H1rGtRfvMYxuIxDf8pEHTFxUei6qWj7HdCrBO6ankWYknzB0sq71XQVjEIUmakE
         7/8Eru96Hsz+r8YJQiYdsgMXqruTycLTu3wkxeJxkV+q+xOIyxqGjVBxJdKuA62leMKv
         ZFnmg3C0HI93zwUp95khSDjeQwzUcsnjVvd1RJb95o7GjoBRabFxmiuREakOQj2c+2TE
         OLe15qC0veUxrnMRGmyIKAfEsD8p0axH2nHKYu2pUs8pVeyc9Fuo+ij3rNO5xsGlTDU8
         IM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NAkokcXK6SFRJAmoCVLTumKVK8Q4Ez+HBIPr2iAIPQ4=;
        fh=ap78LVOoKD0YrR5ugAW6kumO9miOC+XCn4ap7JHMCT0=;
        b=LnWLotYG1+UIxCvnJ7OE19vtNTeNwppobdErij72LmdIPtVe5hv20eDa0EnmQR52G9
         SaOANv2tGZcqAtg1Xd0DtOmNVgSd/+k+Bt1b1P5IpLg98lN0csvgpzdCxuNp4Lwhw89p
         +8IruDoGQBRM6hHx5p0ZYSGw3HxOJcjrPu6jGRt1BgVvro5hABkekFkmqlmlKbnEDJ6j
         TebS8ezWYr3lREF7HRU2M6tn8V681Y5FQ8k3OROl+z88Ab8Gi7qCUybaPzXAtI1El93i
         lgnzEqyDufyfn+9zzWJAUiHQIuQq7qg/vMBmaBLG3+bZF0Bg0Vymt6Mihp+BL17Pvl7A
         zR9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527615; x=1775132415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAkokcXK6SFRJAmoCVLTumKVK8Q4Ez+HBIPr2iAIPQ4=;
        b=fxWjTpU15AZHoiR5aOvn0msTx7wOkMRKaTbxy9s+dkzrb0VuCUDXHDSXxv+MoUBTmm
         xAY6IwGy2nYkQxjHyGJydw38HdfKFN5NxYKzVIacj3u1CF1wuqhvskf3AOV1JA2+SaWZ
         XVuaEQkMjNAeqqLAKBDyzjWRVkzB0nk0a/LmIES3pf0efB3lJ2ViGBr5v2TRcG8qfz6k
         rxZC4nB3Q1VlhJoEDloKbe9IkOfScAkb4r/XcxMxfvuAe6rPKu7D7sMreQRxOxqFVdTz
         FIAKCJuVJ7WqkYLvl05EYtXHJ0TuOkalPssw+mZwUmL0+ak89SQ3Yi4gLVPn6fyNO1rk
         97RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527615; x=1775132415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAkokcXK6SFRJAmoCVLTumKVK8Q4Ez+HBIPr2iAIPQ4=;
        b=RO9jO7R5pyiT4hlA4NhpdtYGooyRjhC/y8Efo8PPENKa5avJ/Gcq9pbXIwc8Gpl+M6
         J+B6gmooa8uC0xf6Z/0QDQOTH+itVHva/RJtdjtL3PmayWZcyqF4XgGGmdK/6wxMoISG
         ly86FWKHNAhsGZxICDfMQTp0Bs6N4GJXqJov/tnY4z4/EWfiRCJGANQtvBAF10HBZzMU
         Y7xl/hMAREl+AnaTLDmNdx+tx7H+O6BHe09gmTgHop8jxo4bjS9nIz6sKUtuRKs9ml99
         CSSnfhyL7jLXzhog+9kui5MFWX5oSMgUwgf+3GFoQXvxxP6Yx9Hs1d4+y467t44zIVaf
         zLUw==
X-Gm-Message-State: AOJu0YyUAzbhik/F+4emOUJAgcCmQtLu1mfBwSlNN9Q6iz/XXwfeCHE4
	EaX/fGreWZqIhCYRwZLIT2fzhMnSNsBZMVpj+JnTudbAmM2O5q4DBUY60bl8hQy9VXN6DCaMM93
	aW0RMzg3Lb3HKsVtx0jSaXg52JYIEGVg=
X-Gm-Gg: ATEYQzxFn5/lvq4NElIXerI00elgzY5ToXZpotdQsc4KVrRi8d9ydVTy0zGRjj6TICl
	FccQVMWZGVyZaGFT66lw/Z8qoiQmuS3rjd6HFo15ElJMI+OVrv4TQPHxXKpxn9/ggR7yQC1XI/y
	K6jvE6ecKvfuyHgLjL6ovYoqNOkZiYMTeGN4HVTU200YfdMcE9t/FfNyYCl5YceDZwJhmqYh8ds
	b+vrMI7q77NJLXbQqbfgNsgEa570ufZidts4znucXdDAt2jyna5A1fJPW9kNQUbgVQBFr6D3+u4
	jX6pWAr5j2tw4hzB5dauAaZZwX0r39+AZXAI9YK/bHsRmrQLx7mPMzjYDnf8LNz9F+rW7Q+icDz
	3hdZ4//BVqgG1t5zsKqP2xIM=
X-Received: by 2002:a05:690c:c4e9:b0:79a:bf27:fe5f with SMTP id
 00721157ae682-79acf335a27mr71953847b3.2.1774527615120; Thu, 26 Mar 2026
 05:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112149.53050-1-zakariyahali100@gmail.com>
In-Reply-To: <20260326112149.53050-1-zakariyahali100@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 26 Mar 2026 13:19:58 +0100
X-Gm-Features: AQROBzBfZF8Et3FPIai9eh-9ymM8byKk42ZEgyjSjxMmCgLEaKpBIQ0EyEH0UmM
Message-ID: <CAN5EUNTSO7KvtO02c-EHJTK95rmcZKRBtKsn8kjNid1qupWZ0w@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t2000: modernize path checks to use helper functions
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, siddharthasthana31@gmail.com, ayu.chandekar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zakariyah Ali (<zakariyahali100@gmail.com>) escribi=C3=B3:

This should be sent as v2 in reply to your previous v1, not a new thread.
read Documentation/SubmittingPatches and
Documentation/MyFirstContribution as I mentioned in your v1.

>
> Replace bare 'test -f/-d' and 'test ! -h ... && test -f/-d'
> assertions with their dedicated test_path_is_* helpers.
>
> These helpers are better than the previous 'test' commands
> because they produce clearer diagnostic output on failure.
> For example, instead of a bare exit code, the helper outputs
> 'File path0 doesn't exist', which makes test failures
> significantly easier to debug.
>
> The replacements are:
> - 'test -f' -> 'test_path_is_file'
> - 'test -d' -> 'test_path_is_dir'
> - 'test ! -h && test -f' -> 'test_path_is_file_not_symlink'
> - 'test ! -h && test -d' -> 'test_path_is_dir_not_symlink'
>

The commit message is better now, but it's very verbose. The list
about what helpers have you changed can be looked at by any reviewer
with git log -p and the example only describes one helper, you should
be able to make it more general with something like: reports loudly
what expectation wasn't met, therefore making debugging easier.

> Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
> ---
>  t/t2000-conflict-when-checking-files-out.sh | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-confli=
ct-when-checking-files-out.sh
> index f18616ad2b..96bae6c53d 100755
> --- a/t/t2000-conflict-when-checking-files-out.sh
> +++ b/t/t2000-conflict-when-checking-files-out.sh
> @@ -58,7 +58,9 @@ test_expect_success \
>
>  test_expect_success \
>      'git checkout-index conflicting paths.' \
> -    'test -f path0 && test -d path1 && test -f path1/file1'
> +    'test_path_is_file path0 &&
> +     test_path_is_dir path1 &&
> +     test_path_is_file path1/file1'
>
>  test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
>         mkdir -p tar/get &&
> @@ -127,9 +129,9 @@ test_debug 'show_files $tree2'
>
>  test_expect_success \
>      'checking out conflicting path with -f' \
> -    'test ! -h path2 && test -d path2 &&
> -     test ! -h path3 && test -d path3 &&
> -     test ! -h path2/file0 && test -f path2/file0 &&
> -     test ! -h path3/file1 && test -f path3/file1'
> +    'test_path_is_dir_not_symlink path2 &&
> +     test_path_is_dir_not_symlink path3 &&
> +     test_path_is_file_not_symlink path2/file0 &&
> +     test_path_is_file_not_symlink path3/file1'
>
>  test_done
> --
> 2.43.0
>
>

Code looks OK.
