Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67194C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D08761056
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhHYQ66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHYQ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 12:58:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3DC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 09:58:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o10so284363lfr.11
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAffB7/g4FtxL6wVVB02etGZX7Fyn+MjkmlCWZuq7eg=;
        b=JtqKvULdq+NgsQdfdlYTQReaA9TwKG9CHhu+/ZcLTTY776vXv125FC192wEB9HTSPa
         ZebGQXM6raQuKxlVxPjOSkSRBc7oqsJmtH4IWVx09dG8h19/6JdBhO5h2nEaKsmqNWJ2
         +l7/8vqg+LeUaQWP0cM5tw3OnNJV7v8tLNWNbvRDUh+q94xUCibEbIJsXA0NtVudvlBf
         DyTLF+QaRl/50+cPbu7GqE4e5bLDfI7vTEcmYlNg2NA8jsN9n5KmcDsypk33Nk6PdSen
         2UKPLPgqYWBz4gpenHN2j2I4PlPCZ+o2GGSMZdgvroXPNSDlRo5OR94NO93tA+PjYADU
         vusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAffB7/g4FtxL6wVVB02etGZX7Fyn+MjkmlCWZuq7eg=;
        b=KY071fThxbylcLyVt8VGFT5+prlqv/APNtjv9lZ3mI0X3DdEq5UaDWQn+3VBGUUimj
         ADAgfFS60gmHqN+0HqjEsbKmcf3rM6ULbMO2zpKD44eL2k6rvN/V399WNTwe2gqFp463
         mGdnfHVULJBaG50hJQew065r+07/dLE6rvf6vN2GjOQXRt3TMmR0Asjn6B/6EtYBT0nk
         SlUa4rHP8yiBc9hrS5WhfQTPUNTzkAGyyPtSu7XRdoIqs2ARNXVGI/q0w345sxxALm26
         YAEJrHvQ8lDX6ehFJWRgBHk5KEUOZAXqLMlXNGscL9bpgxfyB887E+jdezjVPXq7A60f
         eWhA==
X-Gm-Message-State: AOAM532JY5vXpVon2jdibFer6blGHsxl1fkwQKMzR64SX1xNEj/TgtHy
        wVKtac8FBwFmHtDAuje73dGWt64OnmUtfz97/vU=
X-Google-Smtp-Source: ABdhPJwRzPvXtO+fhBBu5hNnjH37vFKZQ4WUfpfxknWa5SYTmIv5OwArKN2RUR1M320rrVuB/OYAmaWYTGv8i22/u5Q=
X-Received: by 2002:a05:6512:214f:: with SMTP id s15mr2256718lfr.56.1629910690219;
 Wed, 25 Aug 2021 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 25 Aug 2021 09:58:00 -0700
Message-ID: <CANQDOdcxsR4n9SCtueRBUO4Ea98NBoT17m5srurpvg=CVft51g@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Implement a bulk-checkin option for core.fsyncObjectFiles
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:51 PM Neeraj K. Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Hardware:
>
>  * Mac - Mac Mini 2018 running MacOS 11.5.1, APFS with a 1TB Apple NMVE SSD,
>  * Linux - Ubuntu 20.04 - ext4 running on a Hyper-V VM with a fixed VHDX
>    backed by a Samsung PM981.
>  * Win - Windows NTFS - Same Hyper-V host as Linux. Operation | Mac | Linux
>    | Windows
>
> ---------------- |---------|-------|---------- git fsync | 40.6 s | 7.8 s |
> 6.9s git fsync_defer | 6.5 s | 2.1 s | 3.8s git no_fsync | 1.7 s | 1.0 s |
> 2.6s
>
I just wanted to fix this performance test table so that it is readable.
Operation       | Mac     | Linux | Windows
----------------|---------|-------|----------
git fsync       | 40.6 s  | 7.8 s | 6.9 s
git fsync_defer | 6.5 s   | 2.1 s | 3.8 s
git no_fsync    | 1.7 s   | 1.0 s | 2.6 s

Here's the graphical version:
https://docs.google.com/spreadsheets/d/18HWXSUVAVqqKATsuVvgxDF6ftX_5qG1UGgNjGtwOuu8/edit?usp=sharing
