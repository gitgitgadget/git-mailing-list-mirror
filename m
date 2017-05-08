Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF3A1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 10:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbdEHKMc (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 06:12:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33266 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbdEHKMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 06:12:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id o85so9339596qkh.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G6Ku45JwlLDVq/VcH3RVH23oC+xxVECli00xHG41DBs=;
        b=b6JtdmMOn2GBrZdvjNRvBXzvpJdpow2QxkEoX9cKGXfBFZ5H+tsKwRjfHhvOTf8bPt
         OqHEJ5o8ZDCpMGrv1tuv34F8yugLptHblI7Z1xxax6S4R4JQuzm+hsMp6zFTOIDjrrRp
         yXCR/rQ6uGhH/kUumvoZiJDMy8+ChCU1EMISl7oik05yrEFA15Uk88go51T31huaIkQC
         jNj3ozuqfpoVEdPt5WrTE4y3dYFDfmLTs/CU8PmbCPf5StOC7CWh1cCwa6a9Thbp7qlA
         jfILUAUICuIlspWo9ArpWfP+Yudl/c5DpSmbSWWPVcUfQUlZbyyZxj/chhHmNBrXE8iJ
         uwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G6Ku45JwlLDVq/VcH3RVH23oC+xxVECli00xHG41DBs=;
        b=toIZsRqikO2RSI7tUmVCAS20Ebann3cN0BHpc6L7cwBaJVSXNbBrDn3zlT4RjoPggc
         j5iboIuolTjBNHRpK3Ih3ncN/lLR2fLUjcgfwBzXtKYNSsYXGdcRhMvoi99ESACUrXNV
         BXn1F/Qmo/rNHdRPAQh/UkOgF0JP+jvBXydmTYx4GKbt5zbAzkSJ0++hdmfF0H/MpNhV
         oC7OWF0Yn8vEIfYXbZaKpJMSyuZhPzBXO2Js+Mjtyqtc2yhVI62U7skuYXgf+EzEDtoD
         PAStFOOCj8cxl7XeMLu+ur/6+4Z61ocMUW1mhK3d2IHqctI2CPWWe4uZFeTbGoLbO2ey
         4RyQ==
X-Gm-Message-State: AN3rC/7n97xFNm4B24rlp0enQRtN+VBZr8luwjCCt1skZpIK2wEgpOhY
        SozgVP04g7pGUiirzTmzS2vxvpymEA==
X-Received: by 10.55.110.70 with SMTP id j67mr22955788qkc.145.1494238349309;
 Mon, 08 May 2017 03:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 8 May 2017 03:12:28 -0700 (PDT)
In-Reply-To: <cover.1494236457.git.johannes.schindelin@gmx.de>
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 May 2017 12:12:28 +0200
Message-ID: <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        David Turner <dturner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Adding Dave in Cc as it looks like he is involved.)

On Mon, May 8, 2017 at 11:41 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> I recently sent out a request for assistance, after noticing that the
> untracked cache is simply thrown away after operations such as
> `git checkout` or `git reset --hard`:
>
> http://public-inbox.org/git/alpine.DEB.2.20.1705031202470.3480@virtualbox/
>
> Duy responded with some high-level reasoning that it should be possible
> to simply reuse the untracked cache data structure in the new index, as
> he had a gut feeling that "we do invalidation right".
>
> I did not have time to back that up by a thorough analysis of the code,
> but it turns out that it is unnecessary: Ben Peart pointed me to a patch
> of Dave Turner's that was submitted as part of the watchman series,
> addressing the very issue about which I was concerned.
>
> And I trust Dave to have validated the idea that the untracked cache
> invalidation "is done right" even when we simply move the pointer to a
> different index_state struct than originally.
>
> Seeing as the untracked cache being dropped unceremoniously when it
> should not be dropped, in a surprising number of operations, I think it
> is a sensible change, and important, too, and independent enough from
> the watchman patches to merit being separated out and applied pretty
> soon.
>
> So what I did was simply to drop the two lines from this patch that
> referred to index_state fields added by Dave's watchman patch series.
>
> Please do not mistake this for a sign that I am disinterested in
> watchman support, far from it... stay tuned ;-)
>
> Oh, and I adjusted Dave's email address. Dave, is that okay?
>
> As we are in a feature freeze phase, I was debating whether to send out
> this patch now or later.
>
> Having thought about it for quite a bit, I am now convinced that this
> patch fixes a bug in the untracked cache feature that is so critical as
> to render it useless: if you
>
> - have to switch between branches frequently, or
> - rebase frequently (which calls `git reset --hard`), or
> - stash frequently (which calls `git reset --hard`),
>
> it is as if you had not enabled the untracked cache at all. Even worse,
> Git will do a ton of work to recreate the untracked cache and to store
> it as an index extension, *just* to throw the untracked away in the end.
>
>
> David Turner (1):
>   unpack-trees: preserve index extensions
>
>  cache.h                           |  1 +
>  read-cache.c                      |  6 ++++++
>  t/t7063-status-untracked-cache.sh | 22 ++++++++++++++++++++++
>  unpack-trees.c                    |  1 +
>  4 files changed, 30 insertions(+)
>
>
> base-commit: 4fa66c85f11bc5a541462ca5ae3246aa0ce02e74
> Published-As: https://github.com/dscho/git/releases/tag/preserve-untracked-cache-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git preserve-untracked-cache-v1
>
> --
> 2.12.2.windows.2.800.gede8f145e06
>
