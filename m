Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F261F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeBIW6W (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:58:22 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37670 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIW6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:58:21 -0500
Received: by mail-wm0-f50.google.com with SMTP id v71so198640wmv.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=w6d84J0gH7hCEh19PmB7DbGfCt/BSq21flB6rmZqEQM=;
        b=gsqQoauHRq6SbV1k/1V1TqFtBqjYm83f4wO/uLXfCt7TtC6ewRPOWbuiEtwrKW3pmw
         Q6azUqlZqTWzQMOJRYGzs6hniipWLLkrPK7IqwdZrm5GTiCpgWFgDXBUQm1mI1+ZHIjP
         bAyfcZGNEIJHJPfJUUsggI+56H81GKu+Vlha2d/Q+UCLcFl/NFp5l0Uqv0+Kq/Y5/P4L
         rbgfWMWnxaKPKQCEzUDMCDMtPOb+jI0FJknArKs/Qw17MCXotdzdFyDEHZC+Ikuuo2L3
         9RGJps48/hUpR2VrKIR9KOH+jq/EeX30UCBKa9goG/PvWqQ+E5e+k4cLmPyHFjVJlMfU
         my5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=w6d84J0gH7hCEh19PmB7DbGfCt/BSq21flB6rmZqEQM=;
        b=peCd33D5I01RRo4pNY/fl8/4MiyDKOhuTrmOAWFrKbI9u7EGG6nHyLyBz6x52nOzPv
         VPafN9yWV+gz4FMoAIlD+XAwlNUpVgnjCOPXqcyFhA/bzQsInVomnezNvc80VKdE58ts
         P1EEpQSFZUIZT92ruxnkKwA6VS+4LTysAxFBajUTQBFhNdzppBbdOqyzEybjQ/r7Mt32
         XqVz8nnBC4RgknU4uuCmxCCvANOJhpN0xseJQoUcV03KGE1HfmS6b9KlU5nB1sVtXp97
         gpige5EinwyrjLcHtBBlS6spbrpEAOwKncHWJlRQ4OjrD21JD1Pbwox8gSTluvKSqAu7
         2aOA==
X-Gm-Message-State: APf1xPBWDZn8guKVG9LVluIdRM2lUxvjOvi1yUtIugQKMR9HmvsDsHd8
        X6/mMfbvEwj1InkDCcZ7ooNKIcT2
X-Google-Smtp-Source: AH8x2272Il0Zjxd4YP4o09ZVNZ+buloLDTuS11LVj75M7G/X0VNGH3kBLlNkJ57HPj26Gi+K867GOg==
X-Received: by 10.80.135.196 with SMTP id 4mr5556162edz.262.1518217100337;
        Fri, 09 Feb 2018 14:58:20 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id d30sm1730080edd.90.2018.02.09.14.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:58:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] update-index doc: note a fixed bug in the untracked cache
References: <20180209210431.409-1-avarab@gmail.com> <xmqq6076xabo.fsf@gitster-ct.c.googlers.com> <20180209210431.409-2-avarab@gmail.com> <xmqqwozlvnij.fsf@gitster-ct.c.googlers.com> <87mv0hbykc.fsf@evledraar.gmail.com> <xmqq8tc1vkua.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq8tc1vkua.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 23:58:18 +0100
Message-ID: <87k1vlbwj9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> Will queue with the above typofix, together with the other one.  I
>>> am not sure if we want to say "Before 2.17", though.
>>
>> I'm just keeping in mind the user who later on upgrades git from say
>> 2.14 to 2.18 or something, and is able to find in the docs when/why this
>> new warning got added, which helps diagnose it.
>
> Ah, no, that is not what I meant.  I just didn't think '2.17' in
> that sentence may not be understood as "Git version 2.17" by most
> readers.

Ah, I see. Yes I agree, sorry. Do you mind fixing it up to just say
"Before Git version 2.17, ..." ?
