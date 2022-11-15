Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA6C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKOR2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKOR2O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:28:14 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546D26117
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:28:13 -0800 (PST)
Received: (qmail 18623 invoked by uid 109); 15 Nov 2022 17:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Nov 2022 17:28:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23714 invoked by uid 111); 15 Nov 2022 17:28:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Nov 2022 12:28:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Nov 2022 12:28:12 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: ps/receive-use-only-advertised
Message-ID: <Y3PMLFuvR6hlIzbq@coredump.intra.peff.net>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <Y3MxmzestKm9iMTU@ncase>
 <Y3M2Fq7pZk4lNY9G@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3M2Fq7pZk4lNY9G@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 01:47:50AM -0500, Taylor Blau wrote:

> > >  "git receive-pack" used to use all the local refs as the boundary
> > >  for checking connectivity of the data "git push" sent, but now it
> > >  uses only the refs that it advertised to the pusher.  In a
> > >  repository with the .hideRefs configuration, this reduces the
> > >  resource needed to perform the check, and also forces the pusher to
> > >  prove they have all objects that are necessary to complete the
> > >  history on top of only the history available to them.
> >
> > We have at a later point established that this is not true: the pusher
> > does not have to prove they have all objects. As the `--not --all` part
> > in git-rev-list(1) is merely an optimization the semantics aren't
> > changed at all
> 
> Thanks; this is Junio's description from when he picked up the topic
> back in WC #08 from October. I'll need to update before graduating it
> down.

Yeah, I think you can probably just remove everything from "and also
forces..." on.

> > I think this is stale, right? There was no further feedback until now,
> > and in your [1] you say that things look good to you, but that you
> > intend to wait a few days for further feedback.
> >
> > Thanks!
> 
> Yes, that is indeed stale, thanks for catching. I'm just waiting for a
> review from somebody that isn't you or me ;-).

I just left a review. It looks good to me to hit 'next'.

-Peff
