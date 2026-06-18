Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184B2E7379
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754801; cv=pass; b=ujxL3BSgGTgnkqJDdUF4g6xYUjbDrf9jA+sQzzgiDP4oPWDOUKaBB+IGUUWHDGvrKGggoN1TE+OU6B9B/jmZ9wCSSds6trdnTVSbS4XgU8elFJWjhq2mKc8Ku356nNP5+1Df5/YE3qEJj1mNS6fRB2vQIvaBsTaI5UyrMkyT/tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754801; c=relaxed/simple;
	bh=Jsl0LSMn/j7WfPez51crnLhlEBl/0pIRftbdnXV3ask=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SoEiWHbourWxHCJvhUesc4GphvYEW9ijLY9Se4B1c8w8bH5AwRXsrzAiQvxBm+Ii8N6CcZoF5VhJrmfD9W9tHGp6xPMIPHR42ACcbvSkNO5W8QJVve8A9NaI3g82SmibTy9j5OVOz55bVCoPRJrhuGAnBV+Fj//CCrrgLOAlTa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqgqpbh2; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqgqpbh2"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4877a7b451dso349224b6e.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781754799; cv=none;
        d=google.com; s=arc-20240605;
        b=joE4NdUmAUnxp9rwYHVC7MhG2021UI9WIegdDg3wO7lRi+mOj5MiSEteN0Ato2MA1s
         jh31KRbFdvtXXJ7rQuYo2cltsPfrw/bAo20ZGNbhEGbJrUCDA4TScGoIjqlUPlzNN59m
         79wXUVsWlS60xJlupZIBVYYHCLA+5Ks9xuuhwgzdPyn2sizFmPHJW5ap2z9m8zP21YjD
         SRlpkixgkiVJIGNuiTKoGScqn8YVz/DJHqgKOJqWBay51OyCyM7S1gT0neq5/8BQA8Hz
         yGSkvD+0hORgXhoza1hlS2V651gfM8Ly+crqv02MT2VqQQ2y0ivlS28jJovW9qQk6TfU
         yyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/Kv/9y+TuTQye1cj++VUbua78pTl/J0FG/FvMP6ix04=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Jo0ERaVIEaKolLJn0x/TONpTu8kfPWlyJnAqTBYMV0kv4DbA83yrr2AX6aHyJHVTI2
         AvMq2oAJ7qBh0VDG2p7SJNNWa1N+Fzo0RxGK3tBUCqIj9Q6fSPKG0zhaJn9gIoXVHau8
         aXyQp14L9PBIrEOOK8A52anuzRkbKGw6dRfxxAx3uI8D/y4ZnbvaEcKa7mO06lmTe7O6
         zB8G/EUKB+zTu0/5NuK3qXmheHXGMSQ2W6FC/u146NlABC44mbEM5QmI4OMTtWUnU+sI
         7REOXBgQw5CJX+g6zuEkaYELWmZJziQddSjYMy5JERS1QR+Ja4leljw92epwkk/UF5qA
         XG5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781754799; x=1782359599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Kv/9y+TuTQye1cj++VUbua78pTl/J0FG/FvMP6ix04=;
        b=Xqgqpbh29yW88sXjaWAcjsxN0qrsMKmOvoMc6BIhZpxuGvNlM+xBw7sDFAQsGWVPLa
         NNv3nmxFP0jpDRVOtUER3saydrVBOlicxJDcVURzUYsSsyQJO0BIXxg7B0VIRISeazWm
         Dnvs3abUq4Q1c9ueWnyTlUGF5MoUCKNNJSJNGDyW+gGf0orElwqJUCOXbp4HZS6WEolE
         5sKC89ZebCjHXNpgjpz7fFpAbcaollxsMNaBqp4nMZIpoumPanae0iqFoPD0NO4KVfZf
         wtFEYisZdMThkP5vDtgCgt40Ayf0XDcKpgsVAk4uC4zm1k+rHp3NlJhBuvmJw0YtW3Pp
         RVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781754799; x=1782359599;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Kv/9y+TuTQye1cj++VUbua78pTl/J0FG/FvMP6ix04=;
        b=iZsYXpsJvcUyWOlEvCoRBiOXuqo8bYIK0JL6BZy6CROh/TrWON6Zcp61E+X3uit/Zh
         G4giBpL1GjUV3gXKRrPrlTlXs74Nj995wgsMfKClgko95fOAM8J3Wy6JCvEKt3KER/vj
         cwzlz7ax/spWtYVAZvMoBFcv8D5jAUz0bYcWfdtV8aj2MPxeT+eTD1trGvh9KSsjTbiI
         iuu1yEWUxXO1jo34PHVBs+am7RoHS19GeDIJr9MQieC0UJkgKy5pN4tQThrBE3z0etlS
         GVr9m66OfxdZyFgI9Mw8g0O4YlawwOooKt49Lwdzyq+O6BM16cpcz+5GFd7Cv4EOfkj5
         MnNg==
X-Gm-Message-State: AOJu0YwSbcZjB4ZbbAZsS4HRrMXveqbESaa5IIX+MXpLsVmPcL+7ZXiy
	C7oPELYMSeJiD0KdSkhWSNtm0kU8x/LdUZB9dQiVSMv8D1/sUVO/moLix+vQWZQL6/5At7QMpWj
	PWD6KOcIrlE1nQUF3TuBgEMbC7GdpRaUKpWSa
X-Gm-Gg: Acq92OFa+mBzgxH4Iv+5F7OE1PYZZKSI6qNDjr+89EfHuoOqJD2gX/NFgwB1YeE1OsJ
	SpEAh/q+lvI+vGAWSmsEHz8axP0BBfBH8ma1ZjDgU1yFvD952fpcTkilXwY0K+Yt6DL64BB+wLn
	tOUEbcI6ugaHrurZD8xcuVU+OYo3pHQ7x2Za4yVQCJJ1lqAoCaS4jfZzp6BXMc0+UAY2zU0+TTx
	iaTszxwiCKQh+A5pUT8piXYqp2f8E766sEzqIMMGB4lyycy0+eHBYUcIOa7fzxDX7Sc2559wUpX
	QkGJN56VhpeNd1zeAIqZZd3UCZ+75g==
X-Received: by 2002:a05:6808:1526:b0:479:f9df:ab35 with SMTP id
 5614622812f47-489570fb68dmr1916130b6e.42.1781754798935; Wed, 17 Jun 2026
 20:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 17 Jun 2026 20:53:07 -0700
X-Gm-Features: AVVi8CcTVOB6a6R1Ap__MZu0wjVbONcqqu7RgzxKD7PgUKfZceG-6T3yezIefJc
Message-ID: <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: address design critiques
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano wrote:
> Contributors sometimes fail to answer fundamental design or
> viability comments from reviewers and submit subsequent rounds
> without addressing them.

I think these added sections are helpful. As a newer contributor
browsing topics, I was somewhat surprised (pleasantly) how it seems
like nearly every patch receives some kind of consideration even
if the initial direction of a patch isn't necessarily something the
project ultimately wants to adopt. I also sometimes see these kind
of patches receive implementation-specific feedback in addition
to design feedback, which I think can obscure the fact (especially
for newcomers) that even though one continues to send re-rolls
addressing implementation critique, the series won't make
fundamental progress (or receive continued attention) if design
issues aren't fixed first.

> +You would want to be particularly mindful of critiques regarding the
> +high-level design or viability of your proposal (e.g., questioning
> +whether the feature is worth implementing, or if the chosen approach
> +is appropriate).  You want to defend your design decisions on the list
> +first, because you do not want to spend too much effort in the
> +implementation if the design is not yet solid.

Two small suggestions: open with a direct imperative and replace
"effort in the implementation" with "effort on the implementation".

    [B]e particularly mindful of...
    ... too much effort [on] the implementation...

> +Also, make sure that any new version is accompanied by a much clearer
> +explanation and justification (in the cover letter, your responses,
> +and in the revised commit messages).  Aim to make the reviewers say
> +"it is now clear why we may want to do this with the updated version".

Maybe it would help to spell out what the explanation/justification is
for more explicitly (though it may be a bit redundant with the
"meaningful message" blurb):

    Make sure that any new version explains and justifies those
    design decisions more clearly: why the change is worth making,
    what alternatives were considered, and why the chosen approach
    is correct.  Put that justification in the cover letter, your
    responses, and the revised commit messages.  Aim to make the
    reviewers say "it is now clear why we may want to do this with
    the updated version".
