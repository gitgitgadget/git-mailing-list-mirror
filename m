Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7DFC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiCAO1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiCAO1e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:27:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7175C06
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:26:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso12308260oti.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=F7a5AHFKfa0psE9kfQtZQW349KUlsTS4M+W6DD7lQAQ=;
        b=XDv4iOcPURyyFIc7NC5sTMVaKhU6xwc6ZLT0IxJaKQl1QgGFYuCv8ARjZuzjYzXMyQ
         NY5aG5vOb5KPaaXIMCkTEFDiH6I4xq+V1LRFTr3ntAOeZYA0taH3ewpNtpN9ChlLamx3
         Cesf2UZnPg+W0dRnIP+w820EcnC+WG1E99OUJjIVtIwg02ZybK2CeLkQL1ETn/8Ju49O
         /QKSb1DX82R/xHUuYrp0PugMbIzf78eYGYDZw3IphW7+VJR0YmrPSKxedLlgEQS3P54V
         xxyPahaEfum91SqgWIgF4M+hqsa/iXs+ZBDFHTJ9DfxTlfc3fDz4+oHpGOcmWmn7zeoY
         Xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F7a5AHFKfa0psE9kfQtZQW349KUlsTS4M+W6DD7lQAQ=;
        b=Q8ZNTngz1U2CFFFeBTO3OLv/9KxcwBIGqkaeMUaYmQN5chWj0LVdE6h99nowVeLQLJ
         pX3ZtAw8Fn/pN/B3CBFZtB2TfX6tjkefm4fqO2EYA/D5TBxs8qhByt9Z+/tJ6TDcNGDX
         52Hcxb1Axf5acUd6xFT82rCRdF7fEFWPgCge8uzE4QsdRHlB4GJ08DX29XhgBeLNKH9A
         Kej8Y/T0h6WOG0byld9Q9MJrIl9YQ6d0JqDFFo+PsQfoMydGxZESvHIBBKleLtudbCGx
         KZl588ukXsf0wkwWDnitqPFMEX+PlA58dgH8fbu9vIdlGyA4Go2IOEN29jMyYsRF4dWV
         3naw==
X-Gm-Message-State: AOAM530FcvaOTCVu0BSn7hXHI+yjnGD/CVJei9Hke/mZ3TBNu2kIECmg
        SpnGvSh4XvAkYzlqz4L2pniM
X-Google-Smtp-Source: ABdhPJxijk3n/w2KmHG7+RqYwnkX/rTH/cLzV8jyFtTr5vJ0D776oRaYlwDbzF2IRn95lfWL+vFJfg==
X-Received: by 2002:a05:6830:118e:b0:5af:a7b:a03f with SMTP id u14-20020a056830118e00b005af0a7ba03fmr12187237otq.123.1646144812827;
        Tue, 01 Mar 2022 06:26:52 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870e1c300b000d0f502781esm5937144oab.22.2022.03.01.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:26:52 -0800 (PST)
Message-ID: <a296c8fc-9701-15bd-4459-e49f157adb56@github.com>
Date:   Tue, 1 Mar 2022 09:26:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: ds/commit-graph-gen-v2-fixes (was Re: What's cooking in git.git (Feb
 2022, #08; Mon, 28))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
References: <xmqqmti9ssah.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmti9ssah.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 8:42 AM, Junio C Hamano wrote:

> * ds/commit-graph-gen-v2-fixes (2022-02-28) 4 commits
>  - commit-graph: fix generation number v2 overflow values
>  - commit-graph: start parsing generation v2 (again)
>  - commit-graph: fix ordering bug in generation numbers
>  - test-read-graph: include extra post-parse info
> 
>  Fixes to the way generation number v2 in the commit-graph files are
>  (not) handled.
> 
>  Will merge to 'next'.
>  source: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>

Please hold for a re-roll on this one. Ævar has some feedback
on these patches that merit a new version. His comments are
mainly about test structure, but they will help get extra
coverage in the 32-bit case.

Patrick also had some concerns about upgrading from older,
buggy versions of Git. I think this isn't an issue [1] because of
how those older versions would ignore existing corrected
commit dates, but it would be good to get a common understanding
of the scenario before merging this.

[1] https://lore.kernel.org/git/f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com/

Thanks,
-Stolee


