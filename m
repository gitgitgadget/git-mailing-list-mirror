Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FA622
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710982410; cv=none; b=hoNb905cGFWzWsi/6wd6v8pXuj9hi8g88hArwZnC77Eth1IIwIJ6Q/lGMq+CL7D5yMgQjfy58r8+AcDxnIEdAKutzoda4czIajOD/ap2ZQzcrsgr0/2nfUCbDg1wGyflpzFMmfwEIX566RiTDfIOA7w7NdH4pnpJMQZiYHAjlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710982410; c=relaxed/simple;
	bh=uM+tI1NwLUPXPmc1SZf8wZIObySvnfF5a1SLumW1ypk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlg/YdUPAR+3I8aK7g6ZFxkrXAM61SvMmMuGPjkC+UtoChBpk6gGpUn+0INZ5cZ+B2gtEtsarc6gEIBUjV8K6rFgnbYs/JN5Vm6NWymCfyBW1kkxQFlknwUMcbkCMyUeTKzCNSMxC8F/QrfjisRF8tIzNb/QZ8VpxZKgfIk9lX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMjyIejq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMjyIejq"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so316590a12.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 17:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710982407; x=1711587207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+xUz1Vjd3Dp768VqhYd62k4z1kA1ngvSLGAu76eMQs=;
        b=VMjyIejqrTXW3ymnZ3mSR+1pUZEiutZ9FH0abpdRcFQhCYrxqPCQCB1+XAzZOSOF50
         SGVxOrEgtAaZdtOhEouPdL2Nvkr9EpVIbTd3Ko1yhUaM81vFjHFz8qLkyO2BIh2dkM45
         d5UzYoOz6shRpmpAAkDpg5w0hHQb0AyPQpZWzURpjybh6ZU5x1LCtrKojzafwNlRdD71
         KoT1LU85/DDQBBS3puJdTD0nI5h+Q/p7v3fGBdWMQf3g5q9MaUcHF/kRmteNQSJM1l8W
         b5lddIQL4NpiETMGeWjPx3iff3fmZnwVr4fEN75++tfnUasGOFnkuKXVGn4G8eRKQ34u
         12Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710982407; x=1711587207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+xUz1Vjd3Dp768VqhYd62k4z1kA1ngvSLGAu76eMQs=;
        b=neJBQMkoCieCxNVDIpg87N7eqgpBu/WsQ89KSBGLY3WoEoEOPE9mfwEYX141xBiPR5
         mETuzlimbRTeQAWW3NUyXddvLjnFgV8u5eoeEhVvIRKp3NqoRiO6SNdz4QIeRuxA9sb/
         Mm1RzBjWACMLeCXcVUySO82+4f9NFCN0JMw7VAUlqFX1X3OTgoAU0Om2M4OIelkYR6MY
         PjY5DOrS1tMF0aof0bOJfDC4gInyOebI3RIQIPTga+VzDKXSJa6npsSnjTvAB24frVLS
         JmxXxZac9AJWhvPesz3Xa7ynEeRix32G14LTh+hP2GW1kyO4h2SgI27o46r6pdwt5M6+
         ANgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuwcBQjkO0LPIknZ46S1HpeGBdwBOYa7DyMJTw/djZVlHteaRCztzAIIl19zSHIuJyYrYUFywXpFgXuOIR6SWbZ+H9
X-Gm-Message-State: AOJu0YynPP8qqMEQwafqPa/Dtt3LNpJLa8+XzhVIc7Qmn9LIqjhnU0D5
	pm1+cNqXqL25DS/ksV774kdP5tbta0HIfzvLsxHzLx+L+gOwmFuAhB57CCp6MkOF/CdCc+SQ2xY
	UJ1natjRrC8SHeKrVWbcTq0gXS08=
X-Google-Smtp-Source: AGHT+IGqZILFfrr3sFeisdYiJcEUJEQWsnK/bQ4bJat9Ra5OCXP0LlKxCpdkRB3Rt4W1n/C4qXzAsdyFqq+arIaZjbg=
X-Received: by 2002:a50:cd9e:0:b0:567:fb9b:37d5 with SMTP id
 p30-20020a50cd9e000000b00567fb9b37d5mr300288edi.32.1710982407168; Wed, 20 Mar
 2024 17:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
 <63dda239-1205-4aae-a3b2-10365147751c@gmail.com>
In-Reply-To: <63dda239-1205-4aae-a3b2-10365147751c@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 20 Mar 2024 17:53:15 -0700
Message-ID: <CAPx1Gvf5g3z8E0e6TmwgDc-TVFmTvSBexBGtOwB8+jh-k6G=7g@mail.gmail.com>
Subject: Re: Feature request: highlight local worktree in `worktree list`
To: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc: Matt Hickford <matt.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:24=E2=80=AFPM Rub=C3=A9n Justo <rjusto@gmail.com>=
 wrote:
> "git branch --list" has a much richer machinery than "git worktree list".
> Perhaps the display machinery of both commands can converge in some way.

I have no concrete suggestions for such, but I will note that there is a
`git for-each-ref` plumbing command for refs, but no `git for-each-worktree=
`
plumbing command for worktrees.  Given the relationship here (each
worktree has a worktree-specific set of refs), perhaps that's a point
of leverage, as it were?

Chris
