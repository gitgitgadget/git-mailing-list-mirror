Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B161F453
	for <e@80x24.org>; Tue, 16 Oct 2018 13:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJPUxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:53:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42922 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPUxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:53:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id j46-v6so25490913qtc.9
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4qgtyYuOV+rZtZ7eIkmPOKwyJOkg3raBhZakPK+Jt6o=;
        b=Q5uoD/itB4KZd1f3JFVXCnMybO+qrYrliNilOIPl/qpDn299OkF1jOmxFfWe8lrMhF
         d6uvMRm2nxMbIl/iQLyXNNAIxN0pGwBxZfX1bIleDWQqcItxBCwzAtkSaq2DuMizvf4P
         U5XlUhjYi8a0kt5zuVNG9mNrvQkglWWS3AouRecrvwQEo0XKtNgPd/THaaRbLGYNqxyv
         gdkgJwhZOszuF5a4ri7T5vb7+fjbFibZLY8r+6zbF/9UVdCUtScXhcz6RfISOZmO/d4u
         AVS+orH5jbqwBfhnqS4eCKzaZDlKSz/kZgUaL6nDMXMswEHZ2QNR0oC8bJZuZmy/Pn5h
         spKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4qgtyYuOV+rZtZ7eIkmPOKwyJOkg3raBhZakPK+Jt6o=;
        b=UczHClqjQ0vraL3gOxJIsLGVgjlc1oqOvb1fuCbfChiN/6uMUw1QMjSJzZfjRhwRz9
         SQhI4wsrmQKpc6AdAmGWJZlRzsch4ZtGBntmGdyTaJLGHSI9SJ1eyweH5MUAHfmVY+uE
         5GCMuNgFioKzCijuUa8XorpIV3FV+fGzaMRq3ogWXVoKM9oucn8oKOQ/Akg5J7Um8DJZ
         oa9avKRy3XIE8p/R9t8vkin0T5C5WWJrwUK0C6LUyqe84AJJ++NqClG7/YCmJsew5tQB
         YNvxyspnUg+H/47bUhYgTEeCGNBR8sFsgFJtVRtii213Tak9w1/HX0NhNBh7Vg/Np1VD
         TrYQ==
X-Gm-Message-State: ABuFfojvhNM2LVweKdnNdkGvGyoq8P9jvCKz8/vi/8jGa5ZPqFCwCXpT
        cxST7XFqBUJHp3CaM0SD0AwOogsqlPY=
X-Google-Smtp-Source: ACcGV63Q5LGNsEHyXaVAibEA+BTJSklUgU4XnlCRc96iFittOcRApXxPK9Y2LIjE//wKzI7cs4iMxQ==
X-Received: by 2002:ac8:2c49:: with SMTP id e9-v6mr20445795qta.17.1539694996035;
        Tue, 16 Oct 2018 06:03:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:293d:4c41:9115:1167? ([2001:4898:8010:0:1273:4c41:9115:1167])
        by smtp.gmail.com with ESMTPSA id l3-v6sm15715069qtl.2.2018.10.16.06.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:03:15 -0700 (PDT)
Subject: Re: [PATCH 0/4] Bloom filter experiment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
 <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
 <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com>
 <8c66cbe3-6830-05cb-f3bb-be2e4902e8f5@gmail.com>
 <87zhvecamd.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ec496cf6-1d54-e9af-6269-65350ab35a47@gmail.com>
Date:   Tue, 16 Oct 2018 09:03:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87zhvecamd.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2018 8:57 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Oct 16 2018, Derrick Stolee wrote:
>
>> On 10/16/2018 12:45 AM, Junio C Hamano wrote:
>>> Derrick Stolee <stolee@gmail.com> writes:
>>>
>>>> 2. The filters are sized according to the number of changes in each
>>>> commit, with a minimum of one 64-bit word.
>>>> ...
>>>> 6. When we compute the Bloom filters, we don't store a filter for
>>>> commits whose first-parent diff has more than 512 paths.
>>> Just being curious but was 512 taken out of thin air or is there
>>> some math behind it, e.g. to limit false positive rate down to
>>> certain threshold?  With a wide-enough bitset, you could store
>>> arbitrary large number of paths with low enough false positive, I
>>> guess, but is there a point where there is too many paths in the
>>> change that gives us diminishing returns and not worth having a
>>> filter in the first place?
>> 512 is somewhat arbitrary, but having a maximum size is not.
>>> In a normal source-code-control context, the set of paths modified
>>> by any single commit ought to be a small subset of the entire paths,
>>> and whole-tree changes ought to be fairly rare.  In a project for
>>> which that assumption does not hold, it might help to have a
>>> negative bloom filter (i.e. "git log -- A" asks "does the commit
>>> modify A?" and the filter would say "we know it does not, because we
>>> threw all the paths that are not touched to the bloom filter"), but
>>> I think that would optimize for a wrong case.
>> A commit with many changed paths is very rare. The 512 I picked above
>> is enough to cover 99% of commits in each of the repos I sampled when
>> first investigating Bloom filters.
>>
>> When a Bloom filter response says "maybe yes" (in our case, "maybe not
>> TREESAME"), then we need to verify that it is correct. In the extreme
>> case that every path is changed, then the Bloom filter does nothing
>> but add extra work.
>>
>> These extreme cases are also not unprecedented: in our Azure Repos
>> codebase, we were using core.autocrlf to smudge CRLFs to LFs, but
>> when it was time to dogfood VFS for Git, we needed to turn off the
>> smudge filter. So, there is one commit that converts every LF to a
>> CRLF in every text file. Storing a Bloom filter for those ~250,000
>> entries would take ~256KB for essentially no value. By not storing a
>> filter for this commit, we go immediately to the regular TREESAME
>> check, which would happen for most pathspecs.
>>
>> This is all to say: having a maximum size is good. 512 is big enough
>> to cover _most_ commits, but not so big that we may store _really_ big
>> filters.
> Makes sense. 512 is good enough to hardcode initially, but I couldn't
> tell from briefly skimming the patches if it was possible to make this
> size dynamic per-repo when the graph/filter is written.
My proof-of-concept has it as a constant, but part of my plan is to make 
these all config options, as of this item in my message:

 >>> 2. We need config values for writing and consuming bloom filters, 
but also to override the default settings.

> I.e. we might later add some discovery step where we look at N number of
> commits at random, until we're satisfied that we've come up with some
> average/median number of total (recursive) tree entries & how many tend
> to be changed per-commit.
>
> I.e. I can imagine repositories (with some automated changes) where we
> have 10k files and tend to change 1k per commit, or ones with 10k files
> where we tend to change just 1-10 per commit, which would mean a
> larger/smaller filter would be needed / would do.
I'm not sure a dynamic approach would be worth the effort, but I'm open 
to hearing the results of an experiment.

Thanks,
-Stolee
