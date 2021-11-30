Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72A1C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbhK3VOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240426AbhK3VOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:14:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A5C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:11:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so92383721eda.12
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7vm1iR3VBgXlbbeK9bVyGD0OSHAobKnpFdaVpK2u3f8=;
        b=IT30zUs8anX+s5wbiQVafmz6Wsrn32YMk3VSBKCYwjAT9SRDrfPEJbly6Svl9A8S1Q
         gt7QCNxup2YRBwKfIcGSuPNQBBkbzV6D8tKUc+ojAhnpr5yka1ZIQKam0fAPqzwv64DR
         ezxhFYdqYeViw4fDeg2qFO6gKJIcwTSue5XEQ/9ILcoYMRPTOtzm42SZznDBkrI1E0X8
         p+EqSEAakeFSyvSdKwTlpEBegcALjgAM5rrUI+09315xAKdhQJIMUFiRpYBfyZ8o+gf9
         TpcF91ebL/zbWEj3tTEPMO8ozhCpUQ3dDCtFOSGj5LSX7rI6jzZkthsdV8AqttSpQRqw
         gl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7vm1iR3VBgXlbbeK9bVyGD0OSHAobKnpFdaVpK2u3f8=;
        b=MY5IkcP1PkInXV9p0dpg2agyv8k6Lpo99E/iQzampo8gY70YV4Zy/TLU/tEKEO2k3+
         B+cXPDD49J2msvW27SFX1ITJsjRtLBxaqEaA+/Qv1YVFnzvRawUxCQioarFSF/wJaGgn
         8wOEbzZv8nI0QeMT3Ece/R3S8ogXtuAQWQIux0I329DOw1pH5dyT3E/VQSldzQy1hqse
         Kp+oCcgiyL4aDelXVyX19Cu1ECBlBQn+n0qG6GH/3eB1ZsLo7735glLkAeI1q0VaL9qe
         S+WwRn2C8OG6gxWZD71UCfWSFZOGYsnVfE6HmFKcXKJw9jtst3dPqI0W/Bs3mGBjkNG/
         jvJQ==
X-Gm-Message-State: AOAM530wkLTSlydtGrhl/8LiB7Qmt3LjLd0X1R57pAltAb2XLwEAVtOi
        Oi6dzlUZxqTQn5P5+gn96yQ=
X-Google-Smtp-Source: ABdhPJyHTJICnJ8JJzHg378igJHTUQ6iryqpzoec+AxTujPupGrey2af871ejpk6/5AKo6a5QFrQJQ==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr2011850edb.345.1638306688284;
        Tue, 30 Nov 2021 13:11:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e1sm9122620ejy.82.2021.11.30.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:11:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msAPP-0019zu-8H;
        Tue, 30 Nov 2021 22:11:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: ab/ci-updates (was: What's cooking in git.git (Nov 2021, #07; Mon,
 29))
Date:   Tue, 30 Nov 2021 22:08:05 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqzgpm2xrd.fsf@gitster.g>
Message-ID: <211130.86fsrdcps0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Junio C Hamano wrote:

> * ab/ci-updates (2021-11-23) 5 commits
>  - CI: don't run "make test" twice in one job
>  - CI: use "$runs_on_pool", not "$jobname" to select packages & config
>  - CI: rename the "Linux32" job to lower-case "linux32"
>  - CI: use shorter names that fit in UX tooltips
>  - CI: remove Travis CI support

It looked like there was general happiness with the approach of having
the dead code gone and the GitHub tooltips being more useful.

Given that this is relatively trivial, and if it was causing trouble
we'd likely know by now it would be nice to get this merged down sooner
than later.

As noted in the latest thread on js/scalar there's outstanding
interactions with that larger topic (including some semantic merge
"conflicts"). So having it in "master" to base on would also remove its
interaction with that topic & any other CI modification as a variable.

1. https://lore.kernel.org/git/211130.86mtlleqhm.gmgdl@evledraar.gmail.com/
