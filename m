Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220FF1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932371AbeAXVD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:03:57 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:44033 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeAXVD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:03:56 -0500
Received: by mail-wm0-f47.google.com with SMTP id t74so10968204wme.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AkfH6sDDjr45aC58FpmzOKSUie+rPLInvgxcKwOejgI=;
        b=ZOw1f7humhzWwchNMXG3CjbJssmIzyjqTvkslP36eqeHNSav7NgwnPQuNAJV4tHSYi
         0QWMTPpUyrvGfpFl1cgrKEIB0vHzdasmMKYbronkzjz2V5ApZyng7uU5/58/homRHL5u
         b3bnMzJLRJ5QhmPwmKyTbTSQspI5mpUwG66dgwATLaAh/SlS51eGYAfDVjyVU0n0+g19
         qQdt2WsGxLeV/AN6L2ZMU1Sv/d1tytsrwU+FZ3D2ZN0qJYp70ENT+GckHq/ilUOO0as1
         z63/kX4/24TvpRygRuDLMEd5okyk+iTxaBFj/0IxsENapnJokZesYUZ8q120i37ZFuXJ
         AYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AkfH6sDDjr45aC58FpmzOKSUie+rPLInvgxcKwOejgI=;
        b=GoLKGoOh/mxmtX4ylfg4QS1T4k/uhiQWkA0IQaU4Uk/2HPZQTXpXE2H2Ive1sqRyBU
         3HuYEu4tu1FkcPzPU5UFqzDFFaKa1s6O7t+mn3tbyvBQxq7XtqgqmnoUa0Ps3YEli/Kb
         Y7Z8c7K3+3LuhPi2IHYiqOpOBXzDaIxTFF4gSTORRz1frIhkFO/V1qjU8hXzFNdTBvfp
         mh6znoAsewppnNJlHEpG9vvgYWmjl9Wd7iI+702JB16LmqcvspJJpdMUzAsw6zZJVRuZ
         +0B9VsfmPelTi1HCbLWp3vrL+waSqxeK4vcVEzzpJFs4tzcITb+DyYW78ff1mV1+ID7T
         pkVQ==
X-Gm-Message-State: AKwxytf1a3MSTfrItJrQ1LUEWxSflh23Fn9uMlWcozA9dFGp1BrG+/rq
        u2vHDgEYnju6xrcMeH3yapPkEWpW
X-Google-Smtp-Source: AH8x226imRR4q/lZsZNidxKZYED2xo/iqfcJ8Y2l2wjRuktfwkpQOJUarbZCNNqUpCriHUCk97YPVg==
X-Received: by 10.28.19.210 with SMTP id 201mr5274463wmt.4.1516827835226;
        Wed, 24 Jan 2018 13:03:55 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id v22sm3128963wra.58.2018.01.24.13.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 13:03:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/11] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180123221326.28495-1-avarab@gmail.com> <20180121000304.32323-1-avarab@gmail.com> <20180123221326.28495-12-avarab@gmail.com> <xmqqo9ljc73n.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqo9ljc73n.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Jan 2018 22:03:51 +0100
Message-ID: <878tcnklzc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>>  git -C {} config --replace-all remote.origin.fetch "+refs/tags/*:refs/tags/*" "^\+*refs/tags/\*:refs/tags/\*$"
>
> Shouldn't the last arg be
>
>  '^+\*refs/tags/\*:refs/tags/\*$'
>
> instead?

^+\* isn't a valid pattern.

This invocation is to replace both +refs/tags/[...] and refs/tags/[...]
with +refs/tags/[...]. This would be more specific, i.e. ^\+?

     git config --replace-all remote.origin.fetch "+refs/tags/*:refs/tags/*" "^\+?refs/tags/\*:refs/tags/\*$"

But I couldn't remeber offhand whether all regcomp() we use supports X?,
whereas they definitely do support X*.
