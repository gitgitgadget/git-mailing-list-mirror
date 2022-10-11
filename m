Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB172C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJKAyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKAyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:54:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB5642C4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:54:13 -0700 (PDT)
Received: (qmail 29847 invoked by uid 109); 11 Oct 2022 00:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:54:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15793 invoked by uid 111); 11 Oct 2022 00:54:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:54:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:54:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 1/7] Documentation: extract date-options.txt
Message-ID: <Y0S+s04LrQWSeIC+@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <eaec59daa178c205a59b779c63e411316d8180ed.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaec59daa178c205a59b779c63e411316d8180ed.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:02PM -0400, Taylor Blau wrote:

> A future commit will want to include `--date`-related options in the
> documentation for `git-shortlog(1)`, but without some of the additional
> baggage in the usual rev-list-options.txt.
> 
> Extract those options to a separate file in Documentation and include it
> from its original source in rev-list-options.txt.
> 
> This patch does not modify the contents of the `--date`-options section
> of Documentation/rev-list-options.txt.

I think git-shortlog.txt already includes rev-list-options, but the date
parts are omitted because there's an ifndef::git-shortlog[] around the
whole "commit formatting" section.

Should we just be loosening the ifndef here?

I think we _could_ include more of the "formatting" section overall, but
it looks like we have a custom mention of "--format" in
git-shortlog.txt, which I think is a better solution anyway. Maybe we
should just do the same with `--date`?

-Peff
