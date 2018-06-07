Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FE01F403
	for <e@80x24.org>; Thu,  7 Jun 2018 15:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934696AbeFGOyS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:54:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42899 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934972AbeFGOyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id j80-v6so6710492qke.9
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XEJHmIWbpcKkujM0HJLABQyJDhVg90XuG5Syf4NSf/Q=;
        b=OINj00Cr8rFLzCbfZYVRdZFuZYKR31gm/iTnvnjrgeIAYxs2TfS7Vj3dZaLegBQtH9
         +osBA2oY5UxUZXC2AQqi55wSoyNbELFkR4iR8VEdpZM8aAlVrw52CIzxRu5D9fvXdHGm
         gPD2wevjHBPe6t3XGeEKBrv7ZYQN7X3JDzJqiEP4NIdfS0bA3FHt4zAZZGZ76kYy+cXT
         7Ru0wCv397S59G33H2J0AGx/R1s15KiKrnXCnyjO5TMDTS2z9et1+yHV0nVRN3zGvP1r
         Ri/6skaGTKhZYzFDUsLhBFw1xtwwxXvJmOA1Kv6aLv2Hz51hEUi+yuEIwwg24lj0mjzW
         Y73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XEJHmIWbpcKkujM0HJLABQyJDhVg90XuG5Syf4NSf/Q=;
        b=hZJ8YwZ+yvfYECITbi7aTub1ZhdX8E1mo+NSk1TQqZLNYLEk8/3tnAk2mdj4Pzgc0+
         QuAZdlWjj8VjCF9znmoBn81teXqjShSQ2/Sqt5sTHNbE0cfWSUMpFva2KxQglpUSTGd+
         Xk2xl0cO8eH6/P5Stynxh8zWzaipQR1xiJN8fimE759G3oCK83piXAgzN3+0YCpUXOL8
         lWiBTrDzf4lRzGOjf2Ta6j6vSik6yVCtuo/bZkjVVuTpP5iXUfGzmzumtK5lJlQ7WvYt
         q2mKzrL38mOi023dpZxQx3Lorxe3zh+eodfMYxOdt2AfNstOb3S3l8vc5HITGZaeqNT3
         FZsg==
X-Gm-Message-State: APt69E2MIVU6sTk1VjKd3u6BLY+vTcdv7sQvOcsrTzZoFrb30h41F9O9
        wj4rh+l57ni1ZpL6jgAPZnk=
X-Google-Smtp-Source: ADUXVKLMtGhxFAjxdA2ITYv7RyeUZ3ny4FmtDI8jln8BMe+DovGM5m9/TtyuqNYCF1TvUiC3Tcn0Cw==
X-Received: by 2002:a37:1828:: with SMTP id j40-v6mr1747026qkh.11.1528383254843;
        Thu, 07 Jun 2018 07:54:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f8c8:bc46:d69b:91c2? ([2001:4898:8010:0:e1fe:bc46:d69b:91c2])
        by smtp.gmail.com with ESMTPSA id j190-v6sm8832474qkd.59.2018.06.07.07.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:54:14 -0700 (PDT)
Subject: Re: [PATCH 00/23] Multi-pack-index (MIDX)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, dstolee@microsoft.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <877enazmdd.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b81eedfe-e789-7ce3-cdd5-2754c8bbc40a@gmail.com>
Date:   Thu, 7 Jun 2018 10:54:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <877enazmdd.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 10:45 AM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jun 07 2018, Derrick Stolee wrote:
>
>> To test the performance in this situation, I created a
>> script that organizes the Linux repository in a similar
>> fashion. I split the commit history into 50 parts by
>> creating branches on every 10,000 commits of the first-
>> parent history. Then, `git rev-list --objects A ^B`
>> provides the list of objects reachable from A but not B,
>> so I could send that to `git pack-objects` to create
>> these "time-based" packfiles. With these 50 packfiles
>> (deleting the old one from my fresh clone, and deleting
>> all tags as they were no longer on-disk) I could then
>> test 'git rev-list --objects HEAD^{tree}' and see:
>>
>>          Before: 0.17s
>>          After:  0.13s
>>          % Diff: -23.5%
>>
>> By adding logic to count hits and misses to bsearch_pack,
>> I was able to see that the command above calls that
>> method 266,930 times with a hit rate of 33%. The MIDX
>> has the same number of calls with a 100% hit rate.
> Do you have the script you used for this? It would be very interesting
> as something we could stick in t/perf/ to test this use-case in the
> future.
>
> How does this & the numbers below compare to just a naïve
> --max-pack-size=<similar size> on linux.git?
>
> Is it possible for you to tar this test repo up and share it as a
> one-off? I've been polishing the core.validateAbbrev series I have, and
> it would be interesting to compare some of the (abbrev) numbers.

Here is what I used. You will want to adjust your constants for whatever 
repo you are using. This is for the Linux kernel which has a 
first-parent history of ~50,000 commits. It also leaves a bunch of extra 
files around, so it is nowhere near incorporating into the code.

#!/bin/bash

for i in `seq 1 50`
do
         ORDER=$((51 - $i))
         NUM_BACK=$((1000 * ($i - 1)))
         echo creating batch/$ORDER
         git branch -f batch/$ORDER HEAD~$NUM_BACK
         echo batch/$ORDER
         git rev-parse batch/$ORDER
done

lastbranch=""
for i in `seq 1 50`
do
         branch=batch/$i
         if [$lastbranch -eq ""]
         then
                 echo "$branch"
                 git rev-list --objects $branch | sed 's/ .*//' 
 >objects-$i.txt
         else
                 echo "$lastbranch"
                 echo "$branch"
                 git rev-list --objects $branch ^$lastbranch | sed 's/ 
.*//' >objects-$i.txt
         fi

         git pack-objects --no-reuse-delta 
.git/objects/pack/branch-split2 <objects-$i.txt
         lastbranch=$branch
done


for tag in `git tag --list`
do
         git tag -d $tag
done

rm -rf .git/objects/pack/pack-*
git midx write

