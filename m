Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677BC1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 10:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfHGKSj (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 06:18:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44707 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfHGKSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 06:18:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so51939536otl.11
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDLXCyhs8wTAEU1UYv9CyuSUuk2wABNcxI603nGQUPM=;
        b=GA3apxV0rowncX+NTgtMqVXFCQLIMvBdIo4buATY1NE8QLWRc4DVIBANUiO6nXItsE
         cDZzlnWM0+2hR5K4/wXPvuKAYOpnKS2t/fRfxpfEiiRRGFxV00l7gWcSRySnmxbbogGv
         jbLD3bzb9lPo1rh9ACV3w/An9080AMivIpj+dbbCV2znh0Hr4C2qlNunZd1RAzWXKXhE
         5/6ONPIBGFgYQkrN8PQ9ad4IC8v3TX1d9oa7iLL2XKmu2lP5eKGub09ZHKhkMsqZJmy3
         cRWuTOIa9Yns6hrLuDtsYozAmGq94qiH+wOdHqOXv+7KdjAy2TsDXHUCAblOJ6+2f6/0
         Oo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDLXCyhs8wTAEU1UYv9CyuSUuk2wABNcxI603nGQUPM=;
        b=U6tX7ADNm2XzGXBFWBP2DyzFigkfRGsXDAATCzHI2UcOUmSbLLuz29t01YINdVpQZZ
         wPQD6m1rf+S+Pct3z6UbfSF9q9rr8OHfSLwuXmHKZ6Uu6ApHcIsK3zyTtpIxslS7TMT3
         ifEf8mKk0VQywWVL4XW1q2HFxAeVc3J+E2HpjvBCBTHftFrKIqYRjNUi7AokMHyrVO6H
         IehlQdtja2VDuwmzRyPg1IIGsOQzM6zf/g0aMP7o0zkdwsVjKUQsPP3Vh1Nv/tPsu7e4
         rII0rwFUvHseJyvRTCJ95xCRSQVGfZq0Q3hh0ZKy9YgSt200UPrh06Q2qfvyHpg2Q3eb
         XPyQ==
X-Gm-Message-State: APjAAAVkOFICEplmgHS9VJ1U3ujfstp7PKpRKyHK2S5Sq37YxwqVqjj5
        lyX5Sr/uwpiksKwypMveWZtQVQ5DBKXLKh5VsO0PQW/f
X-Google-Smtp-Source: APXvYqwy97zP9Ee/Beys5izlT76lCIVMFldQ9ayJS74PW296ztOWHBdatCjQVDOJ+ZjfLFp/CF+nj9Lcav+9E84giOo=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr2620201ion.16.1565173117689;
 Wed, 07 Aug 2019 03:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190807095322.8988-1-carenas@gmail.com>
In-Reply-To: <20190807095322.8988-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 7 Aug 2019 03:18:26 -0700
Message-ID: <CAPUEspgoPizN5mnBJjeUVdmTtsJ4NCrd-gMWcqaghoBqG7Sp+A@mail.gmail.com>
Subject: Re: [PATCH] cc5e1bf992 (gettext: avoid initialization if the locale
 dir is not present, 2018-04-21) changed the way the gettext initialization is
 done skipping most of it for performance reasons if the locale directories
 wouldn't exist.
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject was meant to be "gettext: fix is_utf8_locale() when not using
NO_GETTEXT" and affects mainly PCRE by using UTF-8 flag even when the
locale was ISO.

somehow it doesn't break any tests though, but PCRE strongly advices
against doing both UTF and chartables and we might end up doing that
more often, because of this.

Carlo

PS. apologize for the badly formatted patch, don't think this needs to
be fixed in maint, eventhough the patch is based on it with the most
likely to be affected being developers (or automated tests)
