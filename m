Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FC4C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D0760FD8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhHaGUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:20:10 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41654 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhHaGUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:20:09 -0400
Received: by mail-ed1-f49.google.com with SMTP id eb14so15906467edb.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qK7ZFkElSOkvpTuTXTAJDZkJDstQMLbsf5cvDETkXc=;
        b=WBtzbYD6Xiuy3oNpYV0roJynJtggdQy1Erv9BqAswQqBNTTfPPqrYCjLh+vee1v9LT
         EnaehIBqbOVDgpcO/2e52kw4q24JaXzkS7eYXlchOA/8DEWwj8TjMSy9HPGpzBYDLIJR
         b1u3pk9MgGqM6O2Mtq7ZpHbJIB6g8d4z5ykPXh3k5iLS3bbMpsiIt0tkrCd0nktpMe9c
         BMCiFVXZIgWYO+93piBvQOG1IxRTDBvSBr2MF4GvsNIpAaAfHP4yeZNd2dmr44TESyaN
         i6njHAmKVAEN6u1wm04/5CzGaJSWIGs0u5JHee+GHIzj/AYGF0jwKxVOBpB25M5VNQtP
         s0nA==
X-Gm-Message-State: AOAM531ys3150qYoSNGgqkDxH3VVXbqJvCyoy+ANFDws8i84PaN45oO6
        K8nbairPmIE14tsD+71kBc9K3BqEcSaudEQ6dH7FIw05
X-Google-Smtp-Source: ABdhPJxSMI5XHorDZpXXkQ1tGzeZ3r2izwYJYzJlP3r/w9BQOGEh5JBFPIXeV7bmhh+Gg+Gi8Ic9RV+cZTSr/Wl4N3U=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr27764569edu.221.1630390753859;
 Mon, 30 Aug 2021 23:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <732a28c22fcecafa308cd9444efe9158800b94e5.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <732a28c22fcecafa308cd9444efe9158800b94e5.1630359290.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Aug 2021 02:19:02 -0400
Message-ID: <CAPig+cTG2+A0auFYdu-PHBVa1w2A5neS+6JQ5m+ADaOBq8vzUA@mail.gmail.com>
Subject: Re: [PATCH 12/15] scalar: teach 'reconfigure' to optionally handle
 all registered enlistments
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> After a Scalar upgrade, it can come in really handy if there is an easy
> way to reconfigure all Scalar enlistments. This new option offers this
> functionality.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> @@ -121,6 +121,10 @@ After a Scalar upgrade, or when the configuration of a Scalar enlistment
> +With the `--all` option, all enlistments currently registered with Scalar
> +will be reconfigured. This option is meant to to be run every time Scalar
> +was upgraded.

s/was/is/
