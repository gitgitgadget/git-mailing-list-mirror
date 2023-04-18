Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF25FC77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 11:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDRLCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDRLCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 07:02:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3E1729
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 04:02:17 -0700 (PDT)
Received: (qmail 5188 invoked by uid 109); 18 Apr 2023 11:02:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 11:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1325 invoked by uid 111); 18 Apr 2023 11:02:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 07:02:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 07:02:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] repository.h: drop unused `gc_cruft_packs`
Message-ID: <20230418110215.GC516715@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <fa15125454bb6596adbe68689555337a42cb80b7.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa15125454bb6596adbe68689555337a42cb80b7.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:43PM -0400, Taylor Blau wrote:

> As of the previous commit, all callers that need to read the value of
> `gc.cruftPacks` do so outside without using the `repo_settings` struct,
> making its `gc_cruft_packs` unused. Drop it accordingly.

Nice cleanup (I had to peek forward to understand the mystery
repo_settings hunk in the previous patch; it is a little weird to me
that this "settings" struct exists independent of the config, but that
is not your doing).

-Peff
