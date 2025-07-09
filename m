Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694B28B7DE
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056323; cv=none; b=ePpZJ1ReroePQ6c325YFM4OcRXqwTuJARX4SfKFc1EyuUABJggupBfvkOCXOjlgIljTdGfrbS6fQYPGocsJk0DqbkdpTX+dlf7u7MF0XjjEysVQSunFzQhv0tjFDqWLsf3UAzVDZbCG3ZmiGP1jzgTSF82Hs/CjkZ7F1gtKGAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056323; c=relaxed/simple;
	bh=vhbqhGeER9oRz63oaOYYIRZ191KjTX8i7axLojZn8E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlHgj13PSGlQeDlyxiDY9ltfOCLgrf9acM0ME5l9nJcaEmXlIiFni3eAJG/i8JqgAYNAzIyQi6Ufc26cuaBx5dxhIsdvD/FLOcjeT9NjCIM3Y/G07efd8OUqnpp7y4kDSSG/dsC9YP9A5TVlU89T7tbO4RdNajzuvFpnRFtVY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8nBADzp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8nBADzp"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso9595290a12.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752056320; x=1752661120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwvYtSIRo5OCdeVQPrCXMwjZJxDSN2LYEAF4LIHCqM=;
        b=b8nBADzpAgbfFJSfxDkLgx+XQ2B2j506l2vrp7Wg7/qbJmpFYOaZQwKSEV7NYTmh8X
         H5UShPgibVteGjnfSzaqWQiCaPIWetzK/4fWcPckQ83I7/jdqqUoSTCZfc9rpFdUGP9b
         xJcQdil/jbTg6n7u66SgVWBSmO8hOnNbUOxo+YF1kYudNWOFuBn+uDOu0IDzentS8GQl
         eBcQ3JLFgzRbZtOQGoUw5RjLEMt44uqX0g91X0qhJr6asTb8ZZOIPChDK4bwZGOH+2Uj
         PDN3/nRoOCMA2lxoeO/73eCp+kQYNlTw7wot0B5kyKv4QQM+TdH7Z5SHUdIDqNeJr35h
         akIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056320; x=1752661120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwvYtSIRo5OCdeVQPrCXMwjZJxDSN2LYEAF4LIHCqM=;
        b=HeOUt9/sk2Np1BpCjMd45NokFHsUR2lvtOhwQKO6SSPLVp24ezQULLCn6TUIhp53p7
         u8+l+jGQ7SSbYl7X26m6IEfEWRnvp+YcKwNKqOh8jmODKJbzpUkZ3Latj9rGJCbV7i1f
         yucAhV6IFoXZL1jp7X9S7URlpY6bgiYRYQMkGMie15DGP7I5rs7fMo8TG7MEVYMBFiSV
         xgsV2EiuHmqDsnJDm2LPJB0sxqN5g7TseFRlUegZtfX/rDcVG7SWf2PwE+Fiqyzo/MUN
         XBDM97/RTuFYTlEp44JVg4HYp8XuBhjAj6Yfpvg9atD2qHUiOmgdg/7pfOjz/f4bqM/r
         SL5A==
X-Forwarded-Encrypted: i=1; AJvYcCWCwz3ajPATrJcE0fEwH6IDMa1YISdm4XXaWY4383Pp1NV0Ay24j2KxHCP0ccpPZJaHfRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVT+NN2GUu6vgmzwWQTZo1rPJsewSJXR0zc23B6YRSusscPVr4
	XZ6XmmPzuXCXSgJYtlpPKEob0o4wlULRkgWQw8yYVVyGuUmI9wffLYuu9VxoiiLjRiEYYZpofRe
	A/m39hlMdwQiOhi4ye0JlLHfFsDL4n08A0g==
X-Gm-Gg: ASbGncu5Qd/oe2/9SRxyAZnpXjccwTsLL45N3nNjdQO+vx5ZxLleqjMBwYQC8gXsrm2
	xMatG4So8yaPOnfK0pg1sA9JYjEwJqwYN6spx/FB7obCD9tAk4+bH6Xb+WxuT9mMuxpEXQ0m9Mw
	oHJcsY6RaW8N1zN8OwcljAS7SslHo/OXQBn3739eaBWgYItw==
X-Google-Smtp-Source: AGHT+IERDz7fP1Icmoagf8aoMnWWfTs/XIRawat+p5dkB5PIsLKXZGUOVuul66QslBg3Xd/R5JMwhQjLZdlsEvnKc/s=
X-Received: by 2002:a17:907:2d0d:b0:ae6:ae75:4ff6 with SMTP id
 a640c23a62f3a-ae6cfc6cdbamr193897566b.52.1752056320107; Wed, 09 Jul 2025
 03:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619133630.727274-1-christian.couder@gmail.com>
 <20250708091738.4072857-1-christian.couder@gmail.com> <CABPp-BF6OvH8oh=jG_8fWoC5gW+9E+wx=uDEk1uerJTOva5isg@mail.gmail.com>
 <xmqqqzyqqlh3.fsf@gitster.g>
In-Reply-To: <xmqqqzyqqlh3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 9 Jul 2025 12:18:28 +0200
X-Gm-Features: Ac12FXyqSF1e0APUfEfVzluHi8SJ46KoWsc8iHuJN9ksUjjqYf2W0y8J8wfKgew
Message-ID: <CAP8UFD3h0TcO7zRgOOTBTLjRW9XWD2YMJwQZf42HNS9=UU-Kjg@mail.gmail.com>
Subject: Re: [PATCH v5] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:

> > Really minor nitpick, but it might be clearer to pre-increment space
> > here than to increment it above.
>
> FWIW, I find what Christian wrote easier to follow.  We find a " "
> in the buffer, point it with a pointer and NUL-terminate the
> substring.  We know we want to further process bytes that follow, so
> the pointer is post-incremented after the NUL-termination.  The next
> user of that pointer relies on the fact that the previous user
> concluded its use with that post-increment.
>
> If 'space' variable were named more genericly, like '*cp', it would
> have been perfect. Perhaps only the first half of the code was
> written first, and it looked for a space, so the name was chosen,
> but then later ...
>
> >> +
> >> +       /* Remove any trailing newline from format */
> >> +       space =3D strchr(sig->sig_format, '\n');
>
> ... it is used to point at a LF X-<, at which time the author could
> have renamed it to keep readers' sanity ;-)

Yeah, right, I couldn't think of a good name to rename it, so I
postponed changing the name, and then forgot about it.

> >> +       if (space)
> >> +               *space =3D '\0';
>
> I also wonder what should (not "does", as I can see that the code
> does not do anything) happen if we do not find the LF we were
> looking for.  Is the caller of this function so loosely written that
> it may or may not guarantee that the data it calls this function
> with is properly terminated?

This function is passed a pointer to 'command_buf.buf' after "gpgsig "
was skipped from it. 'read_next_command()' uses 'strbuf_getline_lf()'
to put each line in 'command_buf.buf'. And yeah 'strbuf_getline_lf()'
should remove a LF from the end of 'command_buf.buf' if any.

So we don't need the code to remove any trailing LF. I have removed it
in my current version. This means that we can keep using "space" as
the variable name, as it is now only related to the space between the
arguments.

> > Otherwise, I very much appreciate the work to create a testcase with
> > both signature types on a single commit.
>
> Yup, thanks, both of you.  It seems that we are getting closer to
> the finish line?

Yeah, I plan to send a v6 soon, maybe later today with the changes
discussed here and in my reply to Elijah.

Thanks.
