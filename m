Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6CB1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 01:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfGYBrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 21:47:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40858 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfGYBrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 21:47:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so47522707qtn.7
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 18:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0E5UhlD7zsZYi21cMiMTMM1kk+XmATm9k4pmSM1tpc=;
        b=titQW/e+yaD9FwAvwTEAEv3C45cIy/O6dzyR36q/pWEnM19lY0Y8FZO3yOGHBpNVpC
         8U1YTmvsIPToIB9iMIWEmYozmqIOAwklh9pZWDH7K4GG9lsGiBmvnYewLYLbwLdf4x5d
         8Ddh1qkOV0SAtqVgrJNH4piveZkHkmScwag9Xb4dadOBoSNOmGA2YJTCOm8GqJrFll+B
         wEP6pHqnXoatTyftZVCbNDF+78VJ8+S/fr/cqFML1LtwwLM3iqzLRPXv3b0WteEZ9soi
         lsZVM/5uVyjGC7lHDfJNtSnJDLswffLNaOvAbnoPjjH76xy2UnkxAb290PpFm2/WIVAH
         TKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0E5UhlD7zsZYi21cMiMTMM1kk+XmATm9k4pmSM1tpc=;
        b=t4LdKfXWXtfABwS03eUK31gs5lfeVJOYP3Jx7QUA537w7kjSCRKMjjPUkOTCaedbBr
         C8FHJCkA6XHQ8m06zmWsnnzexHDg+0GHh1AC6crShZdLp2GXD831rS6duJhWhnAK9wzX
         LOb9iWFOr4gIkfZRUPeDLbnbFbEO3JK1TS+TfaUgTm44dCEL1K37XM5CidPY3jRPJQmN
         hq5qsNo5hIai1GCrnZkuDsv68EpCsjN2Va+PMbRMZExajQa2hjWoMh/z9K2IWouVB2sX
         IgiwO1sqFMX4paBR9Il6Ki9sqZv/qE/XqajYmm6CsUjtkROzYqBbFieb6TKZQrj6ORk4
         gMCw==
X-Gm-Message-State: APjAAAU7aoCp6dJRbLU5MhjOidbBJub/lUZAMQ3rSHe0XpPQ/iQlcYtV
        e06F7HQxsNFfw9d5dGJ1Jgk=
X-Google-Smtp-Source: APXvYqzeeiRNiQ4tvvYTQXFG6EIwIMk5CHSoZETBfy4q94ww5Z/Ve0dysISfBVr4cEHTFL0I0ksEJQ==
X-Received: by 2002:a0c:995b:: with SMTP id i27mr60657068qvd.159.1564019249917;
        Wed, 24 Jul 2019 18:47:29 -0700 (PDT)
Received: from [10.0.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id y9sm21173216qki.116.2019.07.24.18.47.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 18:47:28 -0700 (PDT)
Subject: Re: [PATCH 5/5] repo-settings: create feature.experimental setting
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.git.gitgitgadget@gmail.com>
 <da7685936f44a32121ec0568df2a9f23e4003506.1563818059.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1907231708280.21907@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b9843571-5358-a33e-40cf-0d6d30d30766@gmail.com>
Date:   Wed, 24 Jul 2019 21:47:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1907231708280.21907@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2019 11:20 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:
>>  struct path_hashmap_entry {
>>  	struct hashmap_entry e;
>> @@ -1375,10 +1376,14 @@ static int handle_rename_via_dir(struct merge_options *opt,
>>  	 * there is no content merge to do; just move the file into the
>>  	 * desired final location.
>>  	 */
>> +	struct repository *r = the_repository;
>>  	const struct rename *ren = ci->ren1;
>>  	const struct diff_filespec *dest = ren->pair->two;
>>  	char *file_path = dest->path;
>> -	int mark_conflicted = (opt->detect_directory_renames == 1);
> 
> I actually don't think that we want to do that; the `opt` parameter is
> passed to the merge recursive algorithm specifically so that it can be
> overridden by the caller.
> 
> Instead, what we should do, I think, is to change `init_merge_options()`
> (which already gets a parameter of type `struct repository *`) so that
> it does not hard-code the `detect_directory_renames` value to `1` but to
> query the repo settings instead.

[snip]
>> @@ -3687,7 +3690,6 @@ void init_merge_options(struct merge_options *opt,
>>  	opt->renormalize = 0;
>>  	opt->diff_detect_rename = -1;
>>  	opt->merge_detect_rename = -1;
>> -	opt->detect_directory_renames = 1;
> 
> In other words: here.

Yes, thanks! Your suggestion makes much more sense and makes the diff
much simpler. No reason to couple too closely to the config storage here.

I think you gave me enough feedback to merit a v2 before others chime
in, so I'll send one after I validate my current version.

Thanks,
-Stolee
