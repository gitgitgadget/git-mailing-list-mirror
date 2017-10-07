Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2C92036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdJGTMN (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:12:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47556 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdJGTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:12:12 -0400
Received: by mail-qt0-f196.google.com with SMTP id z50so31904277qtj.4
        for <git@vger.kernel.org>; Sat, 07 Oct 2017 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aqanDFwxnpGv7bH+8sL9d2QkN+9tyT3G/NT95hvzJ64=;
        b=YqQNRYx5mOOikv213nFOIqe3NbrGokLCtAx/U2gbZqZnDGQJhYrF+22Tc++9zNBMla
         V0qFec21U27UpLR+ui3Rrs0DRyzC6rifEUABldYgOgyF9dviGMPDN/1lz7hYROnKRZ7a
         aSorglfyzj2gKvEL60RfIH5bQSv8317Rs9s6ZDtpX7btoc8HAjDYEhXSKHlR8XdHcy7L
         oFUq3qe6/xam8oRUDst/XP2iwVh55uh+GBtzd88BgEh2dgLvqGtXgEhCZFrdwGhd4EWM
         fOfg3YQBsuD7GiPUdjszRgmzqyPmrsv1RSGoeJrYNHCnbizEv8eoysiWSpJvGLN/5BJe
         41nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqanDFwxnpGv7bH+8sL9d2QkN+9tyT3G/NT95hvzJ64=;
        b=BzEYHLrmS1dwtz6CDKjh32cKDvZaYOE10HmivX2xCiuPRDHkPxHgDMp1YqoCyiiyc5
         Kq17Y4vbKsOmQrqhnrMqLFdbwo8nqz4PiS0LrCec9ACgTAZN/4uJQ/yLKXOCZPbvacMR
         duFvjEqM7CacpUi7o1UDo0tHbpXJU/bLST/m3/dUl0mq4VDKbS/8FF6qNXGQCZUqD+Tb
         YH3teHoolcELVPO/BwvLJI2Kn6LLBmae4qN857GsIgS30ykBKLoiK7qU13dJQwNM1HhU
         c7gmnXmPGb4g3Vo9NA+QHisq3ZLJx5ahdB1oXxNjsTlo2D216vSWbh4MDsWXxybdjSfQ
         50Ew==
X-Gm-Message-State: AMCzsaUOiyq4CO1Um7pRFHifcrkdIqjwuXFUIM74QxljzswJTcckdZla
        XbwfOu2h6aB48tqZ/ShmxipUskLk
X-Google-Smtp-Source: AOwi7QBjVQoODw9bEoR2U8kxIMktFsl/PYvp03NtcyCV/p/ZoM6S8IEMi/bgQSd38eTWq09JMpzuFA==
X-Received: by 10.237.36.209 with SMTP id u17mr7897520qtc.14.1507403531683;
        Sat, 07 Oct 2017 12:12:11 -0700 (PDT)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b202sm2600475qkc.65.2017.10.07.12.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Oct 2017 12:12:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
 <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
 <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
 <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
 <20171006141128.rkuhd4m7hp2f7vvx@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5b3107f-76ec-8e8c-d7f5-d0f1ec75b1c9@gmail.com>
Date:   Sat, 7 Oct 2017 15:12:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <20171006141128.rkuhd4m7hp2f7vvx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2017 10:11 AM, Jeff King wrote:
> On Thu, Oct 05, 2017 at 08:39:42AM -0400, Derrick Stolee wrote:
>> I'll run some perf numbers for these commands you recommend, and also see if
>> I can replicate some of the pain points that triggered this change using the
>> Linux repo.
> 
> Thanks!
> 
> -Peff
> 

In my local copy, I added a test to p4211-line-log.sh that runs "git log 
--raw -r" and tested it on three copies of the Linux repo. In order, 
they have 1 packfile (0 loose), 24 packfiles (0 loose), and 23 packfiles 
(~324,000 loose).

4211.6: git log --raw -r  43.34(42.62+0.65)   40.47(40.16+0.27)  -6.6%
4211.6: git log --raw -r  88.77(86.54+2.12)   82.44(81.87+0.52)  -7.1%
4211.6: git log --raw -r 108.86(103.97+4.81) 103.92(100.63+3.19) -4.5%

We have moderate performance gains for this command, despite the command 
doing many more things than just checking abbreviations.

I plan to re-roll my patch on Monday including the following feedback items:

* Remove test-list-objects and test-abbrev in favor of a new "git log"
   performance test.

* Fix binary search overflow error.

* Check response from open_pack_index(p) in find_abbrev_len_for_pack().
   I plan to return without failure on non-zero result, which results in
   no failure on a bad pack and the abbreviation length will be the
   minimum required among all valid packs. (Thanks Stefan!)

I made note of a few things, but will not include them in my re-roll. 
I'll revisit them later if they are valuable:

- nth_packed_object_sha1() could be simplified in
   find_abbrev_len_for_pack().

- Teach 'cat-file' to --batch-check='%(objectsize:short)'. (Peff already
   included a patch, perhaps that could be reviewed separately.)

- Ramsay caught my lack of "static" in test-list-objects.c, but that
   file will be removed in the next patch. I'll make sure to use "static"
   in the future.

I'm not re-rolling immediately to allow for some extra review over the 
weekend, if anyone is so inclined.

Thanks,
-Stolee
