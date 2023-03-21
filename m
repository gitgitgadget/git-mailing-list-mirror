Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595BC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCURcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCURcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:32:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1F1E284
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:32:07 -0700 (PDT)
Received: (qmail 27651 invoked by uid 109); 21 Mar 2023 17:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 17:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2301 invoked by uid 111); 21 Mar 2023 17:32:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 13:32:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 13:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
Message-ID: <20230321173206.GC3119834@coredump.intra.peff.net>
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320190047.79836-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 01:00:47PM -0600, Felipe Contreras wrote:

> Unfortunately by that point many workarounds already existed. In the
> case of git, GNU_ROFF was introduced, and in the case of Arch Linux
> a mapping from \' to ' was added to groff's man.local. Other
> distributions might have done the same, or similar workarounds.
> 
> Since 2010 there is no need for this workaround, which is fixed
> elsewhere, not just in docbook, but other layers as well.
> 
> Let's remove it.

Thanks, it's nice to get rid of old cruft like this when it's no longer
useful.

One thing I wondered about, though: even if docbook fixed it in 2010,
the workaround is still useful for a while, as it takes time for newly
released versions to be available everywhere.

I'd think 13 years is probably long enough, but I was curious about the
versions. You referenced the fix here:

> [6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046

but the earliest tag in that repository that contains that commit is
1.79.1 from 2016. However, it seems like that repo is oddly missing
older tags. You mentioned 1.76 earlier, and the changelog for the Debian
package of docbook-xsl mentions the 1.76 release fixing it in 2010.

So assuming the fix really was released in 2010, even long-running
distros like CentOS probably would have picked it up within a few years,
and our workaround should definitely be obsolete by now.

-Peff
