Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD691F461
	for <e@80x24.org>; Wed,  3 Jul 2019 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGCQlT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 12:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:58502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725847AbfGCQlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 12:41:19 -0400
Received: (qmail 18950 invoked by uid 109); 3 Jul 2019 16:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jul 2019 16:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25403 invoked by uid 111); 3 Jul 2019 16:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Jul 2019 12:42:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2019 12:41:16 -0400
Date:   Wed, 3 Jul 2019 12:41:16 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] check_everything_connected: assume alternate ref
 tips are valid
Message-ID: <20190703164116.GA23260@sigill.intra.peff.net>
References: <20190701131713.GA25349@sigill.intra.peff.net>
 <20190701131815.GB2584@sigill.intra.peff.net>
 <20190703091225.GQ21574@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703091225.GQ21574@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 11:12:25AM +0200, SZEDER Gábor wrote:

> On Mon, Jul 01, 2019 at 09:18:15AM -0400, Jeff King wrote:
> > diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> > new file mode 100755
> > index 0000000000..3353216f09
> > --- /dev/null
> > +++ b/t/t5618-alternate-refs.sh
> > @@ -0,0 +1,60 @@
> 
> > +test_expect_success 'log --source shows .alternate marker' '
> > +	git log --oneline --source --remotes=origin >expect.orig &&
> > +	sed "s/origin.* /.alternate /" <expect.orig >expect &&
> 
> Unnecessary redirection, 'sed' can open that file on its own as well.

Sure, but is there a compelling reason not to feed it as stdin?

-Peff
