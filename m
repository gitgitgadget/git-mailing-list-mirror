Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D620127C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955563; cv=none; b=aT36lj4fnt8GIM2XE8Z1bG0OB7ZuiKDgm80NCeUPTR0k/dr/Mq5VviEe7CbR7tgaG4KNsnuHIFXvAPmhHZCd58SXWdAKCO+Aq8td/VXBOdosxvvt8NRz28ZL8jm66tDAfKbwak4o1M0NQ28od8367EFQTkELwMBDFAAf2S2RNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955563; c=relaxed/simple;
	bh=TJ0mvunfh6smB/42zJdbXA0H5OJk6k9ZWsWH1uNXPG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et5sOJmFLW5dkADsGp8vXT5FbgEMWB46jUFUrrijokSwnD1nUXXhWoGXqr2IE0epmiB4RYq1LCXxaU+ATQc5BjnKn5uF/s5MJUZzYZShoQfbkptJXEWmoTQik+qliu+s0ewlqSI4VKtOvqfGhLCRoepvUktyap2Lki/Pia4KqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d63332595cso2221011b6e.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 14:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955560; x=1720560360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdhXkGdM9uOuns3/Ufnwi8XaQG30Ec/j2TGgbMR6ANM=;
        b=M8ietOMl36lRQ+1MwVgP+2Pikn12XeI02tNFYJqxmiSCamhlNA8a/zDZby3nNTnsjt
         VaTT1c/zM3Ccs44oN/FuNtr799FhYPSh179/1TwFTash1j3yoGWgWxHIrMG8ZQb/7uLU
         CE3Oq8X9rSdFe8ECNFflitdfZDjoOH+S1tBH+0hd9wbndjMpjoIxDIJlefwx1hfmOTNg
         r+ZXpRcGJC3Cqmj9j995twVLga5lFhMljmS0IwNB3EDpzAQf5Ovj/D+k41+/OYx8Lhm1
         vB7dQtrfBDZPVfZh0oi6ctjIHSZdxazYqClopFGKZVoBsXnuKu9Dd3TBY4/Cx7/q5r2v
         FfVQ==
X-Gm-Message-State: AOJu0YwDvBxO5NmjkAdiJcSLZpi2UR2vVbAAs645CPA85DSwvW7Hzigy
	DfyIlLfcn4Hh9hKgmVZC4YnbKyrrE2xbDLdEniYjtRruvcsj1XHUFqUpjJr+/V4HXyxqR2UoSpA
	tGh7QJooLFNbOciJvzioTAmGfVpJsbH9g
X-Google-Smtp-Source: AGHT+IHlxuJRhmIP+SlxRoO77+yP92VOWTXwH/afDz1weZY1HKU2hCL/5Od/7pDMP4j3PfmTgUlLMygD9fxn0MiALIc=
X-Received: by 2002:a05:6808:13d3:b0:3d5:60d1:bdcd with SMTP id
 5614622812f47-3d6b50c08femr13727445b6e.41.1719955560043; Tue, 02 Jul 2024
 14:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
In-Reply-To: <20240702005144.GA27170@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Jul 2024 17:25:48 -0400
Message-ID: <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:51=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 01, 2024 at 06:45:19PM -0400, Eric Sunshine wrote:
> > We lose `chainlint` functionality for test bodies specified in this man=
ner.
>
> Hmm. The patch below seems to work on a simple test.
>
> The lexer stuffs the heredoc into a special variable. Which at first
> glance feels like a hack versus returning it from the token stream, but
> the contents really _aren't_ part of that stream. They're a separate
> magic thing that is found on the stdin of whatever command the tokens
> represent.

I created a white-room fix for this issue, as well, before taking a
look at your patch. The two implementations bear a strong similarity
which suggests that we agree upon the basic approach.

My implementation, however, takes a more formal and paranoid stance.
Rather than squirreling away only the most-recently-seen heredoc body,
it stores each heredoc body along with the tag which introduced it.
This makes it robust against cases when multiple heredocs are
initiated on the same line (even within different parse contexts):

    cat <<EOFA && x=3D$(cat <<EOFB &&
    A body
    EOFA
    B body
    EOFB

Of course, that's not likely to come up in the context of
test_expect_* calls, but I prefer the added robustness over the more
lax approach.

> And then ScriptParser::parse_cmd() just has to recognize that any "<<"
> token isn't interesting, and that "-" means "read the here-doc".

In my implementation, the `<<` token is "interesting" because the
heredoc tag is attached to it, and the tag is needed to pluck the
heredoc body from the set of saved bodies (since my implementation
doesn't assume most-recently-seen body is the correct one).

> Obviously we'd want to add to the chainlint tests here. It looks like
> the current test infrastructure is focused on evaluating snippets, with
> the test_expect_success part already handled.

Yes, the "snippet" approach is a throwback to the old chainlint.sed
implementation when there wasn't any actual parsing going on. As you
note, this unfortunately does not allow for testing parsing-related
aspects of the implementation, which is a limitation I most definitely
felt when chainlint.pl was implemented. It probably would be a good
idea to update the infrastructure to allow for more broad testing but
that doesn't need to be part of the changes being discussed here.

> diff --git a/t/chainlint.pl b/t/chainlint.pl
> @@ -168,12 +168,15 @@ sub swallow_heredocs {
>                 if (pos($$b) > $start) {
>                         my $body =3D substr($$b, $start, pos($$b) - $star=
t);
> +                       $self->{parser}->{heredoc} .=3D
> +                               substr($body, 0, length($body) - length($=
&));
>                         $self->{lineno} +=3D () =3D $body =3D~ /\n/sg;

In my implementation, I use regex to strip off the ending tag before
storing the heredoc body. When I later looked at your implementation,
I noticed that you used substr() -- which seems preferable -- but
discovered that it strips too much in some cases. For instance, in
t0600, I saw that:

    cat >expected <<-\EOF &&
    HEAD
    PSEUDO_WT_HEAD
    refs/bisect/wt-random
    refs/heads/main
    refs/heads/wt-main
    EOF

was getting stripped down to:

    HEAD
    PSEUDO_WT_HEAD
    refs/bisect/wt-random
    refs/heads/main
    refs/heads/wt-ma{{missing-nl}}

It wasn't immediately obvious why this was happening, though I didn't
spend a lot of time trying to debug it.

Although I think my implementation is complete, I haven't submitted it
yet because I discovered that the changes you made to t1404 are
triggering false-positives:

    # chainlint: t1404-update-ref-errors.sh
    # chainlint: existing loose ref is a simple prefix of new
    120 prefix=3Drefs/1l &&
    121 test_update_rejected a c e false b c/x d \
    122   '$prefix/c' exists; ?!AMP?! cannot create '$prefix/c/x'

Unfortunately, I ran out of time, thus haven't tracked down this
problem yet. I also haven't tested your implementation yet to
determine if this is due to a change I made or due to a deeper
existing issue with chainlint.pl.
