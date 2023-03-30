Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8257C7619A
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 22:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC3WJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjC3WJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 18:09:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C190E04E
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 15:09:16 -0700 (PDT)
Received: (qmail 32055 invoked by uid 109); 30 Mar 2023 22:09:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 22:09:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22279 invoked by uid 111); 30 Mar 2023 22:09:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 18:09:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 18:09:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 0/5] some chainlint fixes and performance improvements
Message-ID: <20230330220915.GA1914330@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230330192712.GA27719@coredump.intra.peff.net>
 <xmqqjzyyhtel.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzyyhtel.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 01:32:34PM -0700, Junio C Hamano wrote:

> >   [5/5]: tests: skip test_eval_ in internal chain-lint
> 
> The new step [3/5] makes it easier to justify [4/5], indeed.  Two
> primary changes at the beginning are good as before.  The last one
> does not make anything particularly easier to read, replacing one
> cryptic eval stuff with another, but it does not make it any worse,
> and the most importantly, it is clear to see that it does not change
> the behaviour.

Yeah, the eval garbage is horrid no matter where it is. The improvement
is that we no longer have to manually save-and-restore the "trace"
variable.

> Will queue.  Thanks.  Let's merge it down to 'next'.

Great, thanks. :)

-Peff
