Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6474C20A28
	for <e@80x24.org>; Wed, 20 Sep 2017 12:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdITMEq (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 08:04:46 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44889 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdITMEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 08:04:45 -0400
Received: by mail-pg0-f52.google.com with SMTP id j16so1564078pga.1
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=swUk/NMnQIMDU3IgEV56mzxxgNX+HL4CU27THBo5u0k=;
        b=Pg9KV5AUn1GrKSvebhfkobCiokXhf3hg+HnO8hYYD+eKgvmpLAx2fSnbd8m6NXd/VQ
         ZfVbOHQK3d9aIIm4o5lmXhQ2EpEJi1+7zkiSsRZ8s8E/GC7oqoGNK1cBTbhWOK3JMYzQ
         GmvuKBwmn9pynPnpILnV4XKZTywtEA1Ks1AHXTt2pjwDsPVWM0wp36BdVmrvKccscft5
         l+TTZNkKIt5x7VlcP8CJI/Na5Xe3pwvG51HPmbikRmzJCBgpjuTsb63lYfzKyvSkH6g6
         MLLCNVn/D58qQ9UrSfM8q/M+Lci8sXFBqwpeypeffHu9dLEBSgvMlWk/QsMN1SoQvxth
         dyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=swUk/NMnQIMDU3IgEV56mzxxgNX+HL4CU27THBo5u0k=;
        b=lxC/Yf5S+Z/Ag9UI5vJq+77hSI+wAcwlsLpnoYMaGRT6EFJ/ezR9aJ8GkLCbgz6yv1
         /DuFvNFSZ2jXhp5/03jDTqeJIXHpmFKmUUQd5xEigJ8GqxTWvYHhDAw6GxcAHVapKRpz
         ogjkm5zVicaK9pN6pN+o+g1S2xNVu8y8pr4xw4btU94Vzx4Ej/Slv/Sc1S0fqyB7T+Rg
         9rQXlcvKsnVxk/Xj/oOP1v9CyUKmxQpk8fa3A7Vb3diEhxMgv8UOi/UTmNT91tyNbuNy
         bpOoOZVeiTNHODOHvpBN/uS0yLe4r+QydUJt9F3gX9Xpy9sYO8KWEt0JpeFKZt7pkzkZ
         Bx2g==
X-Gm-Message-State: AHPjjUhfQCsvPS9t7/gzzsmjbvwhlnLHUCHFGHayCbiyQXdIaqoZRZtV
        JhFzmt4PVFOPmSHDTHc8Uk1TnpxQ
X-Google-Smtp-Source: AOwi7QA6pNLRjFMh62kU2kW5ExzGy//232nEw5vaicXrSKX6DWmn8rpjcIaXzR9QfyoKi+rBAsr07w==
X-Received: by 10.99.109.196 with SMTP id i187mr1946242pgc.357.1505909084329;
        Wed, 20 Sep 2017 05:04:44 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id o78sm8125221pfj.19.2017.09.20.05.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 05:04:43 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] branch: cleanup branch name validation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
 <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <1d620d52-5326-269a-8710-160b75fada81@gmail.com>
Date:   Wed, 20 Sep 2017 17:34:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 September 2017 09:50 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> -int validate_new_branchname(const char *name, struct strbuf *ref,
>> -			    int force, int attr_only)
>> +int validate_branch_update(const char *name, struct strbuf *ref,
>> +			   int could_exist, int clobber_head)
> "update" to me means something already exists and the caller is
> asking this function if it is OK to update it, but is that what this
> function is used for?

Of course not. I couldn't come up with better names.

>   I do not find the original name too bad, but
> if I were renaming it, I'd call it ok_to_create_branch(), with the
> understanding that forcing a recreation of an existing branch falls
> into the wider definition of "create".

Thanks for giving a better alternative. Sounds catchy. How about
`validate_branch_creation`? For some unknown reason, I seem to
like to have the word "validate" in the name. If that's not ok, I'll
use the suggested name.

> Also I'd avoid "could", which can be taken as an optimization hint
> (i.e. "you usually do not have to worry about this thing to already
> exist, but I am telling you that for this one call that is not the
> case and you need to be a bit more careful by spending extra cycles
> to see if it is and deal with the situation accordingly if it indeed
> is"), and use "ok" as part of the name for the parameter (or flip
> the meaning of it and say "create_only" or something).

Will fix that.

---
Kaartic
