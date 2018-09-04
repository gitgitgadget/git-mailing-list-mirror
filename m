Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF7C1F428
	for <e@80x24.org>; Tue,  4 Sep 2018 11:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIDPiO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 11:38:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53489 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeIDPiO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 11:38:14 -0400
Received: by mail-it0-f65.google.com with SMTP id p79-v6so4398780itp.3
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uabh54If8Ffr9QcKOM3wzNGwYQ0mTeYjf+45tfTpGLk=;
        b=fb0K86DjBMLlwEadc6HF9xOrgnl/cxDUtFxXkhXPDHvB1TZ9gShBvAyyjtUyOXoUGY
         +jTu8jnOG3pUK7TKpXTJp8Y4nDSoeJXmag6InVsQonZqU90LHKe2FnRlVZ3bXN+hTgvC
         6RePOK98/VuRsjb+JXGV4k5X88TzxzyEfElY5FS9uMl+JzrbayH1vc9QqRupr+96osus
         piNDf+y+7CF6V3cECC5W7VclYShkFw/ceykL1k0q3lW5HTCA6qnfHf1iCe3rLr9mbMyQ
         ALzBnBgS1YZrjgwDtUhabwnnp9c6SXCgmQ6JoalqCJ038JUzX3mvmy8nZyW9J33hxN/u
         U2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uabh54If8Ffr9QcKOM3wzNGwYQ0mTeYjf+45tfTpGLk=;
        b=D9ZIppUvsoh4wkQqn/SH29GzptPV15x5+8cGOIwarDOWTP4iUREVh7KwIrVbcGVtg7
         P+1st9H8d4jeM/rxxfX+peIQZqFIt+KWRDU4OSPunHjU31ePGKcK2QVpQqtgvgXKGnvF
         OVGANyiYYPhklNEmGf8VvnPpD4TSIWDkKYSUUk/weS1FTu4hFdr2gmDJNqcQ3zueo+MC
         mRYVD/g1b0LedMbstffe+GI+sGK8eG137AdKQdG4kqt0Zli7gD2rKgLwkyIv5WabFSU9
         BEmwW4mXBVGHhW8zJsut1/IwdApBFOINvP3lLjPCMq2jFTTmx4wy+5/LEqtJ6B/sxYeP
         Td3Q==
X-Gm-Message-State: APzg51Cb8IrQhF1V9OXLaGahRPhBykDjBAxRXFd+F1RUO4XIiRoQo6YW
        VSPM1nogKNvuPvS00ZyLAYpfMc1pwekwBbf0K4A=
X-Google-Smtp-Source: ANB0VdbFbuInJ3D3DzR1hemjL3m/4EY90lh6zF/CKc6XqSNyVXSAjZUXdHXcd/r9/4hhu8IvSooRUrMAQQ4/278MTZY=
X-Received: by 2002:a24:5753:: with SMTP id u80-v6mr7426284ita.21.1536059614039;
 Tue, 04 Sep 2018 04:13:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 04:13:33 -0700 (PDT)
In-Reply-To: <CACsJy8BOZy5MBsSwvHNsWeAf4tqtRJc0SJuBtfwM9wR8Yn_xfw@mail.gmail.com>
References: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
 <20180902074250.6802-1-pclouds@gmail.com> <CAP8UFD0MHUN=auZW9Zu+hnx6oAxjNsZUfQGeJ0HfBCh5RPv6jg@mail.gmail.com>
 <CACsJy8BOZy5MBsSwvHNsWeAf4tqtRJc0SJuBtfwM9wR8Yn_xfw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Sep 2018 13:13:33 +0200
Message-ID: <CAP8UFD135763VCPSzYuir8pR+wC=C7o12E4UcwkpzK-c8yck_Q@mail.gmail.com>
Subject: Re: [PATCH] bisect.c: make show_list() build again
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 7:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Sep 2, 2018 at 9:57 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> Thanks for going the extra mile and doing this!
>>
>> I wonder if we should also try to make the show_list() function part
>> of the trace_*() functions to make it even more regular. This can be a
>> separate patch or topic though.
>
> Yeah that's probably a good idea (though I'm not familiar with
> bisect.c enough to take that step).

Maybe this could be a GSoC micro project or a left over bit.
