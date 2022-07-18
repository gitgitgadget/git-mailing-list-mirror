Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2987C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiGRNPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiGRNPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:15:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080A765B
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:15:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v12so15205035edc.10
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPUxFboO7IrOW2km+s0ietA1Tc1vsXBkOv14j6rtr9I=;
        b=C+p35yKLbZQppcKs3W8p27LM8Cy2nCDKmmQwa9wWY+WCKa3acBxcqIw5f+wzDngile
         EchCmnRrcHJBi69ivluh18taz83oI53Y4FV+RFXUOMigXlMgpvf8GUgEZl5Z/uZ+mtWB
         06L5JgXYMKguSOwaCURD9oxpPBhNAFFI8hu8DDoxA/YhrMLd5i6X4wMntT3cYKXvU8zP
         3LdI0BeKbI9Y9c3bE3ZIZYUm5yAtldVTITijG2+iRliCwZvcREiKl3wmaSyea3lcMVas
         neM0tiaAOALGe2S9cxWAM+ph0S2W42D6z7N86jxoXnetpazZBarTOKTIYs00y30inWyU
         fx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPUxFboO7IrOW2km+s0ietA1Tc1vsXBkOv14j6rtr9I=;
        b=WhvsG8ksznrsHRiLtQvsvq8v5VI+3w8u9UvB1kSoHxQ3GX6XMS5ctpsa3j2cEtj+K2
         onN4bLgJiNG7s1QoaA+QP/Ks39DWPl6cVD5/8gpB+CCsLav1BtlK2YvKdHw9nSf9EKnS
         IW9ZRMaYXtvHIlQrXldfLcP+dm2I5wnlt46BYKe0ioQlwm/zN7Fm1ytACZdHhUfGWlLO
         sRoS+NcfLoCF80KgeL9oF5FCk2d5zvN7pmlQaqrhfnQ2cZ5hMAKa6Wh30nLqB5AA9ZUp
         tiIDV5RBvzkfH4CFlRRYvVGQFSvtxbGH44uLA4BNFucPRbyMFdhV47zdiJzttbodQZxQ
         bquQ==
X-Gm-Message-State: AJIora+t+Ibkyjq5DZHr5gzbyizj/6lM05Tsbd8SR4teVmb66ffl8fWD
        zDg9OmphNj95ExdZFYzB1g54sOIh6Xs2VpTr93Y=
X-Google-Smtp-Source: AGRyM1sAY2/pQurAxeOQayY0TzTMp+zUUarygN+KqWhbjdOV6PbHxnqfJxqzPQU3njmfXW4oLZxSYtbNeyIgk0Sdn98=
X-Received: by 2002:aa7:dd16:0:b0:43a:e850:a245 with SMTP id
 i22-20020aa7dd16000000b0043ae850a245mr36069579edv.127.1658150130392; Mon, 18
 Jul 2022 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com> <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
In-Reply-To: <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 18 Jul 2022 18:45:19 +0530
Message-ID: <CAPOJW5wgqjN=J=+oSdz1+ZnazBGJZXtTRSWziNBZtuiUg5Kd=g@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 5:48 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/18/22 7:48 AM, Abhradeep Chakraborty wrote:
> > I just got to know that CRoaring doesn't support Big Endian systems (till now) -
> >
> > https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps
> >
> > What do you think about this?
>
> Git cares enough about compatibility that that might be a
> deal-breaker for taking the code as-is. If we _did_ take it
> as-is, then we would need to not make it available on such
> machines using compiler macros.

Yeah, we can't use the code as-is. We might need to make some
Git-favourable changes on top of it if we use the library.

I still haven't asked him about Relicensing. Let us see what others say.

Thanks :)
