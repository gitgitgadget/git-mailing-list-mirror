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
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BC81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 05:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfJQFLc (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 01:11:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34616 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbfJQFLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 01:11:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so776216lfm.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slojSR0r6PnHRrqnAa3cdx98cwkbCkPAtC9YclhsFEY=;
        b=M6e/f1BKRj2Z54Ox4ENBlfag32C7kAKJPFzBexNgExwLpVoGMb6umQDGHxW4AyCAJq
         ld+D2p3iVjxxS1+hUPSfjW3HBFAQZrN4Fz7e5dItZzIGoTzay7L5pGYl1hhdg7uaq2qj
         NZoasJsfEKO6bcusnT2senv5CX3UR5EBtbWi1GlOH34ZGgLv4u7OxEtxFwajyA8W3nwB
         7LlQcvJHcfF9A1pBBVcipuAYWx/3jBjpiL9XGER2gsENLGKxtWcWfkOo8iI07Xt6+iM1
         408qbDK0hmhqZGxbzrO2ElvXdYD9XMwZw1zdPmFqVZ1b+V7YXJZ5E6JBy42XWWm3RD9a
         xatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slojSR0r6PnHRrqnAa3cdx98cwkbCkPAtC9YclhsFEY=;
        b=WryLF4VXtqaKCrBrmlKNZkT4/JcHu681TWXqQFTQPZ1SfukkuUVTMvf/srUJxTwsyq
         Ngvsqr1/gzdVJWeJqMD9KVbqzfraMYsMZWDk5fr+HA/adlUImkbcFC43nA90n3quT92y
         BI+yFR9AE4J9Kgk8dj18CvUZ7f1PvX5RfYcXYmGr7M2SehMeJPCsKM80MYZmIbI5CPD4
         M5Y9HqIFNgexPGuE3a2wk90YriX+UrH9hr7qfDkAUpoynAswVguCD452F68LqHbgkoiP
         IAult/j8oRi8q2TB+Sh6/X/MR4bmfQDgsr89lUsockuAoupnxckqLxiY1NmMagyekEXj
         6ozQ==
X-Gm-Message-State: APjAAAW/0lSgRRkGCo267HyUUPc+bM1IFVLZEDnZ3wnPmtl1wO16qkZe
        Rb7EOyT8OKAxfDkhz9LZYeUq79OZN1tQHgAllUS/TJs1sYQ=
X-Google-Smtp-Source: APXvYqxwIwJIkpMcpzbsnJreERyLkWFqWotKha7NrHLipOcaPwSt4oBbLTZwTYZSBh6Oxe785JWFLks9RBfeohyZAzk=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr890799lfi.24.1571289089159;
 Wed, 16 Oct 2019 22:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com> <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
 <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com> <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com>
In-Reply-To: <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 17 Oct 2019 07:08:25 +0200
Message-ID: <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Wed, Oct 16, 2019 at 9:28 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> I mentioned this earlier, and I'll mention this again: I'm not sure
> whether this feature would be a good thing for the larger population. So
> this _might_ not end up being accepted depending on how people react to
> the proposal. I thought I'd let you know to avoid any nasty surprises
> later.

Could you please elaborate on why you think the feature might be
undesired? Why would users not want a staged file to be selected
automatically?

FWIW I've also got 2 comments on this in GH[1].

[1] https://github.com/git-for-windows/git/issues/2341

Best regards,
Birger
