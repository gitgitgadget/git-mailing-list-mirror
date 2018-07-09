Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D463D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGIVKU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:10:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35324 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbeGIVKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:10:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so3145977wrt.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YL0KBQUsEz9UoKYsOYJQDJu/XhaNt/5+vKQHz5uVnSE=;
        b=ZtiUUKZX2/DyzXdqNKiPjzoF5E0fJMhWaBHZf3eVQWkHjI6UUQKj9uc03MX2fuejvn
         7s/nYiFwaaM3IC6gO3JApsKy8f1e7mE7XRH2qBu5rR/lhMH1HPVoOsqQvAroCfI2w2ZG
         yzQlwleWRMd+TGMCNOvy7BANZ12LeYzwNooXxtw4kkSa9oYzsGaw72jC8xPDlhVhd8MX
         sgSo+Vah5o8b1instr14G2cjRaJLIn7Kp3ZJ6nUlyjuFNmUbLaIC7+TmnBWCfG1ZjsJR
         X4uU3AO9M2dq+DuE8+JrHVBHNyv/IFms+rPt3eueZOgdh5Izw2EJNq9NKMPBRGJubJse
         EzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YL0KBQUsEz9UoKYsOYJQDJu/XhaNt/5+vKQHz5uVnSE=;
        b=Gy3V26UZ7cnutsP9Rjl14x/OyT1EXeUlErcWq5QGtZVj2zi57nVrigR1Dg0I13/8NV
         9U4HAmYFnVq90cFDSjDdXMr8yZcghCpMkb4TD0Dnqkh9CJhkvY3aOQ+KMys+WsBpgbvz
         /fTHM+iDYM8pU+T9zqbQiTnBlqdNy5O2DrvTRSsUtzIga60a5fAF3kyfZt9ahcALckcS
         8r2Wf2Cp8Ivwk4BsWsiGkEBKi25f2XF7ISWVxWIWIdWFSLpO++6ZAKVD55A1nNzknY1y
         CG1MXaPooa8bkh8CRJQ/1aNDAzqHX4LBHuhvpvyks0e4i+8FLpjUu2UJ+DRboL41ONOL
         HB7A==
X-Gm-Message-State: AOUpUlFudQBSYOjMmJnwzQ7CJQ7lwht8LOKgTFVVAi4Ufm84jdV0sKeA
        agnhyO3xxZtBQ1Ys8FhO6vU=
X-Google-Smtp-Source: AAOMgpd2O1aCC7KRViOUsS3X6Mldef51qOyungbvAOTj6jQaVefAi5u4X9pTmaBG+5tGBA/K7mfWHg==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr743982wro.195.1531170617770;
        Mon, 09 Jul 2018 14:10:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a11-v6sm14657216wrp.39.2018.07.09.14.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:10:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
References: <20180630133822.4580-1-kgybels@infogroep.be>
        <20180630145849.GA9416@duynguyen.home>
        <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com>
        <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
        <20180707231651.GB6152@infogroep.be>
        <CACsJy8C=Xs1QY_cMu+H4DR9XovBd5bO-ZC=ie-1x9yZepgUMdA@mail.gmail.com>
Date:   Mon, 09 Jul 2018 14:10:16 -0700
In-Reply-To: <CACsJy8C=Xs1QY_cMu+H4DR9XovBd5bO-ZC=ie-1x9yZepgUMdA@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 9 Jul 2018 16:33:22 +0200")
Message-ID: <xmqqwou4azev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jul 8, 2018 at 1:16 AM Kim Gybels <kgybels@infogroep.be> wrote:
>> Should I post a v3 that goes back to the original fix, but uses
>> test_i18ngrep instead of grep?
>
> Yes please. In my comment I did write we didn't need the repo anymore
> (or something along that line) which turns out to be wrong.
>
>> In addition to not breaking any tests, close_all_packs is already used
>> in a similar way in am and fetch just before running "gc --auto".
>>
>> -Kim

Sound good.  

I recall that "clear repo should treat the_repository special" was
discussed when we saw the patch that became 74373b5f ("repository:
fix free problem with repo_clear(the_repository)", 2018-05-10),
instead of treating only the index portion specially.  Perhaps it
was a more correct approach after all?


