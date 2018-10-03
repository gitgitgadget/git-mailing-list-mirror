Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CF11F453
	for <e@80x24.org>; Wed,  3 Oct 2018 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJDBtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:49:16 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45901 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDBtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:49:16 -0400
Received: by mail-qt1-f169.google.com with SMTP id l2-v6so7117973qtr.12
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I4xtouFYZTizHSOlaVBcu4ASYjrU0U8ooSq26rT7DMY=;
        b=WKn/UXTVq959W6nHO66HC5gGOVCVhy2+nGyggujhuLL6Cshm9oJlICJQnat8VHKBzE
         qZzGHysqoZwUfp/e6CU8kOyNOFEifCi7L2ddZ30mxdeNHCR9DEFoUG7vrqg6iEjUhy9S
         Un9uj6QodzTGGMTVkPFuV763AvYUDvmzJRmnEhPJvcbna9QO9iuD86zChAxqE8MRyjej
         hvhXI+HUPmowcgVpAqr2PQen3OeBXScPyTWq0JahZP9EWhXCt1amqH/KPmJnbSgMohV0
         XZWA3G4K9J2Pc6CvoyUL7hoYmAD4FxlLtFaRZEcWvRJTG7xbTrauAQ55fE2Y894z66lO
         fQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I4xtouFYZTizHSOlaVBcu4ASYjrU0U8ooSq26rT7DMY=;
        b=X2Hbj/+ZwUy0aFcNMvz29+zeVcS6k7Rq6BFQYWGdg0EBhKmnYz3PXHurYSDArCfHxd
         /XkBJkTM+wNs64fcpvTMqWCDy3eyoZ/a+q+4J1O2JcPY7NVQerq7uyykiQLE8v5Wd7CI
         QdKI3KSWRkuhMzDR5J9bbYc6yOcLD1/riMGkFHHHIKuaZvf7uR8W4VKu5iSEDBKOzgTG
         jxzUFAeMtSjXUge8dyavr9DZVTtKagOIf16LmRHvy0rlnBXiV1x+0/hcF3zNQkeRVLUm
         2HAO3DghoCEbnlwhpCCB0wSaipZMm/K8uUodGEU+9PG8oAiHg8fXMyd72uf5TXHRIh2J
         1ocA==
X-Gm-Message-State: ABuFfoglnnGu9Zzv/XIipjVQku4Pxq2Ysc0I6l5DfPgzR/XZ8Aac1Rvt
        yUCWbFt0/r9neGSI9Ys77aw=
X-Google-Smtp-Source: ACcGV60nbj3Z2gvzl6jPJ+5JwYFfU5NsMh8qBgDA00T9uJCp9uY0XlvOFyd6e7aKR32zmsi9fWJasA==
X-Received: by 2002:a0c:9545:: with SMTP id m5-v6mr2427462qvm.138.1538593176238;
        Wed, 03 Oct 2018 11:59:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:93a:8fdb:fc24:18a1? ([2001:4898:8010:0:f26f:8fdb:fc24:18a1])
        by smtp.gmail.com with ESMTPSA id s13-v6sm1220601qtc.95.2018.10.03.11.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:59:35 -0700 (PDT)
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost> <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost> <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
Date:   Wed, 3 Oct 2018 14:59:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003185156.GA20709@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2018 2:51 PM, Jeff King wrote:
> On Wed, Oct 03, 2018 at 08:47:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> On Wed, Oct 03 2018, Stefan Beller wrote:
>>
>>>> So we wouldn't be spending 5 minutes repacking linux.git right after
>>>> cloning it, just ~10s generating the commit graph, and the same would
>>>> happen if you rm'd .git/objects/info/commit-graph and ran "git commit",
>>>> which would kick of "gc --auto" in the background and do the same thing.
>>> Or generating local bitmaps or pack idx files as well?
>> I'm less familiar with this area, but when I clone I get a pack *.idx
>> file, why does it need to be regenerated?
>>
>> But yeah, in principle this would be a sensible addition, but I'm not
>> aware of cases where clients get significant benefits from bitmaps (see
>> https://githubengineering.com/counting-objects/), and I don't turn it on
>> for clients, but maybe I've missed something.
> They don't help yet, and there's no good reason to enable bitmaps for
> clients. I have a few patches that use bitmaps for things like
> ahead/behind and --contains checks, but the utility of those may be
> lessened quite a bit by Stolee's commit-graph work.  And if it isn't,
> I'm mildly in favor of replacing the existing .bitmap format with
> something better integrated with commit-graphs (which would give us an
> opportunity to clean up some of the rough edges).

If the commit-graph doesn't improve enough on those applications, then 
we could consider adding a commit-to-commit reachability bitmap inside 
the commit-graph. ;)

-Stolee
