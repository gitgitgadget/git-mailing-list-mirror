Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82782E718B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447953; cv=pass; b=fBmpX4iflWSBrYGyH8PMZ9RWc5DLle400yO1u+nKP4emZdsHWyRAjS0FOgTCV4+2ntHUKEQ8Tl+5goUFE5JhOsH9lNCfauPi7hYJFRyowg6pW7XoeMz8I2UkNAtWUIkwnFY60iALMXuR8ZpovPQzbDcDcZdgyNj3RLVlgmqwdyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447953; c=relaxed/simple;
	bh=MpCCPKUP/PSVVOzoUHsOPAGSwv+Rdw/mEnVII8EGP5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2kBwK78TB8GdcuLZjnLcxsxzI7yaUifmSu5/rjqADpxLgvVwU1NnTmS5L/aKDxvQ33Y4XXXLLzDLBcvblwQTVun9e6kG4juMr670h//AJsnlYScB8owhQs1CDeFLoHjBXScXIfDMwhCq7i/Yf5efGBXszpCDnX8KonTQesejJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ozxSOeCP; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozxSOeCP"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80fe8f03098so38888077b3.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 11:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783447951; cv=none;
        d=google.com; s=arc-20260327;
        b=MKzgk+RHjzezh6kM0qeA141bibXUN2I7pegnUy6ksWczBhbX/Wft7Prc6Jc+yCbVBu
         2TdLplvlj3A6XewT6I+UgLgVKMDOo+oWzkfMUQjJlWxdTsbsJpwn5kTCQBn6cPX9XLwk
         7dTWpRP7WoNjeIGHa7VCRJ2D+iQRx5ggwkU1aY9EikOIueXJvZBxDPDm1Ss5m6rBZaei
         r2/UfTKwjqBwsc/aA4XMh/n7HiWCM0ZqAotcNvV4iJzRXWtOcdL88F+R0Mc8cC8N5DZ/
         fv/cDPSjIWYRc7PQla09XS5Gsjv3iHDbux8GN9XBMReklt8mhguqfbJNN3IotCBDcucn
         OjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpCCPKUP/PSVVOzoUHsOPAGSwv+Rdw/mEnVII8EGP5k=;
        fh=+I8s+MZHwI6Yo8dJxePwmdP5S7TliGe1VFIIUl2NI2E=;
        b=ZPPRsTeyoprK3fXD0B/4weMQhpmdtBoaWrmMQO4aTUjWpENB6IUN7KrPBhX9dKrogi
         qTi8GqlCckxYTZ6fYg4WKKLl/imQciQD7g8HlNT/kPYoRqvjEPN7ToeWwa4cf2Ogspn4
         ++5BXiPdaVVpA9fFm79QFAzEagot6Oi+ojS8z3VXdtnYhCnvcGUnM85LY0JNJ9zcm2yS
         YlSlRQYbZNXuQBI35jGxtjABMMGhddT6ap72GV9iXldEug9oY5GN1gZqb3ItHMmhjhe9
         ZVwpDPHfy0dhgsmeQjiv8wOGwUDVqwnZBawgNXBcNjrvdt+yeyK6TAjJu1If8MfD9o4b
         VDNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447951; x=1784052751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpCCPKUP/PSVVOzoUHsOPAGSwv+Rdw/mEnVII8EGP5k=;
        b=ozxSOeCPnPO/hTbVgThXa5dqq+fMoo+ZeN+TYrMeG9IvDml7b8vAwv38cc1gWz9LI3
         TFCvvvaCTwZhLHNXuyHrTpKH4/Rz8mxJlLy07I6FrTmc3xd3y9F7I4hLAlEADxqKyTW6
         A/MCQYxca48gWPNtLzOw1x1L6V3JX7oG1/JvUgFe3QTg21G79KDDVEOYleTpemt9p4VS
         Pltqxj8Ve8gPeMu9vEUMHuhavClpfRWekOA6Q+hdWsC4oN1GBYgwjC9la9frxB7DPTFA
         7Rfx7PtnG9SQnnRbRrEF4qXs1NCnHPIscfATFnVzKLxqlFe7pB5IDFh1GT5TY6aGk3nk
         7Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447951; x=1784052751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpCCPKUP/PSVVOzoUHsOPAGSwv+Rdw/mEnVII8EGP5k=;
        b=fcmh9W1qxYZowzA1Ie6rfoylxxAaBIua42uLysXkMieL7CLeSNIGZiCMUwX5l+TXIc
         KTo9xgXGMsecKupZPEnw3vN2nAEDWJ3FvxpJO4pqImPyfkBUKIPhOjJYniLNhEktREeT
         ZgTq/IpGG/qp/fS0NrytAyFY67jPgMSacbWQWWOjMa1hvy8ocr6kqDiAd6bDaL99ZHv9
         debrGFUwjnTLqRCElK1jxuVb+OtwGPPSmmqxEs6dbZZPx5KQctHzOlg6FjcTacR5fO34
         8gDosyrwyPTQ7wiH5gfE79pmvwlpDl8xdLnB3NMqSq/3hR8Dow7EYKc8S2t8wArej7S0
         myGw==
X-Forwarded-Encrypted: i=1; AHgh+RqaUJYWo/6w5JlXx0bg/CSV8WDH2lPkv0/deoUWy1EoUdni6vSAhjthJ0x2PWZzBL8kLns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+TLbzj7izCW+ORARlCOZolPCsnoub4uyQ8QEXW0CkUiwG5g7
	TXIL2NCVd5fI04+iMcUonLZhInakeuKrntgLBF/p0TXLhG3ozWqJZjGHYiYD3wPf6jBVM00WUV9
	gz2XSYpcVJdF5HQnBD99IsSF1p8emwTw=
X-Gm-Gg: AfdE7ckjv1/O2A6sPmy9Di1Wmqjg0zPaMgOivNqVJS/+o7c7ia/3s9U6UBqGtLnZNog
	qd5e6SUh5EunAyCga4eXpWN1ssyQOSFkTXobGawS/T7KoBfil99N2bTFRA5uwOcdNIjivznZgoR
	kLutsid02unNxUatLMofvnfo4AgiYe1j1vo6zsKrdw1wgTOjQL960FhRHu34HdvumnOoeLfTepP
	3Wu+4lVJ9kTKt54zCH14VcF31lGk6w5DZDlr2rNcp/+UiH7sn7weH9O58ZkdD+5D5k1zLVCpiCg
	QCg1TxAAg+lLScR0tO8gevoRyrSWKTV4ukKUu1QgTZWG9xt8exJME/ycP2YxzaTcz59b/0ynblt
	iLoHbOzU6H1JgvYAp4k9H1kpaI8wnsBPMtq3Qrkw5HzS6Vq17+oB9xuvglXTdNbJZ5GXlT4g=
X-Received: by 2002:a05:690c:620c:b0:814:3d11:b868 with SMTP id
 00721157ae682-81be35a2772mr51036277b3.65.1783447950683; Tue, 07 Jul 2026
 11:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
 <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com>
 <CAL71e4O1tLE_VSDeeZQ_p=8kAXvk9JQ9EqdPaYMZnNs+Xj+RYA@mail.gmail.com>
 <CA+J6zkSrcJVcKmm0duTQwWcLxrsZ6eZkVgL=hQUQHegKGsWsxg@mail.gmail.com> <CAN5EUNQoLtJ9cGwe8RNJTTdngM=qoak2=5F+yc7TH94TmQn7uw@mail.gmail.com>
In-Reply-To: <CAN5EUNQoLtJ9cGwe8RNJTTdngM=qoak2=5F+yc7TH94TmQn7uw@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 7 Jul 2026 20:12:19 +0200
X-Gm-Features: AVVi8CegfJzv4Fb-aw2sqTd8L1wX-dueaIef3lmTmLH81hx27tiA9mSvb2ATsts
Message-ID: <CAN5EUNREij1M46qpiERuD3knCGbQeVLOL=sV_OPXg26NxFcrxA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 7 jul 2026 a las 8:31, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> El lun, 6 jul 2026 a las 17:33, Chandra Pratap
> (<chandrapratap3519@gmail.com>) escribi=C3=B3:
> >
> > On Mon, 6 Jul 2026 at 19:15, Kristofer Karlsson <krka@spotify.com> wrot=
e:
> > >
> > > The hardcoded size-2 lookahead buffer was my suggestion,
> > > so I am responding inline with my thoughts although Pablo is
> > > the right person for making further changes (if any).
> > >
> > > On Mon, 6 Jul 2026, Chandra Pratap <chandrapratap3519@gmail.com> wrot=
e:
> > > > Do we need to NULL out the retrieved buffer entries? If so, it is
> > > > worthwhile asserting that the entire buffer is NULLed out in the
> > > > !graph->lookahead_nr check above.
> > >
> > > You're right, it's not technically needed, and there are many places
> > > in the repo where stale data remains in buffers, and it would be poss=
ible
> > > to do that here too. I don't think it matters much in practice though=
,
> > > and NULLing them out would perhaps prevent some accidental reuse on b=
ugs
> > > (NULL would crash instead).
>
> It is not really needed to NULL because every time we access it (pop
> or the graph_is_interesting()) we are limited by graph->lookahead_nr,
> however I thought that it is better to have it NULL.
>
> Imagine that somehow the lookahead_nr is 1 when it should be 0, having
> NULL would segfault or if it doesn't at least we are sure that
> graph_is_interesting() won't re-process as interesting a commit left
> as stale on the buffer. Anyway, this is just speculation. I think it's
> better to leave it like this.
>
> > >
> > > As for asserting: rather than checking that empty slots are NULL
> > > (which just verifies our own cleanup), it might be more useful to
> > > assert that a slot is non-NULL when lookahead_nr says it should be
> > > populated, i.e. assert on read rather than on empty. But even that
> > > may be overkill for a 2-element internal buffer.
> >
> > True. But since we're already going through the pains of initializing t=
he
> > buffer and NULLing it upon a pop, I'd much rather go the extra length
> > and verify what we're trying to do, shouldn't be that complicated anywa=
y.
> >
> > Whether that means checking for NULL here, on a push, or on a read
> > is something I don't feel strongly about, either is fine with me.
>
> About asserting, I think that the best is, because we are popping, to
> check the first element only just in case we are in the imaginary
> scenario that lookahead_nr is lying, but because we pop, we don't
> really care about what's on the second entry.
>
> >
> > > > Not the best engineering practice, but I guess it is fine to constr=
ain
> > > > the logic to _only_ a 2-entry buffer since that's what we'll always
> > > > deal with anyway.
> > >
> > > I did consider making it a proper ring buffer, but it felt like
> > > overkill (and I could not find any other existing ring buffer to
> > > piggy-back on in the repo), and the lookahead depth is
> > > structurally tied to the algorithm - we only ever need two more
> > > elements.
> > >
> > > It also helps that this is entirely internal to graph.c. If the
> > > buffer were part of a broader API, a less hardcoded approach
> > > would be more appropriate indeed.
> >
> > Agreed.
> >
> > > > We should use ARRAY_SIZE(graph->lookahead) instead of hardcoding
> > > > the value 2.
> > >
> > > Agreed, that is a nice improvement. What do you think Pablo?
>
> Yes, I'll do that on reroll.
>
> > >
> > > Thanks,
> > > Kristofer
>
> Not related with this feedback but worth saying:
>
> re-reading what's done on revision.c there is this if line:
> > if (!revs->max_count_stage && !revs->reverse_output_stage)
>
> Graph is not compatible with --reverse, so the right-side will always be =
true.
> About --max-count, I made a few tests and the lookahead behaves the
> same regardless of the number of commits to be shown (even if capped).

Now that I saw the GitHub CI tests, at t4202 there is a graph option
"--max-count-oldest" that makes the !revs->max_count_stage check
necessary.
After that everything seems to work, if anything I'll explain it on
the cover letter soonly.

>
> So this whole if block can be dropped and we can try to populate the
> lookahead buffer always.
>
> Thanks both for the feedback and review,
> Pablo.

Regards,
Pablo
