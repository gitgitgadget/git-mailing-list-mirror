Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A0C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiAFQxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 11:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAFQxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 11:53:20 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E330C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 08:53:20 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id i187so3254982qkf.5
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YNb30lNXyO1t+xfGFYinjn7JEQ3P+F49PHOxHy2lc1o=;
        b=f4ahKUegL3LgVOmFkGdP7wc21uB4RMTmfBzmQTNuQtmb6RXdhGDuRdgXTCgtKy2cZN
         alCiKSVClCbvDs2M/Wb5LCZX0WHwIEApZqnLJGNS17aRFI8lOmnDQY3bephIyLn4ziuJ
         pkkytIRitlSkSw9XljFt6roy++GzIiWHIKNuSYU4U332/CzqV77QZvvrEaY440hUUY/k
         nMkoq4ZrEn/O8ng60ZhUnXDVSZSb+7r0FJPmn0PBX4NCRaG5zevjUf3ZJecAkz6NHtQf
         mG133yNUK9TlxCwbhiuhCMoNcoQ4FunVO7qf1DHff9Wd0oQGnIEALzBKgZXpDn6oYpaV
         yVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YNb30lNXyO1t+xfGFYinjn7JEQ3P+F49PHOxHy2lc1o=;
        b=DGXmVSKfqyn7Q/F2qqgQlwzLH/GQcidGdqAB718jTFGvoiuq/WMLddoChYl4AtPpSb
         2mk2Qu55dWZL2T7Lp7kicAh0iHa6yTtw/CcCm6azdIN2ZzO/lO3bMsvRC3lvIQin9E9t
         R2s1DE6Gf6/FIjaMxi8pFswdAXmf4JXSDKB20Ywq5WZXqq2HS44MB1t6zoxCSYEaPxAw
         oXPeqLeDjhrgQIy2K75PzY1YMVM0vy1CUpqiCEELVS1NiwPoKSF0NieN8jev7eAdTzkz
         hzY9dnrjS6HsF1kZugkB0OAzTqE3f9ax3RBcu7kxgmyD0rNQt6MtjuIiQEs8cH2iNJkM
         /6zw==
X-Gm-Message-State: AOAM5318EeoWZwaYPuUOnEIs5a0KLKP4Ij3gYshyGoPbjZ8hzmNwV95x
        bnU7YMZ2RDrrbcEIymec321Kz6maoMa4uw==
X-Google-Smtp-Source: ABdhPJzlB5sfiJuWYR4A1h73YfAoxchWAfGyUg1YkaloXfnWIFW7P/BuiKsTFPoaOzn799eJCgQ2sw==
X-Received: by 2002:a37:a409:: with SMTP id n9mr43285330qke.309.1641487998608;
        Thu, 06 Jan 2022 08:53:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i11sm1838872qko.116.2022.01.06.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:53:15 -0800 (PST)
Date:   Thu, 6 Jan 2022 11:53:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2022, #02; Wed, 5)
Message-ID: <Ydceeo33Yt4N/brN@nand.local>
References: <xmqq1r1lfwyq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r1lfwyq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 05, 2022 at 05:56:45PM -0800, Junio C Hamano wrote:
> * tb/midx-bitmap-corruption-fix (2022-01-04) 9 commits
>  - pack-bitmap.c: gracefully fallback after opening pack/MIDX
>  - midx: read `RIDX` chunk when present
>  - t/lib-bitmap.sh: parameterize tests over reverse index source
>  - t5326: move tests to t/lib-bitmap.sh
>  - t5326: extract `test_rev_exists`
>  - t5326: drop unnecessary setup
>  - pack-revindex.c: instrument loading on-disk reverse index
>  - midx.c: make changing the preferred pack safe
>  - t5326: demonstrate bitmap corruption after permutation
>
>  A bug that made multi-pack bitmap and the object order out-of-sync
>  (hence the .midx data gets corrupted) has been fixed.
>  source: <cover.1641320129.git.me@ttaylorr.com>

This should be ready to graduate, pending another review (especially of
the last patch, which is new in v3) from Stolee or others.

Thanks,
Taylor
