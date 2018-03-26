Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8921F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeCZB4U (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:56:20 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55471 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCZB4S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:56:18 -0400
Received: by mail-wm0-f42.google.com with SMTP id t7so12431811wmh.5;
        Sun, 25 Mar 2018 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cmI7SUK/DgZ52b+JnWgTJg6Q9LAp5rekkg1E389Brus=;
        b=ATR+8ksShVFyUDppYTLqJKyjtgg86YnPgcjlVLchjeWxUjtlDwnErpPDuzqln91+59
         LD+1QfcRsq07SJTm8B8ITzW9yeXV8tl1iAWowNsIiEwu5BmW+ppckaGpcCQNQ4pbFS81
         PFO4qvZCZWkRg5KTCw8DQqIZlA5cKShSmET/tNPiL+8RDMKZxOqwmh9GlHozP5ooCHSH
         iz66Z0yS7VNACjrNIt02MJ27ynfisM2w0LEifZ/uKDILmSp0ArP2jrQJf8w40qF1Vtgi
         FIkR1rMvYPIbz4XTz3mpEZ/HzifvyTfKH5fqxWvvcHopQAgKFtkN3pwllhJUDDC+mi6K
         Cj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cmI7SUK/DgZ52b+JnWgTJg6Q9LAp5rekkg1E389Brus=;
        b=LVvJL4I/c8291cK0i1E+ua6kMoCOTF0Df6O6sYDG+1J+/isZD9Mhg1Xb7y3yjz+lPI
         ccX1juoC4tIPkuQEngwvakGvDtfPZc1mLJssv1k/0xA5R1ONfNppTA4u9fGesXHTrJ1R
         6Ny17KA7IcOjTiku2IzyL0vcJCp+fLePlGjfqyOdnozSnEiOEKhg2CFczuC07nAoSxQw
         fojUJ5sngwAuzxq+VtqOLMi7us72Fnv4Ja+BSMWqlr6++CMLLugq9saijiL0gnVizfuH
         j4dSS7wKqy6bqta5dtoBJCD8VYI2lbsU7Hp0a/Bsng5UVYscV1wgVFSJCNdeXBNdV3f+
         3VYQ==
X-Gm-Message-State: AElRT7HBgOaXfzkmFiidNVgkWAZ4dQJHgdjMJ9pvLE7qMv+aJYOo8Nld
        Jyed0vnmAIZ21IfnE6+PCZc=
X-Google-Smtp-Source: AG47ELucSa3+i8wOtaUAiAntikMQkawlWGodnBaAAbzxpForrw3upRc9o/myUSFQIE7FInwH15LfdA==
X-Received: by 10.28.202.25 with SMTP id a25mr13882116wmg.45.1522029376937;
        Sun, 25 Mar 2018 18:56:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r19sm18735018wmd.48.2018.03.25.18.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 18:56:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
References: <20180325182803.30036-1-avarab@gmail.com>
        <20180325182803.30036-3-avarab@gmail.com>
        <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
Date:   Sun, 25 Mar 2018 18:56:15 -0700
In-Reply-To: <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 25 Mar 2018 20:11:24 -0400")
Message-ID: <xmqqlgefeh1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A minor point: Are you sure that it's git-format-patch that's being
> careful about arranging Date: to display in the desired order, and not
> git-send-email? Looking at old patches I still have hanging around
> which were created with git-format-patch, I see the Date: headers are
> wildly out of order, presumably because the date is taken from
> Author-Date: and the patches were heavily rebased.

send-email uses the current time as the timestamp it lets MTA to see
(and for a N-patch series, the first patch gets current time minus
N, and later patches get newer timestamps with 1 second increment).

The Date: field in the input file to the command has nothing to
participate in this process; sending a series that has patches that
have been shuffled with "rebase -i" would still give older timestamp
to the earlier message while sending the series out.

That is sufficient for any MUA that is capable of sorting the
messages in the sender's timestamp order; even though there is no
way to force the actual order in which an MTA on the receiving end
sees the messages, it is not necessary and it would not help X-<.
