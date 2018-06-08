Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907B21F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeFHWUM (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:20:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeFHWUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:20:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so6167911wmc.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GldY7H9xd2RPPn7pTdtI5RJCor4eILxU/dshPpTypsA=;
        b=n/KevKXmjHNDZWCO4psTMQFW4yMgV52OfxVCJ6dGmZn+Tqg4sKcSzprJdGo3CyFS/l
         r94Q9sOA36gD1sESDJSGAyU2vb+prdgjOM+ehHvqPgIwkWlfwlN0pPBZQ+HlHW+YQ6sW
         dB/qDiuG09gveW5e5PlEzpndY7KL9p8GOOdmZl+JleFz28MPd2IbGr7Dk8k5ey2BKEpU
         mO83NthmyMZqqqpJ02/SPLd9tpbqRashMalbJ0/m/TDqxAco+HnTdNGUHZZES/YrT2Et
         X6ioWX9yTeejYDMkvFEB5RDN94I6s1ep2E33Q5lh31QY0jowNXrO6VO1a02gtOPNTXPZ
         CU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GldY7H9xd2RPPn7pTdtI5RJCor4eILxU/dshPpTypsA=;
        b=tfArrmD1vlUjEd4bKQLIo6UnvMTegg/6QVWshDXg1HN98Y8+L9BQsPwndH2QmvTvr5
         g1hmkF5xYYq0NykSVyN6Wc7ufeQib8bKL1cMhsuIorGsAjA7/QS6LDD5BrsApXG4xefC
         EeMfGe/CFRwm2kDccgHtdeaUon2U6P6Qs7LvE0PHct+RCKPPdAZtwAzE1I3PnZXw5jMg
         SYj3mLkl9ZgPreF5rU4578U8yOpv199Mfa4zDLN4FDzr+hkzoNiqVZiwvQDpM+kpL1hJ
         jHJ2NiI2dpkQ9gG4Tr1psEhdQnm8W37SJiCaOKjOOLEyUWWJBagEImcWyLhrKf74ws1b
         7jxQ==
X-Gm-Message-State: APt69E2+dCz5nJ5xxFm2nN2kIke1q0KRfYz4cDdgGDFReFTftFCoxlBv
        DFu5nicxrORNOrODawB1lck=
X-Google-Smtp-Source: ADUXVKK+oR/EOBfC6aZNUYuAvOmhjXTggUIVQGh4pBHE/uO3UF/ydhlpBhg7mEUR66xURvOqFlguRg==
X-Received: by 2002:a50:8e13:: with SMTP id 19-v6mr8641868edw.101.1528496410849;
        Fri, 08 Jun 2018 15:20:10 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id r10-v6sm7665925edo.77.2018.06.08.15.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 15:20:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
References: <20180607145313.25015-1-git@jeffhostetler.com>
        <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
        <20180608090758.GA15112@sigill.intra.peff.net>
        <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
        <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
Date:   Sat, 09 Jun 2018 00:20:08 +0200
Message-ID: <87fu1w53af.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 08 2018, Johannes Sixt wrote:

> Am 08.06.2018 um 18:00 schrieb Thomas Braun:
>> I for my part would much rather prefer that to be a compile time
>> option so that I don't need to check on every git update on windows
>> if  this is now enabled or not.
>
> This exactly my concern, too! A compile-time option may make it a good
> deal less worrisome.

Can you elaborate on how someone who can maintain inject malicious code
into your git package + config would be thwarted by this being some
compile-time option, wouldn't they just compile it in?
