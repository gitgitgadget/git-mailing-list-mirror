Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDA27701E
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891454; cv=none; b=ldiHaO4m66MC3HO0/e1BAwa+8gU+T9ZLf2M96f4oTpf4jqCzQnpJ/h/6l04wMw19Kb6WoAAFnaZ8L0e+XSc1bF95taiX8fbqVLtLItYAaKu/X2jvU5RClj4dNHSYA7m3FzuEoLGLRUYRESF57LnUrNOuJs79C3WLY8f6/htKWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891454; c=relaxed/simple;
	bh=sF1AJVbuSY2YNK3FCoMKHe78a46qADrRPah2frhlstA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGQWzaTwpntNM3w4fUbWvJ9uuvIBpucxYS1smrCViccasfhJFvOgO2fO7jFKQbB9CRRvTCx/fN8U+OENkYVjbbwnXKUjdeMusTDmnY+nuvomdTJyIPLLsF4P/Uq0Omrm/2cSwD+vpT1ZaJlS9yjz0rKjqlzKpv5Lp3YdPpsuM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7097f2715ceso6653216d6.3
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 22:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891451; x=1755496251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z/7HL9UpmTepz8WHzQUfKghXdD0oUD8lfE6PfUUG3o=;
        b=nADEGD36PfEOLztKCdAxbWHSv9bTcgB/FeYzqsTy5AIdBd8PAw6fIJSJ7ltidZkMWj
         RhZp1wYcMoGJQKHpRi4h6s9Mb0BHs4F3mUpvPEkVAeUMUbGl2RKNFmv0MQ3p42pWaFTb
         Kl9FWrTA/l7qouUQyJqrhkHSZYx/OqJdE9FiFAi+gYAAl9ydDsoZWDmm5I61Pmv0N4gp
         adjqT67FYm+aQ3hd5+buMM/sBwc9hz570bAYyBww50tewC973tYPzB0IbJ2bc6Kyluix
         b2mQmOdqkmz6gvmDNQRvXwTaesoaYc5HU3knxo4/0rVepeNK6ti0b2NF5bnq8Q2wGRmG
         uWoQ==
X-Gm-Message-State: AOJu0YwNUr91+utyL7oA+JhUsyM06lTzxM+HulYhP9Oby/wGxNjVkuqH
	Y7vtaC7LJ9HR3MciYOSgnpTJS06YvPLeDzF10P4GVrFYC8YSuOmgo1RG1kQMUdA/lZv8GiHaWDk
	+lr67iv437OyN8fu0ps4hstxEduYTycM=
X-Gm-Gg: ASbGncv40hdOQU2GNXVtsgtyYmwj7OP2PIgSixlxtARy5iaaS1bzQXAlRoD5GRhmjb+
	TxCW9jSdHHStx/dQW0dPN6YpsQB2sXBN8bfF0IehtsNlo4r/whBxz3IEr42kO7LEAhBRNbI3jes
	LiCaCQOgDZLJ2927E7IeH0rMocL4PdlFN6jHw88RzMFO4SLshq4Y8WRe2Wv2vO31qng2cECYEuq
	bDFnWgAnIiup/M6nyfDkDrfJEztSDp2bDxcElHM
X-Google-Smtp-Source: AGHT+IFJt8QIdtVtTgO0kVOtsjuD+R6+Szu+BGW3kSXMfWOND/qPB+yNYlZaQPFM3Gcoae23+gjHXEn/cQ6ul6J8Yzs=
X-Received: by 2002:a05:6214:2608:b0:709:23f0:f50 with SMTP id
 6a1803df08f44-709b094cbe7mr49551046d6.8.1754891451420; Sun, 10 Aug 2025
 22:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqectl6unf.fsf@gitster.g>
In-Reply-To: <xmqqectl6unf.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 01:50:40 -0400
X-Gm-Features: Ac12FXycJf0XCLgY7jZ34md15MY6Rn21vis0urL-8udtkzHI0Xid13B0apKKC2A
Message-ID: <CAPig+cSbMeQ9yxXLFco8uH2kD84mDCu57sMZs5LtfMRnoKaYjw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #03; Fri, 8)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * lo/repo-info (2025-08-07) 5 commits
>  - repo: add the --format flag
>  - repo: add the field layout.shallow
>  - repo: add the field layout.bare
>  - repo: add the field references.format
>  - repo: declare the repo command
>
>  A new subcommand "git repo" gives users a way to grab various
>  repository characteristics.
>
>  Will merge to 'next'.
>  source: <20250807150239.6987-1-lucasseikioshiro@gmail.com>

I think this topic may deserve one more reroll before being merged to
'next' since two or three comments from my previous review were not
fully addressed[*]. (I also identified several nits in the latest
version but they need not hold up the topic.)

[*]: https://lore.kernel.org/git/CAPig+cTA=3DUKbHd+BdCQUdTjvz1AzCNHi2XTREPh=
fUJfz_2Ny_A@mail.gmail.com/
