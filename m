Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118DD1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJ0PfC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:35:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36328 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0PfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:35:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so3269978wmf.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1YMn8KIv5jJ7CspIVoXes9gfFJ3d9BMUGSWDJ+STHc4=;
        b=CPtBmUIQ99dgjTqcwSNVbrKcCNzIfvlICvYqOmzx741L+AthNNm0rVMlYTXv5QnDQI
         mM00KTpeKxnBdmFcXPmtbonwGdH8pIhxeCrCexB480kXTwVTuVWNdoWudPyO6DwE/VMV
         ckliAjVLKBuDo8jYL9/QXrOj+wUszmqkTP7tRdqvOWEA8Xt+PEkDwNnNIguAocqPkJCW
         TwUN5Zoqhm8zafbolva/009S+231wQXvODEqLpwV+EBmIBPmxqMvwI31fKRJketjhbh4
         +vjuZlULtQonOWqbYTTlkR+mb1buTMoMe4RHY8F1vI5PzaGDy//f/a+L1iKRXKJQWoQS
         eMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1YMn8KIv5jJ7CspIVoXes9gfFJ3d9BMUGSWDJ+STHc4=;
        b=F/HsdTeAGbfUKIUs7CaJFrPlaM35sFpz+KuarGwqgihESik1at4qt0wojg4QCFaNqx
         Rgs7p4iiMHf2ItjgaAAQhvcnIL36s7+aGhrGhe1z8RteK5EhgCvG2udvn5bzBmazAOjo
         S3lwA3oqhSqChWAlzHlFYXzG5DDPiv3d0m5nAF4K0LZK8fCYzOUO246wvLxI3oQashkZ
         Oponf61KgPpABdLxBAXH6v39zgpdR8r5RZrlmCDpxW7hgV/JP3EHAgtykTUXUk3Lsv+v
         cUBjg6txATblH019qBXPdJFkgctRGrjZ3g9WQ1rNoZfvNvpAaoMN7A2bCb5LpD8bogYv
         /MBQ==
X-Gm-Message-State: AGRZ1gLsKfLC3s5iglMXYCifEb82f1jvNapPjqAGVpclpsG7OUDNTJX7
        107nFJxgVGVZMIRzdk+i4pM=
X-Google-Smtp-Source: AJdET5eSLmZBnX0SVtPHRl7pdDhsiOoOCzRDdtvg2N+R/8U6CVnvc8OZbulQEFd465IheRN9pzmRvw==
X-Received: by 2002:a1c:1752:: with SMTP id 79-v6mr7801245wmx.145.1540623302688;
        Fri, 26 Oct 2018 23:55:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u10-v6sm11227707wrt.59.2018.10.26.23.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 23:55:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
        <878t2pd6yu.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
        <8736sxc6gt.fsf@evledraar.gmail.com>
        <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
        <871s8gd32p.fsf@evledraar.gmail.com>
        <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
        <xmqqh8halm20.fsf@gitster-ct.c.googlers.com>
        <20181025062037.GC11460@sigill.intra.peff.net>
Date:   Sat, 27 Oct 2018 15:55:01 +0900
In-Reply-To: <20181025062037.GC11460@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 25 Oct 2018 02:20:38 -0400")
Message-ID: <xmqqftwrc20q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I.e., could we mostly ignore this problem as not applying to most modern
> systems? And if there is such a system, give it a fallback like:
>
>   /*
>    * For systems that use a single buffer for getenv(), this hacks
>    * around it by giving it _four_ buffers. That's just punting on
>    * the problem, but it at least gives enough breathing room for
>    * the caller to do something sane like use non-trivial functions
>    * to copy the string. It still does nothing for threading, but
>    * hopefully such systems don't support pthreads in the first place. ;)
>    */

Tempting.

> I dunno. Maybe I am being overly optimistic. But I strongly suspect we
> have such bugs already in our code base, and nobody has run into them

Yeah, I tend to agree that I would not be surprised at all if we
have many such "bugs" that triggers for nobody on modern platforms.

