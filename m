Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311BD1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeHUSEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 14:04:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44973 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 14:04:30 -0400
Received: by mail-qt0-f195.google.com with SMTP id r13-v6so1700947qtr.11
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rssUD9mN+JXrWfNl/mVUpNSoRW84DViWeYcODYKcdsQ=;
        b=I+mnophvZw+6rXH9v29Y47rJv4dvuIMItVGGZFY4SdNjEvHyakg23W4vmkuUEAfJZh
         EwPOJk9+q8d5DG7MfRuI4PA4Lfqnshm3JF9Aq62BN+fQFPbftZYXltAvYQkyEs43gSJ3
         hvKKb0s60CuctKEBlf75v9QrfZq0WVx/QjB3OILv8fKN9d7rOFmjBDsTjaQrbSpEXseF
         X/wNmaBDDcyYIbTKrgojRrFVMsM0jpOMst+rBSiIRi0ck0XpFtM7DZhQnaktfxPx6kFT
         gZpMiCPhtZxKu/zbvVtQc2KuaSqLyJ+b+wQF0cgD+UP8zEFmv/eJsQBWi1SbzwWKToam
         bV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rssUD9mN+JXrWfNl/mVUpNSoRW84DViWeYcODYKcdsQ=;
        b=d/eixxdf4C1ZiiClEPzJVSuiWMsX+etAOqdgRjnXdS3AjMgRpvgTXyAUNm3rza3SWE
         pRk+H5mXr7FtrFng4VUvCTHw7hJ3IBXyljOdvDEL6aRHTxZO8UGTgSd4KXd+4Kwi9Kfd
         IW20U2oNhrb2EXBv0mfZHzJv57lM1HsGWDpTF5GK8gj/aTQZck1c0Ok2TH3ohP0eOjHb
         hDlNC9wBE1SSqVoGAr9RH3rSmsSaFsozsjM14odyyuAJqWHYdwb/u1Oe8MnHaF700eme
         PNRjOXHoBPYEgQ6V91Oz8gX/fYdySBw4q32Zznrrx8QbVBrhxgkotvLzn/IiSXxY1Jxb
         gcww==
X-Gm-Message-State: APzg51BdhLC2SG/dPnA3Mv+acdjI0IS2kHY4uy4vF4z0cQKRgjubh6fk
        8nPlLbJiFcQmY314RL1F+VaLtQHY
X-Google-Smtp-Source: ANB0VdbJGfQN1yiQdS4UO3LQ5oSPR+5YbZKo04F+iq152SlwyU/UKpq3FbIPdRYvqW8gm2FyZWExPg==
X-Received: by 2002:ac8:2f24:: with SMTP id j33-v6mr12961235qta.93.1534862643507;
        Tue, 21 Aug 2018 07:44:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id e29-v6sm9488414qte.47.2018.08.21.07.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:44:02 -0700 (PDT)
Subject: Re: [PATCH 0/9] multi-pack-index cleanups
To:     Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180820165124.152146-1-dstolee@microsoft.com>
 <CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <03fd9f73-417c-5afc-a276-d2194eb17668@gmail.com>
Date:   Tue, 21 Aug 2018 10:44:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 10:34 AM, Duy Nguyen wrote:
> On Mon, Aug 20, 2018 at 6:53 PM Derrick Stolee <dstolee@microsoft.com> wrote:
>> To better understand the implications of the multi-pack-index with
>> other scenarios, I ran the test suite after adding a step to 'git repack'
>> to write a multi-pack-index, and to default core.multiPackIndex to 'true'.
>> This commit is available as [1].
>>
>> ...
>>
>> [1] https://github.com/derrickstolee/git/commit/098dd1d515b592fb165a276241d7d68d1cde0036
>>      DO-NOT-MERGE: compute multi-pack-index on repack.
> It should be able to _merge_ this patch, but only activate it when
> some test environment variable is set. On Travis x86 we run the test
> suite twice, once normal, and once with special features activated
> (see "if test "$jobname" = "linux-gcc"" in ci/run-build-and-tests.sh).
> I don't think midx is incompatible with any of those features, so we
> could activate and run the whole test suite with it too.

Interesting. I'll look into this. A similar approach may work for the 
commit-graph.

Thanks,

-Stolee

