Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C972236E0
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485721; cv=pass; b=YT90VaLypfANWUjSOBTQYYN+AxyicdDMPsOtnrpxnk14Fhg7wM47y+RcFxiOkd95JaBoce5YDf2y3+eK5TPocF6cuibbizTRt2GXqAJIJZeoVfcIk3BcKIIQM6msGXnhfU95xd029dX58rJvWuJVgDEawEspfPjpAuxI0eMGoJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485721; c=relaxed/simple;
	bh=OrhD6EBJFRyNqu6aejQxGib6T/Zd6hV1oFRqv/RB2b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPNrf3GofTts/qfdfAYa+3jqF08QL/gu0Xsni9978EG6Sv4XLr/xvV921ceqHSuvJ6mITavzOUbmmU2VfjrIjI/k8N3h2fksmRwBSer+8+Uy8UuM8jWynyNg1LChyy+en7+UP4Px1GvqDKzdREmYrBiDq1BBY4jq1dGLw9yDQUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MezuNySS; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MezuNySS"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so4521873c88.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 03:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773485719; cv=none;
        d=google.com; s=arc-20240605;
        b=Wqi25gnTojqKhDafNFUhKDEiXR1SuExuGMxGMpMj5tnuyiIDYHQoC4kv+K4+az9Rt3
         bEBn1YI/RLSGRl9qBt1AJTPVgwMaCswsBW8jdol0Xt5DRqkjyigK6akC8G2EChkn6gu1
         Jt+d9gsTGSAq+aw8Cpa1HxNYDQYy8C3qxjRxGhikPuem/GxIOam+QW/tkvT0+D4huBuy
         gwCThBbYqKZU7XUh9xtIavZOba/4bk73LH/C3yA3HwPK/ruES47dhL2TZJhaW8/agjYO
         Dvgoc7lwJfZNQ3MXSpv6csFo1yrAbPkcgn5kLJfkKwlUpbUIn7qJQcsVCwJhHLTaTdpd
         11RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrhD6EBJFRyNqu6aejQxGib6T/Zd6hV1oFRqv/RB2b8=;
        fh=cg+mcShEU8BBKbY5b01IDSTH7eSHRnFLcK+dKoOnIJA=;
        b=hjXlV5XsjrAWIRlHZo4JDJ4tSTTwJ5F7SCZM1bhFUloKsKrkLHBIMuoGlUSbK1nTWi
         PX7fGWLeSGvYjja2tSUDfT6FLQy5K47+Y0RG606CZNtnR/JbBWjs1XSs9AZEWVefe9gm
         XQEIIXEXhevlZXG8AItMx4kXMXZbefl175J4ksywwxDPestCaKID7/mI/eU46CjwxmtB
         eJFefUbM16ONbdh3Y5NAVE92GDVSUYFLm8sFxaWhXsz4YkCUtJyLHzrLfi4dIvIbO0LL
         ghb0ZAFZ3DI85e75QzRln00bkeZMMJOT7YROrz2jk0sOAqJBxz2xC1vmtAhnEl0h0CZx
         3HMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773485719; x=1774090519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrhD6EBJFRyNqu6aejQxGib6T/Zd6hV1oFRqv/RB2b8=;
        b=MezuNySSfhqp04cR2ZxBelsQXjID7PajwIKAn1zgoy14wr7YK5MatQKG11B094wR5A
         piXinUkTLq0Lj4yeWQJgGRpLALAKbJqvLEk8naPu1iS6UsY3Dr+C0et/BE3qTfYo3m3K
         2rOv770bJuOBJouObQte+5OkoeYKT8JuSrFHAt2eufqtViHkJCdIzsYS+UVJSogqLVfE
         bU8zA9RFjEsAN7d5PdjKnRThTEsEIzPxw+1OwC7cSohyG3YVWE3T59dbLZEPBNyzo8Ae
         7NsyY387bnJcYTxgwJFfJ+DvzUgiv69PxMgL3LzcytjkOIW1W3YWuwyX/xms8JaBvevf
         hB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773485719; x=1774090519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrhD6EBJFRyNqu6aejQxGib6T/Zd6hV1oFRqv/RB2b8=;
        b=MIfUrlXXtFEZN2P3l0tBGcsMCJJxwM2TYRrfas/wB2QoBgdD1iUT8So08fWPkz4gfK
         ptcWJMe0euPnrFGehS1yuMzizln6XCGA61KMkLZwqxMDn8TN3i2InDZTZp3lFgovIuSz
         gzQxLjDcqXh2f1t63N3fgk2ImwsSA+cGJYmbz/oa11609Qa1dr7x0Xy4Cd2bJu9bvwQq
         qY/TACe5kQKLwpSmUJKxNNF7L+qfL1haKQEzyi65fpRXl31JbrZGQW65ga9IAtb7yHOd
         G+pJPSpKikwrtttnSzyEKh8tFlPKAhFmvyL5L9l8q7Sk/XaxmqJOow0gAokLCM/MvQCM
         F1yQ==
X-Gm-Message-State: AOJu0YwYD6rOMskZWZqsPCFw5ZC8wzV7YPH4GfIPbLpSi1x1QQaoXh/q
	yp6PUFTOvhKtE/HNN6ZYUeeMz1/IgPMWq2KIj6/fLl8sYFFqtwLUC+GXy9oSMgou0kh3pRBrTAR
	OSmkTfDQS/9p3v1o3If2FRJ69YftdFjU=
X-Gm-Gg: ATEYQzwFcHPcgxvfAWhgqGBDRXk183iN25pyxxK19urWeauN5SRLUmYuzhjRd4P7EU6
	RJNNyU9nEzDvFKZkjjv5QPW3mur5h+tPk2wa+tE3+58pDz7FQlGgbHqy+yOUczYgF6xieJDGjme
	twhasmsPaE+vwnHkPxLrrzJky+PBd9htqu3Yxt3EpVjtqY89W6QTCV9oymG4pR3u9rXbQvdLfVA
	uooAbJi4XwanXjeOtRex/8zWV1KQw/v9NsU7K++p9GXMOoXaCo/LLLWO07smdhPHVURkELqjyHl
	u4TZMTIGnLAamgUW1CmvEDzBKH6IJ6OXXBQAwZequKD5DwsuBgurHzhWV5c5mgPGLlVtcBoDCkx
	jrIKgVD8/tirGG5MVWgtwFw0Y
X-Received: by 2002:a05:7022:6709:b0:11b:ade6:45a7 with SMTP id
 a92af1059eb24-128f3d011acmr2966193c88.1.1773485719077; Sat, 14 Mar 2026
 03:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNR0KJ4VeuOF_bVupaTuGKGaeTKa0SMRAUoBPo5wWi8YGA@mail.gmail.com>
 <CAN5EUNSK9Lk-ME3nCFSG=Whkcm-0hvF5Npyj8MaXucKLkmM=Sw@mail.gmail.com>
In-Reply-To: <CAN5EUNSK9Lk-ME3nCFSG=Whkcm-0hvF5Npyj8MaXucKLkmM=Sw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 14 Mar 2026 11:55:07 +0100
X-Gm-Features: AaiRm50KIZoQd8FskSXQdw0wJBhcg28si0Nv1EoPkPc5jXTvli3S4bSxkT7guqE
Message-ID: <CAP8UFD22BtMAJLA0a6pqYRNp55iAWoi7y=_qYdrJUJYxPSz6-A@mail.gmail.com>
Subject: Re: [GSoC] Introduction Pablo Sabater
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On Wed, Mar 11, 2026 at 12:20=E2=80=AFPM Pablo <pabloosabaterr@gmail.com> w=
rote:
>
> Completing my introduction.
> I'm interested in the "Complete and extend the remote-object-info
> command for git cat-file" project. My pronouns are he/him.
>
> I've confirmed that I meet all GSoC eligibility requirements.

Thank you for your interest in Git and this project.

> Steps I've taken so far:
>
> I started reading the docs, followed the MyFirstContribution tutorial,
> I'm reading chapter 10 of the git pro book that talks about the git
> internals and I've already sent two patches:
>
> [GSoC PATCH v2] test-lib: print escape sequence names
> https://lore.kernel.org/git/20260311031442.11942-1-pabloosabaterr@gmail.c=
om/
> [GSoC PATCH] t9200: use helpers to replace test -f and test -d
> https://lore.kernel.org/git/20260309230134.758107-1-pabloosabaterr@gmail.=
com/
>
> The project seems very interesting and currently I've already read
> up to the v11 from Eric Ju's and the feedback he received and what's
> left to do for the proposal. I've taken notes to make a good proposal!
>
> I'm now getting familiar with what's related with the proposal and
> writing a draft
> Once I get feedback from the test-lib patch, I'll seek free time to
> keep making patches.

Sorry for the delay, but I think you recently got feedback for both
your patches and your proposal.

Best,
Christian.
