Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F243EA947
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467909; cv=pass; b=P+bJ3RBzERKLEY6rMkbzxii4shtS/mpu7uAIE8FZq0c6ZgeFsbl1gK9YEuNM0wo4C9/+ZAx0kTJMDyVDZvgCgK+mlecuUcXiNpFDr4ncmbvGANZj52ox8cChcMrjF/r4NT+9ygGbhWl6HmmGcne3c5X6POo7mSC+eiN5M390TLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467909; c=relaxed/simple;
	bh=IvZMCezGNULFpD8iQTSXDp5yo2eymhYCbsL0WHoolO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftr4o14r7ppKHyMhpjGDV64S1Zc4TQ/8+xOiJqz0op5PsPioQk7JJLWjMMCqAsJ4tBqzuNqtGwpU3w+9wqB3R+R3rgq3HZ12HPVEQ4FrLg5/5JhRItkcnsLgRnkNjE6/1hLtZ46PyvGN/SWrCH7euYE2OJKlReyZY0EouQQ/6Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpbv7c0e; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpbv7c0e"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697764213d6so1300143a12.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 02:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782467906; cv=none;
        d=google.com; s=arc-20260327;
        b=WzRu6xG1elSLYDFD6Bq6AacZ+Kvp4h6/PTEJoqAhsNQQyDrLowyCnCcJMXuDZY1ppJ
         Ebxwajy24YiAC6s9Ca2DTi7lybOvn2fvF9a8MuHxhykFoNm0sXAFKFvVfS/6NM1EnWZ5
         Tk6TpyLXNbHETUnZvAJeyqLwjkDWW6i3KZVKlvvw9FGLW/vYl14e/F32B4eeu9nEpds2
         1QWLi1usSaYQp2/PrfnHATo4yLyiZIWSCA5XCKHln95SXdLxyJ2Omna8gXjFOtdueNPg
         tYX594NuCj4zCtD9Zl2FqgKdxMe3dn1IQ4CMHISuOllWmphRpI5zoLDzbIo1oeg2Jpc4
         6gIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOofzwNMso2UMmcvFSZ44yIvtmmCtIEz+Iu1cpKXOtA=;
        fh=6VWygOYwOFzWjCdrvv+0+uWmM2l/P0mAp1XWmm+8IcU=;
        b=BnEe8jVzahZ92i6sD+CXvYbNZFVk7EmkRU8/SX1txf7Myo5NtZREzJSGtznAmh5lzy
         sxz9PULHugH12i5LbpBvvxOccUeZEfuR2qr0N5reHEJD+TdO1g8phnQHnYeAZ0/c8CBZ
         0wDgqu4YjCc5mstgN8YsGu/UornSJLWscEQ/q3+n1CJiZmI6dk03acMQpj1upDk4oqou
         5d+Ew5v9Pmzr0khVkCfp57ReD0KWIYwyr6pbprBxEQxsDSAFPSFj8JS2LIAhGWXeTXMH
         EayVNvyTQNalPWEsL9vIfhCR6iaNcpCIzqk4MkwWBEY1JRGmdQPRTKD4JEtWfv5u6nX2
         NHTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782467906; x=1783072706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOofzwNMso2UMmcvFSZ44yIvtmmCtIEz+Iu1cpKXOtA=;
        b=Rpbv7c0eNh5XzqA+OJwh28Cm8VYmRETrtGRP0ioZ6uClrOCOGVAZIIajWmqk+ufEkj
         IvSCz7X4tVAOL6oBFqBhv3Yewr/iZLWSveAMwdOSL3y9H7J4MUdx6j6Mq6HgDXHVLl65
         DgSjxtqEhkkSW/0/i/NtjXgdXl3Nf0XIb1DBhzWMY57eVjNlTYe345+QmQ5/R+DQxWuM
         fhLMkAp8VnD1zHgeHxkGff02udWPP3pvm1eD7JpnG/0SsQfDcfck51PDgXQUyAKiBH1k
         3FbVEocLXmRL3U/hKkuE2lRch+T/IFMMhvCmTVunELoGEqo4+6S41is0snbIajvVt8mn
         i0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467906; x=1783072706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOofzwNMso2UMmcvFSZ44yIvtmmCtIEz+Iu1cpKXOtA=;
        b=EYcQhwEHySvHH83BHsIGUlYUEtLC4rVRKQGNGbZKyJw+iBBus5mmrAKUHcQXS1MGJg
         xB+AbGwAYNz0SzYOFoTU1bGJgM4YJx0iC5IjyOcHDc3oBubmNgCk1r8Ecr5s8SlAxTCD
         FmDDKpoO0jm6jua6Djzh8m3Egs0se3Ezpuf6W8VbLHgXnyJM9uHGqxbOHSmoqrhKD+wo
         Exaj0nA7nUuN1eOY8XJWhVWiLOEWi6VK2/A3CX2A2krCU6DqRr2gHlXjn/HlIGM4jODS
         Co2qUGJc3IONwYY9Ia2zEk318Sau2wneC3+GAt7sITgWbkrJgP3A3WaLg8vfEPjtstw3
         cLWQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVFFs0OsJLWZoKiLTxeL6NbLdDdo+SH+DqAgskEZse+uSpyq7ymm99HkokgNeugsLuKXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAszhmb6YaNqo2P2L8jMcOPG+ORTz7M/RW8IPz/gT0rmESkzdW
	uemLJQVNtzp1IjM9iug6y7a8xhuGv0l/F7k/BcH7wx8wdp23HqzIA1VEA4fzPX0u3u63gVQh6AZ
	ZH12yqDmvlO+NH/QFG2GDvuFHHHP9pew=
X-Gm-Gg: AfdE7cl5VZ/6/USwNBMZpHNUBEBdLQP7BGR/4wB7Ertj1I50XD0xaFcvGoBUTd2QNZw
	ZFI2/ymx7psm5UY7N2yChfHVLmXcBp5HGJE8fKyacuiSSJCvzg9v9dOT4+NLAPVF7JQueo9b3gE
	y91p2UERU0eUa5rKxmgGH1NQfWftsE4be/Q4yN6tJUfG58Ufs6k3UEBAewOAb0IVdMSVzrA3JDq
	+vhBz3H6G7yShJV+DsKTKtxmZLmbGOECEHLFkmQbDqBvfFpPPcNZN2GnbxHqqpITjMvirzIIbCF
	QSPQlOs=
X-Received: by 2002:a05:6402:278f:b0:697:83e1:5ed8 with SMTP id
 4fb4d7f45d1cf-69810a46b32mr1732151a12.11.1782467906069; Fri, 26 Jun 2026
 02:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
In-Reply-To: <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 26 Jun 2026 11:57:49 +0200
X-Gm-Features: AVVi8Ceqct45MTFaBlmjQTX9_RVFb37PXZziS2oMDFLzZZg50bocnaJfG-Rkcjs
Message-ID: <CAHwyqnWXaG1HGunztVgUdWnVogqCHRbxh8pcS5fGA6f3mB-nEA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 10:53=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Harald
>
> On 24/06/2026 22:54, Harald Nordgren via GitGitGadget wrote:
> > Adds git history squash <revision-range> to fold a range of commits.
>
> It would be helpful to give a bit more detail here about the command so
> that the reader has an overview of what is actually being implemented.
>
>   - what does it do with fixup!, squash! and amend! commits? Can it use
>     the message from amend! commits to reword the commit?
>   - can the user reword the commit message?
>   - what happens if a merge commit inside the range has a parent outside
>     the range?
>   - what happens to branches that point to commits inside the range?
>
> I had a quick play and found that it accepts ranges that containing a
> single commit (e.g. @^!) where there is nothing to squash. It also
> accepts ranges that are not ancestors of HEAD (e.g. checkout master and
> run "git history squash --dry-run origin/seen^2^!") without printing an
> error message.

Good points, I will take a look at clarifying or giving an error (like
in the case of ancestor not in history of HEAD).

Only accepting a single argument is quite limiting as one
> cannot say
>
>         git history squash ^:/base :/tip

I don't understand why this is limiting? It thought it was clear that
it should be one argument REF1..REF2 ? What does '^:/base :/tip'
achieve that '^:/base..:/tip' cannot?


Harald
