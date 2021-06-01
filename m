Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A97C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFCF61396
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhFAP5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:57:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43314 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFAP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 11:57:00 -0400
Received: (qmail 28422 invoked by uid 109); 1 Jun 2021 15:55:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Jun 2021 15:55:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11692 invoked by uid 111); 1 Jun 2021 15:55:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Jun 2021 11:55:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Jun 2021 11:55:17 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2]  [GSOC] cat-file: merge two block into one
Message-ID: <YLZYZS8jBiOJynbz@coredump.intra.peff.net>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <f02c1144d916bd36bd32069e439cfc08b2a7898a.1622558157.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f02c1144d916bd36bd32069e439cfc08b2a7898a.1622558157.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:35:57PM +0000, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
> 
>  Because the two "if (opt->all_objects)" block
>  are redundant, merge them into one, to provide
>  better readability.

Funny indentation of the commit message. :)

I think this is worth doing, and I agree the end-result is easier to
read. Really minor nit, but I probably wouldn't have said "redundant"
here. The conditionals themselves are redundant, but not the blocks.
Maybe: There are two "if (opt->all_objects)" blocks next to each other;
merge them into one to provide better readability.

(not a huge deal, as I think seeing the patch helps explain what is
going on. But again, just trying to offer polishing advice for future
patches)
