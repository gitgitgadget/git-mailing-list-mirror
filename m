Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8ABC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359339AbiELXAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356737AbiELXAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:00:38 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F127EB8B
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:00:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g3so4376290qtb.7
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bqc1Va5MQQnGXvYqPaxRR/5KOadL55OwzsaeorY6t+o=;
        b=HplKP1aGxI9hu2YNjHwR4dnrou9Z0xBNVeZl3Ccr2XiPXPSEb1P51uoFNtJlxLj6Ia
         W6qOIEVHzDhfQaaZ1zz/MVQhbqf4ovkd+R3KUcLOofBUqJiol75s8STg7HEpdvM2dEd5
         fy/v1IQz8sXDKttPpzpRna/+HtJpWO34bnoqPUaWmgjpSGndUC69rXA94MTCvJnUvVME
         Cv9YfeQDTag4eAo7HvJouqYsbx99HRpe11b/xVCCSRFClgnM2MnLtqGiOtQ9AwcrjMxs
         GconUwe8aGvmbGjQwUU+yGkaOXUuz/7Lq4l662PjntXxgTqWullY9HYaK9BVLaDcgdtn
         mFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bqc1Va5MQQnGXvYqPaxRR/5KOadL55OwzsaeorY6t+o=;
        b=uW8Mx2GCe6b6xwMWZgumI5FYukJp07Qd5eqpYaxLIdESwnv9djhDKY/caPzXEPDa/2
         UZz1drYwMNoRHPBLfeEHDn5/2Qa60IpzWRF51goOCiZ/OnH2W4HpqU6dCpJTU8tnZUC/
         kMmM8hJ8NiPUtN+XE97PC+izGTCtCBt8J/8z7w7Rm4YGjJxH3PKqJE5eXtkkPXZ/eFLa
         v3PrwZJUQKEftLk8bcr89XmBCNDU4NsESiB6udHxy+xKuBEdwDvMozDJNRItd6ywZI3b
         G9lq2loJYJQMvim9iuRy0qFj7ZdthapCbLKy4uniw5hTft0dEQVKVcAGSdTHRrPFTdff
         zE4A==
X-Gm-Message-State: AOAM531Qe9jaAy9KMG4MoYDIdJCIH17rOnV+65cqiwXhyoonN4ctNf2H
        82ysY/bEB9h2uDRPAMJ5u2c=
X-Google-Smtp-Source: ABdhPJwfpCOMms/Xl68jT0voo/3yvMOEH0uocWjxnnP3Y+vCUtZXfFWshPlnjkWMDE5X9DBiCutnag==
X-Received: by 2002:ac8:5dca:0:b0:2f3:ce27:c691 with SMTP id e10-20020ac85dca000000b002f3ce27c691mr2086295qtx.515.1652396435155;
        Thu, 12 May 2022 16:00:35 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id b126-20020a379984000000b0069fc13ce217sm465865qke.72.2022.05.12.16.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:00:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
 <YntVo0G8G2mQYCLZ@debian.me> <xmqqh75viwoo.fsf@gitster.g>
 <9e766e57-3b6c-494e-84b6-406a91ccf6ea@gmail.com> <xmqq4k1viuwu.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <2507aeec-b2bf-cba0-e36c-994d1cbbbac9@gmail.com>
Date:   Thu, 12 May 2022 19:00:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4k1viuwu.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-05-11 à 18:09, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>>
>>>> On Wed, May 11, 2022 at 01:47:30AM +0000, Philippe Blain via GitGitGadget wrote:
>>>>> +We can note a few things:
>>>>> +
>>>>> +- Each commit is sent as a separate email, with the commit message title as
>>>>> +  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
>>>>> +  _n_-commit series.
>>>>> +- Each patch is sent as a reply to an introductory email called the _cover
>>>>> +  letter_ of the series, prefixed "[PATCH 0/_n_]".
>>>>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>>>>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>>>>> +  letter of the previous iteration (more on that below).
>>>>> +
>>>>> +At this point the tutorial diverges, in order to demonstrate two
>>>>>  different methods of formatting your patchset and getting it reviewed.
>>>>>
>>>>
>>>> In case of single-patch series submissions, the anatomy is simple: first
>>>> the email subject is commit message title prefixed with "[PATCH]" or
>>>> "[PATCH v_n_]" (in case of n-th iteration), then commit message and the
>>>> actual diff.
>>>
>>> Correct.  There is no single-patch topic in the summary view shown
>>> in the document, so it does not belong to the above "We can note a
>>> few things" list.  But I agree that there should be a mention for a
>>> single-patch topic somewhere in this document, both for a patch and
>>> (the usual lack of) cover-letter for such a topic.
>>>
>>> The sample topic this tutorial uses is a multi-patch series and
>>> everything in the document revolves around handing a multi-patch
>>> series, so finding a good place to fit it may be a bit tricky,
>>> though.
>>
>> There is already a small section on single-patch topics, at the end of
>> the 'git send-email' section [1]. And I add a link to it in the GGG
>> section in patch 5/5.
>>
>> [1] https://git-scm.com/docs/MyFirstContribution#single-patch
> 
> Yup, I was wondering if there is an easy way to move it to this
> section, which imparts a knowledge common across different method of
> patch submission.  If we can do so somewhere nearby, it would be
> ideal.  Perhaps in "We can note a few things" list or as a side note
> immediately after the list, we can add
> 
>     - A single-patch topic is sent with "[PATCH]", "[PATCH v2]",
>       etc. without _i_/_n_ numbering (in the above thread overview,
>       no single-patch topic appears, though).
> 
> Or we can redo the lore screenshot to include such a topic, perhaps,
> then we can lose the comment in the parentheses.

OK, a little side note sounds good.

> That reminds me of one small bug in your patch, where it says
> 
>>>>> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
>>>>> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
>>>>> +  letter of the previous iteration (more on that below).
> 
>     Subsequent interations of the patches and the cover letter use
>     "PATCH v2", "PATCH v3", etc. in place of "PATCH". "[PATCH v2
>     1/3]" would be the first of three patches in the second
>     iteration, for example, and replies to "[PATCH v2 0/3]" which is
>     the cover letter for the iteration, which in turn replies to the
>     cover letter of the first iteration.

OK, I will add more details along these lines.
