Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5311DC19F2C
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 05:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiHPFqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiHPFpt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 01:45:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9852DE8
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 15:37:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b2so6915808qkh.12
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 15:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BMTNu0u6AbPl5Yd4FgXqHOIMf6Ez3LP6DWjzZcWui4Q=;
        b=gcTI+jTsRi82bGtHKnl9CEa14Y/XuWi/CThc9/8CG3CUGhPAJRT3KsUiB1UF5rlFZa
         lS5fQvRDBdu2yXS5KJSkGl67AL+i5tWQaZ7BPzzwGlleWeMrTUcZtp1yaG3A4gv9glhG
         Ra/v2eQ+bgyAKncXl88PjC5dRTVlGYs9iTAfGcv9rDTjB0hBqLKJZg6rZxEsnF+O2bbl
         6ZNZbeauzYNPIAWlkNtsF0vpK8xn2WUNcmPcQ+knqWT57TYcwbIzUxHN6KE6YWXR1Sn6
         grxTmZgpE5RLHI4aN6RVdOZTPticF+rxi2/o54f2ESQHCWP0X8ABHzhOpONIbczjndoR
         xBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BMTNu0u6AbPl5Yd4FgXqHOIMf6Ez3LP6DWjzZcWui4Q=;
        b=rLc0qNlqfmOkbCUFEB9n86F7cyEquAQ8dunHfcD8ryrHmeatYLh8nqTH/E5L8dKXkv
         PCXSL2mLJvWegsBmjomDdo1ncBVtxUtsg6+b/GWHNjjE2bGMpvZMsdRb/xjjbNvRI1pd
         SiiKhgmmKD/8f6kVz1XgIaWF8miIKGezSCueQ8oXV1Rsp0maBpY84fD3FHy+8gQN5R71
         KBd4fQ8VtWtHdEDTq7VFkg1EUbWSFyE7Ny8wuddJQ7qXEa8uvrofXRv/+0f9dS5EpqYu
         CrGSSLDT2i70tNxvJdsxO4ItmTiC5qdALjJFblplxk7+4L0PNtidpNiolY1lml/4OAEm
         yq8w==
X-Gm-Message-State: ACgBeo18E4ihBh2+uVENnVfrVbpSYBUbJNn68FfW1mBW5q0iI3yuec+C
        ZWIAai/CVgwQEAYDdGh3mY80Yw==
X-Google-Smtp-Source: AA6agR5YvBFwT5PKklqv7oaRfOeV6UlUbQb3evydglGHEbo2O55kPONaDrEdxWR1QnbEQyt+Lis/OA==
X-Received: by 2002:a05:620a:44ce:b0:6b9:1111:8d3 with SMTP id y14-20020a05620a44ce00b006b9111108d3mr13354948qkp.567.1660603059572;
        Mon, 15 Aug 2022 15:37:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a290a00b006b5e50057basm10225122qkp.95.2022.08.15.15.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:37:39 -0700 (PDT)
Date:   Mon, 15 Aug 2022 18:37:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhra303 <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Abhradeep's GSoC blogs (15 Aug, 2022 IST)
Message-ID: <YvrKsV0137j0iN8C@nand.local>
References: <20220815183217.7132-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220815183217.7132-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Abhradeep,

On Tue, Aug 16, 2022 at 12:02:17AM +0530, Abhra303 wrote:
> Title - GSoC week 9: finding the fix of the failing test case
> Blog link - https://medium.com/@abhra303/gsoc-week-9-finding-the-fix-of-the-failing-test-case-30bc623cb4c
>
> Summary -
>
> This week I put most of the time on finding the root cause of a test
> failure. I took my roaring bitmap integration a little further. I decided
> to use Chunk-format API for the new `.bitmap` version. As midx also uses
> Chunk format, we can maintain uniformity in designing file format.
>
> I tried various ways to find the root cause but till now I am not able to
> do so. I need to investigate further because I have to be sure whether
> Calling `oe_map_new_pack()` function is causing the failure. As my exam
> is starting from 18 Aug, I can't spend much time here. But I think we
> are very near to solve the issue :)

I am back from my vacation and am just starting to catch up on the
progress that you've made while I was away.

I haven't had much time to focus on your work outside of the
oe_map_new_pack() bug that you mentioned above, but I have spent most of
today looking at that issue. I am able to reproduce the flake, and
found/fixed a couple of small things along the way. But I haven't been
able to reliably patch the bug, even after replacing the call to
`add_packed_git()` (from `add_midx_to_pack()`) with a similar function
that looks for an existing pack in the `r->objects->packed_git` list
with a matching name.

I'll keep looking into this, and I hope to have a fix soon-ish.

Thanks,
Taylor
