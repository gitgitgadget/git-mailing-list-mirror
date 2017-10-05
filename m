Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E180C2036C
	for <e@80x24.org>; Thu,  5 Oct 2017 06:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdJEGJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 02:09:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751116AbdJEGJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 02:09:25 -0400
Received: (qmail 7817 invoked by uid 109); 5 Oct 2017 06:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 06:09:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24470 invoked by uid 111); 5 Oct 2017 06:09:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 02:09:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 02:09:23 -0400
Date:   Thu, 5 Oct 2017 02:09:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.15.0-rc0
Message-ID: <20171005060922.o2wzccm4uqq5o74e@sigill.intra.peff.net>
References: <xmqq7ewa87fw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ewa87fw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 02:55:31PM +0900, Junio C Hamano wrote:

> Git 2.15 Release Notes (draft)
> ==============================
> 
> Backward compatibility notes and other notable changes.
> 
>  * Use of an empty string as a pathspec element that is used for
>    'everything matches' is still warned and Git asks users to use a
>    more explicit '.' for that instead.  The hope is that existing
>    users will not mind this change, and eventually the warning can be
>    turned into a hard error, upgrading the deprecation into removal of
>    this (mis)feature.  That is now scheduled to happen in the upcoming
>    release.

I wasn't sure if this "upcoming" meant v2.15 ("the upcoming release that
we're about to tag") or v2.16. Judging from "What's cooking" it's the
latter, but perhaps we should be more explicit. I don't know if you are
hesitant to name it "v2.16" at this point, but maybe:

  ...in the upcoming release (i.e., the one after v2.15).

would help.

>  * Git now avoids blindly falling back to ".git" when the setup
>    sequence said we are _not_ in Git repository.  A corner case that
>    happens to work right now may be broken by a call to die("BUG").

An even more minor nit. This is now BUG(). :)

I don't think it matters for our purposes here, of course. But I did
wonder how long we'd want to carry this warning in the notes. I think it
goes back to v2.13. Of course people sometimes jump several versions
without necessarily reading the interim release notes, so it makes sense
to carry it for a while.

-Peff
