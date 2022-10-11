Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3381C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJKA06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKA04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:26:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139E57E21
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:26:55 -0700 (PDT)
Received: (qmail 29728 invoked by uid 109); 11 Oct 2022 00:26:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:26:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15276 invoked by uid 111); 11 Oct 2022 00:26:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:26:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:26:53 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
Message-ID: <Y0S4TWdeK0dSL3VZ@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
 <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
 <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net>
 <xmqqwn9clwba.fsf@gitster.g>
 <fb4cfbd3-e738-f1e8-18f7-d4e90050b8b5@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb4cfbd3-e738-f1e8-18f7-d4e90050b8b5@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 02:33:08PM -0400, Derrick Stolee wrote:

> Are you implying that you want to use the second version, that
> deletes the information entirely? I'm leaning towards deleting
> it.
> 
> If not, and we should keep using traces, I do notice that the
> original version of the patch uses trace_printf_key() instead
> of a trace2 method. I think this is fine, too, since it's
> likely only to be used by Git developers, who could look for
> which type of trace to use.

I think it's moot, because we're all in agreement that the code should
be deleted. But...

...it is not clear to me that GIT_TRACE_* is dead for further additions.
I find it delightfully simple to use, and trace2 often rather baroque
and complicated, since it is aimed more at structured data, as well as
storing or even transmitting data.

I'm not sure if we have an overall plan there.

-Peff
