Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369091BC43
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246288; cv=none; b=S4vGd66CTlOelfdMc6hj2z8XlU4PRioWpUFg4V5PGdGrr3sn31osEKZAgiV7H/Hu4sy8vLapBGQqSCmTbETq7vXSwqMbbkpAbwiT7CRziWS2C6Sh+2vjq1srcSrRBMn/axjcU7apJ1R8Qeqj0YQJYDyyywCKcM2yM7a3wQyFZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246288; c=relaxed/simple;
	bh=x4pepTEmyXzhbvvV/I+mJeJcJly7+H9dgEFS8oGnzE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAqHuQeu1XubZrdA9amO0jCHRFinRl8LXDtNcSfrC9xEKkqkw9Ud5DtWKbcdUE1FGF135Yp26mzuWCTqYHv7IwttKyFAc1YdaBRuBytQy/1pNxDlpfUcgtv5ds/WYjkPLbWD3t3DOe6+a1wsYDaDlakHWI64B2HBK2SCZ+qRFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79eff64a06aso31436985a.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 23:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720246285; x=1720851085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rohV6erPve7Vr7QjQQ6p5QsYHN8cwvRdKzpPVW4p6sY=;
        b=pQXSxGFcF9EHZhOHLy0zgaQMahBowa8C7Sawawbw4SHrmTODvo0/av/ELgvYDGYmMM
         7t/cuW8o1VGBPL6Rv00QPr3u+144kAgUokGwV9Ao5uhrmZ5zT83vzYI4bEkB9am74UC4
         BHs4EGguQSGMvniTjBHEC7dRsnWp4PB6ILYUcO2TX2ak0IVPSkDiO+nUV7DEXpYIwRwm
         AfU9GuDs5nBTVDr+pTh2xwjfeBPZgfjhU5Yz3C+xt/Bv6L+a0tSWsbhZt0Scpeo2OWW3
         ZH5Pq2BGNDQKnCfegUr+QrW8orzUj1qN0EUdLqG5KlrmWjASfRq/MSS+cbYsMYPF7W6a
         /63A==
X-Gm-Message-State: AOJu0YyQ2m3q1Gm0SccPoGCBjlBYNh/BjyDjwHx/ogehC44HYWusb/Uw
	dMcuumV0w8HbB7l13pBoHzM4u60SKMtEoppCDJYKI6V314K3Hlk6fbq/CLDrk9JfoO0okWOJ6qr
	pdbeevq6bK4OaqkgBy8T4Nm24ukY=
X-Google-Smtp-Source: AGHT+IESl26N4rRYgliTRTibrVTyASVkSxHyxAnoAAMTlVx0VcOi4tIG51EZkDJziL7asG09N4bZLEiEA0MJcEJ4js4=
X-Received: by 2002:a05:6214:5b11:b0:6b5:23eb:3a49 with SMTP id
 6a1803df08f44-6b5ecffa6e0mr75202436d6.25.1720246285005; Fri, 05 Jul 2024
 23:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net>
In-Reply-To: <20240706053105.GB698153@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Jul 2024 02:11:13 -0400
Message-ID: <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 1:31=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Tue, Jul 02, 2024 at 05:25:48PM -0400, Eric Sunshine wrote:
> > My implementation, however, takes a more formal and paranoid stance.
> > Rather than squirreling away only the most-recently-seen heredoc body,
> > it stores each heredoc body along with the tag which introduced it.
> > This makes it robust against cases when multiple heredocs are
> > initiated on the same line (even within different parse contexts):
> >
> >     cat <<EOFA && x=3D$(cat <<EOFB &&
> >     A body
> >     EOFA
> >     B body
> >     EOFB
> >
> > Of course, that's not likely to come up in the context of
> > test_expect_* calls, but I prefer the added robustness over the more
> > lax approach.
>
> Yes, that's so much better than what I wrote. I didn't engage my brain
> very much when I read the in-code comments about multiple tags on the
> same line, and I thought you meant:
>
>   cat <<FOO <<BAR
>   this is foo
>   FOO
>   this is bar
>   BAR
>
> which is...weird. It does "work" in the sense that "FOO" is a here-doc
> that should be skipped past. But it is not doing anything useful; cat
> sees only "this is bar" on stdin. So even for this case, the appending
> behavior that my patch does would not make sense.
>
> And of course for the actual useful thing, which you wrote above,
> appending is just nonsense. Recording and accessing by tag is the right
> thing.

In retrospect, I think my claim is bogus in the context of
ScriptParser::parse_cmd(). Specifically, ScriptParser::parse_cmd()
calls its parent ShellParser::parse_cmd() to latch one command.
ShellParser::parse_cmd() stops parsing as soon as it encounters a
command terminator (i.e. `;`, `&&`, `||`, `|`, '&', '\n') and returns
the command. Moreover, by definition, given the language
specification, the lexer only consumes the heredocs upon encountering
`\n`. Thus, if someone writes:

    test_expect_success title - <<\EOT && whatever &&
    ...test body...
    EOT

then ScriptParser::parse_cmd() will receive the command
`test_expect_success title -` from ShellParser::parse_cmd() but the
heredoc will not yet have been consumed by the lexer since it hasn't
yet encountered the newline[1].

So, the above example simply can't work correctly given the way
ScriptParser::parse_cmd() calls ScriptParser::check_test() as soon as
it encounters a `test_expect_success/failure` invocation since it
doesn't know if the heredocs have been latched at that point. To make
it properly robust, rather than immediately calling check_test(), it
would have to continue consuming commands, and saving the ones which
match `test_expect_success/failure` invocation, until it finally hits
a `\n`, and only then call check_test() with each command it saved.
But that's probably overkill at this point considering that we never
write code like the above, so the submitted patch[2] is probably good
enough for now.

FOOTNOTES

[1] One might rightly ask that if ShellParser::parse_cmd() returns
immediately upon seeing a command terminator (i.e. `;`, `&&`, etc.),
then how is it that even a simple:

    test_expect_success title - <<\EOT &&
    ...test body...
    EOT

can work correctly since the `\n` comes after the `&&`. The answer is
that, as a special case, the very last thing ShellParser::parse_cmd()
does is peek ahead to see if a `\n` follows the command terminator
(assuming the terminator is not itself a `\n`). When the next token is
indeed a `\n`, that peek operation causes the lexer to consume the
heredocs.

[2]: https://lore.kernel.org/git/20240702235034.88219-1-ericsunshine@charte=
r.net/
