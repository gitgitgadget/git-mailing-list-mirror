Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D901F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfBKUi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:38:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbfBKUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:38:29 -0500
Received: (qmail 7993 invoked by uid 109); 11 Feb 2019 20:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Feb 2019 20:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17326 invoked by uid 111); 11 Feb 2019 20:38:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 15:38:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 15:38:27 -0500
Date:   Mon, 11 Feb 2019 15:38:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 8/8] remote-curl: in v2, fill credentials if needed
Message-ID: <20190211203827.GA9010@sigill.intra.peff.net>
References: <20190206212928.GB12737@sigill.intra.peff.net>
 <20190211192054.80935-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211192054.80935-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 11:20:54AM -0800, Jonathan Tan wrote:

> > In the case of proxy_request(), we don't know ahead of time whether the
> > request is large or not; we just proxy the data through. And we don't do
> > the probe thing at all. So wouldn't we dropping some data for the
> > follow-up request?
> 
> Thanks - I'll look into this. Maybe the best way is to somehow make the
> v2 code path also use post_rpc() - I'll see if that's possible.

Yeah, that makes sense.

> In the meantime, do you have any other opinions on the other patches,
> besides introducing a prereq [1]? I don't have any strong opinions for
> or against this, so I didn't reply, but I slightly prefer not having the
> prereq so that test readers and authors don't need to juggle so many
> variables in their heads.

I think Ævar convinced me that the way you've done it is the right way,
so ignore my earlier comments. :)

I just took another pass and left a few very minor nits, but it all
looks good overall.

> If everything looks good, I'll suggest that we drop this patch from this
> patch set for me to work on it independently. (Having said that, this
> patch set is based on js/protocol-advertise-multi, which is still under
> review, so it is not so urgent.)

Yeah, that's fine by me (with or without my nits addressed).

-Peff
