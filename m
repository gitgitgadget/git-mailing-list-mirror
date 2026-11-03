Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730446;
	b=lGCwO42G8SUlXeoukgXVvimsJCAGg3zeJ2yxfwDoFK1iu1G9hQo1Y1um5FIosqjqMU3h
	 lW7MSfEu2OJKlDLYzF4UiNeJqRrWN1DotYdqRbXvWbfxMLPSPZCp8ozmcZ7+E5l2n3/ud
	 TEXWrRNULNPGGjhBaS01p5mRGyuOaH8gtwPxw3UHNVYTvYWHGGmJwXkkGZUoNKWXFp/op
	 AJmyWCq3PNd6Kr/pHKcNERxblfsGevIqZDwPjyk4z+TQYooN01lXmfnirvRFFgJSGrdwS
	 RpP5f4aVY23FAOar/LdTkg6j2UjY4JJaEQWMN9O+x3CjHSM7nz2o/60IkZml5ZicfFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+kaD69hIrPIrUZzwYMb7S/GNpGazAIKC5jeCdJ+GlfU=;
	b=p8YpBcUH3jGFZ4EUg/PSmrUD8r+L+7hGO4s5TODhK9LqDntstp3Saq0cPNDEOOcmEOOZ
	 Geh9B036rc8yMmrs4XNG2KMb/3pG5+Ry1MxV3Gd3OzzbkfDycw+DAgPniAX9vf/5q86Ix
	 LFRyS09C5iB6P192k72CbC/FA+UB47zB9VNue89iGwgLg4UWIVcXWeFqBvajh+pcPOSPe
	 Jxc34ShqrKb4YaeU4XU3RuHxQC/PoWrGSnARUKu2t4byHrKQgIjTmaG6+kqWrMpaSnWG5
	 aDLmJEk+7Rc6nUUbmXexe9NB2rKu/XIkU11nu3KY91fX2wUhtrnFddlr6IbCSN7YkjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElzkqytV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F8606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ElzkqytV
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4d198f1a591so2527095b6e.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793730445; cv=none;
        d=google.com; s=arc-20260327;
        b=BhhiZ4NPZJWMtq1cJIb0MnHDAbWOcfmx0Ya3k45N9wDYfSg7MJ1dj0q05Ehhpf0F5f
         KqsPX9rQg7McqX9O2DTJfuzZpatLS/SwRfoCtVKY2jsaG9R+6U7XKnVFXs1c9BSTsxTx
         0KDxIhXAcKUfQGE5e667Y+daEaigV3dpiE8aH57xrtgAopHLrw4wsXQkQq8jMM8LTp5Z
         OveKYCCAHEoFu8EHIHtNuw94tKGoe5HjxmLL3ovFDHECrBPNgFdsDuZVS4Aa9MTZi7XQ
         IRlCb9Aow5WD5oECsXJqqIvdoMV2AoBbQvQG+7jvW7wo42ao+lv5NfPznDisB9V9v3AE
         FEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kaD69hIrPIrUZzwYMb7S/GNpGazAIKC5jeCdJ+GlfU=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=pn/NexpZz3rBI5UFCotWxsvQJM2bGn0lYsNdBfs6Qtr/RRPhjksgTTEc1um4L+V87F
         AgqX1JUTw1Wz5hhCMYXtnM0XBUk/QDnGtTIfMoD4cmV6G8Zu0Hf2SPOTuM5vq4X/v8A9
         5L6wqQELZrasJ4h1g2/4WDrVbv4zR1DrgJD1VGJ6WysPZ2zPgUfV5Df6bCj1eV0h+NLI
         B6CRpY3cyoilH/A4hsadyzy2bjdXt1mKy19bm5ZGmm8zZ0LXSAAOQQ+LHceJLzFkXL8f
         pK761CFM0wtRxR+NSUs6yr0JbjTEorr0WXqdzSubbVi18yKQvNLQS//bwedLRmpw1aHX
         678Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730445; x=1794335245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+kaD69hIrPIrUZzwYMb7S/GNpGazAIKC5jeCdJ+GlfU=;
        b=ElzkqytVjTdZn8i1l3sQdtRQ4HS8t6/6l2VuM5RF/iVZzgHtwA1ChpSlsslZXqU3pz
         3CGne47DZclWzmeOXGXwmtMuCyZJEyWdQiRP2CNE3mzjrnrk2pikbh2L9NIFpEaYSTL7
         2mNH2+09QTWyBdiRZocrt83y0alGyF6rIhKw7b8R0JZmDnRtXB+EzQj2AFyfZ35utULG
         yuK4ZW0MII/zodD3fRmGL+riWH6dpObb6djlzcj2pCftj98HB+2Fs+negHCi4jF1Mq7o
         jxBZOYf5QJqll6hrt6QUNWOta/TUQSs6nxCvoozOwNaUVawZlM+FP071iGEt3jzOgdZS
         UpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730445; x=1794335245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kaD69hIrPIrUZzwYMb7S/GNpGazAIKC5jeCdJ+GlfU=;
        b=EBa9HTTfROH7rC6EdmJ1mfod+QtjkqiEB8gkRU8PVod145rDFYlryMwLzxQjOvaTHm
         uJqvHSy9atxDMpaFcq/R9+bLBxntdoYEz/1bnZt/J4kRKYQDPLj3mbn4+rx8RuIh7FUe
         XQX/rJXSxj9llSYUsLCvffBHc37fAM8saFYmnKMg2+ikofOv/ejkwu9TaKNU57jiI/8g
         mmZGjCE3ga4c4UE1Hn4SohFVpTxNhl24UtInlAaXZN/F+XsG1P6gd0DO4xTuATEucj9Q
         y9rtDN1zRgWQ7UKJ4bpN7V0CgvZ4Gxuk8w6Mo0D69lw/Ap6TfAKY21uYxuDCQZPQZbJK
         GRxA==
X-Gm-Message-State: APuU4Z+1QCq17I1lUkybuxExXWP6UhsSZRK9Y0PHO9ZCe1aQyxUo5YkM
	ZgCSPc6M1+C/lJgNBPfh1hTnasVBXo7bVkSYw9Adati4HBIl51yLCVGQELIfiMh57ALFoaA0CDU
	VAUTmGROBDXbqO98RfSoe3q3L4GKSoUD26w==
X-Gm-Gg: AYBFou2xhJLUlZ+kFV1B83RjLeDmtwYA/DCiWsUR4FB5IM9woKsQDd05xfW1BVy08ez
	uNWfVX33IgaUtyCziJaBAdYG3DACulvlyLmlM8UBZ7S1wiTye0mZUhWWLmm9aLdqihX7zpZmQTS
	v0pYTqpmrtJQTRc6IHN2wsUBWdX+T98SlylEWV/Q5gOytWs7ZQwaJThvUtwE5f0qfzJuAQ/REV6
	iXHURaLxdodROZfyc6m9aX4j2OMtxI53GZb5KqzzE1euSNLVqBETdIX6KpcQX4Y5KnMI3hYjuys
	hUfniUjuq/ymdOnl68V03T1fVZM3GsMNDqZvgO4PPsMhE75sWacUV91BbRQiY7wRe/GA2wo5JK3
	X/95UTh29b4wl8BBguZT9/AX2oinTJxInqmooFBhIi7De8ys8yaPbp/t5GqBonu4aCkV4kL58OC
	0053RHXXFOuVksPmm+lxnZa07dXFSOmLqESFpNi9oPlEi9OGnkZukVkyU=
X-Received: by 2002:a05:6808:13c7:b0:4fb:ac9b:b06c with SMTP id
 5614622812f47-5640d973571mr10476368b6e.1.1793730445079; Tue, 03 Nov 2026
 10:27:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com>
 <aukHlEd5udC1gLYZ@denethor> <CA+rGoLeSfwSQs6hOyGxjRhyCLqjWBMQ4yfXUYWiCz+MHqsgWAA@mail.gmail.com>
 <auoHYyR7WMfqosDq@denethor>
In-Reply-To: <auoHYyR7WMfqosDq@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 23:57:14 +0530
X-Gm-Features: AclHuK8EMp-Fbk_YjI0cVHTkUeAsb7R5j3Cq9uJO1gf1q-mQ2nlfkzS4ZbZPDWo
Message-ID: <CA+rGoLcoZcPO3nLbS41v_p0HPAw6r9C+ocnfU8BVKsuMd6axuw@mail.gmail.com>
Subject: Re: [GSoC Patch v7 4/8] repo: add path.hooks with absolute and
 relative suffixes
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:46=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/11/03 08:01AM, K Jayatheerth wrote:
> > On Tue, Nov 3, 2026 at 4:02=E2=80=AFAM Justin Tobler <jltobler@gmail.co=
m> wrote:
> > >
> > > So if a repository has `core.hooksPath` set to "/dev/null", the relat=
ive
> > > path output here would be something like "../../../../dev/null". I
> > > recognize that this matches the current behavior:
> > >
> > >   $ git -c core.hooksPath=3D/dev/null rev-parse --path-format=3Drelat=
ive --git-path hooks
> > >   ../../../../dev/null
> > >
> > > ...but I'm still not really convinced that is is a behavior we would
> > > want to carry over as it makes it harder to users to figure out when
> > > hooks are disabled.
> > >
> > > I would suggest we print the "/dev/null" here even when the relative
> > > path is requested and document the behavior.
> > >
> >
> > I am more inclined with you, and
> > I see how returning "/dev/null" for the relative key makes it
> > much easier for scripts to detect when hooks are disabled.
> >
> > One thing I wanted to check: in a follow-up series, Junio suggested
> > extracting a common helper library to share implementations between
> > `git rev-parse` and `git repo info`. If `git repo info` special-cases
> > "/dev/null" for `path.hooks.relative` while `rev-parse --git-path hooks=
`
> > continues to relative-format it, would that divergence be an issue for
> > sharing the underlying helper, or should we special-case it only in the
> > `path.hooks` getter?
>
> I don't really think that would be an issue. Regarding the follow-up
> series, I figure you could just not use a shared helper here if the
> behavior is diverged, or special case it some way.
>

Sure, then setting a case for /dev/null makes sense I suppose.
I can always as you mentioned make it a special case.

> -Justin

Thanks,
- K Jayatheerth
