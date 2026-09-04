Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDC412BE7
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498071; cv=pass; b=OhHkMNapO4Kwbg5LKfqgALuv9UgPJVvnOdotNZT9R9WfEma1Q5YoVU70SCFsx8c8f1f7EdCPu/IzAqHBwks9FpxdBtiqPSMZg0dypZ/E8PWc5o7r1OTHlAq1FZUi2pxrRYpfgKIGkZYVe2L89pU0dJus8RLSVRmbf61KsTwNzFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498071; c=relaxed/simple;
	bh=AJlwBXGSp0deiUS6Ip/B6NI343wcppyeCtH/HZ/c7Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy5w83qkj4fV3MTZbEPCfIOm9/9UWvvOk7nr0zK+v6uPlcCuUFKoen50rYC9Qqxx4rCIuyUQviUxFqzIwuqA595OX1MdMPHpc6TqSyM/pDf5n57GNj+E9FMldX8iH6nV+l70mLlBxmaCKtqNe+6ZpGZ0p4SJ1V7XzwPwlS98M44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiNl1Q7g; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiNl1Q7g"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b37782d003so470192eaf.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 22:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788498069; cv=none;
        d=google.com; s=arc-20260327;
        b=r1+YA9q8e19Dg92nqONAc4rI9QmmlNdD7nhKa/g9Kma/TINSh53EaWysGcFxpz67GD
         tWvOEqh+d8ENfhUEXH0ZOcXSFIvLXizL3N0RtN9xg5hhNzE2POu7+W0XPOmHtqU6esxT
         6OhtIp6CQ/sghAdcIhfHbVxSTMpMLs4HAMheK0VGjMPRS8DjOTW0Tr3DEWyxUmK/0zyY
         8OcVEWjAcRWu8SwX8uHb/Qiqz5JkIeUUvElUnOiOMF8m9bmVgTI2mgmwT7NY4wd/L0xX
         9E+jV4sw9nvM8IsMnUC+nNjKZpmgYceYsjYBPO+nVdJaJIjtnJnsba73NPXe9URfyAW5
         nmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noXKCjV6cyYbnL/74/FDy38Kcnz1vBvSjgouzbrslPE=;
        fh=vJKtsCq0FpAppi4R30iC+GYH+OTl5DrXM959X9d3CWQ=;
        b=hEMs6hYAo+KK31TDn1bB2rk8y1YSg9qM3xUZIa/Da98aTq17WvRSReHSjY8FhtM3OJ
         2JLAv4Uwc3RL4gA5KE2bBPD33330XAv1G1+pBS4VM5YS+ofoFRaV6BPURQ5/q9+EYYFr
         bKYo3p3HkNotz71ac3UfDiy/xbEfySK6IS7aMhZ2UvnoCQz3eoeeqTUKXqLTxrQAQjP1
         JYOlcEz/GvOHhUvScyd205XD989luBVUJlUQtVsUPfyl8VY1NcdWThUJnZKE7jx6nj+C
         9z0kTvMHZiU//uOAXn1prd1BCywJNJHI8B/j8ikWbl5Bb/NsAdhsHb+mB4Z4LcB7q+tZ
         lI3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788498069; x=1789102869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noXKCjV6cyYbnL/74/FDy38Kcnz1vBvSjgouzbrslPE=;
        b=OiNl1Q7gAsMMvXCNSvrHd1627CptDFaiTKvHU0wwLi3AxV28UZ32+Hnc3xUHvbcOk4
         N1Dyen1qfhv6mN01K/CJd5hQq6tvr1ThbadEHNM/P1/LV71LQfJmxuDFVN3eHWaiGpvv
         3AUbyS2nOYOgZyFVx/kwy0d3MXELu27tqKJrghovj0IHfVKow6SYEN96XFtCRZwSuJbD
         BkveyJ7OMdJPQYEhIRbYxPgqG1TdnJkn6ctGD54+kKKOYfLQb+QwQxPisTzwmXSVnn7N
         v3zzT/RJndgHGF7zN8d7XdO5BOmmUawjYRU5mwfsqy95+boqHolqkV58SQNBlifMmaud
         5kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788498069; x=1789102869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noXKCjV6cyYbnL/74/FDy38Kcnz1vBvSjgouzbrslPE=;
        b=lQ5aBNw1CGCW9Y0GmTTEqxEedMKB+PptG7psr+Q7VqXK/V9vCieZ8WDxrn8AFrFL+T
         DhjoEdQmEK+EzIXba/QTzudDxtq9IiBPHKc45ypDegX0SaG7fH+0zTP1j9qzo/etF+f1
         N5GpuYHdPR8D2YqG03fBjifyrxSSxYSu0ZCV+A3VvuUegaa9KnwJNeZ9AHUMr9uQgNKj
         hv32T9+WPdB05gFVUpSdginuuAzWXhh2eJqaD+pDbHWgsaWbdXvOJDMKsCjX59ijctya
         ElpdKK3xXjZPY73Zmy74L2ItCDz0RkJ80vD7ZWwSVKPsrqMKkZJlgi6smL8Mj3/6n4D1
         AmeQ==
X-Gm-Message-State: AFuF++mrz1Q71akk/R9ml6TmLeT3yCxNxNjSZ5aW0U/PcDp9pxiOhSNf
	KDWj5jhPyQOF3cHe5yTAxQskW/hAP0+MGd1VcislKSv3asUQgUZf2ZeEZytCipiwMhaDutTkYpk
	Kyi78KrwW8cghKW9G4otkXeOmg+ZOOzk=
X-Gm-Gg: AYBFou0Ws6sX+8zSHxRbAKp6Jg+UQq6Accbo0R8bRBMWOuvDTiBfMFeMH9iLivPwqj+
	QlKLUtnv0G+48UNUu1eRo2FCnV8pR0mlKK0NHA0UFeXDMd/dSiiyzvuNLMVBCyNX/1LsDWzuwfS
	qi4Pzf9T+H7sDfIAJuqI431c6L7kmXePVFr0Upy4y7C4rd+u+sz7RZqjg62k8VW2zUNyUCTl9y0
	iPSGlQ3jFmNvwG4wGaLFhdqxZr0iwfmggweAp8/XTXUff+byrXmp8STehAcanoRcP8hBpgIFMff
	mbdho6kHldSeBeHSmrLTfrZlL5E4covYtkhIRGIys0EHoVGxZ2XbrAEBoNYj+HDu07soeyKmO3E
	ErrJTz8brpYVJucXLwtWHHmobAmZu2wEDKU6Ca0K9ugT6XOadFQ6ucMFU0PA9YD9kYis9yJKl
X-Received: by 2002:a05:6820:821:b0:6b1:ab9c:3ef4 with SMTP id
 006d021491bc7-6b6fd9c7a7bmr2883454eaf.27.1788498068721; Thu, 03 Sep 2026
 22:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g> <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de> <0617001F-13BB-4548-A10A-89877977CFB5@ytausch.de>
In-Reply-To: <0617001F-13BB-4548-A10A-89877977CFB5@ytausch.de>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 22:00:57 -0700
X-Gm-Features: AcwNN1UYYnEcdKBLZOKcDfDaoKe_RQDFFP_I9tx1dVTbVYYevuM5ISSkpJGJTR0
Message-ID: <CABPp-BFJo80oE=rtWc0FRNUxVh=6NHZeQmHD2q69VGwDcrHNhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: do not apply prefix to negative pathspecs
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yannik,

On Thu, Sep 3, 2026 at 3:23=E2=80=AFAM Yannik Tausch <dev@ytausch.de> wrote=
:
>
> common_prefix_len() derives the common prefix solely from positive
> pathspecs, skipping those marked with PATHSPEC_EXCLUDE. However,
> match_pathspec_with_flags() also passes that prefix when matching the
> negative pathspecs.
>
> A negative pathspec may be shorter than the prefix. In that case,
> match_pathspec_item() advances item->match beyond its allocation and
> subtracts the prefix from item->len, producing a negative matchlen. It
> then dereferences the out-of-bounds pointer. If the resulting byte is
> not NUL, matchlen is converted to size_t when passed to ps_strncmp(),
> which may cause a much larger out-of-bounds read.
>
> The problem can be reproduced with AddressSanitizer:
>
>     make SANITIZE=3Daddress CFLAGS=3D"-g -O0" git
>     git init test &&
>     cd test &&
>     DIR=3D$(printf "a%.0s" {1..150}) &&
>     mkdir -p "$DIR" &&
>     touch "$DIR/f.txt" &&
>     git add -A &&
>     git commit -m test &&
>     ../git ls-files -- "$DIR/" ":(exclude)xy"
>
> This reports a heap-buffer-overflow. Without AddressSanitizer, the
> output may depend on the contents of memory following the negative
> pathspec.
>
> Fix the bug by using a zero prefix when matching negative pathspecs.
> Add a regression test that combines a positive pathspec with a longer
> common prefix and a shorter, unrelated negative pathspec.
>
> Signed-off-by: Yannik Tausch <dev@ytausch.de>
> ---
>  dir.c                       | 2 +-
>  t/t6132-pathspec-exclude.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 95d8a1cce9..7072715389 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -593,7 +593,7 @@ static int match_pathspec_with_flags(struct index_sta=
te *istate,
>         if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
>                 return positive;
>         negative =3D do_match_pathspec(istate, ps, name, namelen,
> -                                    prefix, seen,
> +                                    0, seen,
>                                      flags | DO_MATCH_EXCLUDE);
>         return negative ? 0 : positive;
>  }
> diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
> index 9fdafeb1e9..ad919cc739 100755
> --- a/t/t6132-pathspec-exclude.sh
> +++ b/t/t6132-pathspec-exclude.sh
> @@ -183,6 +183,15 @@ EOF
>         test_cmp expect actual
>  '
>
> +test_expect_success 'negative pathspec shorter than positive pathspec pr=
efix' '
> +       git ls-files -- sub/sub/ ":(exclude)sub2" >actual &&
> +       cat <<-\EOF >expect &&
> +       sub/sub/file
> +       sub/sub/sub/file
> +       EOF
> +       test_cmp expect actual
> +'

Would it make sense to add a regression case whose failure before this
patch is deterministic without ASan?

The test above advances beyond the end of "sub2", so its result
depends on out-of-bounds memory.  I actually saw this test pass
without your fixes, when not run under ASan, which may depend on the
allocator or build.

An alternative would be an exclude whose length equals the seven-byte
prefix, keeping the accesses in bounds:

        test_expect_success 'exclude is matched against the full path' '
                git ls-files -- sub/sub/ ":(exclude)zzzzzzz" >actual &&
                cat <<-\EOF >expect &&
                sub/sub/file
                sub/sub/sub/file
                EOF
                test_cmp expect actual
        '

Before this patch, stripping seven bytes points at the exclude
string's NUL terminator, which is then treated as matching everything.
I get no output before the fix, and both expected paths after your
fix.

I'm not suggesting this as a replacement for your regression test; I
think the out-of-bounds case is still useful.  I just think this extra
testcase might be a nice complement.
