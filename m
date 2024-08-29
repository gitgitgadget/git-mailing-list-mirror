Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08926296
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969098; cv=none; b=MbzFHc8UJLiraCBg+IyMCwmha7M1dErdGFq+zAhkF737PAoaCxJw/EbnvjtfguIZiVWj/XPB6L6wVRaNlNQn3jfBmmYgBC5bOFUWMSNKxYzciTOilqstlTAm8e/4JrRpHeHZep/ReETnqgEPreV8F1OSFjBPsw7dBRvUkpEXzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969098; c=relaxed/simple;
	bh=WTOd9wl83xADHBVPior4Iw3mHl20PDx4YMOgaaPjPZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSEEBsoHlfCRdmUZowWn5S0TCCtcZYbQIruOaPNd/x90qRyTSyZxmxe4nyVI+CXkzp8BqXVc/vU6htDN3uhdkrwnZUiN9dNiz7rjr+hoSJmmbDzR6f65Tle1WI3QtwTBe7efJIqMigtnhENaqJ6FJwU1xF+n7bBOtwm25sTE9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4567b7ced23so744331cf.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724969095; x=1725573895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQEmLCs6k5EV/B4MJiMx/MKegjsDqVoAO9DrzDv9aD0=;
        b=G715o3akfIMcK/FXQzrpRzk67SrJDsQLCCwfJ4uam/93SBsJy1JeNeYbVdeuOZkAa0
         aZeMnIKAv519lMqertyhKqtg+4yY3ezYX678VlVONBwemW7UzEI6DKOzw7tBTGyuuk1G
         +RHKAgc7FkLIs3vXQYa7YrWx9A654A/4zGtzNcMZSqWIJfcWes6NWiy0/+MLxNtKOIEm
         uc9130/241mZmqmmaT1muQF0nZe8rDRvE3aGbjFld/rhIC8NQko6/VyKZwUzgEwsUoUH
         Yvjvi/WCEXdb9YkCmuXP3AdpoSgmWdsQC946VA+8F3gaooEcKZnxfjtUWroUh6CdLVf1
         jf2w==
X-Forwarded-Encrypted: i=1; AJvYcCXHdGYSHtrgLf9ScCsIUDsLfPVr5e6Xe5GKbaQeC/b9UzYi257aXNu4IktE++wmZ5Q5TUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRvVvLILbwyPn9jAplBRQRSMPtX6m/QQGoPzMVKyZ9aVZW+5C
	LHtpnHi7MKde2qYC6UkXlun0cYx8/erZQAq7UwPQVOZC/b9mojGTsmTTrc8kCVNwu3uU+S9+nLY
	4VKcLgklD7ZE0e030erSVxZbpnlFCdqpbiWw=
X-Google-Smtp-Source: AGHT+IGfLi1DshEJf8mEG1NRpNLTTSxDGXHSpQ6pYt2OHYybnfYoojfRpf1RRvW2P0wtUz/ZwqcgYpkAiMTPOrgtmt4=
X-Received: by 2002:a05:6214:629:b0:6bb:3ac9:3274 with SMTP id
 6a1803df08f44-6c3499810f3mr1185576d6.4.1724969095185; Thu, 29 Aug 2024
 15:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-2-ericsunshine@charter.net> <xmqq7cbzxrry.fsf@gitster.g>
In-Reply-To: <xmqq7cbzxrry.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 18:04:43 -0400
Message-ID: <CAPig+cQ+6am7-BSnWZz5=C0Q1Vyng0T4goB+ZE9TKJMrpi_Jpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > "?!LOOP?!" case is particularly serious since it is likely that some
> > newcomers are unaware that shell loops do not terminate automatically
> > upon error, and it is more difficult for a newcomer to figure out how t=
o
> > correct the problem by examining surrounding code since `|| return 1`
> > appears in test scrips relatively infrequently (compared, for instance,
> > with &&-chaining).
>
> I'd prefer to see "some newcomes are unaware that" part rewritten
> and toned down, as it is not our primary business to help total
> newbies to learn shells, it certainly is not what the chain lint
> checker should bend over backwards to do.
>
>     ... particularly serious, as it does not convey that returning
>     control with "|| return 1" (or "|| exit 1" from a subshell)
>     immediately after we detect an error is the canonical way we
>     chose in this project to handle errors in a loop.  Because it
>     happens relatively infrequently, this norm is harder to figure
>     out for a new person on their own than other patterns (like
>     &&-chaining).

How about this?

    The "?!LOOP?!" case is particularly serious because that terse
    single word does nothing to convey that the loop body should end
    with "|| return 1" (or "|| exit 1" in a subshell) to ensure that a
    failing command in the body aborts the loop immediately, which is
    important since a shell loop does not automatically terminate when
    an error occurs within its body. Moreover, unlike &&-chaining
    which is ubiquitous in Git tests, the "|| return 1" idiom is
    relatively infrequent, thus may be harder for a newcomer to
    discover by consulting nearby code.

> > -# name and the test body with a `?!FOO?!` annotation at the location o=
f each
> > +# name and the test body with a `?!ERR?!` annotation at the location o=
f each
> >  # detected problem, where "FOO" is a tag such as "AMP" which indicates=
 a broken
>
> "FOO" -> "ERR"?

Yep. Sharp eyes.
