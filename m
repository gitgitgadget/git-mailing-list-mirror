Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EA51F955
	for <e@80x24.org>; Mon,  1 Aug 2016 07:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbcHAHBI (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 03:01:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33136 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbcHAHBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 03:01:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9071F71B;
	Mon,  1 Aug 2016 07:00:37 +0000 (UTC)
Date:	Mon, 1 Aug 2016 07:00:37 +0000
From:	Eric Wong <e@80x24.org>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
Message-ID: <20160801070037.GA18261@starla>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On Mon, Aug 01, 2016 at 01:05:56AM +0000, Eric Wong wrote:
> > +		while (*cp && *cp == ' ')
> > +			cp++;
> 
> So it looks like this function splits on spaces but doesn't provide any
> escaping mechanism.  Is there any case in which we want to accept
> environment variables containing whitespace?  I ask this as someone that
> has EDITOR set to "gvim -f" on occasion and seeing how tools sometimes
> handle that poorly.

Yes, it's only split on spaces right now.  While I don't think
there's any current case where spaces would be useful/desirable;
I suppose a 3rd patch in this series could add support for using
split_cmdline (from alias.c)...
