Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711FE1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 05:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfDWFeS (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 01:34:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:37760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725882AbfDWFeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 01:34:18 -0400
Received: (qmail 19191 invoked by uid 109); 23 Apr 2019 05:34:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 05:34:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6218 invoked by uid 111); 23 Apr 2019 05:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Apr 2019 01:34:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Apr 2019 01:34:16 -0400
Date:   Tue, 23 Apr 2019 01:34:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, avarab@gmail.com
Subject: Re: jt/fetch-cdn-offload (was What's cooking in git.git (Apr 2019,
 #04; Mon, 22))
Message-ID: <20190423053415.GB12530@sigill.intra.peff.net>
References: <xmqqd0le8t9l.fsf@gitster-ct.c.googlers.com>
 <20190422175104.15471-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190422175104.15471-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 10:51:04AM -0700, Jonathan Tan wrote:

> > * jt/fetch-cdn-offload (2019-03-12) 9 commits
> [...]
> 
> Sorry for getting back to you late on this. The current status is that
> v2 (this version) looks good to me, except that not many people seems to
> be interested in this - I sent out v2 [1] with a relatively significant
> protocol change to v1 (requiring the server to also send the packfile's
> hash, meaning that a workflow that Ævar has described will no longer
> work), but nobody replied to it except for Josh Steadmon (who did give
> his Reviewed-By).

I am interested in this. Sorry to be so slow on reviewing. It's been on
my todo list for a while. I finally gave a look over it and sent some
thoughts. I focused mainly on high-level and design choices, and didn't
look _too_ closely at the code (from what I saw it was all pretty
reasonable, but if you agree with my suggestions there's some re-working
to be done anyway).

FYI, I'll be offline the rest of the week, but I'll try to stay on top
of it next week if you have responses to my comments.

-Peff
