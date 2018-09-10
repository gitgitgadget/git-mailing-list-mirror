Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA6D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeIKAe3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:34:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40766 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeIKAe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:34:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so25623928qtj.7
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=msyV2GDO4hxAW4zG1v8Zwks/j8rE0pF7fPL83KZb70E=;
        b=lyEKEYf0WFvJhQX1fPElsg2i+V51+mb34qkuoPhqhNuBdbFRPfTTmA/860GvjywoTb
         kfeSgRwbdJDDzXemZPxtr8v30bqUrQHlgTUTCyo37ZJ7P+D8ZAb6mLEGCzSX5ZAP+tB7
         OuFF7eU7dkYtgasz2JEWrCh85HGDlK72xwWhL4FyVCbv465grP4Ec92vZeZrUuyefqOd
         SGW/FIAKs+rKhqIyM5pB4Ent1K/0Y3pgX0mEleBv2H6cm2fTB1NCxpR13GIlddUQQJuf
         2DBhL8+Q32thHMMZvV5alrxlwSLJJDx2KxRRKrSWu1Kgzb0Vqd1DoP7shNbyLwvQu/rx
         vrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msyV2GDO4hxAW4zG1v8Zwks/j8rE0pF7fPL83KZb70E=;
        b=FInYr5v6Y8vBk6BxmxY73WeKN71x12wyCqV6W8VNU/Hf46LxQmlF/+vmfRszHoSeXJ
         sH5wI1rc/AEsPgRWaifebEYRswyRLCxeZo5vwHkPAeN4hT55A/PYzpR96zzlCBzVWo6n
         6nLvwns9OM/QxujG3lYd4oFbg/fQxeJtBBQZduA77pYouayg//n6W92qWfRwerDJcjwf
         LRCssPO+sOxs6kW4aEllwSMijjaHWmSPAin4KWw7BJIfxWftHo9Ct69zD4fyYf7HM/XH
         4gq7XpbqojlCgTL605DQxcZWkWmt1zC/X7/bvfMxnAogl3JjCWYv8SjQHCeIk/0FLS4L
         oBjg==
X-Gm-Message-State: APzg51ATnk2S6h+WAwVlFwZoYXqI8C3n7knVdHQOf4Y5RNw4dK7JRbde
        8zQ8sqeeL08eKo44eGh0qV0=
X-Google-Smtp-Source: ANB0VdYjeZZkpLiiniO8q0VuPyC34AeFGuzrr9xN3oqi4duHAHDdYZ7yXwO5dECXZVKN7VQ7lSGm2w==
X-Received: by 2002:a0c:8738:: with SMTP id 53-v6mr16268992qvh.47.1536608330905;
        Mon, 10 Sep 2018 12:38:50 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d11-v6sm9674144qkg.14.2018.09.10.12.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:38:50 -0700 (PDT)
Subject: Re: [PATCH v1] git-mv: allow submodules and fsmonitor to work
 together
To:     Stefan Beller <sbeller@google.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <85d96d65-2e74-7877-80ab-f74fdb81d500@gmail.com>
 <20180910162911.31920-1-benpeart@microsoft.com>
 <CAGZ79kZmmULJHrPJS1=areXAP-nSK0_9UOUOry2Hd6aHSBrAiQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6f8a4921-3b4e-e381-14da-60f0695446cd@gmail.com>
Date:   Mon, 10 Sep 2018 15:38:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZmmULJHrPJS1=areXAP-nSK0_9UOUOry2Hd6aHSBrAiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2018 1:07 PM, Stefan Beller wrote:
> On Mon, Sep 10, 2018 at 9:29 AM Ben Peart <benpeart@microsoft.com> wrote:
>>
>> It was reported that
>>
>>     GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t7411-submodule-config.sh
>>
>> breaks as the fsmonitor data is out of sync with the state of the .gitmodules
>> file. Update is_staging_gitmodules_ok() so that it no longer tells
>> ie_match_stat() to ignore refreshing the fsmonitor data.
> 
> Wondering how this came to be,
> 7da9aba4178 (submodule: used correct index in is_staging_gitmodules_ok,
> 2017-12-12) last touched this line, but is unrelated as the fsmonitor
> behavior was
> there before.
> 
> Before that, we have 883e248b8a0 (fsmonitor: teach git to optionally utilize a
> file system monitor to speed up detecting new or changed files., 2017-09-22)
> that was written by you, who knows the fsmonitor better than I do (or Brandon
> who wrote the commit referenced above).
> 
> Looking through the archive, it seems that we might have more such hidden
> gems?

Fortunately, the only one left is the one in preload_index() which is 
what the flag was created to handle so I think we're ok.

> 
> https://public-inbox.org/git/f50825a4-fa15-9f28-a079-853e78ee8e2e@gmail.com/
> 
> Anyway, I think this is a better fix than what I proposed for sure.
> 
> Thanks for looking into this!
> 
> Stefan
> 
>>
>> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Helped-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>
>> Notes:
>>      Base Ref: v2.19.0-rc2
>>      Web-Diff: https://github.com/benpeart/git/commit/ed30e1a885
>>      Checkout: git fetch https://github.com/benpeart/git fsmonitor-t7411-v1 && git checkout ed30e1a885
>>
>>   submodule.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 50cbf5f13e..1e7194af28 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -65,8 +65,7 @@ int is_staging_gitmodules_ok(struct index_state *istate)
>>          if ((pos >= 0) && (pos < istate->cache_nr)) {
>>                  struct stat st;
>>                  if (lstat(GITMODULES_FILE, &st) == 0 &&
>> -                   ie_match_stat(istate, istate->cache[pos], &st,
>> -                                 CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
>> +                   ie_match_stat(istate, istate->cache[pos], &st, 0) & DATA_CHANGED)
>>                          return 0;
>>          }
>>
>>
>> base-commit: c05048d43925ab8edcb36663752c2b4541911231
>> --
>> 2.18.0.windows.1
>>
