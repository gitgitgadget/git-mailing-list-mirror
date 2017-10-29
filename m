Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6E42055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdJ2DXV (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:23:21 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:54805 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdJ2DXU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:23:20 -0400
Received: by mail-qt0-f175.google.com with SMTP id z19so12687242qtg.11
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9XylaQlF5y8eaPueA1+lNugPdAXl+nuS5lTpXyX0oqA=;
        b=fd0WTAZSVfqAmsHyXjqjxnbJL7EUBcYs2gEP/1SfVITSjo+oyLPu+bmQ9F7X9pJ2Vp
         hHsto8I/Xi2OjtykLLRx9652wpMK8Ntfkg8cY8K0u6f5oj0fwhCC1hC28e8Su8WUcLwk
         2B1gElPJophewYDOwmf6qW0mCR1rEQSSE7I9oDW/qcC/R2KRUiinAPdPase7UDJdbvmm
         BHTpDvDdZ8O2XQueEGZZCnwUoHteIv5OWdhPgph9SequaHlDFQmuo7xDV7mHx8Phqiav
         +DOuwyFheip6YxysWkIiH/0Mefnam8v52f6R+46UHvsh6/Hkw3khY3GRX2iIt+hDFu6e
         bmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9XylaQlF5y8eaPueA1+lNugPdAXl+nuS5lTpXyX0oqA=;
        b=hcTb6ouOyFqHLPemZWEsRPlByBagP0DUsy/FrxULPlG1/Gs32r3WPZruEtffrYjFEg
         Enp4xqu6ivZv53y52jVR7Fkh7zRZESmSjXy/l2SYpJ7LKvzErzG2uZrpRGGgj0jHKcBT
         6jVSRQbhTvujX2SGD0G1CAH96hKqYXdjmkHXxC/5RG5duU09xGQvwDbYECPqJ/vB0YeF
         6O28QMe+M4Of0le5MvTsSbTft8N31kr5aZOJ7CPz3swaHt5pTUemWSEPztpGP8E8NNDg
         VwrHg/3av/MiiwaqU9itpypEoIwNRtDN5GmzJhl8zpoe/YgyA0aEFHsAgxKzIMFwQcyx
         Qdwg==
X-Gm-Message-State: AMCzsaUV/ujKWC84Vj2okcHORvwh79hj2Drnr0CV/jhk6k27DBZByyHh
        I9SHqgpxMzJkfkUjEoDmiW5WMvKaO9c8uV8Hc4jJ0JTS
X-Google-Smtp-Source: ABhQp+Rfozk1DxIX6Zq7uaNuXwZpxWn3oda8vthFPJq6quzz5Eskj8anPuImBpSNQP2Kf3zl8fUbb20ecjPwMOeInJ8=
X-Received: by 10.237.53.137 with SMTP id c9mr8677870qte.125.1509247399759;
 Sat, 28 Oct 2017 20:23:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Sat, 28 Oct 2017 20:23:19 -0700 (PDT)
In-Reply-To: <CAGZ79kaVqSzzPebHN4=extkAPpyi=VagmjFU8mh_A_tYoJgU8g@mail.gmail.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
 <20171028004506.10253-2-sbeller@google.com> <alpine.DEB.2.21.1.1710281917260.6482@virtualbox>
 <CAGZ79kaVqSzzPebHN4=extkAPpyi=VagmjFU8mh_A_tYoJgU8g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Oct 2017 20:23:19 -0700
Message-ID: <CAGZ79kYEfFkUBZ18s=tDo+Dzo1KEA-MVNTZjLim_HHdZmeMa+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] revision.h: introduce blob/tree walking in order of
 the commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 8:22 PM, Stefan Beller <sbeller@google.com> wrote:

>
> (Not making excuses, but...) I remembered some other senior members
> having such commit messages, so I felt like I had to step up my game.
>
> https://public-inbox.org/git/70fbcd573f5c8a78a19a08ffc255437c36e7f49d.1495014840.git.mhagger@alum.mit.edu/

I forgot to note though, that this never made it into the official tree, though.
