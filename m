Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6360E1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdLYRhP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:37:15 -0500
Received: from mout.web.de ([217.72.192.78]:52735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbdLYRhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:37:14 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudKu-1eu64Y2Jm4-00zjmw; Mon, 25
 Dec 2017 18:36:50 +0100
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
 <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
 <20171219114906.GB24558@sigill.intra.peff.net>
 <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
 <20171220130811.GD17569@sigill.intra.peff.net>
 <c8980a2c-24e2-a877-fa66-31206123ce49@web.de>
 <20171224142246.GA23648@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7cb39d8a-2ef2-b7eb-d0cd-6931b2fda951@web.de>
Date:   Mon, 25 Dec 2017 18:36:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171224142246.GA23648@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qC3vqOYOquEtzrd7pb6VGlHSoclIaWEGqvY0EjMkfUPMO/N9Inn
 ife1yJrnvzzetpdBc90T95rB4kiq9gRYj7WfIWSV0LqPoEP0BOE06qLifFKhcJhMvChIrS4
 sp5U1seLTIVWNEzZR2WdBWG2ooLnL1v1bqTbfJS8J+8IVnn8WVKJoIC1m1I360nVsKZf0ni
 udsLvsKSvt2AEhh2e5Lqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K7KXEz2CMV8=:i5wfz3Y4bwd4Zxin6KPTWa
 Hc7P8+tfV6KUPxVC1PYDbj4Yyks1A3KqjYr21tcnYgC6xP8XbW2GRAeUfstKkTZ4bilbs9opO
 h0GNzMHfZX4Q282PPmcDZzIWobIq7i1NZ9+TZBeS+2MrBj6fitzL/KzTYol6A6R5snY/UzOnA
 ATsW+k2s07Zwsg4Z4n49ZT4y6UlWzHOOEL554cLrGA16UmSkNcAqSy8XM56BgAmElTSZu2KcR
 /tjNJm4Cba0DEDokVLs56WhBePai4B78ymaelU5LWWxokbMdxoABosLrxvkjvTg4pRmUqAOZi
 OVOidBsNWekObNa0SY3BkGsoFTkgF4ojPW466Mw3hZo05V3+Lf30oaRjjAaNCP2XhC1YfuWkT
 FX4bqyfgE1+li4eJI//483e2f0TZ4dKbxiOIvTQH50fdPD59ddTHxFFnEzDy9J97Yu96lgfqT
 xLy/G51fpxDeKp8dY4SmIAjZgFwVsAAC3m4Ad7t+Q7tBjYBsXDAzuac3rexFGJ0zMf9x5i+ss
 4oywR1h3qzccUJ8NKpqTXKfxltqThdsVVxZ4m+/xfoWTSUp/DNqr+MZvvzJzBY3hyI9cPHvzK
 KVBuOIFPTLcvJROOb87j1Vk8LpwuGjgqPGgjaMo7+ex1ayhbdkDXMOJACCIyhLhq66Wqdudu7
 aoNbn/gLvkLjCCUmkqkv9GFPpDIKwJEt2EbD0pRfUX2Rg0cVdTrapZt5SYKvrh5EYzs6ETRft
 RjVTJb5zjze1ERy0SBtDHxxc6W+Ze61nYvB+fJOaCsWdVkmCppvRu0I9mHsGWjBgrEikXOSYj
 MpnuqJ235qL5az07NHXGQYfVL5fHcF2jiIXDTaSx8nHpb0Uqh8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.2017 um 15:22 schrieb Jeff King:
> The single-traversal thing I suspect doesn't matter much in practice. In
> both cases if we would visit commit X twice, we'd immediately see on the
> second visit that it has already been cleared and not do anymore work.

Good point.  That makes clear_commit_marks_many() less useful than
advertised in e895cb5135, though.

>    Side note: Another question is whether it would simply be faster to
>    clear the flags for _all_ objects that we've touched in the current
>    process (we have clear_object_flags() for this already). Then we know
>    that we touch each one once, and we as a bonus we don't even have to
>    keep the previous tips. The downsides are:
> 
>      - if another traversal in the process looked at many objects, but
>        our current traversal looked at few, then we would examine more
>        objects than we need to (albeit with lower cost per object)
> 
>      - it's possible there's another traversal in the same process whose
>        flags we would want to have saved. I suspect such a setup is
>        broken already, though, unless there's a guarantee that the two
>        traversals don't overlap.

I thought about that nuclear option as well.  It might be a good idea
for code in cmd_* and similar leaf functions for cleaning up between
unrelated stages (e.g. between parts that had been separate external
git command calls before).  They probably only load potentially
interesting objects into memory and don't need to bother much about
interactions with other functions.

But clear_object_flags() makes me nervous because it clears the flags
of all kinds of objects, not just for commits, and I can't easily
convince myself that this is safe.  Adding a version that checks the
object type would be an easy way out.

René
