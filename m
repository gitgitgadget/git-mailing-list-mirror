Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B392DECBA
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290217; cv=pass; b=XC3nqQFE01hIgonvqafHd+ZqZQE4MhnuDMv6HA0hJrsQUfxvC4c5Lbtlyab8t9kSaawpjZqKqSdUk0oUE+XB+hLZnNRpnzn430yUW9ZN2vb0GhQXf759GImJjgkP+xKZ0KLe/owG/o4b8H9x9HbPR8acBeiIqPLndUKLyjeeWOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290217; c=relaxed/simple;
	bh=keySJCI6eKh5autoNWQTMQDGUCLnjw4aD5NKf+NYt+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+xLuRF2UmMD9nOjytnZX2G75llnDuHduO1gg8/5+s9J8yTqxpQ/3sqAU9FV6KN09nqFVLjErIjVL1QcpSbly3XEJZKfoc9AHRmrto9D8Dy2AUGSG4HFsljbzumNisokxN3ZCPTVShY11X5ZNuIp6LY4ny6bn65s7tkKoBUrkg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFi9t71U; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFi9t71U"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7950afac0ffso14712157b3.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:16:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290216; cv=none;
        d=google.com; s=arc-20240605;
        b=RAz3wOTpKWRLro+b3UsP5sH2Y9J0zQzzEypM4MDBwZfJL33WAuVUD76dFLuWdUYfLw
         +pluvEBmh2DWZtcfPyaWUXbX/4u8PxPCZFlSU2y0sP2GCWiHf4Vy2MG7kShY8XNxgyBb
         kRaw4dKt6yj0bbYqM+XachwbPJBygVI5frUcHGonyvgC3yXvickwTWjc/tYFunEq1CvG
         Rs3vdvWTLkGcITfjYgD1ic+nbhOBcfMfHsRuXFbfLYZh/osJ/71BPfVFqY/ozQ08ewj5
         mRpOg7FRL56oWX/ePHeiOhEW2AonOu1feSYR5/K4R7vIn7/iTRlSpNkgE0FbDS8S2nRa
         C5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1xLD1gGP33zctpAa5wB34eW5Yt2fWMG8b/Vdfw5xbU=;
        fh=RfFcVb/wFaDytUTVLzH3sT8pZDjjuZtt9E/3B30p/JY=;
        b=JqZUUetrvi1G2Uzy7R2VLwa6NqWdttItl63YFcJ2CnEtz4uNceqWpcLXokzE6daC5O
         V8IY5BvMvOP5hEBdrgGbkyFEKNm8D8XWhgwWX5XqdrndgmJmSzfckk6yxo7ARVchIkgi
         +oG2p8kHHNTxTR8+LUbUK6jt7dJjUl7aKQzIcRqMszBDpvMWWh8OVwtse72+S+JLemvv
         vMm50fwjmn7H9gsGEgtBPKW9mH+6Q9z7rxr0Isu/LtDA7SQiOGBue2jfdF6Mj11OYnb6
         Jks8YCbfHSVcqwgfcZh/CvyI1D+61jMvk8QUS2QFPW5XDgmYs3VN5lLGaGKwH4swVb2r
         Kypg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770290216; x=1770895016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1xLD1gGP33zctpAa5wB34eW5Yt2fWMG8b/Vdfw5xbU=;
        b=OFi9t71UMdu3XgTvUHKhoS/blakrAW29OP5WROm8IrQzweSs80UoNshrxQuYV6gAhN
         1AvgXJhhF5XBgMxidZR82QFQdSvIwRAXxusZhMmyUzlJvunZEvwSx4WdyoOgdU4freBO
         leU0/1V74ysrETcnPaOLOC4BPXiwdWe7+091tqO1nVtdte/O7yTU+QDRg7ntFfBRVAQp
         JyJSKMY5r/aeY0RijADvgXqpkacxtdLZvJ8xd7ggdHwWcl+3DuWlAPpRGJ07y2BHQIfW
         njlpjmfXkjJDxUImx6XpJHRC7ZoCGuFshUJMLNfPgzDcVJa9xrpPvypD/yP1HbcetGrF
         68Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290216; x=1770895016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1xLD1gGP33zctpAa5wB34eW5Yt2fWMG8b/Vdfw5xbU=;
        b=irqJAbsok5fCZc9OxXlKWrS1noh8/yk2TQgJAUcwz+NR/6wAh19qCxR/ZDkBsSnX0O
         lAM64PXEHNAgT/37kaj27nE4Ne+ycZuJyr79AfdadO4NIoGZnKdPhS9Ho8SWD5n+ZyYD
         CjNZ3K7N+wH5fEc+w6h20UCuZo79nRHxQA0q7hnvikhgVdgh2uL1UYW3FLc0cLqsjhmc
         bEyLnZKDbtJ6xuSx499CXC0lgA6KrIG/37toyU3xjULzUoKbw+l8qWzRgTtPsMSbGZ4L
         e2o+folr1cxmqZ4oUdvOu0aO4VIwa4r8fIgL9wK4hyNfHGkA2BDY0uLvNcGr5PeLyxrF
         vY3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcLpWO9GdpPUledjN+Z5XSF8j+OhGyREX9ko3Laz5fl1KLuo/ol78LgKYvgZOtzzJlVbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2ayU0y+/k3ZQy2aGGdxV94lTpghNAm2eiovGV5uhTX5SFJjV
	iaXGkfGCQ0bGBebhkmE8B1uIf4mPCGR7H0swET7dNDvLfGuf+5ppXKL+LnpjUq2V0jPu8U5hJ4T
	NJrR1VlpTUi8TUJHON42OCKW5XdAkfks=
X-Gm-Gg: AZuq6aKefxSbyxmwRHxXhvB1KoR6fIIq1t18kvGScHYiSxaRI7slDDucD1hCg7pfW3s
	C85R9h2qsGzUhx6BwvuBfMd7nVE26pxioX/LMtRJgrww9sUTD47Z8zJ7lP38JZHcY4UWVfY8Ez/
	RZFCmW9bVOuoUbBPjicuoQ3Yf5N75L1pWkZw7P2vj21MfPmpIXEafGFYjXVTkQu77iG+xXZ6k/S
	BLCD5rQRwThxx93cCglkSGWa6X4Y7HpnQjIn3A5GalnrVnYYuVbrRCqR03E0IfEz2fLtXPNeN6Q
	7Cgx9xe8yLfbX7xRoC5OhYGGfTO1J8rQUPcv/JY7KXizC6FPdbSX0fPZjrUtbb9pVHfNkJc=
X-Received: by 2002:a05:690e:14c4:b0:649:e9f1:bb9d with SMTP id
 956f58d0204a3-649e9f1bcccmr1350352d50.36.1770290216267; Thu, 05 Feb 2026
 03:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se> <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
 <CANYiYbF295W88XUXqeiO9SXjDTMbJo9h8=mNk3xNALPHTXwvsQ@mail.gmail.com> <aYRVElg21EdWkjxi@kitsune.suse.cz>
In-Reply-To: <aYRVElg21EdWkjxi@kitsune.suse.cz>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 5 Feb 2026 19:16:44 +0800
X-Gm-Features: AZwV_QijR9zwP7HIZknXD3a7GUJzWPpQTqSyMUEUfndKPwDYzHJWI_OX7Jyqn1s
Message-ID: <CANYiYbEJymkh1bqz-iJeSOZ4D344Mx7G6iD6hiCpjzMnQx0SnA@mail.gmail.com>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Krefting <peter@softwolves.pp.se>, Alexander Shopov <ash@kambanaria.org>, 
	Mikel Forcada <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>, 
	Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Jordi Mas <jmas@softcatala.org>, =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>, 
	Phillip Szelat <phillip.szelat@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, 
	insolor <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>, 
	Ray Chen <oldsharp@gmail.com>, =?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, 
	Fangyi Zhou <me@fangyi.io>, Franklin Weng <franklin@goodhorse.idv.tw>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 4:30=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@suse=
.de> wrote:
>
> On Thu, Feb 05, 2026 at 10:06:58AM +0800, Jiang Xin wrote:
> > On Wed, Feb 4, 2026 at 9:00=E2=80=AFPM Michal Such=C3=A1nek <msuchanek@=
suse.de> wrote:
> > >
> > > On Wed, Feb 04, 2026 at 12:58:05PM +0100, Peter Krefting wrote:
> > > > 2026-02-04 10:31 skrev Jiang Xin:
> > > >
> > > > > Please try using AI coding tools to update translations in po/XX.=
po or
> > > > > review historical translations, following the prompts below:
> > > >
> > > > No.
> > > >
> > > > Please disable this altogether for the Swedish localization. "Trans=
lation"
> > > > using stochastic parrots is not mature and just creates gibberish t=
hat takes
> > > > more time to clean up than to do the translation from scratch manua=
lly.
> > >
> > > Hello,
> > >
> > > a similar attempt was widely reported, eg. here:
> > > https://linuxiac.com/ai-controversy-forces-end-of-mozilla-japanese-su=
mo-community/
> > >
> > > As pointed out the availiability of the tools is not necessarily a
> > > problem in itself. The problem in that particular case was that Mozil=
la
> > > automatically applied the tools to existing translations, even
> > > well-maintained ones.
> >
> > Thank you for the context=E2=80=94this is a good reminder that automati=
on
> > should never override community judgment.
> >
> > To be clear, using AI as a translation aid is entirely up to each
> > contributor. In Git 2.53=E2=80=99s l10n cycle, I temporarily handled th=
e
> > Chinese translation (as the usual lead was unavailable), translated
> > all new strings, and fixed many issues in older translations=E2=80=94bo=
th
> > speed and quality were surprisingly good.
> >
> > As an l10n coordinator, I=E2=80=99ve long struggled with reviewing PRs:=
 while
> > git-po-helper catches technical errors, it can=E2=80=99t assess transla=
tion
> > quality or detect irrelevant content like ads or political text. Here,
> > AI can help flag such issues during review.
>
> That is really sad.  'ads or political text' sounds like something that
> would be visible immediately if somebody looked at the change at all.
> Which implies that you do not want to look at it, and have AI review
> it. That is put AI in charge. That's not going to go well.

Git supports 19 languages, 14 of which have received active updates in
the past year. How am I supposed to perform semantic-level reviews for
languages I'm not familiar with?

In principle, I should trust all pull requests provided by team
leaders, but having an AI-powered semantic-level code review
available, especially for extreme scenarios or to assist contributors,
isn't necessarily a bad idea.
