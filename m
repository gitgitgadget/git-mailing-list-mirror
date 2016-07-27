Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5432203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcG0S6k (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:58:40 -0400
Received: from mx.spodhuis.org ([94.142.241.89]:37531 "EHLO mx.spodhuis.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328AbcG0S6j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:58:39 -0400
X-Greylist: delayed 1014 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jul 2016 14:58:38 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=spodhuis.org; s=d201602; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date;
	bh=lhr40+zjdGz5wPQkAi7BLBeBhRjEGuN0kV6WC0DrXhw=; b=CBCumeX4PM2WulsdDsSjaIadmx
	CTRPEM+vw0bUMA2tBDARIM8SVfvrBx9J0vE4vSeMfJYfygbFlAOlXuSaOq0k1haxxPHfDhpVl7xIY
	JgsN9gxg7ETa77zP9o/wC60n4Lz8m6PIkXENmfvHdY3sj0uwyu1rqOI5mUyOYbl1NslIK78nxTEFL
	hVkwwYNv4JsnGm11adgNYlYwmnCD;
Received: from authenticated user by smtp.spodhuis.org with esmtpa 
	id 1bSTm2-0006aX-1s; Wed, 27 Jul 2016 18:41:42 +0000
Date:	Wed, 27 Jul 2016 18:41:41 +0000
From:	Phil Pennock <phil.pennock@spodhuis.org>
To:	Jeff King <peff@peff.net>
Cc:	Phil Pennock <phil@pennock-tech.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727184141.GA23975@tower.spodhuis.org>
References: <20160727081414.GA21451@breadbox>
 <20160727175622.GA9961@sigill.intra.peff.net>
 <20160727181334.GA24224@tower.spodhuis.org>
 <20160727183203.GE32219@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160727183203.GE32219@sigill.intra.peff.net>
OpenPGP: url=https://www.security.spodhuis.org/PGP/keys/0x4D1E900E14C1CC04.asc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-27 at 14:32 -0400, Jeff King wrote:
> Yeah, I agree the "!" test for "did it work" is counter-intuitive if you're
> coming from other languages, but it's pretty normal for C code bases
> (especially ours).

For stuff returning pointers, sure.

> Ah. Yeah, those are wrong and bad. We should fix that.

K, noted, will go back over this thread before I touch code and pick
these all up.

> I don't buy the tabs-become-spaces argument. We use tabs for indentation
> in Git, and that's extremely unlikely to change. If your patch gets
> munged in transit or by your editor, then the maintainer is going to
> complain when applying your patch.

Okay.  (I happen to think that robustness against a cycle of developers
discussing why whitespace broke patches in transit is good, but I'll
change this).

> The magic function you are looking for is "test_tick()", which advances

Ah.  Too tired last night, didn't realize that when I switched from
constructing things on branches to have branch action in the reflog, to
"just need commits really", to "previous tests did this" I lost the
`test_tick()` invocation and for some reason when I looked at the
results, decided I must be missing something about resolution instead of
realizing that I was no longer calling `test_tick()`.

Which leads to a final point:

I'm not going to write any more code today, for reasons of "weak human
needs sleep and I'll make more stupid mistakes if I continue".  So I'm
going silent on this thread for the rest of today.  Not ignoring.  If
folks want fast progress (I haven't looked at release cycle status) I
won't mind cutting me out of the loop :-D but otherwise I'll look
Thu/Fri this week for any remedial work and offer a fresh patch with
fixes from this thread, and documentation.

I'm tempted to just steal the docs from Ted's patch, unless that's
considered bad form?

-Phil
