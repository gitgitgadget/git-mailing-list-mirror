Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08C0215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756546AbeEASvD (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:51:03 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51377 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeEASvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:51:02 -0400
Received: by mail-wm0-f52.google.com with SMTP id j4so19021483wme.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GWJuS7nE0L9hbu8CbytgshV6Mq74dT2Qh/Y/sKLLqIY=;
        b=lv5WF+TaQn5gdgUR28SPAK5Cn3GBANZ7Z5txDwnSLSluOq1qG7z2GZuH4F6wrVnBF3
         NzTgaYXqW/HQzsNFENkPUDVPX5VpIiBwFr5IBToov3IcSSzjkmwfMcrPIsFTU/lppir8
         P7Ie3i8yjKEkayixTMWMESLjKkCo48TFewRYkYdFMkVKO6Jb0SEAUvy93f7+lxFlIvQD
         v/ZaBMLth9kfbWEIfI9fczgf0mAoZhYrYXBMZSc+JHBIc23T3BowqAoiysWn+N+SRpwc
         UErNoSgGmrhLc63Tn5mbfw8OmD6rqUYUvlzxLCaw2hUaHnf4T6T0AHCrJmLg+nUYy9R2
         qFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GWJuS7nE0L9hbu8CbytgshV6Mq74dT2Qh/Y/sKLLqIY=;
        b=LlL4KcxyRA1Q/5SI//Dv8N3oUjSJm7MkVHyvR4pp1nIHNOILeFH/yxw006TvSagDBD
         h9Pc5kk+OMsMut//7HhePB7snaKUcZTwf5Qc3Y22o11WwSkJsyYgetI8Yt0FMf5oK3J5
         66KB8e+atRNaJ01rRNkabqOSJ0V+BfP1c/LA6YAi6Cm7F92GyD0g7MJISyIFo7y/Ix3m
         yn0pN7hcLMhL3DwgyKFuHY/WOoSg0R5ChCggo4IofcWrJDPr8LuiI/88QqG/pUt0yAMC
         zyRKEQUcejqNlmUGNtzGFjeNbvQ2ZAg5rdFfihRo3SMW4sO3swO3i8LjIW0o459kaAre
         hhUA==
X-Gm-Message-State: ALQs6tB6z8e+HsUsT729AAMDUeDa7fB/j6tOptUN2V28i+JmfkotIK2n
        vEBs6Z5QSUeyPl/NkVeficYMmLWW
X-Google-Smtp-Source: AB8JxZoKEm824QQnf3GY85ma4ZOi/n8hiN5KWqtBTVLC0M/l1JeK4fiPr5uHqGwuMLZgMDDWV7rCRg==
X-Received: by 2002:a50:e044:: with SMTP id g4-v6mr22502116edl.123.1525200661480;
        Tue, 01 May 2018 11:51:01 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f16-v6sm5799277edr.32.2018.05.01.11.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 11:51:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH v4 1/3] Teach remote add the --remote-tags option
References: <20180501165931.25515-1-wink@saville.com> <20180501165931.25515-2-wink@saville.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180501165931.25515-2-wink@saville.com>
Date:   Tue, 01 May 2018 20:50:59 +0200
Message-ID: <871sevyzu4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Wink Saville wrote:

> [1]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#me7f7f153b8ba742c0dc48d8ec79c280c9682d32e

Better to link to https://public-inbox.org/git/xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com/
