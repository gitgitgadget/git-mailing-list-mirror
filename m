Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175381F424
	for <e@80x24.org>; Sat, 31 Mar 2018 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCaJKr (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 05:10:47 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33200 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeCaJKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 05:10:46 -0400
Received: by mail-oi0-f41.google.com with SMTP id 126-v6so9397697oig.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wq3mUjqvi72rj3I0Uqw7KbGcO7UUPFLbWtzKWJoK6UM=;
        b=ceDhHRi/Yp/lgbgtgl1GrF8EZZ8G8kPYZkLwKJ3aYpr68r8C+zyobU176DJW+ulcv+
         V9T48Eg65JsXS3B4f97Q2u33o6T/gOFlNiAZNpy053sn3HvCUnid+CInVTaqKY8LpSLy
         iPgOfYuK13r9LBjLpBNoZUUUJ+vo6TlWkI0a5+9Ml9oRRVqR9wz62j+gNxH48KLhvLow
         uXW7Xnk97Z7Bj9SW3wWXa+xtWl9VPUqll2PYITgJxUzFLwIPwTxSsufj01KQOps79GJw
         BY8c9ehTo/kQbPicOZsivtvHfleGnjrxplZX8yMpbZ+Oynx/jpTwVV2d7EMwndb72D/E
         YjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wq3mUjqvi72rj3I0Uqw7KbGcO7UUPFLbWtzKWJoK6UM=;
        b=VxlE8QYCiDK8CCeHm8l57rVRQhc87Q6hNKYxFdGp+Kniw3x5Caprt+eRaTG6wj6d2q
         ts6Luua4bNwytlzH5csQWzrME7DmaTxACSuIM2/dC1nRNqS8RW1cugdiJMSRey7cJw6e
         EPuRevKEkjIXKbSM26+VpIzhMLGggIE+zBowKmaKpfEzX/ZBsgip7IOGB2qsJ75qKgYX
         r+K8EALXNysaycup8jnI02UtcnajNubrt5ibBNP++SK4g6bIh89S3U9anWUrbAd9oT99
         v2B2PkJbHn3yCEVHApUzV43otr1EQkfSTAtOK9P2qTKarNjBAPWj3kx7eyu/WtVcd8Ba
         rBGg==
X-Gm-Message-State: AElRT7F+jdcAKTon5xLmmdsgo8+cZM+4c4sQpeKYhuP1BQdBKxY5R3pA
        /1CuB3kLteoej/o+pgTmCcCGoCIyL6Eury9qoJc=
X-Google-Smtp-Source: AIpwx4+A0xr4M07QoyInwtGb7nzxjoz2oBLmZB5QeZ4W6bhFfdVn1FIG4+W92xB7/xMyylCl6VSvzLdtbYF+AXa9cRE=
X-Received: by 2002:aca:f354:: with SMTP id r81-v6mr1132273oih.281.1522487445579;
 Sat, 31 Mar 2018 02:10:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 31 Mar 2018 02:10:14 -0700 (PDT)
In-Reply-To: <20180330212419.GJ14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-13-pclouds@gmail.com> <20180330212419.GJ14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 11:10:14 +0200
Message-ID: <CACsJy8AzW4nkRpHHdS=BJSu1m5rUSL_F+WU719MYB=4TPTAuoA@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] pack-objects: shrink delta_size field in struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 11:24 PM, Jeff King <peff@peff.net> wrote:
> How come this doesn't get a pdata->oe_delta_size_limit like we have
> pdata->oe_size_limit? Would we want a matching
> $GIT_TEST_OE_DELTA_SIZE_BITS to test it, too?

Nope. This changes how the delta chain is formed (e.g. produces
shorter chains) and apparently some tests rely on that, like t5303.
-- 
Duy
