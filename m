Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDACC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0196C61073
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhFLEnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:43:37 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38412 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhFLEnh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:43:37 -0400
Received: by mail-pj1-f42.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so6974491pjz.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjPOwgab3lgCo08YCF7nFyCHXH0euPOyQfoWfJ7KNtc=;
        b=nORJKinwJ5C/ekfCiWVulrkuYFYsgD/6Qsbol252d5xrc3Z46ym1Lg4XaFoMpJsfSn
         1zVr6lnAncvhDjvm7+k+kAUhNpXlceJq285/bDOvwDoUExq2MdvZ1JN1cWcz3Dw2Trau
         ZQQpwEb1d6q5THp4h1p5nFzm6fwIpW7ymn6TLcXJlnQdT9Dk7jVc3rcoWal9j09EvAQm
         dQTDjVdw03+zf49LDCp6M6SMbHZXR3suadeiCywrrH/HTBV2EHj8tfCV0QlWKrO70DjT
         A+xN91cJ/R/vdaTXqIQlddscKYQBu721Z9HorJTcb+p67IItZHm79WL3MsPFZ5abOL0v
         I3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjPOwgab3lgCo08YCF7nFyCHXH0euPOyQfoWfJ7KNtc=;
        b=t6VvF/zSzyd8OScWiqawLyJ6b36M4aOMybgR0eGyEdOlR5enxXVZCuV10tAkeAW5Uc
         ogL6kX1iI3BajfMyYvI/gSOCMtrmjgPHIfbw72qU5AFIEzNiPge0EfVvbefxIJ63hpU2
         3qo3JnE+q9v9M+DCYyNV1KapksgzlPbsylh0qYgNs3/fE/EOLB9+mNQEx7lSrZdzg3fP
         ysgRzUq+2dDKBEqAOjR8hyRTAZCkxQ3dkdbNeWgPC7K6tJBefPnBQU701kqNIB6RwusO
         OCdYl3CfQnDLyuun/GTU0egZK5WIu5/O2g5V3s0Tjq7TOl21e7dj0iE/N6rnzmvBESPA
         7QSw==
X-Gm-Message-State: AOAM530ivB0syxwO5gs55iYnskUbk48DMEy2x/RBE3iS6hVn/ImtHE03
        6cOTZMpY9sJDUOkeksUbIHE=
X-Google-Smtp-Source: ABdhPJyUZzvAfJfe1nzHkPKzXnWF1s6OPYkmb43UT39iIwp4cN4uqOk9NKR7VBgbUTdrkYEy2qHFmA==
X-Received: by 2002:a17:90b:3e8d:: with SMTP id rj13mr12545663pjb.159.1623472838221;
        Fri, 11 Jun 2021 21:40:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id j24sm6176119pfe.58.2021.06.11.21.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 21:40:37 -0700 (PDT)
Subject: Re: [PATCH 0/4] Use singular "they" when appropriate
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3fcda131-1e59-341d-d4fa-473f203d5f9d@gmail.com>
Date:   Sat, 12 Jun 2021 11:40:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 07/06/21 23.57, Derrick Stolee via GitGitGadget wrote:
> This patch series officially adopts singular "they" as a contributor
> guideline; see Patch 4 for the change to the guidelines and the reasoning
> for the change. Before modifying the guidelines, documentation and comments
> are updated to not use gendered pronouns, which provides examples of how to
> use it.

Sorry for late into this debate, because I'm still on recovering from 
fever a week ago (I still have headache and prefer eating less).

Honestly I'm against this patchset. There are concerns from ESL learners 
(myself included) which have been taught that `they` MUST be used as 
plural pronoun.

As an alternative while still keeping singular constructs, why don't we 
use gender neutral pronoun "it"?

-- 
An old man doll... just what I always wanted! - Clara
