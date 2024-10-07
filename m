Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8D13D8B1
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342095; cv=none; b=QLYESg1IlXxkzRPOb8clO6wiW7fF/PEClNq5JZGweDlQkXZZ6pqdVdhzQvZNYNkMroNnl1rQmN/AlTjRtEXYrClIoWzLmwOAwsaC2PpZjzfq+bPNCxN0Cr+HUmVQUPFGogLFxkUK+zmMIQN84aH4494mrxA1Wja+r5ShTK8Uqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342095; c=relaxed/simple;
	bh=nBYKO84PbVpfTNTVNjNPwppMlQmom0sZfdUbC2bv1Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtGTr3x8iZX+KluTYfoR5afRkbdDU2T+zBKuPZvN8VkbWWD9j+kZi9tsMoVikK2E3ypH6N4t0E24Ovdib6DtSrpbn3fDQdr+GZwXRhC9jbIBT1Y079iEvdR30cuwVGkNv00IewVvwAJKKNbQG3FRgjAY2jQJiDFhllKUyRVXYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyb/fwqW; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyb/fwqW"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50c8330c69fso2224914e0c.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728342092; x=1728946892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzf60AbH9veMUrraNAKzNwQydBJZIu5YWPbx864TAsE=;
        b=Yyb/fwqWvXK1pVbqRHfaQ7303WOMxJR6v5nhVe8h+YVBoTt1AvQdJQwg05HnyCOe8v
         uAHDBThtIF1FM30FkklWBFw5I+Uy94kNxg4FD6KDuj776ZaFbPonjQABN8CjkaxH3gaZ
         BJqKyb5nzTU9zz2O74gIoEV91oO2XFGdmcTXWvTY+tT0oYId9co9EdTWvY5nA7fjYKwK
         6BuFpE6VO/AENw8A4y8AVJbLdGIgrn7PNPABDApCyhoIOGkoNe03waxtriZ6ltTJAMSB
         4C3eQAjSAHnQmxoBtDkhqQM7NyiE+FZktDsxPr3lF33jk4qBXh71zpXU5iQc8M3x8u6F
         FthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728342092; x=1728946892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzf60AbH9veMUrraNAKzNwQydBJZIu5YWPbx864TAsE=;
        b=ISfgRQTOcSs4PJaGYwF/zesZYSdwDE8iMcM/rXv1fAJSxLQq6NTI6HekdeMGJ5DTnW
         KX52Aog7H1wKiar3FwBKO44kSkwg9mXtUUJtmrNWMgJibGOBVBWZqhrffuidSn3oBqUu
         u/PaIosPgNKjtaV3E4gwTxz0uecs1epKWi4sO8ChlPMbfh45ojhzh4lDFpkWK7Gxz0fv
         unsb49e853vvQXiYAzJ87ZX3EFBfBq0FTENd/kd9sSX00Wn+N9igHgfVEI+j5Rv3avpE
         ZePRhNPEqxiMoPmE68dackn1oSq3mK9pD5S5LfEoDygXkDPtCS8SWARb4UTP4qcUImde
         iqmw==
X-Gm-Message-State: AOJu0YwCTXOUorhJoKA6og6k1Mr7U9829ZylantlypACFssa4urblnWr
	3Hm1DTfqiTOPfWSCdbEo0ZPe7/MotZTUeVWGcq1NzeONrqtsLVBtRV7WiTMbDw4/rpzWVT/4lYt
	M0mAzLYD0GwMo6rO29UK1n/48tyJArCPEZu3Q5Q==
X-Google-Smtp-Source: AGHT+IGRU9RmKRAnilNPDJ8aFUXCcpDkRlXVqHaJjq5vkzF3kcHBKgak5naGtR4emja/x1ZtaNRBxNEIYfooZ7Vh398=
X-Received: by 2002:a05:6122:919:b0:503:e3b5:36eb with SMTP id
 71dfb90a1353d-50cd81beee2mr1138563e0c.3.1728342091464; Mon, 07 Oct 2024
 16:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
In-Reply-To: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 7 Oct 2024 23:01:20 +0000
Message-ID: <CAPSxiM8SjJwb6x2bhCd4xsYLiNk+KhWYna7-rZhdNGpYNV1tLg@mail.gmail.com>
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:19=E2=80=AFPM Samuel Adekunle Abraham via
GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> The test_path_* helper functions provide error messages which show the ca=
use
> of the test failures. Hence they are used to replace every instance of
> test - [def] uses in the script.
Maybe also adding what they are being replaced with might make the
description much clearer.
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>     [Outreachy] [PATCH] t7300-clean.sh: replace instances of test - [def]
>     with test_path_* helper functions.
Hello Samuel,

Good Job here, just a simple observation.
I think it might be much clearer if you used test -(d|e|f) instead of
test - [def], as it much clearer.
Overall it looks good to me.
>
>     The test_path_* helper functions provide error messages which show th=
e
>     cause of the test failure should a failure occur. This is more useful
>     and helpful when debugging errors.
>
>     Signed-off-by: Abraham Samuel Adekunle abrahamadekunle50@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1811%2F=
devdekunle%2Fupdate_tests-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1811/devde=
kunle/update_tests-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1811
>
>  t/t7300-clean.sh | 370 +++++++++++++++++++++++------------------------
>  1 file changed, 185 insertions(+), 185 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 0aae0dee670..5c97eb0dfe9 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -29,15 +29,15 @@ test_expect_success 'git clean with skip-worktree .gi=
tignore' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so &&
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so &&
>         git update-index --no-skip-worktree .gitignore &&
>         git checkout .gitignore
>  '
> @@ -47,15 +47,15 @@ test_expect_success 'git clean' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -64,15 +64,15 @@ test_expect_success 'git clean src/' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean src/ &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -81,15 +81,15 @@ test_expect_success 'git clean src/ src/' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean src/ src/ &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -98,16 +98,16 @@ test_expect_success 'git clean with prefix' '
>         mkdir -p build docs src/test &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/te=
st/1.c &&
>         (cd src/ && git clean) &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f src/test/1.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file src/test/1.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -163,16 +163,16 @@ test_expect_success 'git clean -d with prefix and p=
ath' '
>         mkdir -p build docs src/feature &&
>         touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o =
build/lib.so &&
>         (cd src/ && git clean -d feature/) &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test -f src/part3.c &&
> -       test ! -f src/feature/file.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_missing src/feature/file.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -182,16 +182,16 @@ test_expect_success SYMLINKS 'git clean symbolic li=
nk' '
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         ln -s docs/manual.txt src/part4.c &&
>         git clean &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test ! -f src/part4.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_missing src/part4.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -199,13 +199,13 @@ test_expect_success 'git clean with wildcard' '
>
>         touch a.clean b.clean other.c &&
>         git clean "*.clean" &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.clean &&
> -       test ! -f b.clean &&
> -       test -f other.c
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.clean &&
> +       test_path_is_missing b.clean &&
> +       test_path_is_file other.c
>
>  '
>
> @@ -214,15 +214,15 @@ test_expect_success 'git clean -n' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -n &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -231,15 +231,15 @@ test_expect_success 'git clean -d' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test ! -d docs &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_missing docs &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -248,16 +248,16 @@ test_expect_success 'git clean -d src/ examples/' '
>         mkdir -p build docs examples &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so exampl=
es/1.c &&
>         git clean -d src/ examples/ &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test ! -f examples/1.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_missing examples/1.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -266,15 +266,15 @@ test_expect_success 'git clean -x' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -x &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test ! -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -283,15 +283,15 @@ test_expect_success 'git clean -d -x' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -x &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test ! -d docs &&
> -       test ! -f obj.o &&
> -       test ! -d build
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_missing docs &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_missing build
>
>  '
>
> @@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored t=
racked directory' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -x -e src &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test -f src/part3.c &&
> -       test ! -d docs &&
> -       test ! -f obj.o &&
> -       test ! -d build
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_missing docs &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_missing build
>
>  '
>
> @@ -317,15 +317,15 @@ test_expect_success 'git clean -X' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -X &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test ! -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -334,15 +334,15 @@ test_expect_success 'git clean -d -X' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -X &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test ! -f obj.o &&
> -       test ! -d build
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_missing build
>
>  '
>
> @@ -351,15 +351,15 @@ test_expect_success 'git clean -d -X with ignored t=
racked directory' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -d -X -e src &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test ! -f obj.o &&
> -       test ! -d build
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_missing obj.o &&
> +       test_path_is_missing build
>
>  '
>
> @@ -382,29 +382,29 @@ test_expect_success 'clean.requireForce and -n' '
>         mkdir -p build docs &&
>         touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>         git clean -n &&
> -       test -f Makefile &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test -f a.out &&
> -       test -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file Makefile &&
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_file a.out &&
> +       test_path_is_file src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
>  test_expect_success 'clean.requireForce and -f' '
>
>         git clean -f &&
> -       test -f README &&
> -       test -f src/part1.c &&
> -       test -f src/part2.c &&
> -       test ! -f a.out &&
> -       test ! -f src/part3.c &&
> -       test -f docs/manual.txt &&
> -       test -f obj.o &&
> -       test -f build/lib.so
> +       test_path_is_file README &&
> +       test_path_is_file src/part1.c &&
> +       test_path_is_file src/part2.c &&
> +       test_path_is_missing a.out &&
> +       test_path_is_missing src/part3.c &&
> +       test_path_is_file docs/manual.txt &&
> +       test_path_is_file obj.o &&
> +       test_path_is_file build/lib.so
>
>  '
>
> @@ -453,11 +453,11 @@ test_expect_success 'nested git work tree' '
>                 test_commit deeply.nested deeper.world
>         ) &&
>         git clean -f -d &&
> -       test -f foo/.git/index &&
> -       test -f foo/hello.world &&
> -       test -f baz/boo/.git/index &&
> -       test -f baz/boo/deeper.world &&
> -       ! test -d bar
> +       test_path_is_file foo/.git/index &&
> +       test_path_is_file foo/hello.world &&
> +       test_path_is_file baz/boo/.git/index &&
> +       test_path_is_file baz/boo/deeper.world &&
> +       test_path_is_missing bar
>  '
>
>  test_expect_success 'should clean things that almost look like git but a=
re not' '
> @@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git work=
 tree' '
>                 test_commit deeply.nested deeper.world
>         ) &&
>         git clean -f -f -d &&
> -       ! test -d foo &&
> -       ! test -d bar &&
> -       ! test -d baz
> +       test_path_is_missing foo &&
> +       test_path_is_missing bar &&
> +       test_path_is_missing baz
>  '
>
>  test_expect_success 'git clean -e' '
> @@ -638,10 +638,10 @@ test_expect_success 'git clean -e' '
>                 touch known 1 2 3 &&
>                 git add known &&
>                 git clean -f -e 1 -e 2 &&
> -               test -e 1 &&
> -               test -e 2 &&
> -               ! (test -e 3) &&
> -               test -e known
> +               test_path_exists 1 &&
> +               test_path_exists 2 &&
> +               test_path_is_missing 3 &&
> +               test_path_exists known
>         )
>  '
>
> @@ -649,7 +649,7 @@ test_expect_success SANITY 'git clean -d with an unre=
adable empty directory' '
>         mkdir foo &&
>         chmod a=3D foo &&
>         git clean -dfx foo &&
> -       ! test -d foo
> +       test_path_is_missing foo
>  '
>
>  test_expect_success 'git clean -d respects pathspecs (dir is prefix of p=
athspec)' '
>
> base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
> --
> gitgitgadget
>
