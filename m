Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFDCCA486
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiGRI6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiGRI6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:58:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074B192BD
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:58:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m13so4157386edc.5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX2Xgf7dmaf09jJXY32AmeguNoN7BD923TpHM9hMBCA=;
        b=RUzcPcX6vTOFH7xioaLC4GDGwrvq+mxYcRfRd9dz84zms/e3IELXCwjo6aZ+hOrvl9
         pE3n+IbT9HOtOkqdA5QEMKhebP6/E0kLb9sEi22RTqbvqnjh1/rnO0B48DWuDXIcy1Kz
         2n7/UsXKRJpD1VFgyfJqZMtQ73svvn9tZ78PnRCREyjl7hpYRxAcHxysR8MMHnkNGw2s
         wbOzI7xU8F9tGcBlDGd5PM6nBdYbzWjWklCelTpDXHeSAZ+zgnvColil3NGLc4ZKeEaV
         PEAIgscetEvV/JFp24r0NiBz1C74noJPOLxWBuxe9abT/60pMxvhp5fOlG9oE1j1QVgU
         PDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX2Xgf7dmaf09jJXY32AmeguNoN7BD923TpHM9hMBCA=;
        b=tVfmwn6l/LF6aMiBXPxV+ckQe7/kpaX7hw5CUvhp7WiOwyeMCTzqb5196PHOw537IS
         7We817moiJU7F/5S/piQZcbZIOl9ehZTJccuwTvIDKKuIVqEVC0oDCqknP/qSxLAHoNb
         gc/jqOEZlHPjqyAAt8ujVZX6s4pOY59tb22vrqjeYLYBL6UIn15DAa35qP7VgI13Zg6K
         274EkWllamm1N8VyHCZ2xwQT5Ys4hwHNiTgprGdqMAZtPQCyf+/7spNjvNBKXNFbQAS6
         fW1If8/CLDfqi4IHzDd7D4yrt+I38vyLgOEAidmI5ocsbev7ZakRRBPL0GYgLotmie6Q
         2Iqg==
X-Gm-Message-State: AJIora91FTqNk2bddVH9PyKyUK3cHAiEKusAB++rOyOof2pPzqEMf90r
        KrjXozBuE7y3L505XD86L/BKLPBeCnuEq9lQg0U=
X-Google-Smtp-Source: AGRyM1ux5qhGybnQNGYWfbrwtYvqw5i3EQkZcIE0VofoPYpMn6aF7JDdyOt2Cq7n8WaXo/bEHS+l3ixVarj2J4tN8c0=
X-Received: by 2002:aa7:c98b:0:b0:43a:944f:5db6 with SMTP id
 c11-20020aa7c98b000000b0043a944f5db6mr35970278edt.34.1658134691260; Mon, 18
 Jul 2022 01:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <220716.86y1wtxhok.gmgdl@evledraar.gmail.com> <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
 <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com> <xmqqzgh7v1q3.fsf@gitster.g> <YtSMVcc59LP1j+Ys@nand.local>
In-Reply-To: <YtSMVcc59LP1j+Ys@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 18 Jul 2022 14:27:59 +0530
Message-ID: <CAPOJW5w+6jaHJe8FBVzjAfRBATYuV=+uv4HeA_fpRKFbRtKXcw@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 3:55 AM Taylor Blau <me@ttaylorr.com> wrote:
> > Assuming that we can clear the licensing issues (or we can write our
> > own implementation from spec), how would the transition plan look
> > like?  Does our bitmap format carry enough metadata to allow
> > existing clients who never saw anything but ewah bitmaps to say "ah,
> > this bitmap file uses encoding I do not understand" and gracefully
> > fall back to not using the bitmap?
>
> Yes, the version field alone does this, since the existing readers know
> to ignore a bitmap whose version they do not understand.

Yeah, the version field itself is enough to do this.

> I assume that Abhradeep will want to pursue some format redesign as part
> of the transition, though, at least to see if changing the format beyond
> a version bump and new compression scheme is worthwhile.

I haven't thought much about it until now. As far as I think we don't
need Xor Flag anymore.
My primary goal is to implement Roaring Bitmap as soon as possible and
perform performance testing. If the performance tests give good
results, I will think about reformatting.
As far as it seems most will stay the same.

Thanks :)
