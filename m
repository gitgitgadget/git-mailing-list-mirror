Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B226B1F42D
	for <e@80x24.org>; Fri, 25 May 2018 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeEYCHf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 22:07:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39085 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEYCHe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 22:07:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id f8-v6so10355679wmc.4
        for <git@vger.kernel.org>; Thu, 24 May 2018 19:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pQ1TIfaIvNeAIMzppqF3qihUxw7spy2yGCQetpl9tEQ=;
        b=kNlU4XTRhAAQB7gokN1ce6+bxr2HkNeUfyrTANp3qtkATQ3UVr23rVYvNIq+ZkpL7E
         YYElVqxttFX6hXkE+uvQwFzimaK3yRG94uCbZJGvDXdKAIr3J2Zs/nES575bX9w1GGeG
         Fk8uXzZVrq/QOCwFhkoTwZ1zhdvpokl/GSlg3phCWSX4gDLoDD53Dy13iX3XqHzBBXxF
         lXycu3J9ZMuxMhUTqyIvzJGUMyK1Q1FiUhxReBMFCuwqqOCjPwDMOeLGSB35u/jp7lI0
         pGQz65mtNTWHOZlSqcm/4qd3MGB+kRpDBRO5PAwuP892UGSD+cezotpbthzyBKRjTZNE
         zi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pQ1TIfaIvNeAIMzppqF3qihUxw7spy2yGCQetpl9tEQ=;
        b=E3EmItdIlLL+O6HE+ih8bs499HZtBNHXT8koSaY4WONkiCzcsgGmstYTP7yCsTT6eL
         svGK2Am4fueVbEymrwcENBMQfuLxZ12z760ogQ5YrEIFw6LM4r73U2LzVx+yC359ULfP
         SCkxRN1foDcVDpJE2/W9GwrLgUrTiLNFlJRo4ZjhyGeRcJwsCHfoImgsDqu+IRQdCneh
         PmpdgLgsi2LYOteaEctfQtnGykUMjQVWuEBDLk8AoYxARrQGRUIqwyICVhssynmxoyaf
         nWhuqSz6/isqrHyQwS8Qe5osgctGHOUlz3ZSKZWPnbDUHNJTtT+PrqAJDcgViW5Ob9HU
         5IpQ==
X-Gm-Message-State: ALKqPwcJDBIsx5ZH4T0zvrwTwv5Xw322Z8lqVas0e1SiXiHDeguPGJ4K
        Yo/J2ZU6kYRQ3n4GeqG6IPU=
X-Google-Smtp-Source: AB8JxZqajG/vIRI6E47sck9pcUaHGOKubfhzLJiA1yXiNipSKaHqYJcAP3BDkomQEmBxfftE0cG0fg==
X-Received: by 2002:a1c:8645:: with SMTP id i66-v6mr276171wmd.40.1527214053192;
        Thu, 24 May 2018 19:07:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y11-v6sm16078143wrc.93.2018.05.24.19.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 19:07:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-1-avarab@gmail.com>
        <20180524193516.28713-3-avarab@gmail.com>
        <CAPig+cTr2J6yj39NNdV1vT8CQP2qyPxNB1ggaE9bGgXukuq1yQ@mail.gmail.com>
        <87r2m07qz6.fsf@evledraar.gmail.com>
        <CAPig+cQeNDfkwJXNVB0xP50KUPFMKTmJhrCSdsAOJTqcNFegAA@mail.gmail.com>
Date:   Fri, 25 May 2018 11:07:31 +0900
In-Reply-To: <CAPig+cQeNDfkwJXNVB0xP50KUPFMKTmJhrCSdsAOJTqcNFegAA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 24 May 2018 18:49:55 -0400")
Message-ID: <xmqqd0xkpjx8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I see where you're coming from, however, I would think that readers
> arriving at this topic (generally) do so as a result of actively
> looking for it (as opposed to happening upon it), in which case they
> probably are directly seeking information about it; the incidental
> information is just a bonus after reading what they came to learn.

Yup.  That matches my mental model as well.
