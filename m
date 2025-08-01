Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3416F8E9
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085037; cv=none; b=eCa+Ru+63NR3MSNFqVpg+RoMKw5oJQrexnM2xoEK/rgNsx2IeA3WD+Ij7xVJOim1NWCZ/aN1K+0D/6hRgcjNkS10kkeJCj6+lxoo28ffebURoTnICZPPd5HL438sGD5oWDnYDoTyLpIFgKkTM/ToPc/MyAaYV4ffD3zB5ZgU3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085037; c=relaxed/simple;
	bh=Wto1NozTLunCEBnllzEeDDMV7XHuqLkSfX4dPBRmy08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+ExR/jpZxvKwPHRNubDwvIzNFanzufAKhGkqzlBdOiNYNp+u+M3acwDUJKRc0Jfxk72HaCKh9klfPZDUJvvegci79MFq+abAbOcswMbCXlIjcaNAizgyJaQj5LQseEbaPPRBptAOIu0a7pQ0bh7CFmjUTPJQgf6XOJ+iweMgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4abd2d45996so6186321cf.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 14:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754085034; x=1754689834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92WL4FrMtPGSdQNsmj3xSWaGyhoeYMqLunKFZfZ0iuw=;
        b=B0UG9xqOHEn+NB2PQ06k8Wq09Q2FnRO4mVl77OMfKnTUS5p2FqqvfTZhYtL5Ic6kkT
         ZSsg3GlwPlFMMwFfRe1vm6B6R9lEPOQ7F2jfQ+FqFd3LMcF9WaOL4w87MUMzC/6NT3zS
         aQUcJdvLwWJm0eQ+jpkEbmv6m3YR7zbjuKipcSRnaWSj6EjTxBq8+MWbsZgfeLeV0b+d
         2Hq7dGtiZ8yYA1kWaDUTfuf96tLzw+F5xzOHM9wTuFvetnhzk8xLvTHq7o1EpYC6jr5D
         t/jjWk1IdoK9ywKW1PeT2ULOI9qj/gQ9TDZFw3UxakTFrYXYyTX/0znRZZGP8V0Zus8E
         AkFQ==
X-Gm-Message-State: AOJu0YwBq0IyWZ27+wE7SGuCJXVGEAy0XrcveALcsJ8jtIOSyVDvBRoG
	wRQuPOL30VJzucoqeemvHJnknOAJ53XfZcfWHZ2PKU3QViYbFp3VfBwqu1jaxWYtAkm2Yam13AF
	cWlOqsomyyeFjlynSrXMOK5+ZkR8xr5A=
X-Gm-Gg: ASbGncuh/94uBRaAt7BghYcln0XH6l7pou8IsMogn0Zv5RzzzLD4tlOXWWTGnwu4Lnv
	Od7hI/N/fb0hFi5sbe2Jm0JT4nem/2FwERTaeM5R9iUQRoD5e9flyxFbkdzh0vKpAlVFUwWzAbn
	nj1MnB7inbCLtUZLzdtLBeJ8Oq+Y5TM6MGppgXIYl8D/nhBFvzKgSQY/IfMB9AVq7ChDuZVA5lU
	/RF9yDFx6Dumnv9BAqlKx3A5QCLdykxg89kSOJL
X-Google-Smtp-Source: AGHT+IFaiTXZbC+siNkPWkgicp7G7WSOYQUsZSmx6BVNcWGjpv/DKlCwmLndOVI69U/FRAxnRjrwPINOaa5bNlyP0OA=
X-Received: by 2002:a05:622a:409:b0:4ae:d762:c070 with SMTP id
 d75a77b69052e-4af108f751dmr12294191cf.2.1754085033946; Fri, 01 Aug 2025
 14:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com> <20250801131111.8115-6-lucasseikioshiro@gmail.com>
In-Reply-To: <20250801131111.8115-6-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 1 Aug 2025 17:50:22 -0400
X-Gm-Features: Ac12FXzgKP1Y9er5kzZvWP1duUKmmcciMEZG41Gz6bOSRcL-1pmBJqIZ-x9WWc0
Message-ID: <CAPig+cTtJHn3NxrXF-AU_0cRzccDOo+j8JTAq1Jyqm4BzXBpSw@mail.gmail.com>
Subject: Re: [GSoC PATCH v7 5/5] repo: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:11=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
>
> Given that this command can be used for generating input for other
> applications and for being read by end users, it requires at least two
> formats: one for being read by humans and other for being read by
> machines. Some other Git commands also have two output formats, notably
> git-config which was the inspiration for the two formats that were
> chosen here:
>
> - keyvalue, where the retrieved data is printed one per line, using =3D
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - nul, where the retrieved data is separated by null characters, using
>   the newline character for delimiting the key and the value. This
>   format is targeted for being read by machines.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -21,10 +21,17 @@ test_repo_info () {
> -       test_expect_success "$label" '
> -               eval "$init_command $repo_name" &&
> +       test_expect_success "keyvalue: $label" '
> +               eval "$init_command keyvalue-$repo_name" &&
>                 echo "$key=3D$expected_value" >expected &&
> -               git -C $repo_name repo info "$key" >actual &&
> +               git -C keyvalue-$repo_name repo info "$key" >actual &&
> +               test_cmp expected actual
> +       '
> +
> +       test_expect_success "nul: $label" '
> +               eval "$init_command nul-$repo_name" &&
> +               printf "%s\n%s\0" "$key" "$expected_value" >expected &&
> +               git -C nul-$repo_name repo info --format=3Dnul "$key" >ac=
tual &&
>                 test_cmp expected actual
>         '

Due to the embedded NUL's in this new "nul" test, I'm pretty sure you
want to be using `test_cmp_bin` here as suggested previously[*].

[*]: https://lore.kernel.org/git/CAPig+cQn7c5+k06yHOD2jxYTGnny7is=3Dfbo4tOw=
26eD+4zX-Jw@mail.gmail.com/

> @@ -45,6 +52,7 @@ test_repo_info 'shallow repository =3D false is retriev=
ed correctly' '
>  test_repo_info 'shallow repository =3D true is retrieved correctly' '
> +       test_when_finished "rm -rf remote" &&
>         git init remote &&
>         echo x >remote/x &&
>         git -C remote add x &&

For what it's worth, it would be clearer to turn the removal of
"remote" into a "make sure we have a clean-slate for what we are about
to do" rather than making it an after-the-fact cleanup. That is:

    test_repo_info 'shallow repository =3D true is retrieved correctly' '
        rm -rf remote &&
        git init remote &&
        ...
    '

Alternatively, since the "remote" repository is static in the sense
that it is the same for both the "keyvalue" and "nul" cases, it would
be even clearer to just separate it out into its own "setup"-style
test:

    test_expect_success 'setup remote' '
        git init remote &&
        echo x >remote/x &&
        ...
    '

    test_repo_info 'shallow repository =3D true is retrieved correctly' \
       'git clone --depth 1 "file://$PWD/remote"' 'shallow'
'layout.shallow' 'true'

> @@ -79,4 +87,11 @@ test_expect_success 'output is returned correctly when=
 two keys are requested' '
> +test_expect_success 'git-repo-info aborts when requesting an invalid for=
mat' '
> +       test_when_finished "rm -f err expected" &&
> +       echo "fatal: invalid format '\'foo\''" >expected &&
> +       test_must_fail git repo info --format=3Dfoo 2>err &&
> +       test_cmp expected err
> +'

Do we need to perform this `test_when_finished` cleanup? As mentioned
in earlier reviews, we don't usually perform cleanup unnecessarily
since doing so slows down the test suite and makes it more difficult
to debug a failing test.

Also, didn't patch [2/5] already add this exact test?
