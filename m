Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C771F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJCCtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:49:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46945 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:49:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id g32-v6so3206468edg.13
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFB0xyVRx7sCRVdhl0VbzaQicRtxFCImxk+0KIj/F5c=;
        b=b6c+IzeRvG6WVjWA5NxySspDrRNxcu+Xuoin5RPNPLjlk4NIIGengNqJULIxvpwvMH
         NyfFtyaTBO+kCdXmDSnCmS7rp2JIPGM8DxujOUxMnb+4p0JR/+RGy9oRf0eBbR++/LFF
         VmmO+JOZmpf3IxOLtGjEVU4HPyju7ZMnmWiTjlKJ6wf3pC4KJyaGo67dR5R9nWvzUsDl
         dwmsIMmS/GAbSbX5PP7Gqm0ZJxs9DutJy+GPionb0cB8IfZ4j1B9UCO9P0wZxjnP+xCD
         87YiVZHjMzkGrmsv2LJ2eRj1tWKwBXjRENyL/sXuKc5n8r+WUFQ0w6x9Bgl5PkXSuqe8
         +Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFB0xyVRx7sCRVdhl0VbzaQicRtxFCImxk+0KIj/F5c=;
        b=eMq0yEtUzSx7utCodKi0QGGWfC+BK/kKoo5Qu94uXnCNeIfxayFk8VOIAloxkGuV/0
         eeGXEeldc/cYchAK7jeyDQs4Yu+GyoiNfOA1qKokAwuocS0lwP8XoK737Kij+w0HYnhq
         eNYag3+Eu09g+jTB75I5+mrc/JlJZyBPiGWrcxlTvvgdHTHusSaNqCUvn5B/MB1pOSYc
         jI8aE6GDmBBlJMwdHKaFGLh7gJ9g8+8EaakUJcXS+xiphfd6j2YKeRkUBR79wnekzLV1
         +jDhF3wi++MCjx0+BXBDlC0N7hMSFKOA0QOYnPANL5bTHQFm8n8PaZCr7tcfL1OpxAim
         Kksg==
X-Gm-Message-State: ABuFfoimkDLHBQn/0wYJ1tIceCnW0+iathOUKocCONn5WUeldiMHpwPV
        0t0Zu6hsQX0zNtILUtBvTti3/MNIQuF+kp8ni5c=
X-Google-Smtp-Source: ACcGV61mjzIghuCv6R1WzUtIdX7/ksRZP7I7KsoqSmYLGDcm/Xe99+mugL3fZJWXz6zI/8/z2B+a6sM661iiO1kYCjs=
X-Received: by 2002:a50:a7c1:: with SMTP id i59-v6mr5607457edc.296.1538510677311;
 Tue, 02 Oct 2018 13:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181002200353.13412-1-jacob.e.keller@intel.com>
In-Reply-To: <20181002200353.13412-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Oct 2018 13:04:25 -0700
Message-ID: <CA+P7+xqWDyxR7jWQ-YEH2YUdCYQCg3KYpHEOnVcPY75XLrLxNw@mail.gmail.com>
Subject: Re: [PATCH v2] coccicheck: process every source file at once
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 1:03 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> From: Jacob Keller <jacob.keller@gmail.com>
>
> make coccicheck is used in order to apply coccinelle semantic patches,
> and see if any of the transformations found within contrib/coccinelle/
> can be applied to the current code base.
>
> Pass every file to a single invocation of spatch, instead of running
> spatch once per source file.
>
> This reduces the time required to run make coccicheck by a significant
> amount of time:
>
> Prior timing of make coccicheck
>   real    6m14.090s
>   user    25m2.606s
>   sys     1m22.919s
>
> New timing of make coccicheck
>   real    1m36.580s
>   user    7m55.933s
>   sys     0m18.219s
>
> This is nearly a 4x decrease in the time required to run make
> coccicheck. This is due to the overhead of restarting spatch for every
> file. By processing all files at once, we can amortize this startup cost
> across the total number of files, rather than paying it once per file.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Woops, ignore this version, it doesn't quite work.

Thanks,
Jake
