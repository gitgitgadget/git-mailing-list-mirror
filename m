Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE9ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiJaQq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJaQqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 12:46:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3112A8C
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 09:46:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o65so10210351iof.4
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+al/lw9sqhaJ1Si2BuFIrQQ3n1x9yxpn03c5mDKosA=;
        b=f4RmhzkgSWkAvgPgE5W4RoLF6b3uywGF0wErn+fg1r+RAaJ47qiaAfnePs9A2qNTeb
         ib/sBBhy0prJKO0/Ontjc5u3nS3bfZIn+LvJ3Wt0XotfYeunaZaTtiODrNluziz1SkzX
         Jwdusibe9FxWkvI+N8Qygnu4RHjQOefrmL8lLjoS7KAkrUVQTn6kdd3FayBh8hpeNBwk
         Em2ttBUrU9joak99dkJGNeyEu5Wy4OsgJ4eaxNeBhp/R753dAaUPBYLCRPmgmqHOtqJZ
         rFBVqMwcn7tW4JjTPzfcxIVLy1p8FW5j5P0jDiq6R0Opt+koQoSajvFew/HzSKBmR4qd
         T+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+al/lw9sqhaJ1Si2BuFIrQQ3n1x9yxpn03c5mDKosA=;
        b=7LoZYASscZs0Uhjkac8bGTcIaQzhE7ZQN1uSFjKXNPiF115GRIq2lw8VRHJtbjbppB
         t+qECoIHnL02yT731Sm8s1zMp+Ti85ipH2A8RjuC430mjN1p8+JZn6B+4uJBpaKuDv7k
         ocN2tl4W/iVWJzZUrK6yWBBASbtafPdUN40txGP+Y11uAbuImpn3V1M57EaS9MBBQqWC
         9U452AxmNdSKODNg3Xz/PGaYwpnf4J358m3u5I4iAuwhXH4y/sLQvtMQJyQ+Ly67TP6y
         54NjZJ1FpIve6kAE2ZuAQXAt7T4gfu4NtoRpAyz9ZMycyTk3zaNvo9vzQeTuvr9TiOlh
         0KiA==
X-Gm-Message-State: ACrzQf2Ks2LxHTpK6Q186htD8Ub8TYCsRFfg5bDNfvEYrO5VsABo/Bw7
        p0+G4JKG66LvCXGtmchuzVhS4tTXZ2CJbW+v
X-Google-Smtp-Source: AMsMyM6vx+62Z050UeAkfAzTSA6boMNPJsNWvpqJ4P0m5BVT/be9K/pCDvASjtnY+Z8UE2lIaXWAvw==
X-Received: by 2002:a02:290e:0:b0:35a:d680:7aad with SMTP id p14-20020a02290e000000b0035ad6807aadmr7690603jap.62.1667234811746;
        Mon, 31 Oct 2022 09:46:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k21-20020a023355000000b003634aa4a55asm2949010jak.82.2022.10.31.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:46:51 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:46:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Large repos mini virtual meetup
Message-ID: <Y1/7+S78dbtyTZWU@nand.local>
References: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 11:18:37AM -0400, John Cai wrote:
> Hi everyone,
>
> From our contributor's summit back in September, one theme that
> emerged was the work around scaling Git for large repositories. In an
> effort to gain shared consciousness around the problem space, surface
> opportunities for cross collaboration, and deduplicating current
> efforts, I am organizing a mini virtual meetup where we can share
> about common problems we're trying to solve in scaling Git for large
> repositories.

Thanks for organizing. This sounds like it will be pretty interesting,
and I'm looking forward to it.

> Anyone is welcome to join! Here are the details:
>
> Google Meet Link: https://meet.google.com/zid-azpu-apa?hs=122&authuser=0
> Google Doc for notes: https://docs.google.com/document/d/18Mh6WokkSb3t7xeLsTdAUrSd8xfxZ4Myc-X25sG8b1Y/edit?usp=meetingnotes
> Time: Thursday 2022/11/17 11am-12pm PST / 2-3PM EST / 8-9pm CET

Added to the Git calendar.

Thanks,
Taylor
