Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB701F42D
	for <e@80x24.org>; Wed, 16 May 2018 13:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEPNCR (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 09:02:17 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42898 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEPNCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 09:02:16 -0400
Received: by mail-qk0-f193.google.com with SMTP id b22-v6so520844qkj.9
        for <git@vger.kernel.org>; Wed, 16 May 2018 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RfituSRT2YofoeB5ZJepEEqa2qSFcbi98zpcfi74B4A=;
        b=O/9WDzK3BHMEwS1pE9k8ZYAm2DA+4RNe5N8M6Ikw0sB4llhHZuCgrk9Eygjv1t+iW3
         a4RYVSLbUfApi1iMvnZ+eFmmXoJjPI9CQDcj0RPW5Q9lRuaC06L5vVdzA3oTs03pBUT3
         sBbpGik1aU83rMPxNx2Ncv5HMoM/bP7l3SO3k4ElZwsr2SN2RXFLuhaRI/ava6yhPcCW
         WyprBhz2VJQ7PaGdsv5Kn18MWtihLAW6qZRdC3CC5enonoUg3Ic9854fqQ9g2yv8m3Lf
         4oHVhvxvMLUd5iGvPOSQtpsMkpus/p/j49DjVnFY0OMRmPQzWBlz8KcwSzSB+0g6Umgp
         RGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RfituSRT2YofoeB5ZJepEEqa2qSFcbi98zpcfi74B4A=;
        b=Povl3toR81aAL27LEAxf+g7Vp/+HgGJvo1l/mz873+w5Sr/R8RUZi50JVVz0pcB6TA
         gLeBLga/Bpj9w04SX2AvoVNWWk1VFCgQKt9abzowSmJb6JjCLgc7FySI74UPSByRjFU9
         FhyIz9fIFemqON3bQsEVePXQZG4+WHjZHMCWQcF3+Pcwu6g7nQjudp2qKdOIy8B6E58+
         g4D/2OYRBqyovk7Yejd/vcf1uKOiN6eww4uHe8U2YzU5DuzVD7Y6i5uRDNHMnDA9Tw+c
         XWk1aHamQRk9Ul74RSGoUKgJL0JRflsneTHmdzd6/GrASkK18CNyzY2jsBlZ8IMHCWMX
         LUqA==
X-Gm-Message-State: ALKqPwfAMfy+aacFYw91NhtjrT101nty2KgIQPB3J3fDjv5hM6qS4vKY
        wVlZ5mun+1fvZTgUMUMByRc=
X-Google-Smtp-Source: AB8JxZrAOOpVROEJVg1e2zfa4aQ5gPLs2hqL5SvLusVfdOHZ4h7CO4EYbke26ZttLiMiG1xX1LEjhg==
X-Received: by 2002:a37:9907:: with SMTP id b7-v6mr646853qke.307.1526475735780;
        Wed, 16 May 2018 06:02:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9417:e20c:6f90:3ee4? ([2001:4898:8010:0:7d4d:e20c:6f90:3ee4])
        by smtp.gmail.com with ESMTPSA id q33-v6sm2064867qkq.72.2018.05.16.06.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 06:02:14 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
Date:   Wed, 16 May 2018 09:02:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87muwzc2kv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2018 6:33 AM, Ævar Arnfjörð Bjarmason wrote:
[big snip]
>
> And here's where this isn't at all like "worktree", each of those 100
> will have their own "master" branch, and they can all create 100
> different branches called "topic" that can be different.

This is the biggest difference. You cannot have the same ref checked out 
in multiple worktrees, as they both may edit that ref. The alternates 
allow you to share data in a "read only" fashion. If you have one repo 
that is the "base" repo that manages that objects dir, then that is 
probably a good way to reduce the duplication. I'm not familiar with 
what happens when a "child" repo does 'git gc' or 'git repack', will it 
delete the local objects that is sees exist in the alternate?

GVFS uses alternates in this same way: we create a drive-wide "shared 
object cache" that GVFS manages. We put our prefetch packs filled with 
commits and trees in there, and any loose objects that are downloaded 
via the object virtualization are placed as loose objects in the 
alternate. We also store the multi-pack-index and commit-graph in that 
alternate. This means that the only objects in each src dir are those 
created by the developer doing their normal work.

Thanks,
-Stolee

