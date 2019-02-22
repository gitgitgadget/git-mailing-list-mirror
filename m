Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6951020248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBVQuB (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:50:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBVQuB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 11:50:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so3122930wrg.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bZCOLeS7RiVpNgVEbSO1X3DPcXEfZ51aUl715t/pTqc=;
        b=rN1fTlQoNbsnsGaw8eeIiX71ZaN3hcncKEwB5YSTYpRjpA6DzWSGfYGvCEtL5L7aPB
         o+BeOtXL+mIV+Ks3xkIENUPRkVsjnEtIanATMba87YBsxmmhuituosy+0JLxI0jD1e87
         0ElZh6Iq+JdTMZgH3m72hu73MitHptlzUdvxKnA2l0YRnPv9Am2iI5q+RsKNJmruE+FY
         OxabmC2S/6eqY/JswwMlSZYLdgqoM81gb+8mOq8PGttnVAXuY2mn+s6drTZC5oPmuSZb
         fp5CphNkrHyIm3H32mJ1lgRZ/eSxIXLeTEPjKgfQlcwdFOUUmBfaNqk0NjUZv53SO+W8
         GvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bZCOLeS7RiVpNgVEbSO1X3DPcXEfZ51aUl715t/pTqc=;
        b=jwsTsqIa360uG7LnRkTJqdFTYfB13giHQC2pNQHrNwHoOuOfbfmtRX4rlSKn5spGJF
         Pp79rel3eB1h84E0w6Tx4I+IGY/ewxzgaFBldcqRXq7ksu/QqdCmQo23S/lWFIBczjNC
         vKg7RMmtQCapAp5uShHIalB0WhzlO7Yvdo0cH9V+QYyHJ7IkYTvbkpVIukQ2HXS9AJy8
         eaEh5vcvl0yTIrX/bVi/wk44tMZSsw62JoJqq6FxZMiHcbF62l/r1L9FiPhJAb4BJ7Xa
         XakeBoq1Wgr5pEHtGhjY7UgIeP4mifJDmJPuuapKWd8KzJMk60cOoDDvPEWcrPGV6rNo
         oC4A==
X-Gm-Message-State: AHQUAublsEWk6El/bHLaZ+vLhjti3ioQp/M/9VYkdsrhGFVMTviW/rdb
        DnzPgap0ZB+mrq8YwvWwC/lYVAnX85E=
X-Google-Smtp-Source: AHgI3IYsukr2W+jnscaPnu+NWuNAU8EJ1mYzYbWLRHMBQstnp2J70OgYkSA7URz+IZqWmvAkBCfWWA==
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr3597197wrs.20.1550854199242;
        Fri, 22 Feb 2019 08:49:59 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n6sm1999193wrt.23.2019.02.22.08.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:49:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 2/2] rebase: don't rebase linear topology with --fork-point
References: <20190221151009.GA24309@sigill.intra.peff.net> <20190221214059.9195-3-avarab@gmail.com> <20190222150852.GB5090@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190222150852.GB5090@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 17:49:57 +0100
Message-ID: <871s3z6a4q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 22 2019, Jeff King wrote:

> On Thu, Feb 21, 2019 at 10:40:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Fix a regression introduced in 4f21454b55 ("merge-base: handle
>> --fork-point without reflog", 2016-10-12).
>> [...]
>
> OK, your explanation mostly makes sense to me, except for one thing.
>
>> Then in 4f21454b55 ("merge-base: handle --fork-point without reflog",
>> 2016-10-12) which introduced the regression being fixed here, a bug
>> fix for "git merge-base --fork-point" being run stand-alone by proxy
>> broke this use-case git-rebase.sh was relying on, since it was still
>> assuming that if we didn't have divergent history we'd have no output.
>
> I still don't quite see how 4f21454b55 is involved here, except by
> returning a fork-point value when there is no reflog, and thus
> triggering the bug in more cases.
>
> In particular, imagine this case:
>
>   git init
>   for i in $(seq 1 3); do echo $i >$i; git add $i; git commit -m $i; done
>   git checkout -t -b other
>   for i in $(seq 4 6); do echo $i >$i; git add $i; git commit -m $i; done
>   git rebase
>
> With the current code, that will rewind and replay 4-6, and I understand
> that to be a bug from your description. And it happens at 4f21454b55,
> too. But it _also_ happens at 4f21454b55^.
>
> I.e., I still think that the only thing that commit changed is that we
> found a fork-point in more cases. But the bug was still demonstrably
> there when you actually have a reflog entry.
>
> With the fix you have here, that case now produces "Current branch other
> is up to date".
>
> This is splitting hairs a little (and of course I'm trying to exonerate
> the commit I'm responsible for ;) ), but I just want to make sure we
> understand fully what's going on.

Yes. I didn't dig far enough into this and will re-word & re-submit,
also with the feedback you had on 1/2.

So here's my current understanding of this.

It's b6266dc88b ("rebase--am: use --cherry-pick instead of
--ignore-if-in-upstream", 2014-07-15) that broke this in the general
case.

I.e. if you set a tracking branch within the same repo (which I'd
betnobody does) but *also* if you have an established clone you have a
reflog for the upstream. Then we'll find the fork point, and we'll
always redundantly rebase.

But this hung on by a thread until your 4f21454b55 ("merge-base: handle
--fork-point without reflog", 2016-10-12). In particular when you:

 1. Clone some *new* repo
 2. commit on top
 3. git pull --rebase

You'll redundantly rebase on top, even though you have nothing to
do. Since there's no reflog.

This is why I ran into this most of the time, because my "patch some
random thing" is that, and I have pull.rebase=3Dtrue in my config.

What had me confused about this being the primary cause was that when
trying to test this I was re-cloning, so I'd always get this empty
reflog case.

> Your fix looks plausibly correct to me, but I admit I don't quite grok
> all the details of that conditional.

We just consider whether we can fast-forward now, and then don't need to
rebase (unless "git rebase -i" etc.). I.e. that --fork-point was
considered for "do we need to do stuff" was a bug introduced in
b6266dc88b.
