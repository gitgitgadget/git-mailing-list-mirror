Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483681FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 11:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdFGLSk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 07:18:40 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34182 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdFGLRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 07:17:14 -0400
Received: by mail-vk0-f42.google.com with SMTP id g66so3725669vki.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mn1u7nUnhGLKqba3n+luLU4kSUrwjz3K9oeTohIH2p8=;
        b=WphxtgRVTPjdP+vbkJcCHl84hWyB8MrPwlB8PBRxOVjfP1tT09+on3cYYHAgANL8s9
         KFtQ1jPpbyWRGdwtjA1GbxMPVFDWt3Gp6ctd8QQTdb8AC6C6K1fuouSyusjVM7qIK/ux
         wYrg6t4UB7UshpnDG1y7sFUCfoquJUNBudRDh3d50gudPuKZNf2Nrzd6mivCpOmzvHyY
         JA/qAEobIEUqyvKwQee7vjXq1B3rNhS127gu3hFt1YkvgI495f9uPq09HE4x7Jh6d85o
         /YD/chMQw7wu3Sn06gMPfzYaICqkJwsgGqHcd/TEDAgmgBRNxPN5ASMjjHZ6uUR+jq3t
         Aoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mn1u7nUnhGLKqba3n+luLU4kSUrwjz3K9oeTohIH2p8=;
        b=pfUtEu1ykvZZ3fGrPWi8ac/G3oGl+vJzO3qVAwmsLVNoabAHIqrg44b14WE9QxFaEB
         hGJVvQb/Orqy4SR8ZWbZwyDGtsbHV8RRki0Hu5PD2AA0DfTwIyuCEz27shKh383Ne4sQ
         oiQ3iyiupM+G6OiB8HrrVsuAf1J9+JLRBZA57y4oPfcWo5knqH5L1i0JQOtbbycUUfVv
         MAyvDdmTGFq9Pqg0+zJZ0FimkY3JsOqUDcV4w6ufaCreiuAXEO0fiQtDxY5Vbllat1ND
         +cHmuohBNdgJz0LunZwgRWDpgLQZJhkdyXb/zUidqExm1Jc9/gcUx0zBNPR/bwrslBza
         LIpA==
X-Gm-Message-State: AODbwcBiMQDKH4l/jFuOga3JH1sANtPVExsNSEPLZQnF+vnoy7K1doU3
        pIG+E4CZ1c1sBhME4GpNWeyMW8qZPg==
X-Received: by 10.31.195.196 with SMTP id t187mr10335856vkf.151.1496834233378;
 Wed, 07 Jun 2017 04:17:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Wed, 7 Jun 2017 04:17:13 -0700 (PDT)
In-Reply-To: <20170606183726.ycl4k2aoyurj5sfr@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
 <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com>
 <20170605081845.tvzidc5nblbnuner@sigill.intra.peff.net> <CAM0VKjngnRv6iAozvhY_c61CyWhQP2khcr0bs1=7G_-MDNu4kg@mail.gmail.com>
 <20170606183726.ycl4k2aoyurj5sfr@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 7 Jun 2017 13:17:13 +0200
Message-ID: <CAM0VKjmdTstqJVHZCQ4f+CxdQxnQP9C2ocCYepE5ihcfV7sTkA@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch refspecs
 during initial fetch
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 8:37 PM, Jeff King <peff@peff.net> wrote:

>> To put your worries to rest we should eliminate remote->fetch_refspec
>> altogether and parse refspecs into remote->fetch right away, I'd
>> think.  After all, that's what's used in most places anyway, and it
>> can be easily turned back to a single string where needed (I think in
>> only 3 places in builtin/remote.c).
>
> I don't think we can parse right away without regressing the error
> handling. If I have two remotes, one with a bogus refspec, like:
>
>   [remote "one"]
>   url = ...
>   fetch = refs/heads/*:refs/remotes/one/*
>   [remote "two"]
>   url = ...
>   fetch = ***bogus***
>
> and I do:
>
>   git fetch one
>
> then read_config() will grab the data for _both_ of them, but only call
> remote_get() on the first one. If we parsed the refspecs during
> read_config(), we'd parse the bogus remote.two.fetch and die().
>
> I guess that's a minor case, but as far as I can tell that's the
> motivation for the lazy parsing.

Yeah, I know, we'd need a parse_refspec_gently() or something.
parse_refspec_internal() already has a 'verify' parameter which
prevents it from die()ing while parsing a bogus refspec, but in its
current form it doesn't tell us which refspec was bogus, so we'd need
a bit more than that to let the user know what's wrong.
