Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735FA23C8AA
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878855; cv=none; b=g7ijga8XsceHMHIXyYGykXfMwP3gv5l/RDtQOyT1TG4BHvUQMG/MPS+nXgwYwtB6d4yEEnSkNHCOmnqBcs/A6dDVXQ2P6SXNRmIWf8eOtxndKdCQQCN/b4Id3VRKfpkY2mmr/vwjD0lxfiAEagZOr3CzoQJ6fVNLMDyCZf/w3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878855; c=relaxed/simple;
	bh=NMFgFUKCGmvxPELcFeI6BiVDKf88L/Xh5USFcyueYhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIy5KAVE2npumZDvNoPUMsYQ5uFW35iixazL6gHb2VbQZu8YTM4DoIti9LBrO6NyceiH82/BAIuL6lKwChuzhy6+MOJQWSPVCsuwOHY3iPlF4F4Ef1mHKfuwhdQJ2CJuMUKco4SalrDhFHew1+t8854YsAcWB5/x1x+M78j1g/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnwQMbd1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnwQMbd1"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbae92be71so144481466b.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878852; x=1740483652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHSRrGfuTkldyKFb1aYgvAf2QsornCpCyqoa/4+PMyM=;
        b=UnwQMbd1MzhSnf73SDR2DxyoJsxwNWO/DVPbG2aHVOzpNths9Pj/WcRZ+0KwrgiZEg
         Mk4ZMS0OjFmsq3ESvNqcYVjOIMpQwdpFXg9zGoAvxZfFXWfrkcGPmcXRiEXnE4fQ8Qm2
         8xbpbvrX0D6+taNgXYdc7sM0N/2/xCX1p0QPgkZeDFMe/yjYN620nvlPMpjvZC7lN5sR
         /n7g8LOS3yZ49gG7Btd9gCX+hKlEm4v0DWUEcwyGAG4YoFVU/an/tcoT7Oue8+EGy9yL
         Q/DdeGu77WFSxzLnKy8xE8j4nUCZMbgYjPQ5Yrrhedfhn8zufuiNT663/xRw1BJ2QdHw
         /IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878852; x=1740483652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHSRrGfuTkldyKFb1aYgvAf2QsornCpCyqoa/4+PMyM=;
        b=D1L6GeFCk3JfLYBA5HgDaYvThS6/DknF1h72DsEjvlax8e8j71QK8zRyIRIUk8WJQ8
         dDLOqInjSKq1i+wCPTXq4++EIlp/snb6AkBXf5a5tSFV9vT5DAwtb6bwSax4fMF2k+9Z
         j+ZuZtQm3TWeAjVjfa8oorrqanyCs3NSZ0+eboT5dc24NMhBQPsO4ptrQFQOlytkBzK+
         uAERTQw7Cv7/ILtp/LRiVzE4am8tvjxvNUBmQhOGXDk9UaJ+/SataTmTUBYYM4OFWCEC
         A+OL9AuLO/78jdNOMXMgZW6B+NGHFCG9s2z8FON/SJysUOmggr3XPZYRFJUHUGlGzmf8
         gO/w==
X-Gm-Message-State: AOJu0YxyLaSfw1ZYoaOFWHY4gY9f4PC/Qon2Zn8vebUEvfAZmHZ3yhGP
	j9fS8b+j63fTRDOUuMOR+AiN7CDUICBk8DO/M3oL4ex60xqjHXDdCqRZ6uSowweWptTpd0iueBo
	cgMZXUSgWCxC4xqM3L4fP6qffJHA=
X-Gm-Gg: ASbGnctgz0ohBR/Jt0VW0z+K5MEAGx4yeTQ4W4T9S9XutdT0+xgnTbVuFGkkweRCtzq
	53eOFFRdAloBe2aHFUMecIayNyz8+rg339JDI2p77uUSVaEaMba3wbZPxA25opAqf8k4kLEaVUW
	4=
X-Google-Smtp-Source: AGHT+IGfquENySF50S+eIKnl7ilF+DEpzS/GWhZLUeaHwuS90Y8RIsnoTCGZTGmU88Gz8K/YtY/Vk0bPTd2oNE2kndw=
X-Received: by 2002:a05:6402:268a:b0:5de:594d:e9aa with SMTP id
 4fb4d7f45d1cf-5e03602e4a5mr36107336a12.8.1739878851515; Tue, 18 Feb 2025
 03:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com> <xmqq4j1kq7qz.fsf@gitster.g>
In-Reply-To: <xmqq4j1kq7qz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:40:37 +0100
X-Gm-Features: AWEUYZlxHjwhd6IXHhaD2TxmdlCrINgncQ0Ohqo2cJUFWHrrf4os74VTdu__UNs
Message-ID: <CAP8UFD1_Eb-_F=t1SSizkbk-=izkiL61PFfGSB_F9Aatyq4TYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Introduce a "promisor-remote" capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 10:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> >   - Patches 1/6 and 2/6 are new in this series. They come from the
> >     patch series Usman Akinyemi is working on
> >     (https://lore.kernel.org/git/20250124122217.250925-1-usmanakinyemi2=
02@gmail.com/).
> >     We need a similar redact_non_printables() function as the one he
> >     has been working on in his patch series, so it's just simpler to
> >     reuse his patches related to this function, and to build on top of
> >     them.
>
> Two topics in flight, neither of which hit 'next', sharing a handful
> of patches is cumbersome to keep track of.  Typically our strategy
> dealing with such a situation has been for these topics to halt and
> have the authors work together to help the common part solidify a
> bit better before continuing.  Otherwise, every time any one of the
> topics that share the same early parts of the series needs to change
> them even a bit, it would result in a huge rebase chaos, and worse
> yet, even if the two (or more) topics share the need for these two
> early parts, they may have different dependency requirements (e.g.
> this may be OK with these two early patches directly applied on
> 'maint', while the other topic may need to have these two early
> patches on 'master').
>
> I think [3/6] falls into the same category as [1/6] and [2/6], that
> is, to lay foundation of the remainder?

Yeah, but patches 1/6, 2/6 and 3/6 are removed in the next version,
thanks to a comment by Patrick...

> >   - In patch 4/6, the commit message has been improved:
> >   - In patch 4/6, there are also some code changes:
> >   - In patch 4/6, there is also a small change in the tests.
>
> All good changes.
>
> Will queue, but we should find a better way to manage the "an
> earlier part is shared across multiple topics" situation.

... so no problem anymore with this earlier part.

Thanks!
