Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8485F1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEVSiL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:38:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40629 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVSiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:38:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so11407208plo.7
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1XA4/dgIhNzhNh6n50ECdAzxXknCorQ3Om6+72TIwc8=;
        b=WMxRU7127HHAPDaezOrexu9Vpd78EJvy5p+y7ajvbZdgfQ0EFcfIUHKXPECQoZZDBp
         p08gZTnjBExj5pA97DdiO2rA4rcPaXfOJuMIMlXnjBC1fAzKWSo+cA4gietBiJiyT97p
         Ded5xZGhtUC8Nld/6fq/bw/jwMKdfS4LoPYhlTD8GOjqAFsNXRCZGKDEpVun2RD3OwhS
         yZ1+twAHz+e55Wjb8EWpdGXDL8BqYlgs5SneSMO5IK98aua51CyhJPkTCqZnrCogFJl1
         1zArQKha9+5PJU9xYDJgY7XsjWz/hlsjsA0QSDmqBvmPllEyIHtyHblgUAq2GGKZnoI/
         f4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1XA4/dgIhNzhNh6n50ECdAzxXknCorQ3Om6+72TIwc8=;
        b=CIyQMDHs7WS3xK5XlScerUzRTQbcDAyXM3zo+bafi06cicOUTkZ4ki5rLB3NliS53d
         I0GN6wcUjbY6bqJs8zt5LVv+f2Ob9Xh0whx9YAFbbhcp/dbJdm2wcrL1nVSQ5wSQYJ6g
         vDKBQn7etJaNx+/T8yWGJ3WxYaZebxNEejzWoAZLznRNl0xwY2Z8a/brjGs4cHFNqZwx
         V4YnKFpEnLs5U1LNAUmjssfcpoCPlio1thZUr0ULzbHLlfYGsLSSsawTjFo/cG9CzRBn
         Jv3/zsDKknwaY4Acrzt1gWeGCvNjFiMZk/Wp5VlMnGvNKHsNifHImxf3leq0Jm6/yCvr
         hrEQ==
X-Gm-Message-State: ALKqPwekJW22ddOYSI08msUsSs8uhqFqRvBLg24J0UXO3F3El/1/THCp
        gNXoMHijhDUe97X7gaFWur0=
X-Google-Smtp-Source: AB8JxZrDDxJJDhQxsBGy9KUYMmd/2l5dczO2A+6qChKs/kFI6/OG4mQmHYdg8vRzAU4AwKw1zl2Hsw==
X-Received: by 2002:a17:902:4b:: with SMTP id 69-v6mr26527660pla.178.1527014289891;
        Tue, 22 May 2018 11:38:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e15-v6sm21496677pgt.50.2018.05.22.11.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 11:38:09 -0700 (PDT)
Date:   Tue, 22 May 2018 11:38:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Antonio Ospite <ao2@ao2.it>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Why do we have both x*() and *_or_die() for "do or die"?
Message-ID: <20180522183807.GK10623@aiede.svl.corp.google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
 <20180516222118.233868-3-sbeller@google.com>
 <874liz8tsi.fsf@evledraar.gmail.com>
 <CACsJy8BnsbOvz+iSz=9ug99Cs5Dm17Fgk65K2nXusBg0dML4xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8BnsbOvz+iSz=9ug99Cs5Dm17Fgk65K2nXusBg0dML4xg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> On Tue, May 22, 2018 at 7:49 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:

>> Just a side-question unrelated to this patch per-se, why do we have both
>> x*() and *_or_die() functions in the codebase?
>
> I wondered about that myself shortly after suggesting
> repo_read_index_or_die(). My only guess is xfoo is better version of
> foo, which sometimes involves dying inside but that's not the only
> possible improvement. Later I guess people go with _or_die() more
> because it describes what the function does much better.

In particular, there are functions like xwrite that don't die on error
and write_or_die that do.

I'd probably be in favor of a series using cocinelle to rename the
functions that do die on error to _or_die.  The main case where I
pause for a moment is xmalloc, since I'm worried about the verboseness
of malloc_or_die, but I suspect I would get used to it.

Thanks,
Jonathan
