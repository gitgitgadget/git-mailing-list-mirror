Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3877EEE7
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956273; cv=none; b=FOfKfy0uywY49Vup5e5eShlI8pJ5I/OCTcSv4g0MiPNWVInXlhEXm/YgCZdZ+4Mkj1nFGL1t01T/GhtLTlDGFP0sxmdkeKkv4ryh1Xgu0NxtQ8MXrgwjrtd4lCkz7TBVA1ORPIMpw2yrZKlP6BbqqhjjXuqg5pZEeXN5OOxAB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956273; c=relaxed/simple;
	bh=tv6ZT7M4zGmUs+9N47KDsugechwOzOgwnNUaelv/nQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFPVIBKmGujp+jExp3F1b248AqxywW3N3nilIy6sU/G8O68YZZrGQYZxrTS+CcHN0qHGk+W1uTLUJXG2vUZr6l7X3G93t0vVEnV7NG1kW2Jekco9EW45oAZrdqQpMicnKKtuXc7Q+t905DzIs7j0YCgmgNcZ9SuFGHThhShp62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-444fa159caeso38118411cf.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 14:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719956271; x=1720561071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aLVF8b51E24YyWppGKVJ2tFYWkWbA9AUcnP5iUNrNc=;
        b=ZmU8kKpFoHm+qL/mgYNBSNcXEozSPbxs38uhtrE6dR/tzskz8OeWJ7Qt83iKM+Pgbz
         s+fLIKADXF9YehC35rw3B7+qdO/FnsVsZCGQOMiuEJ1anPs28Zbxja/xGFVUGuIL9H1q
         uVTSs+yMYYS/fAdE4364KjlmHanFnKlE7rkhV3TLIdpqKnPzxB3RayrjcZv3nb3/qlYn
         tPRUWqmNO/zjGgVL81YA4edMQle7rAOUe7Pby6OPEeYpcbvHNZZwuXZnSXZOFkRCd6Ht
         EiYFdeU88GrWBvvk/lRjbMf46u5uYbflKFbLpMcPXhWCDunTd3TPDi1YZPJjk2cPDVvA
         vB3w==
X-Gm-Message-State: AOJu0YwN6PcRAaoCjQDmnjmYFYtylK4Tco7Tuyt9CImluUrreeHavSeI
	CW3zzn0BreyUzt/BnBbiBeal0BmuatsBv4pylIKQfT2MKsk6EFutuaz4e9fco1CxkeZZO567HsS
	b7sHqsc2PSZ5j6Po6929OIqeVejPVylID
X-Google-Smtp-Source: AGHT+IG/j6VK/AjG4It+MRJ7vYrZsrVYUiPnM3rrs/dqYPcbG/Igcr4/gV8Ih5faUxYWS+DI7kAlGjtTOwviWEV8dbI=
X-Received: by 2002:a05:6214:3015:b0:6b0:89ac:ad3a with SMTP id
 6a1803df08f44-6b5b717b192mr130260716d6.59.1719956270790; Tue, 02 Jul 2024
 14:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <20240702011350.GA31739@coredump.intra.peff.net>
In-Reply-To: <20240702011350.GA31739@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Jul 2024 17:37:39 -0400
Message-ID: <CAPig+cRJZeNTfOB_ygqo7yoYzko6-2wH11cxu2kHeNNBuxVn7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:13=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 01, 2024 at 08:51:45PM -0400, Jeff King wrote:
> > And then ScriptParser::parse_cmd() just has to recognize that any "<<"
> > token isn't interesting, and that "-" means "read the here-doc".
>
> BTW, there's one non-obvious thing here about why this works. You'd
> think that:
>
>   test_expect_success 'foo' <<\EOT
>         cat <<-\EOF
>         this is a here-doc
>         EOF
>         echo ok
>   EOT
>
> wouldn't work, because the lexer only has a single here-doc store, and
> the inner one is going to overwrite the outer. But we don't lex the
> inner contents of the test snippet until we've processed the
> test_expect_success line, at which point we've copied it out.
>
> So I dunno. It feels a bit hacky, but I think it's how you have to do it
> anyway.

It wasn't non-obvious to me, but I suppose it's because I know the
author, or I am the author, or something.

> > -     $n-- while $n >=3D 0 && $tokens[$n]->[0] =3D~ /^(?:[;&\n|]|&&|\|\=
|)$/;
> > +     $n-- while $n >=3D 0 && $tokens[$n]->[0] =3D~ /^(?:[;&\n|]|&&|\|\=
||<<[A-Za-z]+)$/;
>
> One curiosity I noted is that the backslash of my "<<\EOT" seems to be
> eaten by the lexer (I guess because it doesn't know the special meaning
> of backslash here, and just does the usual "take the next char
> literally").

That's not the reason. It actively strips the backslash because it
knows that it doesn't care about it after this point and, more
importantly, because it needs to extract the raw heredoc tag name
(without the slash or other surrounding quotes) so that it can match
upon that name (say, "EOF") to find the end of the heredoc body.

It's mostly an accident of implementation (and probably a throwback to
chainlint.sed) that it strips the backslash early in
Lexer::scan_heredoc_tag() even though it doesn't actually have to be
stripped until Lexer::swallow_heredocs() needs to match the tag name
to find the end of the heredoc body. Thus, in retrospect, the
implementation could have retained the backslash (`\EOF`) or quotes
(`'EOF'` or `"EOF"`) and left it for swallow_heredocs() to strip them
only when needed.

There's another weird throwback to chainlint.sed in
Lexer::scan_heredoc_tag() where it transforms `<<-` into `<<\t`, which
is potentially more than a little confusing, especially since it is (I
believe) totally unnecessary in the context of chainlint.pl.

> I think that is OK for our purposes here, though we might
> in the long run want to raise a linting error if you accidentally used
> an interpolating here-doc (it's not strictly wrong to do so, but I think
> we generally frown on it as a style thing).

Such a linting warning would probably have to be context-sensitive so
it only triggers for test_expect_* calls.
