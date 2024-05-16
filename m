Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8403FE4
	for <git@vger.kernel.org>; Thu, 16 May 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897889; cv=none; b=ANxFIpePwhkoD1L+9r25Qha2oQSnMHDlmjfKchz9r2UimqqkX5pmejXvko1F/ohAKxOSxQiRtbY446/FmO07l+6X6kv3HGnJ7An1Pdm/tPtmt5vaTFctdOC6lyVhAtYY+rHs0vPYbwBNy5+v1hzQR4EVFnAGdCHfHWXia4ZCCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897889; c=relaxed/simple;
	bh=31O0BkQnElarVl86SOWG3H26zTnEiTygpau2v3J1zpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gE/mhoJKaPZH3BMscs4hr98YElcBNVJE28jo/ZyLGSjnLagR11Sd7bM2bUS/DI4pGTk+Bwax/IhTr+WecAJD2eUS1XumRtaZCNT2edLmJeg2Jx6vHc0BEe5IQiLsRx9OaojdepZNH3Z52DmTZAvkp4qv0fRXKik++vG3AWc9vzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqmgxohC; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqmgxohC"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9a5a2180fso77360b6e.2
        for <git@vger.kernel.org>; Thu, 16 May 2024 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715897886; x=1716502686; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=es0Mxjn7lnjJ+erog30nujNpTY3wZ53pMD1yHT0LXKI=;
        b=gqmgxohCQVPlvnsZLjy7Ctv7LnbZBDTYa9uH87/KsX0tkQuSPVGX51Zb2aigkBtDcc
         cvy8wmJUEhO+aSuhaRkM2NDqwTUfIn4iDXZTGzu6U+f2vMd/zD42kOYLWfZiDxAyrmiY
         MPWgh/Mie2OAbxSCo+jy9ipnSyAiVty0wmJPQIJYWcuKTUs3FdNr+WtdraeAGh0Gg1zW
         invJYnliI6IY5oGasAGeTbXEZwcopTz32wE4sB27XT3SpEQMhfZsw4ztCwBQv0pQm2WB
         Ki/jy1ArCHrETqdiTj/OqTzqfHYshVRaWrLrcHhspYqXLSwdXKdOqxu2yR1qnaFopPlw
         tfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715897886; x=1716502686;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es0Mxjn7lnjJ+erog30nujNpTY3wZ53pMD1yHT0LXKI=;
        b=MoSLiPzaNbZWzxZw8Io3TmUWgH8kDsAsw81kQNnRkrsiGTCDgTASgps4DmmQzTXZHn
         pTVi7KPwNgEEEg/nMouVPCq1jYdZuFP6WZ8Q4MiB7h7vwMj+nDKWJ0fCerznYsBarwTj
         H/bgt8IxKTHSo/xrGgxJtMoc9tMjUno+qQyUiP2RBPh8tUzMd28hRpUhrbughiHlMPX/
         gSuvS4FdYlCTlUxJj8tvQhmGIVMmNt6xu8TiWBVUp4MTsxJwzyqbHitgSOSrLnObDLcI
         C9Ht+iuVMkE9Kr/xc9c33v7g5cQ5zxeElsOhiaW0abqpUkfclil9kRaWsFn/syBGjGud
         VSvQ==
X-Gm-Message-State: AOJu0Yx68S22mcz1CAD2kZ3CI81UvgQR02DNdzbqVpJfFm/hocfGLrus
	0CLHqzcMtFQt5PWTyl+U6QEprUZ2/UusS/4WnJhB6oEf49TqMjJkDZXvOA==
X-Google-Smtp-Source: AGHT+IG0u8bvsqz1R4Gu5ZHIghT+L/VoJlCymT0OynIPak7iq75HNIEpDdU4VU22OzGQVAAjmx6lAA==
X-Received: by 2002:a05:6808:138f:b0:3c8:4e7f:47bd with SMTP id 5614622812f47-3c99725a8edmr24792687b6e.5.1715897886405;
        Thu, 16 May 2024 15:18:06 -0700 (PDT)
Received: from epic96565.epic.com (pat-verona-i.epic.com. [199.204.56.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf33b16dsm842853885a.127.2024.05.16.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:18:05 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what
 should happen?
In-Reply-To: <xmqqy189o94c.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 May 2024 12:21:55 -0700")
References: <xmqqy189o94c.fsf@gitster.g>
Date: Thu, 16 May 2024 17:18:05 -0500
Message-ID: <m0seyhs8o2.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:
> I personally found this a bit unintuitive, because in my metal
> model, "reword" is a mere subset of "edit": the latter would give me
> chances to change both the contents and the log, while the former
> only would offer me a chance to change the log.

My mental model is not quite the same, interestingly: 'reword' and
'edit' are not-quite-orthogonal, not-quite-parallel in terms of intent.
In 'reword', I know that I just care about the log. In 'edit', I don't
know *what* I'm going to do -- in fact, my mental model is more friendly
to the idea that 'edit' => 'pick then break'. This of course may be a
mental model learned from the observed behavior and not conceived from
the ideal behavior.

My 2c: in the case where you're changing the tree, you will already be
prompted to change the log. It appears the assumption is that if you do
not change tree, you will not need to change the log.

This assumption holds true for me, but my workflow is generally to get
each commit's patches into the desired state and only *then* spend some
quality time with my messages. That's certainly not the only workflow,
though.

> After all, the reason why it may become necessary to edit the log is
> because the user made some changes to the tree in the first place. And
> by not opening the editor, only to close it without making any change,
> the command is saving the user some keystrokes.

...and you seem to be on the same lines of thinking as I am. Playing
devil's advocate a bit: there are certainly other cases in Git where the
editor pops open and I have muscle memory to close it. I wish I could
recall in this moment where those cases were, but I don't know that
avoiding an invocation of the editor is a good reason not to invoke the
editor if that's the Right(tm) thing to do -- that seems to be a
circular argument.

Setting aside the obvious reality that an actual change here could have
pretty serious UX considerations for folks with muscle-memory, what in
your opinion would be the right thing to do? Why? Are rebase commands
'shortcuts' or are they intended to be orthogonal? Do they have designed
purposes?

I'm wondering if you can tease out what the 'ideal' state looks like to
you, then you can identify what if anything there is to be done about
it.

-Sean

-- 
Sean Allred
