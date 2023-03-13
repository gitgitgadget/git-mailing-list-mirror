Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A5C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCMQih (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjCMQiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CDBB9F
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 09:37:59 -0700 (PDT)
Received: (qmail 21651 invoked by uid 109); 13 Mar 2023 16:37:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Mar 2023 16:37:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8579 invoked by uid 111); 13 Mar 2023 16:37:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Mar 2023 12:37:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Mar 2023 12:37:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
Message-ID: <ZA9RYncZaqoA0mCw@coredump.intra.peff.net>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
 <xmqqedpxq4if.fsf@gitster.g>
 <ZAr6vIOe3WbTIohE@coredump.intra.peff.net>
 <xmqqh6us7epk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6us7epk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 08:28:55AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   1. I feel like "-p1" was pretty standard even before Git. You'd
> >      extract two copies of the tarball, one into "foo-1.2.3" and one
> >      into "foo-1.2.3.orig", and then "diff -Nru" between them to send a
> >      patch.
> 
> I would too, but then we wouldn't have accepted the request to add
> .noprefix configuration; I do not recall where it came from.

I always thought it was an aesthetic thing for humans viewing diffs (and
likewise mnemonicprefix). The original thread doesn't give much
motivation, though:

  https://lore.kernel.org/git/1272852221-14927-1-git-send-email-eli@cloudera.com/

That is not really important as what the option has grown to be used
for, of course, but it's another data point (or lack thereof in this
case).

-Peff
