Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F14C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 07:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiHTHEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245060AbiHTHEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 03:04:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B12543C1
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 00:04:50 -0700 (PDT)
Received: (qmail 21307 invoked by uid 109); 20 Aug 2022 07:04:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 07:04:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9284 invoked by uid 111); 20 Aug 2022 07:04:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 03:04:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 03:04:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] fix pipe_command() deadlock
Message-ID: <YwCHkLd0lTxWzDJ9@coredump.intra.peff.net>
References: <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
 <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
 <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
 <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
 <3e102aa4-ff44-0b7b-8164-f79bb00a8d3b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e102aa4-ff44-0b7b-8164-f79bb00a8d3b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 11:19:08PM +0200, René Scharfe wrote:

> Am 17.08.2022 um 08:04 schrieb Jeff King:
> > On Wed, Aug 17, 2022 at 01:39:32AM -0400, Jeff King wrote:
> >
> >> I wouldn't be opposed to that, in the sense that it's supposed to be a
> >> black box to the caller, and it's relatively small in size. But I think
> >> we're pretty close to having something usable without that, so I'd like
> >> to pursue a smaller fix in the interim.
> >
> > So here's what I came up with. Most of the changes are done as
> > preparatory steps, so I believe the final commit should just work out of
> > the box for you, as well as on Windows CI (which I just kicked off).
> 
> Indeed: This series passes the test suite for me on Windows 11.

Yay. :)

-Peff
