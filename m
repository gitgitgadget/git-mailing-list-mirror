Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C151F42D
	for <e@80x24.org>; Wed, 30 May 2018 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934433AbeE3CwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 22:52:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37599 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeE3CwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 22:52:22 -0400
Received: by mail-wr0-f196.google.com with SMTP id i12-v6so27937014wrc.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MtJiF6ybIMGhSULDJITlpbG8wneDnbRLyGGz0+mpBoA=;
        b=LsKhgLniAfd01qj09VeSG5NXH8SItwEyi+4h+bA8hxq/nBvs4rxrKk524Sdge0Gk71
         f5/cfhVCyk3JTxEuJSGICO635IYV+vlc/Mkr0p+Il+Gnj9J3s/kTM0ShAsmgsmeDvO9E
         FLCN+ISj/wYWxmLOgPsj77UDE3opHZK5ivGECQxzgljGLlL08H2NQLNzdvY8+L5B0NRb
         brFuslyuOMBVBa3DOY/r+GtW6deVo6lXUuxO0qSFkLwsIZuyWRixW198aE3hdYOuCIxC
         eq10c5zH1l+AL69mH6uRgigELhV1edRDKowU8qf9ekmQy7c1PgEdkGhjxzUUyldERw17
         2DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MtJiF6ybIMGhSULDJITlpbG8wneDnbRLyGGz0+mpBoA=;
        b=lNae63UiZ4SHBQuz+6kiqf2CNcQureQB6lAox208dX733jZCCuBBIfw1nAmMVlpjuF
         aL6D3zItI+049jpm2XEiLJ/374z7HRY0NfbtveC9pvWhju0xmxZOsp/iF4egVdhAHvDX
         hOgLLguN+kTeFmFrBsre9NAYwchX/DLDLZTRvWhotPLLXrbqAhIIN9XGXxzYk7WRUhYi
         sn0xJ/CtxJyoebpBKDhD5BYdueJYWzrvmkbbaEA42r1sFPT/Cj4bsynVmz3BRCWj72Wi
         8d6w+yUz/AavqF6S1FQq16Z/GuFzpUPp46Kl29pTNy5Tj8NS42qCXU1/pzO+CFpbr9Id
         xQiw==
X-Gm-Message-State: ALKqPwd4yoxZFVc54S0Q+oWzGHo5Lzao/1NcrsmNVWKBNPEBVBJkCVIK
        u03jTAZI/niJvKgxFZiJ9Qc=
X-Google-Smtp-Source: ADUXVKIRxwF/d4qXe9uIqB2uxVhMq8kUlBTUx/QDD+lFkPf/k6UAEOvOBx7nwWJfaIWrJAizihzSXg==
X-Received: by 2002:adf:f090:: with SMTP id n16-v6mr381813wro.49.1527648740653;
        Tue, 29 May 2018 19:52:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 130-v6sm319124wmv.1.2018.05.29.19.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 19:52:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
        <20180529211523.GA7964@sigill.intra.peff.net>
Date:   Wed, 30 May 2018 11:52:19 +0900
In-Reply-To: <20180529211523.GA7964@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 May 2018 17:15:23 -0400")
Message-ID: <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, what I meant by "gentler" is that we continue to perform the same
> behavior as the old version, alongside the warning. It's arguable here
> because running "git branch -l" has _always_ been wrong. It's just wrong
> in a way that happens to do what the user wants. ;)
> ...
>> Anyways, if you think it mustn't turn into an error now and only in the
>> next stage, a suggestion follows in another thread.
>
> I don't think "mustn't", but I have a slight preference for what I
> posted, as I think it is a little friendlier during the transition (at
> the risk of somebody missing the warning, but then step 2 turns it into
> a hard error anyway, so they'll certainly find out then).

Well, we could keep treating '-l' given in contexts where we have
silently ignored the option and did "list" instead as before during
the transition, until the very end where it becomes an explicit
"list" command, no?  Then there is no need to even warn against '-l'
that is ignored because we are listing in the earliest step.  The
only usage that requires a warning then becomes '-l' used for its
original meaning to create a reflog, right?  That sounds gentler to
me.

