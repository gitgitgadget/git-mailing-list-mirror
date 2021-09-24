Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D6AC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE0A61076
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhIXVtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIXVtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:49:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ABDC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 14:47:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b15so44967271lfe.7
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wm78EGS4iBNUi1mhuoRep/+RhlEcwqE8GtzPyg8w4ao=;
        b=QJHsxHjBCGoqalJMziHAaxMgHQ0cD7eD4NIezZK/eX/qzZZTmCJIfPEYsboEynLmG9
         zU2FwOcWfjwE7wX/HWh4oZzscSAeM5PpA/sktSbizHeSUGCXW/KVZ7WgWDHpxhOtlFuD
         iD+PnikSdSLnOYnulvO499OZlCwehWTtkpNddGDmTPncyxLNbV7cqYQlrIkS1QXaI9DU
         SqdwnjUQpze07/TlmokchcjyzV+4cjVBLRB+Z5V6RduRfvVNDQyC2+QI+HnJ99lC37+z
         RUV9R9Wostm4T6wufJ33X6z5M3TE+AOP3DCCt5TaMWIpGJKeCs5r1QqfVJDIP+xquEKl
         KyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wm78EGS4iBNUi1mhuoRep/+RhlEcwqE8GtzPyg8w4ao=;
        b=CkWnEiozA0B8w7StVRbSksL2Szy8cxvNagUdk0k2EdVX1WoY1VZQVI9W1l4OHTnJpv
         4BV93r+WHRAnHbIilsCirU1C6SwCCj3h9OKqD+G2LQMk+o2pcpN59meMgBrKo00Ije2n
         GbN5+NfA9L7xEePCBDllkaTMRaUCgrMT8/KETIfxa/NAVSQ+gg20vHbNCM79J6rJishn
         ehXD3Aj/I05mtJJ5IY943TQWAzn3tM+l3WZ+isDc0qj8FpXBn/zW5MXQySP5TV4ZAU73
         F629X56uC1FfgAyht+p2NZUHUc1RO5DZUORs1CEIACjs0diTnSmmDxc8iBrOW4Z8XTB0
         SZSw==
X-Gm-Message-State: AOAM530lM8/QvdZl1xIxcPHhvFAkoI7TT12O2rVSAlm0p7drDHEm0vqg
        kB79fWd39ZySrjolmcK57Wjo+b34AvZNGQ9icu1Ei3SgWPc=
X-Google-Smtp-Source: ABdhPJwQ5VBdZsSlJAjJS86hrOULvn3OryjZKasjOf2XdFhKa+YjXIjxHUU7JPFidzaATTxbaCDehEvCGqxvGModhyo=
X-Received: by 2002:a19:7701:: with SMTP id s1mr11443764lfc.592.1632520050705;
 Fri, 24 Sep 2021 14:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com> <fe19cdfc9305a54b40b9979842d0d1d7c7dfb828.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <fe19cdfc9305a54b40b9979842d0d1d7c7dfb828.1632514331.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 24 Sep 2021 14:47:19 -0700
Message-ID: <CANQDOdfCgdBDE3oJ385WFWQ_in7J5xe_UwkQ5BVaxgkCw15xvg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] core.fsyncobjectfiles: batched disk flushes
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 1:12 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Neeraj Singh <neerajsi@microsoft.com>
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 2244311d485..9d9897cf037 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -678,6 +678,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>
>         if (chmod_arg && pathspec.nr)
>                 exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
> +
>         unplug_bulk_checkin();
>
>  finish:

I'll remove this stray change on re-roll.
