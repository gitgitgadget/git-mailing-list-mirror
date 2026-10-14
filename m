Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B54F4D04
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975446; cv=pass; b=R5FqVcmQhvLbHv98KF6X7ExOHkomoMOQ7y89hhU9HfCmxTRSHgiWdozzONw/3eKMec/6GE4Q+W0Qv5ObD3Mqq/mRLDi89C2KOjdQSgjWiYi/3elWFQ/Y8nCSU9iFPlC9VTIaHpDmTmNMoo6mZ02WEMS1IEPoNFmBsKeNZ6Aq4+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975446; c=relaxed/simple;
	bh=KMtupsUwE9zOiUS/C//yYW3F6507j3kzcywQ4pRzIZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQDpJQPQV0tX6XZNI8AkrwSvYFYy2r4C1O6aCWP5R2fU9+atE5iRlePZoDPNG6vv5nUwOZh6kQzqY3c7nfiXNPXdeIxiliLpAkyeSDf5F8/J6aFenQbg9inRaX1OrOTRpjdaKerWQ7ChJkzRpyCwsy/OBJA1rrAF1XxZ/DTTWDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfstJbeA; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfstJbeA"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f55a53898cso2063164b6e.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791975444; cv=none;
        d=google.com; s=arc-20260327;
        b=KrJTW88J6m0hPs8GRJ3U1xROs75SCtXzoX4iWPFIp0uj08f3qms0qTNGdbjAeGTxNW
         QkJgrroA4nJJch9fxnlqAUx3LwcQgD2/0eG5Nr9AtNOeHn4L+R3v6EYGktu2xmMkvwgI
         g1MDoytXiq2292lyT+fxHYVlsM8pAd2A701KInt86whrxc/uEeP+IwWe0qZZe5SsDSDq
         lxyqHtovTO7Lovnzz9BdzvaZdlnd0iZ2MKXUCIDQ6+FkpMs+Hj7ygErOPyh59JDvY7Ix
         LvNrP2XCJpN22tgMWOUsZmeErLc+43Jo99p0YlVI9pnS+ZIZJF1thCjEAdrxgW/6XYch
         WafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TE9tHam85DdempdVxQ/Z7+SGoqnlCDupr29BpM9n+rg=;
        fh=xct+iGG4b1LwuXoxK5VB4+y71YE7hTgcJFCPJmdmGL8=;
        b=CDLOIjjr8iH+Mfmz2lBviBU6p8t65+RhEIlX83+Wg0UXfXxeOvZhC33gDnu0vDZHr+
         IdJ2wD6NtSCn3EuEg4vMmYPMs2IhvWpZb5FO8d5S1At+DuRw3utU0RihgtZK6IfCw0TA
         6sEh7LqyueaHYbOITTWMbZB92Q5BbXliaSTUTEFKn0mITtOpF6KEs17OqMPwNn98oZkt
         YIuVt5v8wqJ8MwsTNSaYjBppEE+/rE4rDil35pRo+qd9zGHdKYRlC+RnkFx6sy/jygyN
         9uEDWTxAArrfLU8YuVNSzYZD9YmbQCQppWb/TA65wBRrqdLpjHgnidZ/+O7vZj5ZI8yW
         o8yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975444; x=1792580244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TE9tHam85DdempdVxQ/Z7+SGoqnlCDupr29BpM9n+rg=;
        b=kfstJbeABoo9ubzkGChG23mQt1Ww8jgv42HeCMDCg7JlU6V8xxo4h64q8nL3nW/A4Q
         WQkxK4aTSbKdqyuuuk1JU4k8aF7iuA/eVGaCG92mNVa81X+VVeB99peyJ7N0GgVba3OP
         NMqabEQQizPBTl9JNa4DiG2991RYCVCGI788I0UcVj7tj1rF+2L4cAcfWFXzmDawsu40
         /xQWluyrbGRLBwiW4wT4U9PDiRUl9eqnft+FXclfWbp7wXyvNhgpt0/xBvQ7AkbU2Mac
         ghLpMhOADL2+TtPKl2OfR95vl85lgJqAbLTlpLwb9F5p9YDRDWGcTVIDt+VwLWGtuXiI
         kEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975444; x=1792580244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TE9tHam85DdempdVxQ/Z7+SGoqnlCDupr29BpM9n+rg=;
        b=mOfmDnmc7iSnvBd5GoSIqEKmyOwnVS6WxSeZpFndW0CDrQrWHQXax1F1kgQuBgLkwl
         wCFR0B+vESt2AXfmavhrqCy5JwPJ895OEC1fltiP15wucEP8IVVC7G/NwJA6YVMnn6TP
         HuPTXchEFvk6orZKKOJKqE2un3StGcDm/uHFkQXuIqZTpLuTlaMLlbFWLa3zMKOLJiLK
         HaiFlWEq15FIrAmLuMBSxNSWOJQ6EhY8aHvSyPLY7Y3u7CD2P89JXbcR9bNYz0MYbtlb
         6TUTDwZbYb8XxXleVeYXNUk2ejfLOoqInNAL8ZbBTwhsx/LZHYySN/0fTYF5gHAWEM0n
         Hvtw==
X-Gm-Message-State: AFq9FYLpuBH7T0SOclNCJdhu0XbMXd52HmDG70hjX2kEUAGW3yxbWcau
	2BR/TrLoHClXtFn6yDSNmhl7ZlywXRneaV/uBMOjRj8CZt83VX4nLMeKvlr5RSvrT3kV2PPGfEF
	jKd1E1alLDP0s0VMSFyL0IldSmYsEbeI=
X-Gm-Gg: AYBFou2j11IfMrpNI+uvZKzkySMiT6Phwlp3sLo4Sn8MwGvhTtDxhI/mdb3x03bbMso
	nd9q8KyhJbwCWBnCTMIf3h/B78hoSZ/q74GiXl8kLaW9o9vBUviA8P/tJlkhxAwKwHlMlCQ+p63
	6S0YSup59JWZfHpk/hKnfhQ+jDf8bdxKGpvEG22bC4Ddczf5cOBz12VijQh/m4/baQHPmkswCav
	Jj3M+CWNFBmPBsdBVTCmhvxWL4BVGThoqQf8pQS2ZSIIwfWupiqefMJNEwhUERitqyiIp1jGnnt
	1tFkI4BF+jHTNupJJUViG1oBwScERwKmIjfU0ttJ/ZdClvMVfaShi7zFKZ26E7q2wkonDx97dkt
	oVT+7q634pL9M1uJDy3asd09ZpN13P6jndNI5pWyBlRicbxdAYTa4b5R/mWFxeUKJBzbl+SIfzk
	pEXjuyS7R63TZO65STde6Js4HrYLqepinyol7aYe1VTYEnqoLkjw1UFcw=
X-Received: by 2002:a05:6808:f92:b0:4d6:9222:9a19 with SMTP id
 5614622812f47-50c5b27c094mr12478869b6e.52.1791975443786; Wed, 14 Oct 2026
 03:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014081209.61966-1-okhuomonajayi54@gmail.com> <CAPSxiM8xEA5zAUb_Wd0M0=PGD44XeS7=NX0vsdMcyid8-EOV+g@mail.gmail.com>
In-Reply-To: <CAPSxiM8xEA5zAUb_Wd0M0=PGD44XeS7=NX0vsdMcyid8-EOV+g@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 14 Oct 2026 11:57:11 +0100
X-Gm-Features: AclHuK-EExWykppeBiwbSqf-jfSy6-vlAPDRFG8VbpI0YGVOCbJ34Xcsk1kh7TU
Message-ID: <CAFpMFfBVSaGSoFfw9pfOcDWMKnLwnpMSyT51Nu7f-ZXE2NyxZA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] diffcore-break: remove USE_THE_REPOSITORY_VARIABLE
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:25=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:

> > Without this, new use of the_repository in this file would fail to
> > compile.
> I do not understand this statement.


Thanks for the review.
I meant that since the USE_THE_REPOSITORY_VARIABLE has been removed, any
future use of  the_repository without adding the
USE_THE_REPOSITORY_VARIABLE macro would fail to compile.
I see that my statement above is not clear, I would modify the
wordings and send in a v2.
