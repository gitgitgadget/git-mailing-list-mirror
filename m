Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4CE1F453
	for <e@80x24.org>; Thu,  2 May 2019 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEBQXB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 12:23:01 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:37445 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBQXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 12:23:01 -0400
Received: by mail-it1-f178.google.com with SMTP id r85so4442507itc.2
        for <git@vger.kernel.org>; Thu, 02 May 2019 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufxA0Ujy5cNSKobsmxvPruSS5IvcT4zjaD+ZkQiRzyE=;
        b=Zc6KeGWNh0/IJko6zNuGs2D5HnQE+afi2UcS3hlPC9HsEDbDkxPr+PIgIRpPIRgHnK
         DOsgGAABTCuKdbZQFKo65Cbza+xYrT9NGelOe4omIEKHYm1YVtFOHpKIOjrxbVuIvXKM
         kVn6i72GaK5L5VKnPq9DGjLjv6AaQCJ/4xreUNnbFrH1Xv27Nek4qlgF8tSJHr8CNdHF
         /fViUC47lae7HlkjXvywAsTNvh6nNYACk64hoqNei8oDYbWokriDsyjkXUYoZNUT9xDK
         LVUhzr/ZTLzaJGIYqyiNUaS8VisBLj6QquUDUQ7/Y89L2YUQlzJCXRT37bey81MPRmm1
         gCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufxA0Ujy5cNSKobsmxvPruSS5IvcT4zjaD+ZkQiRzyE=;
        b=W7U5j37ZXgAt/Hf6ujY/DwZ+J1hBjaNpyn9uJf9iiV+ysMmIGrDRdcigqfrm4Z/SXO
         1C15ib9b9tx80gFrcfNKG7z97jgQyXoAgfzxidno1u9a9MYgupfqO9MMT6MLx4R5aA1V
         JIe9/zedC1AWQl/6J5p4SibmrfPHh5wh2Cj0LgDBa4aAbSJTqZvWksMzWK1k51ZXjIOs
         g/EeRdRHRbaqByTDpiArO1tOAKZi6Clxp2ZodZ+2xCDb2s7K2KZi0NzXIMu/Yyb7a7Ad
         /OAZV4aC32QJCThMuhqzerS1e9zSyZjileW8tgsL9xDgQXrVS4mEdpwvdd1mEp/LxnQm
         Y2UQ==
X-Gm-Message-State: APjAAAX2qnzPvYDRqtDJVNt7EHgVyr6VZLxRukbnXyDgt4IfP6ZAZD9j
        OHKywAXS0hW0vhyIpIQjYE9vyuAOn1he7LCnWdw=
X-Google-Smtp-Source: APXvYqxTLHewAFDQHCGtCEImQCv4ZS5IKQslRugC7/V3T0OVvDR6RooiLTvnLhDg8k1jCx9+xn29wNnVmKAXRVSs3dk=
X-Received: by 2002:a24:478a:: with SMTP id t132mr3036280itb.123.1556814180397;
 Thu, 02 May 2019 09:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
 <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com> <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
 <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com>
In-Reply-To: <3bf0f04d-83d4-ef13-8e19-a679b4153793@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 23:22:34 +0700
Message-ID: <CACsJy8DLUfpL9Rpne2qpWWpRr-myF28LS8MW6zeO8_WJWZoLmg@mail.gmail.com>
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     wh <microrffr@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 10:45 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi wh
>
> On 14/04/2019 02:59, wh wrote:
> > Thanks for the info about the upcoming "precious" attribute. Looks useful.
> >
> > I didn't get the impression that Git normally overwrites ignored
> > files.

Please do not include me in these discussions again. Thank you.
-- 
Duy
