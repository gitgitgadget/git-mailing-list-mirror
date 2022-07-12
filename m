Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C1CCA47C
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 08:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGLIYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiGLIY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 04:24:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4FB59271
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 01:24:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 70so6897645pfx.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=N6mT7S9VNDq8poN6tOsQYGY+ii0WrZyVkRpteOn6S2g=;
        b=eYcnbdWkQ2TABKbRyFUAS5BRIyG+pCrqeFX+aDC/bqTxeRwGcsFlutaxYcxRRYFwHi
         Vc4hNkH9UdpX8AuQBzfymmKeHM1OBovitMADaORpaLPnjofYsQEvEwwNmvb1QnuWNdyU
         Biy6GG9bJ/eP9BDyt3my3MLv/dBfpefEDml8oKSSVgUP1KscC/rZb7FujSclykuAbemj
         uu15ZKlkQAQlYgMbkXg2agXUUkGPWpHSDO0trhAhxf7xafoOV8CPKNzbH0oxShVlO4dC
         6zFE8pM81RjPKcyD92kUswPbfNSEu6Qp7SInyOfHh61sdsBPJl0LTo3QlEzzYvf5ab6Q
         gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=N6mT7S9VNDq8poN6tOsQYGY+ii0WrZyVkRpteOn6S2g=;
        b=BGBH7MHYfMLPJKFTzN3pZ6VMFz+6edwwR6u87ZFIhA4JRaYjwzAdQ/g3GwejXGUouk
         fy8nnMbtjag4iaYBKB65WLQVN/XlyGK43MknPEAHGx+oKlNH/mBQZf4eKfuFHXSryLLr
         sSwVyOXPlrCVBXB66q7DuIDmEzCZ4VnZ2XS0Cq/UEsZK2YBvrfFqFoXgzXDRbsJc38WL
         Bksige8Ud205+mBupp80Ot7oEA93vG6gH6c0G6AlicMP1YNZ/AxLl76n7MSeFdqWpMiK
         YtE5h9CrELi0UK1TjUusSp9GyGOkze5tCywo+42rORq/FMJuq8mPhjxJN4wopB9YZkvW
         w9ZA==
X-Gm-Message-State: AJIora83k1yiZYu8rmmjGgmTg9EfU2f+nrgyhuCX9dA6exVDj1Ms+/N0
        oiKWkJmBfEs313Fa7iJmi0aHcu4S7CComJsO
X-Google-Smtp-Source: AGRyM1sq+ftEFBD/wUY3Xqyq9FxgNH1fVhrODnRuyvaX7vHr6lCq/hAC7QFEZZO9JCr87lStFz/IFw==
X-Received: by 2002:a63:ee10:0:b0:40d:7f37:77c4 with SMTP id e16-20020a63ee10000000b0040d7f3777c4mr18757597pgi.28.1657614265071;
        Tue, 12 Jul 2022 01:24:25 -0700 (PDT)
Received: from [127.0.0.1] ([128.1.248.98])
        by smtp.gmail.com with ESMTPSA id g124-20020a625282000000b00518e1251197sm6310775pfb.148.2022.07.12.01.24.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:24:24 -0700 (PDT)
Message-ID: <803773d1-25b6-e62b-18fa-efd9fdc92c97@gmail.com>
Date:   Tue, 12 Jul 2022 16:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [GSoC] Week 3 and week 4 status update
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shaoxuan Yuan.

I'm writing to share my latest progress [1] from GSoC week 3 and week 4.

You can read them when you are free, and generously give me some
advice if possible!

---
Summary of the week 3 and week 4

At this stage, the main focus is on making `git-sparse-checkout` work better
with `git-mv`. With the ongoing "from out-of-cone to in-cone" clearing
up, I'm also working to make the complementary "from in-cone to out-of-cone"
possible. Read the previous blogs on GSoC to get a better context.

In the meantime, some experiments towards integration with `sparse-index`
have also started, which are based on the latest work "from in-cone to
out-of-cone" boiling in my branch.

This week I'm working to ship a PATCH v5 [2] (please reference all the
code here) to address the issues raised in PATCH v4 [3].

The good news is, that PATCH v5 is being queued into the 'next' branch, 
which
means it could potentially be merged into 'master'. It marks that this stage
of work is almost done.

[1] https://ffyuanda.github.io/blog/GSoC-week-3-4/
[2] 
https://lore.kernel.org/git/20220630023737.473690-1-shaoxuan.yuan02@gmail.com/
[3] 
https://lore.kernel.org/git/20220623114120.12768-1-shaoxuan.yuan02@gmail.com/

Thanks & Regards,
Shaoxuan
