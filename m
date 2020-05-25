Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED059C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEFE20776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgEYSWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 14:22:10 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35155 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSWK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 14:22:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB891300061B8;
        Mon, 25 May 2020 20:22:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 884335B4F7; Mon, 25 May 2020 20:22:05 +0200 (CEST)
Date:   Mon, 25 May 2020 20:22:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
Message-ID: <20200525182205.7hcffndaro2pgink@wunner.de>
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
 <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
 <xmqq1roo947y.fsf@gitster.c.googlers.com>
 <87sgfvq967.fsf@igel.home>
 <20200520194019.GA340985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520194019.GA340985@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 03:40:19PM -0400, Jeff King wrote:
> The "too big fetch" issue has since been fixed in "master", as well as
> reverting the switch to the v2 protocol (which I think is just
> belt-and-suspenders; AFAIK there are no known issues after the fix).
> Both will be in v2.27. I don't see anything on "maint", but they _could_
> be part of an eventual v2.26.3.
> 
> The fix was merged in 0b07eecf6e (Merge branch 'jt/v2-fetch-nego-fix',
> 2020-05-01) for reference.

Please consider cutting a v2.26.3 release with this fix at your
earliest convenience.  The waste of bandwidth is mind-boggling.
(> 1 GByte whenever fetching from a kernel remote.)

Thanks,

Lukas
