Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8AC1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 13:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeH2RYg (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 13:24:36 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45652 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 13:24:36 -0400
Received: by mail-qt0-f182.google.com with SMTP id g44-v6so5630359qtb.12
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DEws3AJ+MM1IlIErmd4DZodKriyRgb4qsrI1qYyhaEE=;
        b=mQEd2sqWXcSSy+2FPqpvl38vnaDbabAIk3jXRgVVraKIs/VUb5WJFQuLrP1NH1hqij
         HfeLSjfVIPqG/QeDEZr0aMXA+UChPnhDck1Rcr0QJuVEAUVBRqz4S81E5XBE3800lPTq
         9OoH0CwL1xaOHNkgRY48k28kCMAtw1qXHpjFNgqpbZDPv3CANIjSf3Z2ysB8r7Swk3cN
         9XMGqpMvzsjkXNrRg6aVRF2J6p0dm/TgL37cry5r6uBnalTbFBmrCSBt7Rblcto3F2cv
         ZilDN2mXR1iaX1CUkstu8IL1/5hJubNYef0tYkNLBTailGUEBzEocy8Dg4SSvUaJ3CUn
         0SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DEws3AJ+MM1IlIErmd4DZodKriyRgb4qsrI1qYyhaEE=;
        b=GhW67qo27cj5CviW23MjdNKLWSTm6aIhRNGRk8wnGftW46yUFch283SszhMDn5Wo2X
         0RPBe7D0R+nS7iJ3bOuJMg5ksBdmpOVnw8ylJqDi075aIJnNHkUrXBDe48tTRsAqQ909
         3ztaSPGvpTzbBtwJzLqJR2xzh22vs4IgMABRixpJftcoYhVfbB61N9scPOhhOzQNwiwf
         eHJcmH2JP4iL2G1HmNnQx0sofztRVxPldwiVFCSpZtodyU3252VHmnirdeNW5FS4hGPD
         XWhCVhDzG1TC0fozcTFajUKTI24KnajPcN/ANQ8VLRv+omLsuUQZE4dJgxqP6nZNHOeq
         bfxg==
X-Gm-Message-State: APzg51CHhDjLR0DMqTbSjqVP4iFn/iDrP5sTOTDAHv3diO7sEAEZBmEd
        aImycEp5MoZzRFPCncmgOBM=
X-Google-Smtp-Source: ANB0VdY53DKGMC7t2di4s9m/EMfFwBTAMJLdcWlu0VY1FFvzOfUrlT4DoZdK9MiGdOifYUSy1noKmQ==
X-Received: by 2002:aed:36a9:: with SMTP id f38-v6mr6767803qtb.64.1535549258013;
        Wed, 29 Aug 2018 06:27:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id f6-v6sm2283865qke.77.2018.08.29.06.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:27:37 -0700 (PDT)
Subject: Re: Questions about the hash function transition
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04300dbc-622a-c8cb-172e-985726249a8e@gmail.com>
Date:   Wed, 29 Aug 2018 09:27:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1808291458480.71@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2018 9:09 AM, Johannes Schindelin wrote:
> Hi Jonathan,
>
> On Tue, 28 Aug 2018, Jonathan Nieder wrote:
>
>> Johannes Schindelin wrote:
>>> On Thu, 23 Aug 2018, Jonathan Nieder wrote:
>>>> Ævar Arnfjörð Bjarmason wrote:
>>>>> Are we going to need a midx version of these mapping files? How does
>>>>> midx fit into this picture? Perhaps it's too obscure to worry
>>>>> about...
>>>> That's a great question!  I think the simplest answer is to have a
>>>> midx only for the primary object format and fall back to using
>>>> ordinary idx files for the others.
>>>>
>>>> The midx format already has a field for hash function (thanks,
>>>> Derrick!).
>>> Related: I wondered whether we could simply leverage the midx code for
>>> the bidirectional SHA-1 <-> SHA-256 mapping, as it strikes me as very
>>> similar in concept and challenges.
>> Interesting: tell me more.
>>
>> My first instinct is to prefer the idx-based design that is already
>> described in the design doc.  If we want to change that, we should
>> have a motivating reason.
>>
>> Midx is designed to be optional and to not necessarily cover all
>> objects, so it doesn't seem like a good fit.

It is optional, but shouldn't this mode where a Git repo that needs to 
know about two different versions of all files be optional? Or at least 
temporary?

The multi-pack-index is intended to cover all packed objects, so covers 
the same number of objects as an IDX-based strategy. If we are 
rebuilding the repo from scratch by translating the hashes, then "being 
too big to repack" is probably not a problem, so we would expect a 
single IDX file anyway.

In my opinion, whatever we do for the IDX-based approach will need to be 
duplicated in the multi-pack-index. The multi-pack-index does have a 
natural mechanism (optional chunks) for inserting this data without 
incrementing the version number.

> Right.
>
> What I meant was to leverage the midx code, not the .midx files.
>
> My comment was motivated by my realizing that both the SHA-1 <-> SHA-256
> mapping and the MIDX code have to look up (in a *fast* way) information
> with hash values as keys. *And* this information is immutable. *And* the
> amount of information should grow with new objects being added to the
> database.

I'm unsure what this means, as the multi-pack-index simply uses 
bsearch_hash() to find hashes in the list. The same method is used for 
IDX lookups.

> I know that Stolee performed a bit of performance testing regarding
> different data structures to use in MIDX. We could benefit from that
> testing by using not only the results from those tests, but also the code.

I did test ways to use something other than bsearch_hash(), such as 
using a 65,536-entry fanout table for lookups using the first two bytes 
of a hash (tl;dr: it speeds things up a bit, but the super-small 
improvement is probably not worth the space and complexity). I've also 
toyed with the idea of using interpolation search inside bsearch_hash(), 
but I haven't had time to do that.

> IIRC one of the insights was that packs are a natural structure that
> can be used for the MIDX mapping, too (you could, for example, store the
> SHA-1 <-> SHA-256 mapping *only* for objects inside packs, and re-generate
> them on the fly for loose objects all the time).
>
> Stolee can speak with much more competence and confidence about this,
> though, whereas all of what I said above is me waving my hands quite
> frantically.

I understand the hesitation to pair such an important feature (hash 
transition) to a feature that hasn't even shipped. We will need to see 
how things progress on both fronts to see how mature the 
multi-pack-index is when we need this transition table.

Thanks,

-Stolee

