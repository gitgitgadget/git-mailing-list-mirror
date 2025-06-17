Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB692E06C4
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161107; cv=none; b=Vj6U2+LrQIvA0Umzox3JqW8jYWwew9L7Ibg7vZzVHARwvDP8zMLSv0ZtsDK7Mjj7ArviROBjuoAAupfbGFeY6zCPpngHscj/xB7hwEnYzcBsWhhegEJ4AppjNRHSFs1Ttijr/Ufo3zLV/ACKi9oMqxDNAyKPhvqfGwqnL4zhXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161107; c=relaxed/simple;
	bh=AZBvVZEn+aiiRny6GzVeoiELSFDiRNSjj6HQfDVQ0Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu9ksN6rEdnZ0opLPKJUQfRYh/DLKMRvwBo4dkvD+9yP40WAaV3Xy1RBDSlCGEIixZzu1jUq5KaWH5zM4ejossJtRXJ+ogOq/U/73bMAmK/35XFmqW/ar5t+SuZyfR+9IKKQBi8/SErPZm7J4T/REMj7n7UB5b9dDCSdeby+7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czFD4bHQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czFD4bHQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23636167afeso54434755ad.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750161105; x=1750765905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie65hZBd2HkX9MpJx47w75xxNvjEihGPzkkyaE8VBhg=;
        b=czFD4bHQjpbVkIh3c+Dn2NQdYTBdEOHzYBwOrKxKdp+JDBealMaR9/ov4Pj6Ywz4OS
         IG60F7IygaUalDniGtuDQ3BvypoubXMhsdpt6CMD06firwNrMRn5H12y5rvpAM3i9Cli
         wZsU7RvN2edFu+IgPWupVmJmRyO+SJG5WBWrLEn6uaCLgUOJ4/CI5tupYJonb+L/USxo
         9fMnp4PxetoCZVEloYklum6GnnZtCK8WRREXVpV0kTDX+ACUvW7YuUhB82fNG/ksN/yF
         y73yAulmLBQdvQqlOnvYePbtszaBQAakwkQKKPwCTymRzurrR2a0P7xtarNtBYOvF9i7
         wFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161105; x=1750765905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie65hZBd2HkX9MpJx47w75xxNvjEihGPzkkyaE8VBhg=;
        b=ETkigm5A09ySvAP7lqahUIFJOuZaO7OswDXtUqnrOht7h/0ESvdi9ew3zvfgOqPeKt
         EzyNBH/uT8H0iljukzqpAgT/q1+mFLJEaIJJO0nix6aoEyprZq3VCXtbH3/WUIfVvFZB
         N5S19/OP4j719IyGIbe8doHdOoXEpnGBHJnJaF7cw2AxHwupzGIW/7pPDbaEDmbjoD1L
         Rfj5YyfrIOLWjQFipzn6j7M2lFfjTeGbN4KrgTu1UdedJeseaxgQu/ySEBv+f+Z2zAQi
         KO/HAyLZo5Izyt1FKO+n76GyciHPTBx8gPsCN40OWvkPut3IbZKA9blHtkNSdIohrzJ9
         Jd6g==
X-Gm-Message-State: AOJu0Yx9MzIt2YplrGuwAutgv+mKyYC5FVsMunBXI/oTFlbieh16Jqwq
	UbuBCRI9wL10cIiOCF5Ne6WYraenL0R1oWovYNvrw8BntnH7hLP0G7UItCbzytgVYuFV52Kmup0
	QXrdsnWDVnAY/WCPNl2NYYHjuZ2SK5aqT8tvLNXA=
X-Gm-Gg: ASbGncvFA2f06iRnF3Ir1EFK5Rv9s/eNXUWgcFVtLap5Ua0CQc/8ywZskTZiXuC86EG
	4AOADqaEdu8pRvOOqwTOXO7/VejEzMSFehJgGznkETkoaoRV52g8SPCqGQ6z7wcZvnAQZqn84h9
	m9sG86Ox5Wm4c4P/YYzyZ9AxCm+cBpwMYJjHfLRydRXtXk6VpfbK7wZCs=
X-Google-Smtp-Source: AGHT+IEYI7qjNM19/kFzmnAmXaQ8TXui1oTShCMQb3Tw3c+HomuxgLXjtvSy8sCnkb9gegvDUCbvL6/ECrp+A6IDRUk=
X-Received: by 2002:a17:90b:3909:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-313f1d96edamr20327618a91.25.1750161104907; Tue, 17 Jun 2025
 04:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614070536.17320-1-meetsoni3017@gmail.com> <xmqqsek16g6c.fsf@gitster.g>
In-Reply-To: <xmqqsek16g6c.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 17 Jun 2025 17:21:33 +0530
X-Gm-Features: AX0GCFsc1CBkJvi4U4R6FIOK4yAyNOewZ-gRx-6DlveHrglLUDZXRRtvkpg6K54
Message-ID: <CAPhwyn3N2O4OgPvEgec8C7Kvb1793s_KLq1u2y1tx6-msG+gFg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 05:15, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > This RFC is meant to start a broader discussion on:
> >
> >   - The desired default behavior of pattern matching in git refs list
> >
> >   - Which features from both git-show-ref and git-for-each-ref should be
> >     preserved, rethought, or dropped
> >
> >   - How much backward compatibility we want to offer, and through what
> >     interface (e.g., compatibility flags)
> >
> > Feedback and thoughts on these topics would be very welcome.
>
> In addition to these three points, 0th point perhaps is "Is it
> desirable to unify these two commands in the first place?"
>
> I only use "show-ref" when I care about a single ref in a script,
> expecting to be able to switch on its exit status.  Everything else
> I'd use for-each-ref.
>
> But then that particular unique advantage of show-ref over for-each-ref
> can be done with "rev-parse --verify".
>
> So, I'd rather not to see yet another command to do the same thing.
> Rather, is it insufficient to just use for-each-ref or rev-parse,
> let the sleeping show-ref alone, and be happy?

The broader motivation behind this effort (and the overarching GSoC project)
has been to reduce fragmentation in ref-related functionality by gradually
consolidating it under the git refs umbrella, aiming for consistency and
discoverability.

Your point about rev-parse --verify covering show-ref's main utility is well
taken. If that truly makes show-ref redundant, then perhaps it makes more sense
to focus consolidation efforts around for-each-ref instead.

One concern I have is that if we simply replicate for-each-ref under a new
name, we may still face the same question: what does this new command add that
the old one doesn't already handle?

I'd love to hear thoughts on what a modernized or simplified ref-listing
interface could look like. Are there features or changes worth exploring that
could justify the consolidation?

Thanks,
Meet
