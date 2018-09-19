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
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FE61F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeITB4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:56:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39166 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbeITB4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:56:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so5968621edi.6
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=57Uy1h7YmKzafG00sJ+V4nxjITLZYuZlN/VR7an1m7k=;
        b=Tcld4oOyMX3Ev0ZWNbQz3nZVEsgL2cwGtmp/8dAmqBiNn1mEEIn40dbYymaxSrKo71
         cMkXZm79I4/ukM9Mn5A+2LuOesOEmhQOToo1ICPIhHeiuZJgrbGAleb5KJi9C0cAb/07
         pSGg9iCd4olTnXY7j4rZsq6OiB77TPfA64SMYgb/CalT0e2iONCWYEXR3c0t+a+trPCL
         8nD2mqoOxGNALbEwtzW71nyMra04vNVB2k31UEp/Bai0ghn7RYCOAkhQmkJWZ22Y3CGP
         4eBaN+HqDkSYXhPk03G64trMAKVytpL4wSDDGt4S+niHXQWI2YL7v3CNz+N+QtVkkphQ
         H5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=57Uy1h7YmKzafG00sJ+V4nxjITLZYuZlN/VR7an1m7k=;
        b=iiqd+mGVLBV+BXvRAYXYOmdIfhc87PoZBGRHWwAtAfDnkGOhWf1r3CaIw6VVpS/AJh
         RaAjuRzhz4ASUS/ZqCYijrJX7EolDuLxC3c6XBN7Y6R6+cIHaHABFoD5E3iP4rhyUH4u
         0esPWrtLKHna3toO/srE3ElyXZOy9DY+AUgoWhoCpglyZFOWUlmB28p2ywAx8fsecLec
         DgszfgvRyxHeZ2HxWnaJmrpNEzwsr7XgrkM1PFEuy6XVgQuq05MlCR2Pu8ESZw08CE2O
         98+lm9rQmsCwIvY6nlecQdfZvLMTbhe0RImcJPLVaPSOKxI7F4Bv0jBIkfOpEUqL/2pF
         lPCw==
X-Gm-Message-State: APzg51DxRKHG2Qcea+cQwwIhC+gxRnCcFduTMBfGYauV6KBCBgzZN5/k
        khiUkY0P9SJshW9FBteL5l8=
X-Google-Smtp-Source: ANB0VdaNPupNe2uFVbCZSckmwdei40G3EGgU106PDrBCe9t6Z/Md8lsmZQofCnZsXt9MQ5iNCbz5Sg==
X-Received: by 2002:a50:bf0d:: with SMTP id f13-v6mr59448023edk.157.1537388216675;
        Wed, 19 Sep 2018 13:16:56 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z56-v6sm2851675edz.54.2018.09.19.13.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:16:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog expire: add progress output
References: <20180919141016.27930-1-avarab@gmail.com> <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com> <87tvmljtaz.fsf@evledraar.gmail.com> <20180919190110.GA14552@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180919190110.GA14552@sigill.intra.peff.net>
Date:   Wed, 19 Sep 2018 22:16:54 +0200
Message-ID: <87r2hpjl8p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 19 2018, Jeff King wrote:

> On Wed, Sep 19, 2018 at 07:22:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > Do we have --quiet option or something that needs to completely
>> > suppress this progress thing?
>>
>> Yes. I also see my commit graph process patches sitting in "next" broke
>> the "git gc --quiet" mode, and I'll need to submit something on top
>> (which'll be easy), and submit a v2 on this (pending further
>> comments...).
>>
>> Is there a better way to test that (fake up the file descriptor check)
>> in the tests other than adding getenv("GIT_TEST...") to the progress.c
>> logic?
>
> The progress code doesn't do the isatty() check at all. The caller has
> to do it (and ideally would respect --progress/--no-progress to
> override, along with having --quiet imply --no-progress if such an
> option exists).

Yeah, what I was confused by was testing this with "git gc", and until
my recent commit graph progress patches + this (which I wasn't testing
against) the progress output was all from pack-objects, which checks the
--progress option, and then proceeds to ignore all of that and just
check isatty().

> Once you have all that, then you can test --progress explicitly. If you
> want to check the isatty() handling, you can use test_terminal().

Thanks.
