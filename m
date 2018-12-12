Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA57F20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLHu5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:50:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLLHu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:50:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so16598402wrx.9
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fCtBiVTQnZVF48VloOVp+74++KF7Ct9I2KeuM6jEaVk=;
        b=ZKeWCQRsvDO+Dn0Zeh+zxGGhvIepQUAz/HoPVuKKm/00mHdpxS+ke0eI6IlCKDZagL
         yy5VRVMeJcdz1reLpNEPF38969msEIU4e3xf149eTqs3uV9VXlpuOMM2kgjg5M0cK61p
         S++m9k7vejILAbzKjoKxNIFUd/LP5FBW6nU7MDMWkWizhbSzm7/1O8hSHBsfszxC7phs
         BWSXONKshoMCTl1CVtQL5W31vzym7N8m9rpPniYk5c8bfoG1eGq11YN1Ul0MWJL484AL
         BL/e34w4IckRH+bN5rT6hsX67C5EIUrpCuhTIZGpX6ZnITV2NAeKbTWhbDESYIybB15C
         NBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fCtBiVTQnZVF48VloOVp+74++KF7Ct9I2KeuM6jEaVk=;
        b=fMuUpeAFPi15Ll+e1rEG0eTqL/6S6I1AywydQ9yWOC8lIBVwb4odDrILh1+WSMHJa2
         yqippT21RhOCBnxMnxmOWqvZX4Re0QAPculn/okVcfxbhPPEMsDofotqglgr52u0DCwI
         jsSQXDoMeY4H3rQgIgPST8S7sR7Cytitu+Yjad4BbU4aXr2CM7p9yyLyh8wr389FCSll
         Z/lOQOJB+xz3e4s2UoRAYlx+V41d2Fjn4F8R+d/av9+Dnc4MyT9dT09/hbdGXta0CQaj
         li5wTbTopL/l4yx1g8CBPR5O4obSJ99EQXryTd7exNemfldUe66uQ9IoC/WWpdbjxd4S
         8mSQ==
X-Gm-Message-State: AA+aEWb8i2Zydt/JIH62dWEUuYuVRnKoO28y1VbcWUpoOT/RzQBkvRPx
        5vX03TryKEeCG6uo1yEiJE4=
X-Google-Smtp-Source: AFSGD/WWK554BMtVfNSZzRuSEQLlvyiRR1RDY/VpvYMNz9/K0Qa9eexDfgeDaxsTDS2fIVBPjZnjhQ==
X-Received: by 2002:adf:c44a:: with SMTP id a10mr16468036wrg.145.1544601053903;
        Tue, 11 Dec 2018 23:50:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k7sm17929632wrl.51.2018.12.11.23.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 23:50:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] parse-options: fix SunCC compiler warning
References: <87va4cujtx.fsf@evledraar.gmail.com>
        <20181209102724.8707-1-pclouds@gmail.com>
        <xmqqy38xkhvd.fsf@gitster-ct.c.googlers.com>
        <20181210152642.GA16203@duynguyen.home>
        <xmqqk1kgn73c.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BFn7xbJO8G_mTeeHBbZ3J52ZQkSAyrmyxe=BfVaapPEA@mail.gmail.com>
Date:   Wed, 12 Dec 2018 16:50:52 +0900
In-Reply-To: <CACsJy8BFn7xbJO8G_mTeeHBbZ3J52ZQkSAyrmyxe=BfVaapPEA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 11 Dec 2018 16:40:20 +0100")
Message-ID: <xmqq4lbjji8z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I have a better plan: stop exposing parse-options loop to outside.
> What all these commands need is the ability to deal with unknown
> options (or non-options in update-index case). They could register
> callbacks to deal with those and keep calling parse_options() instead.
> I'm converting rev-list to use parse_options() and as an intermediate
> step, this callback idea should work well. The end game though is a
> single parse_options() call that covers everything in, say, git-log.
> But we will see.

Sounds like a good plan.

Thanks.
