Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1CDC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJKBAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJKBAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:00:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA68D50FAF
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:00:12 -0700 (PDT)
Received: (qmail 29880 invoked by uid 109); 11 Oct 2022 01:00:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:00:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15881 invoked by uid 111); 11 Oct 2022 01:00:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:00:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:00:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Y0TAG3k1wK+ZfdzY@coredump.intra.peff.net>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
 <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
 <Y0CnJBzTbNgRIqZ+@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0CnJBzTbNgRIqZ+@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 06:24:36PM -0400, Taylor Blau wrote:

> > So here you're allowing multiple pretty options. But really, once we
> > allow the user an arbitrary format, is there any reason for them to do:
> >
> >   git shortlog --group=%an --group=%ad
> >
> > versus just:
> >
> >   git shortlog --group='%an %ad'
> >
> > ?
> 
> I think that if you want to unify `--group=author` into the new format
> group implementation, you would have to allow multiple `--group`
> options, but each such option would generate its own shortlog identity
> instead of getting concatenated together.

Exactly, and I think we have to do that anyway to match the existing
multiple-option behavior.

-Peff
