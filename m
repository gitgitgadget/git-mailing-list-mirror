Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CAC31F424
	for <e@80x24.org>; Sun, 24 Dec 2017 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbdLXOie (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 09:38:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:46506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751029AbdLXOie (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 09:38:34 -0500
Received: (qmail 12207 invoked by uid 109); 24 Dec 2017 14:38:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Dec 2017 14:38:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3530 invoked by uid 111); 24 Dec 2017 14:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 24 Dec 2017 09:39:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Dec 2017 09:38:32 -0500
Date:   Sun, 24 Dec 2017 09:38:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171224143831.GD23648@sigill.intra.peff.net>
References: <20171223174400.26668-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171223174400.26668-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 23, 2017 at 05:44:00PM +0000, Ævar Arnfjörð Bjarmason wrote:

> This is similar to Jeff King's jk/drop-ancient-curl series in that
> we're dropping perl releases that are rarely tested anymore, however
> unlike those patches git still works on e.g. 5.8.8 (I couldn't build
> anything older).

Heh, I'm not sure if those are the best prior art to justify this, since
I stopped posting them after getting complaints (though I'll admit I was
considering re-posting them since AFAICT nobody has stepped up to fix
the breakage after many months).

This may be more like the recent C99 weather-balloon patches, in that
we're not using the new features yet, but want to see if anybody screams
at this first change.

> The reason to do this is to be able to use features released with perl
> in the last decade, 5.10 was a major feature release including things
> like new regex features, state variables, the defined-or operator
> etc.[3]
> 
> I expect this to be more controversial as since the 5.8 release stayed
> along for longer in various distributions, e.g. it's the version
> shipped with RHEL 5, replaced by 5.10 in RHEL 6 released in late 2010,
> similarly the first Debian release to include 5.10 was 5.0 (Lenny)
> released in early 2009. The release history for other distributions
> can be seen on CPAN's "Perl Binaries" page[3].

As far as this actual perl change goes, I don't have a strong opinion. I
agree it would be nice to eventually move forward, and your reasoning
about what constitutes "old" seems sane. But we also don't write much
perl in this project these days, and I don't see a lack of modern perl
features causing a lot of headaches.

-Peff
