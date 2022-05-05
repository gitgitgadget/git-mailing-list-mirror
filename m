Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7574C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 07:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiEEHKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEEHKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 03:10:10 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271827FC0
        for <git@vger.kernel.org>; Thu,  5 May 2022 00:06:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m11so3478553oib.11
        for <git@vger.kernel.org>; Thu, 05 May 2022 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/HCULzFKpPAF6e4fvb8qW/ohMPg+qSkDu94jeUDnhAk=;
        b=OkVBoEKZI1SQClUt6zsJ5KYJZYvsYH/+bm2o61Wc+S/zCr+kNa6Pp7j1J5N8x2cXQg
         4UjWvsBPWN87syKHgwjlou1V2WnWnZYrcg1Eo9IOEU900ZdfASn6DFzFGtASVaSckFU5
         bjelM2zyTdRfxMJzFXn30ZfB+qOOXvN6Eby7R3bvroSSOMbLWvkZWBQRp3Px8eifaVeh
         J6fPVCROdFmveOCRSM5+4y5Y0kw8M2i9oPB+9bxhF1s6++x+ja5JPSyhHlQ789q0T+ks
         92xZnid4TXBNXcvHAO7WGjbqQD3+Upjm8vpZVcQBzILS+0VoMGM1SgwW2SWOfyEBvkqS
         RO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/HCULzFKpPAF6e4fvb8qW/ohMPg+qSkDu94jeUDnhAk=;
        b=2NlIZ/hRwjA/ppbwursHhea+su/QKaM6Z0DuD6UolTi2e/mk4USPVk3rYOoSmsfnC5
         bMm/Rj4lgV2Ro1H8WrRjj0Rieje9woGYcZIqgHB9LVEkv9GshKDUNp0IoIQQec5gKflJ
         VZoCIcTfu3/bDvE5+ibObzgYA9zgwjfFF0CLOT2DV8m54vjYo/XCQa21VbJyMfKvMlC2
         v4EksR61Pjtuey/VlZyPBf4bMnlC3h0aUNfy+E5RWQ6pwnzDrgkUGToecB4h65KFAlPy
         jcfWZDGub+WOUoHoixKPSO+1FqaB0k3+Bf7hr43iqDhp9wpEagfi6u7fU7Hx26FSFQ8L
         cgOQ==
X-Gm-Message-State: AOAM533B0y/LK4fv4eddR0qO5LFuRx1QgkZ/p2HrMoQIyrP/UJaLed+C
        ReiNNANOOmhF1m3JoBnmAWAK7ClGuZZN3znu7MEwlruW
X-Google-Smtp-Source: ABdhPJwrt6srbjgMZ1mCHogQGM9kUC6of/NJvNxbXon1S4QZ63heBoZb6fgypRCTHuHhAJjQg3zfZR+KMbtx8vCya90=
X-Received: by 2002:aca:be57:0:b0:326:3a95:a51f with SMTP id
 o84-20020acabe57000000b003263a95a51fmr1678885oif.68.1651734391386; Thu, 05
 May 2022 00:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
In-Reply-To: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_Gr=C3=BCn?= <christian.gruen@gmail.com>
Date:   Thu, 5 May 2022 09:06:19 +0200
Message-ID: <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
Subject: Resizing panels in the gitk window
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resizing panels in the gitk window leads to a error message that=E2=80=99s
presented multiple times in a dialog:

expected integer but got ""
expected integer but got ""
    while executing
"$win sash place 0 $sash0 [lindex $s0 1]"
    (procedure "resizeclistpanes" line 38)
    invoked from within
"resizeclistpanes .tf.histframe.pwclist 1834"
    (command bound to event)

Is this a known bug?

I=E2=80=99ll be happy to give more details.
Best, Christian
