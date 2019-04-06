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
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D2D202BB
	for <e@80x24.org>; Sat,  6 Apr 2019 19:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDFT2Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 15:28:25 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33658 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFT2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 15:28:25 -0400
Received: by mail-ed1-f45.google.com with SMTP id q3so2914854edg.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=etBxy6CaHJb3TX4Zh3SzMIChxeHB2lInUr0Q+P3wjS0=;
        b=kavsAx4M/6H3hvoF81Id/QubLnvuvu9h99EZfNwsT5hwfrUxHR7hazBKu4rRTGDbGt
         jZgQCKQHWx9wJnS+U/PoWlzFN79gPhXlKZTr+cYBHPi4BH2HuRnuJCtI26WdWvY2GjGZ
         mHb3i8KhZnSlDpaxSoOYg/Yw1kTqrtjWcSuM66A2UxhcaE804atWobdJF7dpCSnljd9o
         4/PfD2Z49r3T8dPx7zhq2muXYl6wj4xvnRoE9TVSFkNLgad4BU4G4l5f79K5E3sl5u4i
         INP5+F9jivf5BxT7j9l+r4bgmj5r838B2TFcpGvkRlOoUlEi4htX8pmeDW9LAT8/tJVT
         GFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=etBxy6CaHJb3TX4Zh3SzMIChxeHB2lInUr0Q+P3wjS0=;
        b=jin+xgH2EC10VRCbZt+zrdSHnEVhNCvLgzwDQGjLAtmiP1eRUWOQ9tx+RJtKkBn4Vq
         ZdtyCdXYPbngGKluOBc8OZtyrR0UC95W5x9gwzRcDpsNb8hSWFPwlkxLH8zoBxeF7htC
         LzaZD6ZjUDaimBj95iOSC7mm0gmhSYWg/jxmaE00NhUrBecTccU/R55wwJqTybh8jWz1
         a3g5QqrxoCW97C+TdGYrXbpMOkCRb/VUQZjgp24DYZHK9tXDO8r5iQ4x0gUN3YRYRSsg
         u8zmFvEx5XIZIqeTLZu6dPlkJ7R4ljrzDehwstiUGK0LQ/zRFaLeOloSlB4CwYe8RdXB
         Mklg==
X-Gm-Message-State: APjAAAUHAfp6fbDZAUpdpICAXXVf/CORHhHJ3tJhQe/j9nZEal0i+dZH
        g54SiAFQ+qXziTkI17TvLNQU6mjr
X-Google-Smtp-Source: APXvYqx3YEMNv1XshcVjMGw1I1u2V/LE1cxL/8PpRsdBeLRsYr3Y1RZ0JBrq2yZcRNmHEjARxvMAiw==
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr11437720ejb.32.1554578903445;
        Sat, 06 Apr 2019 12:28:23 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id l20sm5374085edd.96.2019.04.06.12.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 12:28:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 06 Apr 2019 21:28:22 +0200
Message-ID: <87h8bb9bmx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 04 2019, Junio C Hamano wrote:

Just comments on ab/* stuff:

> * ab/gc-reflog (2019-04-01) 7 commits
>  - gc: handle & check gc.reflogExpire config
>  - reflog tests: assert lack of early exit with expiry="never"
>  - reflog tests: test for the "points nowhere" warning
>  - reflog tests: make use of "test_config" idiom
>  - gc: refactor a "call me once" pattern
>  - gc: convert to using the_hash_algo
>  - gc: remove redundant check for gc_auto_threshold
>
>  Fix various glitches in "git gc" around reflog handling.
>
>  cf. <20190328161434.19200-1-avarab@gmail.com> (v4)

Missing a "will..." note for this one, the "cf" is just the cover letter
for v4. AFAICT it should be ready to merge down from "pu".

> * ab/gc-docs (2019-04-01) 12 commits
>  - SQAUSH??? fixup! gc docs: include the "gc.*" section from "config" in "gc"
>  - gc docs: remove incorrect reference to gc.auto=0
>  - gc docs: clarify that "gc" doesn't throw away referenced objects
>  - gc docs: note "gc --aggressive" in "fast-import"
>  - gc docs: downplay the usefulness of --aggressive
>  - gc docs: note how --aggressive impacts --window & --depth
>  - gc docs: fix formatting for "gc.writeCommitGraph"
>  - gc docs: re-flow the "gc.*" section in "config"
>  - gc docs: include the "gc.*" section from "config" in "gc"
>  - gc docs: clean grammar for "gc.bigPackThreshold"
>  - gc docs: stop noting "repack" flags
>  - gc docs: modernize the advice for manually running "gc"

That squash makes sense. Will submit another version with it integrated.
