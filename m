Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9881F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeKNFOk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:14:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36899 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:14:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so21479160qkd.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mv5ENlxbWX1tfyAR6DK4upYzziLkySzk2ipM+GTAObE=;
        b=Xnj4ReMSHzch2V1GUP79m0IuzMWyrF2zBrdwlwww79AwR2weCh3s8aVdjioGe/X5zf
         /y/0qgj1ZtwfPWExruNcAulUIpifgfes+nWaFcWuhAOo8DOKttEnz17j+wKrJPvLHWC+
         I02jKlWBJ+HEHQL3xXKvkuZoxpM81LYYYeriCXZHlSi9Yd2nyoduzaxX0bz9V3Xtp1SW
         PPs9Jf1EkHOEEqZX6OEWljNvYygMM+y191fnF35mMROsrzx6YwvM4VLnGJlYkZyy+pd2
         LwRFiukGKjp7t2S4kHM65G0itZ7aLo5OwKEqwh7ozF65Eop8c0k2eYhGMsGGknxbYl2M
         WA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mv5ENlxbWX1tfyAR6DK4upYzziLkySzk2ipM+GTAObE=;
        b=YSMhEHMM2GCmTK1r5d0s4kscpCqfbR1xyZvEQYyCCTHATjFa9ekU6AQZ4sqF5R2Pv/
         ttrOu6J86g8gyguNo6fLwa7ConC9efCSeWol7E1nEK9anwjn4UdTpz1zXPSGdY10QIjq
         RfH9ST1KBpztQdbGpbYZm31OQjsgUjhyhh1Vba0aksGwOlCox2b0FJKQU28kd4W6fjJB
         TdTzWqSYpy9XbBIpTuzp1DOaRzP8m4A2mGN7r8E8aBnvdPgZ0cEXbiLIo4tZB41Q5cav
         L9PNTINxaHlX3LUAiVWYHBY+4rdw+Qt156s35454hcW5GwNP21q2ZiOWtcaTz13iN2jZ
         wuzg==
X-Gm-Message-State: AGRZ1gJrAuyIyFTy/BF23whjHQAQj6TpH065n11YyHEtTVCx2uy4gsVg
        aq8rwy/DTXDQV2BbUR0DktU=
X-Google-Smtp-Source: AJdET5d4tejctJ3Bki5yGm6DY25ck+nH+9QTLNM2JkUUPodlZzuDJleu5gHU7Hbk88voH3Vo3g2THg==
X-Received: by 2002:a37:744:: with SMTP id 65mr6133959qkh.260.1542136510487;
        Tue, 13 Nov 2018 11:15:10 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o42sm11690409qtc.90.2018.11.13.11.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:15:09 -0800 (PST)
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <20181113181855.GB68106@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1b890149-ee7f-c391-9abc-46d120e4324c@gmail.com>
Date:   Tue, 13 Nov 2018 14:15:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113181855.GB68106@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/13/2018 1:18 PM, Jonathan Nieder wrote:
> Hi,
> 
> Ben Peart wrote:
>> On 11/12/2018 7:39 PM, Jonathan Nieder wrote:
> 
>>> As with EOIE, popular versions of Git do not support the new IEOT
>>> extension yet.  When accessing a Git repository written by a more
>>> modern version of Git, they correctly ignore the unrecognized section,
>>> but in the process they loudly warn
>>>
>>> 	ignoring IEOT extension
>>>
>>> resulting in confusion for users.  Introduce the index extension more
>>> gently by not writing it yet in this first version with support for
>>> it.
> [...]
>>> Introduce a '[index] recordOffsetTable' configuration variable to
>>> control whether the new index extension is written.
>>
>> Why introduce a new setting to disable writing the IEOT extension instead of
>> just using the existing index.threads setting?  If index.threads=1 then the
>> IEOT extension isn't written which (I believe) will accomplish the same
>> goal.
> 
> Do you mean defaulting to index.threads=1?  I don't think that would
> be a good default, but if you have a different change in mind then I'd
> be happy to hear it.
> 
> Or do you mean that if the user has explicitly specified index.threads=true,
> then that should imply index.recordOffsetTable=true so users only have
> to set one setting to turn it on?  I can imagine that working well.
> 

Reading the index with multiple threads requires the EOIE and IEOT 
extensions to exist in the index.  If either extension doesn't exist, 
then the code falls back to the single threaded path.  That means you 
can't have both 1) no warning for old versions of git and 2) 
multi-threaded reading for new versions of git.

If you set index.threads=1, that will prevent the IEOT extension from 
being written and there will be no "ignoring IEOT extension" warning in 
older versions of git.

With this patch 'as is' you would have to set both index.threads=true 
and index.recordOffsetTable=true to get multi-threaded index reads.  If 
either is set to false, it will silently drop back to single threaded reads.

> Thanks,
> Jonathan
> 
