Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B8C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiA0Jca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbiA0Jc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A90C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:32:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id l68so6968514ybl.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 01:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Wb14mucS0CoBV0qiKbt/yt9dWBs86K7lq4yc+MKSJQ=;
        b=XOtFPPz49cmDtDKBG1DWSX1tzhS6Z41QhMwLZnv7OuTFQd4fX265ru9BFCDmaiLy6Z
         ez0yxCwC+70Vl8qtdoFGSWMqio3ZmE1mFlj7mpDObuaL+UeQI3uGWvgvt/FPC+/di/4i
         EU5mCRisw/4cMzw7qRLESjMnk2kAz3bBYBCChshm9kQG1loSqT1g1Z76K0fCiI2h4a96
         JSH+I/zkWxFn1eGlQYg+zSeP/IFIcGEMg6amfDGfgQ+8WX9yR7zvLpOS2081Oqi94iPz
         mlvBbsm57jk2xbUVTGZ8U0wTfVD7xfDv1hGIuGWpC9Jx+5gpgZ1PJpEyNDC0p12ql/5g
         QgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Wb14mucS0CoBV0qiKbt/yt9dWBs86K7lq4yc+MKSJQ=;
        b=vSwhX9lS/UIrCU662R+Mml3F2PJkjJcUDhTIRsSmcMO9xuIMpgNhQ9pmOiSKU2tjDH
         03Pek2V07EJJlGZbmwBAtRkLPRKv1pKf1oTjZcrzMELOYhNR3xGH95KwEPOxLfUDwIcm
         uByeziFnYhYKf+zXOIaRuWFRNS0i7yuJg4KfcU5KMvVIvS1hVq2DhPtIlzqyZNSMLefr
         pMB7iTw7haIvAE+m8Ekz/wXjDH+WR3OjS+CoyrzlqRU5m+Fr2mbE4fD7UBXPvEwdzD7+
         4bf1nE6NuUOP7opRuZCY69rI3Tep7a2RfAS0+b7XvwEtiIp5c1/cKFE6figR0CPa5pRw
         j4EQ==
X-Gm-Message-State: AOAM530d61FVlEr8swJOn11DN/zZr8X0mWtfLLTOU2/4JHUAGxjV50bI
        4SlEFCRmvSYdDKraQgLSBBgMQ6k6QSVLS+5hxno=
X-Google-Smtp-Source: ABdhPJyBLMpPKXiNkmzGs2h8fYXLTO6fAdUwciWgoEouqSNqj/bNbLm6rAvO/bOIrDNYyMcOYfgp5RH3RigRqJyu/Tg=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr4401094ybc.427.1643275948251;
 Thu, 27 Jan 2022 01:32:28 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com> <YfGpjm8mCkWIPM6V@nand.local>
In-Reply-To: <YfGpjm8mCkWIPM6V@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Jan 2022 10:32:17 +0100
Message-ID: <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
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

Hi,

On Wed, Jan 26, 2022 at 9:05 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Kaartic,
>
> Thanks for organizing this.

Yeah, thanks!

> On Wed, Jan 26, 2022 at 11:59:16PM +0530, Kaartic Sivaraam wrote:
> > First, are we interested in participating in the 2022 round of
> > GSoC?
>
> I think it would be great to participate this year, provided that we can
> come up with some interesting projects and mentors to help out.

I agree.

> >     Taylor showed interest in a bitmap-related project during
> >     the Outreachy application period [4]. Taylor, are you still
> >     interested in mentoring a bitmap-related project? Would it
> >     be possible for you to do so for the upcoming GSoC?
>
> I'm available and interested in mentoring. I don't think I found many
> interested folks via Outreachy who wanted to work on bitmaps, but I
> think it's worth trying again via GSoC. I can rejigger the proposed
> projects there a bit, too.

I am also available and interested in mentoring and I can reuse a
project prepared for the last Outreachy round too.
