Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A6C1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970242AbeCSVVi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 17:21:38 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45530 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965283AbeCSVVb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 17:21:31 -0400
Received: by mail-io0-f195.google.com with SMTP id 141so2002993iou.12
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a0r6SkFgh1m9kH4YfmcdALjdA0egLijwY2a/bUE+Ln0=;
        b=K5MBuFFwBy23urioNncXy4BubvM39hU16B4NkWR8e8WEvEQSJqkYXf4KBj0edvdxKP
         wVfg/ekhtqQyVxKUij6qKXg+RXq8J5AD3nwlI9KM4PoKJZD3x814mhdwA935Shsdry9z
         4ToKKnv3IyU7rDaJn+LKw/IU+5kvK/0+3Y3NDzoCReIaoEkwRrpDzDbcZFAP/I4Z+22+
         kKuWhxQ2JOT+7T0SWJOX1uUEp1CXZxV92tob20+17By8iGAB+pB6lFBjPLQjBCjF8XzA
         iv1iHYtSTqIjvdlzbDvstnPKN+OQKfp9UumXz8MjI+eUgQUueFDyFLrVbKEKorU1+KVS
         cGIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=a0r6SkFgh1m9kH4YfmcdALjdA0egLijwY2a/bUE+Ln0=;
        b=Lg9V4XLeX1dpsC9DQG6cWYGQL3Zt86n2qg+mkB5Rd/JT683kpmMWyGzcXVHyGxKKtr
         SGMIUxstE2SmIrPEZuGrmjhkbfaxHtuNwQo+YMou+IFcDV2rgmMWI5vv8WWbrIZDbZuq
         1zn6LTYANqImasWL7DyFMyuWDuFbBIWeQDAbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=a0r6SkFgh1m9kH4YfmcdALjdA0egLijwY2a/bUE+Ln0=;
        b=EKghFk7EKgoAVj71y7ZwUOpSzxuqa/c04DbK9LfNmKy5kbEkcFQUpjaYOpSapnsqGV
         itM4zoTd0l2JgtDQ1MVJ623cnWPrWDL6CmpdFxd8NEOGVGewc8WgIko2Cr71bMz4GDNQ
         mIs9VE8M7dTH32Pjd4Dm1wQR/I8664bC2GLxqMvyLQMcm/laic4ERr4XurnARRS6nesG
         pO/sNwbdpXckgJWb6nmSLdnVsI2+qVHQHHffHWLCca6MlasgDVnDKvdvUD22ybupK7yD
         YZqbAdYJnzn/h5/d9O8EX4y1m88/EYRO1c34Pro7KkwOZpeSu39fxz8tFzecucxp9isd
         MFyg==
X-Gm-Message-State: AElRT7EikfzABXdyHW7FB4zTMF420ubJRYzrnx+hUvhqVTJ8FYOH1Mzb
        pN9vFrF/D5/r781SR8KuBqSoYneCX3nsak1h9ug=
X-Google-Smtp-Source: AG47ELvKcD/UYbfT61zDeNctl5kObxPf+dxhb6zqkwPhMTI63Mopiw68mrUxLVkMHQtIzC56YszlVzXSp9X8bB856OY=
X-Received: by 10.107.22.1 with SMTP id 1mr14124851iow.238.1521494490327; Mon,
 19 Mar 2018 14:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Mon, 19 Mar 2018 14:21:29 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803191228240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com>
 <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com>
 <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803161248040.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87efkkdwcv.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1803191228240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Mar 2018 14:21:29 -0700
X-Google-Sender-Auth: AiYhJxPhnI-mwwCBJ4i9dK2JWbE
Message-ID: <CA+55aFxSx6xd3yKFQMAoRnjKVj=tgLD=Ui2RRkAe4HRWQ8ohsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core
 binaries to bin/git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018, 04:34 Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This is a real problem.

No it isn't.

We already handle those special cases specially, and install them in
the bin directory (as opposed to libexec). And it all works fine.

Look into the bin directory some day. You'll find things like

  git-cvsserver
  gitk
  git-receive-pack
  git-shell
  git-upload-archive
  git-upload-pack

there, and the fact that a couple of them happen to be built-ins is an
IMPLEMENTATION DETAIL, not a "Oh we should have used just 'git' for
them".

The design of having separate programs is the *good* conceptual
design. And we damn well should keep it for these things that are used
for special purposes.

The fact that two of them have become built-ins as part of the git
binary is incidental. It shouldn't be visible in the names, because it
really is just an internal implementation thing, not anything
fundamental.

> And it is our own darned fault because we let an
> implementation detail bleed into a protocol. We could have designed that a
> lot better.

And by "we" you clearly mean "not you", and by "we could have designed
that a lot better" you must mean "and it was very well designed by
competent people who didn't use bad operating systems".

> Of course we should fix this, though. There is literally no good reason

Go away.

We shouldn't fix it, it's all fine as-is, and there were tons of
f*cking good reasons for why git did what it did. The main one being
"it's a collection of scripts", which was what git _was_, for
chrissake. And using spaces and running some idiotic and
hard-to-verify script de-multiplexer is the WRONG THING for things
like "git-shell" and "git-receive-pack" and friends.

Right now you can actually verify exactly what "git-shell" does. Or
you could replace - or remove - it entirely if you don't like it. And
never have to worry about running "git" with some "shell" subcommand.

And you know that it's not an alias, for example.  Because "git-xyz"
simply does not look up aliases.

So really. Go away, Johannes. Your concerns are complete and utter BS.

The real problem is that Windows is badly designed, but since it's
easy to work around (by using hard-linking on Windows), nobody sane
cares.

The solution is simple, and was already suggested: use symlinks (like
we used to!) on non-windows systems. End of story.

And for the libexec thing, we might want to deprecate those names, if
somebody wants to, but it's not like it actually hurts, and it gives
backwards compatibility.

Btw, real Windows people know all about backwards compatibility. Ask
around competent people inside MS whether it's an important thing.

So stop this idiotic "bad design" crap. Somebody working on Windows
simply can't afford your attitude.

Somebody who didn't design it in the first place can't afford your attitude.

                         Linus
