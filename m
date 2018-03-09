Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8BA1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeCITGJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:06:09 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33688 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCITGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:06:08 -0500
Received: by mail-wm0-f52.google.com with SMTP id s206so4680018wme.0
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kOmwnSckBdzZU/fBOZn/8iDPjHdmn4LFAO+NktuqhLw=;
        b=ax2ATz5h4vsd8CDvAtoghlxRQqCMwrZj9HktBPiyastO7NHeI5RWeAteQjrIeaK1Yp
         m18PPbRalQi0yG+gdNE2ZbkSh3XIHd/NYVnd99d1O5dud63dKp0HcfxCgqmz4J/rm9+t
         zo7LyZaXZv5wfnqzbWRAKxPWfYA45wifqcNPpaNEEfsSuLVE8yCuNe+kmPdXaBNPAi6w
         bLxWujfGshgOh5Da1hfHg0mckRI5MVHPJ9i8sMRWaUSqmQLSfSnSHEnlY92+2PZzbKdg
         DeM6GlHgZrfnLKbeXAoSD9Pklq33y3ZiWfeawZ/sNNJgKR9EyuqUSw9W0obGl/r7oj01
         Ctow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kOmwnSckBdzZU/fBOZn/8iDPjHdmn4LFAO+NktuqhLw=;
        b=dqg+g81tohL0enL62XKNwSeODsQ8ahnlJ/GAkQ7Nql3NFTbRPR/h74s45vEvn90Kr1
         rAkYNdz/jDQLpo/gHVk0NcJRfKxHWByqzljpCXdJdLXUQX27E/YORuxvnMqcGouPiVsm
         31DOANScxr9ZFNjDzLfbeybUN5jWJJskWdTyvuvpKsphbxw0FEmXU07mbcuDdNqjnBNH
         DnuKUg9o081BWa450+ds98/KID3LdicVf1IOT9xX5n4CcO2tBiTmGPx+T9UHmp8Fzv/K
         XlRkoUw5s+5yPDSi5fE7y3kztirj2/e5CEZDTFJl1r3l78+DGyvYV62cUg1I1WIZCsJe
         PWjQ==
X-Gm-Message-State: APf1xPAoSRjtqC30/xGtBo4N/cfWABg7d7cvG37iRxcEFMddPv7YT6Go
        opKRqZqQmc5XXEMquGDkXr0=
X-Google-Smtp-Source: AG47ELtefju7Mc5xzkhLRYaQ9dEQugkZsZgjc2+03Byveoz+lmSa4IkXAkJJPlOS9R3RNwT4OVEZWQ==
X-Received: by 10.80.245.136 with SMTP id u8mr39699008edm.8.1520622367171;
        Fri, 09 Mar 2018 11:06:07 -0800 (PST)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f6sm1199384edl.9.2018.03.09.11.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:06:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git Mailing List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-4-lars.schneider@autodesk.com>
        <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com>
        <xmqq4llq88ms.fsf@gitster-ct.c.googlers.com>
        <7920610F-8B51-4E8F-83C6-7B29D0EBF852@gmail.com>
        <xmqqmuzh6u8g.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqmuzh6u8g.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Mar 2018 20:06:05 +0100
Message-ID: <87h8ppqdb6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 09 2018, Junio C. Hamano jotted:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> I think following the boost lib makes most sense. Therefore,
>> I would like to go with "istarts_with". OK with you?
>
> I don't care too deeply; if we took starts_with() from there, where
> what we now want is defined as istarts_with(), then that sounds like
> a good thing to do.

I don't care either, but just a note that we had this exact discussion
around this time last year when I added a starts_with_icase() [1][2]
which eventually got dropped.

1. https://public-inbox.org/git/xmqqpohao2hw.fsf@gitster.mtv.corp.google.com/
2. https://public-inbox.org/git/20170326121654.22035-4-avarab@gmail.com/
