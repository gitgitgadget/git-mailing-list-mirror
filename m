Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0E19E7D0
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912850; cv=none; b=RB8ChKGBxpasW/u8zkgJSEI709fDn47Y/HkXD69/2Fai3qze12mE/fAY/sZXVgwYdAlqH4LXl9vk7yU8OO7/OejFBnafiwJzOPlA/h7QtJ9ka/ioKyK3++OZiC9UzGi9J7+CFS6UFn8e/T4SogUNlkp92IgWwA3J+w2sshrERg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912850; c=relaxed/simple;
	bh=CyYlaFeZHyUDsaKAH/wlyaivPrEbhyfV6/OyjFaPibY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXFYZqC7Wn4c28VMz2exUjyXuONo0omy2cEaNw5DesijhaQDQlZFd9BnVjSIAPDN+G/5DaXn8XFR0VpKzIjbG1jHqZDZSRSNR2J1sktvJ92cy/zXgDeUEBHA5JZWHkVAzw5Fc/Xqqi1jjXLUz1ZO0BSJhgWb6NxRAwj+nQLwoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nej2UexR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nej2UexR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae35f36da9dso55021766b.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753912847; x=1754517647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AczGjp4rZEWILQAM/61gf8ORUomsGRwl3uf82f8Lxgk=;
        b=Nej2UexR52TR9YkDr7oRhsAqN8MWIDiYT6tHk/+kUbfgnmyKPbAL6pDpZGKcFB8r/y
         clezLTkAGGwPW0X9+H9hxFMckBhcT/2/zKP7gJuhgm9YegmuG+CWIo5lL4WYgdROD6y9
         3iqxBKEFNkxg4QVDfRf6vLFwYpaWfF0r9mmf1qr6oPs9U9wl3pvCsHAI69sfdVUTNK9u
         vjRRgiinkYUjPSVPwnAkL787EBPvIGHM/U/9eS4M2GxxJm0CX2bbZ4NkfbpyCCeHxrnb
         yBYLH3s/gig9CwpYgJ0Nl06Uo5GvHh7Ivon9R584flL6w38NFbu0ysk778Ihwj8wygvV
         0USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753912847; x=1754517647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AczGjp4rZEWILQAM/61gf8ORUomsGRwl3uf82f8Lxgk=;
        b=iqAU7dzW0BodXnEVOotmox9dwjjd3ecn6RxBw0ofvvmo91nSWl0KuWtzMuGq6GAmGo
         IutgjvfpO8KC40kpOaTFIAU8h5N1EokJfMOqFLDnooiSRaBkmaZo2Av658UIs4d69ZvP
         0K11EkfHerrXgliy3AQig9Z9f1/S11OIPwm+KVBDmDrE+8vl2gQomP8wvcZ2b/Q9FpkI
         dgNcwklMefBrc2Iypb/lrmslpnJ1rJ3yJpU3mew4ncGZ4DRu0BbSuieQ7cXMKNxpP+ad
         EcCH3lH8CxoF0TQVXetHz1sfL98IIQh3YkOJXrgvH2UmbIc29tbKKxsdJOHqKvzPR7MM
         YRMg==
X-Gm-Message-State: AOJu0Yxn4Eb0k2XreP+YuPxxlYek3jA6m0lQraki62vtVaDTx6rDTYqq
	I4nHvuRgjkrXwH2X6gPPkYo49jhOmytEFIPO3WM8qnbX2vmHM4IIDEwrW+1X1ONUMHIwMP92ulB
	Hhc04wspQcNK1QfmpcM7naCM0B3YfqQc=
X-Gm-Gg: ASbGnctxrUFZgXXQLRKy3etWTaXwwk9y6KwuXJOUh+QWJDfMnizeBDRzL+Tv+hEAYmV
	EHh7KbBzHbvtLKLFG5UXusUz65gAbpkENVAsO6xpvj0xhXjqzewvsmbvxI7qBtIfVxWNy6L0CBR
	DxPZHUaq1ahmWCdu3WJKNZSFYgDVuTtkE2DGAiX1iJS3Xe1p/ckV6lPKXD9t0LpEdDZy2WZLMW1
	iKFeJ+qq9gkZZjTzYakoxXAv5Agc1SViRCQYm9rKA==
X-Google-Smtp-Source: AGHT+IEApzqXbtC6OTfknhb8FSZgtK9/0l8hTMxk0HvU5+b/UR+XFhbaKuSOVsXBrR/D/Ss8kVhPVj9MWqkbhW31gCg=
X-Received: by 2002:a17:907:d05:b0:ae4:a17:e6d2 with SMTP id
 a640c23a62f3a-af8fd736fd6mr600689766b.24.1753912846763; Wed, 30 Jul 2025
 15:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-4-ben.knoble+github@gmail.com> <xmqqcy9kxrbw.fsf@gitster.g>
In-Reply-To: <xmqqcy9kxrbw.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 30 Jul 2025 18:00:35 -0400
X-Gm-Features: Ac12FXzdEp0CD-JEnooKGbo4-W7S4VDBtOszBD09Pq-TseLJfplKxaoPYzhfplk
Message-ID: <CALnO6CB+Hh46A=hLLNDYc2dJB=DbfdbethuGk0rzX3dA2ptO8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] builtin: also setup gently for --help-all
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Lessley Dennington <lessleydennington@gmail.com>, 
	Jeff King <peff@peff.net>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> >     I originally considered leaving out the changes to
> >     show_usage_with_options_if_asked and relying on the parse-options A=
PI to
> >     do the right thing. Unfortunately, most commands can't make it all =
the
> >     way to parse-options when setting up gently, and trying to parse op=
tions
> >     without a repo creates myriad dependency problems (like: we might r=
ead
> >     config after parsing CLI options, so we have to make sure the parse=
d
> >     options overrride config).
> >
> >     Some usage.c callers, like check-ref-format, probably deserve to be
> >     ported to parse-options at this point.
>
> It is unclear what you mean by all of the above, but hopefully it
> would become clear as we read the code changes.
>
> [snip]
>
> I don't understand your "I originally considered leaving out ..." at
> all.  We are special casing a lone "-h" here already because we know
> this is where we should stop without exercising unnecessary code
> because we may not even have repo!=3DNULL and that is the reason why
> this function exists in the first place.  It is obvious to me that
> we need the same special casing for "--help-all".
>
> In other words, I think all the above changes are good.
>
> Thanks.

I'm glad it was obvious to you! I spent a lot of time trying to get
commands to call parse_options early, before touching any repository
variables, since that was the only place where I knew "--help-all" was
handled. This turned out to be a terrible mess, so I looked around for
a different path forward (the one here now), and that turned out to
work much better.

In that old world, parse-options doesn't change and the builtins need
a lot of surgery (and probably still aren't completely right)=E2=80=94I can
see how that note is confusing without that context, though, and I'll
drop it in future rounds (esp. now we've discussed this version).
