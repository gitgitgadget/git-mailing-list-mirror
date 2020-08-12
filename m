Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB625C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937CD2078B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHLJOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:14:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:56140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgHLJOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 05:14:38 -0400
Received: (qmail 7103 invoked by uid 109); 12 Aug 2020 09:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 09:14:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29534 invoked by uid 111); 12 Aug 2020 09:14:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 05:14:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 05:14:36 -0400
From:   Jeff King <peff@peff.net>
To:     Craig H Maynard <chmaynard@me.com>
Cc:     git@vger.kernel.org
Subject: Re: git reflog --date
Message-ID: <20200812091436.GA18444@coredump.intra.peff.net>
References: <730B4EB4-AA72-4097-9487-D6B8623BB8E5@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <730B4EB4-AA72-4097-9487-D6B8623BB8E5@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 08:28:55PM -0400, Craig H Maynard wrote:

> I'm using git version 2.28.0. I don't see any mention of this 'git reflog' option in the online Git docs:
> 
> git reflog --date=iso
> 
> Any I missing something?

The reflog command defaults to "reflog show" if no command is given
(from the "Description" section of "git help reflog"):

  The "show" subcommand (which is also the default, in the absence of
  any subcommands) shows the log of the reference provided in the
  command-line (or HEAD, by default). The reflog covers all recent
  actions, and in addition the HEAD reflog records branch switching. git
  reflog show is an alias for git log -g --abbrev-commit
  --pretty=oneline; see git-log(1) for more information.

And the implication that it takes the same options as git-log is spelled
out explicitly in the Options section:

   Options for show
     git reflog show accepts any of the options accepted by git log.

You can find a more detailed description of --date in the git-log
manpage.

-Peff
