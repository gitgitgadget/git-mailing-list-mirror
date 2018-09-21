Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312AE1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbeIUVhV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:37:21 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:40658 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUVhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:37:21 -0400
Received: by mail-qt1-f169.google.com with SMTP id e9-v6so1747065qtp.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8rWR4uSq+rMlFHrJachtg1UKfx5WfI7km8QYHWYSTb0=;
        b=XEnXO2kRYuHKkAc5idOPJixT15ElQ0RKHATv/Q/uBw/ZsrJ+fOHJ+LnydqhSN2iRc7
         4KGYEE7Fbw5duVIYe3iNzyn2ozS0+ZxtY/eidCSGZIjNzSGwXt4UpaQtB+eGg9gj6lrj
         4dC/RPUJi7qbDgoFKaP/f8sHGAhPP7zd/QZMRBdR8qjipAE85Dxp/8C9IiYsOEkltoh3
         oYDbNgAO7UMHxNfKkYKNuM6FqJUt+vnhnQMrs12Gojj9rXpk5VlHh++tUzaIaNZAKiKV
         o9Fhi51bPAX5uh0l1KlPtk49f2cHCAz07DxkOkRYILmjdRzzpICDF5zcXnZgZxPFg0Ka
         dJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8rWR4uSq+rMlFHrJachtg1UKfx5WfI7km8QYHWYSTb0=;
        b=CShSxLW2Zyl9wEku4WtWksDJz7FjBOPBcsnLCRMNxWcxAcK3eAoi45rxLSiI9EDPY3
         IDas4Xxyd/xjivuUwVrq5yLkNJXXiOX/cYRuyZhIwgQbNa11pWeowfltuf4zhkroLI2b
         iY9RHi7mCQrzw6mORVCypCUHIHNN+W73JNk95jCtSx66TNt3UkmHOvZMNputQU0Kj1HP
         zw0seS3inYZZOVxiuhJaFPnpXUYMAzzx+XyK+GdMbe6D3RxDBSWfJywJAY0akuq1J7Cl
         V9lUNdiHY25gPk4RvENp5AqH0Il2Zz3t6hN62lwsnDAUbFovZak7ukb7DJKN+8G2kWey
         Q6/g==
X-Gm-Message-State: ABuFfoiNLdLCE7L3plbrEYBYLX50knEZmBDRXQ8awDOjGK3RImfay8Pj
        ajQvr/xvr46/OoUt/etkqRg=
X-Google-Smtp-Source: ACcGV60FszmT7NyIGKKT+7f7Z5rD6vNc7m4ktcHByV8xoMqf58elQp5ySW+RtKgiZXayPQOTnuks/A==
X-Received: by 2002:a0c:af55:: with SMTP id j21-v6mr1286821qvc.149.1537544871799;
        Fri, 21 Sep 2018 08:47:51 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id v7-v6sm15181317qkc.29.2018.09.21.08.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:47:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Use generation numbers for --topo-order
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.25.git.gitgitgadget@gmail.com>
 <pull.25.v2.git.gitgitgadget@gmail.com> <87worjjq6o.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2d72ae31-774e-d0a4-8b6c-ea125377eac5@gmail.com>
Date:   Fri, 21 Sep 2018 11:47:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87worjjq6o.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2018 2:05 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Sep 18 2018, Derrick Stolee via GitGitGadget wrote:
>
> Thanks. Good to see the commit graph used for more stuff.
>
>> On the Linux repository, I got the following performance results when
>> comparing to the previous version with or without a commit-graph:
>>
>> Test: git rev-list --topo-order -100 HEAD
>> HEAD~1, no commit-graph: 6.80 s
>> HEAD~1, w/ commit-graph: 0.77 s
>>    HEAD, w/ commit-graph: 0.02 s
>>
>> Test: git rev-list --topo-order -100 HEAD -- tools
>> HEAD~1, no commit-graph: 9.63 s
>> HEAD~1, w/ commit-graph: 6.06 s
>>    HEAD, w/ commit-graph: 0.06 s
> It would be great if this were made into a t/perf/ test shipped with
> this series, that would be later quoted in a commit, as in
> e.g. 3b41fb0cb2 ("fsck: use oidset instead of oid_array for skipList",
> 2018-09-03).
>
> Although generalizing that "-- tools" part (i.e. finding a candidate
> dir) will require some heuristic, but would make it useful when running
> this against other erpos.

t/perf/p4211-line-log.sh has the following test:


     test_perf 'git log --oneline --raw --parents -1000' '
             git log --oneline --raw --parents -1000 >/dev/null
     '

We could add the following to the end of that script to get similar 
values, since it already selects a file randomly at the top of the script:

     test_perf 'git log --oneline --raw --parents -1000 -- <file>' '
             git log --oneline --raw --parents -1000 -- $file >/dev/null
     '

>
>> If you want to read this series but are unfamiliar with the commit-graph and
>> generation numbers, then I recommend reading
>> Documentation/technical/commit-graph.txt or a blob post [1] I wrote on the
>> subject. In particular, the three-part walk described in "revision.c:
>> refactor basic topo-order logic" is present (but underexplained) as an
>> animated PNG [2].
> We discussed some of this in private E-Mail, and this isn't really
> feedback on *this* series in particular, just on the general
> commit-graph work.
>
> Right now git-config(1) just matter-of-factly says how to enable it, and
> points to git-commit-graph(1) for further info, which just shows how to
> run the tool. But nothing's describing what stuff is sped up, and those
> sorts of docs aren't being updated as new optimizations (e.g. this
> --topo-order walk) are added.
>
> For that you need to scour a combination of your blogpost & commits in
> git.git (with quoted perf numbers).

Thanks for reminding me. I have this on my list of TODOs.

-Stolee

