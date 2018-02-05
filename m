Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772991F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbeBET3e (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:29:34 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35362 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbeBET3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:29:32 -0500
Received: by mail-qt0-f195.google.com with SMTP id g14so41117947qti.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6x8QZX+cyLaMQ9BwKNeo1JRn423hDGQTepW6xJZeJgs=;
        b=Hy3YutXR7wHIsmdHfy7HNXoJajLmM/CyalFGaHr9u8L3p10wdt4lujcmLDQqXu8c7b
         Y9vXHW4b8e/79wxmpNaeiKS6QWy4KuGDAracOmb/H1t6wqv0v1VgolSyYjetFH0acezN
         OgiStyMuTXwXKsEzRcB67Igxh6RZzYZuPKI0GDGKx5dM+T1sTDVkSEBZM+4FKWCt6oPg
         YFrnSvgtDCjO8Cypw0jBtDtENylrhXEPlzXPBt0AsDON/7198nFYfgBwZOpi1w/quxMe
         EgIYJXB/otMAsYPdNTBQEHD85AuQ/3Ap1hVyk0K0XdE1lrCcMv0aDexUIyUq34Iql/IL
         cVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6x8QZX+cyLaMQ9BwKNeo1JRn423hDGQTepW6xJZeJgs=;
        b=NqJTqWZejQxpJyTBWtdgJ/BUCBQhibMApFdUnlFHuo5YOJQwSp4gAr9qwtcoIhCqZ2
         7EIcSIR3B2zQz3uF0xbJEB5A3ip/cONBadzWhdc28f84/yxr7njYD9peJrPL1lHMlVHF
         UEsyEs+irhI8m9qNfheF077c48xhf6i4+N67sGG8voxhtn4tXcSqN5YwhLA0C2S0mJHh
         AJhlbrcxWhjGWuYBNQxX1exSvKQisLAVhXkHWwaNtSQCSC9smXoP+egTLr1NEsxDRGY/
         m7WbmqQ15AVnTCeh9dEqzuNfwFDnFeyfYlXz64QmhEuC/8XZVshK7PIPbD7V582rZ3UH
         3N5Q==
X-Gm-Message-State: AKwxytfJQuIaEMEdGqDOMH1rfOH19XmDGH9sXZ4SISNirTQyM5EFP9Fr
        NyTVIfLPUQVy9ex3m7UVpMQ=
X-Google-Smtp-Source: AH8x224JgNmHxXkvvlYzN3z+wWwQCqsWLeVASBINX1SPf80+0N9QcUnNZx/G39haHyfIGc4MPM2RaA==
X-Received: by 10.200.41.143 with SMTP id 15mr80183116qts.247.1517858971585;
        Mon, 05 Feb 2018 11:29:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q2sm6259733qki.26.2018.02.05.11.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 11:29:30 -0800 (PST)
Subject: Re: [PATCH v2 06/14] commit-graph: implement git-commit-graph --read
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
 <20180201162324.fa8b38531955ee5378e5c5ff@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a460925-a143-ecc0-8651-900b8e731caf@gmail.com>
Date:   Mon, 5 Feb 2018 14:29:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180201162324.fa8b38531955ee5378e5c5ff@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2018 7:23 PM, Jonathan Tan wrote:
> On Tue, 30 Jan 2018 16:39:35 -0500
> Derrick Stolee <stolee@gmail.com> wrote:
>
>> Teach git-commit-graph to read commit graph files and summarize their contents.
> One overall question - is the "read" command meant to be a command used
> by the end user, or is it here just to test that some aspects of reading
> works? If the former, I'm not sure how useful it is. And if the latter,
> I think that it is more useful to just implementing something that reads
> it, then make the 11/14 change (modifying parse_commit_gently) and
> include a perf test to show that your commit graph reading is both
> correct and (performance-)effective.

The "read" command is intended for use with the tests to verify that the 
different --write commands write the correct number of commits at a 
time. For example, we can verify that the closure under reachability 
works when using --stdin-commits, that we get every commit in a pack 
when using --stdin-packs, and that we don't get more commits than we should.

It doesn't serve much purpose on the user-facing side, but this is 
intended to be a plumbing command that is called by other porcelain 
commands.
