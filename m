Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D356E1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeHAWNU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:13:20 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:49569 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeHAWNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:13:20 -0400
Received: by mail-ua0-f202.google.com with SMTP id j12-v6so6897034uaq.16
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+LRdpvI2ZZhoRP3VsZ1rqjklFCJFYVNqWUhh/QQNR44=;
        b=qABqSK5itugKZr6Gw7w8aWsgT5fL+9Kko78Yk02UulmEmok3/RMxzrN9BCz9LMZMHQ
         ei4mQD09aATAUDA0vL776RR67KC4LMN2fBrU3YIlM0ffFy/oDIW2+DSCsIXb0R3QgFzI
         g0NXznIXkA6ClASGkMO6sezRbbA7wLaPihgwdJTs4VPFHFe3I+otpVcWL0J2P+Ze0enU
         QgTzbYLmracEIiNxrx14epsadVlgWCYQgs9SlCVahPJnrHppncXv+/cA42SFS7HM+kOU
         uioyFJOHt44WxISecRoTKgAFVTMtxjH+1WBGhhZ8oPxruZrnjyKLGX+bBB06iA+4Trw7
         NEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+LRdpvI2ZZhoRP3VsZ1rqjklFCJFYVNqWUhh/QQNR44=;
        b=sFfG7cT60f62Wq2rdjseBfQo0x/5VUa8hCcc8fju+MeNBTdXjXYfp2R43kJYbg+WdF
         2gXQ65lbDD+A+mlK/W9ZyYTqxTu+xnGEOxRoZLbLf1C1Wb9EeCRzLg3i7ppmz37+73DH
         oeCmR9SdLWNuAziipU5vfFTb9J79fShYBgml1iDCRSTF2wyWzKLdq0iaO9p8XxAl1AfH
         4G4BBtb9dubqVjgXn6KdxUm2MhbJYtcDxhNytL4iR5Wi6RZWiVeFxeFCfj/MzGzXp+Sh
         Y1ChRDj/Eg1T/nT2J2At6kUEkC1sVrkGswZMet1xoQ75y7IfYhiKkgIy41G3Wg2DsalA
         J+HA==
X-Gm-Message-State: AOUpUlEullLqRvY9cLLz4cybvqG529J0I3Z1evFkRJ92IPhBVMc76QGk
        OfY2pKlNzcrEzi+CTkGX35ETIIPS2Jh2g4K1yRy9
X-Google-Smtp-Source: AAOMgpenz6RJ7vzjNb+eA4rqvebzMWczcawjGscwoIy0qnCh/ioxSqi1mVKV1k0p7XFh0BV0XuUaZUX5S7PnPmV/+Gsg
X-Received: by 2002:a1f:7c8e:: with SMTP id x136-v6mr13462054vkc.9.1533155148474;
 Wed, 01 Aug 2018 13:25:48 -0700 (PDT)
Date:   Wed,  1 Aug 2018 13:25:45 -0700
In-Reply-To: <20180801151835.9182-1-avarab@gmail.com>
Message-Id: <20180801202545.204151-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180801151835.9182-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH 0/2] negotiator: improve recent behavior + docs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think 01/02 in this patch series implements something that's better
> & more future-proof.

Thanks. Both patches are:
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

A small note:

> -	packfile; any other value instructs Git to use the default algorithm
> +	packfile; The default is "default" which instructs Git to use the default algorithm

I think we generally don't capitalize words after semicolons.

Thanks for noticing that the check of fetch.negotiationAlgorithm only
happens when a negotiation actually occurs - before your patches, it
didn't really matter because we tolerated anything, but now we do. I
think this is fine - as far as I know, Git commands generally only read
the configs relevant to them, and if fetch.negotiationAlgorithm is not
relevant in a certain situation, we don't need to read it.

> That's awesome. This is exactly what I wanted, this patch series also
> fixes another small issue in 02/02; which is that the docs for the two
> really should cross-link to make these discoverable from one another.

That's a good idea; thanks for doing it.

> I.e. the way I'm doing this is I add all the remotes first, then I
> fetch them all in parallel, but because the first time around I don't
> have anything for that remote (and they don't share any commits) I
> need to fake it up and pretend to be fetching from a repo that has
> just one commit.
> 
> It would be better if I could somehow say that I don't mind that the
> ref doesn't exist, but currently you either error out with this, or
> ignore the glob, depending on the mode.
> 
> So I want this, but can't think of a less shitty UI than:
> 
>     git fetch --negotiation-tip=$REF --negotiation-tip-error-handling=missing-ref-means-no-want
> 
> Or something equally atrocious, do you have any better ideas?

If you wanted to do this, it seems better to me to just declare a "null"
negotiation algorithm that does not perform any negotiation at all.
