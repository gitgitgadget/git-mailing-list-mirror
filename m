Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3038C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJKA7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKA7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:59:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D66786D8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:59:09 -0700 (PDT)
Received: (qmail 29863 invoked by uid 109); 11 Oct 2022 00:59:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:59:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15852 invoked by uid 111); 11 Oct 2022 00:59:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:59:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:59:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Y0S/3Nl6PFWS3rTd@coredump.intra.peff.net>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
 <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
 <Yz93RjrJ00A5QvNe.jacob@initialcommit.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz93RjrJ00A5QvNe.jacob@initialcommit.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 05:48:06PM -0700, Jacob Stopak wrote:

> > We probably want to insist that the format contains a "%" sign, and/or
> > git it a keyword like "format:". Otherwise a typo like:
> > 
> >   git shortlog --format=autor
> > 
> > stops being an error we detect, and just returns nonsense results
> > (every commit has the same ident).
> 
> Small aside: I like how Taylor re-used the --group option for the custom format.
> IMO it hammers home that this is a grouping option and not just formatting or
> filtering which can be confusing to users sometimes when doing data analytics.

Yeah, sorry this was just a typo/thinko on my part. It absolutely should
be --group, as --format already does something else.

-Peff
