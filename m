Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680071F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeC1RMo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:12:44 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35806 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeC1RMn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:12:43 -0400
Received: by mail-wm0-f52.google.com with SMTP id r82so6775508wme.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sr38UMbPX5p5Mc2G8mITFuYwu5CyDDrPS7H1wKl2lwU=;
        b=eM3O40ScB3aG0/E/Wrqp9GGv8KwKNCLMQN7hknsiO7jeZtFmcaC7v6WDVssHsyofVg
         Av/bkOcaxWelHq4iCkiP2RKZvQ/yUMl6WLspr8T/tdr7SgcvZlgsunDZgbO6HCtVjsNe
         H1D+2JK45OzRrsH4YpmqhXLeyO6KFmStbx3Y0j3piDuMBTD5yhRZHfBcDY0Ak7Gao7TA
         unIvPYPWKRI5X183EYRYwzmh7Y0CgmUn+I6xmHRaiPLjYF/yYDaDiSLQ9Y4LRkjakvNh
         lITmERFC184QARmfZY77kTOTTAy9EMTxWqL+3oMZBTwBszPZFeMUR6rMVc1wXWp7GCek
         FH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sr38UMbPX5p5Mc2G8mITFuYwu5CyDDrPS7H1wKl2lwU=;
        b=ZLIW8T+tUN9ZVul2B08ilQN/x9P/4eEvUTk8yHiVCeWQln/cnC91U01GSJe5VIjv96
         Wa/keH/2DdA/N08FNA3Gh3UjkaCE7E14C5lWENeP0o2yt90WWSvMec+ON23J7yKGYbI+
         r4HxDoQE4wlZ2dtJDsu845gbBUOmS1/oX8D+BZntjr2+sY9yyGWQnlCuybkad6c3WCrQ
         9+BhLHqriRmq6796AFqZt5/N/IoSGJVrMr468+smTJs0W6bmqIWuMJN48r2yfDBWKo9/
         p251P0XonbUuRrx2o/6i7MB7unD377sD3IzOtRqbCR2sSoceNdX3IfpyIW2j1jm1Ek0n
         6OiA==
X-Gm-Message-State: AElRT7FutLasSkjB8UwpCHjdF27fYpn5ZlinQmGlygu4SspBmAz9C4LM
        +PIvAcW6iinJtDmDUVYXaSftLKob
X-Google-Smtp-Source: AIpwx4+y9YANLUONBqiopD5f/WVpJI4FE5pK/bLyTHo318/KiHDpKuOpRaxgwOZbB7vAL87G1IrHqg==
X-Received: by 10.28.9.81 with SMTP id 78mr3157425wmj.23.1522257162062;
        Wed, 28 Mar 2018 10:12:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q21sm6649169wmd.12.2018.03.28.10.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:12:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX design
References: <20180325205120.17730-1-dnj@google.com>
        <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com>
        <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com>
Date:   Wed, 28 Mar 2018 10:12:41 -0700
In-Reply-To: <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com>
        (Daniel Jacques's message of "Tue, 27 Mar 2018 16:05:32 +0000")
Message-ID: <xmqqa7us86pi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Jacques <dnj@google.com> writes:

> A simple grep suggests that the current test suite doesn't seem to have any
> RUNTIME_PREFIX-specific tests. When I've been running the test suites, I've
> been doing it with a "config.mak" file that explicitly enables
> RUNTIME_PREFIX to get the runtime prefix code tested against the standard
> Git testing suites.
>
> From a Git maintainer's perspective, would such a test be a prerequisite
> for landing this patch series, or is this a good candidate for follow-up
> work to improve our testing coverage?

It would be a nice-to-have follow-up, I would say, but as you two
seem to be working well together and it shouldn't be too involved to
have the minimum test that makes sure the version of "git" being
tested thinks things should be where we think they should be, with
something like...

	test_expect_success RUNTIME_PREFIX 'runtime-prefix basics' '
		(
			# maybe others
			safe_unset GIT_EXEC_PATH &&
			git --exec-path >actual
		) &&
		# compute the expected value -- we know the first
		# element of $PATH is where we find "git", so things
		# should be computable relative to that, perhaps?
		echo >expect "${PATH%%:*}/..." &&
		# then compare
		test_cmp expect actual		
	'

so I am hoping such a minimum test to be in the series when it
graduate to 'master' and become a part of a release.  

On the other hand, "make a whole test install and try running it"
may actually be easier but that probably can be done using existing
GIT_TEST_INSTALLED framework?  In short, you would probably do

 - make RUNTIME_PREFIX=YesPlease
 - make RUNTIME_PREFIX=YesPlease DESTDIR=...some..where... install
 - GIT_TEST_INSTALLED=...some..where.../bin make test

or something like that.
