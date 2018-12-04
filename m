Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BFD211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 21:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeLDVSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 16:18:46 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:41885 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeLDVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 16:18:46 -0500
Received: by mail-qt1-f181.google.com with SMTP id d18so19857627qto.8
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 13:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR9X2RaFclqVHQJg0YnfFrZhhMWBbHo8cBQGhmeDj/s=;
        b=X7m0oNeBy2Sxm9D0UPePxWaaAoZ8Uo06wfiY8PaNmR6RCOqgPsBMQn3RxLq/e3lood
         1ol0PXIBCF1WV1ZFUTyVs6J4pEoV1DvLxM3JSHCxizCTxT9qFqTS/2kJRJApc6srU9iS
         sFokBPfv3j21+MVoMCCjZ4KytE4ucX5syzxou+VQyUGpKnmqxZB7I01Ztjbb4OLh7Gvo
         Ni731UDbtGxZsg/WdddFE/zlCj9DxeYloQcSgrMR7EHidkupQ6EvnxfCfyqGUczaErvu
         3ElXurODOemmqiOyYaY8yyJF3PPyBWDee8YTHGK9LY85RDokMcH/HqggrdyopzsAr9zf
         62uA==
X-Gm-Message-State: AA+aEWYKvvV0AizTvOjvV7KtukgHCmoTPeVC6hc1D/qAH7O9eIhtINF5
        dcTKt5XL71kwdnjDdhat+pg/RnMvbm42oiNc4Jw=
X-Google-Smtp-Source: AFSGD/Whhi7UPITwvcEe2k2JyARW3LfnE1W3JjNN9KJOE7jTwO8mgml3mNQuCX0hlBZc+9MQ6VrPHqytH3Ek2G67PQw=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr759588qti.184.1543958325658;
 Tue, 04 Dec 2018 13:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com> <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
In-Reply-To: <CACsJy8DEMHFTnL2QJu5Csb1jUQeu0HiT3rTDii4krrEJcoh=Qw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Dec 2018 16:18:34 -0500
Message-ID: <CAPig+cRnQaaACTi3VRrW6-t+mwqhggTd72DQd1s3uKzAEwR9tQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 11:28 AM Duy Nguyen <pclouds@gmail.com> wrote:
> Haven't really worked on killing the term "detached HEAD" yet. But I
> noticed the other day that git-branch reports
>
> * (HEAD detached from 703266f6e4)
>
> and I didn't know how to rephrase that. I guess "unnamed branch from
> 703266f6e4" is probably good enough but my old-timer brain screams no.

"git worktree add" and "git worktree show" also report similar messages.
