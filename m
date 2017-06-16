Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60291FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 20:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdFPUw4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 16:52:56 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34910 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPUwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 16:52:55 -0400
Received: by mail-pf0-f182.google.com with SMTP id l89so27356234pfi.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B8vf/V9CAAlmF4HYMsAeN/bvuNiMLjzDQ1z7CyduV1o=;
        b=t5BOpeEnqZu4JtTYw0CnxIpd7TcIqPeQ72qZoIpWnI7H4Z++BxVeQfqpCrqoIDwDbK
         dh43Nr8+oXr90W1h7C2V0zsctpWywj+IkwZPG+7YTN+sl+7J2K5pK49VAsMZMyo3w3rh
         W1kS8d2aFk3xMfh6+WvmjZv5vjkHV+XVXzc6DgtZxsan/Ykp/WYU8AsjtZJjMbB01/ej
         Nub+bTVeqzkK+4CFoBipa7gr3gfFlKp7xZrdwu1DtsKFQQ+2HPy+hNEeYuyzQsr11fs1
         mZClSUFC+eOnV0fQKy6DQctjfAoYo64CsWYFxoIPgQ0+A6AQ2mIqaq8i4dr9ORM2INyY
         8bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B8vf/V9CAAlmF4HYMsAeN/bvuNiMLjzDQ1z7CyduV1o=;
        b=VTg6LENBrkTaUNItFYglYSllFkWwQa92EuoIukCc4AqSCyl043CLV8P5KesqMmh8nf
         A/7TkzkUgw0sePufXDpCwbvE06WpL5itJFjrImNO7XPEo8RiZ5k9Ri7NB1hJWUtMy82h
         XDfZKU/SRWmpWKa07xaWh8zIgJg8wcSr0t7rrs/6HLcpozHSIYDJlrCZJJcsxZRshM1q
         YK/76U6MEkedOu9cJPusJwYkWZtTxosgmwQOHSZsUD12JZsSrd+3Qrw46U7Ryh+AyrfO
         WQSxESpFfv7IbtG8fnjP1l2Ri3CXLcBYTG3qZJYu65tqYrNljwuKkRJlBZUiQ0Y5F0Y0
         G1AA==
X-Gm-Message-State: AKS2vOzH3hF2/gLJzYEjxk7PDZ35lQxjd14KTuJmu4pZYU58eidldK1J
        8nDwEHqWFwGCvg==
X-Received: by 10.98.36.135 with SMTP id k7mr13199564pfk.62.1497646374843;
        Fri, 16 Jun 2017 13:52:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id j24sm6514447pfk.78.2017.06.16.13.52.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 13:52:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Langley <agl@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
        <20170306182423.GB183239@google.com>
        <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
        <20170615110518.ordr43idf2jluips@glandium.org>
        <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
        <87shj1ciy8.fsf@gmail.com>
        <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
        <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
        <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
        <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
        <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
        <87y3ss8n4h.fsf@gmail.com>
        <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
        <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com>
Date:   Fri, 16 Jun 2017 13:52:53 -0700
In-Reply-To: <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com>
        (Adam Langley's message of "Fri, 16 Jun 2017 10:38:41 -0700")
Message-ID: <xmqq37azy7ru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Langley <agl@google.com> writes:

> However, as I'm not a git developer, I've no opinion on whether the
> cost of carrying implementations of these functions is worth the speed
> vs using SHA-256, which can be assumed to be supported everywhere
> already.

Thanks.

My impression from this thread is that even though fast may be
better than slow, ubiquity trumps it for our use case, as long as
the thing is not absurdly and unusably slow, of course.  Which makes
me lean towards something older/more established like SHA-256, and
it would be a very nice bonus if it gets hardware acceleration more
widely than others ;-)

