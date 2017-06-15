Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8565F20401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbdFOXFp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:05:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34409 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdFOXFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:05:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so3184246pfe.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gHB4YzvTdU9ND76UXq4Hqh1SyUFcLEShAjygpdsG28s=;
        b=AMaF4itESBLfnoV4OpCzfVMR9K3hiHNYXqUS5n8vqCeQFf/nfUjPPUwjSKj6gkWizi
         1dainxwI0PzpXXH8zh3RbSWjmLYwra4ToYUTnUTG38iAgA5HDUN/MRMk5hBB5SLqXcRK
         tvHBRZ9Tg5Zz/P/Jx+/mPJBYH2FouQnil232bVazxPp1YFn9Ing9Q0YvlTdycpFWtQCd
         VTdSEvoe8NnSwGgUtaYUsjqhCtD4psfbAuFWTax3Llh6Dk30DuQ284q6B34g+xsbbB7R
         OXNhUI8cGgEZQ/U4OfgQVkEQLXiemzKs6ANPalZdfcggE4+JKNG7WS81ib3ZlN0rc1OB
         RBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gHB4YzvTdU9ND76UXq4Hqh1SyUFcLEShAjygpdsG28s=;
        b=STWrkFlMOnrdbsCcRcgyYK9gA8RtLChbY+52DXyW9sgnNUjNvbmEMTwEXxSvFsiGWA
         1BkUxo/OSnSo++Rbq5ieCFdIcCwKioXz+lj57mBdqzUeanvTdn/CHUDj7tPuJ+wBEPlg
         89IP6j+k9L0Yg/LqAikw8eTZpzSQ2EToR06txqxAcgrvuUPch4u71ZQxC6yEzKsAMqQI
         WUB3wj3poBeu+F716UJRvh0DitVW0BmTvSAcDrZDXqhUTTx1A0PiXz/xQj28i28tUd66
         rPmVorGzWpKtj7X5TdKcNAesXIrUxw66atcXwBVxFlQcNPtqlXpPano4uNQcXM82NiR2
         yJOA==
X-Gm-Message-State: AKS2vOwTWVXvXv+Yy6A48DanuuZZ1qYfuOqxgVi2ospAqhyZGgXvjkd+
        c0GBGSev7nLo/g==
X-Received: by 10.84.137.1 with SMTP id 1mr9231131plm.128.1497567943459;
        Thu, 15 Jun 2017 16:05:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id d71sm575214pfe.106.2017.06.15.16.05.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 16:05:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170614102427.5220-1-phillip.wood@talktalk.net>
Date:   Thu, 15 Jun 2017 16:05:42 -0700
In-Reply-To: <20170614102427.5220-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Wed, 14 Jun 2017 11:24:24 +0100")
Message-ID: <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've revised the second two tests as Johannes suggested to drop the
> sed script. The first one is unchanged.
>
> Phillip Wood (3):
>   rebase -i: Add test for reflog message
>   rebase: Add regression tests for console output
>   rebase: Add more regression tests for console output
>
>  t/t3404-rebase-interactive.sh |   7 +++
>  t/t3420-rebase-autostash.sh   | 138 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 141 insertions(+), 4 deletions(-)

Thanks (and thanks for Dscho for reading it over).

Unfortunately this breaks unless your shell is bash (I didn't have
time to look further into it), i.e. "make SHELL_PATH=/bin/dash test"

