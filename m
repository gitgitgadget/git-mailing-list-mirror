Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CDC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjBWJsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjBWJsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:48:40 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADD25293
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:48:38 -0800 (PST)
Received: (qmail 22877 invoked by uid 109); 23 Feb 2023 09:48:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 09:48:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17710 invoked by uid 111); 23 Feb 2023 09:48:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 04:48:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 04:48:37 -0500
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: mc/credential-helper-www-authenticate (Re: What's cooking in
 git.git (Feb 2023, #04; Wed, 22))
Message-ID: <Y/c2dQTohGsN+3Me@coredump.intra.peff.net>
References: <xmqqbkllaxd7.fsf@gitster.g>
 <3ab86863-fa15-a5c5-08c8-73ad775e04c8@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ab86863-fa15-a5c5-08c8-73ad775e04c8@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 09:51:28PM -0800, Victoria Dye wrote:

> Junio C Hamano wrote:
> > * mc/credential-helper-www-authenticate (2023-02-16) 3 commits
> >  - credential: add WWW-Authenticate header to cred requests
> >  - http: read HTTP WWW-Authenticate response headers
> >  - t5563: add tests for basic and anoymous HTTP access
> > 
> >  Allow information carried on the WWW-AUthenticate header to be
> >  passed to the credential helpers.
> > 
> >  Will merge to 'next'?
> >  source: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
> 
> Aside from some relatively minor touch-ups, this has been fairly stable
> since v8. I'm happy with it at this point, but I'm also curious to hear
> Peff's thoughts (since it was his review that prompted the switch to Apache
> for the test helper, among other changes).

I just gave v10 a careful read. It looks quite nice to me, though there
were a few tiny nits that I think are worth a re-roll (the most
important being the strcasecmp buffer over-read).

-Peff
