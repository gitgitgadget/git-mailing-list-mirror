Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22484376BF1
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654714; cv=none; b=gGHmXU+2vkUipER5M+1vkUk/HtONxOl8tc4vqDtHuunYD1alUuCM6OgnPIdx3CjV/jO2bM7P2wZSzlZHivwTggtU8kTh1q6xB1CSWIS8nVpmxWK4eWJTJnRdcgnzsNPZa49hAfowTqRCClbKogX9Dvpw7OE0abVo8HJ2UtlElKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654714; c=relaxed/simple;
	bh=j3xmXinsz9lVf+2HYWVGrLs+2ZvbZS6JzNKLj3mdtoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RS3pjywFE+UEsRQGw9InjBdQ+IOh0o7gi4Dc9MQJEP8JZ8l3/sSWW/OibQmPSejA01w4kdpwTxgVVXsn2YrNr8CsuHFQK9zBetTDAJyM0znWCQKsU5llcvrQ4JBWxN9IB58W1bVSCbN4U4vAHtLSuq93Qw/x9mZB6+L3qVQWZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvi5rlmg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvi5rlmg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343ff854297so1506472a91.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763654712; x=1764259512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAEjYwsq0+nSwM6A3kTYrgsZhsW4hsWEP38+qo32BOU=;
        b=Fvi5rlmgtKxoR+RzqTpVPfIjh6kEhe5DWRBKKp4o6N3yPmVNIoLXU9508bxcNwDf/B
         eSN+pgTaEnwa0343JTsWu0POL8qo1XRN8C2kDcOWlH/a8nk1LM/zNeJ3t842GG6r/EEn
         lyv+VVcgPQJsXk1bu94aBEicbOMCU0McsUn2FBIGJmXlv3zCYC0AYKIjIZe5ozIIs0cA
         X40RIQGnNx8hiyYjKpvxBGSxD+8ufYnG09ts4Xz6rogtzu1shyX0JAjtS/Zbv40HlpN8
         0furl0N3GOeNHTjABXaYDdYQYC6XLA69yyFrqXUv0olOBxNTvHpEonJPIjxW499STXXM
         ESrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654712; x=1764259512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAEjYwsq0+nSwM6A3kTYrgsZhsW4hsWEP38+qo32BOU=;
        b=sGKUNiGUqjVUxWdBpV9Y9WNaY+qdnw6CR9tIes3chYjzKZ5uaUCdMTXI0xpUee7dwA
         zib50o5aR1/zDJj1li3+iK8krSeY67p1boziTCUIZ0yQ4xcU2iO0JCnB5VhABxM7Y+b4
         IXletnIWGsfD6Zx2ziMID8VRalw+4KtCO02Vv8xOR+kYYZ65/Y5g4l0wMy/CFkahSF2g
         DeL67DhgM19gpCPW30xd33Eyt698OCWCfm0Z5FZrmUBNkwWA9x1ylY/W2DDLlV/ucLu0
         Z2+eauY0I2G/CCFO2S/QsE5Zk5BZ5Igtx6+u92crQizHf/l3offjkXZDqvvIeXiz9Veq
         H9WA==
X-Gm-Message-State: AOJu0YxoNA9lfJicLTlCOr2j2A44lDVI09oEMq7J+0LXSyol67b4jP5m
	8LAR89bYb5fI5U1mudKkuKEXIl5BqjLetiwoaVZxutBiJyfXaydjJiCJoNDvr9gkHdY90YTIp4t
	rJVFrSyKf9178Q+2bRvxqdCUVjLfSI6HA+O1ORVI=
X-Gm-Gg: ASbGncvVbzSm+VldPxPDSL/4nYPP0c5OTXjVDlCnWoa2/2zR4O9GIzpQk1gx0yMa4FP
	LlE6Va25qngcQ0XTax6goPrT2n5TyQ8vje1qctvxMfhr88/+fblVMLAX351IZyoDp/Y283F86j7
	lDWFzVIoENXp2BhgfAHK3OUSdvmL5py5YSluuIaymyEYp4fQclZvpQPwI283jdhxbq1zFXBSbgn
	XibnteCW5/ZV7Vkcn5N5hRuCMPwJQJj8KArKRFxRf/LYdDJOSbYtrkA3UmYm1pNU/ftk87oCfUR
	SiRle+0=
X-Google-Smtp-Source: AGHT+IHhK6rO5mnU7e/tfUEevvIg62XR+7BGzrPL9aVC+YFe56AX2fnzB4EFRHXx/WaPC9Tw5FQnvjwzALcqCrzrZzg=
X-Received: by 2002:a17:90b:3cc6:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-34727be8de8mr4448181a91.12.1763654712073; Thu, 20 Nov 2025
 08:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmkf25oq2vka2kipfqfybngkqffbljqygmtrtiujgsrao7g2wq@k56wxix4oism>
In-Reply-To: <xmkf25oq2vka2kipfqfybngkqffbljqygmtrtiujgsrao7g2wq@k56wxix4oism>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 11:05:00 -0500
X-Gm-Features: AWmQ_bky0K9ugso5AlRHJXar3qlOjBBCv7AMHDF6iu1Nwvdo-5qZ19D7DhP_BlQ
Message-ID: <CALnO6CBdc=5KpUwweMzxpT+9CBXZVP4AG4bFS9sGucJJVmzjtQ@mail.gmail.com>
Subject: Re: `git submodule update --single-branch` tracks HEAD instead of
 branch from .gitmodules
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> for a project I'm using several submodules, showing my issue with just
> one of them
>
>         $ git ls-tree @:layers | grep poky
>         160000 commit b33a8abe77081a2bdda0d89c61736473b2f9bb8b  poky
>
>         $ cat .gitmodules
>         ...
>         [submodule "yocto_poky"]
>                 path =3D layers/poky
>                 url =3D https://git.yoctoproject.org/git/poky
>                 branch =3D scarthgap
>
>         $ git submodule update --init --checkout --recursive --single-bra=
nch
>         ...
>         Cloning into '/home/uwe/work/sri/poet-server/layers/poky'...
>         remote: Enumerating objects: 8775, done.
>         remote: Counting objects: 100% (3119/3119), done.
>         remote: Compressing objects: 100% (158/158), done.
>         remote: Total 8775 (delta 2974), reused 2961 (delta 2961), pack-r=
eused 5656 (from 1)
>         Receiving objects: 100% (8775/8775), 3.24 MiB | 15.45 MiB/s, done=
.
>         Resolving deltas: 100% (6158/6158), completed with 391 local obje=
cts.
>         From https://git.yoctoproject.org/git/poky
>          * branch                      b33a8abe77081a2bdda0d89c61736473b2=
f9bb8b -> FETCH_HEAD
>
> so far so good. But:

Is it? You've only cloned the HEAD from the origin:

       --single-branch, --no-single-branch
           This option is only valid for the update command. Clone only one
           branch during update: HEAD or one specified by --branch.

Perhaps you want to use --branch here, and _perhaps_ update
--single-branch should default to submodule.<name>.branch ?

--=20
D. Ben Knoble
