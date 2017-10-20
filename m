Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CB4202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 21:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbdJTVdo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 17:33:44 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:52963 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdJTVdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 17:33:44 -0400
Received: by mail-qk0-f193.google.com with SMTP id b15so15960006qkg.9
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3wPb1jUzbbib0Qtj2ovcjb07ATRc1hBv39UvmzrL5HI=;
        b=eMWIKT2P9uQmXVt/v9l5xtbyq7cIhsdsjFFf5/afcWF0v/uEi3JS3LEF1cahdJIS98
         tf0xwciCG3c390bny/EaXZHzjyComhF3XpvIkydm4BaEsYV3mlFU7Eevx6+Kar8yuGP/
         MZfEsKKzjq1L5zbdrk348pV8hEAzoB8VmNqaafrjSv9rf3NabvNlWOycQ4+mWCtB7WDJ
         JUSVvZGDhs50LsqrZLhjvpo3lhdWDk7SRXN+5QhX27WDSStUnJ66c2Ev33RDJILWt4UY
         k/AGq8gId4Kc+BmKNmvY9JhV9AXtlPivtp11ECmp1voRvyLbyJNZGJPxV7VkuEsS9ce2
         +FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3wPb1jUzbbib0Qtj2ovcjb07ATRc1hBv39UvmzrL5HI=;
        b=a+k+U2DDRqoWu2e86z2MiojUY8IXkxulF5E08SGAtgId/sSnlRqs8d7nA7HC59OgI3
         CyEB2KCHlZ3vFhNuUSyN5gRhZ7E6VaKiVTv0DvpUQhqRPlIS6W/aijbDCvlk1Cv0yPfa
         tXViD1ZUwI7FqSllM5vGk9WrG5S0fcxo0LbjkyIEfe2cOhqX2odn/9jMbS2t38feTFin
         aEQMstwmKX9FEN65b0KMq67iG147EgDtis6UG8+RRyAAb18VXQT2vSVj2cgJ7yhItRRN
         8+Ocu8QZO26SqNGGInLXQWoDc8SzYp7zgPkNg6duEpuqf1qpCtu4+PeowqvQJO/j5TVD
         VAZw==
X-Gm-Message-State: AMCzsaWf96S6CHvKojNUNTNvGnxHwrrqXC5923K8x6DhkBweVyo5pZEW
        OWdItwH1KnmV292b/wG21x2vQSFpWqH/Ko2TUplXjw==
X-Google-Smtp-Source: ABhQp+Tg8Fj/iv8nJ8T3BUpYrODZbR3NHhk6hKpvCYXuakUYDCXO+2wlAUZN/PRgZOBelCWG5l/lQg5qHyM9DyxLnAg=
X-Received: by 10.55.125.196 with SMTP id y187mr9551889qkc.180.1508535223232;
 Fri, 20 Oct 2017 14:33:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 14:33:42 -0700 (PDT)
In-Reply-To: <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 14:33:42 -0700
Message-ID: <CAGZ79kaVUBuHVxaE0opXqiEwCr7MVFZHrt5ERQ0mF_deSHeOSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] branch: improve documentation and naming of
 certain parameters
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Documentation for a certain function was incomplete as it didn't say
> what certain parameters were used for. Further a parameter name wasn't
> very communicative.
>
> So, add missing documentation for the sake of completeness and easy
> reference. Also, rename the concerned parameter to make it's name more
> communicative.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

Up to here ( including the subject line), I have no idea you're talking about
'create_branch'. Maybe

    branch: improve documentation and naming of parameters for create_branch

    The documentation for 'create_branch' was incomplete ...

The patch itself looks great!

Thanks,
Stefan
