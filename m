Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0D42047F
	for <e@80x24.org>; Mon,  7 Aug 2017 20:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdHGU6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 16:58:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751662AbdHGU6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 16:58:37 -0400
Received: (qmail 30905 invoked by uid 109); 7 Aug 2017 20:58:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 20:58:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10307 invoked by uid 111); 7 Aug 2017 20:58:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 16:58:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Aug 2017 16:58:30 -0400
Date:   Mon, 7 Aug 2017 16:58:30 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170807205830.yge6kcpmg5gkogjj@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
 <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
 <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
 <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
 <feae203b-222c-4430-8af2-aae76c7e0bb0@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feae203b-222c-4430-8af2-aae76c7e0bb0@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 06, 2017 at 09:12:16PM +0200, Nicolas Morey-Chaisemartin wrote:

> Also it probably make sense to have at least one release where --curl
> is the default. Until your mail I had no idea this option existed so I
> never tried it out.
> Making it the default will make sure almost everyone is using it and
> that there is feature-parity.

Yeah, I had thought that the curl implementation _was_ the default if
you have curl. But we just build it by default, and you have to manually
enable it. So I agree it has not gotten nearly as much testing as I had
thought, and as you found, it diverges from the earlier implementation
in quite a few areas.

So I think we would need to take any deprecation much more slowly than I
had first thought (and your patches in the nearby thread are moving in a
good direction).

-Peff
