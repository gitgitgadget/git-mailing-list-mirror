Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D110A1A
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249601; cv=none; b=JHBT0z1rELxY1Cb9oksPLl2pb3w4fAe4b9kDjeacTMlrx1B2EmJ2uIWpUsUT9P9UrEyLIgoIPGKfUPIjiDP1UzWX8Ydsv3OzBUyDbV0b7v+o0NS3UywzFQcqwBXMwvJ6HJBuZnG+fAzlTg2AdHembGjji8tFe3qOZIIo5iI0Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249601; c=relaxed/simple;
	bh=c3GqGdDQbJb2wjrf2NVq0Yo692WMTBb1kczYLtj0tYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=io5eWgbMsIcwatBN93kmiQ8S+//kLCkgo+d/+2hpTRah2xw6f1AjVfq1/yNc8A9/jwSC6aFsvPIiOaxu9eIEAYTPbzrIkBLpDT0/iKEcsHpm2oa4FzPkpoAO1mDGZkBFRjcNyMNphn1oqBntSCvFQDFCHOcQyD/qnFxtDRsISuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c0f8d6ec5so154788885a.0
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 00:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720249598; x=1720854398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3GqGdDQbJb2wjrf2NVq0Yo692WMTBb1kczYLtj0tYA=;
        b=LTQtBdpEbDKfbsOsnS7WDLbd82oUoZAIVEgrQhw6pdQij2nvKAgED6Q5xHgyVxH97M
         KKBds9D+O5iXfO+5seEYu0iFD1IJH3h6sWiThW4prb4jX6X0lTf1yLaDqmFHT8egRUQJ
         euqGT8QDTAnLXy6MNagPMS5XJVG99qt+fU+W2P74zIzGTRbqdNJS8cUnEO4bFXM+sWpO
         U0GW6WlvHlt6PYci6p7ncCKQipD2ztv0Mofsebjdj5gWKe8L4BE2JcHfrLS9tlB5H7Q/
         QP8SiB+cdpD4ATkxz1g71Zev09IzjzZgIXgAJMUSYjB14IyKxcHizwbyARyRsfPg0hwG
         Co/g==
X-Gm-Message-State: AOJu0YwUWkAoQ/nUoir6X49FF7e/CUNPnInqBc/7RPm4DfcY1jUTY+zo
	9L8SkWCzb8TF08rpi0uk5pre1NP77EtrfjOEH4TLR5V3Q+/o0aA6j4dXKQsYXGRbuwwkCfcS39R
	cYaLTgYxGEHYOYrGWLy9PThPWUM0=
X-Google-Smtp-Source: AGHT+IG0GZLpxObhTEehK35IMliTIYNPqe7K2i5gANqLG9+1VlsN1xUilMUhz7AGIzXCS6YMyBllucmwzfUAHpVeDHE=
X-Received: by 2002:a05:6214:e67:b0:6b5:dca9:6746 with SMTP id
 6a1803df08f44-6b5ed26bf43mr71479316d6.60.1720249597616; Sat, 06 Jul 2024
 00:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
 <20240706053105.GB698153@coredump.intra.peff.net> <CAPig+cQnZjMBPooBqMJjPY78EiCEXQOSSyHBm4GtLcbsSqZKrw@mail.gmail.com>
 <CAPig+cTSAaZmoKHRPiVkV=Jc9z_JZWmGn_JZj+Atsc4DdC7XeQ@mail.gmail.com> <20240706065534.GB702300@coredump.intra.peff.net>
In-Reply-To: <20240706065534.GB702300@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Jul 2024 03:06:26 -0400
Message-ID: <CAPig+cQNVtJJ5esayT=zoahtvhLipDaCBbsqLdQPecpxLbhT7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:55=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Sat, Jul 06, 2024 at 02:47:57AM -0400, Eric Sunshine wrote:
> > Of course, the more I think about it, the more I dislike relying upon
> > what is effectively an accident of implementation; i.e. that in the
> > typical case, the heredoc will already have been latched by the time
> > ScriptParser::parse_cmd() has identified a `test_expect_success`
> > command, due to the fact that ShellParser::parse_cmd() has that
> > special case which peeks for `\n` immediately following some other
> > command terminator. As such, fixing ScriptParser::parse_cmd() to only
> > call check_test() once it is sure that a '\n' has been encountered is
> > becoming more appealing, though it is of course a more invasive and
> > fundamental change than the posted patch.
>
> Rats, I just agreed with your earlier email. ;) I am OK with the
> slightly hacky version we've posted (modulo the fixes I discussed
> elsewhere). But if you want to take a little time to explore the more
> robust fix, I am happy to review it.

The primary reason I said "the more I dislike relying upon ... an
accident of implementation" is that this limitation is not documented
anywhere other than in this email thread. That said, I don't mind the
posted version of the patch being picked up. The "correct" approach
can always be implemented atop it at a later time.
