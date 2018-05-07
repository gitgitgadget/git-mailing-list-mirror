Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD79C1F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEGKFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:05:44 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:40608 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGKFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:05:44 -0400
Received: by mail-pf0-f175.google.com with SMTP id f189so22463433pfa.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pw3gZ4XapD3JRUQogsMqPExabRSlWcAr14Bxez1gOMU=;
        b=aZ9N9e1GjMtSigbFzNS/zsnT30SgZ4hprd6+ZbqMU2DCGWQofe/7V2YOCtA7LyxAel
         8+j97ckmRnRsQKKc3DK0kPtiRnr6Wj0fIdfWSYQlvMyYhGyzw60fIsrllZxQbt+LLjwg
         IkWXoTlDMwPhcbdKnRpiAeRztmeo9rpE92nWLM61E9ugkmpv9k6ZMDT8Pdhfz6kAK9MI
         boH+OMxGFLfFk0P31pz1+7OzIVTWMpsvi6QfyRVtg3/o4cNHQf5IWYp/omU95MGrutHt
         jatcDFxW/vTYAYv3NeHm61WScHPOkLC7BmHR5yL+QdHoHe8PBgZAVxK9Vo7uDgS3CHjT
         QN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pw3gZ4XapD3JRUQogsMqPExabRSlWcAr14Bxez1gOMU=;
        b=raTGfHkx9M1ZJh5YbHfE17TWCj5OXmS7MxUq18/tArwxJbCeZQkZzdI9lHgxFSVQZa
         C42kgE8eorrHIg2DMvSSiHgQxmcwKLHVule1pUKFrzJMaAfBu0KF9kT7VlvmI0LANc/7
         5/pa16e/GE/KiPUahVRnuh0yDofPKaFg8B6hxhKUn+Ep44eOItt6LInGb44PfX39IcPC
         vcIi3bk16HIcYo4ZgSHbSlB9e+lwczXwj4HqJvZHR9MAa8igPINBiNB1CWGtjY7N8Oxt
         n5anIAnY/ihOKA5bd+4GslxGS6NUmMMfsdb+gVvWrRU6Jxda4oW5Ffg+pW0/y0AdqAtG
         DgQQ==
X-Gm-Message-State: ALQs6tCrD2cZ526TzfXxDYSi7H6XaPGhRsc3xJVJ5XXWpTFALREUV3eU
        HaY0B42lngvUyc5zKg2VoTJq27/Ipdnf4dyZ1g4=
X-Google-Smtp-Source: AB8JxZrSVY9q0OIkBXdtSB1YDkn7pSkQWdaQ/STdhyhQJmNyYpuVqGT6FCXSYrnj6mPyqCqIKSg2LWsy/83MoMWXpTw=
X-Received: by 10.98.233.3 with SMTP id j3mr4066499pfh.196.1525687543427; Mon,
 07 May 2018 03:05:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Mon, 7 May 2018 03:05:42 -0700 (PDT)
In-Reply-To: <1291dbc0-31f9-213a-ae30-1a6349ea1626@alum.mit.edu>
References: <CACUQV5-9PagVhE5YY=Z3721YRiBwSZykT3ZjtzmD3o-c6O6ddQ@mail.gmail.com>
 <20180506133549.8536-1-martin.agren@gmail.com> <1291dbc0-31f9-213a-ae30-1a6349ea1626@alum.mit.edu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 12:05:42 +0200
Message-ID: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com>
Subject: Re: [PATCH] refs: handle null-oid for pseudorefs
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 09:39, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Thanks for the patch. This looks good to me. But it it seems that the
> test coverage related to pseudorefs is still not great. Ideally, all of
> the following combinations should be tested:
>
> Pre-update value   | ref-update old OID   | Expected result
> -------------------|----------------------|----------------
> missing            | missing              | accept *
> missing            | value                | reject
> set                | missing              | reject *
> set                | correct value        | accept
> set                | wrong value          | reject
>
> I think your test only covers the lines with asterisks. Are the other
> scenarios already covered by other tests? If not, how about adding them?
> That would give us confidence that the new code works in all circumstances.

Thank you for your comments. I was not able to find much
pseudoref-testing. I think what I should do is a patch 1/2 adding the
tests you outlined (some will be expected failures), then turn this
patch into a patch 2/2.

Martin
