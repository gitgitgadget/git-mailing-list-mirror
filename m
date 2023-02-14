Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48634C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBNWXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBNWXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:23:42 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C469CA35
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:23:41 -0800 (PST)
Received: (qmail 3292 invoked by uid 109); 14 Feb 2023 22:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 22:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6777 invoked by uid 111); 14 Feb 2023 22:23:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 17:23:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 17:23:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES
 constant
Message-ID: <Y+wJ62wwAcuvBRYi@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
 <Y+vVkhB59XYys4C7@coredump.intra.peff.net>
 <xmqq5yc453u5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yc453u5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 01:34:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The current count-up isn't a big deal, as we need to preprocess that
> > array anyway. But it will become more cumbersome as we refactor the
> > shortening code. So let's get rid of it and just use the constant
> > everywhere.
> 
> OK.  As the array is constant, we could lose its NULL-termination
> and -1 from the definition of NUM_REV_PARSE_RULES, but that has iffy
> upside, and can come on top of the series if we really wanted to.

Yeah. We'd have to update the other callers. Not hard, but I agree it
doesn't buy us much.

-Peff
