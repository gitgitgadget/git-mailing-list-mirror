Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FE52027C
	for <e@80x24.org>; Tue, 30 May 2017 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdE3Wjp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 18:39:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36604 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdE3Wj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 18:39:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so20805278pfb.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gnepwfeUHAHfH6MH5olxJG7z4xbeauBjHp4YtVSRrGc=;
        b=eT7nHZAe0OU8ItCkIIhGox4aTtVvYvDKCOUV7GVy37v3+Vz/izJ/QRpuxpKTk4xDkh
         PHxLoCNtAi/Fa1/ICMHf5j3Rz/33rMDpzVuKX7V2/aw2oqkT/j4xw/yGwEVuj9AxTka2
         xzsHHkmZE7iQiDYimEMlLd/kHoazfWdzVSSmzv+3Ntq6jk8/74QrGsXZQZqB9b8Kt8rl
         EILz5W7NyVcWEYAALiB4V8MFvrLCJAEyqrp5nBzlqaBJqPR3T8ZNWiy0SbQaT5BFbA9X
         8K5eybz0A+RHDJDETFOFKSCbeGFqLu4SPEe6e4isVSewjzuCxSTicq/dov8AEmObQdWl
         uGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gnepwfeUHAHfH6MH5olxJG7z4xbeauBjHp4YtVSRrGc=;
        b=bqPwJ5C/rssFk4Pu81kIHugw0xi9YxuGDK98fRrb6Kuq9LrgZ0BVcXM8g0OA6/rSiX
         2eRarR49DABBfj0gQeqcX8IT99pbMXURG9Jro9rUqWlewSZV1aKUfo4dxbB92+K4C/CM
         2RmNz0prBHbUSoLNVmoSDiSELlY8y/8gjv6LWLl5y0dTpvD3KCBep6s80d0nj4eTfCYP
         tC8qY/M+Aybwz1kOTukE7KE4we10oje5l2M4ZoHLWxOJac9ncB1SBAlvGTktaFdaZRP3
         uNsy0GiRlGSsosHaMmBT2CjXjP/ZBr5sdenDMi8j+UMvHDJMCiiew+nQQl7ZPEpbE6Wp
         AfMw==
X-Gm-Message-State: AODbwcDYdmndhQoEG8NJCf5mc/NU4visluUTz8qunUwP/32TOAq6f79F
        7M6t/JywDNUvyA==
X-Received: by 10.84.164.162 with SMTP id w31mr28190837pla.174.1496183963858;
        Tue, 30 May 2017 15:39:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id g70sm25808617pfc.47.2017.05.30.15.39.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 15:39:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
        <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
        <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
        <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
        <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
        <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
        <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
        <20170530154432.rxzo5k5ti3jxmksx@sigill.intra.peff.net>
Date:   Wed, 31 May 2017 07:39:22 +0900
In-Reply-To: <20170530154432.rxzo5k5ti3jxmksx@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 11:44:33 -0400")
Message-ID: <xmqq60gias11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And the idea is that ranges like "-.." should work. TBH, I'm not sure
> how I feel about that, for exactly the reason that came up here: it
> makes it hard to syntactically differentiate the "-" shorthand from
> actual options. We do have @{-1} already for this purpose. I don't mind
> "-" as a shortcut for things like "git checkout -" or "git show -", but
> it feels like most of the benefit is lost when you're combining it with
> other operators.

All correct and that is why I haven't seriously considered merging
the topic further down (yet).  Things like -.. makes readers of the
commands go "Huh?", and "git tbdiff ..- -.." does not even work ;-)
