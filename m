Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087661F453
	for <e@80x24.org>; Mon, 22 Oct 2018 23:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJWHY5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 03:24:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35487 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWHY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 03:24:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id w186-v6so715520wmf.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5pwrpxcTZAybPYKyVgwN+3hW6e01bk0mOz6Vx8mFyzg=;
        b=n5773xhjx1WRf8+wdJPIgHYNxlpgSObc+NmoFG7j7ykBhho6lxSa8oCPZUfb64FUV7
         ZzqaVLIwble74Z3tHpv0jOBhTKsFYYj28Opbm0gg/9sk9a0p31+fIJdkSPzCkXA3F9D1
         Qm9UwNhH/it8oc9pBxDJYYEY0W5CJPhMaPArvSDoRLFRUYgV40qy2x828sno6iCNZhAu
         imBP7o7hUkqMgbGjiFeHM+wsd/XOQvW5JoFAtlyNyx9ggqbd5NiZojHAYFx4yDF91fCg
         TtkUGE2K81AjWCEZ918rcNDn5YIoTDSa4kdC+erweLnesLdkZgFB5qmlWoufHyVvRvXr
         Tw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5pwrpxcTZAybPYKyVgwN+3hW6e01bk0mOz6Vx8mFyzg=;
        b=Eyv4U+og1s1Btnx/nVOCnsf+rpFOu/jMjtWdw1Gpi+c6gUng6Eh81Aq7CDtxgInmB1
         V1LsvVGqJ6SHHsr80Tg+NBxP7FoJPB7frcEviZ+jUCpj5qTKKyT4QbCpdOFl1AC9Io9A
         JY7nYG7KyFXP8j+cJFYYVN52B1WN58RcedNqyAIJxAh8pwIWxkPKIFc63OJWEu0eH7sz
         LvO+cIdgboQbWN9mk2Cf5iNOTUTbljd/N+rcH+khWvZIDatWiKELOrFBoi32YM1B6Ryg
         L2NLxA/umeAZxJ+CH+mlV7/Pux0IAlYM/YR1tvnWSDvMUvqpFhlfj2atB3FDfaeBdQWR
         9+2A==
X-Gm-Message-State: ABuFfoh691n1qFFyjqc8u+dvU71mXvC85GdVw9D9ethABJx/QvJR+sQL
        ZyXGgEiVAgfNLoWgxnucb3M=
X-Google-Smtp-Source: AJdET5cUBgfsvoUePHJIvuakBLZN2NxWfag/0xBWg/WSQ29XNZTLFvGZBHAY1dmf6o1yeV2Jo96rWg==
X-Received: by 2002:a1c:a345:: with SMTP id m66-v6mr18362620wme.104.1540249462893;
        Mon, 22 Oct 2018 16:04:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4141100wrv.46.2018.10.22.16.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 16:04:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com>
        <878t2pd6yu.fsf@evledraar.gmail.com>
Date:   Tue, 23 Oct 2018 08:04:20 +0900
In-Reply-To: <878t2pd6yu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 22 Oct 2018 23:09:13 +0200")
Message-ID: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> So I think the only reason to keep it compile-time is performance, but I
> don't think that matters. It's not like we're printing gigabytes of _()
> formatted output. Everything where formatting matters is plumbing which
> doesn't use this API. These messages are always for human consumption.
>
> So shouldn't we just drop this notion of GETTEXT_POISON at compile-time
> entirely, and make GIT_GETTEXT_POISON=<boolean> a test flag that all
> builds of git are aware of? I think so.

Haven't thought things through, but that sounds like a good thing to
aim for.  Keep the ideas coming...
