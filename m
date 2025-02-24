Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CC262D37
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418051; cv=none; b=mBxTckPm5xQBjNDwDTDcnwdzKFlBfN37K6FUZ2ue8hayw3kqA2qJ7RXkl5Hu33q8UcFvXw4jfeB5cIXB/udBFxBRU1NpU/5xoszA3alU6iZFHlKScYITrFxg7EdBSakORTn36R6TZzkfngoH4ZlQH+NuSBB03K0FNxo++k+hfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418051; c=relaxed/simple;
	bh=idXsI828nDVYLuatkvB63NYvsnZwRSy+ar8QYZ2tn5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqxkpVCuete0+d9mlCTxLyp/xwgrWbnWWJkMEfAYFnKeXt4g8/RPGEJkjC6SFnltEa8ybZzskkWtLBznfqDizXf17quHo9jNgZHBmLI4wUW8nhLckCukQ4/nthajCDScuz1UT8V0gaCi/FIPImBZQPuZRaE/YYfaBCYufjlApjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkEWHKkJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkEWHKkJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so988608466b.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740418048; x=1741022848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmq/5k7aBGu1nGAJA7eGZqPkDMp0IkA3DuILaDIcsnE=;
        b=VkEWHKkJvt87ZI7V8wM70ljjevokccbfljRO6MniQzm4BtfwUI0/ie2Zw3KYT0SJ8B
         b3IJitWlI96MLMKWFOPsvRzU4A5yR+J00EhB82A7LcUOEx03NFzjdugy0g+ABN99urCi
         W9+Cu+HLAa7vuLriFHMeUnjDq3+4oc/7yL6SeIumDmLKDigiPk6xI+vukGT/0TnFwF6/
         8/RqqcD9/vtwAlda7+SfgqPnvIC3ccHmcdVIvFBab9/zBQsIxzFv/qCcjTyCG+6vHY+Y
         HTrsluiZFuu8N0OZAYTv6F9m53Cq6DIQ4MoHxlQNjr3rSJbADF/v0GEycUBPfC3uKz5F
         czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418048; x=1741022848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmq/5k7aBGu1nGAJA7eGZqPkDMp0IkA3DuILaDIcsnE=;
        b=dqwgRAMrNA42ImxFyBYEqRW8qPB/Z9UcAMyIgmuR3sskKJa95NVuy5GU8w9Z1psQaE
         ZGOp3dUDVX6SWLV+vP7GulF0p7EOl9GGqKHReCh7Nu2uDZLtfK+TGBMdBX2mWjiKENFI
         sTzwm9ZHB2K5wsPk6kHqb6IVEXye4leTFxa1uUUUyN1Rko/tksuyC0DysYLfJIxDuAhP
         J1bBnFLh7nNfyA1JTAr++62rJDTt/5mSbYqGNfwhmYxQVBrcNl80J7dJ4vpa7qtVdkBW
         P2HYeHYTQsR7/2o2wTA6Sl34rVJ5VyLKh3UuuskzqFSxdU6i0xHv42StOgKNvQ0RE1oE
         50AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzuM/5PAShUDbhKErDCNxfT8UiKav8D0bHukH1HlDQ+VAspdHTERWK3DJGsj0cwGnluw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/ccuq6iPzIG4SlSEYoVeytSlLPRgT7Ac7ksCFNANvXCpziE3
	uN9c4ZxZOJH1N3ujNq1qCHvQIrti/LPoOpsfqV5Op2ulS6CBULIYC0la82hpy9FQeiSNz3ZJrkV
	MKCWZ2Sp3rhB+4rKimOWSqWEg3Fc=
X-Gm-Gg: ASbGnctywEGgAT11j0TngwjpID1CoIymEXSGnZ0dIHJw8k7Jl98+5kFoyZmq4W9vpPo
	jjfu47eHCLt3bSm4YnXjo31JDbV2l9LZWfCDLranjJn1sLXyOKdWALytlSajmQ1bmyXGzwmKM1c
	tXF73BHXqeUIeXONj8F2XZri4WMACAjvkmQBxzPv8=
X-Google-Smtp-Source: AGHT+IGbI7mE490Qk0R2KvDBmY31xbk4jhsEXxOUN9GhAFgDuvGHzZP0xStRoWtimYvA9y7Gw1uBkggTKRf5RGUQ5VQ=
X-Received: by 2002:a17:907:9989:b0:ab7:d66f:c872 with SMTP id
 a640c23a62f3a-abc0b037870mr1205731966b.19.1740418047815; Mon, 24 Feb 2025
 09:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
 <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
 <xmqqikp4ctoh.fsf@gitster.g> <xmqqa5agcbx6.fsf@gitster.g> <CAP8UFD3XVgJCc2Qa3wWZA54fg38jcpyiDtQOPNc8UQT9uL3vWg@mail.gmail.com>
 <xmqqcyfbb35h.fsf@gitster.g> <CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
In-Reply-To: <CAP8UFD3EpwK3edfBfqRWmcncRFG--Q-yHR=K1wZnDHJs56ZipA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Feb 2025 12:27:15 -0500
X-Gm-Features: AWEUYZkX347l48DT62j7-kFjftWffSbHrwca-_vd2TGPC9d3pNCzB77G46yJSXI
Message-ID: <CALnO6CCoD8iRENU+OkCAkKGhiHPVtACZMojAsJbo8=cDYLC_eQ@mail.gmail.com>
Subject: Re: first bisection step takes quite a while
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:25=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Feb 21, 2025 at 6:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > Yeah, it seems to me that in practice this is a bit like bisecting on
> > > the first parents first. It would be nice if we had added an option t=
o
> > > bisect on the first parents first, so that we could compare your
> > > improvement and that option.
> >
> > Unless you are talking about something entirely different, I am
> > afraid you are confused.  We added first-parent bisection in mid
> > 2020.
>
> Yeah, I know that. But I don't think there is a mode which performs
> first-parent bisection first and then continues bisecting normally (so
> not only on the first parents). That's why I called it an option that
> does "first parents first" and not just "first parent".

This was also how I read your original reply, and I think it would be
a nice addition. It automates something I've done a few times when
bisecting in large repos where the good reference is far away in terms
of commits, and where automated build+test (bisect run) can be slow.

Essentially
1. bisect with --first-parent to find a bad merge M
2. bisect between M^1 and M^@ (maybe this is the set M^-2, if I'm
reading "git help revisions" correctly?)

with the idea that (1) is fast but coarse (but also helps skip
unrelated, potentially bad commits in the merge parents) and (2) is
fine-grained but still fast because the set of commits is hopefully
small.

(Most readers know the previous justification, I expect, but I figured
I would spell it out.)

> Thanks for working on this.

Seconded!

--=20
D. Ben Knoble
