Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F51026
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268309; cv=none; b=s9drKtEyZZ6tsLPIo1STuAjIHum3xOXytoHtp9oghuDPLuBKrwq+Ooyt/yOSauECHR+/Bkbz2DnXrAt9LyiPr87utaxdeiVYOEJFxSM9XjYhPPnh2ndznF0wlqFfV8/ddGNSoSik+q55C7k0PyWukRgJPmteKoEEzkAmkmum+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268309; c=relaxed/simple;
	bh=gdLYZ9cJj3oX1B9+nGAlkIs6/oe9RW5AaOtlt9iHYv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FePXGqHEjXimF/R7xbtf8LnHLEZ3tft36TDEKYWDyCrlB5yOujnGiT2hdKDrPTV81aOpwBAsW6LdsY9G+qScJcQz2VS1D1MIL7ToAUXhcydBGY3SjtXpQBOT0lsqn9A2GFXZYSRuQ5s7XgUVmCl9ycpx91i/2VDh1BpPhpY0yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42e5e1643adso10315871cf.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268305; x=1709873105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16zA1qGrdtio9Ij79rTW0Jx13haEK63/rhn9lv5UBgA=;
        b=jM4UBV0m0lG6HmvSTbe9wr2XtZ9V8dZ2JwMEf1srVnABXuEjXtlybltiMvTvmSYKXI
         vk1InTJs4yF17NB5sLokhZ77WKZxuIJU4NFyOnrtV3fGLeZ/qCfRzd+uTjNXEmsaY/XH
         xfjiifccsxTm+uYxsQhevNg9C/iYvZFODnweKoEIRBWJTicb/mcBJdig3rPYd0fpLLe2
         Ts9x3sGftPjCBkCyeVupbeSsNqAiCoTmi4ExyNwlF+NS59Hsv+tId8K2eEar1PhEiIna
         OeIfA1ZM1mKB20k7uGQ5DCILbmlgNWfwm2a+Y6GD6lKQoZP5yy0vc/E2uf9PWhTICVAF
         0GoA==
X-Gm-Message-State: AOJu0YxvG2OouHiGM8Tdp9BsQwCBBacOFDWA7l32frJ373Bgc1i5f7qL
	3wc1aUIihWBZencrausjE1QKV5F6wfgxILBtspLbOxNuOq11SBN83FIlypTdLf8K3jH/fBkmkQd
	L0Goy2XsEcocKPPBOXYt9+s6+uNw=
X-Google-Smtp-Source: AGHT+IEy3nVBJCuh1UbYS29u/shY/HBZ+8yzhcuLD6JjMQohrewmq57/hs3QR5cJ0hQ92PKrJNvDZ9Ixg+6HkaaNZ5w=
X-Received: by 2002:a05:622a:11d4:b0:42e:7a6e:825e with SMTP id
 n20-20020a05622a11d400b0042e7a6e825emr649825qtk.61.1709268305585; Thu, 29 Feb
 2024 20:45:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229150442.490649-1-shejialuo@gmail.com> <20240301034606.69673-1-shejialuo@gmail.com>
 <20240301034606.69673-2-shejialuo@gmail.com>
In-Reply-To: <20240301034606.69673-2-shejialuo@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 23:44:53 -0500
Message-ID: <CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] t9117: prefer test_path_* helper functions
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:46=E2=80=AFPM shejialuo <shejialuo@gmail.com> wr=
ote:
> test -(e|f|d) does not provide a nice error message when we hit test
> failures, so use test_path_exists, test_path_is_dir and
> test_path_is_file instead.

Thanks for rerolling. t9117 is indeed a better choice[1] than t3070
for the exercise of replacing `test -blah` with `test_path_foo`.

[1]: https://lore.kernel.org/git/CAPig+cR2-6qONkosu7=3DqEQSJa_fvYuVQ0to47D5=
qx904zW08Eg@mail.gmail.com/

> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.s=
h
> @@ -15,39 +15,39 @@ test_expect_success 'setup svnrepo' '
>  test_expect_success 'basic clone' '
> -       test ! -d trunk &&
> +       ! test_path_is_dir trunk &&

Generally speaking, you don't want to use `!` to negate the result of
a `path_is_foo` assertion function. To understand why, take a look at
the definition of `test_path_is_dir`:

    test_path_is_dir () {
        if ! test -d "$1"
        then
            echo "Directory $1 doesn't exist"
            false
        fi
    }

The test in question (t9117: "basic clone") is using `test ! -d` to
assert that the directory `trunk` does not yet exist when the test
begins; indeed, under normal circumstances, this directory should not
yet be present. However, the call to test_path_is_dir() asserts that
the directory _does_ exist, which is the opposite of `test ! -d`, and
complains ("Directory trunk doesn't exist") when it doesn't exist. So,
in the normal and typical case for all the tests in this script,
`test_path_is_dir` is going to be complaining even though the
non-existence of that directory is an expected condition.

Although you make the test pass by using `!` to invert the result of
`test_path_is_dir`, the complaint will nevertheless get lodged, and
may very well be confusing for anyone scrutinizing the output of the
tests when running the script with `-v` or `-x`.

So, `test_path_is_dir` is not a good fit for this case which wants to
assert that the path `trunk` does not yet exist. A better choice for
this particular case would be `test_path_is_missing`.

>         git svn clone "$svnrepo"/project/trunk &&
> -       test -d trunk/.git/svn &&
> -       test -e trunk/foo &&
> +       test_path_is_dir trunk/.git/svn &&
> +       test_path_exists trunk/foo &&

These two changes make sense and the intent directly corresponds to
the original code.

>  test_expect_success 'clone to target directory' '
> -       test ! -d target &&
> +       ! test_path_is_dir target &&
>         git svn clone "$svnrepo"/project/trunk target &&
> -       test -d target/.git/svn &&
> -       test -e target/foo &&
> +       test_path_is_dir target/.git/svn &&
> +       test_path_exists target/foo &&
>         rm -rf target
>         '

What follows is probably beyond the scope of your GSoC microproject,
but there is a bit more of interest to note about these tests.

Rather than asserting some initial condition at the start of the test,
it is more common and more robust simply to _ensure_ that the desired
initial condition holds. So, for instance, instead of asserting `test
! -d target`, modern practice is to ensure that `target` doesn't
exist. Thus:

    test_expect_success 'clone to target directory' '
        rm -rf target &&
        git svn clone "$svnrepo"/project/trunk target &&
        ...

is a more robust implementation. This also addresses the problem that
the `rm -rf target` at the very end of each test won't be executed if
any command earlier in the test fails (due to the short-circuiting
behavior of the &&-operator).

As noted, this type of cleanup is probably overkill for your GSoC
microproject so you need not tackle it. I mention it only for
completeness. Also, if someone does tackle such a cleanup, it should
be done as multiple patches, each making one distinct change (i.e. one
patch dropping `test !-d` and moving `rm -rf` to the start of the
test, and one which employs `test_path_foo` for the remaining `test
-blah` invocations).
