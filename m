Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6067A1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeH2SlD (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:41:03 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:42502 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeH2SlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:41:03 -0400
Received: by mail-qk0-f182.google.com with SMTP id g13-v6so3502153qki.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S+nbr1OrYRHNY409VOkMcmSTT3pRUeMgxuTnA5h8dvw=;
        b=IIUltSRvmBnjmOK3Mdwku4CouzMS6t4jTbwRkyrYPt1JE2xIR1wV9SPe79sy9//9z8
         TNylPPavI6uFC3kwTHqW1kUNlXjgaTgWGS7EtuWEg3Nh6KxSVwLPmFv/67ekSX55UPaW
         rMjQE20t+RGYRDZoDk4HqikmuNLl2iTdNNU4H5STKTdes5MDPO8lgcAuyNN3ffF0fjhd
         +V/oXTOt5tmP4HAFt4+ATZ8LzN9GYPRmv0l1kpXEgDxa+xp3CIxvbCCa87yAo/R7uiiC
         uONBRr0LW0bhkrhqYOwb+hZVySJX9+2EwOzSAqPsfP4bQZ54kw8O3T2thEfBQxvGC/ld
         WYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S+nbr1OrYRHNY409VOkMcmSTT3pRUeMgxuTnA5h8dvw=;
        b=TM9W+koaaDTXnvViNk7Gs5SPpI9SV3c5IfId0NEA/u2OKylMcGlYcBQtR1fuUE79uo
         PtABCFVyhvFzsAaRQHN2fHcQDl3eZDhEA9DosmFC1scFbwI6IdehEyZdpJcscNCOl2qV
         qCWafFODU5LNCLsi14K1JiuQdXf7Bwfk+P8PVZKehLlv8Gec/sMOGIdKGtSEXMYW1VgR
         WejfKDRbNt/ld+vptqglbCaXBWl/3lB9OHzbVhTEiSrbJL81CTUPft3VtSvAYLDPSjP2
         PJyWRox5mOGXcngxw8HNlAXCqhj2zszFGI0O+kYI4TM5EqwEmwYEO/miZf/cX2n3jPnE
         JQXA==
X-Gm-Message-State: APzg51DbwmKxGhp8TU97RjGQ81akKgb9lOc/HGpwTpInjwEGsxhb+3sh
        Vb8NySdnkgSMRnztN+cZ6pY=
X-Google-Smtp-Source: ANB0VdYLRty9SNEoiELqnB9DpmP4s+MIv6qIWILh7HBMs3Fr4+ygJbRquZuTaAM1Zowqn0TmdrZJqg==
X-Received: by 2002:a37:72c4:: with SMTP id n187-v6mr6686021qkc.103.1535553826096;
        Wed, 29 Aug 2018 07:43:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d923:e823:6a50:26a6? ([2001:4898:8010:0:c259:e823:6a50:26a6])
        by smtp.gmail.com with ESMTPSA id f13-v6sm2066629qth.62.2018.08.29.07.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:43:41 -0700 (PDT)
Subject: Re: Questions about the hash function transition
From:   Derrick Stolee <stolee@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
 <20180828171113.GA23314@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808291458480.71@tvgsbejvaqbjf.bet>
 <04300dbc-622a-c8cb-172e-985726249a8e@gmail.com>
Message-ID: <74787b14-ea63-de76-4eba-ce322aa7b1d2@gmail.com>
Date:   Wed, 29 Aug 2018 10:43:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <04300dbc-622a-c8cb-172e-985726249a8e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2018 9:27 AM, Derrick Stolee wrote:
> On 8/29/2018 9:09 AM, Johannes Schindelin wrote:
>>
>> What I meant was to leverage the midx code, not the .midx files.
>>
>> My comment was motivated by my realizing that both the SHA-1 <-> SHA-256
>> mapping and the MIDX code have to look up (in a *fast* way) information
>> with hash values as keys. *And* this information is immutable. *And* the
>> amount of information should grow with new objects being added to the
>> database.
>
> I'm unsure what this means, as the multi-pack-index simply uses 
> bsearch_hash() to find hashes in the list. The same method is used for 
> IDX lookups.
>
I talked with Johannes privately, and we found differences in our 
understanding of the current multi-pack-index feature. Johannes thought 
the feature was farther along than it is, specifically related to how 
much we value the data in the multi-pack-index when adding objects to 
pack-files or repacking. Some of this misunderstanding is due to how the 
equivalent feature works in VSTS (where there is no IDX-file equivalent, 
every object in the repo is tracked by a multi-pack-index).

I'd like to point out a few things about how the multi-pack-index works 
now, and how we hope to extend it in the future.

Currently:

1. Objects are added to the multi-pack-index by adding a new set of 
.idx/.pack file pairs. We scan the .idx file for the objects and offsets 
to add.

2. We re-use the information in the multi-pack-index only to write the 
new one without re-reading the .pack files that are already covered.

3. If a 'git repack' command deletes a pack-file, then we delete the 
multi-pack-index. It must be regenerated by 'git multi-pack-index write' 
later.

In the current world, the multi-pack-index is completely secondary to 
the .idx files.

In the future, I hope these features exist in the multi-pack-index:

1. A stable object order. As objects are added to the multi-pack-index, 
we assign a distinct integer value to each. As we add objects, those 
integers values do not change. We can then pair the reachability bitmap 
to the multi-pack-index instead of a specific pack-file (allowing repack 
and bitmap computations to happen asynchronously). The data required to 
store this object order is very similar to storing the bijection between 
SHA-1 and SHA-256 hashes.

2. Incremental multi-pack-index: Currently, we have only one 
multi-pack-index file per object directory. We can use a mechanism 
similar to the split-index to keep a small number of multi-pack-index 
files (at most 3, probably) such that the 
'.git/objects/pack/multi-pack-index' file is small and easy to rewrite, 
while it refers to larger '.git/objects/pack/*.midx' files that change 
infrequently.

3. Multi-pack-index-aware repack: The repacker only knows about the 
multi-pack-index enough to delete it. We could instead directly 
manipulate the multi-pack-index during repack, and we could decide to do 
more incremental repacks based on data stored in the multi-pack-index.

In conclusion: please keep the multi-pack-index in mind as we implement 
the transition plan. I'll continue building the feature as planned (the 
next thing to do after the current series of cleanups is 'git 
multi-pack-index verify') but am happy to look into other applications 
as we need it.

Thanks,

-Stolee

