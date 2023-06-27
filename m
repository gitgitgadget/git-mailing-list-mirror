Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A984C001B3
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF0USI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjF0USE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 16:18:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51B26BC
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 13:17:43 -0700 (PDT)
Received: (qmail 16719 invoked by uid 109); 27 Jun 2023 20:16:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 20:16:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20939 invoked by uid 111); 27 Jun 2023 20:16:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 16:16:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 16:16:36 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/7] var: add attributes files locations
Message-ID: <20230627201636.GA1358527@coredump.intra.peff.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-7-sandals@crustytoothpaste.net>
 <20230627070557.GB1226768@coredump.intra.peff.net>
 <ZJsKa6ZNq7nnh0gf@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJsKa6ZNq7nnh0gf@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 04:12:27PM +0000, brian m. carlson wrote:

> > So I dunno. I'm mostly giving a heads-up, and seeing if you (or other
> > reviewers in the thread) have an idea to make this "flag" thing less
> > awful. I'm also happy to just do my topic separately, and then
> > eventually circle back after yours is merged.
> 
> I've picked up your patch as the first patch in the series and will send
> it out in v3 in just a few minutes.  Since I plan to have v3 be the last
> round of this series, I'll let you send out any further changes as
> fixups on top of that.

Thanks, that is optimal from my perspective. :)

The resulting series looks good to me, both the changes you integrated
from me, but also the whole thing overall. It is a little funny to stuff
the GIT_CONFIG_GLOBAL values into a string only to re-split them (versus
passing around a string_list itself), but I think it's a reasonable
compromise given the function interface.

-Peff
