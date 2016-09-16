Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5087F207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756293AbcIPRfv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:35:51 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34284 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbcIPRfu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:35:50 -0400
Received: by mail-yw0-f177.google.com with SMTP id g192so93440553ywh.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k4X0ieaecwXrg0FQg1ybblMX2/baCQyWMCdoqErh4wk=;
        b=QooqgcFtcw9pOZljHKwzo3IDNTCOael3v19ONkvuNjvYb98poyxX9d6n8LSqp7J3nv
         m3mMzUe4cWcQArUfAoTerV/IWVyqJLijPBy3P1OlCIMsQKa/Fuhp39dpvcdr+DcnBmuO
         VVS+hOpnKH8gNUZ/2bilHsqNTeWrfInBPxBlHhi12Rhp9AX6+wloHelnKhajMQSGSs4j
         vQODVPsleIEzGRxjkDkrKE9kJJHQuljHtEc3emX7yLbk9y/sHTd5y/hrIQ+ATyKWYfAe
         MOPR5e3iLf3AFNdIdE4oU3ubSRWe6Ktye3Ly+or2Dkf1+ZUSm7AvW55cUsAPLhiWOgD6
         xvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k4X0ieaecwXrg0FQg1ybblMX2/baCQyWMCdoqErh4wk=;
        b=PnkNZBIgZapOrTZrvn8Qy77+G1UAcv09e43pDAWrgE4hyZvZSO8aMm+L+ViBp7w9oA
         1S+C1/H3qRyTLGIgFcmIJHyXqjbZNsOYvOhaRPStwYeFS2vE+Tnks6ddyHSizu9F4Czl
         b+hQEWVLxtQS+EzfnxCLgHiU4rPsN8Mbt1LtOC2bSf+BeFDt6N3DvnIbQZGsa2gutLEb
         YJPE9FNkVQebUrLD3Bg8KRrEFXYrtbrmETJCmrcEhr/Ng7SlhZARcZF1NsQilXCkXvT8
         6WpTqSUvqLRPlM2QJNeJDM8jgDbfQU11mlex3cVZAODAfSDoWLqTAtBUfJPDNiy1Wj47
         Y6DQ==
X-Gm-Message-State: AE9vXwOcPUN27CM/dx/K7dO3o4EtxJ00RSAoKyuqXWq2+eRZCKcSN2L4RZ7qi/ZrFlZv9m+Ts79hce4mn7pdKg==
X-Received: by 10.129.76.6 with SMTP id z6mr15203082ywa.257.1474047288497;
 Fri, 16 Sep 2016 10:34:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 16 Sep 2016 10:34:28 -0700 (PDT)
In-Reply-To: <28c5d2c59851279858df22e844c6ff7c09f33199.1474046573.git-series.josh@joshtriplett.org>
References: <28c5d2c59851279858df22e844c6ff7c09f33199.1474046573.git-series.josh@joshtriplett.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 16 Sep 2016 10:34:28 -0700
Message-ID: <CA+P7+xo5vijUhWvoM4q_sW5Ps4rii7=wFBREP-Q_bn+mBTbCiw@mail.gmail.com>
Subject: Re: [PATCH] format-patch: Add --rfc for the common case of [RFC PATCH]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 10:27 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> This provides a shorter and more convenient alias for
> --subject-prefix='RFC PATCH'.
>
> Add a test covering --rfc.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>
> By far, the most common subject-prefix I've seen other than "PATCH" is
> "RFC PATCH" (or occasionally "PATCH RFC").  Seems worth optimizing for
> the common case, to avoid having to spell it out the long way as
> --subject-prefix='RFC PATCH'.
>

I agree!

Thanks,
Jake
