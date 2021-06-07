Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D3C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BED608FE
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGTI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:08:26 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42807 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFGTIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:08:24 -0400
Received: by mail-ot1-f42.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so13406700oth.9
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lfGWYFrViV9A2t0HMeQgGyxVUtyAMGg06H8D97G+PLc=;
        b=uAl6JPdWtEJTLJIu5IAFFuZGHdnL2AHsibhErHdCSOxD3b1f4naymeL+ggrXcGx9de
         UCOh45zkQffzTFJYvAMPeMl9AG8X3SZ7N1W9zXpAoK2AlX2hM+F1fc1jFxIe/2mUTPhI
         sS8rY44p4/ygJ+s/7yX4emuc66XIjQi1nESV8YE4SizYM3s5PFz1hBXF0Wev7TkG8Lw0
         so48lE9WFAWqZ/U6VmOmnou9u1PHg7Y7xY9vYk/eYohJAENy8HprJMgMBi85sW6xoCmu
         OPE38MiHXQQ1NQ5oadUEM2IOQSDACsBRyXGJDG6SYQnVEBWIcf2IagQAj5w58X1ZgZYU
         i80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfGWYFrViV9A2t0HMeQgGyxVUtyAMGg06H8D97G+PLc=;
        b=qRKELSbwpyge0PfaPj3yZceTCOhEPlVJGs55d0FvBwyrnTx+AbSJtTQUrNy/Kq3CLd
         e3DOf2Ki6tm/mSsbs1IL4Mv5R9/hl5vDswDc4sCNi/syRnUP488T+I3UKmd7KatxtKXn
         v0sgTBEq1wDh2XRwC+XCrj971/lalhfSBOtycqKufilHn4Hu7Qf7SXXN1aWJV8EZvxoa
         CyHwvQUXH3Gy1ZANRrAAl5nf0RjYLn+ODB8HSIuh0tx0vQmMRi0dqsxQz7sXiN3ozHdq
         K6SteHof6lYto4+Rikn80uPwuugbIJtjjDQkya1YXJnY+XZi49B8kcZqSih+kc6dTrpp
         FpHA==
X-Gm-Message-State: AOAM532swL3vevIpz1nZA6/+ScI5LONZflSUnCHuDqa9hgXT1g3OYHMI
        JE0JDlRsfWa0+VBoR1Lnok8=
X-Google-Smtp-Source: ABdhPJwzMcjRmtdKoDAzR7xQlBrzvyN1j29wvcFTmfXScpVrFRoOgXMLAeR89b45tYIS7QW0z9aIqg==
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr14411437oth.306.1623092721947;
        Mon, 07 Jun 2021 12:05:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:58fa:fc7:3955:c1d5? ([2600:1700:e72:80a0:58fa:fc7:3955:c1d5])
        by smtp.gmail.com with ESMTPSA id 21sm1942856otd.21.2021.06.07.12.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 12:05:21 -0700 (PDT)
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
 <xmqq4ke9v6za.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a66ed39c-926d-d887-526b-dc0f9c049085@gmail.com>
Date:   Mon, 7 Jun 2021 15:05:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ke9v6za.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2021 2:56 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> To futher justify singular "they" as an acceptable grammatical concept,
>> I include the careful research of brian m. carlson who collected their
>> thoughts on this matter [2] (lightly edited):
> 
> The use of "their" here I found going overboard, given that (1) it
> is outside the topic of this change, where you are not referring to
> a non-specific person, and (2) as Brian's siglines indicate, the
> preferred pronouns for the particular person you are referring to is
> "he/him or they/them".

I'll admit that I was trying to be instructive in my commit message
whenever possible, so specifically chose that option among brian's
preferred pronouns. If I misinterpreted the purpose of "he/him or
they/them" then I will absolutely change this instance.

For my part, I did run this message by brian before sending the patch,
to be sure that my use of the quote was appropriate. (Also, I'm
purposefully lower-casing "brian m. carlson" to match chosen email
signatures, but perhaps that is also incorrect?)

Thanks,
-Stolee
