Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321361F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeGLPuo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:50:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40700 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeGLPun (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:50:43 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so6902174qkd.7
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PdU560njYH1hlQkOkpD9/Pj3Ur8NMoTJZNPEyhPZFk8=;
        b=tzi8OTT48tm0mz7iMHCNKg13HCLm48qPNR5NcYKrBSpy2iAgByHApaXTc6+bpzL6k8
         VsGI1zRPLfcBNUept1WiiWtYbQVrgdyZSzyDqLL97XmtdfeNm1IWMsbjvAOWxaf0xesz
         RpqfS78XFHCzfw5VpCp06HEd4uY8ienT5rjJhuBdNc7dXZxtk56UFSWSC/ANbiRODIHa
         YStc0XZbK+WU5WzXykumALSaApE0KtwMTCXZgf73yX6c8gxWR7yfDYBBsQ1gOb7qNCFR
         djG7/tLEaoVMsjofCgF+wr8obsRcCeLHXpTpLieWit6GEHlTRcvNsLG0lxofEn18YIJw
         9arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PdU560njYH1hlQkOkpD9/Pj3Ur8NMoTJZNPEyhPZFk8=;
        b=cePcl/u8u8K3TjtAPEYNHt3l+jCcYxx/zmSJbQs5k+XjVPahwOvCENdKDyotKVM1Gc
         NyizhhU9RNsUaBxN/VWvklzSg2IPMQzaINA7y6T2iAuxkug2QKQqJEn0INQw3H88ezy8
         wNkQ/18BJ0dU27Dp2ffnAyqrBEfRa3NierTWN3jLF0CYzIQMCE9C73n7lF3gtnDlcm1S
         8UT/DJfmuOoMA8s+cDhy+Gd75RL0FgFJc8TmkeSGhk8IMDwFSVY4pivZWjf84+DuFtNo
         UhoSwZpX3sVWrvk3csHa4LfeJk2Xf3eveotSvaRRVKeT5Obl0ZOjJNdocD7nGC++ylTO
         pVGg==
X-Gm-Message-State: AOUpUlFoAdC+A3IoTa8tMH3r8lGZoVZUn6PHZt6nIuZ7uWg8MRKHAsRA
        eXEz3dB6EwiyNtDFr73YW+X1qDi0vpo=
X-Google-Smtp-Source: AAOMgpfsQTSPVBi4pzznT9DvfUjJeAGMPNMrx5ihT7WQ13KlwNFtko0p4HcC74Q3O2X3E3LYlu9Vxw==
X-Received: by 2002:a37:c597:: with SMTP id k23-v6mr2194456qkl.324.1531410038058;
        Thu, 12 Jul 2018 08:40:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7999:2a5f:44db:50fd? ([2001:4898:8010:0:62cf:2a5f:44db:50fd])
        by smtp.gmail.com with ESMTPSA id k67-v6sm15024830qte.95.2018.07.12.08.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 08:40:37 -0700 (PDT)
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com>
 <20180711094858.3230-1-szeder.dev@gmail.com>
 <dd2f774d-a217-0273-efbe-d133ae23c5bc@gmail.com>
 <CAM0VKjkuC5Qc6HtQZP4dpHE4CcCvNkg1D8_AFw7+PQDU6bU5Wg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <540316c3-b74e-f187-797a-2b2d0b14c025@gmail.com>
Date:   Thu, 12 Jul 2018 11:40:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkuC5Qc6HtQZP4dpHE4CcCvNkg1D8_AFw7+PQDU6bU5Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2018 9:31 AM, SZEDER Gábor wrote:
> On Thu, Jul 12, 2018 at 3:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 7/11/2018 5:48 AM, SZEDER Gábor wrote:
>>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>>> index ab641bf5a9..ab895ebb32 100644
>>>> --- a/Documentation/config.txt
>>>> +++ b/Documentation/config.txt
>>>> @@ -908,6 +908,10 @@ core.commitGraph::
>>>>       Enable git commit graph feature. Allows reading from the
>>>>       commit-graph file.
>>>>
>>>> +core.multiPackIndex::
>>>> +    Use the multi-pack-index file to track multiple packfiles using a
>>>> +    single index. See linkgit:technical/multi-pack-index[1].
>>> The 'linkgit' macro should be used to create links to other man pages,
>>> but 'technical/multi-pack-index' is not a man page and this causes
>>> 'make check-docs' to complain:
>>>
>>>         LINT lint-docs
>>>     ./config.txt:929: nongit link: technical/multi-pack-index[1]
>>>     Makefile:456: recipe for target 'lint-docs' failed
>>>     make[1]: *** [lint-docs] Error 1
>>>
>> Thanks for this point. It seems to work using
>> "link:technical/multi-pack-index[1]", which is what I'll use in the next
>> version.
> It doesn't work, it merely works around the build failure.
>
> The generated man page looks like this:
>
>    core.multiPackIndex
>        Use the multi-pack-index file to track multiple packfiles using a
>        single index. See 1[1].
>
> And the resulting html page looks similar:
>
>    core.multiPackIndex
>
>        Use the multi-pack-index file to track multiple packfiles using a
>        single index. See 1.
>
> where that "1" is a link pointing to the non-existing URL
> file:///home/me/src/git/Documentation/technical/multi-pack-index

Right. Sorry. I also see that I use the correct kind of links in 
Documentation/git-multi-pack-index.txt (see below) so I will use it 
here, too.

SEE ALSO
--------
See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
Document] and link:technical/pack-format.html[The Multi-Pack-Index
Format] for more information on the multi-pack-index feature.

Thanks,

-Stolee

