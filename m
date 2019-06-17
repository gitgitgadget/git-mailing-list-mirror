Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C561F462
	for <e@80x24.org>; Mon, 17 Jun 2019 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfFQJPT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 05:15:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 05:15:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so9051903wrl.11
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u4696rjjTeFZHBWO9W/qXyyzylUaoZZSaoK7z+BFD0c=;
        b=o7dOaLLVvZUb60/v9Y7VSMvikc17DUTHdqjftzsNaFnm6ILDILXyy1cwd85GgiBe1f
         5sV76P3M/n7QBjIdGKXf2DKeHOOSdjIjth0LqAlVWQ3rtQ8kg9pHMKkmClVpE2kvwscP
         Nn/Knr44kgrhoInDMEQYq4FGDOHH1X7+wCE/z7ewX+UzL0xqClleE3EzPFEZZNoq3riN
         mdBMwuZbH8hmiFeTyweiNUjZ+h9xTCbkZwZKINCPYzhnvmfev7JQv4jkfxOSogw4WMPv
         f4qtVo6zGr8wfKR2A/R99jbbLrb1YvAiXCTrHlGAAsov7zZN8/T86E/ojql2f54GvJmN
         D1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4696rjjTeFZHBWO9W/qXyyzylUaoZZSaoK7z+BFD0c=;
        b=Ey+xb7t9xuWcbCm2tFHOzG4z7TJbArHXMl/oK8yze8SRnBOC9jmw/kPaPg5Spb6gMG
         gqRABoJOAj/f9QgqkcShZrFad/6HDvc8fnaApDAcfGjwqaYp7cpTKHrt6zrwGw+oZhYF
         4Cvcu5iF9VzIpM2gKzfilRmcTXFogJOT81eD4RhcpsbdJF0SDyD/8s2nKv/a+MehAQur
         igzocVFLJcSkPP0P0vJIISsv9NvLGZIctIrcEnArf0YNLLU4l/etGMgCwl2pQT2oIxIv
         KJ1EDbJ+dYFgoM8htbdKwZOeWAER9wnF2x9vlGCzzFTcVK8IYnSXhoROQK9VuJXyNMSh
         ytRA==
X-Gm-Message-State: APjAAAWfzyFE8gTOWf4eKiM7to1Vs1FNMIbZVo68kUGUqJ2F6P7n2h2U
        FIyXjZuKcEL0l+eo7lnkTQlolLEz
X-Google-Smtp-Source: APXvYqzX3X76kIM/Unq2RGeSlb2Jhe3LKXOFphjZ0V7gNDyJ97TDqEHqIhWP3EPXxfZc3ZU2C2rPKg==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr1621839wrm.24.1560762917148;
        Mon, 17 Jun 2019 02:15:17 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id p3sm12453553wrd.47.2019.06.17.02.15.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:15:16 -0700 (PDT)
Subject: Re: [PATCH] show --continue/skip etc. consistently in synopsis
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
 <xmqq36k9tb30.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <991b0908-4ec5-2d19-4df3-df3eb28632c2@gmail.com>
Date:   Mon, 17 Jun 2019 10:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq36k9tb30.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/2019 23:33, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The synopsis for am shows the command mode options as
>>     (--continue | --skip | --abort | --quit)
>> They are on a single line and in parenthesis as they are not
>> optional. Fix the merge and rebase docs to match this style.
> 
> Is it so clear-cut that it is more "correct" to have everything on a
> single line, as opposed to describing each one per line?  I am not
> sure.

I'm not sure I'd argue too hard one way or the other, but I do think the
documentation for the various commands should try to be consistent and
the am, cherry-pick, rebase and revert man pages all use a single line
for these options (although rebase is missing the parentheses).

I'll re-roll with Elijah's correction and a sign off

Best Wishes

Phillip

> 
> I would say both the above style and the style used by "git merge"
> documentation are correct.  The "rebase" one is a different story
> and the change in this patch deserves to be called a "fix".
> 
> As long as the more concise "am" style is already prevalent (are
> there pages other than "am" you can cite?), I would agree with you
> that the change to "git merge" in this patch is a good idea for
> consistency's sake.
> 
>> ---
>> This patch is based on top of nd/merge-quit.
> 
> Thanks for indicating where it should go.  We need your sign-off,
> too.>
> 
> 
>> The docs for cherry-pick/revert are updated to this style by
>> https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u
>>
>> Documentation/git-merge.txt  | 3 +--
>>  Documentation/git-rebase.txt | 2 +-
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index b7d581fc76..07ca9fb78c 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -13,8 +13,7 @@ SYNOPSIS
>>  	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>>  	[--[no-]allow-unrelated-histories]
>>  	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
>> -'git merge' --abort
>> -'git merge' --continue
>> +'git merge' (--continue | --skip | --abort | --quit)
>>  
>>  DESCRIPTION
>>  -----------
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 5629ba4c5d..a67d40596a 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  	[<upstream> [<branch>]]
>>  'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
>>  	--root [<branch>]
>> -'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
>> +'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
>>  
>>  DESCRIPTION
>>  -----------

