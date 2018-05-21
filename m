Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396331F51C
	for <e@80x24.org>; Mon, 21 May 2018 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeEUQsU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 12:48:20 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40867 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeEUQsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 12:48:19 -0400
Received: by mail-vk0-f68.google.com with SMTP id e67-v6so9147082vke.7
        for <git@vger.kernel.org>; Mon, 21 May 2018 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pJhOuspwkEgEn9kx2C1VWcm0ID3tcRb8G+Otrp2wxbg=;
        b=PxfYm/jG/VGox9ftqd02+G2wutPSSO1CxZc9+Qs0ElibUcfAkc7TXtQYJRc9WlMzT1
         +ON9AoHiEeGJveBH9fNNmQSrku9ELtSMvBuuOeYRDbdX59St+WnumIrkvrIynqfGkrWG
         yQ1mYKmf7nrjc4yqFvLSUP06H1sa+FGNQJ9VLrpvOwcUFaXuFGQDblHcBnVqgQ6YEabG
         0L+XoARovmkkFbHNTZbXsvBgq2mwqr5ophY6yZznGv8WdAZByb20BN8kEMfvsm1PGbZR
         L5eirCzaFKIhznBl8eEUxbr4XlNOfyINkTOcOKojMTY2pn9KmoUnb6sbdXJ9UW5pdzTd
         rdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pJhOuspwkEgEn9kx2C1VWcm0ID3tcRb8G+Otrp2wxbg=;
        b=WxIHQTfRf3MffoSSIY9UIV23tudRnV6cZ113AeVBba63D0DfVYG56FvSnthBHwD7BH
         gMSZmfPP8LLfMvQznkHAi8KJDa6hC6xJrswTjohFBHOpqJbBo3a1nkTLR0jkman8JqQX
         zyzqb7BQoBMmR5egMKiV8g7m4LHZlmahcDiFL8FSLiX06tic24lci42+QI4qATmDlebx
         3Ml7iOvZubbzDBomcrRASXFpZdICq3sxaR/WbMVzBq/ENPdteQXa0DIOSCw2yZVKsTKo
         sxITel/g8K7MKRuDzewd3MwZ3dTK4ze4heakw/tL2fq1nzkSA+MneP4F3p8+Msew+elE
         Q2NA==
X-Gm-Message-State: ALKqPwfutRUyp93o3i+I+pcnAr1UuF/7dslpzGfWcW8y3AnSuzICUAp1
        pXnUBsal6X7QeDF4VdK7lYyBZIoCrPSjTmFlCM0=
X-Google-Smtp-Source: AB8JxZrzDZC83sah+ZgJFSbB7t4u1nhSJPwEKXA/gCR1JrRcLLgFIQzyUsB3xNcR3y4qy+xmN/T0FljrQ1tsZ2n+7no=
X-Received: by 2002:a1f:aa58:: with SMTP id t85-v6mr14011543vke.118.1526921298087;
 Mon, 21 May 2018 09:48:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 21 May 2018 09:48:17 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805211542160.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-3-newren@gmail.com>
 <nycvar.QRO.7.76.6.1805211542160.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 May 2018 09:48:17 -0700
Message-ID: <CABPp-BGR1jaGzVcqyCO=WYgdX3SKQoj9pzuKCvXoc7+R=OA8PQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] merge-recursive: fix numerous argument alignment issues
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, May 21, 2018 at 6:42 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Elijah,
>
> On Fri, 18 May 2018, Elijah Newren wrote:
>
>> Various refactorings throughout the code have left lots of alignment
>> issues that were driving me crazy; fix them.
>
> I hope you did not do that manually. What is your code formatting tool of
> choice?

Sorry to disappoint but it was manual.  I noticed and fixed one of
them many months ago, tossing it into a 'misc' branch.  Then ran
across another and added it.  When I hit the third, I was annoyed and
cleaned them all up -- and combined them with other changes into this
series.

However, it's hard to call this formatting entirely manual.  A quick
regex found the relevant sites pretty easily, and 'M-x indent-region'
(emacs) fixes the indentation for a block of lines all at once.  I
guess if I had taken the time to fix a few other emacs formatting
rules, I could have highlighted the whole file and ran C-M-\ (a.k.a.
indent-region), but didn't.

> The patch looks obviously good to me.

Thanks for taking a look!
