Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6782D66
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596613; cv=none; b=Id9liNRoiL7I6BDHAyrQbIUU29yoNATN7vBOVe4Cg5/YfdWRhOQl0Q0CoG+UJmQP666zAfekFvrZ7BW0Ocvznim64asQVvevhpcdJOPyqOIY+dmifA2Ro+kJE8wuTsRVo26OPaV2+4Jr/p30yJ+qJwkGFC2uHCIn4fBthz0fvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596613; c=relaxed/simple;
	bh=lTzAW9ZiKfe/GoXKzRJaJu3XXc+dLvjn1DXwT0TxtNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eREUOGsPqMqO2mpNHNL9QMNQdEhf1lTavG+2kq7ZlCcfJFWvsX08pqC9gvASKpJwv+8lisPVYQ2z3Vx4IdEkRe7qwjaUDWd8NVqj5OfB8HOVylnkoH6dq4VN4mkx8khybjyZf0crS1N84V5+k3ykbT5a+syg8O70NmWyHavfQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79efb4a46b6so277058585a.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720596609; x=1721201409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTzAW9ZiKfe/GoXKzRJaJu3XXc+dLvjn1DXwT0TxtNs=;
        b=uEsYF6px2X6MMfxi0XrG11ww9nfZKXwBomyNkZdOmirk9OpWYS8Yi3b3ycTYNBRvar
         fpHea7G3SwxxmCXXSmhFOhW7YHE9Y8AhN8fm3bYMoH66JZQlPAm8hCH2G2hWJtIKbOTN
         DUEd6c/O/WBG5t2v9CyQwaUNKjfDaUPNj6/ObbWANDIDXoDjG0RldeG2xeeKfA0D1O/c
         uWo9bo87yMBfhUfhZ2t2lJG9xT//KYPhGVktCrvhxXwEONQ1j40KpJFtRV3GTaYtdp7I
         4Y2wynInrxxxVOblSmJB8oBrShdCKkdvw4AE2HL0yMmpKZhXMgtwzmZqw26WqH4dX7oK
         5ZeA==
X-Forwarded-Encrypted: i=1; AJvYcCVvcdcL4FNsYNLDhoKSlC59Mdh9yY3+EwxePsEoG/H1GdG1yhAIKr6Ffxk6bPDkBWb+IjoQci8pa96w1HZ9NgEBZbeo
X-Gm-Message-State: AOJu0YxC2KlKVJudf6JaZZmLRe7UBNSAMNQxEk/B8gJKfqbxOMoqP+CF
	+GF85BfxaY/oz5HTtU1HuNqMycsVCPctpOhAc2fKzbkiDKcLR2JHk6FDWuuRidc0PvCWc4swUZX
	QrRiW14BCX6kjAkOlpOVwu2oqeVw=
X-Google-Smtp-Source: AGHT+IEz8kN3rKxBCxXwbNOdXWpu31sZsaBhUmNqjm8+ACMaaHYq/ZfxlcHNmIyPuBcrJFuXLwpF6aHUn+thRbTms9k=
X-Received: by 2002:a05:6214:5290:b0:6b4:dd2a:aa44 with SMTP id
 6a1803df08f44-6b61bfa28eemr51630676d6.37.1720596609194; Wed, 10 Jul 2024
 00:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g> <20240706231128.GA746087@coredump.intra.peff.net>
 <CAPig+cTv-DaGRmwWWCk8b33MKzV25vfP2zPKd2VOAEOtz4FZ2A@mail.gmail.com>
 <20240708090837.GD819809@coredump.intra.peff.net> <20240710010927.GA1529709@coredump.intra.peff.net>
 <CAPig+cRXkOesS_ctvxY2X=rwesTzgrBB0=5fvQLQsG3hZVY9TQ@mail.gmail.com> <20240710070647.GA2048777@coredump.intra.peff.net>
In-Reply-To: <20240710070647.GA2048777@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 10 Jul 2024 03:29:57 -0400
Message-ID: <CAPig+cR_yN6viMPgFDZQW90GF-=_q_RhrH6DMG7YAp7LRRYKWg@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:06=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Tue, Jul 09, 2024 at 11:02:01PM -0400, Eric Sunshine wrote:
> > That could indeed be an msys2 issue. It will automatically convert
> > colon ":" to semicolon ";" in environment variables since the PATH
> > separator on Windows is ";", not ":" as it is on Unix. Moreover, the
> > ":" to ";" switcheroo logic is not restricted only to PATH since there
> > are other PATH-like variables in common use, so it's applied to all
> > environment variables.
>
> Ah, good thinking. I'm not sure if that's it, though. Just PERLIO=3Dcrlf
> should behave the same way (the ":" is technically a separator, and it
> is only a style suggestion that you prepend one). Likewise a space is
> supposed to be OK, too, so PERLIO=3D"unix crlf" should work. But neither
> seems to work for me. So I'm still puzzled.

Me too. Perhaps Dscho would have more insight(?).
