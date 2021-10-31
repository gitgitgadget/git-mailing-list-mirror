Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E61C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F60460249
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhJaSjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhJaSi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 14:38:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5489C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 11:36:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l13so5140691pls.3
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IM3gz/Zyu41cQf7mOVt9YGOu6XxL0Aqc5EiG8rOfMLc=;
        b=lk52dpjwS0oWaTm2W/cd7QDZwgF2UiefgGjWxEB/DVTnfEFK8XZG48mfCkDcdCC5Q5
         Rc6aTLOjk7JqhzlwJ51f7IXmDFSbludObndxdWJvUtimMVotn0EPQY/U+ylzBwXpe4gc
         RMhQfEwC2x/XM8iYwsHW0vFO9WxrAWqP8Td0Wk1O9pRGnVCrYXBAZ5vWgq2Rh1z5Dx1w
         zHvyfL4RTQn7Q7M99hOBM1f9SCr4cM8nG3yzFdDtyRXx71iYe0+PFbzLpjMoHy+2gr0t
         ofzijEPFfA4i1Xl3z6BvO4OF25ijREWPIDaMuU3Feule+qQajC4eUgf3zlwCiwV61aGJ
         /trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IM3gz/Zyu41cQf7mOVt9YGOu6XxL0Aqc5EiG8rOfMLc=;
        b=j+PRmOVU54KjdQ4g4onW9eFoobUdWbEKQfGA3ObiHA6fvzGeItb8A6FevMY2lCFEXk
         9Rb6E8w1RATpAsqN2cAQcyXMKa85vdSik0FNTOjyDyIn0IeYD3ZiJ5Kn9p9iMKdc4bu5
         2Syi2IIJf9tP7hoLWfAAbLI9uEqZvh19H6ApV8j/pyL9SaqB9pCJJVeC+aoouls3p4wA
         8TEIy/7fqlaQAPLSs58RQ9xCYXNdvJaR/OnQY8DaCwX6lJOAsZJ/H1b9z8xiCVCskFgB
         E4VyXYSj/GN/dgc3Jz595WPUtgCUtftZSlvThuqPFS68HTrIjDqFIu67P2IArlqqkKHk
         mTsQ==
X-Gm-Message-State: AOAM533zhi3pXsVahMT6ekC6+dxbhBeYFuyAoiUC4cFY4+DgksOwRdnN
        oGfSkExa02S+VxhxBTrCst0=
X-Google-Smtp-Source: ABdhPJxvKWR+hzL0c/9GSjlAMW3DYpPDbgweuvBTSZUALhaVFnegMbNfRFRnY8OyUMamZiOF8E/Sew==
X-Received: by 2002:a17:90a:a503:: with SMTP id a3mr15241392pjq.122.1635705387110;
        Sun, 31 Oct 2021 11:36:27 -0700 (PDT)
Received: from [192.168.208.38] ([49.204.130.72])
        by smtp.gmail.com with ESMTPSA id oj1sm7694641pjb.12.2021.10.31.11.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 11:36:26 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
To:     Jeff King <peff@peff.net>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <YXeRNkO8B4TP/cau@coredump.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1575aeb5-7aec-3d5c-6b2c-11b9866f3f4c@gmail.com>
Date:   Mon, 1 Nov 2021 00:06:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXeRNkO8B4TP/cau@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/10/21 10:55 am, Jeff King wrote:
> On Mon, Oct 25, 2021 at 08:48:04PM -0700, Junio C Hamano wrote:
> 
>> * ks/submodule-add-message-fix (2021-10-23) 1 commit
>>    (merged to 'next' on 2021-10-25 at 377e759528)
>>   + submodule--helper: fix incorrect newlines in an error message
>>
>>   Message regression fix.
>>
>>   Will merge to 'master'.
> 
> This commit has an extra unused parameter in the helper function. I
> think we'd want the patch below on top.
> 

Sorry for the oversight and thanks for catching it (again)!

This reminded me to check my config.mak and enable DEVELOPER=1
which I seem to have turned off for some reason. I did notice
we explicitly add -Wno-unused-parameter to DEVELOPER_CFLAGS (likely
with good reason). The rest of the flags should be helpful though :)

-- 
Sivaraam
