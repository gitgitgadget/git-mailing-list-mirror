Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C52235375
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035460; cv=none; b=hMh2M/Gr/nRPhm6JQjjcGyGf3rCXVjFgY/mS8Z232DjaCAbORcN84giiUGkLjRw8iUqmmAD13Po+F+n4L3HxpaCU7A60av0l/IJLZAAkMl9+F7Ah3wgjC9n0V2iayCD7Cu6q5l/jufqLoOJ/MJpUlJPGrcidcEWKLu6NU1gNeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035460; c=relaxed/simple;
	bh=5QiC9ohTK3UHXQtEkV/4fwuqJ+LnZLQY4AjfypapXcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPSVqBxXTCimIWZ9s0cJk0yYzmIxLaCI7OF6SaYxuv5DMuZjNcmE+4igeIsZXahSXLdJga0Z3k6N9Le8i1LdWaffDlNaTsH2KRk9rX/kc1HfaKnfLbf5laKTnYd9Osr0uVdSghPV/6CblRtyKQgKe/G9kFpm81aZsD5QmxlPt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e89959309aso3718596d6.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741035457; x=1741640257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfRHPx80KA76++AiTp7OtNAo6b7DErNJPY9wOCfRXbk=;
        b=K0b9EI/W5YcMJdAE9UaSOmtd+xA31fODmDgwINSukt3RsM181p1wTg0XZaJyXHipM5
         VuC+JieBekE0gC76U2LW+hEdv/jSch4EEDzZc4ntXceFRWYPPswbCyASUZOU7NPBEK7R
         VtBcKaMJWC22iX2rVeMf9z167gclAWDlwpzoDDMcoOsm18jzfdHRQPWZ8yK55eoGHzEQ
         PGwYG5nW5HS2P80cVzBQlQxEdGUfIoBHFQdy0QNHRhQQvSXXL157jK7fhTFQDLMZjtPQ
         AVhU5zgXX+E2pHWTtDnXSWKHInE7yQnR4rnD3asm+npvdhQqNB1TP2ojNKxHfRVElRJY
         +KbQ==
X-Gm-Message-State: AOJu0YzHDtAQYnk3xSgLfk9mpYOHApTUk4vQANbBGcsz8koKXsQ//MZ1
	r7xIwlgmYeNBUXxOWs1OE31NsenTFRrn90ov8gBhESgVmAowakqrD9y3hSc9jNJrLwmUb7PKHEe
	wDjh4tjulNlTNBOdunlwyTQqUOv2EQ/2Z
X-Gm-Gg: ASbGncsM/sSGc6S6zf3lZ8SKJDyczYgDJlnOWTQrGGNk9feX9rAeqDzM/BmcPqWazv0
	qfmhf/Z+n2JsNW3rKZ2S7EZ8c5sPJWgsYH0gnO1LUhnWz68Qb7i73jqY7UcZbwMoGhD1+grVq/Z
	mAAHE2CZ0Y5xAkKjudahfJgQArNQ9XqLqTP43EnLOy2xpjNJj1JuWJrHTcN+g=
X-Google-Smtp-Source: AGHT+IET98Da61iO2/GWl17vEEGOV4MqEBnoGDSqWu0k/j0OKygKkt+B5HZFD7t/vBROh3t5jZSX06n+BS1dNwUovnU=
X-Received: by 2002:ad4:5f0a:0:b0:6e8:9f7e:8116 with SMTP id
 6a1803df08f44-6e8a0d0d610mr80845756d6.5.1741035457085; Mon, 03 Mar 2025
 12:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303141800.12848-1-ingleprachit101@gmail.com>
In-Reply-To: <20250303141800.12848-1-ingleprachit101@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Mar 2025 15:57:25 -0500
X-Gm-Features: AQ5f1JoEBwEyHo5rMysy8uTThwYpzxgyBmr7pae13EGTP_FndwLvc8YlsifTr8o
Message-ID: <CAPig+cTJYsXTSXHyUEDcG+qxUNdh5aVUV7FwC=gHDbUX0mpZsA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_=5BGSOC=5D=5BPATCH=5D_Modernize_Test_Path_Checki?=
	=?UTF-8?Q?ng_in_Git=E2=80=99s_Test_Suite?=
To: Prachit Ingle <ingleprachit101@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:20=E2=80=AFAM Prachit Ingle <ingleprachit101@gmail=
.com> wrote:
> This patch improves the Git test suite by converting old-style path check=
s to use
> modern Git test helpers. Specifically, we have replaced shell commands li=
ke `test -f`
> and `test -d` with the appropriate Git test helpers, such as `test_path_i=
s_file` and
> `test_path_is_dir`. This enhances the readability and consistency of the =
test suite.
>
> The following tests were updated:
> - t/chainlint/cuddled-loop.test
> - t/chainlint/cuddled.test
> - t/chainlint/double-here-doc.test
> - t/chainlint/dqstring-line-splice.test
> - t/chainlint/dqstring-no-interpolate.test
> - t/chainlint/empty-here-doc.test
> - t/chainlint/exclamation.test
> - t/chainlint/exit-loop.test
> - t/chainlint/exit-subshell.test
> - t/chainlint/for-loop-abbreviated.test
> - t/chainlint/for-loop.test
> - t/chainlint/function.expect
> - t/chainlint/function.test
> - t/chainlint/here-doc-body-indent.test

Three comments:

* no need to provide an itemized list of files you changed since
git-format-patch does it for you automatically (below the "---" line)

* the list you presented above does not match the list automatically
generated by git-format-patch

* let's not touch any of the "chainlint" files; they are checking
validity of a completely separate tool ("chainlint"), and have nothing
to do with checking Git itself

> The changes have been verified by running the test suite to ensure no bre=
aks or regressions.
>
> Command used to find instances: git grep 'test -[efd]' t/
>
> Signed-off-by: Prachit Ingle <ingleprachit101@gmail.com>
> ---
>  t/chainlint/chained-subshell.expect |  2 +-
>  t/chainlint/chained-subshell.test   | 30 ++++++++++++++---------------
>  t/chainlint/function.expect         |  2 +-
>  t/chainlint/function.test           | 30 ++++++++++++++---------------
>  t/interop/interop-lib.sh            |  4 ++--
>  t/lib-httpd/apply-one-time-perl.sh  |  2 +-
>  t/lib-httpd/nph-custom-auth.sh      |  2 +-
>  t/perf/p5302-pack-index.sh          |  2 +-
>  t/perf/p7527-builtin-fsmonitor.sh   |  2 +-
>  t/perf/perf-lib.sh                  |  2 +-
>  10 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
> @@ -37,7 +37,7 @@ build_version () {
>         for config in config.mak config.mak.autogen config.status
>         do
> -               if test -e "$INTEROP_ROOT/../../$config"
> +               if test_path_exists "$INTEROP_ROOT/../../$config"
>                 then
>                         cp "$INTEROP_ROOT/../../$config" "$dir/" || retur=
n 1
>                 fi

Unfortunately, this and almost all other changes in this patch are
incorrect. The `test_path_foo` functions are meant to be used only as
*assertions*, not as part of general control flow. That is, they are
meant to be linked into a &&-chain within a `test_expect_success` body
like this:

    some command &&
    test_path_exists foo/bar &&
    some other command &&
    ...

To understand why, take a look at the definition of `test_path_exists `:

    test_path_exists () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -e "$1"
        then
            echo "Path $1 doesn't exist"
            false
        fi
    }

This means that `test_path_exists` will print an error message when
the path doesn't exist, but that's inappropriate as a general control
flow mechanism in which it may be perfectly legitimate for a path to
be missing.

> diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
> @@ -9,7 +9,7 @@ test_perf_large_repo
>  test_expect_success 'repack' '
>         git repack -ad &&
>         PACK=3D$(ls .git/objects/pack/*.pack | head -n1) &&
> -       test -f "$PACK" &&
> +       test_path_is_file "$PACK" &&
>         export PACK
>  '

Hence, this is the only change in the entire patch which is likely correct.
