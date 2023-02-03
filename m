Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7CC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBCRTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBCRTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:19:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6E418B17
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:19:32 -0800 (PST)
Received: (qmail 26557 invoked by uid 109); 3 Feb 2023 17:19:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 17:19:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10313 invoked by uid 111); 3 Feb 2023 17:19:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 12:19:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 12:19:31 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] t/lib-httpd: bump required apache version to 2.2
Message-ID: <Y91CI1NKcy4pEzjn@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
 <Y9pO8bBZjXjEZhR/@coredump.intra.peff.net>
 <Y9s+ifALGYniOVHK@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9s+ifALGYniOVHK@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 11:39:37PM -0500, Todd Zullinger wrote:

> > diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> > index 608949ea80..8fc411ff41 100644
> > --- a/t/lib-httpd.sh
> > +++ b/t/lib-httpd.sh
> > @@ -99,16 +99,19 @@ then
> >  fi
> >  
> >  HTTPD_VERSION=$($LIB_HTTPD_PATH -v | \
> 
> Trivial, but is it worth getting rid of the unnecessary
> backslash, while you're improving things here?  Maybe that's
> a mild tangent for code that's otherwise not adjusted very
> often?

Heh, I didn't even notice. I don't think it's a big deal either way. It
definitely doesn't match our style, and I don't mind if we fix it on
top, but it could just be left alone.

It might make more sense as part of a broader cleanup. Running:

  git grep '| \\'

turns up a number of hits.

-Peff
