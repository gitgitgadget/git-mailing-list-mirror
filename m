Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33722013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbdBOSqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:46:08 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:37947 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdBOSqI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:46:08 -0500
Received: by mail-it0-f54.google.com with SMTP id c7so71013415itd.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LpHxO+Hmy8c9HIt1uc0dE6doh/rBXoeP0WgU/GUs30A=;
        b=dMcs2BcaAhB/86cLt7aHf0ABO/L5m0dbUReNWU9yptp09kCt54VKnC1CH8d0yjF+xv
         OVG9MbD6o9MBoi2F08y9k4ceX2kn7ViNHJCNrgbgKVyJZgxInLpOhwTtpSRooJ4ptdYe
         TOnxebKGwBXDWAblMn7o9tYhhLLHgEglG8e8qdH0LpZmesalJzDd4od6qPJuzdk/pMEx
         7VUBOMkViJtXUc9l/WX6w7sgytBjqpptLM66u2rwVr6GXkgnnLmvqonHAo1RZJvz+Apb
         fiAcYSxsWtVT8iTA4vE68IeFG6c+7An2DrNuEP6L8GHSKMiaT2mtYXaZapKT0rX/B6zk
         skhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LpHxO+Hmy8c9HIt1uc0dE6doh/rBXoeP0WgU/GUs30A=;
        b=QiNFQFRim/Z9toZaCoe5Weoy2wKnTc2QlUBvul51PZw4ccJQGQqprMIcqINziBOCDs
         iagB4gqxxqFt6aa1KBSGHfRk3BC7hTWcYVEnwhDVwvesig89QDE88BCgmq5Xgx948F0e
         /JoAdtQ5wV8bMatSGUDjDon/vfqdqF6r8oBT7P2qE8POfHktETyko8kjXtX/kOsjkZrk
         bq9NIJybFeeqm7wGivwc4H20k2dyWLnhdGhBv+A6X24BNPxvkkGWPBdhjYGGmeWC0MBi
         Ywc83z2K++psqlY2lnDJyxebhq56jIg2BlREs5xBo6xXXmG5ooqQOGHX3YdoaxZHJd5g
         sN8A==
X-Gm-Message-State: AMke39nvfHFvfWK8B+mhLY3HZlUNhG/9MWr9Vn060kZ4Wr9rKKs8hRqWbO6wLuXwcCb8T4arch+vVU/Px6mAxtum
X-Received: by 10.36.65.161 with SMTP id b33mr10469074itd.114.1487184366823;
 Wed, 15 Feb 2017 10:46:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 10:46:06 -0800 (PST)
In-Reply-To: <20170215170441.GB29448@google.com>
References: <20170215003423.20245-1-sbeller@google.com> <20170215003423.20245-8-sbeller@google.com>
 <20170215170441.GB29448@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:46:06 -0800
Message-ID: <CAGZ79kbN4e4btgVzzW7yKyUuaf7htmYFutp7ALhtygsKpFsTyQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] update submodules: introduce is_interesting_submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 9:04 AM, Brandon Williams <bmwill@google.com> wrote:
> On 02/14, Stefan Beller wrote:
>> In later patches we introduce the --recurse-submodule flag for commands
>> that modify the working directory, e.g. git-checkout.
>>
>> It is potentially expensive to check if a submodule needs an update,
>> because a common theme to interact with submodules is to spawn a child
>> process for each interaction.
>>
>> So let's introduce a function that pre checks if a submodule needs
>> to be checked for an update.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c | 26 ++++++++++++++++++++++++++
>>  submodule.h |  8 ++++++++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/submodule.c b/submodule.c
>> index c0060c29f2..4c33374ae8 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -551,6 +551,32 @@ void set_config_update_recurse_submodules(int value)
>>       config_update_recurse_submodules = value;
>>  }
>>
>> +int submodules_interesting_for_update(void)
>> +{
>> +     /*
>> +      * Update can't be "none", "merge" or "rebase",
>> +      * treat any value as OFF, except an explicit ON.
>> +      */
>> +     return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
>> +}
>> +
>> +int is_interesting_submodule(const struct cache_entry *ce)
>
> Is there perhaps a more descriptive function name we could use instead
> of "is_interesting"?  The problem is that its difficult to know why its
> interesting or for what purpose it is interesting.

I should finish the background story patch first. By 'is_interesting' I mean
* it is active/initialized/"The user expressed interested in the submodule by
  setting submodule.<name>.URL
* its submodule.<name>.update strategy is != NONE.

The second point is interesting, as that entertains the thought that we'll pay
attention to the submodule.<name>.update strategy at all and
we may want to also implement rebase/merge eventually.

So I think we'd want to tighten that down to "checkout" only for now.

Thanks,
Stefan
