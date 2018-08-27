Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6A81F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeH0XYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:24:14 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43079 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0XYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:24:14 -0400
Received: by mail-wr1-f47.google.com with SMTP id k5-v6so82129wre.10
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=F9++D9OZAF/bDybMoHb3jQIRdqGXpLuUr5o98ZXIDWk=;
        b=bNALi5lum+21ULZMtcNj4HfC6K4FlJO0odr3gCsU7Abf+oaRW36VkUjYKaefbpqsn1
         NGEFasV+KjBmN5bCFtt3OTTLy3v4ceb7QxVaOc656FRgoQnNsKmcqzKQzCCOE9IJc0sl
         YHjW5m6NT72bBCLuvjXxEbjD/oMg/ZaA0wQCmaEXWDWpttpG0xF6GYTaVmDKPQ2Lzg3o
         0Ty7K077ihG23/26fKN0cCajIQl3y8ZM06ob77q/R8uU9nhWSqbXoLqDFntr/vZ/7Ut3
         hejulgg2nNnSOumcJ9oTfy8JDTYrK5kF2Gx9Ao06L4AFP91dkVvPtigC3Xb7WCvydgtk
         9hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=F9++D9OZAF/bDybMoHb3jQIRdqGXpLuUr5o98ZXIDWk=;
        b=Vjja2pQpszZegrOaEe2MxLM5pAZmzWZ8ave8iH7FGqL0hq0HQixxS5i8zea7kcQDrP
         klCQsxjZBSe1fdGbnzuOEyQSu38SHG87sFSoHacG7toLqfvF3plKaUWc8EkQgQspn/1I
         yu2BFwkUf7bKyiErJSDlc6I9LBQIDvPyybKsuuk34yYOtHjJ/9ocaWXZbVTtySI5wo3R
         KTJwindvS49VkBfSCG3qELf8rsQ+mncmDdTnAa165BLI1FcfPNc8HNpp3AS8pUyY1VQo
         BRddvRx8BZNavb7XHghdij9+02Z6g/9N4z2mEVvGyNqQnX8pROWGTGzB2SBWpM9Vr+lS
         E0bQ==
X-Gm-Message-State: APzg51BysJYaYceKdmpQc9bclHJ791he6NCMWF++UDjC0fqR1X95lU0W
        0g54ZpdP9YXdEhQ7kQGxw/IlACfr
X-Google-Smtp-Source: ANB0VdaR3yl3Z5Qb1VrvsS2aoY2LYuJEeulifXuApPsWwMNpjxREdzNBaP+K0VbZpbqFtl0hct7blg==
X-Received: by 2002:adf:b7cd:: with SMTP id t13-v6mr9500068wre.274.1535398575313;
        Mon, 27 Aug 2018 12:36:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm62166wrn.41.2018.08.27.12.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:36:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
References: <20180823021618.GA12052@sigill.intra.peff.net>
        <20180823034707.GD535143@genre.crustytoothpaste.net>
        <20180823050418.GB318@sigill.intra.peff.net>
        <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
        <20180823161451.GB29579@sigill.intra.peff.net>
        <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
        <20180823234049.GA3855@sigill.intra.peff.net>
        <20180824000637.GA10847@sigill.intra.peff.net>
        <20180824001643.GA14259@sigill.intra.peff.net>
        <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
        <20180824025955.GA24535@sigill.intra.peff.net>
Date:   Mon, 27 Aug 2018 12:36:13 -0700
Message-ID: <xmqqbm9nk3f6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, what I showed earlier does seem to have some weirdness with
> else-if. But I finally stumbled on something even better:
>
>   - oidcmp(a, b) != 0
>   + !oideq(a, b)
>
> Because of the isomorphisms that coccinelle knows about, that catches
> everything we want.

Nice ;-)

