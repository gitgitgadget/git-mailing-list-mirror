Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A2C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiGTBmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiGTBmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:42:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D876C11E
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:38:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v185so13254110ioe.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5fg2Aqfhv06qIvNWjMJ+vCDzixjTjRU1MFSTk/hPka8=;
        b=Sxf3kwf5oOp8KDOELWTYe3LQQ3eGu6eJ1JmmS0QNdaWm7D7PyFw5gCgNa/bWzfNFey
         WkgiOCIAwRr/JkpzQDMzQe5U2nIfJAgUygmaT7n4e49mOE2pJ8qEFBpPLj2TyZU9HJFn
         m1hCoTuFed9heSn6ruerMxCnu6TjmMT8Xs7HeCVSc0WDHQzrsKBkG6VMmyQHDamZBWCc
         EWi00Uer4bQWzH1NNbBvhHnj4QLODRP/5tU+bVEsR7iNMomDJqy0LIlU2pSpzN8RrEKq
         X2IkL4pn5QOr7way4WBXemIU1ALsIezRlBB93aTi8W1oqwBD/IPsTHywqufc2w895Hwt
         WYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5fg2Aqfhv06qIvNWjMJ+vCDzixjTjRU1MFSTk/hPka8=;
        b=Iho8VyKCyt/NbptNO4J59ZLHkSNIBF9mWbembBvpflV3Jd8dyUWUELGbrPXOHctjDu
         dlR7UCd8k0HupsBsYQAHmfyk7aiAeqodZZN0KvIl8jrGqpci9DAuq1Il0vbWEr/oqBEQ
         fVtRltfY+sW5kwrsfJTFl0pRDWdvJyPZiRngcbcfxPyNHoOB28qUv1FTTvWD+DjOt373
         maqvR7NJMnf9xwPwUuGSCMELZOG3tBoEmtesyk/zlLwnmonntrNgsbCEKMEJaVx74XBS
         fQOoOodkZc72Oavlo9aBKel1tCWezdYdAS6ZOQeLerTVXWe4BMW6zDFFF5u3Ixi1irfo
         5pig==
X-Gm-Message-State: AJIora+u//vqZ5EgI1KcPiUrspfbeutG0pyC4+KZ1bQKJ+mVqQcrizI5
        kOM622JfsWpS2UR7OiqawGLM
X-Google-Smtp-Source: AGRyM1ugdXdAGxEkm0Voa/vaBVN6R6B1pFXPTGt4PmgM1O3FXfZWGRQvL2/Zf82hkwbmx0d06k70tg==
X-Received: by 2002:a6b:c306:0:b0:675:b60c:8e89 with SMTP id t6-20020a6bc306000000b00675b60c8e89mr16595637iof.0.1658281089029;
        Tue, 19 Jul 2022 18:38:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d574:b134:aa04:ad2c? ([2600:1700:e72:80a0:d574:b134:aa04:ad2c])
        by smtp.gmail.com with ESMTPSA id g16-20020a926b10000000b002dc1f1a7cc2sm6408348ilc.31.2022.07.19.18.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 18:38:08 -0700 (PDT)
Message-ID: <bb1c7669-4d17-66e7-1b6f-2ac504516587@github.com>
Date:   Tue, 19 Jul 2022 21:38:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/10] t/README: reword the
 "GIT_TEST_PASSING_SANITIZE_LEAK" description
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
 <patch-05.10-6f474a0f83d-20220719T205710Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-05.10-6f474a0f83d-20220719T205710Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 5:05 PM, Ævar Arnfjörð Bjarmason wrote:
> Reword the documentation added in 956d2e4639b (tests: add a test mode
> for SANITIZE=leak, run it in CI, 2021-09-23) for brevity, and to avoid
> a merge conflict with another topic, per [1].
> 
> 1. https://lore.kernel.org/git/220719.86lespun6l.gmgdl@evledraar.gmail.com/

> +GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
> +declared themselves as leak-free by setting
> +"TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
> +test mode is used by the "linux-leaks" CI target.

Thanks. This paragraph reads very well.

-Stolee
