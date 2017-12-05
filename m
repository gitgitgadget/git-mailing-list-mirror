Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C2D20C11
	for <e@80x24.org>; Tue,  5 Dec 2017 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbdLEHKQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 02:10:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:48330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752334AbdLEHKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 02:10:12 -0500
Received: (qmail 30249 invoked by uid 109); 5 Dec 2017 07:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Dec 2017 07:10:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29872 invoked by uid 111); 5 Dec 2017 07:10:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 05 Dec 2017 02:10:32 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Dec 2017 02:10:10 -0500
Date:   Tue, 5 Dec 2017 02:10:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4/4] sha1dc: remove in favor of using
 sha1collisiondetection as a submodule
Message-ID: <20171205071010.GD4788@sigill.intra.peff.net>
References: <20171128213214.12477-1-avarab@gmail.com>
 <20171128213214.12477-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171128213214.12477-5-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 09:32:14PM +0000, Ævar Arnfjörð Bjarmason wrote:

> As an aside: Now where was that .gitdiffsort or whatever it was called
> which would enable us to show sha1dc_git.h before nuking the contents
> of sha1dc? :)

diff.orderFile, I think.

> It also occurs to me that it would be useful for patch formatting in
> general to make all file removals go after file changes & additions.

I wonder if that might run afoul of programs which try to apply patches
in order. I think "git apply" is smart enough to apply all deletions
(regardless of order) before any creations (so it cannot be fooled by
adding "foo" followed by deleting "foo/bar"). So maybe it's fine.

-Peff
