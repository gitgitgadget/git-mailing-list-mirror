Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3234D3B5
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762128634; cv=none; b=awqCr/MLi5J3bLYYb9GLV9gTLilQJiOsy7kdkVuLwX7jtPlk3wSKGy6Gpj7WrOm0Jf7rgPoXFI9g/EfTO88GHRAcb0retow5B/brrzkUsA8ub6vMv+rrtt1YO3PybyKLGZSY+r1IseQr02M2u8uKi7jsLhyiO9sZlP1kq9Eg6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762128634; c=relaxed/simple;
	bh=QyY1RUheluCmJAYO043vx6TragUar6dDAlv6JTiaYqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gyn/MVqyhRQWbJAKThE8GyBaVrig88qHTLC/6RPATJfW94llCYXxRHKXyitPduLnsjsmhUbHIpwUQAt99Zi0o+YbG46wTvrFvFb0VUWpLEiAjXunkLH7N7UmE9bEzhPOw/fPGsSFui49qSmlhKJJJngsuU3Chbr/fkBdDRAka0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e893561f38so6972951cf.0
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 16:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762128631; x=1762733431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ajnuCIiJSaMFZ26n0WIl8gwkp0S0DgEt73FnZxiFLI=;
        b=CPJhp4iDdvtKl6QDhz4Pcfqjb4pL1tdBAidGYYnsByj6eziBv8cN8/Vt9zUH8u/TUx
         QT/hDLuH9fbswkN8/wu3ke/9d3UvJYfG07Bxa5nIFRAZTz92wxsU9y7jPZ3evdejMXKc
         erGDYx0vjwRKe2956sPbE/RljWo9f6KskHX4hk87g+bgVd2NICWhcSO12v2a/PbhO8gB
         D7R01tud8VyvaUnGsAmJvPs723MIY89LKiZMb2u4cjnI3gbiBs/IU0slJ0ZI7Ivi1om0
         vwWEzh0bP+wWSS74mX5ACSDiSpQ8TQqMGQ/bHpCZ5dqkzS7sfDtKxznOar3e9FvE2A+m
         z4aA==
X-Forwarded-Encrypted: i=1; AJvYcCWZVhK7vD/Nz712vu7CSzepizVxlWaKSz5+pUtFuz6+Q+Q/sRtTHZ5puv0uk2baq0ZVG1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeph3YHKrcGFcgyhc6/HU5mHUsYHFpryHCtOQRQT1wwgAcuAfM
	tsCYXKxN43XdqZxqszKQtkt2jE1/hecBAeBFm/LfZvtJDc5tNSzYXinoiCXFuee+deQnfSfB9zT
	3yxwH6pJTwtDEfzGmpoJyo7vaAd4ABZM=
X-Gm-Gg: ASbGncteHPRyBY2tGNfbRZ1wowflwU+G/oijfTzhFnhNust20mNCQOXZiIy5MZ9Im7C
	xtkQFD8kgzfbx9dHqo6g6OwzmiuWWUQwRiMtqpkFRUdeM/dV+sVF2FhPn219jmnRckbUylYrHvD
	GakGEsUv68BclXQF/oYwMVHQWJKX0+TEDL9JV7NEy678kQKLbVxxR53iFfL4nb7Oewvo3Oi1IeQ
	JunnNDBk6aEq1hBiBxJxKqcY/bzg8Q7qwmsTMM2YaL5rgCQDfUm2N71x6aw
X-Google-Smtp-Source: AGHT+IE0Em2CiPDoV3BdtJqP08kWvlbGbpUGQRLlyNqdw+suTTNSRWWmulEz6i1QD/U70jURlWaAVkM01ZVb3INbikY=
X-Received: by 2002:a05:622a:1649:b0:4ec:f9c2:c1ec with SMTP id
 d75a77b69052e-4ed30f7af4cmr94733131cf.9.1762128631566; Sun, 02 Nov 2025
 16:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
 <e8755a04-bd44-4ead-ba44-c603bffcc75e@gmail.com> <CALnO6CC=FFuMmBfJPzunUqDOBMBtmXm3i73y9M9LgRrhxzrs9g@mail.gmail.com>
In-Reply-To: <CALnO6CC=FFuMmBfJPzunUqDOBMBtmXm3i73y9M9LgRrhxzrs9g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 2 Nov 2025 19:10:20 -0500
X-Gm-Features: AWmQ_bmmGN6zTEE_DJu2DUfdK5jlQklUBkZbgmUqwQlB6gctb-XdDPPgIfKb8kU
Message-ID: <CAPig+cQLri3m9398R0JEf2fafKVkZBvOdxvpg=xPF2aZ6ayDvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] parseopt: values of pathname type can be prefixed
 with :(optional)
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Noah Pendleton <noah.pendleton@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Thranur Andul <thranur@gmail.com>, 
	Michael Grosser <grosser.michael@gmail.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 11:20=E2=80=AFAM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> On Tue, Sep 30, 2025 at 11:26=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> > On 28/09/2025 22:29, D. Ben Knoble wrote:
> > > +             is_optional =3D skip_prefix(value, ":(optional)", &valu=
e);
> > > +             if (!value)
> > > +                     is_optional =3D 0;
> >
> > I'm struggling to see how value can be NULL here as we return early if
> > it NULL before calling skip_prefix()
>
> Doesn't the "skip_prefix" above write into value? So I think if
> "value" is exactly the string ":(optional)", then after the call to
> skip_prefix it points at the null terminator.

I haven't particularly been following this topic, but your response
suggests that you're reading the code as if it says:

    if (!*value)
        is_optional =3D 0;

whereas, Philip is reading the code as written, which lacks the `*` derefer=
ence.
