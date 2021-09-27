Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC340C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6DF60EE9
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhI0A3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhI0A3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:29:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0977C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:27:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e15so69462532lfr.10
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2fzfmP8lSHPr4ka4KADs9JTkDH4PnmVWdbLcYnlAyo=;
        b=H1nReJ+vA8rskSQMaQKcG4MrGKdDvdQxFwSzwGmoqizGQ3BX6lanefpqnm3gSD60LN
         A6l8NyqXDjnXn+Yvo0aFHlKORi4meyr4E7TW0Zr7UVXx3RnTPzHi0h+ZeaRcQXKrV8OI
         rSwjWNUJC/bz4FGkLhyAPUdNoDJwhah99Zw9oxHg3cW31LztJju9s8ywTIhjN0aGHgiv
         Sdxg+wG0zauA6TFsUZ+Q8sDG0nSEgpLFuyqjFCoJnv+XAFiavnSYjEsqGFes8OvUFoFi
         cNPAJDcYqkezdPw4RW+kndGVYcEtwGiA5JaGntGx/IJZJC7XqjFm4u2x1zEs6gATsQy+
         Bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2fzfmP8lSHPr4ka4KADs9JTkDH4PnmVWdbLcYnlAyo=;
        b=E71RsYB2GNLfYCt2XT1r110JEDPhhysaGOWd93IcJ2E8SVtfnh+KtDOwztDO7YYYx2
         E63wpGWe/V/q5Ui5zAYb9GR5GBQRtEP6Hp5gPyer7hBe50jlV6IsuvhGCpGrcv+CY+8H
         kHsiVXrZhLYkY9xQ8UgQqtGwBD+v9YRq2J35cTv+gljcnhalEQCC8ebhUljQhZbYDTeW
         oRLKPPfueuVouO51A2cpic4G6hIEUHkZy9Fh03ev5hh9yGozPHAHRYkRI39TxkPe2ExL
         UCtJb2u79UiriILpKjfmFzjZdWa3Ef0YbL2a2H5jWVm8tr8dtisTIs7MXL+QOYnR6AVY
         GUMQ==
X-Gm-Message-State: AOAM530sNSkS/ByoRzCnxBIHXMN+O6wmYckoAO1ul8RDRCYi4ZbV0LNg
        olH/jqZWYzL7emvKmRglN61csweaRYeJUGkbzM67eApsRVM=
X-Google-Smtp-Source: ABdhPJx3VJZLzewW2M84S72d89Xc/R41k2EIptoKAa+9T+qrZMCBHMEDZ/zAtHFyPfO8HbKYgnbLWElBx70baHMu6mQ=
X-Received: by 2002:a19:7701:: with SMTP id s1mr21551566lfc.592.1632702458013;
 Sun, 26 Sep 2021 17:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
 <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com> <543ea3569342165363c1602ce36683a54dce7a0b.1632527609.git.gitgitgadget@gmail.com>
 <e8244ef1-dbd3-d56d-b9db-1e67114538fa@gmail.com>
In-Reply-To: <e8244ef1-dbd3-d56d-b9db-1e67114538fa@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Sun, 26 Sep 2021 17:27:27 -0700
Message-ID: <CANQDOdfN9y+iVS=KuWkcVaFkOoeWPT7ACQWmmgxe=uxftduq+Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] core.fsyncobjectfiles: batched disk flushes
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 8:15 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 25/09/21 06.53, Neeraj Singh via GitGitGadget wrote:
> > At the end of the entire transaction when unplugging bulk checkin we:
> > 1. Issue an fsync against a dummy file to flush the hardware writeback
> >     cache, which should by now have processed the tmp-objdir writes.
> > 2. Rename all of the tmp-objdir files to their final names.
> > 3. When updating the index and/or refs, we assume that Git will issue
> >     another fsync internal to that operation. This is not the case today,
> >     but may be a good extension to those components.
>
> The 'we' can be stripped because only point 1 and 2 that are
> subject-inferred, so that subject needs to be explicitly mentioned, like:
>
> ```
> At the end of ... <snip>.:
> 1. We issue an fsync ... <snip>.
> 2. We rename ... <snip>.
> 3. When ... <snip>, we assume <snip>. (stays same)
> ```

I'll fix this in the github PR so that it will ride along with any
other re-roll.

Thanks,
Neeraj
