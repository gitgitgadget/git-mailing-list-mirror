Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2331F453
	for <e@80x24.org>; Mon,  5 Nov 2018 03:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKEMu4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 07:50:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38155 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeKEMu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 07:50:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so12483797qkg.5
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 19:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyMAYDHvTcJOJJ5ucfEQYi3NsmGM1wk/ptrZ5PdMqls=;
        b=H0HaEwtO1QgEC5Y/KfTuE2OzqdLz59xYdIvmSMQZEZYbkkoFLQzFw+gRVxXMVJSsbu
         Gl/WPMba08j1Xu5x+84tpMtAD3zUAJFPDnHXBsrgmjJXTbFlsQ5UuCi/HIbA6RWbyWMY
         pJp8dU7VwosGXvfSQ5XrIDD9N7GEmYstJOwgjvOi7faD3mf/fGuocz1rj4ve+pqQGV3E
         6edWCKVjIziTRoCnqs2+5V6Fdq67f7XCUEXQ6SdmSHNPH59AVlSAA0SFgqxHBd6/zXkf
         1ZsnJcb3oaAChCLrH2rJLb98ssqJIuIvnS9Nj/NZMy346Sew1UDcUbc+GJPHuM7HNiFF
         Fdig==
X-Gm-Message-State: AGRZ1gL7Qhw2gXH+FxbuaXzh8wxb5BM60+EIZB4QzegH+XD0SLBETLb1
        T7D2bwcL65HszLTTdJxiNqpbd9Ib8K4ex76JQMI=
X-Google-Smtp-Source: AJdET5d/TKF1OrXkOw1ZvQd0xLv/hNu+h0vS74c0Echr9DOPJeCD130+DV451toeiFUfhAiu0X+SuW0k64fpy6qVXRs=
X-Received: by 2002:a37:9584:: with SMTP id x126mr6284567qkd.36.1541388804337;
 Sun, 04 Nov 2018 19:33:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.64.git.gitgitgadget@gmail.com> <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org> <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
 <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org> <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
 <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org> <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Nov 2018 22:33:13 -0500
Message-ID: <CAPig+cRdaXdZPpmMKBwZziMZarr2+wrdpnyHPkSYAkoBDuvLnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, carenas@gmail.com,
        shoelzer@gmail.com, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> OK, thanks.  It seems that the relative silence after this message
> is a sign that the resulting patch after squashing is what everybody
> is happey with?
>
> -- >8 --
> From: Steve Hoelzer <shoelzer@gmail.com>
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Acked-by: Steve Hoelzer <shoelzer@gmail.com>

It's not clear from this who the author is.
