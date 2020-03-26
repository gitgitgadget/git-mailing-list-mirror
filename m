Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D5C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010A120748
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgCZLPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:15:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727990AbgCZLPB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 07:15:01 -0400
Received: (qmail 3628 invoked by uid 109); 26 Mar 2020 11:15:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 11:15:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13879 invoked by uid 111); 26 Mar 2020 11:24:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 07:24:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 07:15:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?S=C3=A9bastien?= BRUCKERT <sebastien.bruckert@smile.fr>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Representation of diff with trailing spaces
Message-ID: <20200326111500.GB4193632@coredump.intra.peff.net>
References: <CABt=S26FB1zkwDCdmXeyVvFYvpvuGSX_y1Fg5N3K=yq0ZMyR7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABt=S26FB1zkwDCdmXeyVvFYvpvuGSX_y1Fg5N3K=yq0ZMyR7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 26, 2020 at 12:07:55PM +0100, Sébastien BRUCKERT wrote:

> # Abstract
> Something that always bothered me with git diff was how trailing
> spaces are represented. If I add spaces, then diff, they are
> represented in the terminal by a red background. If I then remove
> them, they are not represented. That's how I can have a diff with two
> exact lines, and I'm looking for the diff in it, but can't find it.
> Because it is the non-represented spaces.

Have you tried setting diff.wsErrorHighlight? By default we only
highlight whitespace problems in new lines, but it can be told to show
them in old lines or in context.

-Peff
