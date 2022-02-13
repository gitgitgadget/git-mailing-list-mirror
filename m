Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428FCC433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 13:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiBMNfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 08:35:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiBMNfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 08:35:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327F5F248
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 05:35:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cf2so23237513edb.9
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvmnCs55amRNB9u1X44uSvj6YC4R/w9pxP+ZjX96NQE=;
        b=KI4GB3pZw1v+x0KbxcouJ3ehYhcpHgv2KfHb5DKCFZT7W3Kgqnz1RlW9Mx9idN/Vh2
         rv/gTG+7+3bTynSDmo0T3PO9qiTjP5FzYEyoU8VYmG9+ivW7h7K8V8YPWec2IjIf/5nh
         PzW0Ss1F2kZCxHqOTyZvwIontsxK9/XN5owl0X6tnMXR1O1Iz800IDdoVahIV2rWB29z
         2KGLDao0Y0i+/4ivThqKUcXigL+OFj7P9tyvgWtVwV3Wv9WkXqPb9hLxS0sv0Z8l6MJV
         AcTtGOfR9IqDJyBj/WSHD3g8m6OtFf30xgbryH0cnwIoXIFS/Ri2AKaWHFVNK4DAdCl1
         TI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvmnCs55amRNB9u1X44uSvj6YC4R/w9pxP+ZjX96NQE=;
        b=V5h/vrrjoSKO8jqOPjbJvOZu4WIrATiLKTRZjIv16qKC1ysVxm2tQyBII6u2e6gVDl
         Y1fn+Z6MjfrAcqiMh61DDiuDdlDKRAOer1VJCi7a4yeHVKQ4b/tuTvQTGjkzWgt0UiAq
         +bA9kyXFaHobS3CbBlrx5xWnno0DLi2E1ZpKszrs8N09ADMexnkEwRPxvGBnInA/PxGV
         dAjRRgvo+nN8DYKW4OEsv0VlQ8AjX/8Cj6v4NMuZTHe1S9brWyMvVSLYvE7BEjPOe+Ga
         mMqV0zgSBmGM/5qfNW+LrnjP9LNxqiVMfXuItfEYnhaSrPM85vyfu6+g27RDasCAcb/C
         G89A==
X-Gm-Message-State: AOAM5329lx3pM4Cm9tnp4bEOjtC98HaHbRU67rJACf6NO0Wf24+d0L3P
        nHAJ1o0J9jelmG7Vfl/Fq1vFVeI/B4Z3Hc7AmI0=
X-Google-Smtp-Source: ABdhPJw1UOE4I4cpwG1DS3Rvpa1R49MJbS1uiaFGISr+4SPqioo6jgpUFdge3v5ACtzm8/EfbOHG9IxTtJiaZ5OHpeA=
X-Received: by 2002:a05:6402:5307:: with SMTP id eo7mr6067497edb.205.1644759345943;
 Sun, 13 Feb 2022 05:35:45 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
In-Reply-To: <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 Feb 2022 14:35:34 +0100
Message-ID: <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 10:32 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Jan 26, 2022 at 9:05 PM Taylor Blau <me@ttaylorr.com> wrote:

> > I'm available and interested in mentoring. I don't think I found many
> > interested folks via Outreachy who wanted to work on bitmaps, but I
> > think it's worth trying again via GSoC. I can rejigger the proposed
> > projects there a bit, too.

Taylor, it would be nice if you could add this bitmap project to
SoC-2022-Ideas.md soon or at least before the February 21 deadline.

> I am also available and interested in mentoring and I can reuse a
> project prepared for the last Outreachy round too.

I added the "Unify ref-filter formats with other pretty formats" to
continue Hariom Verma's work during GSoC 2020. I would be happy to
co-mentor it if someone is interested to co-mentor it with me.
