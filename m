Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968E01F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeKKQXn (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:23:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727568AbeKKQXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:23:43 -0500
Received: (qmail 31978 invoked by uid 109); 11 Nov 2018 06:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 06:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31755 invoked by uid 111); 11 Nov 2018 06:35:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 01:35:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 01:36:01 -0500
Date:   Sun, 11 Nov 2018 01:36:01 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 02/10] git-fast-export.txt: clarify misleading
 documentation about rev-list args
Message-ID: <20181111063601.GB30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-3-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:04PM -0800, Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-fast-export.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index ce954be532..677510b7f7 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -119,7 +119,8 @@ marks the same across runs.
>  	'git rev-list', that specifies the specific objects and references
>  	to export.  For example, `master~10..master` causes the
>  	current master reference to be exported along with all objects
> -	added since its 10th ancestor commit.
> +	added since its 10th ancestor commit and all files common to
> +	master\~9 and master~10.

Do you need to backslash the second tilde?  Maybe `master~9` and
`master~10` instead of escaping?

I'm not sure what this is trying to say. I guess that we'd always show
all of the blobs necessary to reconstruct the first non-negative commit
(i.e., `master~9` here)?

-Peff
