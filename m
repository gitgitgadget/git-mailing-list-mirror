Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A0320248
	for <e@80x24.org>; Wed,  6 Mar 2019 04:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCFEnE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 23:43:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:40464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbfCFEnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 23:43:04 -0500
Received: (qmail 4639 invoked by uid 109); 6 Mar 2019 04:43:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 04:43:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9470 invoked by uid 111); 6 Mar 2019 04:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 23:43:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 23:43:02 -0500
Date:   Tue, 5 Mar 2019 23:43:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
Message-ID: <20190306044302.GB6664@sigill.intra.peff.net>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 10:34:18AM +0900, Junio C Hamano wrote:

> * jk/fsck-doc (2019-03-05) 2 commits
>  - fsck: always compute USED flags for unreachable objects
>  - doc/fsck: clarify --connectivity-only behavior
> 
>  "git fsck --connectivity-only" omits computation necessary to sift
>  the objects that are not reachable from any of the refs into
>  unreachable and dangling.  This is now documented, and also the
>  computation is done in order to show the dangling objects when
>  requested (which is done by default, but can be overridden with
>  the "--no-dangling" option).
> 
>  Will merge to 'next'.

I think this merge message needs a slight tweak with this v2; we don't
document the failing now, but instead just fix it. :) Maybe:

	"git fsck --connectivity-only" omits computation necessary to sift
	the objects that are not reachable from any of the refs into
	unreachable and dangling.  This is now enabled when dangling
	objects are requested (which is done by default, but can be
	overridden with the "--no-dangling" option).

-Peff
