Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97260C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAOSgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 13:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjAOSgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 13:36:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DE9CC37
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 10:36:08 -0800 (PST)
Received: (qmail 7717 invoked by uid 109); 15 Jan 2023 18:36:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 18:36:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22295 invoked by uid 111); 15 Jan 2023 18:36:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 13:36:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 13:36:06 -0500
From:   Jeff King <peff@peff.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Crls <kaploceh@gmail.com>, git@vger.kernel.org
Subject: Re: ctrl-z ignored by git; creates blobs from non-existent repos
Message-ID: <Y8RHlukE5vtpq8Pj@coredump.intra.peff.net>
References: <632d051b-d81b-b35d-0641-c2488a124810@gmail.com>
 <Y8Qfj32h89hq5UD6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8Qfj32h89hq5UD6@mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2023 at 10:45:19AM -0500, Theodore Ts'o wrote:

> > Expected: The same issue does not happen with other non-existent repos e.g.,
> > git clone git.zx2c4/ it returns the message of fatal repo not found
> 
> So what's going on is that github.com is not returning a non-existent
> repo error; it's prompting for a username/password, as _if_ the
> repository exists.  That's presumably to prevent disclosing
> information as to whether or not a private repository exists or not.

I can confirm that this is exactly the reason.

-Peff
