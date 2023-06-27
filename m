Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29076C0015E
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF0UUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjF0UUD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 16:20:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654413580
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 13:19:38 -0700 (PDT)
Received: (qmail 16907 invoked by uid 109); 27 Jun 2023 20:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 20:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20962 invoked by uid 111); 27 Jun 2023 20:19:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 16:19:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 16:19:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] replace strbuf_expand() with strbuf_expand_step()
Message-ID: <20230627201923.GB1358527@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <150df0b0-0548-f291-2b68-960841dd1c97@web.de>
 <20230627085422.GJ1226768@coredump.intra.peff.net>
 <8d2223b8-ab33-be5a-20ea-ad60f6cbcc75@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d2223b8-ab33-be5a-20ea-ad60f6cbcc75@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 06:31:55PM +0200, René Scharfe wrote:

> > It does still feel like we should be handling "%%" on behalf of the
> > callers.
> 
> I feel the same, but restrained myself from doing that, so that we
> can see all the pieces for now.  It allows us to recombine them in
> better ways than before.

Yeah, since you did the work to handle "%%" in each caller, I'm OK with
proceeding and letting a later refactor shrink it back down if we
choose.

-Peff
