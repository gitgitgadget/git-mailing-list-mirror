Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 06:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81B764E36
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 06:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBLGEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 01:04:01 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:34615 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLGEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 01:04:00 -0500
Received: by mail-ej1-f49.google.com with SMTP id hs11so13791877ejc.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 22:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bfvj7gkYgwE3ReKSyhetZQZtwnzssv3LnkPQuDkGbj4=;
        b=gB9oYptHYSlEsCZ6TCmvGK6b/Nt2k53Bh39oeGwwhjW0NjtxuFnusiXw6PZAXY2VyF
         QbHX+DnC/8JY32WMiLrjCYQKrwXvnyeekupObun6fIp9j1vyXrvCBeHC8v9jRUlYn8zo
         HX97bTHSpHS3M5cOw6+lNIJUeKblTFK2XRvuPHcil1pPgIbALo6/utCgZ3UxvrI0ioXu
         gZIzV5ERrs0Ic6Ml46tOXjVkoD+u0r15IFpq3ju2g7Tm7MGsH2PZZrHCbZlrb5tqv10c
         /uCWH1P+dgywQ3FjE4VfEAR2Gs4D7HjE2kAn4fAmWUS7bzJdLRSF4GyAlgWO96dc1z5I
         B8Ww==
X-Gm-Message-State: AOAM530fdhsnGeNRJKH6D6ra11zkIMQDTSnQAK7IYkHTqli/pZ2itpBG
        gHQrGUnUiAad21Mvu/w2q43aE9sAkePyL2zlt4GWhgOZfMMfgQ==
X-Google-Smtp-Source: ABdhPJwnLVegFyRcp61iaDZbYjbbbJekeJqnhjnZQOJCqWXuFhmkFavpVA2y3yw0WuewbeVhkavATIFS5/oFr8MCRXE=
X-Received: by 2002:a17:906:fac4:: with SMTP id lu4mr548094ejb.202.1613109799303;
 Thu, 11 Feb 2021 22:03:19 -0800 (PST)
MIME-Version: 1.0
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
 <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net> <xmqqlfbz927i.fsf@gitster.c.googlers.com>
 <YCAzcs1e08Qnk2wa@coredump.intra.peff.net> <CAPig+cQ=nR7O+uNAufB7ohKN2ZoUP6n1aLbZBz2jeFKMFbaAcA@mail.gmail.com>
 <CA+kUOakk_=DRzroNb+0_RcfbkaOYLJxY=AtYMe4YQwuhB+_P_w@mail.gmail.com> <CAKH6PiXj39+8SQLiJfdDWyg=vmqiNAba=DKffg3adfztWJ0w_Q@mail.gmail.com>
In-Reply-To: <CAKH6PiXj39+8SQLiJfdDWyg=vmqiNAba=DKffg3adfztWJ0w_Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 12 Feb 2021 01:03:08 -0500
Message-ID: <CAPig+cQrYtzk+BZkSc90dj_QavWO1i6FVExF=JzggHGhhO7yzQ@mail.gmail.com>
Subject: Re: default editor
To:     M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 10:15 AM M Douglas McIlroy
<m.douglas.mcilroy@dartmouth.edu> wrote:
> Many thanks for so thoroughly exploring my query.

You are very welcome.

> I have long lived with the limitations of invoking Windows apps from
> Cygwin. Fortuitously I could work around them without resorting to
> "command prompt", though clearly that isn't always possible. And you
> have shed light on the difficulty of the opposite: invoking Cygwin
> apps from Windows.

Were you able to resolve the situation (for instance, by staying
entirely within the Cygwin ecosystem for `git` and `ed`)?
