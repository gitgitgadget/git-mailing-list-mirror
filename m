Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C019E96D
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763210349; cv=none; b=Nj3BxD8FlqR+nz6YguwoX4X+yl14jqQgQtNTFXlzU7Hj6uSXQTFTl/Vcfn2ODnDPGKffQqrBvI42t67UFCA7PIoRRgJKPtxc7Ga02ctjwSYjskoq8f1cfbv3cSZj9rrCTsEiQ41cvCRipnr3J1APU1wFGPWifnGAfISeeIjIRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763210349; c=relaxed/simple;
	bh=PlTdr5V/MMdxEyjIUxTSFHUwGCzlnH2YMVqZLP4K3kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMy8vKw0zSJT6RT4rTVmLqag6O+XA+hjzGIluQ875/I3HtWng4kg4HbA/960ZaXp9siLegT1nOZaQAGwyIUSD97cFTv2DBXhxImUwMOr8CDeT25H+UCqZjVz9f30PYYROo+FnHXSFy4G8Ts2KmCpol/79soxujxoo9HoRnjgBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+XxdM+Q; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+XxdM+Q"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so2551220d50.3
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763210345; x=1763815145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDadFYyHbeb8FMjtvvRQjFLfraXr30L3lNPAN4+gwmg=;
        b=E+XxdM+QgXNufznIsqYC+tus2ysf3cN2ts4AFidLgsy0WSdsXw3l9lmaCpNdq/QA1p
         aTyPZHuT9G2Erp10WrYIP6EaYwwXNP+IiZ/ljLYuvUBuh0F/iS4Mwz6GYpSEtAvLmpNq
         KD62nKmSASTqaH+OzYexneRRiM//pFvd3uyf8NqmKWq9JIZYbehQQFRoabNOj4UJkKWQ
         ON41KFS31q/RVxgg4a8MaSjJZNSCk69q2RASvXOBOLAOzjN6IC6Z+GGoyK+2zqcwEyMM
         sHyJWgXlGdzJcBlvo4X06k1cufcF9jT7jxEryMyYcC+fzoEcU6up5kz/mxrIBErPknbc
         acUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763210345; x=1763815145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDadFYyHbeb8FMjtvvRQjFLfraXr30L3lNPAN4+gwmg=;
        b=hGOJlsAKjOCdz/6XisKgbkii8N6uoU34BIUyHvap3Ut3Qx7ULOGxfQIPkCOAMP3YJF
         WdsC7uLEIkgkupdvg8YCfIglT9yyKKUuQMolTJ8Zupc0lTLs0lKR7ZkDoENmvpgr2Z5u
         uPetv39WiWOrftgVVkhKhYIByNaFwttSJJ227TwPTYc5udRCOWmrjdR0h5mlyJZKeuUZ
         o6s1KatieCptGJ42vB1L6yOTl874axcOldig2BKkCiRsdxMNa/Zk/7psViC5UsMIuMTF
         b0aJk89pPexLcoCXAh67orRQkTd1i4ZLf0vr68EqqV3VdUiNtVLuy4EHrPxPHAzdaagG
         i9Sw==
X-Gm-Message-State: AOJu0YyoXX1jCHIa1Ao4BP70QPYq1Tp/xx1Si5qgUafNVpeYtjYaJyb5
	C4NWSAEATV+qO2IP23ZDDNeQhZOnle2FnpcM5S4tgq7gjz9y1IRyoeRW0tQKq2V0HFeC8yj44lO
	tTw99js3xdOZr4l5Ara+Y454MYE9X8EU=
X-Gm-Gg: ASbGncvS+wpz9kworMtc+5/wsFYxJ0oPYXgs9YdHCys3Z9xOSONg1V8fSHnmPeW00kY
	3BqyRHffIpTwRbzCACZ6ZYtv4ijeZn0wEldrpLxx/tD+4n8s1c1YXaByJIjLehrH/XTTON4hoa4
	B6qIGnymnvRQlUuQwVWzyrWVWX1G4DLiqi9PP1auCC/jfskV1igOgC+vhnHNuTAFL39VjNIcKTq
	TkO2gMZBJlbIGu4fG8FrJ4qqgLEJgDqjQkUwJoFQ7aogh+LA2knMDp5GXlvrSJHiPjMzz1I
X-Google-Smtp-Source: AGHT+IFyvt+KBmpRrldrg5kCUaNYYNHSZwVZSiY0avnpkA/IySqbMNrtVQQPPj14wmyno5/IDBHKaKc6GtqtYYc882E=
X-Received: by 2002:a05:690e:4361:b0:63f:b2e8:11b0 with SMTP id
 956f58d0204a3-641e75f3ad9mr3721339d50.40.1763210345427; Sat, 15 Nov 2025
 04:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <04ab347ff80e16d49524246a8923cc86cc7355be.1763098804.git.worldhello.net@gmail.com>
 <xmqqzf8ogyhw.fsf@gitster.g>
In-Reply-To: <xmqqzf8ogyhw.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sat, 15 Nov 2025 20:38:53 +0800
X-Gm-Features: AWmQ_bn8byKArkj2J3NmOSxtXDj2oMbxMcHGrANpWmX974JmA41YK_wADfH_CRU
Message-ID: <CANYiYbEhGo2Z1Y+YaXfOs35+2nTOLYW4C=yXR65b4wGfe2nFgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: add UTF-8 width tests for CJK chars
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 4:17=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> [jc: the same question about the choice of Cc addresses applies]
>
> > This commit adds a new test suite (u-utf8-width.c) to test the UTF-8
> > width functions in Git, particularly focusing on multi-byte characters
> > from East Asian languages like Chinese, Japanese, and Korean that
> > typically require 2 display columns per character.
> >
> > The test suite includes:
> > - Tests for utf8_strnwidth with Chinese strings
> > - Tests for utf8_strwidth with Chinese strings
> > - Tests for Japanese and Korean characters
> > - Edge case tests with invalid UTF-8 sequences
> > - Proper test function naming following the Clar framework convention
> >
> > Also updated the build configuration in Makefile and meson.build to
> > include the new test suite in the build process.
>
> The usual way to compose a log message of this project is to
>
>  - Give an observation on how the current system works in the
>    present tense (so no need to say "Currently X is Y", or
>    "Previously X was Y" to describe the state before your change;
>    just "X is Y" is enough), and discuss what you perceive as a
>    problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to somebody editing the codebase to "make it so",
>    instead of saying "This commit does X".
>
> in this order.

Will document the purpose in commit message of next reroll.

> > +/*
> > + * Test edge cases with partial UTF-8 sequences
> > + */
>
> All tests before these make sense, but I am not sure if we want to
> hold utf8_strnwidth() to the requirement that it will tolerate "len"
> to end in the middle of a single character, as such a requirement by
> itself does not do application any good.

Will remove unnecessary test cases.
