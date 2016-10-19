Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06C22098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945276AbcJSPij (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59453 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945475AbcJSPia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:38:30 -0400
Received: (qmail 6560 invoked by uid 109); 19 Oct 2016 09:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 09:13:24 +0000
Received: (qmail 11815 invoked by uid 111); 19 Oct 2016 09:13:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 05:13:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 05:13:23 -0400
Date:   Wed, 19 Oct 2016 05:13:23 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v4 6/7] t/t7030-verify-tag: Add --format specifier tests
Message-ID: <20161019091323.jrirwruwex7l7yj2@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-7-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-7-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 05:07:20PM -0400, santiago@nyu.edu wrote:

> Verify-tag now provides --format specifiers to inspect and ensure the
> contents of the tag are proper. We add two tests to ensure this
> functionality works as expected: the return value should indicate if
> verification passed, and the format specifiers must be respected.

Sounds good.

> +test_expect_success 'verifying tag with --format' '
> +	cat >expect <<-\EOF &&
> +	tagname : fourth-signed
> +	EOF
> +	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
> +	test_cmp expect actual
> +'

I suppose it's a matter of style, but for a single-line expectation I
would just do:

  echo "tagname : fourth-signed" >expect &&

which is shorter and saves a process invocation.

Ditto on the next patch (which IMHO could just be squashed into a single
patch).

-Peff
