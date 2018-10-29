Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEA61F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeJ2MXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:23:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeJ2MXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:23:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so982177wmh.3
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CkRPf9y99inDQkyrG85V8msMgp9wqoymf/fkplJxiWU=;
        b=jIeHK4NzUfIZPfJ48TGmO0yFVS/oisyuWGAuOlLLLbjixA72eaMW1ejZu8dthEGXZY
         6zvksL12F2j1q5m/nIWcDNDcp53Os8yEdlZLID3WJo2kYULuQn76eQdjjuoncL5w5CQ8
         AT/lOGSEJqeIaju3QGOa5aEVGUP8fzC+uynVqGFk6kzBuverYNgc/dX3gqo49yijEZSa
         0mifwfQd3oi72hcYu/CYR+3hTXfogUh9XktLVnhpxopsJPCLDayYKgx3363QA8rctnOi
         AeblV/Ci10woOClJDu6jXxJ4/dMTsUOo+JtCPqmt+uYFyE6Xi4uocEWmJLcLWzDWMftH
         LX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CkRPf9y99inDQkyrG85V8msMgp9wqoymf/fkplJxiWU=;
        b=DHyMGvpLC83GcAxGJ1/cJew3zv/MbxEwiyxKDbq3vyxIHBSRSUZzM1AICmvV7QBNkZ
         vyG+TPlmX5UKkMNzb4JyriePCMSz4XLB0rzorHGdRS+jZXddWBxNa9KIEt+tfaw4sQVH
         vGDpL4Du9zkthxwvz3wTiiTQKLSLJVbSrR/6dYTig8D9nKGhVaxXt7nECysQJtB7y23e
         ovcDMH6XCMz1MQnjPil1fV6qKGft9iOwQazFRumL2AGNZV9AGxhQPAK+xP8n4ImLv2y7
         HaFE+VdyxqttEKKVNir/rq8VKVKxU/kpw9k0dB0kb/saO412SjhTdIbD9V9GKKXDQ5ju
         zrGA==
X-Gm-Message-State: AGRZ1gIZOepl+6y8frW8yN/yE0CexjIoeurujlYOJPpq/oE6jPtXkSZb
        xTE0ztEKOx6SmhUIMk5L55Y=
X-Google-Smtp-Source: AJdET5dxnZnbDBNAhh0YL8kESFTx8/rYmnIUS+LB7123XXs6B0cQ+X7QbgUj671VUHwEoOVs2dCPJA==
X-Received: by 2002:a1c:f417:: with SMTP id z23-v6mr12697704wma.80.1540784217772;
        Sun, 28 Oct 2018 20:36:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r2-v6sm11359760wrq.1.2018.10.28.20.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:36:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t7405.17 breakage vanishes with GETTEXT_POISON=1
References: <CACsJy8B=gxVMrZnr-BNp=VCHea8wpx+GCE4N76=vSGMnX2rSbA@mail.gmail.com>
        <20181028121517.GO30222@szeder.dev>
Date:   Mon, 29 Oct 2018 12:36:55 +0900
In-Reply-To: <20181028121517.GO30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sun, 28 Oct 2018 13:15:17 +0100")
Message-ID: <xmqqzhux77ag.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The test in question runs
>
>   test_i18ngrep ! "refusing to lose untracked file at" err
>
> which fails in normal test runs, because 'grep' does find the
> undesired string; that's the known breakage.  Under GETTEXT_POISION,
> however, 'test_i18ngrep' always succeeds because of this condition:
>
>   if test -n "$GETTEXT_POISON"
>   then
>           # pretend success
>           return 0
>   fi
>
> and then in turn the whole test succeeds.

Ah, good spotting.

If a test using "grep" declares that something must not exist in
plumbing message, it writes "! grep something", and because
"test_i18ngrep something" always pretends that something is found
under poisoned build (by the way, would this change when we remove
the separate poisoned build?), "test_i18ngrep ! something" must be
used for Porcelain messages to say the same thing.

Of course, this has a funny interactions with test_expect_failure.
I actually do not think the complexity to work this around is worth
it.  

Changing behaviour of "test_i18ngrep ! something" to always fail
under poisoned build would not work, of course, and changing it to
always fail under poisoned build inside test_expect_failure would
not be a good idea, either, because the know breakage may be at
steps in the same test that is different from the grep, e.g., we may
have a "git dothis" command that should keep the HEAD without
emitting an error message, and we may test it like so:

	git rev-parse HEAD >old &&
	git dothis >out 2>err &&
	test_i18ngrep ! error: err && # no error should be seen
	git rev-parse HEAD >new &&
	test_cmp old new

but currently the command may have a known bug that it moves HEAD;
the command however does not emit an error message.

SO...
