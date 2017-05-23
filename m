Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2972023D
	for <e@80x24.org>; Tue, 23 May 2017 03:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbdEWDdA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:33:00 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34900 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbdEWDc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:32:59 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so100609301pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=laK00E77btXSgfutCHi+gVdahm9yMriSGP5uco2HsKQ=;
        b=q/UsJrfJYXZXfHAMVistWwjHCFBW/e9imXfD6xJoyTJk0jS3/DfVD50mlhgCsLlwQP
         NvUfQuYbbvd9tuTPaSu1LghVyhaswvzmG98X2YHwKH4tsYfXoM6hS7d+f83nwLjoY0Zn
         Nd2wOwWSUs4JqrPOIGcN1KHK3s+GaaX/5/6DcQ3CG+7E5TFDHGOfwQL8JdGIPxnHtjvO
         VV8HTXEYY59SdaOIrBt8CCJ+Fq9BZtAfNjvX9rilw9MUXGYckdac01Dlx6flrQt0R4RL
         UY0+WXu7GqslxFiXmAI3H5kt73Ve4RzMtdCfnRUzViWezsxY15w1xHlK1+72M1+v1S6O
         auHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=laK00E77btXSgfutCHi+gVdahm9yMriSGP5uco2HsKQ=;
        b=KT7/gxPPtUjvo4Z/2tcPKeXE2GlwkMfYetWNefH2PU5pfnF0LCVmP0YSJyw0C7xepc
         FoByknd23nvOw8byn1aaK2jYjYXgYX4ZWGUOVXEMH/8OgvQbKGE1qnjWL+M4kLVG3o4g
         5A991cRqlqZ4+43qQ5nvmgTAY8nw4IcARwsLmWpzpR7l4Uon01X+fgw6nLOBozC8oJIF
         jn+i9txSPUPgcNsQ8HehRVkhj9NsP/7ZM+V+VFFu/CVX/IDRGFEmINRZ8+xUz18bvVwP
         2ipleVW+PnSF9FdBt7emJcyCuZ2tP4A/39tvnTn5tjdS6iPlbsOnGkMF3HvsD8CcskJA
         k4GA==
X-Gm-Message-State: AODbwcB99R/VQczU50OVXQd5WdyHOHQrcE1B4BMnBpMgV0pVp50C6Lyn
        +HYILQWNSxhrzg==
X-Received: by 10.99.181.11 with SMTP id y11mr28857167pge.54.1495510378480;
        Mon, 22 May 2017 20:32:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id v13sm35210309pgo.44.2017.05.22.20.32.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:32:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
        <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
        <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
        <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com>
        <xmqqd1b1pq1j.fsf@gitster.mtv.corp.google.com>
        <15d73455-6d0e-e67a-7cf3-eb0ae9aa3b0d@ramsayjones.plus.com>
Date:   Tue, 23 May 2017 12:32:56 +0900
In-Reply-To: <15d73455-6d0e-e67a-7cf3-eb0ae9aa3b0d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 22 May 2017 15:02:16 +0100")
Message-ID: <xmqqpof0memv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Having said that, I rarely run sparse over just one file (except
> when fixing a sparse error/warning). On each branch (master->next->pu)
> I do
>
>     $ make sparse >sp-out 2>&1 # nsp-out on 'next', psp-out on 'pu'
>
> ... so that I can diff the files from branch to branch. (I check the
> master branch file by hand. There is a single warning on Linux that
> is actually a sparse problem).
>
> Just FYI, for today's fetch:
>
>     $ diff sp-out nsp-out
>     $ diff nsp-out psp-out
>     12a13
>     >     SP blame.c
>     42a44,46
>     > diff.c:813:6: warning: symbol 'emit_line' was not declared. Should it be static?
>     > diff.c:828:6: warning: symbol 'emit_line_fmt' was not declared. Should it be static?
>     > diff.c:1865:6: warning: symbol 'print_stat_summary_0' was not declared. Should it be static?
>     54a59
>     >     SP fsmonitor.c
>     137a143
>     >     SP sub-process.c
>     170a177
>     >     SP compat/fopen.c
>     276a284
>     > builtin/worktree.c:539:38: warning: Using plain integer as NULL pointer
>     296a305
>     >     SP t/helper/test-dir-iterator.c
>     $ 

Interesting.  One thing that I found somewhat suboptimal is that we
do not get signalled by non-zero exit.  Otherwise it would make a
good addition to the "Static Analysis" task in .travis.yml file.


