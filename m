Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E975C2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiAZUFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiAZUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:05:36 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E7C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:05:36 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id o10so719528ilh.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKpxGoc8gav7QWepoo3hdtR9INeLElFCN/ripH9Rym8=;
        b=VA+JWk6LVtPvW+e72maJBYgtubwh8uyp/QeozqCoVzCUiM4XpDwKJMK8nkQ099sL3W
         HYt4rUH5hqAiAVpA2611x0yaWn5cwYLlY4lzjHbO1U/Y5pTHD/kj99O/mCv09JWzFd9O
         NXw7x6BiO+3KGBQ3FmPrb0x+e7kZFXPEFVI9hlyZZyGbrkaCepy4StjTZ2zi2H+88SoZ
         juuF2tzXJs6f3lMQjMlTFLIE7n99ujN/Q2zLvBR5wZvCHuI2UzYBc46Uoz6WkXxIflxx
         QWouQzqRbQxphk6kQY0SPUUO+7GKgOLev+AvLh3GQAtRvIOj+YOm8t93W0cMWDFitp2x
         Lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKpxGoc8gav7QWepoo3hdtR9INeLElFCN/ripH9Rym8=;
        b=mwHaGQ2kHPHmSaMSidJFk+NKmMa1sfD9XZ7HDB3Pmgeto35upmbosACYmpdV7KYrl0
         pXwF5xGc2Yqt99BAhD9j0+395dsWMNkmPzqfTsr6QFcq/VDd2yH417kFzHosuMKOpC88
         BCbRCRzxgzxKIeeiX9fONWHiSusqGIFsF0cUVd29WpSRd/adco/yJnv3gGzQsCAMGl/A
         ela7sCPIYn7RQ3Ooat2A2uMigG29VJHFkPUz11ZoBqHSG6Xe2d5De0p4eeNkTDDtHoXB
         6neZBzpvb++QgxwD1AJ/TdoXshMFwiJAYyg66BYm/Bl2VXFx1/GJKOxEpyQDntY88eIL
         uveA==
X-Gm-Message-State: AOAM531cSANFDa16ozRKiXk5FTFoSM22LGgHIB36q+aclT7moqfIXgt6
        LhMqVV+qFWT+pU/GryQ57uxx8Q==
X-Google-Smtp-Source: ABdhPJxCzGnEvOVmZf5LR0XIng4uXj9lHqnR3csf8478IY3hYuN22BvsJwABlGURy07avlokUNzGxQ==
X-Received: by 2002:a05:6e02:1c49:: with SMTP id d9mr518404ilg.168.1643227535857;
        Wed, 26 Jan 2022 12:05:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f2sm11386236ilu.79.2022.01.26.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:05:35 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:05:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in GSoC 2022?
Message-ID: <YfGpjm8mCkWIPM6V@nand.local>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

Thanks for organizing this.

On Wed, Jan 26, 2022 at 11:59:16PM +0530, Kaartic Sivaraam wrote:
> First, are we interested in participating in the 2022 round of
> GSoC?

I think it would be great to participate this year, provided that we can
come up with some interesting projects and mentors to help out.

>     Taylor showed interest in a bitmap-related project during
>     the Outreachy application period [4]. Taylor, are you still
>     interested in mentoring a bitmap-related project? Would it
>     be possible for you to do so for the upcoming GSoC?

I'm available and interested in mentoring. I don't think I found many
interested folks via Outreachy who wanted to work on bitmaps, but I
think it's worth trying again via GSoC. I can rejigger the proposed
projects there a bit, too.

(I figured that it would be fun to have an intern with fairly wide
discretion over what they could work on, but it might be better for some
folks to have a clearer idea ahead of time.)

> [4]: https://public-inbox.org/git/YVTM+WQH%2FUyhVeTz@nand.local/

Thanks,
Taylor
