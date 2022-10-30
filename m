Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECEC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJ3SAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3SAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 14:00:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2275518C
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:00:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p141so8278891iod.6
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxv//ZOndsJCdO4r5Am0wDidSUeglX3W4JizwSX+4C0=;
        b=KR3GzWfdEq44xLNSvoAhnpROIJxTcU1TCSeolR1aprfw7z6nGsSOzhZUIYmetVriYf
         A8rBu6TA7kzdhg+Pe38Ychu3ccuBt2y/e3BBOP/MrKLhCTSvkg2jFUlupZ7ljnsPutbI
         7XmVuzm0MwgST3UK2VyNob5iBTIoI8ri/BTf2aGZQNoMExqLSX2AKAjPmaI22KQCMEyu
         Zkh+cf9oAOKP7GByTijIsp9NG7W9/B6228eAim0OP3kdG911hKgb8Uq3gx2RDYIE4nyn
         1QdjwMJ8p3hEUwJiCFwkPAQ87CxZGtlUkmSKOKnitdqEVZq34Q0R+FiPcczhZ7oiOuEz
         L91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxv//ZOndsJCdO4r5Am0wDidSUeglX3W4JizwSX+4C0=;
        b=7/JHWEK4uzTE5RPZ0Mq3jigxoHJfax2JLAKNjJjx/zvRczvnzLhPBMz3RQ2/4NNG+L
         mGofPkarXeqG5P9TnWCQdTRSSRy39ZLhJ04S7pypapSZ8lZM0s4sHwLiB3fgLMnjqASV
         D3o7Iyikik7XZ394GtYoDZPD8jEFjIhljhYud62u5oZ8w+1/tbDI6PN5r8g90BqIVFk+
         f65X8Cz7q4hXbBoNx5deO/V3GgEuGFSiB20C9G/Qc/HD80t3N2vwafy5CEsC9kMW5iZ7
         JiPNr0b3QznXwT3S74kEKmDf/icv2FFiv4sDALGDWsA6gm09pa4Wra9KGRN2A7d+k1gN
         a8Bw==
X-Gm-Message-State: ACrzQf0lbATS3XGnV9LMHhqEaa3eTuEmyQ0XsdnTmpTfxHTbGE8yZODW
        j0pyy0EhxZVECeiL9rS3QrheG9Q0+8fw7oaZ
X-Google-Smtp-Source: AMsMyM6GNi55I11aveW+sfrcDgMj46KYzkHbZhkcG6VeM5a20JfoeRXAQyhIsM4Y052ZdDlOe9c/Jg==
X-Received: by 2002:a05:6602:27c1:b0:6a4:cd04:e392 with SMTP id l1-20020a05660227c100b006a4cd04e392mr4815451ios.23.1667152815516;
        Sun, 30 Oct 2022 11:00:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q8-20020a02a988000000b003636b73cf29sm1918986jam.8.2022.10.30.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:00:14 -0700 (PDT)
Date:   Sun, 30 Oct 2022 14:00:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Debra Obondo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Debra Obondo <debraobondo@gmail.com>
Subject: Re: [PATCH] t7001-mv.sh:modernizing test script using function
Message-ID: <Y167rdL0IB5wnXHL@nand.local>
References: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1372.git.git.1667150441883.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 05:20:41PM +0000, Debra Obondo via GitGitGadget wrote:
>  t/t7001-mv.sh | 62 +++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)

Looks good. Will queue, thanks.

Thanks,
Taylor
