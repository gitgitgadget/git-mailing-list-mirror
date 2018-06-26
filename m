Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EB51F516
	for <e@80x24.org>; Tue, 26 Jun 2018 00:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935024AbeFZAiE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 20:38:04 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34568 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934992AbeFZAh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 20:37:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id n187-v6so1988449ywd.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 17:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdsMP53d6YVKKsdvEZfUK9RO5uHeBeFk50wMVLdNWic=;
        b=RF2p7KNEBoWsA+PFb7apig/3D+RtaFITei65ajjzB1i9Y6VKurVQBKyEjzEbE4H64a
         mWXLRtEtZ+WJPFwOeMJMtVRHp5G1E3jYWZEXqvovtnCLxptCR1ks7mo12Y/bVs5dYc0/
         DPsc/74O+vmQwaoluOtXVIr4Hv3ZenT7U0RD1XE3iQT8wNA7/guqXk9d/ThtRfVsFGoT
         Q6FHNyo2XYiR0Litybfns2GRHgvGcJ9RaeNCIV4L7hjik8eIhkMk8HX+SC38f3hI0yiM
         28ITKt2H0pnuJ4gFujcLgN+50beMyDotzhQ9rrqegQp21NkPc3gPVFDy0uidkcX1+MzI
         1ylQ==
X-Gm-Message-State: APt69E3ewD4D/eFMfL1+UK+jsDvkYfRxQFGVpnICrjy235Vcxn+wai/o
        GMBK/WmhqrKN8QI7vv3pdZGPJtVtYnutoA/8LM8=
X-Google-Smtp-Source: AAOMgpfl1Oy1z2xL6QJxQjL2kaK2KHZ0L0A4/iAlik4hhXTjCZU1+1GbLrurHIrzA69ho9nySK06Yg8oyO9Vcg+Ql3M=
X-Received: by 2002:a81:7b42:: with SMTP id w63-v6mr2146059ywc.70.1529973478281;
 Mon, 25 Jun 2018 17:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180623121846.19750-1-chriscool@tuxfamily.org> <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Jun 2018 20:37:47 -0400
Message-ID: <CAPig+cTaxJ2fAXaXdQUNSWE7ehyROM79YL6wsNpnf1PuMoaxdA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Introducing remote ODBs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 5:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> > This is a follow up from the patch series called "odb remote" [...]
>
> 5702.20 and 5702.21 seems to fail in standalone test, when these are
> directly queued on top of Git v2.18.0; I haven't looked into the
> failure myself (yet).

In addition to the t5702 failures, I'm also seeing failures of
t0410.1, t5616.6 and t5616.7 at the tip of 'pu' as of [1], all of
which seem to be related to these changes.

[1]: https://public-inbox.org/git/xmqqin66mql6.fsf@gitster-ct.c.googlers.com/
