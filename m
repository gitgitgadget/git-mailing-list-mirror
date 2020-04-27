Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B40DC4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F69214AF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 19:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgD0TJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:09:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:41262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726571AbgD0TJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 15:09:56 -0400
Received: (qmail 15460 invoked by uid 109); 27 Apr 2020 19:09:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Apr 2020 19:09:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26836 invoked by uid 111); 27 Apr 2020 19:21:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2020 15:21:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Apr 2020 15:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v2] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200427190955.GA1728884@coredump.intra.peff.net>
References: <20200426234750.40418-1-carenas@gmail.com>
 <20200427084235.60798-1-carenas@gmail.com>
 <20200427115223.GA1718141@coredump.intra.peff.net>
 <xmqqk12095yh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk12095yh.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 10:47:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Those were never supposed to work. I'm mildly surprised that they did.
> 
> I know that feeling X-<.  It probably was a mistake to pretend that
> the file were editable with an editor, but it is too late to fix
> that.

I guess it is somewhat my fault for documenting the format at all
git-credential-store.txt. I probably should have said "this is a black
box and is subject to change".

> The next complainer may say that "; comment" no longer works.  We
> probably should draw a line somewhere, but I am not sure where.

If we get a bug report for "credential-store does not respect
core.commentChar" I think my head would explode. :)

-Peff
