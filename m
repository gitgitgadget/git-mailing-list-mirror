Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1934B25B090
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783835817; cv=pass; b=FLas/FtRtvwTDe+WkCmzuzXxX1/NzyimPKBYOGL/4obuiipvgbtvAYeZ1+HW2ohV8LjwbzUK4vS0o3lv1X29dbLjf8gMeDKR0lsAcu+2B8xbFOe0hfdV3vcqEiOlgJg/52NuOf+Vl/fvihtzgSUqEeezEYqEdabGbabMKK+yhws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783835817; c=relaxed/simple;
	bh=944OGSyGSSzejJ8iXpdeSL40HwLx9h7hBOtgImfkuYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPjLlAvfUrXEZ6/SLif00EqufI6jV56j33uVoGg1KW+YaGKukJGlkdM3icoofqSWE8XjdD9AwOFcMHv9kADZzv3+OKHgpQWxoPhlzfJOaESc3ztsDLkxjGbyU252n2L+OuLU4XixqIIQu8f2FG9/55w7Axski9cbc6+/aSSof8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJOLHpnb; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJOLHpnb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so5264018a12.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 22:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783835814; cv=none;
        d=google.com; s=arc-20260327;
        b=Ftc21DTeYK5IAGzz8Q7oG67MkEX0KNjleV/dNKtLTBkLKXAQG9lKsiagYnMLUY2f5+
         CLyqxHVpElUSYQ4e2pqzEiyXJkNzKAKkooTQ6dbmUpL/xswk33dpm1n210WGOsSxWlSp
         2dStPSUXSlD888k1iCqxt+ohVkkVAa0Gt6zynt9KjwYC0mtHhlL4EtUKn9cIfWdlRp0Y
         1mF4Omc581Y168Wze/FQijUMk6V6YjOJvM1JL+sGMdXMMcX8O1DFVp080wbfcX8zjxq1
         omYTtFrzsXA+8lcFIeF2tEG3NBu60imzZKkMWdOmQF+DAqgr6wgc6dZt/SIY4kx+1S0G
         xCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SII2hySGQy8wAjeuWzEe5Sv36FO/AZWaL0ckBrEXu1A=;
        fh=pks7SeV6havSBOYb9QFq91qaeoqWKp9lBTygpBFqwpk=;
        b=kT5pjsiNKh6q7wKquOYQTkis+w0ifeGGMmIZnVeUA3cHNHayArav0iz7sY5EILcMnN
         zW1wJqKJKyWZ3RkfxRt2g0VN4YRv3DmrCCTak6Y5p7gPiV7gxFuh3dwTStMtpJXkt351
         ZCkBiU0KT4lsW51GQZBiW2NZ4sLGECQ5yE8VuTkuZok9r9QnqS35zByHyOlx+AaijHFI
         6kprnDxdemGBd2Z4VVDXPjM1ztCSfEzGSMiqvk+ao6DE/xnGld4o4MD01GhdT6KEc7x3
         250MgFY2W8NPbaJqfw3V4P52BuwhiDK08qjAyK9tEX/E4AAlhK0qcxD9/5vI0EXz1dMj
         4hVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783835814; x=1784440614; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SII2hySGQy8wAjeuWzEe5Sv36FO/AZWaL0ckBrEXu1A=;
        b=BJOLHpnb/EVvzjfATMRgw7mDI325PzUXhRgnuO+uBDtm5yWKgitkcqd0Sfh5UNOtuk
         n9wvuwB153atMnbyJI4p6/o9OBPAv3cS/EgGxAt+QSk9ZP3OR7I9wkfDE6Q+zsQqh3FK
         epLJnfbXSx3+Q+T6Yjg9G7ukpZF/0DA71mwed10ewbyWNjKGLgdPzvCAyTatrpr6ovH5
         18Zw5VxuAJHJxIdtb4ACfC6Qp7EjPx+bwmSBHXf2m73Ue35o1hjsIJvex6jkLyLUvaZi
         0tEMFXXFiiAINpp9bDKlwEcRkfky7YSIHDeTXvmb2WgIm1dgSvKI5sLAORCMjquNzz3p
         aALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783835814; x=1784440614;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SII2hySGQy8wAjeuWzEe5Sv36FO/AZWaL0ckBrEXu1A=;
        b=Lz5Rl6iMo2Bibtso+3tDmg6fKbyarYlO+Lwqfu+fxxHT/pfFkcNVPYBfmoUcqGNqTL
         83sNghykb8zeQP3wV53Rt/muy3yDZ5nFQmDYXCsz6Lb0cWtgloUX4jYBG677QWumMcGM
         QSskiKmrJTFwqI+/WWRiQ/KKjFnMkgJhOzxaj7fDP127Ddht4/r+77M6mCSW15OFeINq
         hyNNs+Y6Ow7LcvQWP60cZQ6Kr+nVXVc7jS1+0elO1rqvo1ZVomVpCv3hslwiNFs4+/u9
         9I36KzgjTvq8c+LhmVCsxcxwijmz7DY6gSf224gA6YUiLheQS4OBEq5SC1Su1B5CSYfb
         9raA==
X-Forwarded-Encrypted: i=1; AHgh+RrgGQ97k5K7ugmBFH9DOvGBfN4Kq8A7yiOcqmSfQNVOGFO2DT/Ls0cf9Q3YQ+SbX5PLLrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaHO61aDYg1HPThJIIPs3iNn0cH/QicT1A3qcr/w/JZRZMaMu
	g9+y+iht71epVYX9cmZHyCv6RNBxmLkzbbvgYRsPFIOwygKEdcEBqtYyprTkXXGA6YpF0AWXQ/q
	/u/zJHFmcLQjxtAr6wy+BhEtRlVdVPPM=
X-Gm-Gg: AfdE7cm5tffLhFdsKl1cJbVPmZ9VF7VMEE29gFdBZ9w9l8wFFtmX70LTqGuqTvSfZGv
	FPa1m4m6H25qinO+ulJm77ctYoTCOmj3UwFp66KNI/QzZ89GiBqPSuwQTirQYlsxFek3KWBWv8J
	tinbdM9oMth7a8sO9EGKg0KenpDxrL8iez6HG7iLMoXdKcdF8/zl97tnts+F/MlsiSwyxijssfz
	UTIf63XWu/yBjZlGyQKmOvI2tZKLojIyJB+9u9uHsPffAuePcvr1K1N4dhjNgltodNGFr2jzklR
	0H6E4VE18I1tNqT2+L3QYEXwuFQzKs7DL3o+nXJ2xQl7QXCBVA0L/jLd23EMHhXANhcxJGMRSYv
	n/Jmv1xe1YW0xR5gGaSbm
X-Received: by 2002:a05:6402:268c:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-69c62a77bb3mr1895743a12.7.1783835814395; Sat, 11 Jul 2026
 22:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit> <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com> <alJpjTXfZmYQccwk@exploit>
In-Reply-To: <alJpjTXfZmYQccwk@exploit>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 12 Jul 2026 11:26:27 +0530
X-Gm-Features: AUfX_mwVTT8uBnXy-Ra73qRacGdX9t4jVn72aiv4uw6us1ByjnmDrmpHeHl6chg
Message-ID: <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
To: Mirko Faina <mroik@delayed.space>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 21:55, Mirko Faina <mroik@delayed.space> wrote:
>
> On Sat, Jul 11, 2026 at 05:41:58PM +0200, Pablo Sabater wrote:
> > I think that this solves an ambiguity so it should be the default option
> > and someone who doesn't want the indentation has to explicitly unset it
> > maybe with something like '--no-graph-indent'.
>
> The reason I prefer the current way of printing as the default is
> because the ambiguity arises only when each commit occupies exactly one
> line. In any other case we can clearly see the edges connecting the
> vertices. I'd rather have --oneline imply what would be --graph-indent
> instead of having to pass --no-graph-indent on any other format
> different from --oneline or --format=reference.

Tying graph-drawing logic to specific formatting flags could introduce
inconsistencies. For example, if a user relies on a custom format like
--format="%h %s", the output is functionally single-line and suffers
from the exact same ambiguity, but it would miss the fix.

Even in multi-line formats, relying on the absence of a '|' character to spot
unrelated commits requires active effort. Indentation provides an immediate
visual cue that breaks the vertical lineage, which is helpful regardless of the
commit message length.

I agree with Pablo: for users who strictly want the old behavior, an opt-out
flag keeps the graph logic decoupled from the formatting logic.

> > Apart from having an option to disable indentation.
> >
> > We could have the cascading to have a limit or make it zig-zag:
> >
> > instead of:
> >
> > A
> >   B
> >     C
> >       D
> >
> > We could do:
> >
> > A
> >   B
> > C
> >   D
> >
> > This would have its own edge cases like:
> >
> > A
> >   B
> > C <- if we zig-zag here C and D become ambiguous, currently we are
> > D    indenting only the last commits (visual roots) here we would have
> > D    to chose between continuing cascading or indenting the first of D.
> >
> > I'm not so sure if I like the zig-zag solution because we need to think again
> > if it causes an ambiguity, but I wanted to mention it.
> >
> > I think we need some more opinions about the design.
>
> I don't dislike the the current solution but I can see it degenerating
> if someone contributes a lot of one-patch series.
>
> Maybe you could indent commits that are both head and tail up to two
> levels and then on the third go back to the beginning of the line. That
> way you kind of have a zig-zag but without ambiguity. You'd only have to
> add a counter to keep track of the level of indentation.

Not sure about this. A zig-zag pattern visually mimics branching and
merging, which makes unrelated commits look like a complex merge topology.

I also have a feeling that this will end up recreating the exact ambiguity this
patch series is trying to fix.
