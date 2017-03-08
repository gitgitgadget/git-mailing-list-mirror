Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B88202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbdCHOBH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 09:01:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:40435 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753629AbdCHOBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 09:01:04 -0500
Received: (qmail 20665 invoked by uid 109); 8 Mar 2017 13:33:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 13:33:50 +0000
Received: (qmail 22391 invoked by uid 111); 8 Mar 2017 13:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 08:33:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 08:33:48 -0500
Date:   Wed, 8 Mar 2017 08:33:48 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
Message-ID: <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2017 at 01:54:02PM +0100, Sebastian Schuberth wrote:

> I'm getting
> 
> $ git config --global diff.ignoreSubmodules all
> $ git diff
> diff --git a/scanners/scancode-toolkit b/scanners/scancode-toolkit
> index 65e5c9c..6b021a8 160000
> --- a/scanners/scancode-toolkit
> +++ b/scanners/scancode-toolkit
> @@ -1 +1 @@
> -Subproject commit 65e5c9c9508441c5f62beff4749cf455c6eadc30
> +Subproject commit 6b021a8addf6d3c5f2a6ef1af6245e095c21d8ec
>
> but with
> 
> $ git diff --ignore-submodules=all

Hrm. Isn't "all" the default? That's what git-diff(1) says (but I've
never used the feature myself).

That would imply to me that there's another config option set somewhere
(perhaps in the repo-level config). What does:

  git config --show-origin --get-all diff.ignoresubmodules

say?

-Peff
