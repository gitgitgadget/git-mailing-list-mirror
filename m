Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73FCCA480
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiGLHM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGLHMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:12:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100097497
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:12:53 -0700 (PDT)
Received: (qmail 10519 invoked by uid 109); 12 Jul 2022 07:12:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 07:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27889 invoked by uid 111); 12 Jul 2022 07:12:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 03:12:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 03:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
Subject: Re: Why is reflog so obscure?
Message-ID: <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
 <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 06:55:09PM -0400, Thomas Guyot wrote:

> The reflog is simply a log of where you've been, in descending order (latest
> entry first), and is branch agnostic. It show every commit you've been on
> from latest to oldest, and each entry can be heads, tags, or detached
> commits. Some operations like rebase may even generate multiple entries if
> it's done in multiple steps (ex conflicts resolution).

This is right with one caveat: the HEAD reflog is branch agnostic. But
there is a separate reflog for each individual branch, as well.

-Peff
