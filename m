Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A3375AA9
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281502; cv=pass; b=Qje6R94rpoX9NvCs5v5EEUmw6M7IOkxCnAPM3V4dp9RUHgRHXoGFo5ySmronjcM3yMlOfdOvorI6lBtrMjzOhLGQ29rsUsZkl0ddNQbnsKuDk6nDAK9J06B6mob2gGUq/N2ZhLaaEaPaUKpbTNhxw/anrz/EzANE0JTYqsGi5H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281502; c=relaxed/simple;
	bh=55gKvoWgyDN5kZ3KmQV5Lbwx2b2lIVJI+ZjDzimsdFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQSYjsyKYyrcwf7eKd7ZxIF68FEwq7qLU28TkjNTsXDfZnhbKMfeZ9Gwsjg6adiiFWPoiJ/+IyWY1IDAzxoezNRQGJTW/ht2g3ZHz9jDP5o3YHTF74qnCIFtijbddvy/l3qxSdaLhb3rHTs7yLe1lJZHgFAln58B/JEHY9Zc29E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzq3Xu3m; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzq3Xu3m"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-127380532eeso383821c88.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773281500; cv=none;
        d=google.com; s=arc-20240605;
        b=MqNaeErE66RtL5hr28FSt8TDRN8VF5xwt8r0EPPV3fdJokqo/T7EEx0yOcJZY2vSBY
         mbG0+GFuiCDkVd95nh37K84cU1Ebz4BGqgr1sfHz75scLlcpM332XR+5EoKTOIEF9ild
         Wud6Tiq8V2ezUniuJBOJCsnzHfRwRcOaRO5y7Waq+3/qxxWuNKNQolXia+xVtLo1WHVQ
         sc7/LGoHKWJcoPyD1TF1goeP4azIkji+2BUI3rYRqUYfOu8vGXvLd7fw/gQtiU96hxWu
         Edke3GWeOrtQBD6sHVq29rEnIsEv2jpx4TulhXDrtBpzbQjtRv9vxHX0CjErrWSg4Gtw
         KnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55gKvoWgyDN5kZ3KmQV5Lbwx2b2lIVJI+ZjDzimsdFg=;
        fh=m1InK6W840f8eoz/kXTt2NAhSmLI+5gQ0Uo43ti2bNo=;
        b=WmNH3ZJv3YVvoNB/5XGs1eXsTtIQkgwuwuCntKNPJuw1OI5L4SlME3V3k4ZwTauxaC
         xvaal7AhfO7tlZc/lrIJV7RWXaicSNtWbuVYLiQn7Mq2WRVLniDxibH2y9ZW7a4qYkNh
         9gD25J9c+rUPfC1KTLNW2RJm+5ZV3+AtQyO/XrEWN0ZTEF8Kcc0nY27/lHlR8rrYEIni
         +vQOL55gQacY4qcUTVHLbafMUmMdnzFGPj2LMBRpOVtFh1OUF1g9jDebcqOUA0zpG92U
         w7lWZ2Go1BLvbN3RvxM2ziA9UaKMjUqqrxEK8mYYZphvZ8MUXGXvbFbePMWsAh7AP1Et
         qxqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773281500; x=1773886300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55gKvoWgyDN5kZ3KmQV5Lbwx2b2lIVJI+ZjDzimsdFg=;
        b=mzq3Xu3mxsEHsNzZk1nJv9BM5AYkeZsv9lm0ijBV8j11+Ojx42wDYtPamdz43ZghB+
         doe0Dy0JmW/GoHdckPjXCYhHovrJS08fJZ4C4Rte33KvfFfll7jHXe38jh7UqpwSopFl
         uEYA25YbUmgoLl1eKdY00r8V5xjCfo7cg7xW0BID436JPsI4jB4K54WCHlCgf2rI8suA
         TGzJR4XmQGSdTOfIca6n/qEymXWK5GinHKaTSVzknjwZYg6+0mKUhgSJI7xoJ0IeHPZc
         qNOTSdBWPEESPp3inS7fwwBAP1uYx5r0d86wT0DD9lwB2m0CUWvumSLqARHyts8CaG/S
         Spqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773281500; x=1773886300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55gKvoWgyDN5kZ3KmQV5Lbwx2b2lIVJI+ZjDzimsdFg=;
        b=Ik/otLxIeTBiAGnm6FCq/EW5SfS2YnfU/Wfae4UChb6oagNcYIFYOWkxfrrb8Njb95
         CVQffRhJ9b8DzfSUrXZHJZ5gMq1bnlz/WtVlx2CI1jCMDe0YckJldOMFH3xjzLX7H+JD
         78N559zuum8tcriK7NxdcXRqXYhzLuV9+5JDeoSPw8MrCXbhDHfiKuR6j7a6ugLXYYR0
         toYM0DndMLlhUfeizM1NI5xpWepQAVKir+nprEG2I7G1ZqOB9uYtLjJQkKzG4t2Qz8Oz
         2huskgoqsR0RaJ1JUUOGBhgErvcFxglmcIbFw/ckwzAO0pOW7aZHjlGDPLAK4T7kwKoy
         X/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWalEWGkEDUZf69jgw63C65yGg+58/wyFnDx38kNhvEBewbHYcQZ68rwx1FqfTMsd0+B0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdnt+5jHiOouoGJUqyLWc/P8yVjgz9mNh/2q1W38OMYHeefNZC
	7IQWxqHSICmG+fdAlw99ltFmud4ndo+MgnjKzQTu9qalk+sFvrMqXjN+oEJVVHf8j1cgENxXYXC
	RQlLl06/QRx1Y8YsSMOTkF81pPP11pd8=
X-Gm-Gg: ATEYQzwbPLLU3/Noli1fSSeWZQ45+PONuna/LWeknFfuNlBGjNVCF24cwV10mzGkqv4
	MaHniuLz7+ON1wALZ+BlS/ExYmX/pD5sa8IrfN8oKMoI4GWUp8h3TAcfn0UR/b1f0Ow5shgetp3
	LiNl0ppHC0FLmtjSkMMzj9qMCjU0aXXmPeL6cbeDDhLSUf0rKVOoNXtRSeBT5+Zh6U1eP+uGHip
	pk/SU3GUDzG8LTL3wCqswbklYXZirBUslrM+NNxi6WqcGdaL7uioS4U65cn+PUjzGoEt15pMhJv
	2qrIOl3Ci0SK/7Kt/bin9ZIBaMTaannSh3yzL0cFkonb0bNWAmFuDXe+FkaMUPkDqL91J39mzbg
	UvF5lLXg=
X-Received: by 2002:a05:7022:698a:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-128e75f705emr2708438c88.0.1773281500141; Wed, 11 Mar 2026
 19:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1772551123.git.worldhello.net@gmail.com> <5e23a45964fa86bf710d5e04396a574dc8882ef3.1772551123.git.worldhello.net@gmail.com>
In-Reply-To: <5e23a45964fa86bf710d5e04396a574dc8882ef3.1772551123.git.worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 12 Mar 2026 10:11:28 +0800
X-Gm-Features: AaiRm53G4AJNsk4Lc-cd-7X93NeVLcW1Uj17eo2isBlGpoLWcTrPgc4x3tBbjKY
Message-ID: <CANYiYbHC-DZyc1jALswPN2NTcgC5-icV5yiwT3Ex-65TAdk+oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] docs(l10n): add AGENTS.md with optimized
 update-pot instructions
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:33=E2=80=AFPM Jiang Xin <worldhello.net@gmail.com=
> wrote:
> +### Header Entry
> +
> +Every PO file (`po/XX.po`) contains a special entry called the "header e=
ntry"
> +at the beginning of the file. This entry has an empty `msgid` and contai=
ns
> +metadata about the translation in its `msgstr`:
> +
> +```po
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: Git\n"
> +"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
> +"POT-Creation-Date: 2026-02-14 13:38+0800\n"
> +"PO-Revision-Date: 2026-02-14 11:41+0800\n"
> +"Last-Translator: Teng Long <dyroneteng@gmail.com>\n"
> +"Language-Team: GitHub <https://github.com/dyrone/git/>\n"
> +"Language: zh_CN\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=3DUTF-8\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
> +"X-Generator: Gtranslator 42.0\n"
> +```
Will remove unnecessary header entries in the v3 reroll to make this
file smaller and more concise.
