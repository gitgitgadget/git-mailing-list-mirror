Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557E21F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbeKTH67 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:58:59 -0500
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:49325
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbeKTH67 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Nov 2018 02:58:59 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2018 02:58:59 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id Or3UgmrqOTdR5Or3WgjJVS; Mon, 19 Nov 2018 14:26:07 -0700
Date:   Mon, 19 Nov 2018 23:26:03 +0200
From:   Max Kirillov <max@max630.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181119212603.GC5348@jessie.local>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfJ0kegnZ4coLZSH3zma8jtmQQO7ehq+g4wmD0Z983KEEAZiT4rmPO4R6lxA28GIreAlrGR9OTbGFpiaby23bwI1tYcmJyGRZVF/2uZTC7UR/9x94XO5j
 I7lLzNaXu2L7b0R6Xgl9Iw32LQipwaP0sAPxcO2C+QSFan9pdAH4OHP+Potug0xMad3FCuf3miMLRq1pqARe7snLAr5VWoa8mAXy8Oi3gLZqWnQcAARr6bF6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 11:36:08AM -0800, Carlo Arenas wrote:
> NO_CURL reflects the build setting (for http support); CURL checks for
> the curl binary, but as Ævar points out the requirements must be from
> somewhere else since a NO_CURL=1 build (tested in macOS) still passes
> the test, but not in NetBSD.
> 
> tests 3-8 seem to fail because perl is hardcoded to /urs/bin/perl in
> t5562/invoke-with-content-length.pl,

I see.

In other perl files I can see either '#!/usr/bin/perl' or
'#!/ust/bin/env perl'. The second one should be more
portable. Does the latter work on the NetBSD?

To all: what is supposed to be done about it?

> while I seem to be getting some
> sporadic errors in 9 with the following output :

This is more complicated.

Does it happen often?

Does test 12 ("push gzipped") ever fail?

So far I can imagine either a buffering issue or some
mistake in length calculation.
