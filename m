Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1071F424
	for <e@80x24.org>; Wed,  9 May 2018 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965829AbeEIREd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:04:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44495 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965673AbeEIREb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:04:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so46525809qtp.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZrTjdCqqMqOQ75Kt1z6z6TWQiaJ04RpFyTcKv5f0iI=;
        b=VVpn0MkYZqJIX6PSIdGDSgJFIfWvrIizi3LGTaGWCWonyEOSdVMleLLgwsVPslO+WZ
         j7PvzoP9E6AHdyaWOHc7T8+uoYl5iGggaVEheOUQuDcupwRPDUkgPbqkhxg1VzAkF3o5
         Tnc3J3luvHn9Ae1X5+mqqKFwoiav58vKTDAqcSRuLW+zebaIvQsYeTM6JsbpO2Ph8Ed9
         8gg52kJgIfKNdxH/GpYzr8rYIhQ0WNmBUI/lZxjzt3tGmjjma8uM+X/p6uKwAZddrPwF
         fokU8pdKvR6L6wCqIu0rSve/BLTUZndIOt1Ed0l2tLj4JS/wBoQLFWb4b5xjxrY+JTcB
         81RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZrTjdCqqMqOQ75Kt1z6z6TWQiaJ04RpFyTcKv5f0iI=;
        b=dSguLJkTUg3WFHTzP+4lgVm4KRF7BrJUrEgRFLp1URbLTMXHzcG+iiX03csgwJBzvX
         KXL4H9FS/rKNnMypTGubIV3afIWmi/Rh3vo6nBohBtQodvja0XzP/i5hVsLLAlj3G3tL
         +94L0yA06CSUojmE4MG3QALyvaM4LfPUadmkwgg3gWS8aos0Vhl3OVA8UKGZDwbxUXt9
         LsZam0a4V7zTJkh/yvmR32QH44zrbZg0i1FSzw6bmCREA4iC41SLH6Pka88y4ki+l+qr
         rjNqc+PQYqf5OHFcMbqpxvlzww+Yych1Ie6XAA9kkZy3QNVLGH0M0Q1qR4RC8XVc+Lw0
         txtg==
X-Gm-Message-State: ALQs6tD4j5elnX0QXtRWVQW38l7xorJ8C5fkV2b+QOb70naAKu+aePwD
        UKArvLv+VkHefbYdqUvkUOKVWL+y
X-Google-Smtp-Source: AB8JxZoWR6sFP3ptcYZGW+IyyFGodamQFCd2PmSlZCiJpSfX7lNkp75RtcbM/Sc3z8H3D9sBeqrOBA==
X-Received: by 2002:ac8:710b:: with SMTP id z11-v6mr44054506qto.112.1525885470342;
        Wed, 09 May 2018 10:04:30 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b3sm10973070qkd.5.2018.05.09.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 10:04:29 -0700 (PDT)
Subject: Re: [PATCH v1] add status config and command line options for rename
 detection
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <CACsJy8CdvKO3aityyP3Ax0ZqaS6JzwH_i2Gn_8NmCUDKHMMQrw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <80ddf6cf-0a38-9cd0-18b1-83114c2d1f5d@gmail.com>
Date:   Wed, 9 May 2018 13:04:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CdvKO3aityyP3Ax0ZqaS6JzwH_i2Gn_8NmCUDKHMMQrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/9/2018 11:59 AM, Duy Nguyen wrote:
> On Wed, May 9, 2018 at 4:42 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> Add a new config status.renames setting to enable turning off rename detection
>> during status.  This setting will default to the value of diff.renames.
> 
> Please add the reason you need this config key in the commit message.
> My guess (probably correct) is on super large repo (how large?),
> rename detection is just too slow (how long?) that it practically
> makes git-status unusable.
> 

Yes, the reasons for this change are the same as for the patch that 
added these same flags for merge and have to do with the poor 
performance of rename detection with large repos.  I'll update the 
commit message to be more descriptive (see below) and correct some 
spelling errors.


add status config and command line options for rename detection

After performing a merge that has conflicts, git status will by default 
attempt to detect renames which causes many objects to be examined.  In 
a virtualized repo, those objects do not exist locally so the rename 
logic triggers them to be fetched from the server. This results in the 
status call taking hours to complete on very large repos.  Even in a 
small repo (the GVFS repo) turning off break and rename detection has a 
significant impact:

git status --no-renames:
31 secs., 105 loose object downloads

git status --no-breaks
7 secs., 17 loose object downloads

git status --no-breaks --no-renames
1 sec., 1 loose object download

Add a new config status.renames setting to enable turning off rename 
detection during status.  This setting will default to the value of 
diff.renames.

Add a new config status.renamelimit setting to to enable bounding the 
time spent finding out inexact renames during status.  This setting will 
default to the value of diff.renamelimit.

Add status --no-renames command line option that enables overriding the 
config setting from the command line. Add --find-renames[=<n>] to enable 
detecting renames and optionally setting the similarity index from the 
command line.

Note: I removed the --no-breaks command line option from the original 
patch as it will no longer be needed once the default has been changed 
[1] to turn it off.

[1] 
https://public-inbox.org/git/20180430093421.27551-2-eckhard.s.maass@gmail.com/

Original-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>


> This information could be helpful when we optimize rename detection to
> be more efficient.
> 
>>
>> Add a new config status.renamelimit setting to to enable bounding the time spent
>> finding out inexact renames during status.  This setting will default to the
>> value of diff.renamelimit.
>>
>> Add status --no-renames command line option that enables overriding the config
>> setting from the command line. Add --find-renames[=<n>] to enable detecting
>> renames and optionaly setting the similarity index from the command line.
>>
>> Origional-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
