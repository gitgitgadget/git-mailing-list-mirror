Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FF41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJLGOv (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:14:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeJLGOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:14:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so11399813wro.7
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uADxuNd8TPwPloySTXfxEJwtFUwLSMle3PTdnO03upI=;
        b=LE43PWiLOjGWZs2+CsAy76qLWGOg2IuvYmkG91YRxWvCIXFVtl5mLUgxixH+zFEMQf
         Iz8lANYmE7ckzPAL59ugHl5gPq0aId8/ls5nd47BF7M6CNx/yeDqpIONdBOJtEDFSnq1
         2q0RGyuBMfZigtybthn53tewD+q9qVWR1fXkE/WEc7kqnW9Z7EpD+Y0HP0iZIxEMV/93
         X3e+7wSD1HCVnn1pd1L64I7pH5ePLTh+hYinaYc5quhOPk591yzhSbgrruEFgEs1D+RA
         SkyBa6j//5km+6zLGO5jm+3UpquD4x7xkTnuXE+zipsOpefWQgcQjl0eWlH3ylUPG/z5
         h0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uADxuNd8TPwPloySTXfxEJwtFUwLSMle3PTdnO03upI=;
        b=kDpjcKMyaIVo/SMX+2P0j/oC8J2A/kQzCNAjRwHAO+wjRliuXJGL/pUaISNZhKTXSz
         wkNYWfOx+nrbCM2cwjSEG/Cke+dlZqGp3bdEyl7wBnwZWxrWgJ7s1SvcBVJcJ6W7NOOQ
         eVGxX6cbDttHGJakDiSJziS4aj5H4QAjfJFrORURc5rRR2NlZsIVnta7NtQ6m2g1yZ0q
         H1nKnJr9nLW0+r1eEp4kgkWfZYKJGW3uJTulngz6Vxf1rf8fbpgQrC/v+ee43gZtlSaZ
         yec++xLCJlCT0UJ/dgnlSmgHfOcLhmpJrjdj6gjFjuFj3+kAMLvVUk0pLetIZZmav4Ui
         2ilQ==
X-Gm-Message-State: ABuFfogs5lH3A20SSA0PADo4rPhbNndeDaUOsIgtNyi45vvEX6WwUpvl
        4HHTbazBtsKZZAjD7J4KH+ajOO3TT7k=
X-Google-Smtp-Source: ACcGV60XSuBU0Y45wTQlHTlcJMPVR2ty0NrKLV5HZNEyPucp7MeA5Tg9hBfMOqlFh5cLVFM6WS8k6g==
X-Received: by 2002:adf:c187:: with SMTP id x7-v6mr3113975wre.233.1539297926931;
        Thu, 11 Oct 2018 15:45:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n11-v6sm34079549wra.26.2018.10.11.15.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:45:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com>
        <20181010104145.25610-3-avarab@gmail.com>
        <20181010205505.GB12949@sigill.intra.peff.net>
        <87r2gxebsi.fsf@evledraar.gmail.com>
Date:   Fri, 12 Oct 2018 07:45:24 +0900
In-Reply-To: <87r2gxebsi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 10 Oct 2018 23:23:25 +0200")
Message-ID: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Oct 10 2018, Jeff King wrote:
>
>> This is much better, and I love the customized behavior based on the
>> object type.
>>
>> I wonder if we could reword the first paragraph to be a little less
>> confusing, and spell out what we tried already. E.g., something like:
>> ...
>
> Yeah that makes sense. I was trying to avoid touching the existing
> wording to make this more surgical, but you came up with it, and since
> you don't like it I'll just change that too.

OK, for now I'll mark these two patches "read" in my inbox and
forget about them, expecting that a reroll of 2/2 with improved
messages would appear not in too distant future.

Thanks, both.
