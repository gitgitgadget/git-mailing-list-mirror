Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7014BFBF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468025; cv=none; b=XuUnAkvSt3krsdL0fcrbZgw3zoJcmSLl29HhGRXEQcJrLv7X+fdlWNUe234honbDssxOVi/9mAXwKm7epjB034QiwHhIwMBjb9vc0Fn6mBYrM5kt9dctVyRh1iR4DPaG6JlQQOMjYxsrIfjgA5wbQQvhekpVCN5lSdNZ9kNvbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468025; c=relaxed/simple;
	bh=KG2RBX9C/ILMN8soCRCU6eLyUv1BdKUBh1REb+U1N2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw3DNlWCRZjK79R180n6dkv36K+tCMAxXJcK/N+08mnVjj4zxZlnkCOK0EczFl312LqS93C8S/tZ2uH+78+bdBlF9XqVCUP2n6N4QIYcS/om7EMyzqKfvi0qVxcm9jX8kZ8Ck0bERe5PU29LYnY+n6Odhkmc7HAVLFiaU/k3QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f014a53b7so232110185a.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468023; x=1721072823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG2RBX9C/ILMN8soCRCU6eLyUv1BdKUBh1REb+U1N2Y=;
        b=W4wnT5ikoQIcjwhFA18fw0t4ja+n+uqmK7ju/vFHsOWxzCwKgzsj4NiM+YZD7A0uvF
         Yp89cBQnS/JtsQ+iyxZLAu1g4GaR2h646SN9Cs+wTEnCSHi1ryPUL2xuYwPrH8qqVuGV
         Ai5TPXntaxjADw7aJb2zFKKVeLxTy7HsvhLZ/WJdiPgirlMOQ1EDNWo3d2usKxsXshMk
         qsI6Z9yy72kwnnOR/JDy+fy47qMwhR6DpI82dOwnuSn7c4KkehUyRu38syL27ADo1iEM
         Ox4c35v/lM9zXi4/DToViVDg9ipuSPpOp2z7pBnYnW3dpSfo++/i5WX4SNSAfCDSPmO0
         IM9w==
X-Forwarded-Encrypted: i=1; AJvYcCUOgCN9bAeD4tbPX38KV6C/2rzFBMFuRuyKQC2bVxrsZrjCO/NpTHR/DZ05bVQJjuapJ4Wy3AoFGveh51LAIT7v7Sd7
X-Gm-Message-State: AOJu0Yy08+TeQn/LY9GYebjPOE58+iDKbZRwcpHbKUVFIgWefD66vBSi
	35t0N6h7wX27NqVT07ZO1VyXzng1P8rHi/E8kmnpHU6h6KesdSuB8P2X1uFBjNizyCvAwDBHaAp
	bpArGOCX+AufcQR1pPnO/Tjgxr8w=
X-Google-Smtp-Source: AGHT+IEKw0gLUAv5qCN0IuIkyfUhis88SO8H4ifFY2HlWUse+dB0Y1QmsVu4W27p0e9GWFJsIcz/0thPNB0x04V6kEE=
X-Received: by 2002:a05:6214:ac9:b0:6b5:ea99:bdcb with SMTP id
 6a1803df08f44-6b61c1c4107mr7767296d6.42.1720468022724; Mon, 08 Jul 2024
 12:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g> <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com> <20240708090837.GD819809@coredump.intra.peff.net>
In-Reply-To: <20240708090837.GD819809@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 15:46:51 -0400
Message-ID: <CAPig+cRzJXPa07wBXibCjfZ_uYtbAnRnOsXFrbMbCqRfwSxszg@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:08=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Sun, Jul 07, 2024 at 11:51:15PM -0400, Eric Sunshine wrote:
> > Given the way the Makefile currently concatenates all the self-tests,
> > it would indeed be a nightmare to retain the line numbers. In the long
> > run, we probably ought someday to adopt =C3=86var's idea of checking th=
e
> > self-test files individually[*] rather than en masse. With that
> > approach, it may make sense to revisit whether or not line numbers
> > should be present in the "expected" files.
> >
> > [*] https://lore.kernel.org/git/CAPig+cSBjsosRqoAafYN94Cco8+7SdUt0ND_jH=
S+jVPoM4K0JA@mail.gmail.com/
>
> I took a look at running each test individually. It's surprisingly quite
> a bit slower! About 4s instead of 200ms.

I'm not surprised. As currently implemented, `make test` chainlints
the self-tests and the Git test scripts unconditionally, even if none
of them have changed. As I understand it, =C3=86var idea was that the
costly initial `make test` would be offset by subsequent `make test`
invocations since `make` will only recheck the self-test files and Git
test scripts if they have been changed. His particular use-case, as I
recall, was when running the full `make test` repeatedly, such as with
`git rebase --exec 'make test' HEAD~n` to ensure that the entire test
suite passes for each patch of a multi-patch series prior to
submitting the series; the repeated cost of linting unchanged files
adds up, especially when the series is long.

> There's a bit of low-hanging
> fruit to get it down to ~1.7s (which I'll include in my series). But in
> the end I punted on that for now, but did add line-number checks. Each
> expect file just knows its own numbers, and I use a bit of perl to
> handle the running offset.

Okay.
