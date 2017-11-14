Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47251F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 17:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdKNRlf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 12:41:35 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:53871 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdKNRle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 12:41:34 -0500
Received: by mail-vk0-f49.google.com with SMTP id k195so12720436vke.10
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 09:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Vk+z5vjD10cftfGbhrzDW8cbI5Jr+M6GWiYfymAiH8=;
        b=V/vDL+H+7HqHJ2AaPNlGtd8ODCu/wP3x+1JHu1Vd0G+oRJ8haFH33WMzE0YcBSOb7s
         ihiENwDWcqie5UMyBoWWPbvGGfb1S15uVeVWepvzp9sckewQr8CZfytskzuGe8BuO/Oh
         KiRaMOPhQMo5AF4RmywLgRIwhnBo2+42AdnVhe13Ll0ssTMac40xfL1oJGEz+QjZn9EL
         4o/UlnJwDi/bS0JngBauc6TuHU9pYFSXy4mtdCUHhaWufouor8H3sB54AYroeZdHrGZV
         h9121qOX6N8cgsyGnmgCBHY8a9/pGxwFD+Zjo/i4ix7ASrsFgEeo6u887kmX7/v33Hz5
         zWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Vk+z5vjD10cftfGbhrzDW8cbI5Jr+M6GWiYfymAiH8=;
        b=VGQwNn31KHQPFw4lrsDICh0jK1MGFfLLlSaXezDa6hbMQTLffKq4SNiDvJmU0rU9jd
         Xtq4DFIKjKQoM6OWcFA5N9ncoL94MNvEAsFW5SGdospFkvrriqGQbx5NmUpIE6tXcSR5
         /0kb1fJHNXBWpoN6rFhAsWObEyKr51mWp9Y35PZYFiVROnb4iYgNtcm7LEWRAeOBi87e
         lbeDX/ZIjz4zSVbw+YVAiYLYK1k4Gaul2XD5H8555Slf38WcB/QUstLlgEnqK3KihvwZ
         bw026ru1EzDClW+/4gPU9wgkb8mMWjRpMRtRVs6jnroos1uuhIZJZq1ue8nwRYfmqgXl
         Lv2g==
X-Gm-Message-State: AJaThX79Wpamnp2RnVIjhZhsurQohaFj3T0lie0NGkle54GUG8jzwOvN
        Y8gd/5Ibe+FTFCwF5GdbCgbw9sEgRzjmkrcDoCw=
X-Google-Smtp-Source: AGs4zMaGb3FBmI4E9uiPMMoOQ+KQ2AnqNoUdP6r8n2sN0tSXO/3k6jmOUD5VpZZBgBGrKL84SFTC5AGCiLNmD3jntLQ=
X-Received: by 10.31.172.137 with SMTP id v131mr10996088vke.75.1510681293164;
 Tue, 14 Nov 2017 09:41:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 09:41:32 -0800 (PST)
In-Reply-To: <xmqqh8tx5ux8.fsf@gitster.mtv.corp.google.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-16-newren@gmail.com>
 <xmqqh8tx5ux8.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 09:41:32 -0800
Message-ID: <CABPp-BE8Jc-ZmW2bt3Fe3Azd6wEiSTUjsmhNNNdoip_LXHC_Yg@mail.gmail.com>
Subject: Re: [PATCH 15/30] merge-recursive: Move the get_renames() function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 8:46 PM, Junio C Hamano <gitster@pobox.com> wrote:

> It took me a while to figure out that you are basing this on top of
> a slightly older tip of 'master'.  When rebasing on, or merging to,
> a newer codebase

Sorry about that.  Yes, I worked on the series over time and rebased a
couple times up to v2.15.0.  I assumed that was new enough, but
clearly I was wrong.

> By the way, checkpatch.pl complains about // C99 comments and binary
> operators missing SP on both ends, etc., on the entire series [*1*].
> These look like small issues, but they are distracting enough to
> break concentration while reading the changes to spot places with
> real issues and places that can be improved, so cleaning them up
> early would help the final result to get better reviews.
>
> I won't reproduce all of them here, but here are a representable
> few.

Eek!  My apologies.  I will go through and fix them up.  I see no
reference to checkpatch.pl in git, but a google search shows there's
one in the linux source tree.  Is that were I get it from, or is there
a different one?

Also, would you like me to make a separate commit that cleans up
pre-existing issues in merge-recursive.c so that it runs clean, or
just remove the problems I added?


Thanks for all the reviews!
