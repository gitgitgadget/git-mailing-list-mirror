Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBF01F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeI1FHh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:07:37 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:42356 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1FHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 01:07:37 -0400
Received: by mail-io1-f73.google.com with SMTP id m13-v6so4582598ioq.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T/mWb2pinaGr/NIbwzD2ZKk5Ez1SPU0Rj/tLu/bX8No=;
        b=VpJ0SvNMT5sZ7jv78urp+uMDizNj1JGvm79XRVZj8O8lHtyF9RptSVFs31mNQQmAmT
         m3WLZ5RB0hijH58bRF6CpI/DG6c/ei9DkVFtt8nidOlrNYZzbjbCLow8+9RlKFOWj0xN
         xIAfvzEPoC1cFK+x0hIwR/gaiuUHLWRcChnVpQ0HEembSbM/Vdlea+cOn4SyXfRxB9XA
         q4k8rNlBAlfJVec9PG8wjgbKUItT1jKCj36tKg3qOolzujxl+PAm5YjSdxATvooSGbJU
         YcILXhyVRBb2cd3/YEdX7AQV0kxuomLMZjpF5HrhLU+5bUUhoCl9S7pUcDr6lHvJvHUV
         h+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T/mWb2pinaGr/NIbwzD2ZKk5Ez1SPU0Rj/tLu/bX8No=;
        b=Pn/gItirb8AuscNENcjRaKpWtV/p4ssfkT235vzM/+mvvbx09n6rRRNTHwMWYzZTPU
         XrdRYcue7Y8K0xaDkJAKy4RL3ULPeBKoXW2yrW/wkLVLbYUMU7T4JXCiKr+8vvTPLzE4
         WpdxHkblJ3M+9Lo8+DwFiU7MTj+3IWHN/RO7SNIbfQTkQ8QxIWTtoM/0zvKLcCkMPBRx
         iPo9/PcptgVrkLB+VPyuMK8jFhaYrRK01wR85bl31SmRpQg0tFHp/s5ZTfkyaWaI/ehl
         4wmMBoEsEmuo53z1r0RN/0/6WGFI9p5A7xdJojmsWyOZjsKh88Ky/FSSHPITfH273Yno
         rFTA==
X-Gm-Message-State: ABuFfojoPBmvScWbanGUUaFoJeTis+8AGbochdVqFrHhTd2L+WymQa6z
        1/w4OZJ8v9RFHm7HxY6i9aL3ylZI0mA/V01qp2a5
X-Google-Smtp-Source: ACcGV61zym78E7p3+Woj9PBZD+2QNpWJ3dHa9tmXCJRvHpgCC2wRxFGAk+DjQQgeKklRPWl0K14lOpLoYkBJTIXQRQrs
X-Received: by 2002:a24:1382:: with SMTP id 124-v6mr518684itz.30.1538088421327;
 Thu, 27 Sep 2018 15:47:01 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:46:47 -0700
In-Reply-To: <87o9ciisg6.fsf@evledraar.gmail.com>
Message-Id: <20180927224647.111690-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o9ciisg6.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [PATCH 0/2] negotiator: improve recent behavior + docs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I get:
> 
>     warning: Ignoring --negotiation-tip because the protocol does not support it.

When I implemented --negotiation-tip, I only implemented it for
protocols that support connect or stateless-connect, because
implementing it fully would have required expanding the protocol helper
functionality. For reference, the commit is 3390e42adb ("fetch-pack:
support negotiation tip whitelist", 2018-07-03).

So HTTPS wouldn't work unless you were using protocol v2.

> So that seems like another bug, and as an aside, a "skipping"
> implementation that sends ~1/4 of the commits in the repo seems way less
> aggressive than it should be. I was expecting something that would
> gradually "ramp up" from the tips. Where say starting at master/next/pu
> we present every 100th commit as a "have" until the 1000th commit, then
> every 1000 commits until 10k and quickly after that step up the size
> rapidly.

I reproduced using your commands, and yes, there is a bug - I'll take a
look.
