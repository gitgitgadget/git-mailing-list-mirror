Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E0B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGaS6g (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:58:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34652 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbeGaS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 14:58:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so11622554wme.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eElKKT6PXSZXHssQjU2aTChUGRKh2+oKznDKiKhC7dE=;
        b=b0OGRG/X+M9JlLjLhQWfcD4Um8DEsxa/aSj1Rw8z6y287WAPFDneNY2OpD0iR6qRcJ
         viC2xgHz0ru2amfByQGwmIlrmudMtbPecyxwP/8QinKmjTqa7L02qJyNq+CwsAiKCNPV
         fOu/+h2zap+j0gBo3I34Gxg/y89qVX4EHQtN41UI4Cec6U1EyZZ7XghadsTtQUfUaW1d
         3ssPN55Nl2LBqNc5bvTG1nODdHpixcQXiU1S/RItW0GIi1VmLWhVqYRHDEg5aCKhpPMC
         OPMlodrj0rQMQ0qV4amdVfodsLjKNZwMfNsXGNyzpefbjBsS4+HP+gYmFhpyl6qIu0xG
         w1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eElKKT6PXSZXHssQjU2aTChUGRKh2+oKznDKiKhC7dE=;
        b=gUePh8xBNURqalBLw/2/0LbYNTPSv+E2Ezyv40DYmZPVmYW2TlhcfOlS3C1ILenu05
         thne90BKySGMO1M6LJzkzJru5iLjdfrwLz1xcKghd3CypyUdlltWova4LCcQ3kKEwqyo
         dTdVwO0QhrfztkHv2msViReG7ulYs1q3XXw6orAMpC4WjIzfmzgjDp3cA8xSSPhFyPo/
         4LRSUkT1+L2654cD425LpRic08fLFjsQMgin/Q7C5qS7aVWziiGCXKEcBjms4OwRfwui
         eWbTFhCF4yckh3j+HJMVYYWWNdo/30ThTwcj1qFPIKMAQqWeHqA1cInXz64nwkjjpS0d
         Peeg==
X-Gm-Message-State: AOUpUlF678FvN1CduSWLe8pmvFpki/OTLrfq65Siz7LubMg+qwhqbTJi
        oelOuuQGfkNT0m8lD5ul6wU=
X-Google-Smtp-Source: AAOMgpeMDubCeTzsgqoUQI1r7U1D4lc24NdZBEO+yIdZqIKAIrgjmE2m9qdbHnMFAQ/YzirOk4IK4g==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr415857wmd.6.1533057436976;
        Tue, 31 Jul 2018 10:17:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h2-v6sm3100205wmf.28.2018.07.31.10.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:17:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
        <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
        <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
        <20180731161559.GB16910@sigill.intra.peff.net>
Date:   Tue, 31 Jul 2018 10:17:15 -0700
In-Reply-To: <20180731161559.GB16910@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 12:15:59 -0400")
Message-ID: <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +...
> +		} else if (cmp > 0) {
>  			/* path2 does not appear in one */
> +			score += score_missing(two.entry.mode, two.entry.path);
> +			update_tree_entry(&two);
> +			continue;
> +		} if (oidcmp(one.entry.oid, two.entry.oid)) {

As the earlier ones do the "continue at the end of the block", this
does not affect the correctness, but I think you either meant "else if"
or a fresh "if/else" that is disconnected from the previous if/else if/...
chain.



>  			/* they are different */
> ...
> +			score += score_differs(one.entry.mode, two.entry.mode,
> +					       one.entry.path);
> +		} else {

