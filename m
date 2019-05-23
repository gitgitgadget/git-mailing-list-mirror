Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA471F462
	for <e@80x24.org>; Thu, 23 May 2019 13:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfEWNA7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 09:00:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWNA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 09:00:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so6533296qta.9
        for <git@vger.kernel.org>; Thu, 23 May 2019 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlwUN1mQFjrh0pHSjgzBaeZacNJFgjOlcAQuH2RU+Zw=;
        b=tpEhxbW2pgpSa/QLZrKV/+pJVSMIDmJaQDA3owvbgJiDm0aIpfc1FsIYDoNeEIV5zf
         7aZaZ1DvsNdys7dXP3MpGMTFgSJFIJH9b/r3ZjDMosxMJoEHL9JKhY2bUCivgfTNM+X/
         NVhSbSIuiWNKkJOOYA7+l10VjXQPPmI/im9TXIMZephVTsOmDYazW6yk0YoUd+RLCd4E
         rbN9Pn+wbbRBQy6DySI3pe+uy723aQtpMPXuBmeqKwyN0bSXWpK7fpOMTTmTJmD3xw72
         vNo7ZlkACPNe4RsNIz5u4od2NET+kUcy/U/lYHC6I2D7kQcl6u8ASK5jZRdCRYgeLDRG
         zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlwUN1mQFjrh0pHSjgzBaeZacNJFgjOlcAQuH2RU+Zw=;
        b=GKbXMqF+1cpN8lqPEEJFmgbao6XEUqQAOT+bh1iq8QFO6Fu5Kl9mxxE+OJbcixKFUt
         +vjAaBW5F+RpSYG5zCsCyNZMBrsH8gOc74rK/M0p5KBBGLsNe8AJjmeA6XufKfT5e5xQ
         nQXxul6HpmX/Z07CUZmi0Tyh/FWL4Mo81SsGMOzq7uGbnOU1eQXJiG9PgnsI2GXZLSuK
         rJrBEEfKzv/ceHfjSAtmWyECGx7djlOltj2nFxwdltNpXduV+eZT53eeulipIif+lqtM
         hA7GmB6NKeyOJIvgV8wh54mZSfXDXz2Yxot+2ml7wpMPwmj6dNDlj+WoZKxbTdmAHUhA
         wV4A==
X-Gm-Message-State: APjAAAWj3Fgyc1+IJq3BHscuJygqXVtA7KbJts6LcTzzCnexMIlwhC6R
        PMPqdMU/afIIBNlfImNMkdA=
X-Google-Smtp-Source: APXvYqz4WAqwQqfcP1W+XBrRXgc/umqRY4EIrwEzgpsG0mGdRkLChh2NaVJ0B5cll1N30bm5mqXnwA==
X-Received: by 2002:ac8:2e38:: with SMTP id r53mr80643783qta.192.1558616458120;
        Thu, 23 May 2019 06:00:58 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2932:ade9:ad1d:97b8? ([2001:4898:a800:1010:da67:ade9:ad1d:97b8])
        by smtp.gmail.com with ESMTPSA id m21sm2104344qkk.0.2019.05.23.06.00.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 06:00:57 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] commit-graph: merge commit-graph chains
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <pull.184.v2.git.gitgitgadget@gmail.com>
 <9567daa0b88e9fa2e755d9060341c7a39629ea86.1558554800.git.gitgitgadget@gmail.com>
 <87zhnet2zp.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ae1189cf-d9a6-b5d9-6b0b-e460d59dc9a0@gmail.com>
Date:   Thu, 23 May 2019 09:00:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87zhnet2zp.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2019 8:43 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, May 22 2019, Derrick Stolee via GitGitGadget wrote:
> 
>> To keep lookups fast, but also keep most incremental writes fast, create
>> a strategy for merging levels of the commit-graph chain. The strategy is
>> detailed in the commit-graph design document, but is summarized by these
>> two conditions:
>>
>>   1. If the number of commits we are adding is more than half the number
>>      of commits in the graph below, then merge with that graph.
>>
>>   2. If we are writing more than 64,000 commits into a single graph,
>>      then merge with all lower graphs.
>>
>> The numeric values in the conditions above are currently constant, but
>> can become config options in a future update.
>> [...]
>> +## Merge Strategy
>> +
>> +When writing a set of commits that do not exist in the commit-graph stack of
>> +height N, we default to creating a new file at level N + 1. We then decide to
>> +merge with the Nth level if one of two conditions hold:
>> +
>> +  1. The expected file size for level N + 1 is at least half the file size for
>> +     level N.
>> +
>> +  2. Level N + 1 contains more than MAX_SPLIT_COMMITS commits (64,0000
>> +     commits).
>> +
>> +This decision cascades down the levels: when we merge a level we create a new
>> +set of commits that then compares to the next level.
>> +
>> +The first condition bounds the number of levels to be logarithmic in the total
>> +number of commits.  The second condition bounds the total number of commits in
>> +a `graph-{hashN}` file and not in the `commit-graph` file, preventing
>> +significant performance issues when the stack merges and another process only
>> +partially reads the previous stack.
>> +
>> +The merge strategy values (2 for the size multiple, 64,000 for the maximum
>> +number of commits) could be extracted into config settings for full
>> +flexibility.
> 
> As noted this can become configurable, so it's no big deal. But is there
> any reason for ths 64K limit anymore?

There may not be an important reason to include it by default. Whatever config
option we use could have special values:

 * -1: No maximum commit limit (default)
 *  0: Never write more than one level.

I would personally set a limit somewhere around 64,000 to prevent long chains
and having some processes hit a concurrency issue where their run-time
commit-graph is effectively 100,000 commits behind.

> While with the default expiry of 0sec we can still get that race, it
> seems unlikely in practice, as the "commit-graph write" process would
> write a new manifest at the end, then go and unlink() the old files.

The process reading an old manifest can still only succeed partially as it
reads the chain from bottom-to-top. Succeeding gracefully in this case is
built-in, but should have a test! (noted)

But I don't think the concurrency window is any more lenient than before.
We now have the flexibility to set a non-zero expiry window. That was
impossible in the other model.

> So maybe at this point we could make this even dumber with something
> that behaves like gc.autoPackLimit? I.e. keep writing new graphs, and
> then coalesce them all (or maybe not the "base" graph, like
> gc.bigPackThreshold)?

I will look into these existing settings and try to include similar options
here. Better to stay consistent when we can.

> Also: These docs refer to MAX_SPLIT_COMMITS, but in v2 it's now a
> "split_strategy_max_commits" variable instead.

Thanks for catching my out-of-date documentation.

-Stolee

