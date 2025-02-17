Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCE28E8
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830708; cv=none; b=jRhqE7WiOzqWG2kuXlS4ooh/BxkE9eV23gCGAma23QfjGObm4m9Z3mv0TpCVGJjcfChrBmkOD0sUFqMNcRIse/80rxgSc0IiXVrrH4IIycTF34E3pX3rFSQkDcEWmqHnrY/yQJD9yLdHbiIdayQd/KJUWkzD8hLCRjUJ+HgEoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830708; c=relaxed/simple;
	bh=pOGb2q9pXMjh5XIwTd91jIugXUrZSXoFpmuNFp+m9nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVnJ5GEMgSyQE+LM7pcto352JL/7ERIa+ysRp8SVz17YFuj0pcdcdEAQOuc6JeUvqyk01zMhnbJSLnVVnZv41YQzMZ5vCgDyclMS5iXEcMjmC2eN3JYTixI4vMe3mxkq7MbHMzSEWfPXdyErwIIqJ3iAJ6sbmagdXt298jVRw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnutyPil; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnutyPil"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d284b9734fso22841205ab.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739830706; x=1740435506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk7dZpw5/EpZGXZtVcFR0GjIkbJxm+RMwMf05dArF40=;
        b=DnutyPil2s56PsmKNEdTiHnPMVDbvxir3ThJhpKgfhS7CUPspFoKfUW2jgl32ggbPT
         VsZ6nDSxsPbQmaXusDui74RHaOVh2rp9a/G+EGGAerXYbZsW6KJkES8spv0G/VsMZC2O
         p9uUWNzINyZK8sYt6+1MbrHsvdp4Ujwt2wz0WJFGJIM8Y+dGzBdb4VAeGcZBCPQiepOn
         L9OnxTdgdClZ8Y7N3mDvNGNMgc643Y9ZTQmM+2p/RxhuXl+OOB4dLIu3NKjIlplLdbI7
         EK8SpMpisouPS0bvjm3we7CAVTIgoa4AlhA3SZf3xZTSUEVKt889DzRgNgtAJgV3PurY
         +p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739830706; x=1740435506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk7dZpw5/EpZGXZtVcFR0GjIkbJxm+RMwMf05dArF40=;
        b=m32Ol5CRLK/b09NTQTTAg0IEhnGZ+Ck3tdWt/FQmIFWGxLH8g7TO3fP21fDuJKK6+O
         Uf5VcyIsuH49QGykBaH5PzppIZHkzIomlbmKX6HyrPr70VBSch505jhibFOUcm6ah9dU
         txCC0P9zuPZXwfYhL2EpDGuLXd7ecWcfI9RSFvTuf2IZEYm9n02+c3NQZpMwCKU49tLx
         vpQqtjq8D2Qt/r8jclADH1A8UAeBeXeGS+8mD3dcJKfkKwVZD9C96os9vPrJK1o7jCsj
         f/f6eSu3VpGItgp6nTw4toaEhMplj7sz3reuOEd7wuoiksc5h5MjNZscO6Tps2JUnvGK
         VQeQ==
X-Gm-Message-State: AOJu0YysaWQWJ2Gw+weBgYmkSLXKZ4BmHsScTn6ZbN2AHnUCW5FGa4tz
	HYw9FN259LXP02U7S3mp3S8HjWTBjTBtZvW1uf0+W7LdbBbC+3Ju3w/xpbA6do/ZbXx1VuzHSXS
	VEGCT8XA0tqSEH96DSW5Dori2lHkhdA==
X-Gm-Gg: ASbGnctiJHbyEz1K8egkVAdj0pR9rSeH+IGL8Q3JfAvA2jiwZ1EBTk9m1zOvvqEss0d
	pSZ6WKTZXoPeden1508gNV8Lu4pe1eskkj3l4gyjppvy7shP630J5MKNBYzjqE4g5kyKoAtxfEk
	Zn0Sbf4P+01Rgf9jAhRwibR7W26eHGCA==
X-Google-Smtp-Source: AGHT+IF+cdCWnAtRy6eHD7R43dz1jjQSM1//vssSkEAl4hTXJznFGGy0gNEe/3+OAUZtsowP5t4VM1KLEpbyOy6r/Zw=
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d2807ab183mr110733185ab.3.1739830703715; Mon, 17 Feb 2025
 14:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net> <20250217175759.1576684-1-sandals@crustytoothpaste.net>
In-Reply-To: <20250217175759.1576684-1-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Feb 2025 14:18:12 -0800
X-Gm-Features: AWEUYZkf2tIo8b0zS5oMDGegKRueRM9Pz1Yi8U1sVFqRxT5pvVVXn15KIrBwZWQ
Message-ID: <CABPp-BF01SYAr8TNxMBNvxPKseSqLH4mVC=MrrVp8w9ejEzK1g@mail.gmail.com>
Subject: Re: [PATCH] diff: don't crash with empty argument to -G or -S
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jared Van Bortel <cebtenzzre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:58=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> The pickaxe options, -G and -S, need either a regex or a string to look
> through the history for.  An empty value isn't very useful since it
> would either match everything or nothing, and what's worse, we presently
> crash with a BUG like so when the user provides one:
>
>     BUG: diffcore-pickaxe.c:241: should have needle under -G or -S
>
> Since it's not very nice of us to crash and this wouldn't do anything
> useful anyway, let's simply inform the user that they must provide a
> non-empty argument and exit with an error if they provide an empty one
> instead.

Makes sense.

> Reported-by: Jared Van Bortel <cebtenzzre@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  diff.c                 |  4 ++++
>  t/t4209-log-pickaxe.sh | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 019fb893a7..c89c15d98e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5493,6 +5493,8 @@ static int diff_opt_pickaxe_regex(const struct opti=
on *opt,
>         BUG_ON_OPT_NEG(unset);
>         options->pickaxe =3D arg;
>         options->pickaxe_opts |=3D DIFF_PICKAXE_KIND_G;
> +       if (arg && !*arg)
> +               return error(_("-G requires a non-empty argument"));
>         return 0;
>  }
>
> @@ -5504,6 +5506,8 @@ static int diff_opt_pickaxe_string(const struct opt=
ion *opt,
>         BUG_ON_OPT_NEG(unset);
>         options->pickaxe =3D arg;
>         options->pickaxe_opts |=3D DIFF_PICKAXE_KIND_S;
> +       if (arg && !*arg)
> +               return error(_("-S requires a non-empty argument"));
>         return 0;
>  }

Simple fix, as expected.

> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index a675ace081..0e2f80a268 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -93,6 +93,22 @@ test_expect_success 'usage: --no-pickaxe-regex' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'usage: -G and -S with empty argument' '
> +       cat >expect <<-\EOF &&
> +       error: -S requires a non-empty argument
> +       EOF
> +
> +       test_expect_code 129 git log -S "" 2>actual &&
> +       test_cmp expect actual &&
> +
> +       cat >expect <<-\EOF &&
> +       error: -G requires a non-empty argument
> +       EOF
> +
> +       test_expect_code 129 git log -G "" 2>actual &&
> +       test_cmp expect actual
> +'

Looks good to me.
