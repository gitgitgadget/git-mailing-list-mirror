Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9853E1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 21:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBCV2Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 16:28:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36801 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfBCV2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 16:28:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so7259906qkf.3
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 13:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDhSRk3PZ+rSJAGEvDH2lqk0p0/Ir9UP2glVvpShcro=;
        b=KEksrNIiwaMYombV/aQiv0Kj4KE0KpG5U/SXcxWa7XVfo9560BiYFiLFjIto7hjXNE
         NvJDeepT/01l9mRoFKOxPlUqnROhiFZoqOb59F9nBjqD+t6wgqgGMrWE20U5deWjOAbT
         zvfEJD/2c3QURspCvmKhpfCLjGCS/plNSwZZGWj7+qmbxc0NjWy9UXFcTk5gvavF+dkJ
         HM0kFHfGP63ojY385RFxRqBSRD96SNfnrdNxorvZLd41dBgnalLJRVE6TMn4ZjfJBW+W
         uVIVG2mSBxOG1cKsNEtvXpc0SaHhEbINetOqwjlw/sJy3uzizgQvbEprVQ4aMwX59IYM
         nwiQ==
X-Gm-Message-State: AHQUAuaWmmnoVSvs8xm3mK4TwuanaKHApN+8WAfC81DY9rhPWk/lWe7p
        7Zczx/YfU3CWnEYjvrifnouNAkp8pXxie8X23RM=
X-Google-Smtp-Source: AHgI3Ib3DkgSvy45uLNufIYVpIpeyv7LWL9jcvYkIpHygn2Y+IM5gST4Bcw2SkxVWWz2nmfe7bz2NOnueNnNh5Uvj5s=
X-Received: by 2002:a37:c8c:: with SMTP id 134mr3578599qkm.152.1549229304202;
 Sun, 03 Feb 2019 13:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190203210027.13272-1-svenvh@gmail.com>
In-Reply-To: <20190203210027.13272-1-svenvh@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Feb 2019 16:28:13 -0500
Message-ID: <CAPig+cQXuzMwZjHa3n+DwRFL3E76U8uAvhiFiC5S=B23f03Vnw@mail.gmail.com>
Subject: Re: [PATCH v3] git-submodule.sh: shorten submodule SHA-1s using rev-parse
To:     Sven van Haastregt <svenvh@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 3, 2019 at 4:01 PM Sven van Haastregt <svenvh@gmail.com> wrote:
> Until now, `git submodule summary` was always emitting 7-character
> SHA-1s that have a higher chance of being ambiguous for larger
> repositories.  Use `git rev-parse --short` instead, which will
> determine suitable short SHA-1 lengths.
>
> We cannot always rely on successfully invoking `git rev-parse` in the
> submodule directory.  Keep the old method using `cut` as a fallback.

Reviewers and future readers of this patch are left in the dark
regarding the circumstances in which git-rev-parse may fail in the
submodule directory. It would be helpful for the commit message to
explain this potential failure in enough detail for someone working in
this area in the future to understand any implications of changes to
this code.

> Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
> ---
> Differences since v2: Simplify code as suggested by Eric
> Sunshine <sunshine@sunshineco.com> and suppress stderr.

This version looks better. Thanks.
