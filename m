Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E7C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 02:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiBDCn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 21:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiBDCn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 21:43:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FCC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 18:43:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d1so3931945plh.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 18:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=LYjw8iq2gol9BAOqkuzO2VZwGR3OGrg/P7ccIWre77Y=;
        b=m4LtGZaFlHnM1X61YWwZ/kieiOG7QUaQkzrh3dlnmkwFEjCsARFfhnz3Fkh93HBQ/h
         fxJ89UaN7Hd399gJI8nsCpWqUN1/keqt58OIgsK/yqNFQBfewTqmrEotfs/nQsQNPQQr
         Td4bEZyqj3b0wmApfMBtY3joVqzepCs3fVO2fJQATPbwpAP0V1OZ4c1P2kNf50RRKxVg
         sinc6CI5Vztnmo+vuOYmsNa2aBr1k1pj6i6/P+GXb01o8wMGRBnT/aA8OngpjGI3KvFE
         qTn3MjN+XgEq9GSCUoZn5vK6EI7k9NyPKHCeHF9BpPPg6oh/VJl/nh6TNymG1ArDvU9Z
         TSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LYjw8iq2gol9BAOqkuzO2VZwGR3OGrg/P7ccIWre77Y=;
        b=w+aULAsYvuuBEaiyIJiaw5FIXFGZCVmwkJ+6iLoItBunNN0fIYeSdmm5NrqKxSBKXo
         MuePMfkgceTrkFH4t88DnQF2USGsMCCAbL3HZDtkzOb6t9/g7BT5xMloPOPFweZy3POo
         c3auIcRPtJ7cxaLkDN8zHAWJ2smtxjwhUGK8sWmTwQO4p1IbxES/WVpUDDRlJ0F0s39b
         BTKCc8gnn3Ab7uIulOMa9LMDypVqKJI8v6orOT2xATwJQ1UhSdmtshtywWbslRIE6Ahz
         4RHdHtn6+1MabqbWQzaqU6gCIfhx+jr44oKYDlvRMM8uq3+UqI1VEf2XtMz1YyRUHcyc
         xG+w==
X-Gm-Message-State: AOAM530GguvLRtdcsVCw4NgQYPv8m9Br0Z4R6gAUQTWRaXleU/YsuYqG
        xb3dhLnSQ8TGdQBv9ENkWYrkc4y30ZRe/w==
X-Google-Smtp-Source: ABdhPJwT7QpEHE0pKObmtH2Es2S1kItGRzdci3iv0Rb0Q6fld0U0vVq1Gs8LPYiuiWADQgewhqumYw==
X-Received: by 2002:a17:90b:4b0a:: with SMTP id lx10mr807499pjb.16.1643942635914;
        Thu, 03 Feb 2022 18:43:55 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id k8sm277011pgc.89.2022.02.03.18.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 18:43:55 -0800 (PST)
Message-ID: <cb6f65b5-4e02-08af-bea6-141fb6227927@gmail.com>
Date:   Thu, 3 Feb 2022 18:43:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <xmqqo83nr59i.fsf@gitster.g> <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
 <xmqqy22rpm10.fsf@gitster.g> <eb442213-d369-fdcd-c3a3-05239bccb5bf@gmail.com>
In-Reply-To: <eb442213-d369-fdcd-c3a3-05239bccb5bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 3:59 PM, Lessley Dennington wrote:
> 
> 
> On 2/3/22 3:28 PM, Junio C Hamano wrote:
>> Lessley Dennington <lessleydennington@gmail.com> writes:
>>
>>> On 2/3/22 1:48 PM, Junio C Hamano wrote:
>>>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>>>> writes:
>>>>
>>>>> This series is based on en/sparse-checkout-set.
>>>> This has been a very helpful note, but after the topic was merged to
>>>> 'master' on Jan 3rd, it has become a tad stale.  Let me apply the
>>>> topic directly on v2.35.0 instead.
>>>> Thanks.
>>>
>>> Thank you for the heads up! I will remove from future versions.
>>
>> No problem.
>>
>> FWIW, the tip of 'seen' seems to be failing the CI; I haven't looked
>> into the cause of the breakage.
>>
>>    https://github.com/git/git/actions/runs/1792151138
>>
>> There is another CI job running on 'seen', whose only difference from
>> the above version is that this topic has been temporarily ejected:
>>
>>    https://github.com/git/git/actions/runs/1792296432
>>
>> We'll see if that fails the same way (in which this topic may not
>> have anything to do with the breakage) or if it passes.
>>
>> Thanks.
> 
> I just merged seen locally and was able to repro the failure. I will
> submit a fix ASAP.

GitGitGadget CI has passed with the fix, but it is not responding to the
/submit command. As a heads up, fix may not be submitted until folks who
are a bit more knowledgeable about GGG than I are available to help
troubleshoot.
