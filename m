Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8B4C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbiBQRNi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 17 Feb 2022 12:13:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbiBQRNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:13:37 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD71C559B
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:13:22 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d187so199814pfa.10
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KiXlH7DvVhBsR2hcqqhHFPhCQNuRVR6EgaJvsaDC8tw=;
        b=y/BEMPRTy52WotsxJiFip0+rtMjtnn2Zqy51KrZWrpw/f7WSOzGVS/nlxX2pCsnryx
         wM7qaj544cQgWoAZl6srx2y+/+6N/mTO1Nmh6UPpcUNcI9jc32SX+6eNVYvhUFhdM+cV
         InqA0MX8RIoJNTug55ni5jsR1KCUrSnj7lx+IC7LyyoSPMwL6dG6BF1GBb8bpDC/xtBv
         5WmP5OdRytN+yJbsrscx08esuntzL9o5QCYS5MLutSgdsAZe5xIHNxT09s4wEOEvYphO
         AU/nN/9X+FVG6+B24Vc1fiYXcNrNe1lCq/fB/1MczT/C8ZiLW+dptcNNJ5OcsS3gNHWA
         4r4g==
X-Gm-Message-State: AOAM530gCQTOzJeHQ/ceV0JbqRtcwuelfCqVLiO7Nyc4Wzes/Oziq7Zx
        KFdElsvXa2U65ThKsAtfjqGKU7bN1q8+FHWXz8J3FnLAEG4=
X-Google-Smtp-Source: ABdhPJwTaP/BHICwaHC0p4jgzgBsI5LgaUmPfBVR+9J3b3U0bzYlOXdhpjZrLwVnzLb2E5TJpsGmDUbAmlKBRBW1X5M=
X-Received: by 2002:a63:1415:0:b0:372:782a:6039 with SMTP id
 u21-20020a631415000000b00372782a6039mr3154060pgl.227.1645118001778; Thu, 17
 Feb 2022 09:13:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g> <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
 <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
In-Reply-To: <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Feb 2022 12:13:10 -0500
Message-ID: <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
To:     Erlend Aasland <Erlend-A@innova.no>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 7:51 AM Erlend Aasland <Erlend-A@innova.no> wrote:
> > On 16 Feb 2022, at 20:03, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Patches implementing this behavior for `git branch -D` have been submitted previously but were rejected (if I recall correctly) since "delete" is a destructive operation, unlike other cases in which `-` is accepted. A relatively recent submission and ensuing discussion is at [1].
> >
> > [1]: https://lore.kernel.org/git/20200501222227.GE41612@syl.local/T/
>
> Thanks for the heads-up regarding previous discussions, Eric.
>
> Until now, I've just been using the @{-1} notation, but - is very much faster
> to type ;)
>
> There are no new arguments pro this feature, so I guess the conclusion from
> 2020 still stands :)

Perhaps. Perhaps not. I may be misreading Junio's responses in this
thread, but it didn't seem like he was necessarily opposed to the
change. A documentation update as in [1] would be a good idea, though,
if resubmitted.
