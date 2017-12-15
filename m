Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D53D1F407
	for <e@80x24.org>; Fri, 15 Dec 2017 18:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755534AbdLOSDH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 13:03:07 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33259 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdLOSDH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 13:03:07 -0500
Received: by mail-qk0-f177.google.com with SMTP id 63so11349981qke.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 10:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2FwS7bAmpQ8hjxPDcU943sDPp7k4lk98c08dghd74hI=;
        b=FXr1JckT6mUXvmDFvYkM5PT+Ik7MEbBqQxxljBCdo0OUvozbPGLhKNlm++ew1p5Znd
         L+suglGnagGXXwC2OckXBr0Fa1WJ3HY4O/lcWzFixMQ/Y5/ihWtThURTbsOPHx/DPODg
         MX7dATfr4obXGIiT7ZwZOyeaVFdmmfA1CxStuQA042E/8Od8YT+IPDSGVCz3QjLtTwx3
         yj8JU2g05nqRBIWtVAh8BdM4TsiAkXKZnREje3I5S5SKTIafimd3Dp8LOXmTdyGbxq24
         eQ8DJvXajvfCYxCNFi9sOnUapsJ2ULJcHsgVgNH5dciAIn8A+RUw2eCWyduT1tuNPG9a
         2KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2FwS7bAmpQ8hjxPDcU943sDPp7k4lk98c08dghd74hI=;
        b=CU6/vdZ8fneYv02I0JgVFkvRxLJWbNYfbJTh4Ot7fCN+t5pIdLcHIL9OLravnueq/T
         IUyVAkSSwImAJBO48dRagLfpbeaPpWNKX8agq8dyg3yUntF/FgddwzRb76kJju7R4tBp
         h1dTrW6M72FgDndP7DyuWYBz9PIz1Aqck8hL6N8BmRZMedULH73y3JlzZIfxGHLypXVp
         G2R2dY4B0JC3nFMV0nbH+wupJ/rJ8Cusc4qlqFppE+jGX86znCzI4OCJHEt0uRNBSOxb
         BfVDCxhbHP8HsWYU4VRrB/SPGiwwaIWgqHkzdNQipwLoeseqGMXGzD+Dwa0FGJtJYKbp
         5Q2w==
X-Gm-Message-State: AKGB3mI4Nh6pMut9XZedng5p1m//jdfbpftPaCt/bDAJmG2+04SAmBhz
        VY3wCVSzR/82DP/KnPL90VgQZE2srVrSl15xq4o=
X-Google-Smtp-Source: ACJfBosAEcgBTqAHEV0OwpWqspjoaW0DMGN0CCyOGyhm39TgiTQzmDSn+0dtgBAn6zI5rLjAtO2YyKBfusL2QPercVk=
X-Received: by 10.55.126.7 with SMTP id z7mr2150901qkc.306.1513360986302; Fri,
 15 Dec 2017 10:03:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 15 Dec 2017 10:03:05 -0800 (PST)
In-Reply-To: <xmqqind7rik1.fsf@gitster.mtv.corp.google.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <cover.1513294410.git.johannes.schindelin@gmx.de> <xmqqind7rik1.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Dec 2017 13:03:05 -0500
X-Google-Sender-Auth: g0qLfPwak_JJn1JlBybFcCBbofk
Message-ID: <CAPig+cRymagTe20ZJS4Z0DyPy0_OuE7zEuP1wiEk0rWhDdk6nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Offer more information in `git version
 --build-options`'s output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>       no commit associated with this build
>
> I find this output somewhat klunky for machine parsing (and it is
> inconsistent with the style used for "sizeof-long", which hints that
> these are "<token> <colon> <value>" lines where whitespaces are
> avoided in a <token>), but hopefully this is primarily for human
> consumption and scrypts that are trying to find a specific piece of
> information would know how to use 'grep', so the inconsistency does
> not make much of a difference in practice anyway.

Simply omitting that line from the output of --build-options would
also be an option if the commit can not be determined...
