Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233F374C4
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753652760; cv=none; b=Zy7iHWDgYpbE12kIg+SHELoatqf+W8ZLeIYtP6H4McXR87ueKTfHlDzFRY9npHq4UroREWGP7CRp1Tq9azUWWf7ewUx407V7L3nteUE2NL2dKOUVeNkgNfbkQHQR3DmDhl6mAOLTqtDCDTvSHFlyrWYOcqCVjJPX3taEbrLn838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753652760; c=relaxed/simple;
	bh=clDQMtIy88+1i4s9eu8vLQuhZeDfgKGD8JEYTeSLIWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRYWYUPmLeLo6SrdmVrrS1bZnuGett0VwBejDyYXcy17cXXF+Yq6E3UAHs0bJo39H3d2PobqIt7WUnapnSDSCnsZ4ZSXpjaKgGZqOEqQMbJBbhHzmfMsLf0vhsnr7QYgeIVOkAGay7icxzIP4lbCSvAaE7V4g8QslZbk3B51AcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70742520205so1413266d6.2
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 14:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753652757; x=1754257557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWfLX/NArU9v0HikdQ1ynMuF+SND48jeaEmz/Lm0Fd4=;
        b=STHOkUSea3Zpbu5fPOiceTUtHJlIRNFXclzJymNJXmTCJKDFOxF+gvPEMasYZsz1Iv
         CblHvKjJ7xuYqhHt5TWWijLNcqgEAk77HjBdULJ3G56TDv6vB57qkePgjqgzAhd2gdMC
         3ZKrCGKyjYlyem/L7bYA/Afdv0/hO0lb7k0d8C6a7DDnMjNnEtnZ8Za5Q+LKNTh32JCF
         4cxhacqCj9FWs1gOKCqh7XJf4T/WNfnyb9Sq2SV8qOsVrom39qp78KQHZL8p8HZ67WuF
         YZm274Tf/qttmXjPPlXljt86sCNpvwyH3a1OFqrfWS/w+dFl5ZsIh7Irwrey1VaRge2N
         4/OA==
X-Gm-Message-State: AOJu0YxJwYxAnrNm/6OkhhB6vIUQTfHxNLH8wPkfuHikLKNtAIQJtkub
	CIjz/2RAUzJIN9bLcCX4RUbbW+2d+PQ4OM7iBd1kcuk/ridXAWcrpOf7HskZxtU8Uxk97eEu8Hj
	ljgmnhgOO5sYdPFKOx/ARScIpZi3qVks=
X-Gm-Gg: ASbGncuNDd2Z1UHQGd+E+o7pUaET7xbh0z373g08/Zvie+W5SNj0npjQx6OullIda/5
	gxkx579DgXU+oqYCqcTnfMdMG0qs0oKIF+tcc9UuhMp07LhfWFWBqRlhseoXOMvpPHcZBzRw16t
	DhZESLzqfuOBG9ptcmNJbh9IcennJ5+xvB6Ve7M+vzQ8wx1vMihRojQOjdIslcFTJ0ldjJexCVC
	HyXRc0eRpT1sFTbdY5HPg1KC93fn/D18omSntLJ
X-Google-Smtp-Source: AGHT+IFCI8fdJd5++JsQlrmS+nUoCnqjEVjJlbBsFXsSIgAqUxX8rbZT3rvrv0h72z7UFBmkLSCLYbVyvnjotf4rYL4=
X-Received: by 2002:a05:6214:4114:b0:707:6f5:7f99 with SMTP id
 6a1803df08f44-707205ae447mr56455206d6.6.1753652757169; Sun, 27 Jul 2025
 14:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com> <20250727175110.84770-5-lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-5-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 27 Jul 2025 17:45:46 -0400
X-Gm-Features: Ac12FXyh3TPf0q-xuLSyekKbxOeb-vV9qBP9BWIrgXYtI05M5ALlSRZCeBJA9NI
Message-ID: <CAPig+cRyRZma-b4wdPrhHnRrOh8AESDV-Bt1oxZgncddfEqv4w@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 4/5] repo: add field layout.shallow
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 1:52=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
>
> The flag `--is-shallow-repository` from git-rev-parse is used for
> retrieving whether the repository is shallow. This way, it is used for
> querying repository metadata, fitting in the purpose of git-repo-info.
>
> Then, add a new field `layout.shallow` to the git-repo-info subcommand
> containing that information.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -42,6 +42,20 @@ test_repo_info 'bare repository =3D false is retrieved=
 correctly' '
> +test_repo_info 'shallow repository =3D true is retrieved correctly' '
> +       git init remote &&
> +       cd remote &&
> +       echo x >x &&
> +       git add x &&
> +       git commit -m x &&
> +       cd .. &&
> +       git clone --depth 1 "file://$PWD/remote" repo &&
> +       rm -rf remote
> +       ' 'layout.shallow' 'true'

If a command fails between the `cd remote` and the `cd ..`, then the
test will abort while the working directory is still "remote", and
every subsequent test will then run in the wrong directory (because
the tests are not isolated from one another in that way). So, the rule
is: never use `cd` outside of a subshell. Therefore, you want to do
something like this:

    git init remote &&
    (
        cd remote &&
        echo x >x &&
        git add x &&
        git commit -m x
    )
    git clone --depth 1 "file://$PWD/remote" repo &&
    rm -rf remote

Alternatively, you could avoid `cd` entirely:

    git init remote &&
    echo x >remote/x &&
    git -C remote add x &&
    git -C remote commit -m x &&
    git clone --depth 1 "file://$PWD/remote" repo &&
    rm -rf remote

The choice is subjective, though I find that I can spot the secondary
repository more easily in the first example.

As I noted in my review of an earlier patch in this series, we don't
usually clean up just for the sake of cleaning up since doing so makes
it more difficult to diagnose a failed test and slows down the test
suite, so you could probably also drop the `rm -rf remote.

> @@ -60,4 +74,11 @@ test_expect_success "only one value is returned if the=
 same key is requested twi
> +test_expect_success 'output is returned correctly when two keys are requ=
ested' '

I think this test could have been added in the previous patch (and
it's where I was expecting to find it).

> +       test_when_finished "rm -f expect" &&
> +       printf "layout.bare=3Dfalse\nlayout.shallow=3Dfalse\n" >expect &&

This could be made a bit easier to read either like this:

    test_write_lines layout.bare=3Dfalse layout.shallow=3Dfalse >expect &&

or like this:

    cat >expect <<-\EOF
    layout.bare=3Dfalse
    layout.shallow=3Dfalse
    EOF

It's subjective, but I find the latter example to be more obvious at a glan=
ce.

> +       git repo info layout.shallow layout.bare >actual &&
> +       test_cmp expect actual
> +'
