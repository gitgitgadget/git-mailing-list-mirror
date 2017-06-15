Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB4D20401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdFONDd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:03:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:40637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdFONDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:03:33 -0400
Received: (qmail 26101 invoked by uid 109); 15 Jun 2017 13:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:03:32 +0000
Received: (qmail 23006 invoked by uid 111); 15 Jun 2017 13:03:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:03:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:03:31 -0400
Date:   Thu, 15 Jun 2017 09:03:31 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian =?utf-8?B?RHLDtmdl?= <sebastian@centricular.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git cherry-pick segfaults with local changes in working
 directory
Message-ID: <20170615130331.tak725h2i3fe7npw@sigill.intra.peff.net>
References: <1497517910.2239.105.camel@centricular.com>
 <20170615103215.45sp5adzu6zcorct@sigill.intra.peff.net>
 <1497523056.2239.107.camel@centricular.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1497523056.2239.107.camel@centricular.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 01:37:36PM +0300, Sebastian Dröge wrote:

> > Note that the tarball doesn't have all the necessary objects. Its
> > .git/objects/info/alternates points to another full clone of
> > git://anongit.freedesktop.org/gstreamer/gst-plugins-good.
> 
> Ah good to know, I thought this only happens if you clone with
> --reference and not otherwise.

If you do a local-filesystem clone of a repository with alternates, the
clone will have the same alternates. So I'm guessing you may have done
such a clone of your --reference repository as part of preparing the
tarball.

-Peff
