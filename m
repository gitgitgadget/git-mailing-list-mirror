Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C064C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350509AbiCORRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiCORRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:17:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252C583AC
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:15:58 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so25123037oof.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u4OLQMmrtG7P1PuIcYNLjGnEMgwTCekdZspE2hkZlUo=;
        b=B1G5aq1TubUxkZe7/A92nmAIz4XpZhe8OWlV9mx9Ttz3RKLDlOWWHCPav4+hNWBX+g
         0yQ25gJ+A5ne63qcjnhKxCS3zbx+qARFh2kT0+QEYLyrMLO1dCI+CCRhgVAn0+TczhBF
         USySqPolAU9rv3XG3n9rkM26pWMqO2d4XOIK3bNl5oqfDaFkQxjETbLwlx6qjqb26aBj
         rwBTTXzuHno2+HIaEgE4Ly0RtWrxWfVD/ruEulzBQGBsG4/yMq6lNZuUHWT2+4B4w00M
         +eT4/39Wgr/0WejHuJeRyaT+iAKy+niKXSe2njNwK4GvFl05sbWXjjPR95s0a6HEQjzE
         7FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u4OLQMmrtG7P1PuIcYNLjGnEMgwTCekdZspE2hkZlUo=;
        b=Wmp/IfTQ5VLarBqCFyMk/K/oT5LQg4rm1svMmgziyKS05/+gi5v/aiWckxRiM51Yh3
         GNAU/zizDu+9GneNoEMxMExiKtZuc11Ax0cZEkSymDigSKjkdo7TU9GL82GJxcwv+Gri
         gpA3IeIikxWzEiWts6PE4P7V0lnSLUdD2hnlDWIGkb7zBdaTZ3LDgoiIgDQfZu0GoE5f
         4cwP46cmJyzETnNg3c5XaVMWwTcddzksFmWoPiQDqftsHEeX5YIgAkYGPNK5BWskqT4X
         iUWg3klL/ZmfwqFXbGEEqZUfGLdx37KO0+CoBZ93dtZVN1pbpfGx9u8qEPEGjiqjeAvu
         doLQ==
X-Gm-Message-State: AOAM53200W/OQPzusyFviv//3EaBBRR0m7sX+Q1Wst/iVSq5T1H7nUYn
        e9VLOZxU+FVk4fyKFkA5Encg
X-Google-Smtp-Source: ABdhPJy1QuP2m58UutE7TYYy5IRVyh14n7Hb3RlcmYmDuxxnJYbGNYpj5FqXZ993Jn/XcxLnnj3x8w==
X-Received: by 2002:a05:6870:d250:b0:da:b3f:2b29 with SMTP id h16-20020a056870d25000b000da0b3f2b29mr1820859oac.200.1647364557543;
        Tue, 15 Mar 2022 10:15:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w22-20020acaad16000000b002d9c98e551bsm5977986oie.36.2022.03.15.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:15:57 -0700 (PDT)
Message-ID: <d6631b7e-3237-5f7b-a97c-1b152ffd242d@github.com>
Date:   Tue, 15 Mar 2022 13:15:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/9] tests: stop assuming --no-cone is the default mode
 for sparse-checkout
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
 <05dba7069c5e0c1aec1a7206f9cbea593d8d68cb.1647054681.git.gitgitgadget@gmail.com>
 <xmqqfsnkqodp.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfsnkqodp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 4:18 PM, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Elijah Newren <newren@gmail.com>
>>
>> Add an explicit --no-cone to several sparse-checkout invocations in
>> preparation for changing the default to cone mode.
> 
> "several"?
> 
> After this step, wouldn't it be a bug if in t/ there still are
> "sparse-checkout init" or "sparse-checkout set" invocations for a
> given test repository for the first time that do not mention
> "--cone" or "--no-cone"?
> 
> I am mostly asking for the criteria for reviewers to decide if they
> spotted a bug or if it is expected omission when they spot, say,
> "sparse-checkout init" without either.

There are some "git sparse-checkout init" runs without the
--no-cone, but since they are followed by a "set --no-cone",
the difference is not important. Perhaps, as a later cleanup,
we could go in and delete those "init" calls.

Thanks,
-Stolee
