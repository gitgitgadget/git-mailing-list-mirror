Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27EC64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 02:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBXCNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 21:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXCNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 21:13:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C6A7286
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 18:13:44 -0800 (PST)
Received: (qmail 1878 invoked by uid 109); 24 Feb 2023 02:13:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 02:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28161 invoked by uid 111); 24 Feb 2023 02:13:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 21:13:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 21:13:42 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/16] http test bug potpourri
Message-ID: <Y/gdVv63YSilKSYz@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
 <xmqq8rgo3qe6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rgo3qe6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 03:37:05PM -0800, Junio C Hamano wrote:

> > I'm actually not sure if the final patch is a good idea or not, but
> > certainly all of the fixes leading up to it are worth doing.
> 
> Thanks; this must have been a lot of work.  From the "test what the
> end users use, or at least something close to it" standpoint, 16/16
> certainly is the right thing to do, I would think.

Yeah. My main concern is that we are now using SSL by default in the
test suite (or at least trying to; I _think_ we should fail gracefully,
but since it works on my system, I don't have any data beyond the fact
that CI seems OK with it). I think it's one of those things where we try
it and see if anybody screams.

-Peff
