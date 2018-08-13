Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D9F1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeHNAj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:39:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34099 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbeHNAjz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:39:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so15543640wrt.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FhfiNhD4HaHZB5Q8L2d25wQA25hFmZTl65JBQm9ZYI0=;
        b=SI+TgnQLLEBY8Oa44cjIguRzX2720YM/w5YOkv9MixGa3liGcMAHj4Bw67Y9tUqGPb
         HTAk08IoZ+hjyI3MZFbhbtZW83aQ2i0oh2Qgif3SolkdOOb9+8KkZqbdfDD7wj3kfFoc
         8iUi6s8q5AO6cMcx9bGfsKbF4Rsvbwso9gtvlAqVpPm9qwF19IhrShrMimeojq9tSmSV
         2296+Pe3zGTzNcKY8E/Pv8tA/HCK+jNJS+iqqfdUFvM0DiiqBK4dqXhs/F02omUicjKO
         LNO9SgaNf7DXCQoVodPjfqkkJwF197GtICfNkVYUKDXOitkvHRLBuMtsEoonxD8qz1Y/
         jpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FhfiNhD4HaHZB5Q8L2d25wQA25hFmZTl65JBQm9ZYI0=;
        b=JMhlKGTGHdRMX4USMVUnqnalxMcTvz2dz2F7LnojL648KUz2gVLi5kCcE+JJNcWdmf
         wmuN4kplBBDYHHmoaADb/ffV4kS86XBejdoSJzU9TwhhnTNqvGp1jrIWFgohW6yquAU6
         c+Ji84S+5CWeL3G0of+qsDC+scJWQmAXfeW/fI4jfWqZvSKc748FqXhB/jqDhepGlrK/
         R35McaUrkh5Uq96s43ss+m2aNeXaETcPGMFQqrR7m6APyJeHcrGMMNzekr8H3WvAXqoj
         nEJYlseEiNNASGo0FRUVScqSJL0uJgq0wQ74Geg8D92LCbs1ZWT64Rv/GYfnDXIvE4LI
         u+tg==
X-Gm-Message-State: AOUpUlFCXYjTDQ6PAHcOePnqN1DLoaSnnJpc7iMLlpkJkswws2/MLR/p
        RJfs0UHGf31Bpe3PJyaFb2Q=
X-Google-Smtp-Source: AA+uWPwm+pBmSvhEKllVlPj036FcTRHgJvDkzedAI1ZJIwgN2Bq6XPvMPBOKhGMDmmZEyRX4IrQdpA==
X-Received: by 2002:adf:ad38:: with SMTP id p53-v6mr12267574wrc.10.1534197348445;
        Mon, 13 Aug 2018 14:55:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 1-v6sm21029276wmf.47.2018.08.13.14.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:55:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
        <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
        <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
        <xmqqr2j23tnb.fsf@gitster-ct.c.googlers.com>
        <84c749fd-23d2-0bc5-225b-74f8d31502b6@kdbg.org>
        <87eff2rmgt.fsf@evledraar.gmail.com>
Date:   Mon, 13 Aug 2018 14:55:47 -0700
In-Reply-To: <87eff2rmgt.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 13 Aug 2018 23:22:10 +0200")
Message-ID: <xmqqo9e62aos.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> O_APPEND in POSIX is race-free only up to PIPE_MAX bytes written at a
> time, which is e.g. 2^12 by default on linux, after that all bets are
> off and the kernel is free to interleave different write calls.

We are only interested in the use of race-safe append in the
tracing, so we should be OK in practice.  but then ...

> So there's still a use for a race_safe_append_open() wrapper function,
> to O_APPEND and do the PIPE_MAX assertion. Otherwise you're calling a
> "safe" function which isn't safe at all anymore.

... having an assert that would never trigger is not all that bad
;-)
