Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A5F1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 16:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDXQR4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 12:17:56 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:43202 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeDXQRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 12:17:55 -0400
Received: by mail-oi0-f43.google.com with SMTP id p62-v6so18202142oie.10
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lIBIzoXfACiQ7nnvnKTzBI7iqvHksRnfRN2HJGDsE38=;
        b=b+itdIrFZfznbmg3xRRNMmj0mBoJfp9YAQxgOe8XBsA8WBsCdN6VmKCaom12Ln+6Kk
         GknfvhIKD3YttMruM+s9DAUN5DGsTAf7Q8+yXSkmXoMc/9hDW+BMlHW1/Z9MpUtm/7vF
         km0C38i6pOdbKwfMBOzEr562qKXJYYU3eDIv89P5oA9/ewNeCADLcuShIl82hZ8r8w54
         e8ZKMf4BYCHywY03xuEP8wmso6n1BlhfWuUHe4w8xJ0aSsUSQJQbE8A8AoQjiprwI5Yv
         G2gBCVLTB7SyuNRuHUeOcYJUSyxupml6H9/6dnZYxi16/5io0fR9T8vnoTR8aRnoEP/B
         Sn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lIBIzoXfACiQ7nnvnKTzBI7iqvHksRnfRN2HJGDsE38=;
        b=hM8HsQ2+9OESHAO8MYrY/8k2PYs63shK5lcMewS+Ng1VGzEIY1dY5z/55PYzF0j+dJ
         dw0loAOeJf8zMxM1Sva334MOM0fnRU8ToMPgvcNMtKmW6byFP+tdcckertQ2WWT29X5Y
         q7kiiDxfv0eO6tU6/ntTPw/O6Fgsvb2VuH2dx6NIdkqL1EDGsZZEaYvvyeRfVU1Aco6w
         ta574bkYE8hMimWWG+7cyqqFCyxuPohDAnnAbHit7vCOOYhfqiEHtB9VYvkhmLhufI6v
         dwo/jlO9iTaLsXie2XFzWcaFTI3y4g5bW93JsSexW1DC9TM2khmBFVwn6GQzwCaQRCap
         Xc2w==
X-Gm-Message-State: ALQs6tBSQvI4IZbuZL+CqkATmhcosEXl4hY84/Upd6Jkhdb16tV4BbNq
        0N0dCeIMUqpzzWqpfMiy7vXSqVKA/AQBqD/ARKg=
X-Google-Smtp-Source: AIpwx4/sidi1cye+etUDa9ZOTh0dvC3iKfVlvhJCrn5dmItAl+TJtJYrbEH4ShXzSOTMLvBFWx+DkDFd04+XTY+xuVo=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr16024792oie.30.1524586675277;
 Tue, 24 Apr 2018 09:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 24 Apr 2018 09:17:24 -0700 (PDT)
In-Reply-To: <CACsJy8B0bFzh5h+QE+NMgCHfoShfu8MvCzmxPPCVi-g_Ud3sUw@mail.gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com> <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
 <CACsJy8B0bFzh5h+QE+NMgCHfoShfu8MvCzmxPPCVi-g_Ud3sUw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 24 Apr 2018 18:17:24 +0200
Message-ID: <CACsJy8DWcofCqg=QKo2pLcLQ91GKohnS71Wns8siVZ_sufjgUA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 6:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> git-completion.bash will be updated to ask git "give me the commands
> in the mainporcelain, completable or external category". This also
> addresses another thing that bugs me: I wanted an option to let me
> complete all commands instead of just porcelain. This approach kinda
> generalizes that and it would be easy to let the user choose what
> category they want to complete.

To complete this: there could also be yet another special category
"custom", where --list-cmds=custom simply returns a list of commands
specified in config file. With this the user can pick the "custom"
category to have total control of what command shows up at "git <tab>"
if they are not satisfied with the predefined categories.
-- 
Duy
