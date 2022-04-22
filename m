Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB2C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 18:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiDVSu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiDVSuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 14:50:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55016C20F
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:46:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d6so6369973ede.8
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AizXFprje/f5sT+7toOvU8AQVHnjXuR1/+7K+w6xe4g=;
        b=bYuqmsoHlhz/CuRXRi99Dulla/oxr+eSt/+4ChyTsMEScu6CQ5yi81lX24zoDOxsAh
         4Af51Q2HlaR1RwCbs6RrtU+e9XtoQh2ITjSbCAjguldceiWsJ47QDGwPiLV9usIMm5pC
         xrgrF/rxJ32WTrXgGWCGuB9LGmJstRWJ4crfsmpykxfxkzTsM5DsBZ68BarZSrwBo/ec
         Zxbh4RjtXPpclqCmZUBIk3M7Pbuzhanu6y94VhatMo+WqstvpXxilVUHL4ytSWtqXo3d
         eO23fAd4u0JhPm2haFrRDU2RSz5ZeyWjgy0xNkxIUR3cYizKiUhjPIQQ+s75hxYicOYf
         CAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AizXFprje/f5sT+7toOvU8AQVHnjXuR1/+7K+w6xe4g=;
        b=T/xfticGm2w0zWuGotHJSUjIX4Sz2O1zsywryotXAGjS0jWRqOIKxc9gKFPwJEa1WL
         jU/ITD0Y4S2wNR8AvYfJVoOF0Bjvx5YWqsCbKfi7Guf1LiEq59NSPCySGPI/3kz7Qou+
         eORqjfBQ+AyxHslWUh/vUIG2X6hAc82CtgK42c4+Kyul82HBIFKSB8tgCYOsXWnYbBkJ
         e34BPJm6zR42Yb+DXbWDHqMUzUlxo183uIjou3svsTzRnhhBUqqM7tL1IWiKmBUpO7LJ
         m8hlMwU+69qiRV1LkcMyLGo4Aw2bqui19gocOIlL7UGq9nMVm7i6hMezTmbhkwSWGXNi
         4PLA==
X-Gm-Message-State: AOAM532TFvmy6Ff/BLMrpZfKCkKvk7X68+y7GOdpNgZarWrjJGtkkIjZ
        Qs7nG5uQm7R4cuOnFPM2c2M=
X-Google-Smtp-Source: ABdhPJyjxiRasEsuSIQfylG44w9PS3LkYV2wyGWwjWLKm+uRd/fiOXMtSRTMoUtFLJUx7nfoVKPGrg==
X-Received: by 2002:a05:6402:3456:b0:425:ab60:1b00 with SMTP id l22-20020a056402345600b00425ab601b00mr6381350edc.71.1650652940980;
        Fri, 22 Apr 2022 11:42:20 -0700 (PDT)
Received: from localhost ([2a02:2149:8b50:c800:e8f0:5d4e:a679:b7fa])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm981823ejo.191.2022.04.22.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:42:20 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:42:11 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     Kevin Long <kevinlong206@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: help request: unable to merge UTF-16-LE "text" file
Message-ID: <20220422184211.5z67sxrgq2zm3tvd@compass>
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/19 12:36PM, Kevin Long wrote:
> Greetings,

Hey Kevin,

> [..]

It would also help if you create a minimal working example[1] and upload it to a
popular Git hosting service like Github/Gitlab, so we can try to perform the
merge. This way, you will probably get more precise directions.

[1]: https://en.wikipedia.org/wiki/Minimal_reproducible_example

Thanks,
Plato
