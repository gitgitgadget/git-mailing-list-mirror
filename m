Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345F91F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 10:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeKPUuI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 15:50:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37475 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 15:50:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so10124750wru.4
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 02:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NxGiTTnBl4zGxwKRFOhnoMmUpVYIaNujYEiuM5lNyfw=;
        b=lNg94N89h0p/kHrak0Uxgf7SanGp90auadY4oIMsjiJK/WiyUzsZh/F5odk4pZddmV
         vVyvS/ZaQxsZkwIDEgvUaDIWyJvoMNKcGgffCxBEUtfJ0Jvfcn6LlmsTWp/Lnl9HPxxy
         HRKyxe6vA3E9P8Giu4VhR9TCsOBjoTN74nTcKePnevvfctHGN7AB2aoOPr9egpZZ8Eaq
         CQE8wfjzIDqA1s3MdyUJzcGAdeOVVsR6TJjGXWIJDm/IyHTLJ3EbtfsGJ1SjNzBfbPyH
         PIEndzdQ1mLcTPXYcVck+U8u4Th2QR94IikSgFubIIHChPYGplWLMEccK3QeNY5+8qdP
         MWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NxGiTTnBl4zGxwKRFOhnoMmUpVYIaNujYEiuM5lNyfw=;
        b=rNGvyxBteZ5KZV1mzCJqMD3KOJraB7XLzkyeLlp3ANf0ywoBZs4ZbXyFOIJ6kgchJ5
         CL9fq7v75NrWhUOm4owdLX19mD//c+H5O/PsvM2gLHW5VX/nj00Em6UIox66wPkgJryI
         C1qQYiKq4e53iUs7scRC9dhedTCrNqQG69UFZVzZ/1p8rl/5K8tQG3HZjc2YjD4OxQ/s
         fQacMofKI76dUMbIIH6F391NGghS2TwioNT9EW8pzPljR3Xuz6FwGsbty6FeUersjsWb
         MuSioDqlFZ6Q2xBtcCFeDi1D8u6be9hcYOR1qyjivFTY908OIfZAKDTQ7Yyi5a5aRsfN
         YYGQ==
X-Gm-Message-State: AGRZ1gJCe3Fsmbk5bbR66sIW2fcaK7iHrbLwKP8i4KoAf+jcHmgG1vl7
        RUOwg6FOIfAfvyIMhpHpUbnIyhdm
X-Google-Smtp-Source: AJdET5eMa6de7eKayI8l2iaAjFzWUhH+us/rZCn3DOz+etcIq3DxhxRJHwlEiapvNLcvGtOXemuqzQ==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr9299943wrm.115.1542364700587;
        Fri, 16 Nov 2018 02:38:20 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id i7-v6sm30207653wrb.3.2018.11.16.02.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:38:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like "git-init"
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181102223743.4331-1-avarab@gmail.com>
Date:   Fri, 16 Nov 2018 11:38:18 +0100
Message-ID: <87k1ld1f51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 02 2018, Ævar Arnfjörð Bjarmason wrote:

> I think up to patch 4 here should be near a state that's ready for
> inclusion.
>
> Although I'm on the fence with the approach in 1/5. Should this be a
> giant getopt switch statement like that in a helper script? An
> alternative would be to write out a shell file similar to
> GIT-BUILD-OPTIONS and source that from this thing. I don't know, what
> do you all think?
>
> The idea with 4/5 was to make this symlink mode the default in
> config.mak.uname and have a blacklist of systems like Windows that
> couldn't deal with it.
>
> Since my ad874608d8 ("Makefile: optionally symlink libexec/git-core
> binaries to bin/git", 2018-03-13) I see that e.g. Debian and GitLab
> have started shipping with the INSTALL_SYMLINKS flag, so making that
> unconditional is the next logical step.
>
> The 5th one is more radical. See
> https://public-inbox.org/git/87woyfdkoi.fsf@evledraar.gmail.com/ from
> back in March for context.
>
> I'd like to say it's ready, but I've spotted some fallout:
>
>  * Help like "git ninit" suggesting "git init" doesn't work, this is
>    because load_command_list() in help.c doesn't look out our
>    in-memory idea of builtins, it reads the libexecdir, so if we don't
>    have the programs there it doesn't know about it.

A follow-up on this: We should really fix this for other
reasons. I.e. compile in some "this is stuff we ourselves think is in
git".

There's other manifestations of this, e.g.:

    git-sizer --help # => shows you help
    git sizer --help # => says it doesn't have a manpage

Because we aren't aware that git-sizer is some external tool, and that
we should route --help to it.

Non-withstanding the arguable bug that things like git-sizer shouldn't
be allowing themselves to be invoked by "git" like that without
guaranteeing that it can consume all the options 'git' expects. When I
had to deal with a similar problem in an external git-* command I was
maintaining I simply made it an error to invoke it as "git mything"
instead of "git-mything".

>  * GIT_TEST_INSTALLED breaks entirely under this, as early as the
>    heuristic for "are we built?" being "do we have git-init in
>    libexecdir?". I tried a bit to make this work, but there's a lot of
>    dependencies there.
>
>  * We still (and this is also true of my ad874608d8) hardlink
>    everything in the build dir via a different part of the Makefile,
>    ideally we should do exactly the same thing there so also normal
>    tests and not just GIT_TEST_INSTALLED (if that worked) would test
>    in the same mode.
>
>    I gave making that work a bit of a try and gave up in the Makefile
>    jungle.
>
> Ævar Arnfjörð Bjarmason (5):
>   Makefile: move long inline shell loops in "install" into helper
>   Makefile: conform some of the code to our coding standards
>   Makefile: stop hiding failures during "install"
>   Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
>   Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES flag
>
>  Makefile         |  65 +++++++++++--------------
>  install_programs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 38 deletions(-)
>  create mode 100755 install_programs
