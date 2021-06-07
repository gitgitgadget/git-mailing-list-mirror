Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F206C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448AE610A1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGRf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:35:29 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44944 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGRf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:35:28 -0400
Received: by mail-ot1-f44.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso1303220otm.11
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cC4S4nLmIJISeIfzg/NFAPqgERsQxBYYVi8vwCghulU=;
        b=pJjJo2Bi/yQoQoWQclW/5O6KonJIt/CmtVifN5lsHKk4uLdj8+0YcR82TCzJsOL8Ln
         cyg2+Cg51OpNz76SAP0ohDTmXuAnLuBnfGpX8sBbbhXZHVY7FKT9uSfcDNAjMLMmeJpU
         o2I3TkJn77oqBVQxswfMTVVqS+0GeGflFrU2r0XWhcXynKkBn59DcxGsWjA95NDWF9Wv
         sAipIwkDOSkp0B2yrnD5/0oawVzNiyRWmhOaGMDbtMixNl2JE7q2nSoRCs49j83I9hN5
         48/kQAwBFFFMshyionWMvIuJfjdwfDFJ3erE6NW/XuyFefqNhXUktx1Q30s9vhdNg4M8
         /nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cC4S4nLmIJISeIfzg/NFAPqgERsQxBYYVi8vwCghulU=;
        b=MMER3xD4tp9GUgXawxOmu/b5gNjtkP8F5orBIzoTceBy9+mztEm6bMcedghIVpxqdH
         bSISY4aeIRO2wL10V1WKZ/fjn0thpW3wmPn60n8ozIUveaJYw45q163TtFAFJg7p+2A9
         l3QMSiKnMTBzuX1LCxwzY0/mvcLD6ZWbbz9A2DxZ4x7UX5MsTgegnBAQs4izUDmvVCBF
         /fU8KbTk+foGVDKdRDmXPyNm5oGVseHVhBKA6MwVtae4itQegKNiNDZXhkj7hqSrMWly
         qqT5jcU7ud9GeGy4xK++/EjfxG1IRcXjyG1LfpIs0+o4KiU02wcdafCBvwO8wayA++rN
         olow==
X-Gm-Message-State: AOAM533qx4j0ZkJYTl1q4YMFUd95InfK1qlkDGcq81lgA2fDUtBMss4N
        wQbsArP/EGEC2h2qkWLBGzY=
X-Google-Smtp-Source: ABdhPJxTXsvYeB7T8hmUmTOW8NzHRWFp+bTcD1g9/UzPlZTbdddG2UXYTBeV/CRXDLEOPuBcxY6fzg==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr14200781ots.291.1623087140967;
        Mon, 07 Jun 2021 10:32:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id x7sm2327480ooc.23.2021.06.07.10.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:32:20 -0700 (PDT)
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <87eedd4n20.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ae26bcd-c6b7-682d-f895-3196c6c04ce2@gmail.com>
Date:   Mon, 7 Jun 2021 13:32:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87eedd4n20.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 1:09 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> There are several instances in our documentation where we refer to an
>> anonymous user as "a contributor" or "an integrator" or similar. To
>> avoid repeating this role, pronouns are used. Previous examples
>> chose a gender for this user, using "he/him" or "she/her" arbitrarily.
>>
>> Replace these uses with "they/them" to ensure that these documentation
>> examples apply to all potential users without exception.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> I think this is mostly an improvement, however:
> 
>>  .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------
> 
> This is a quote from a mail of Junio's[1] (date and all). I don't think
> it makes sense to copyedit that after the fact without at least editing
> the header that indicates that it's a verbatim reproduction.
> 
> 1. https://lore.kernel.org/git/7vehuyosaa.fsf@alter.siamese.dyndns.org/

That's a good point. It does look a little strange that there is
an email in our Documentation/ directory. I wondered if this was
included in the docs that get posted to git-scm.com, but I see that
the link I manually constructed [1] redirects to the GitHub mirror.

[1] https://git-scm.com/docs/howto/using-signed-tag-in-pull-request.txt

As long as this file remains formatted as an archived email message,
the edits here are inappropriate. It's another question of whether the
files within Documentation/howto should be updated to be docs that can
be more easily posted in places like git-scm.com.

For now, I'll remove these edits from the patch.

Thanks,
-Stolee
