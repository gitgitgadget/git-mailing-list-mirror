Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3415990C
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891081; cv=none; b=sJdGQPMIRVRHrSh8pUptHk6OK5p787Y2ylI0PTnWGsNopP2qh4Pucx21SsxFa7DhwZVcKbbbdRgQAXith9oG4XQBGIbtb7OTdpnsorRqe7YlupyfdpIG3ty3FOLAVAC71Vn+bZse52s/kyVKIzvglxHZ9q4Z8Lkw6XmRZQqNgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891081; c=relaxed/simple;
	bh=1W43fvx2Mcm+TBDwPWHGz38sQYPvr4olhTEd0xUYI/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWtoaSabtzvk2gotlTFX9vgUQSUrb1N6Sg5NW1nresi/vVd+GVjhlBb9GXylNWh7zkvdDwPGHm3Y/VYPkpGnoMMbBmusdGxdbqYE3+B7uhtB6MVqMAmF0QXY/z28GvyXoir7UkCO98ehutyc67fprNMn+DOt3+q1WcTXpFaZvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e6984d694cso98086985a.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 22:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891075; x=1755495875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDwuomWMXyIyI15X9cD5KpKUypiMpluRifopfeNCKvo=;
        b=EmzR4xvjEwmVsGAEFRqkEAWoXYwPeps/Md0Ex2PPuYJL85zh/iTaiOBYXFEw/LCM4b
         8VK1DQPk/Q8t+bJoLRDCwbvBh3M2UwmVApMbm7qDGjOpFoCbdn0z3usd0+VjDuGD/O24
         Ve2+L80WGkQYtkbz8mPul4zJG0LNy1rXK2MwsjefurvhTTtSJYmoz2MjPeDLfAbWRMKW
         lkgURIVXva3upHLnY34NEB/I9s4/H3Z1I5aTro1DhRhdaFEUAh6XWKKjCYURfkGEzWGg
         GG5tTgZLwBARfpEcQC6fsXl1Zw5ApDt8VuyIuB/l8ln0mBiyMIvatzV/JEK2YNaif7H4
         De/g==
X-Gm-Message-State: AOJu0Yz66j6n70yJu0kctzypSFL5mCV2zWo13W+fQKxfRoXG29Mv7RO+
	nhn1TZqYnH+WLCyB5D14l8J8IooXBPYCqpbM3huooZDbRrxJaLHdARDO1Ppj56pcmKxj2/1qsFQ
	AGAH2iT+KQpdXpfKYYTkwpckqQuPnOZU=
X-Gm-Gg: ASbGncuZesP6i5C5vBcY5kRWbRviQzaHB+5ZfhQo4XOCJmqunp8sTf1T+uCu6LJRYD9
	XfMlCJ3+fdKZ0owLADgcv9KkoPJAjLVrRXRne4Jz0hLQTER0JArk5kbox9vHn2a9nnoOYRF5bJu
	Em8YjnbijOMOQ+CIW2rFKOBBG7YmAyDjI3X3cKYGCzOf6b1MMVV01T29RuGUDD7IpLdpS0zizg4
	YZcKeeV+gb3Msu8/AjT8FoO8ZFuykMkXJV8zETZ
X-Google-Smtp-Source: AGHT+IGqxHbe0/K8SaouQZRKOVo7PxjGLoynNYcb0NUmLy7mUSvVTbKDKVG3Ohvan6EgtS00Mb89fWqqMs2gdwbC3p4=
X-Received: by 2002:a05:620a:2596:b0:7e7:fbbe:a193 with SMTP id
 af79cd13be357-7e83b6a9b86mr515079085a.3.1754891075541; Sun, 10 Aug 2025
 22:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-6-lucasseikioshiro@gmail.com>
In-Reply-To: <20250807150239.6987-6-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 01:44:23 -0400
X-Gm-Features: Ac12FXxrjO2NpsffHyYCj3XTWq8vWz6BHUCp_mdnmspsMHVYFX8VUoVORXN6IaM
Message-ID: <CAPig+cS0F0KYrgfspGGrYtGuisWxDqC+VgKuASRghBE4aFSiTg@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 5/5] repo: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:04=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
> [...]
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -21,12 +21,22 @@ test_repo_info () {
> -       test_expect_success "$label" '
> -               eval "$init_command $repo_name" &&
> -               echo "$key=3D$expected_value" >expected &&
> -               git -C $repo_name repo info "$key" >actual &&
> +       repo_name_keyvalue=3D"$repo_name"-keyvalue
> +       repo_name_nul=3D"$repo_name"-nul
> +
> +       test_expect_success "keyvalue: $label" '
> +               eval "$init_command $repo_name_keyvalue" &&
> +               echo "$key=3D$expected_value" > expected &&

Style nit: drop space following redirection operator[1]. Not worth a reroll=
.

> +               git -C "$repo_name_keyvalue" repo info "$key" >actual &&
>                 test_cmp expected actual
>         '
> +
> +       test_expect_success "nul: $label" '
> +               eval "$init_command $repo_name_nul" &&
> +               printf "%s\n%s\0" "$key" "$expected_value" >expected &&
> +               git -C "$repo_name_nul" repo info --format=3Dnul "$key" >=
actual &&
> +               test_cmp_bin expected actual
> +       '
>  }
> @@ -44,12 +54,15 @@ test_repo_info 'bare repository =3D true is retrieved=
 correctly' \
>  test_expect_success 'git-repo-info fails if an invalid key is requested'=
 '
>         echo "error: key ${SQ}foo${SQ} not found" >expected_err &&

Nit: Here you used ${SQ} as suggested by Karthik[2]...

> @@ -80,4 +93,10 @@ test_expect_success 'output is returned correctly when=
 two keys are requested' '
> +test_expect_success 'git-repo-info aborts when requesting an invalid for=
mat' '
> +       echo "fatal: invalid format '\'foo\''" >expected &&

...but here you did not.

> +       test_must_fail git repo info --format=3Dfoo 2>err &&
> +       test_cmp expected err
> +'

[1]: https://lore.kernel.org/git/aJQ3sVf4MsgnCaMz@pks.im/
[2]: https://lore.kernel.org/git/CAOLa=3DZSX0hFt7PRdXssz2xGG17bmDchS=3DEheB=
SmQj9xr+r_baA@mail.gmail.com/
