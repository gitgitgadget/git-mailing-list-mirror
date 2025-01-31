Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF131F2389
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352567; cv=none; b=luo1GFlUpJ2hf6JIidYjMCQi9C+9z/MWlNZuoQjdp9eoR/LJLnveyYHIVPrsedO9KLTCFezIs1xnRFL0F42M320IkVQ1saw2SeLvbfwqAf3FRIlaKSTJJ0TRpjgoTlET8HS1ApqZcnozXSasNBlzWux20aKSjPw8llwoPddRvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352567; c=relaxed/simple;
	bh=oe+9jChVWRn39AVQAuqJwBVy/Qo1b8pdtI2jzoFMHjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LboZLuaxx3jT7eV5sJPegUqaYGsTdHbj5w6QmskacwhO0M6X2/iek5nlnx0SKIrOZu6EAWN/OOOcUKj2BgxZ72LVCGynSkr7aKAmolJjq/dSP7c0ipq/AGzCoM6lRuFx5pOXJk6en2mI0cIZ//+jioZQTInNzBaRN9cpQVHy4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFiTFU2g; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFiTFU2g"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c4557fce0so574249241.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738352565; x=1738957365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPFu/icGom0rJnZTRiJ7n0B4cOmDriRLov5miIe4MfA=;
        b=fFiTFU2gWD5vUjxzZbvtN4XzR2wmisESJ+htL1nYqyBtVF2YIDQWN3Q9FvbEIVZEld
         34ZSn2RKi/pJ6J8jbcW9PBbhMoQLM+kR1aN+tHmc1iumslOX0PELeo+SQJtrALM5zkCS
         L/mE2ffcqn1V0HHABJhnjeP9iyDNGN4ejdgAJ8FAFV6YJPYZN0UAlqVaX2zMfTHGq8XZ
         hAw7wsdJtBEQpB/w35Fy0IhRZDU/OrBlC6YJF6/lN1OYsKexziT1g3z20mCIJuDnIHK6
         mkt1NM2OK7rFXmxsn+RVK/Nj8lghBj+w19Aq1w5uqJvA6wPADr+YI2E/qqH4CKKDV4xD
         +C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352565; x=1738957365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPFu/icGom0rJnZTRiJ7n0B4cOmDriRLov5miIe4MfA=;
        b=gtp/Xp+suK02NWes1Mg7UHBJNaDYhtUFnfjFgZppquuYZuM8zkmwO9kQSJa37E9WcI
         wFZ/XvBp5thfj9M6ESubE4fPxoyRBYImV5lCdWZNMXAttqneOPZQeiJRlcvsn5rz7pWC
         JNuMvxOZCqS0e4Mwlv1fIlVbSgwVkCVFELIzVtkSc8h5/nm0b7RsOd7MLMuGDJ+xqThq
         WSqKh6WetBlUbr4ZvWYk+HE3wGgUCwXlue3paMZ3Xl6RfCu4GvoAbb+9fI0LlDc0veAy
         YWcIrrlDe7tE4xIjty381rDX8DlKG5+HqipN7PjKBdgw0tJYP6jdA6yKjwmhbJPHz6D9
         sooQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrrsna0LFVyOosyO91ClcE1w0ZvsTQAG7NobkHOa9l45lFxa2amrWDMgKFuu8I6R7mQWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutCaXnKewI5zZC+3F5+0vw5EOxRIQb944nA6Oj7uR1K/378WO
	KLx5EoUTYTv6ABFxbZObR1zQpGpZU5tkI6Ke/RpY1dKDpY0G2iuXIqfj4IQAuf3tcBu1Zo0C7A9
	Hzi7rTAtR501XMp2JBKGPLVeDrMgOGDoKI4c=
X-Gm-Gg: ASbGncv7LDqfL6PtsPdxLzccXeLyO5U24Cjsvv/lBesskV/or0wvO5Db9QUUBb0Zc8h
	WhtPV87B+i0BaYlgyw0RhZD5IBRR38mT51xyD068cEVHvYTzmZl95JwS9firpDdQKisajLyEu
X-Google-Smtp-Source: AGHT+IGkJY5Aq8WC952NiWLrljoccz8qAMT11ElSJf1S+/XrZ/ugXMZyQP5APYgix+PuTspXz96iAmiT/wZvsL023iw=
X-Received: by 2002:a05:6102:149f:b0:4b1:ed1:56ac with SMTP id
 ada2fe7eead31-4b9a4f5851amr12816413137.12.1738352564979; Fri, 31 Jan 2025
 11:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com> <xmqqed0sxdiz.fsf@gitster.g>
 <CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
 <xmqq5xm0wa5l.fsf@gitster.g> <CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
 <xmqqzfj77xd7.fsf@gitster.g>
In-Reply-To: <xmqqzfj77xd7.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 1 Feb 2025 01:12:34 +0530
X-Gm-Features: AWEUYZkBMiiSvWJzxiX0iGu3ZR3FA5A652Vgy33pi4o5LWQlLMZKYmTG0xqElKs
Message-ID: <CAPSxiM9xO+GPNrScQS0C02qNJM8M+hOpEfkr0Vp1Tz3i_jkCjA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > By the way, if we put the OS information in the "agent" capability,
> > how do we separate it from the existing "package/version" content and
> > make it easy to parse?
>
> Do NOT parse, period.
>
> If three "things" that talk the Git protocol on the other end of the
> connection gives "Linux git/2.48.0", and "macOS libgit2/1.9.0", and
> "Windows git/2.47.1" as their (enhanced) "agent" strings, there is
> no "ah, this one is 1.9.0 which way older than 2.47.1 so it must be
> missing features X and Y" the users of the information are allowed
> to infer.
Hi Junio,

Do you have any concerns "git/2.47.1 Windows" instead of
"Windows git/2.47.1" ?

Thank you.
>
> Just take it as a single opaque string, and group identical ones.
>
> In the above scenario, we found three different kinds now.  Maybe
> we'll accumulate the counts and notice that there are N times as
> many connections whose agent string begins with "Windows" as "Linux"
> and "macOS" combined or something.  That would be an offline
> analysis, and forcing users to do the stats offline would reduce the
> temptation to use it for purposes other than its intended one.
>
> You may find "ImNotTellingYou" and may wonder what OS the user is
> really using, but they do not want to tell you, so you honor their
> wish.
>
> > I don't see a good solution because
> > GIT_USER_AGENT could be used, and the config option to not show the OS
> > name could be used too.
>
> That is a good privacy measure.
>
> > Also we don't know what could be in the "version" part. The doc says
> > that the agent part is typically of the form "package/version" but
> > doesn't require it.
>
> Exactly.  I would think it is a feature, and the way to treat the
> string in line with the philosophy behind that feature is to take it
> as a single opaque thing.
>
>
