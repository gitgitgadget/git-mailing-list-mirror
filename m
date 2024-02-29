Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D061160657
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229497; cv=none; b=FTsKOSCNaCOywfRWOTbpP3ewDbXUaVun+FTgBZTcHGUE4eL6oWtW2eAmoumEQrjYwphTEa9nt+VckVeIF0xYkwpzQK/feeH24LF9yRSDmpGPcGbMpsriF4CNS328lpQUpuoBfCkFMEYd6cG7FNYmLEEK0wpE53Y0Mylp4n6NHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229497; c=relaxed/simple;
	bh=O8pyYCkk81JFQJNLnAtnZaLww2bDKyYPoEL8hhwdO5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQTpDLAAkQ1QEYI4KadiqEvjDH4Yffd87pOUyuGxFwQcgU70QnmNPvOwJgRJv4OEyv0XeYBeClthGBsoxGAKyvvBNqSfce5sQTMb9u+iiGVVusSyfjKDXwhCOiERiarMLrgSoz/l/KyvE/mk4L2EUEsNm/tETRM8MXXgdKNFHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6901a6dca63so7031236d6.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 09:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229494; x=1709834294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md/oKuC9MWu6dbnEecURmnYi3m/yjQVlCOruW+7SA6U=;
        b=fQbRmpYuEjHisLWmnOZa+DTqnppKXB5fo0GP8NcVbKIk/s6+oLJSZfpTiHlc+tDjHz
         3MgIYjL25x6JXqLwAXn6tO1jdJwbC3aajw5uP05dF9/tthLxPApymLOJxeDrQMGZdmej
         bm7uNiOHsM+78KCQfEg2PTXWOBa7e5dmLltWCU1PeRL7qmbJiCaGC3eeFml9SyqZTweo
         aNeHWZ3Ae9XozXCmhtoT8UDOnbHXQQpKcVPM1Cdmdc3KI4gGTYwsh8l+8ZJYYgZFIbT9
         nD0b/w7X5g2Srml+3Z7e3G3YsRVITs6trErkixJTamo+C614pCads99LnWerBVgu6JaB
         fFtg==
X-Gm-Message-State: AOJu0YxUUtmzu0W9eEa9WTP8sMLIzcn/HOdTbc1bMyEueIJ4yfqtkGin
	nGpr7BO6HKRJloCgBdniAwnWGLQFpNMwQWYRfkJE5vE7lNIHbaPYkclRI3ZOm1e/Q7fPny99ipr
	UgJqW2w6FsJ/2VyZErzdoF/VfDzRfARAncAs=
X-Google-Smtp-Source: AGHT+IEwo1OA6KxPy0CAUjhiGskOmuI83IElBjPWLO1eOdrzZYZmM4HlGh1IxqNufNP9rhkfR6XmVOzC6zajgZVTpRE=
X-Received: by 2002:a0c:cb85:0:b0:68f:6df2:3b6f with SMTP id
 p5-20020a0ccb85000000b0068f6df23b6fmr3022785qvk.44.1709229494506; Thu, 29 Feb
 2024 09:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229150442.490649-1-shejialuo@gmail.com> <20240229150442.490649-2-shejialuo@gmail.com>
In-Reply-To: <20240229150442.490649-2-shejialuo@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 12:58:03 -0500
Message-ID: <CAPig+cR2-6qONkosu7=qEQSJa_fvYuVQ0to47D5qx904zW08Eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] [GSoC][PATCH] t3070: refactor test -e command
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:05=E2=80=AFAM shejialuo <shejialuo@gmail.com> wr=
ote:
> t3070: refactor test -e command
>
> The "test_path_exists" function was proposed at 7e9055b. It provides
> parameter number check and more robust error messages.
>
> This patch converts all "test -e" into "test_path_exists" to improve
> test debug when failure.

Thanks for providing this GSoC submission. The aim of this patch makes
sense, but it turns out that t3070 is not a good choice for this
exercise. Before getting into that, though, a few minor comments about
the commit message.

This patch isn't actually refactoring the code, so using "refactor" in
the title is misleading.

Rather than mentioning only the object-ID, we normally reference other
commits like this (using `git log --pretty=3Dreference -1 <object-id>`):

    7e9055bb00 (t7406: prefer test_* helper functions to test -[feds],
2018-08-08)

In this case, it's not clear why you chose to reference that
particular commit over any of the others which make similar changes.
It probably would be simpler to drop mention of that commit and just
copy its reasoning into your commit message.

Taking all the above into account, a possible rewrite of the commit
message might be:

    t3070: prefer test_path_exists helper function

    test -e does not provide a nice error message when we hit test
    failures, so use test_path_exists instead.

> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> @@ -107,7 +107,7 @@ match_with_ls_files() {
>         if test "$match_expect" =3D 'E'
>         then
> -               if test -e .git/created_test_file
> +               if test_path_exists .git/created_test_file
>                 then
>                         test_expect_success EXPENSIVE_ON_WINDOWS "$match_=
function (via ls-files): match dies on '$pattern' '$text'" "

The point of functions such as test_path_exists() is to _assert_ that
some condition is true, thus allowing the test to succeed; if the
condition is not true, then the function prints an error message and
the test aborts and fails. Here is how test_path_exists() is defined:

    test_path_exists () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -e "$1"
        then
            echo "Path $1 doesn't exist"
            false
        fi
    }

It is meant to replace noisy code such as:

    if ! test -e bloop
    then
        echo >&2 "error message" &&
        exit 1
    fi &&
    other-code

with much simpler:

    test_path_exists bloop &&
    other-code

It is also meant to be used within `test_expect_success` (or
`test_expect_failure`) blocks. So, the changes made by this patch are
undesirable for a couple reasons...

First, this code is outside a `test_expect_success` (or
`test_expect_failure`) block.

Second, as noted above, test_path_exists() is an _assertion_ which
requires the file to exist, and aborts the test if the file does not
exist. But the `test -e` being changed here is part of the proper
control-flow of this logic; it is not asserting anything, but merely
branching to one or another part of the code depending upon the result
of the `test -e` test. Thus, replacing this control-flow check with
the assertion function test_path_exists() changes the logic in an
undesirable way.

The above comments are applicable to most of the changes made by this
patch. The only exceptions are the last two changes...

> @@ -175,7 +175,7 @@ match() {
>         test_expect_success EXPENSIVE_ON_WINDOWS 'cleanup after previous =
file test' '
> -               if test -e .git/created_test_file
> +               if test_path_exists .git/created_test_file
>                 then
>                         git reset &&

... which _do_ use test_path_exists() within a `test_expect_success`
block. However, the changes are still undesirable because, as above,
this `test -e` is merely part of the normal control-flow; it's not
acting as an assertion, thus test_path_exists() -- which is an
assertion -- is not correct.

Unfortunately, none of the uses of`test -e` in t3070 are being used as
assertions worthy of replacement with test_path_exists(), thus this
isn't a good script in which to make such changes. If you reroll, you
may be able to find a good candidate script by searching for code
which looks something like this:

    foo &&
    test -e path &&
    bar &&

and replacing it with:

    foo &&
    test_path_exists path &&
    bar &&
