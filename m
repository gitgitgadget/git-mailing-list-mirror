Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D9B1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeB1S7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:59:08 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:42711 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1S7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:59:07 -0500
Received: by mail-yw0-f171.google.com with SMTP id u84so1173634ywg.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1dAAKWErFy77/u1sBGpQzVC9YamrSbETZL/u2RjZ200=;
        b=FaDfJYrFBnu1JC9UZlarSI31C8VUUAIufrhQZEQN2gCnIlucTqEG8mt2z7Do3m9uCL
         gQBSdRnZt9KRYW9UagqGGrusrdhct/PBvnt/rC9wCRH4ldmLx6KxJnp5aWRimf4BaSf5
         SQuDqNStPfsZHTtgvhsuAOFDgDDGzbTldtI7QIYmVbf1aFcTTEfFHayoerRAA3ZJFPmU
         nXQK2NIL6LfFVGxzKuvt5psRx2zzQx3ZiC4OBJCmJ8S4AvxNhQEJxfKIsuxNAmnp5j+v
         JlhQf7zepsnBsqaXYIZ47N/SN9ohtBNaYfQeH1kFSQ0iSa6SY3SsMRe3ubmjm+39G6Oy
         h3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1dAAKWErFy77/u1sBGpQzVC9YamrSbETZL/u2RjZ200=;
        b=Mx1Rc6Zbz8jY+irOVXuTv4tJc4vh0q/J2Hg9b6hNDcCKsntdHZcR1y9zjnZDVI49nS
         Vu4HX3rbjtALObGdKXSBIXfEo8f2QG7cC63GPISQhNR2XQ6hWJLUyBGHxMKNroTAvi8b
         n965xO/2uACelaR5hf3qD2/XupMsdNcS6TISmTag3nKtZoXPx6VFJh/YPW8v/nMHIueI
         hLveaJLDOB5QR1lLbblxRRB2yTsUVGT2UJZEJiehbNuuh4VXrUdrF79r15pFu+DvdPo9
         I56JHfwzMyQdHlArbnV+OBnJoPWmJEw64wpMyhMbDTVPuGABCU7VAHyufzDwA927gNWn
         +ffg==
X-Gm-Message-State: APf1xPB268UpwVV0Efxh3Y/6o2zIIQchzV6pzPDVK+3KU6yn5SqPcOGv
        09P7SrI5cqaB/K7Hb30P0pVXs1H7OWN0thqm61NpLw==
X-Google-Smtp-Source: AG47ELvxRMz61FGEtB8ZMTG/wePw9dgdnKjjQbozIO+rdlVJ5Ryrh6u5tjI0rzqZllH0t1E2w871o5+UQTvZXFmdMPE=
X-Received: by 10.129.196.74 with SMTP id s10mr12613879ywj.33.1519844346251;
 Wed, 28 Feb 2018 10:59:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 28 Feb 2018 10:59:05
 -0800 (PST)
In-Reply-To: <xmqqy3jdknar.fsf@gitster-ct.c.googlers.com>
References: <20180228010608.215505-1-sbeller@google.com> <20180228021530.GA20625@duynguyen.dek-tpc.internal>
 <xmqqy3jdknar.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Feb 2018 10:59:05 -0800
Message-ID: <CAGZ79kaurxM+Daa43ZQ_LCn6HbiaXex_NtO73g2ip70RUpjM7A@mail.gmail.com>
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Looking at the full-series diff though, it makes me wonder if we
>> should keep prepare_packed_git() private (i.e. how we initialize the
>> object store, packfile included, is a private matter). How about
>> something like this on top?
>
> Yup, that looks cleaner.

I agree that it looks cleaner. So we plan on just putting
it on top of that series?

Thanks for the help on refactoring,
Stefan
