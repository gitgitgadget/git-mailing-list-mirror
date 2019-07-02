Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FAE1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGBJUs (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:20:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44448 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBJUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:20:48 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so35326293iob.11
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJw0YjW3M8q71JC3ag7x/7BTVtruQDgvc6te/bZMWHY=;
        b=kGbdh44Nv5nSEF39o6Z6R7qlCyv5zvgzqWY1r8abGKw5vPZ5krd6FUMKhSoiqdtsE4
         8VdspH9FQjf7z/UTPngEFa/f6QHI/7lBHP8AzWO3dLZm2Gyr8MxF3QC5EjZw59g7/7QZ
         FU+No7xkFuk5smxSO9vcVDquiTYYDEkx85uw8n/Zkzq+Gkkx/JVYoiWpJ21uZXzhdIR/
         QyOnFGU33/G7AC+gHu3E3jPeFQzaWnUCeLyWDQcW0YcCKI+bbIMqipzJ/aWcsifNE/pg
         VXLZDTcjmHI5WQ/aiULVXhhLPS2sP3mScD7f2ZEb5rcmTp/Oej0JhT2vaC/3KjqupCpv
         jqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJw0YjW3M8q71JC3ag7x/7BTVtruQDgvc6te/bZMWHY=;
        b=RYN14hn4OTDlVrdOJ/dmuaCviNYskk264Zlp92yvLOUasmLthA0QHk1phXwfu3tOcJ
         R5doL0qk690i6rL07Y4t+4GTu5KaT+dQW+VvBqupAg+nC7RiSexfu0tQDGE2vm2HjMHY
         PVb35m3v+S1Jjd8apnkyutkp3HMy4ZqQj4ErhzRWNONVLCm04J9CFZMsJoe+mHbr2nm1
         EMUbHQurBJtfLOliI+k4vMTEQIO4Neb/yiuzQulLRhxwX06sjXLjyL6E3s3CSnhnFR6P
         UZYa640VO5elzSJy6Gymtlnmg6WnAoDJvF4f3tmVcxtDTSEAgXQDrjV5A6aWSeHhVAPi
         CVGA==
X-Gm-Message-State: APjAAAUNXu4kOJ7xSyt0xd2fSyJUR+eyAHVSgfq0lTFrdi83k85+BJHG
        eYZtV6hqDIIA7fjJjVv27t41v4AtkRyz54fFCd4=
X-Google-Smtp-Source: APXvYqz5nxpTYg7kDIZMWidxam4olqB+xRF3Bg1gkV8AJk7TZoow4Y0y+IGD6rnwyrlHhMb7vyGV6WEwmL+MQ3lV34U=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr36139032jaa.64.1562059247460;
 Tue, 02 Jul 2019 02:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.254.v2.git.gitgitgadget@gmail.com> <pull.254.v3.git.gitgitgadget@gmail.com>
 <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com>
In-Reply-To: <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Jul 2019 16:20:21 +0700
Message-ID: <CACsJy8Cwxov9VWq_MpeWstGtMB-rTy6LYyFj_PF9oSP0kqcDXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] repo-settings: create core.featureAdoptionRate setting
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 1, 2019 at 10:32 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> @@ -601,3 +602,22 @@ core.abbrev::
>         in your repository, which hopefully is enough for
>         abbreviated object names to stay unique for some time.
>         The minimum length is 4.
> +
> +core.featureAdoptionRate::
> +       Set an integer value on a scale from 0 to 10 describing your
> +       desire to adopt new performance features. Defaults to 0. As
> +       the value increases, features are enabled by changing the
> +       default values of other config settings. If a config variable
> +       is specified explicitly, the explicit value will override these
> +       defaults:

This is because I'd like to keep core.* from growing too big (it's
already big), hard to read, search and maintain. Perhaps this should
belong to a separate group? Something like tuning.something or
defaults.something.

> +If the value is at least 3, then the following defaults are modified.
> +These represent relatively new features that have existed for multiple
> +major releases, and may present performance benefits. These benefits
> +depend on the amount and kind of data in your repo and how you use it.

Then instead of numeric values, maybe the user should write some sort
description about the repo and we optimize for that, similar to gcc
-Os optimized for size, -Ofast for compiler speed (-O<n> is all about
execution speed).

We could write, for example, tuning.commitHistory = {small, medium,
large} and tuning.worktree = {small, large, medium} and maybe
tuning.refSize and use that to optimize. We can still have different
optimization levels (probably just "none", "recommended" vs
"aggressive" where agressive enables most new stuff),
-- 
Duy
