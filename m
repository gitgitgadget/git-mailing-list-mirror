Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7AE202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbdKTUhF (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:37:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:35058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752402AbdKTUhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:37:05 -0500
Received: (qmail 4315 invoked by uid 109); 20 Nov 2017 20:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15965 invoked by uid 111); 20 Nov 2017 20:37:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:37:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:37:03 -0500
Date:   Mon, 20 Nov 2017 15:37:03 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, hsed@unimetic.com,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH V4] config: add --expiry-date
Message-ID: <20171120203702.mdd3hkwezxyf7vtg@sigill.intra.peff.net>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
 <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
 <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
 <CAGZ79ka+5o07cz4A8=Gu_VqO1hYqqO=8Ju1uAaDY23s7xjCWvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka+5o07cz4A8=Gu_VqO1hYqqO=8Ju1uAaDY23s7xjCWvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 12:28:11PM -0800, Stefan Beller wrote:

> > +cc Stefan, who added the die(). It may be that we don't care that much
> > these days about recovering from broken .gitmodules files.
> 
> By that you mean commits like 37f52e9344 (submodule-config:
> keep shallow recommendation around, 2016-05-26) for example?
> That adds a git_config_bool to the submodule config machinery.

I actually meant ea2fa5a338 (submodule-config: keep update strategy
around, 2016-02-29), which adds an actual die() into parse_config(). But
yeah, I think the end result is the same.

> I agree that we'd want to be more careful, but for now I'd put it to the
> #leftoverbits.

Fine by me. While I think the original intent was to be more lenient to
malformed .gitmodules, it's not like we're seeing bug reports about it.

-Peff
