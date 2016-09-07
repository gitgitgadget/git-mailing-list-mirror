Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465E11F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbcIGW2d (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:28:33 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:33915 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbcIGW2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:28:31 -0400
Received: by mail-yb0-f172.google.com with SMTP id x93so10945259ybh.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ho9owuUoO3wJdsnt0SgYZ4X+aRutTdFzHucpaMGoP1U=;
        b=QBgUM7pZRNxH9E3sxq/ItsnLNWNNxVIZoxaQIAxWF7RElLVxsFHMRFgXJNW4I8yXoj
         8j/e4iQGU5u1SN+UxTOF0/hWQ0/wYJVhKUo7UofFayKCrRoE0Q28YTevjg0BHat2zvAg
         ZcZXUofGextvkcLCTzMsGB75n2jMSuO0I4CybcFp8+yDiDh2vgmhvu8eS4mK51i0G+Hb
         wz+0FqU+kjYakepApxliE3H2zENDkDQau5e37J6oOlwyE0kXRx7oNmslba/aMAKZ6ssV
         QIHFsVxbZGX9dXvbny/VtiQkTIwXZTke0tzCNBohBH+pzKXz69dsKGZv37QMslt5iTxE
         MUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ho9owuUoO3wJdsnt0SgYZ4X+aRutTdFzHucpaMGoP1U=;
        b=ZKRHyVuY+hHAXyB+4RlJPEjOk81cQLaYspJSVewGeW/HhEhGpDyrROBxaghH52pOb8
         e3ew5B7WN7bwW73v70lWyQX3Mvq8F8ibN6rfPYBquG/UyHmeL6fjgHVpuaSQ7pbuU4rN
         vk1GQYxGQ1o9a2Xw7ZZLFLJW7+RCpyU3//pH3DXkCRld31YpLGzwqDTraSEmw9y5Hd48
         oJ4jmlne1AfCwmWUBc36rtlX7LzHt4N3sjcjR3bJD3vgt5DOjO4RfzCGbPuvQsZJB9se
         +tc2OxFEnHI82JAtoOEyDgt71hHwyrFVrtoTimEHCkr5B2wlrHxP8/1Vf0BtsnnBfOzD
         Srmg==
X-Gm-Message-State: AE9vXwNyuGrAgegQBkIa+O5wc9xLYUDPx0AfU8FT0uaw5JNzLS6TTFexJnof/ogXrPfmoD+8VRit+1c0kiSj+A==
X-Received: by 10.37.25.7 with SMTP id 7mr6603808ybz.20.1473287310988; Wed, 07
 Sep 2016 15:28:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.211.202 with HTTP; Wed, 7 Sep 2016 15:28:10 -0700 (PDT)
In-Reply-To: <20160907220439.ukbqnj5biaro2lxv@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net> <20160907220439.ukbqnj5biaro2lxv@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 7 Sep 2016 15:28:10 -0700
Message-ID: <CA+P7+xr_GqU+v6RevEuqgNK5Kui=izRwD2oPvBh-4NzAp10uOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] patch-ids: use commit sha1 as patch-id for merge commits
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 3:04 PM, Jeff King <peff@peff.net> wrote:
> The patch-ids code which powers "log --cherry-pick" doesn't
> look at whether each commit is a merge or not. It just feeds
> the commit's first parent to the diff, and ignores any
> additional parents.
>

The subject here is misleading since it says you will use sha1 of the
merge commit ,but instead just ignore merge commits and indicate they
have no patch id. I suspect this is because you switched
implementations part way through developing this.

Thanks,
Jake
