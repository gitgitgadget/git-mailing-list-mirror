Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88E01F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfJMG4L (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 02:56:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:46864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728080AbfJMG4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 02:56:11 -0400
Received: (qmail 5715 invoked by uid 109); 13 Oct 2019 06:56:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Oct 2019 06:56:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15774 invoked by uid 111); 13 Oct 2019 06:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Oct 2019 02:59:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Oct 2019 02:56:10 -0400
From:   Jeff King <peff@peff.net>
To:     James Coglan <jcoglan@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
 merges
Message-ID: <20191013065609.GA30601@sigill.intra.peff.net>
References: <pull.383.git.gitgitgadget@gmail.com>
 <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
 <9fe7f2d9-2108-5cf6-dcd7-06d91e74e98b@gmail.com>
 <204c7479-c78d-54ff-5ece-397b4c31804c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <204c7479-c78d-54ff-5ece-397b4c31804c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 06:04:21PM +0100, James Coglan wrote:

> > I should have noticed in your earlier commits, but why don't you keep
> > the output inside the test suite? You can start with "cat >expect <<-EOF"
> > to have it ignore leading whitespace. Sorry if there's something else about
> > this that is causing issues.
> 
> I was following a pattern used in t/t4202-log.sh. I believe it was
> easier to debug these tests with the setup and expectations split into
> separate blocks, but I wouldn't be opposed to merging them.

Some of the older tests used that style, but we've been slowly
modernizing (I know, it's hard to pick up the style by example in such
cases!). The usual style these days is making sure everything goes in a
test_expect_* block, with "<<-" to indent here-documents.

Another minor style nit that you picked up from t4202:

> >> +cat > expect <<\EOF

We'd omit the space after ">" here.

-Peff
