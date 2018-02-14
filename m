Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40D11F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161635AbeBNSI5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:08:57 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34899 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161585AbeBNSI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:08:56 -0500
Received: by mail-qt0-f195.google.com with SMTP id g14so8817350qti.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KD6qCdkJFoHyzDLcvw+AVfWGcVDbmSJk5T92wH84u7w=;
        b=FktoqkTqwqFgmz7ANB+5oN8BmU03ViYOWG9zvnjub5gjkq/l6K65TPMh9NChXBm3PX
         +1GqnnTdqRb520UFrma67y3JJyawkGCTGo+bgX9SHWdD5df1whtdxbKN2ZTxaSH07y3D
         X0xmm2/ErDZOSqE9aBdv1jR3lx4NyqP6P+owf2+hMH0CodD5ZgxugkTa54za6N8c121P
         kG5FhqgERk3KYH8DzjKZ4Qa1DzKrhYBbKoudY4c8KrHqJY0h+DFxeID6JvQTc6Y2Wx3Z
         0f6+ZynDnRpbsa49yTRxVGEcW7tJp+TAD3zZ71vdYT3gFBzEB7HHwdD2jW9zzqFmlhc/
         ccpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KD6qCdkJFoHyzDLcvw+AVfWGcVDbmSJk5T92wH84u7w=;
        b=M4HjTTxh2yiftgq3iMNK2X8mxTv4+i/N1qlibh3eeaEPpaPPe0+vCJ7GpHMaEErkYs
         xmOYsdFfeYhm51HRauZqcnTlBIcFAdg1umJ8SaxfFSm5qsHJlpBFKfTWybNA/ltgUoOZ
         lgPQvR5kBe9rsujxaF80VYQJMTGMqhjO0sS2wAJE6B08LVhhd0MWYjc970Mjt2je9N39
         wNG4NAFjWl4+b0J2xc8QmwIcUa9fQNzSxK/6drdrJpTcLpNqnGb4LEuyQsq7t8AiIhGn
         oBLhIoyBMxhYbOuqY10qDdPaReV2dIVtrOpFENG5saysHCqtf6TQAwgOrk/rjC0BklTz
         4w2g==
X-Gm-Message-State: APf1xPDj6Aw2apWud41q2/rIMvDGKWg09cDrba4Bjs0JsBPFUqsIKDgF
        pneC7McitbbXxyEtPMo2w5o=
X-Google-Smtp-Source: AH8x227HZ4kg7cC0/L4HNYK4939Z+1nrBmEj68aaO68jIBkkvNWXEY/cmZdGRfryPVnlxT37yCpGpw==
X-Received: by 10.200.54.100 with SMTP id n33mr22469qtb.271.1518631735648;
        Wed, 14 Feb 2018 10:08:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o59sm4412729qte.36.2018.02.14.10.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 10:08:54 -0800 (PST)
Subject: Re: [PATCH v3 11/14] commit: integrate commit graph with commit
 parsing
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
 <20180213161225.6e21291d25015be632b03fee@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e53ef79-e196-e524-194c-741851db0755@gmail.com>
Date:   Wed, 14 Feb 2018 13:08:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213161225.6e21291d25015be632b03fee@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2018 7:12 PM, Jonathan Tan wrote:
> On Thu,  8 Feb 2018 15:37:35 -0500
> Derrick Stolee <stolee@gmail.com> wrote:
>
>> | Command                          | Before | After  | Rel % |
>> |----------------------------------|--------|--------|-------|
>> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
>> | branch -vv                       |  0.42s |  0.27s | -35%  |
>> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
>> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |
> Could we have a performance test (in t/perf) demonstrating this?

The rev-list perf tests are found in t/perf/p0001-rev-list.sh

The "log --oneline --topo-order -1000" test would be good to add to 
t/perf/p4211-line-log.sh

The "branch -vv" test is pretty uninteresting unless you set up your 
repo to have local branches significantly behind the remote branches. It 
depends a lot more on the data shape than the others which only need a 
large number of reachable objects.

One reason I did not use the builtin perf test scripts is that they seem 
to ignore all local config options, and hence do not inherit the 
core.commitGraph=true setting from the repos pointed at by GIT_PERF_REPO.

>
>> +static int check_commit_parents(struct commit *item, struct commit_graph *g,
>> +				uint32_t pos, const unsigned char *commit_data)
> Document what this function does? Also, this function probably needs a
> better name.
>
>> +/*
>> + * Given a commit struct, try to fill the commit struct info, including:
>> + *  1. tree object
>> + *  2. date
>> + *  3. parents.
>> + *
>> + * Returns 1 if and only if the commit was found in the commit graph.
>> + *
>> + * See parse_commit_buffer() for the fallback after this call.
>> + */
>> +int parse_commit_in_graph(struct commit *item)
>> +{
> The documentation above duplicates what's in the header file, so we can
> probably omit it.
>
>> +extern struct object_id *get_nth_commit_oid(struct commit_graph *g,
>> +					    uint32_t n,
>> +					    struct object_id *oid);
> This doesn't seem to be used elsewhere - do you plan for a future patch
> to use it?

