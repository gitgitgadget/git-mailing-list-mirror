Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710BA1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeGBSUT (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:20:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:56548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752208AbeGBSUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:20:18 -0400
Received: (qmail 30854 invoked by uid 109); 2 Jul 2018 18:20:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 18:20:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23540 invoked by uid 111); 2 Jul 2018 18:20:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 14:20:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 14:20:16 -0400
Date:   Mon, 2 Jul 2018 14:20:16 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Steve Groeger <GROEGES@uk.ibm.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180702182016.GB12208@sigill.intra.peff.net>
References: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
 <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
 <OFAD36A6D5.F36D27E7-ON002582BE.0043296C-002582BE.0043297F@notes.na.collabserv.com>
 <4621C69D-B837-43ED-8570-462D4CF2BBA0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4621C69D-B837-43ED-8570-462D4CF2BBA0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 02, 2018 at 04:09:32PM +0200, Lars Schneider wrote:

> Brian had a good argument [1] for an even more flexible system
> proposed by Peff:
> 
> 
> 1) We allow users to define custom encoding mappings in their Git config. 
> Example:
> 
>     git config --global core.encoding.myenc UTF-16

I think this should be encoding.myenc.something. In Git's config format,
only the subsection names (the middle of a three-dot name) are
unconstrained. So even if encoding.myenc only ever has one key
("replace" or "useInstead" or whatever you want to call it), there's
value in organizing the namespace that way.

And as a bonus, it leaves room for extending the feature later if we do
need more keys.

-Peff
