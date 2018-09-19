Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C271F453
	for <e@80x24.org>; Wed, 19 Sep 2018 04:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeISKRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 06:17:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39925 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeISKRV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 06:17:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3737800edi.6
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=edKGZR1C+wzchyXz0YnxeGHbUnx2LzgMrWUe9maJRUE=;
        b=rmiNRdO5qxZ6PFFFkQR5G1WJP3ywfeSElLQQ4AWcxL4XUoQ5cvtXYrCJKfBpThITrU
         fCChhNkl16+weiLhMWoIc2cxYax/0nWnpENi9XbwWAvoEL8F3UyL74lwIY6V59PeO107
         5wh83NzelbrOqMlFpxfXQ/HPLPFUJq3FsE2CVPzdUtzKjWG8m8lUXaPJkYbfkf5AmhwO
         t9jIrYLMAZSjBEsLg6JMcXR2r7Gv4ry2eA4x8AOqLeuIqiY51Qx5FzchlPz/D4oGsh61
         aX+UtrawvB1//57QYFIJswTqziJth+FcXEKDImWb7M98EotdLOqvVy/8fjzEuRGvYuhs
         NCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=edKGZR1C+wzchyXz0YnxeGHbUnx2LzgMrWUe9maJRUE=;
        b=emsalLfb8jEylFIbezFYhZ7fCU8SFoawQ27Hdgv5k6BfUKLhYMS+teAy+VSnaxODkl
         Fjfm7qu2PkOEs4QrwrSmbphypL4k7t2Lr9QyDMDnMW4cGjsAVG+PeXyqGbVvvvsZdnIN
         1Aid52jjvd1gD0nd1TO66ZEiesft+v33fEXRlHgGShAZfOcjB++6E2fvjtLTb2NXWMFn
         hSTiSw0z1NlaK73OAccLXUmMq0i5kC0wqj5euqHNUGtVSZU96zedRftOoYr4Lo0GtU3z
         yUQCjXALh7j8aV4DGXb/TbjJ0isdxG30UXMlftQ6Zc3Z9q2rByot9YaMhO3vCQRxf48z
         bFEA==
X-Gm-Message-State: APzg51CiqistiDs+rK/rDrtBXvet5S497ERUo+M5O6BtGEv08NZylhzm
        Ep9uvFqfpDdJ9lSLUulpItI=
X-Google-Smtp-Source: ANB0Vdbc68twdoe3/6gnOUlWIDhUR4cFdJOX0wg4TuJuN0nsB+r858QqcCOKUztAWxEkizGG7HXunA==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr55121227eds.27.1537332076322;
        Tue, 18 Sep 2018 21:41:16 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id h40-v6sm866515edh.88.2018.09.18.21.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 21:41:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config doc: add missing list separator for checkout.optimizeNewBranch
References: <20180816182653.15580-1-benpeart@microsoft.com> <20180918053449.14047-1-avarab@gmail.com> <20180918171317.GB15470@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180918171317.GB15470@sigill.intra.peff.net>
Date:   Wed, 19 Sep 2018 06:41:14 +0200
Message-ID: <87va72jdzp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 18 2018, Jeff King wrote:

> On Tue, Sep 18, 2018 at 05:34:49AM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> The documentation added in fa655d8411 ("checkout: optimize "git
>> checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
>> needed for the labeled list separator, as a result the added
>> documentation all got squashed into one paragraph. Fix that by adding
>> the list separator.
>
> Obviously the right thing to do, but your patch does not seem to apply
> on that commit. Looks like you built it on a more recent commit that
> also has checkout.defaultRemote (i.e., probably 'next')?

Yeah, it's based on top of next, which I was testing at the time and
didn't expect that conflict.
