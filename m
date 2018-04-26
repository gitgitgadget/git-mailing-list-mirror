Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE791F424
	for <e@80x24.org>; Thu, 26 Apr 2018 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756641AbeDZWIK (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 18:08:10 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:37873 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754841AbeDZWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 18:08:09 -0400
Received: by mail-ua0-f177.google.com with SMTP id i3so7004885uad.4
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dj/79urgQDxmmh2z2BlRWWBtPMY404nbEoAyI8SKffg=;
        b=Gd6biIAihtHLoi/PQtVHp+HtiBstigtSHs2Gm6V4HGlxqf1bNUjdDYCYEIy9dkgWbW
         rKKX1GxxuuboIOzSpge6V8B4OklQdTz3wFKKyZT1VZqU4yWRj8D9AncfomR8Rek65YBR
         rwR+aLZ2OGd7vHBe6QVWaAmIg9VD/L/MUaUPKtfZSOQyD7P1htGvIB9QZT+xO9ul0l0p
         pLMoAbJB3DdyJFWDWm32JhW1tvWTOaVl5jts5/pFNwW3g2GFgAvx/NuwK3IMDi1AEqv/
         PJQXydTEHw2Zhsw7oARIR9sdOjW6aG/BcLKj0hYUYxcVJPm8k/dW3ySLFJzd4wA8xiCV
         be4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dj/79urgQDxmmh2z2BlRWWBtPMY404nbEoAyI8SKffg=;
        b=LTY0CMqAagGeHzo5uAjIwk9G7gZ2rX2L44YfVo5C09FbXcVnfV9cun0fM0UXnavcx6
         SKXDVkGnnR6Ghd6AOag/y7iJwzIFGbdrjqyZoH7wHw5khd/2Q6QMHQAqZPXQaHFVmzyj
         dc+Y2MezHuZrQWx7Pg0YiITg/5hXmtJOqm0Tv7dZv/IXWhCv3yVPWfVcPtzHjROiiP7u
         n+/wxKKbmdP58gbB2CO3Xskge2JVXww4wA4mMOta0IYXjBOofmok3HY20tJvqjtPTtUD
         98qdNKPYLlHZg61/CVY8+ROgvTISHegzMB/vl882MTkZATwXXmxREacLkLw1tdyc1AXr
         Ymbw==
X-Gm-Message-State: ALQs6tBmaCLgfL8uuV+pArxK7eq9Fmus3btCfUbHSJqIr7fh+kAmru5n
        TH8SuxYNUG9B8ahGvO6PyIEJL+zZ/kboKek6E/I=
X-Google-Smtp-Source: AB8JxZryIEI+k6DauldinnW+ryIxgc9vtKrItJYIvlgCzm6RvL1TzEnSTMfLBP2l4db5cOz1I49M8/jMyVipnmiCP8E=
X-Received: by 10.176.21.232 with SMTP id j37mr2142546uae.199.1524780488315;
 Thu, 26 Apr 2018 15:08:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 15:08:07 -0700 (PDT)
In-Reply-To: <20180426205202.23056-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180426205202.23056-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 15:08:07 -0700
Message-ID: <CABPp-BFh=gL6RnbST2bgtynkij1Z5TMgAr1Via5_VyteF5eBMg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> This is a complete rewrite based on the feedback from earlier patches.

Thanks for pushing forward on this.

> Update the documentation to better indicate command line options that override
> various config settings related to merge.
>
> Add a new config merge.renames setting to to control the rename detection
> behavior of merge.  This setting will default to the value of diff.renames.
>
> Also adds logic so that when rename detection is turned off, the aggressive
> flag is passed to read_tree() so that it can auto resolve more cases that would
> have been handled by rename detection.
>
> For the repro that I have been using this drops the merge time from ~1 hour to
> ~5 minutes and the unmerged entries goes down from ~40,000 to 1.
>
> Helped-by: Kevin Willford <kewillf@microsoft.com>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>
> Base Ref: master

We may need to figure out how to coordinate amongst a few topics.
Looking over your patches, there are going to be a few conflicts with
en/rename-directory-detection-reboot, so this won't apply to pu.
Martin's series to introduce clear_unpack_trees_porcelain()[1], which
he was waiting to submit until mine went through, will also conflict
with this, if he uses the changes I suggested for the handling in
merge-recursive[2].  These aren't major conflicts, but I'm just
flagging it.

[1] https://public-inbox.org/git/cover.1524545557.git.martin.agren@gmail.com/
[2] https://public-inbox.org/git/20180424162939.20956-1-newren@gmail.com/
