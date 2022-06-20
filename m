Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57381C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbiFTUVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbiFTUVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:21:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F213D66
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:21:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y79so12249110iof.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m/X4mdojupGUHGWxv+HfhCKbZ+ZkfCMIoJivb23FX0Y=;
        b=MRYoSzMc8mv0ZTsQCjhDrayVy9VyP9UBpaqbeYKGJfYl+Z0XGkKXygUsVx5oCUEJOn
         CF/fWAJ/yPYl7Tl5/Sec4WTbq3Vi39iUlHptwvWaTQtelcrVlBfcavyP8Buk82cXus+G
         BoKN8DWDqqBMOZmGfrFSjqFFKDpi/2mRJ/nw9pGExKOYZlaXDAH8IWutpwbxdhMnCy8u
         VZgx6fbhLIm/rPpAzl4YRtikz8jvabgm0VM2dbx4eSKyhTVlGSyjYAnYT3NUcxqbJLgj
         CxoBDBZ+1DgpmCefYR4naK7AIrBi5wtiYSUYM7nXd1FjfQlPEUmUXik/7Te4LsiVXrlS
         CqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m/X4mdojupGUHGWxv+HfhCKbZ+ZkfCMIoJivb23FX0Y=;
        b=lV7B0dgHhoARv9l6iSX6fhwKYWvL/zgRAM+bnvsfk99zQsPs1dU+NUNEJ4IdE8hDLD
         0m4+gU+T3qFiUkf61V5NC75wNQPxNHZdWJkhno7GkiOZdAjLp3x4rbLTMrUfqnl8gD7p
         CayCqBUEhTSHl/VdiVr+EZkse1gCFHSba29I0vptOB+ztNLDsYZCYmDK2ji77F/pKsPy
         RotNcGLzz193TKRqyPffeSWAMdHRnwfZUZkRDGPEMIfL6SEqzpSbufiBLyoRgXtfe0un
         KtAGe0vogrxaCWcWXDSfULQs0pMy2qLGay1TZIVfl46nSrqkVWgvZW8PJIO7u8REPzyi
         asMQ==
X-Gm-Message-State: AJIora8HSafLwH7tBe8tywARhuwcaVW4T7vPCJZVj75VMYsOKa1cSruo
        m3E6W/uDAm2DuOQEgt4Rjc5T
X-Google-Smtp-Source: AGRyM1tM0gjTn3Lf8fBYIcQY8CRWHcygsHiuUPKA3dQgri+MT8QnaIEgyLSnMAorx9oIWA06SoE3ig==
X-Received: by 2002:a02:aa92:0:b0:331:c856:fe69 with SMTP id u18-20020a02aa92000000b00331c856fe69mr13388268jai.187.1655756492593;
        Mon, 20 Jun 2022 13:21:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed9a:c6cc:7079:2a02? ([2600:1700:e72:80a0:ed9a:c6cc:7079:2a02])
        by smtp.gmail.com with ESMTPSA id h13-20020a0566380f8d00b00331bd537addsm6393527jal.102.2022.06.20.13.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:21:32 -0700 (PDT)
Message-ID: <25e03c86-5a47-2100-2da7-a635673a8e38@github.com>
Date:   Mon, 20 Jun 2022 16:21:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table
 extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2022 8:33 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

> +			** {empty}
> +			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::

I think you mean 0x10 (b_1_0000) instead of 0xf (b_1111).

I noticed when looking at the constant in patch 2.

Thanks,
-Stolee
