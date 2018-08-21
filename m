Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A71E1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 06:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeHUJjI (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 05:39:08 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:59676 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUJjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 05:39:08 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 82348671D1
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 08:20:23 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 6753D671C9
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 08:20:23 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Tue, 21 Aug 2018 08:20:23 +0200
Message-Id: <5B7BAF25020000A10002CE20@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Tue, 21 Aug 2018 08:20:21 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <peff@peff.net>
Cc:     <git@vger.kernel.org>
Subject: Re: Antw: Re: non-smooth progress  indication for git fsck and
 git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net>
 <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
 <87woslpg9i.fsf@evledraar.gmail.com>
 <20180821010712.GA32126@sigill.intra.peff.net>
In-Reply-To: <20180821010712.GA32126@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Jeff King <peff@peff.net> schrieb am 21.08.2018 um 03:07 in Nachricht
<20180821010712.GA32126@sigill.intra.peff.net>:
> On Mon, Aug 20, 2018 at 10:57:13AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
[...]
> So it really should just be a simple:
> 
>   progress = start_delayed_progress("Hashing packfile", 0);
> 
> That said, counting bytes would probably be ugly (just because the
> numbers get really big). We'd probably prefer to show a throughput or

Hi!

With big numbers you could apply scaling (the usual ISO suffixes), but after
having read GBs, there wouldn't be much change visible unless you add
significant fractional digits.
So scaling seems good for absolute numbers, but not for growing numbers. Of
course one could recursively scale the fractional parts again, but then the
result will be lengthy again, then.

Regards,
Ulrich

> something. And as you noted, there's some refactoring to be done with
> pack-check for it to show multiple progress meters.
> 
> (I still think in the long run we would want to scrap that code, but
> that's a much bigger job; I'm fine if somebody wants to do incremental
> improvements in the meantime).
> 
> -Peff



