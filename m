Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D38E1F42B
	for <e@80x24.org>; Mon, 25 Dec 2017 00:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdLYARa (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:17:30 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35557 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdLYAR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:17:29 -0500
Received: by mail-wm0-f53.google.com with SMTP id f9so30355455wmh.0
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GOvbAnZn6lCaFAi6YQBipV/cbIs9oUPv4lN3vFgaGfg=;
        b=uPxpms41lmBDBjS7fdrZPf3Jr3Ck4GjHRhNDrzuNhxSpmADQaKO5nP4LJ1ktbZYRYq
         IrwSo8n2lHZVU7uwByn1D3hhz3VR2RhoLDBqNtfWyQwcA9qgF1AXPy33W06A8tbrc2P6
         rIooMO/3ZATewnfR3aHo51It5sops9AHgRfXPGoAZXbVosLQZ8p0csg2nOjpM+2UdaAM
         bxvgCZNH8K6wOJ/mjd7oC/5Afv+cTe8GuI3ZQD7wGddga93v4xTfLv8JfvJ74UBcxdWj
         qagQyiKpKc71irgbINxdAMvbxSCwGdQaCDilFqR5SWT0+22hYrLKa8c5BsJ5fh1RfK+9
         /oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GOvbAnZn6lCaFAi6YQBipV/cbIs9oUPv4lN3vFgaGfg=;
        b=JuEN/SfthRGeCSTS+te4DRZDm7TJmB2uQvM9KGHfcrTYs1UfBb7EEjfgZE62ljw7eZ
         juf+MRtIGF3UtFGWDD9sZ5qsRZ/p2GobR1qsAozu/oJpL6bAC6WO8b6Kdqhsbe2B5lP1
         V6fSPw8j7aEHns3c7JI7vzPX3Eb5ll8UNwixPg3R/gHjegV8X32l90ibEtJL1/FninoV
         Yd6JyOrGjPYbpgf8bKY/Cvz7irgL311DEY+QK6APbaxMH1O/qbyELPWMeJOFmcmOERUf
         7201ST3b3tWE3yeIpVC92CG47G/zp7Tay78rwSa5qPege+VdvtvuAw+6zYm7B/u6Pmff
         r9hQ==
X-Gm-Message-State: AKGB3mLCU8y8GN1IShzi3QycqXzIzB7FojElSEebMBSQRUP/0EwCpat4
        OknB5MbHmvB3gC6aaLqEDIE=
X-Google-Smtp-Source: ACJfBov/96UvFP0E3PJvcnzLB6htTGVuK9dlY0pjvMdDdCJSwuOAhT801zykLKsjjeiLTF4tnIrkrw==
X-Received: by 10.80.165.139 with SMTP id a11mr25256480edc.95.1514161048236;
        Sun, 24 Dec 2017 16:17:28 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y28sm22437771edi.95.2017.12.24.16.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 16:17:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
References: <20171223174400.26668-1-avarab@gmail.com> <20171224143831.GD23648@sigill.intra.peff.net> <871sjkrtrm.fsf@evledraar.gmail.com> <20171224230839.f6r66u37wj4ai3sj@untitled>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171224230839.f6r66u37wj4ai3sj@untitled>
Date:   Mon, 25 Dec 2017 01:17:25 +0100
Message-ID: <87y3lrr78q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 24 2017, Eric Wong jotted:

[Removed Petr Baudis <pasky@suse.cz> from CC, his suse.cz E-Mail address
is bouncing]

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Sun, Dec 24 2017, Jeff King jotted:
>> > As far as this actual perl change goes, I don't have a strong opinion. I
>> > agree it would be nice to eventually move forward, and your reasoning
>> > about what constitutes "old" seems sane. But we also don't write much
>> > perl in this project these days, and I don't see a lack of modern perl
>> > features causing a lot of headaches.
>
> Agreed.
>
>> Yes, unlike with the curl patches it's not a big PITA to maintain
>> compatibility with 5.8, it would just be easier to write new code &
>> maintain old code and not have to be on guard about not using features
>> one takes for grantend, and maintain compatibility with 5.8 versions of
>> core modules.
>
> As one of the more frequent Perl users here (even outside of
> git.git), I never considered using 5.10+ features at all until
> now.  Maybe 5.8 compatibility is just too ingrained into me and
> much of the stuff I work on is old and ancient(*).
>
> That said, reading perl5100delta does reveal features such as
> defined-or and given/when that I might find useful; but I'm also
> not going to replace existing code to use new features unless
> there is a clear improvement.
>
> If there's new code people are developing using 5.10; I would
> not object at all.  Otherwise, I don't see compatibility with
> 5.8 hurts more than it helps.

Aside from whatever we do here, I don't think this would be a good idea
& would introduce a lot of confusion for packagers, e.g. requiring one
version of OpenSSL for hashing, but another one for "imap-send", or one
version of curl for "push", and another for "imap-send".

I think for any given external dependency of git.git it makes sense to
just pick a version, not say that this script requires perl so-and-so,
this one python so-and-so, or curl/openssl so-and-so etc.

> Maybe we change our docs to say we welcome 5.10 features for new
> code, but I'm against changing things for the sake of change.

I should have mentioned this in the commit message, but for me it's
mainly that whenever I patch the Git perl code there's no easy way to
test if it works on a currently supported release, 5.8.* doesn't even
build anymore on a modern compiler without monkeypatching with
Devel::PatchPerl (and then only some subreleases).

I think it's reasonable for us, in general, to at some point pass the
buck in maintaining dependencies to people who want to still build on
ancient versions. And not just for perl, but e.g. curl too, which is
something I commented on at some length in <874ltg2tvo.fsf@gmail.com>
(https://public-inbox.org/git/874ltg2tvo.fsf@gmail.com/). I.e. if you
need to really build the latest git on RHEL 5 with all bells & whistles
you also build perl.

It's not just change for the sake of change, there's a high cognitive
overhead in trying to write code against the last 15 years of some
software as opposed to "just" 10 years (which is already bad enough).

Of course any one change isn't going to be what makes it or breaks it,
so it's hard to make the argument in terms of "I must use this new
feature here". But if that was the standard we were applying we'd still
be supporting perl 5.6[1].

1. If it hadn't turned out that it was broken for years because of using
  a new feature, see d48b284183 ("perl: bump the required Perl version
  to 5.8 from 5.6.[21]", 2010-09-24)
