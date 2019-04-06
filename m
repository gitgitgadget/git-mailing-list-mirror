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
	by dcvr.yhbt.net (Postfix) with ESMTP id 982C620248
	for <e@80x24.org>; Sat,  6 Apr 2019 19:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDFT5v (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 15:57:51 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42442 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDFT5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 15:57:51 -0400
Received: by mail-ed1-f50.google.com with SMTP id x61so8288255edc.9
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=NMZvMCuxu3qEJeINKVmMsVZNOupZ2lCTDJ6X4IBRCFY=;
        b=o5MeZi6qMZoYhshqBEmHuitrhDPQLMdYE7lKmuqk/+DGMUbSe6zQQe4mAngv13dbv6
         mNoDtXDHvRx67arLplo8CqNnjQwJgL3vf8Rece4mHRUi5LWfCngKcdwWByMjwFzbpJuy
         9smL8F2MxL6mjDnZfCtt7X3/4TFl3g2xgtUbEN1k4ZXq1WC6g66W+q/S/81G4VNXohQv
         BaKj5q9aiMKVAQk3ptdpOcgArkn2qaOmZz+ikuk2B26ZaKSWdQqSIrHvtjtDdTW5UImk
         /g3CMxVo1UPKU6rKohC8/jLxwslxC3Y02YQWBqbgbd19Dh9DA4S5JgXdCqrrvwPqtCcF
         Oqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=NMZvMCuxu3qEJeINKVmMsVZNOupZ2lCTDJ6X4IBRCFY=;
        b=lmwu3X8+qC9MYKBebOcZXlvkKYP0CdBM3cgwspzQk0K/BxgT5WLR+XpvOqEGTPxFLu
         yzHdEl+kPtGj439yhS3raIv72oqGX1muCLgg5CR+M6q6Ev6muAwLTm6FFSpqjSdWTI27
         gnuXcot+WdsOdGgYSew4XJNsRRwyWfmgfiVgTIiXqAlfffhabOShmNdusGLmJR99nMIP
         ivuNM7f4vNaOg3arphwPQxvzkcCUSE2ckB0xpz+3vuvPPD4I2q389NDkai/KMFD3vvIk
         w7+J3AdCKP71jD00pwkOfNWenLerVVGIVC3L77ATnN17lUniA4eyFEJQwYQu8+mM2+op
         p5UQ==
X-Gm-Message-State: APjAAAUrnj5USusAVxj7E6taiRTfHLrhC+Wlm/qlHTUmIgXX4HrQ27r9
        p869cdKDbbD++mBZB6zdlT0=
X-Google-Smtp-Source: APXvYqydu0XkmwIXkyTJ24xx8CIiZqjnYz/bYn855FKK2MeFyf1ktjIrtpXHwDe7brSw2QGYt5beeA==
X-Received: by 2002:a17:906:4ca:: with SMTP id g10mr11428493eja.88.1554580669782;
        Sat, 06 Apr 2019 12:57:49 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z35sm7520694edd.81.2019.04.06.12.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 12:57:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 06 Apr 2019 21:57:48 +0200
Message-ID: <87ef6eaoub.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 04 2019, Junio C Hamano wrote:

> * dl/rebase-i-keep-base (2019-04-03) 4 commits
>  - rebase: teach rebase --keep-base
>  - rebase: fast-forward --onto in more cases
>  - t3432: test rebase fast-forward behavior
>  - t3431: add rebase --fork-point tests
>
>  "git rebase --keep-base <upstream>" tries to find the original base
>  of the topic being rebased and rebase on top of that same base, which
>  is useful when running the "git rebase -i" (and its limited variant
>  "git rebase -x").
>
>  Will merge to 'next'.

Still a bit unclear on whether parts of this are intended or just
emergent behavior, as noted in
https://public-inbox.org/git/87ftquapfy.fsf@evledraar.gmail.com/

> * jh/trace2-sid-fix (2019-04-01) 7 commits
>  - trace2: make SIDs more unique
>  - trace2: clarify UTC datetime formatting
>  - trace2: report peak memory usage of the process
>  - trace2: use system config for default trace2 settings
>  - trace2: find exec-dir before trace2 initialization
>  - trace2: add absolute elapsed time to start event
>  - trace2: refactor setting process starting time
>
>  Polishing of the new trace2 facility continues.  The system-level
>  configuration can specify site-wide trace2 settings (which would be
>  loved by big-brother types ;-).
>
>  Getting closer but still being discussed.
>  cf. <20190403000032.GA190454@google.com>

FWIW also the discussion as of https://public-inbox.org/git/87lg0x9voz.fsf@evledraar.gmail.com/

> * js/trace2-to-directory (2019-03-22) 1 commit
>  - trace2: write to directory targets
>
>  The trace2 tracing facility learned to auto-generate a filename
>  when told to log to a directory.
>
>  Will merge to 'next'.

I had the feedback of effectively "why retry if we can just make the SID
unique enough" in
https://public-inbox.org/git/874l7rcqk9.fsf@evledraar.gmail.com/ on
March 25th.

You seemed to think so, but after Jeff Hostetler made the SID more
unique (AFAICT "actually unique" in practice) in the parallel in-flight
jh/trace2-sid-fix
(https://public-inbox.org/git/4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com/)

I think it's fine to merge js/trace2-to-directory down as it is, but do
you/Josh think that retry logic needs to stay with that sort of SID?
