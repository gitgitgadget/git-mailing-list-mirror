Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D0C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbiCXPbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243490AbiCXPbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 11:31:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB957B0E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:29:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b188so5199636oia.13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pqeBf7dAF0Fiwd5W9V2Uqu5F8t9WFaipjZp+PQNWFHs=;
        b=gotOndINF+EreJd7vbqxVwmDgyhPLVyTXhA3FA3feRzvMj5jfN5X62n9UkuDeA0E6e
         XEZZwe52bUWaAuzwDOep1enezN4YwNC+SS/JxNY1DmET9aQmj/ksO/0gKFvHBvgHc7X/
         +fBjU7HFUVwg9h7dURW94A6mluMwtk/n3lxrArE5ezInDc4cGyIB/1Rxr+jfTD3AR4h0
         PmE+twxcWiq2acUr3mMlOze+ypmIgIbgy+o4bAop+Q94sAtV6EPh83Zgc3Lf1Eju2goF
         lPuMlgDwT5fITUVan/xBx4M35gEh6H+pTZDp4C5eJRANmRb1UBZV4yaW9FddoYaG79jQ
         zNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pqeBf7dAF0Fiwd5W9V2Uqu5F8t9WFaipjZp+PQNWFHs=;
        b=dkbJA0ABarNQRuFmUGibjjCu+W8CWD32sfkOMWlXnmfNsSyTVck5msLrmSZKc3rMG2
         5wcgiNjGOnPp3Trw75iZsIXztm7jv6NXFYeys13neF195SPvxv6XY/ebnjXSx5lh34Zv
         p9fDmhwgW/d/cV2V505tFw8fSuudCUVB6geoKCZENBUlQ5aMyU4abzo50Itms+S+H5FJ
         3kEOkBRalj43d++x+7GzBnwq8zqehXTzKKm1D9fsTB6Yaqd/Ek8K3/xR755vrIvcuSP0
         LpIjjkZltu5o8MOo0qgsBcFygnbAZPMW1EAXTIPlRDMHOzWOvJt00uXwWW1ovwNuKLC7
         XTrw==
X-Gm-Message-State: AOAM531s0ensP99eXwt/4JX1z9N9PoHnVFTZHanGS/ahyM5iSFBMe1Du
        52EqUpyBQ35CIaRXATqkKwYP
X-Google-Smtp-Source: ABdhPJyizH7lm/H2ywstpl8cSm5jc2T4XVUdU7PnCWDQpMt9r1bQ4cGn8rv3gzerDf++/W3AcRnJog==
X-Received: by 2002:a05:6808:1a10:b0:2da:5a40:36f0 with SMTP id bk16-20020a0568081a1000b002da5a4036f0mr7437227oib.41.1648135781587;
        Thu, 24 Mar 2022 08:29:41 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r19-20020a056830121300b005cdb11a7b85sm1317079otp.29.2022.03.24.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 08:29:41 -0700 (PDT)
Message-ID: <a4656826-aecb-d752-7ce7-2ce7a37c7b00@github.com>
Date:   Thu, 24 Mar 2022 11:29:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     stolee@gmail.com
References: <20220323210803.1130790-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220323210803.1130790-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 5:08 PM, Jonathan Tan wrote:
>  test_expect_success 'fetch --update-shallow' '
> +	git init a-submodule &&
> +	test_commit -C a-submodule foo &&

You add a submodule here so you can trigger the bug in this test, but...

>  test_expect_success 'fetch --update-shallow into a repo with submodules' '
> -	git init a-submodule &&
> -	test_commit -C a-submodule foo &&

This test was already named to be specific to submodules. The test names
could probably use an update to describe what's really the difference
between the two tests.

Is there a reason we couldn't trigger the failure only in this second
test, allowing us to still test --update-shallow when submodules are NOT
present?

Thanks,
-Stolee
