Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D89C1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 12:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfBLMNk (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 07:13:40 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36590 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfBLMNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 07:13:39 -0500
Received: by mail-wr1-f45.google.com with SMTP id o17so2440216wrw.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 04:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0Xu6pMXRueqoCB6323wvlsi7SlKmn8AHMRuK/Z+yiMo=;
        b=qWAH7FMEyGd1hd0EafbWUCoKShAVSh9xQu1rDdGVRKjWGNF9QWngmLq759vqHZ463/
         0ou/qIg2VT6w0G+VHUizjeJ77VM+rnWFYj4uqquNk/EBNVJTgVSmJ1A90D6REQpTH1sG
         JhvxpAuSR3zqBzhLYlwusYHHgzxfK9Plgcxvw6MyeZ6ilOwlDA4py+XDvswtcrzuo1mi
         dtazNdW8jgoBrAi/sM7ke7hSUa/HkpZ5RkWqBilvDNBwoQCGqrC10Fis3I9BpANnpxwg
         13D/OuOiuhORh+S6n1v+6lsPDNx9T7LwHJyPlR3Wz88b4FWkxFgknBlZMerFX5bNh4w2
         OTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0Xu6pMXRueqoCB6323wvlsi7SlKmn8AHMRuK/Z+yiMo=;
        b=VwnsgkchuSDBua3G/rQrBhCgEjQe11IY+2ILARMLNj+6AetzuWGrW2VxkAjt7X3r7W
         SrkBXNXwSs1Wz95d85v/50l1MXf1cQYfiwsgshXLTanccXVgMcfXwgvWVBb0TrtuKSit
         zweGVyTprcnWdVCWleI4B1nMutaQnUv+Tbe5mQ8Xr4TgHplPrM1gH1SVLqYp8Yc/rew0
         yd1hxL7/TxTAj3xd5UQ6dmRcbRbErQJgzFq6NkNtUKA5j7plgsD5cwrAuTj1r/w4U4H2
         mx/iyVbELe26ShzDkgrvCTvh5LrwbkfBNIcYDHpGzjVDzqA6D0zyTAFH1kiM+cfbaAa/
         zDGA==
X-Gm-Message-State: AHQUAubz69kaSGrQPfeE5ToXgXA0+EYrsa6Pk17RyN+bcuNGkGnoZM6x
        MbeNNbNa8VoF5Gy9XQP+vIA=
X-Google-Smtp-Source: AHgI3Ibi6wPHUQdgK0oKRQvdxtsb5pAXArzCCXl+K6YCDFV0KlExCWFG5UiqkKtSJnbGPXXHfPP2RQ==
X-Received: by 2002:adf:f145:: with SMTP id y5mr2830405wro.240.1549973617864;
        Tue, 12 Feb 2019 04:13:37 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id b12sm1773728wmj.3.2019.02.12.04.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 04:13:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 12 Feb 2019 13:13:35 +0100
Message-ID: <87sgwtjjbk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 07 2019, Junio C Hamano wrote:

> An early preview release Git v2.21.0-rc0 is now available for
> testing at the usual places.  It is comprised of 426 non-merge
> commits since v2.20.0, contributed by 57 people, 13 of which are
> new faces.

As seen on https://gitlab.com/git-vcs/git-ci/branches there are
regressions since 2.19.0, e.g. we have hard compile errors on BSD now,
and maybe AIX. I haven't dug into it.

I probably won't have the time for this myself before 2.21, but am
sending this message in case others are interested. I don't expect these
to be serious issues, just portability nits that'll either be fixed
before 2.21, or alternatively by people packaging for those
platforms. If they don't care enough to pursue it pro-actively I'm not
very inclined to spend time on it myself...

Johannes: We didn't have a chance to finish this conversation up at Git
Merge, but the useful bit of CI platforms basically devolves into
test_for(SHA1, params), with the hard part driving it so it's done
constantly, N branches are tested with smart notices of "XYZ broken in A
but not B" etc.

My impression is that you're *way* ahead with the Azure stuff for
solving those hard parts. Is there any way we could ditch most of this
ad-hoc GitLab CI setup I have on the GCC compile farm, and make it be
driven by what you have, and at some point it would just do something
like:

    ssh <some compile farm host> "compile-and-test.sh SHA1 <params>"

Then we could all display it in the same UI, and get feedback on "pu"
topics before they land et.c
