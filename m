Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBAE1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfDWWwE (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:52:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:52:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so8314644pgs.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/gI/yCH/c2AMui8221DsOkfpXmZwukKkQVhp+QufGKE=;
        b=mvFHb1vyGzBhSo3p+PNnikgzlxYFKuX5IDQDvH1XHR8uMIaSg7rK4h028Gp+hBsAfG
         kHoA9glvbegfRUjIlxELE2KneWXbdyzfgyZf8Gg7L5jBZoc2Kk58WNeJxkHJqdKOtsWu
         pwl8H4/ke0eDU7uGZJFE1px/rh6fpH4aZNDLgOk8nzKC1UMDP+ecD4zJhhwNuZ3rOJmz
         tRfZeGnvKABNLeIVEQun/2MeCJmSRbyUr54/h16u08WmgrDH/J1M5giG/nVVCR1mgtuP
         HRnnvJhhcP6o3cF2R1egUUFyMmV7yzSchHgJQxR2JNKIvwSQrQANClhPFLoai1jn6ang
         OmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/gI/yCH/c2AMui8221DsOkfpXmZwukKkQVhp+QufGKE=;
        b=EhRWI4uy3eZuIdTdSU5dol9BQQTWa96UmB5Pc1npXeJO9SHwRFuuBHzN8TjG6EXSfi
         Uj7ReRSzLS/rhsQdXV4/dqZ3uqysXS2Ww8SYXbgVpFDti1jTmu5D0NCQEBhpDzv5HIAH
         slOgwU17IbemO37JFPDwf8rLwYcc+Q+BLxCXNByOi9NMyOsEi5KOp2u1IrTG9hXIWhlf
         Rb5DfY/QeaHgrlCMwkQDwZOH5ZPlKHNSKQhSaEshI5/mLwlKboe1EdcQoqJQGDDOz1BO
         XWVhNRV90R6ijoY76+gfxGYbiQn/fXsioPeCMbB6wujAD9tHiUq8OErWOMFrOX6eDVPV
         zWJQ==
X-Gm-Message-State: APjAAAWP9Wj7KmDK8RSAbmBOCIluSvA7c3VJndX33IQZiT60osGFjjnd
        /h1mYeJaeF72mFC7OM7ZtJw=
X-Google-Smtp-Source: APXvYqycVWoPGKE+zVSuYt5jQpBczx0S18BvPQlA+p2TEGUt9Izj2J+5nFq1GqAZAuwQWLTYrAVPBA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr14607749pgj.208.1556059923132;
        Tue, 23 Apr 2019 15:52:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f7sm8022755pgp.77.2019.04.23.15.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:51:54 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:51:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
Message-ID: <20190423225152.GD98980@google.com>
References: <20190423053130.GA13162@sigill.intra.peff.net>
 <20190423203801.29156-1-jonathantanmy@google.com>
 <871s1stlf4.fsf@evledraar.gmail.com>
 <20190423222249.GB98980@google.com>
 <87y340s6ax.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y340s6ax.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Apr 24 2019, Jonathan Nieder wrote:

>> Do you mean this for when a pack is self-contained and contains all
>> objects reachable from those "tip" commits?
>>
>> What would you do when a pack is not self-contained in that way?
>
> Indeed, it had been a while since I read the first version of this. I
> was assuming a "base pack" use-case, but it seems it's narrowly isolated
> to just "N packs each containing one big blob", right?

The demo in this patch series covers the single isolated blob case.
The protocol supports the "base pack" use case but many others as
well:

* daily "catch-up fetch" packs
* "base pack without blobs"
* ... etc ...

Thanks,
Jonathan
