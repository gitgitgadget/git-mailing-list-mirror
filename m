Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404BC1FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 07:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdDHHax (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 03:30:53 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:45170 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdDHHaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 03:30:52 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Apr 2017 03:30:52 EDT
Received: from [192.168.42.152] (dslb-188-102-145-188.188.102.pools.vodafone-ip.de [188.102.145.188])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 7D076300111;
        Sat,  8 Apr 2017 09:24:06 +0200 (CEST)
To:     matt@mattmccutchen.net (Matt McCutchen), git@vger.kernel.org (git)
In-Reply-To: <1491617750.2149.10.camel@mattmccutchen.net>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Sat, 8 Apr 2017 09:24:06 +0200
Message-ID: <1n45nzn.ab6mgwjoledxM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> wrote:

> When I'm rewriting history, "git push --force-with-lease" is a nice
> safeguard compared to "git push --force", but it still assumes the
> remote-tracking ref gives the old state the user wants to overwrite. 
> Tools that do an implicit fetch, assuming it to be a safe operation,
> may break this assumption.  In the worst case, Visual Studio Code does
> an automatic fetch every 3 minutes by default [1], making
> --force-with-lease pretty much reduce to --force.

That's a big problem, but even without such tools, I find
--force-with-lease without an argument to be pretty limited in
usefulness.

I like to type "git fetch" myself regularly, just to see what's new
upstream before integrating it; this already breaks it. But even
avoiding "git fetch" doesn't help if you are working on more than one
branch at a time, because doing "git pull" on one branch will do an
implicit "git fetch" on the other.

I like the idea of git maintaining a separate "last integrated" commit
for each branch, I think this could solve it in a nice way. I'm probably
not qualified enough to work on this myself though, but I'm happy to
give input if someone else wants to.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
