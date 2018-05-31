Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3661F1F51C
	for <e@80x24.org>; Thu, 31 May 2018 06:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbeEaGwt (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 02:52:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37309 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbeEaGws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 02:52:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so52047273wmb.2
        for <git@vger.kernel.org>; Wed, 30 May 2018 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gu8Xat3Y4csDVOw50q950L9LWm7rb9qrqQkler13/9g=;
        b=L02bdB/pyUTenDENSmpBjVHCEsqdSUR/mx9uRfM1tIqlhOOF76h2BZmZaRYN2yKvh1
         vw1pIax6Ey6+rCKEK5/jSd6TB2Ft3zr8StSP3ziZnCNSKFSdQ27DJ+xUDd8Zi7ZYFXcN
         +z60Ac5Ovi6rZjRTUwRRAipMBAA542K3SEQZxe3+wo4tk6aByR8ZfEaiT5gtjqyhPFF3
         VJZWebM5ZhAvQY5bP88pHH5eXTOqDkH2nn/y7dPUh7jHt89YbbGZr318mDkpKPPCJQbe
         8Hoajq+3XoowSVjewwUotPvoHmoGT1CKq1P/5htzVXBT0o30nF6qlGIZjcYO37eLo4e+
         weNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gu8Xat3Y4csDVOw50q950L9LWm7rb9qrqQkler13/9g=;
        b=uU8f+ozAk3MAxqlBj2Ul8g5iGOpsBt6Ld+9AV6+KzyySFPPo/mUOxHaLaXbjcbLEoJ
         AIMXnXotFk45GY4C5jw/tZnrbSAQt90eiyrL0YBfroAClbCmUw6Iqa8gd4lPbE86EwJ8
         0U0l2PvzDJsG8pErq/RLTlrMOrKGukWpZmQvImKLoeThznqpvXhKsmIXeM0mNetl84/N
         8l/5qYaz4KCifjS4o6BTqLemWks1+kulTHo8v6Ks/0I7W2vHqIHZRwjYxihasTu8/cdv
         H/ihSlAebr8XXF7PNZBNudSYM3ZVs1nk5mUB5t2MyIXAkjb0X4a3oHJYZ6xNFYf5gWuc
         1C0g==
X-Gm-Message-State: APt69E1P+efup63NsPurTIVAoyE7/OmcCmv/2OLgpuezyVB2BHNmjNjX
        V/MSjy2zxUOIZi5t3nMLeBkU6ZMZ
X-Google-Smtp-Source: ADUXVKLC/VO7xLXOLT2r7kl7hkGhax2L+XAYQwwWDbWoZqLHnN/WZe33Pog7y6fjQoa9Uh4386fl3A==
X-Received: by 2002:a1c:e619:: with SMTP id d25-v6mr3131776wmh.23.1527749566748;
        Wed, 30 May 2018 23:52:46 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id u7-v6sm21101858wrp.44.2018.05.30.23.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 23:52:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
References: <20180529211950.26896-1-avarab@gmail.com> <20180529212458.GC7964@sigill.intra.peff.net> <87a7sif7is.fsf@evledraar.gmail.com> <20180531055451.GD17344@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180531055451.GD17344@sigill.intra.peff.net>
Date:   Thu, 31 May 2018 08:52:44 +0200
Message-ID: <876034fhab.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 31 2018, Jeff King wrote:

> On Tue, May 29, 2018 at 11:59:07PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > I'm not sure what testing this buys us. [...]
>>
>> Half of what I'm trying to do here is clarifying the v2.17.1 release
>> notes. The initial version Junio had & my proposed amendment on
>> git-security was:
>
> I think that's a fine goal, but I doubt that adding a test is going to
> help much. That's why I say this seems like it should be a documentation
> patch and not a test one. People are much less likely to crawl through
> our tests than they are to crawl through the documentation.
>
>> The other half, which is why I think this patch is needed, is making
>> this aspect of it clearer to future maintainers. Before I started
>> hacking on my recent fsck series[1] I didn't realize the intricacies of
>> how *.fsckObjects worked in various situations, and I think explicitly
>> calling this case out in code helps.
>
> I agree we should be testing that, but I don't think it should be tied
> into this test that is specific to one particular fsck check. Don't we
> already check the behavior of the various fsckObjects options elsewhere,
> like in t5504?

Okey, I'll turn this into some documentation in my re-rolled
fetch.fsck.* series.
