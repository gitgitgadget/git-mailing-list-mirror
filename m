Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9FDC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjEPW5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjEPW5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 18:57:33 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D51131
        for <git@vger.kernel.org>; Tue, 16 May 2023 15:57:30 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24de504c5fcso193663a91.2
        for <git@vger.kernel.org>; Tue, 16 May 2023 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684277850; x=1686869850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDeUHNshhX7gzjN8tRL7zGVurCcNPQgGRdMw/Pxl2sU=;
        b=LR1aFu7tX55ewvjndXhyWZumjlZm90V4sR3FSxDbEXh581WvrEufaYZnHLRazZSFWt
         Xd6jQUVlOguW+ePPBg6Ls1GYl4M2j2E+lX+3jB5ftv+5pepKd6zAjAnAy7taTsd1hXJi
         BXw0NgMfo43EVPQs88R8IHXlQr5sJBz5JO2wMnorSpDqcSaH9KkHV0nuOen/6S/hvg3W
         NsgYaKcQNWKoesMh8a7iTYupOsmqXCDC1Fm3UaJGBD1YyRm9KAhauJp59WAwWgGMpRcV
         qZUtrTn1m/MMay1TFbC9s1k087sND1j/8UumomQd1zhclkYaM8XequryJYy/qcpSTLf5
         cTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684277850; x=1686869850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDeUHNshhX7gzjN8tRL7zGVurCcNPQgGRdMw/Pxl2sU=;
        b=lgh+VP8rdACuYEofY3kWzgPnyyzn5N9lIww3XEpuCtamNFg3pJ0Yz+3JlFV7j7Mdl3
         MHIg250ZjVEZtbR/N+J4whUVO5ElDxCAMmWQ+t1eqjDrg/mcoWeBmjmaoEzuXz3yQplq
         dI+CRqcnhxmHoO2pquPBaioXRCZZ+MmBJseiTgGfjtaZrQBcmnFVad0k03CsEQ7aqcUN
         /u0FYiayqLkaGFenm+Kpr02AgLuQHMKhjmd4h/3S/+Vc5+9HHNZ4DPptZvx/vtBCc3TM
         FWrB5lg+iY7jzIxWoYDPDoAPzV1ELyhJ7sQp960ZZE/qdnDHGWfsFVpXIe3W4mwL7/V2
         iRjg==
X-Gm-Message-State: AC+VfDwaeCqjHKTkbe0+59Ctm7DzUsCkk/GGFPoXfaHd9ppg6XaJkHU0
        fGbsAXypS2pSIGM5d8YdNzc94v5QW4g=
X-Google-Smtp-Source: ACHHUZ6Elfd+gwGOOfd2+80kRSiLKPu7A4PDSn/l4vF+J3kgVigwRiso2Eo8tdasETN2INI66ojE5l9ZMTw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:458f:b0:250:5385:26a9 with SMTP id
 v15-20020a17090a458f00b00250538526a9mr10376725pjg.1.1684277850400; Tue, 16
 May 2023 15:57:30 -0700 (PDT)
Date:   Tue, 16 May 2023 15:57:27 -0700
In-Reply-To: <xmqqv8gxm8uj.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com> <xmqqv8gxm8uj.fsf@gitster.g>
Message-ID: <owlybkijnaug.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 0/9] docs: interpret-trailers: reword and add examples
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Looking very good.

> Unfortunately some of the updates to examples overlap moderately
> with what the kh/doc-interpret-trailers-updates topic wanted to do.
> I think I resolved them correctly, but please double check what
> appears in 'seen'.

I don't think I can double-check 'seen' in a timely manner (see "FYI"
below).

> As the other topic is slated to graduate in a day or two (topics
> usually cook for a week in 'next' before merged to 'master'), it
> may be a good idea to wait for more review comments and then rebase
> these patches on top of 'master' when that happens.

Will do. Thanks for the tip!

FYI: I am currently on vacation (in hindsight I should have mentioned
this ahead of time) and won't be back until June 5. Still, I am highly
interested in seeing how my topic branch evolves (along with the
interactions with 'seen', 'next', etc) so I will at least have a look
time to time before my official @work return date to see if I can rebase
this topic on master when it (master) moves.
