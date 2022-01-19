Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC5C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 20:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiASUGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 15:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUGm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 15:06:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F140C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:06:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso16886417wmj.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 12:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D7eoPGOJhe3toYNBmBZQND3+wu/YW/euYLjATb5R538=;
        b=CHhOjNyNKIdyx5YqV8FmBVsbsdEmCxJ3/GFtn7nckUAQIvU2TkHDcj/Sx7jS3fZAMO
         vYI1gJKHl3Pcmp2PgGi6Od0XzbMjOW2gVDyCyuEznoz3kQHKePQ+9gdGg1GYDYktRZdY
         mywnsJuHoXUiptW5vWgBGYAgzxHKxRdkP6DByqQfZE4KxdgqGJatlmY+9t8UJ/zCr7J5
         pngr9EZ8fEuBEOVST2HCfqgHDJaXsh0cdqRUOyU2m8PD3XXgd3JSnKl3d98UJ3BSSJdm
         iyk9Xbab6wDZsw2Qb/bxyctUBwDwItigaHA8RnN9vyRmfE/R1oiOzyys7e0/pUaVL8ko
         UC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D7eoPGOJhe3toYNBmBZQND3+wu/YW/euYLjATb5R538=;
        b=VV5xYFws4w12WiaJnEWPf7muZwhbYD/u5hqSMNhj4WsX4X/BKE8zes1wWaFO1BXdoF
         EhCjGVR4bE67BlV5UAZeFJ/WChLT4akjGsbDwRBRT+PJFGdaJa+ZmFgAGx/c4TzgwJoG
         6Lv4DROSbLKL2iWeopI/mWZM8Wkx1tTnoUMKQb4wnZjFkc+ZEgb9pEdqifBQb1iGjJr8
         7jQqNVe3TJutuM6jHLhB5jiLK0xYry4CeQ1po1z4td0NMD4MxabLA0HI+pT8zUxqstfR
         c7pq7l1Xme+xRzzHUROmMqHx4LHJEOeW1u9uUyA910hsMxqXb54145E1APeQ5+ofMoBV
         GXJw==
X-Gm-Message-State: AOAM531MZPdWcMyFNI93rNgnBJYTnu6knyaANvrZOwt01nuyQ2ii0Y2y
        lfj9udiailrJG65V5pCouuo=
X-Google-Smtp-Source: ABdhPJx1qmPxOXb3AS0mUB19gu+gPrLnDY7DzJ78o8L5gcKYkDf2DHhEjoLgOVQnwPFASAJul7XTyQ==
X-Received: by 2002:adf:fbcf:: with SMTP id d15mr30900445wrs.132.1642622801061;
        Wed, 19 Jan 2022 12:06:41 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id i19sm442396wml.29.2022.01.19.12.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:06:40 -0800 (PST)
Message-ID: <5678dc92-0f64-df7d-f23e-5ffbeae65a1e@gmail.com>
Date:   Wed, 19 Jan 2022 20:06:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jan 2022, #04; Fri, 14)
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy23h4nss.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy23h4nss.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/01/2022 04:37, Junio C Hamano wrote:
> 
> * pw/add-p-hunk-split-fix (2022-01-12) 2 commits
>   - builtin add -p: fix hunk splitting
>   - t3701: clean up hunk splitting tests
> 
>   "git add -p" rewritten in C regressed hunk splitting in some cases,
>   which has been corrected.
> 
>   Will merge to 'next'?

I think so, Ævar did had some suggestions but said he was happy enough 
with the patches as they are and neither you nor I were keen his 
suggested changes. c.f. <xmqqv8yovlc2.fsf@gitster.g>

Best Wishes

Phillip
