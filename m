Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBB8201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 22:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbdF3Wlg (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 18:41:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34458 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdF3Wlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 18:41:35 -0400
Received: by mail-pf0-f180.google.com with SMTP id s66so73327610pfs.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WlvfGAkdQTGvzzygyRG1QRLMyPSDAhKCNxJLluUca/M=;
        b=fJ2w1aCWZtCQkdmmHIudUnpprDPRu2SSG5evi2Qt0IWCTWLV6Z43uiZS4tiwgVZjtl
         I7j9DJ8JogkNVPl6tx0g7r5iJs+AMA7ejJ5gNG6BIqAc6XYf1SMH+mu3C/NjXnGjb5kh
         ++1/f9mT+UDOuwry7ufcSUSQu8PeQ7egvJI3SAzR2CqoLmeT7uNjRKmwL/7jOCfebCSQ
         k+Espzd6Kt0s1hEat7ZibPWhCS+Sk0fEqxdon+1AhFK+vFULgm2g8POXRGTfE+/RVM+Y
         WoP/+/6v2hLvYPA/3LyftHmJjupGWNoxuknQ1OHV4f0TgZAxHUQG7PCpIXgRvP1+SaQz
         PI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WlvfGAkdQTGvzzygyRG1QRLMyPSDAhKCNxJLluUca/M=;
        b=H6k8U6o55WuLbzjTDteShO2WvR/gr5lyM6rAbJarA0QIgZv47nh+nNjyQx0fxkWDYv
         NugHi/JH+dSwmwEwIX8tiWdXMhpr9WVcfcx7U6t0s5/MOXTDBVuGYUUnZfs4DzJPJDfU
         u5McUVWx3QrpST9fBLg+PojD3sz3mD+tQXfmneuoBRoCp11DIFleY7rS/7O8ngs9i549
         CLGZlPa/yc/Y1FcbsBJ3bEihbmzbSc6PVTUXE3lLAuhUugVy27FkWJRdqui1n31TPj8D
         x4ONyaTg6fyi0adFspn/xFSLBuw8uiIHgVuapJ9B5Xy9leImrdrOv8T/FBMLxBallAmN
         tzuA==
X-Gm-Message-State: AKS2vOwHeNQ6YcWQTRwY1Rfd0I0PxtIoGbtKf4+f8TaA8AN0TI70LTG2
        1yxQlnYjR6nqQtH2418K0kR1Ug9Abi7E
X-Received: by 10.98.69.76 with SMTP id s73mr24300622pfa.94.1498862494730;
 Fri, 30 Jun 2017 15:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 15:41:34 -0700 (PDT)
In-Reply-To: <cover.1491851452.git.jonathantanmy@google.com>
References: <cover.1491851452.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 15:41:34 -0700
Message-ID: <CAGZ79kYdydHLxuzDcfyiahbfszoAGoyVsb4VjTAiC8ATDyLMxA@mail.gmail.com>
Subject: Re: [RFC 0/4] Implementation of fetch-blobs and fetch-refs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for not paying attention to this patch set earlier. I missed
(and might still
miss) the big picture(tm) here. This is because
http://public-inbox.org/git/ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com/
seemed to be specific for big binary files, but ...

On Mon, Apr 10, 2017 at 1:46 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

> In particular, patch 1 demonstrates that a new server endpoint that
> serves refs without the initial ref advertisement can be done in 228
> lines of code (according to "git diff --stat") while accounting for the
> various special cases that upload-pack imposes (stateless RPC, inclusion
> of an additional response when depth is requested, handling of "done" in
> request, sending a packfile directly after a response containing "ACK
> ready" without waiting for "done", and so on).

... from looking at the patches, this actually implements the idea
that was thrown around on the mailing list as "client speaks first",
as this essentially omits the refs advertisement, and then continues the
conversation by running upload-pack as normal.

That seems very exciting to me!

> To that end, I'm sending these patches in the hope of showing that these
> features are useful (omitting ref advertisements help greatly when
> serving large repos, as described in the commit message of patch 1, and
> serving blobs is useful for any fetch-blob-on-demand repo scheme) and
> that my proposed way of implementing them can be done in a relatively
> uncomplicated manner (as seen in these patches).

Yes, if we encapsulate v1 protocol on (both?) sides, we seem to need
very little additional code, but get the benefit of using lots of well
tested code.

Thanks,
Stefan
