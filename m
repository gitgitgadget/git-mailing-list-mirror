Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BF01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeGTWO5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:14:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39762 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeGTWO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:14:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so12436873wre.6
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oqiueJd9HHq71Frk/QxVYQ99iPD1wirkwHy/U+hzCBU=;
        b=LpskpdN8aLlDWWZREFRTakObtSetu6+KgD3SbIwYOdiXfqC2T/yiHy3s6S9yq2j0PU
         Uu5zQ+8V68jtBSF8w1yt+kP3kS0XZefy3yYDXGPwQoYqhtl0I/OO6Y9Fntvl9vJSLlH+
         rB98VAXdG1Wj18PGm0Rd8E80FDsN8oB/BQ5IXDYkFZwX8wexd7nNJ0EVl9LfYbtKrLsU
         xyBJpVMEdRy7E2F70Jn5nGaKPQ+s5SfwtDp89UAnLzDVlTZN7NpJ/7HUALg2ME8SCQHg
         AbIl+d0DzdDW0awnbRMi6dn4kVkoUrzp+TUMib06swjG5y3+hLZWiDY/zP+RDKmJFvig
         2N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oqiueJd9HHq71Frk/QxVYQ99iPD1wirkwHy/U+hzCBU=;
        b=SfizLHBN8DCPH0fFm0tYlFBC+CjGZmc6bvBXSEzLix+JBt1ZqgvoI3rtvJcZSyIyZ5
         XgkxnBnPKXTywb6L4FhjlGriUn05bcDkL2Q/l5uWRSS5HSoMXFW5r7Tg4SckVN2zsFOa
         BPUjfOcKllCANGHAxBTcQ0h3BEhTp6bfljV1+KlLf4uppeGMdOwClNVtJquqDPatbJuy
         FSXOQaAmUvZ41GR6/tQHVCTlF8VpdhCRUuRcbgPRZkB4TahmII/TLrTb6etl1msgIJR5
         ivRB0sW6j4Olyq9S5ixsFuoqNwxKH/0hXUiJmdsgjMUx+rdDtCTNFypZlMXwbeVQPH43
         49YQ==
X-Gm-Message-State: AOUpUlFueMmMSgvddZuYrKZNdwlNC045h6Y2yt74HVsAvHwAOt/F8Eek
        JqhIBDU7j9tEnsIpO+XNfgQ=
X-Google-Smtp-Source: AAOMgpfd55A89O9i7nLbejHZiyPuVatMSidO1OGhuAK/bg7FSDQ2RbhxfIwXaRPusBsXkSDLQhZNrw==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr2588682wrg.203.1532121891843;
        Fri, 20 Jul 2018 14:24:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s10-v6sm3657386wmb.12.2018.07.20.14.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:24:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
        <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
        <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
        <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
        <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaLTJDmWhS8Y8R1cQh9TRXLawdoWHEzVC6PLHBN+VQekg@mail.gmail.com>
Date:   Fri, 20 Jul 2018 14:24:50 -0700
In-Reply-To: <CAGZ79kaLTJDmWhS8Y8R1cQh9TRXLawdoWHEzVC6PLHBN+VQekg@mail.gmail.com>
        (Stefan Beller's message of "Fri, 20 Jul 2018 14:20:04 -0700")
Message-ID: <xmqqo9f1a9ct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jul 20, 2018 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> It is not like anybody (including me) needs realtime up-to-date
>
> I thought the same for a long time, but contributing to other projects
> showed me that this is not necessarily the case. Having a real time
> update, even if it would be just "your patch is labeled 'under discussion'"
> is beneficial as I would know where it is "in the system".

Well, you wouldn't have an access to the up-to-date amlog maintained
by me *UNTIL* I push it out at the end of the day.  So by
definition, you do not have real-time access to the up-to-date
state.

And also by definition, you do not *NEED* such an access, because
you won't see newly created or rewritten commits, whose originating
Message-Id is not in the copy of amlog you have (yet), until I push
the day's integration result out *AND* you fetch what I pushed out.

