Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD0D1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967522AbeF1R1L (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:27:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:58560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967503AbeF1R1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:27:10 -0400
Received: (qmail 21317 invoked by uid 109); 28 Jun 2018 17:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 17:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23086 invoked by uid 111); 28 Jun 2018 17:27:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 13:27:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 13:27:07 -0400
Date:   Thu, 28 Jun 2018 13:27:07 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across
 different platform types
Message-ID: <20180628172707.GA31766@sigill.intra.peff.net>
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
 <20180628024446.GD644867@genre.crustytoothpaste.net>
 <20180628143405.GA16657@sigill.intra.peff.net>
 <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 07:21:18PM +0200, Lars Schneider wrote:

> How about this:
> 
> 1) We allow users to set the encoding "auto". Example:
> 
> 	*.txt working-tree-encoding=auto
> 
> 2) We define a new variable `core.autoencoding`. By default the value is 
> UTF-8 (== no re-encoding) but user can set to any value in their Git config. 
> Example:
> 
>     git config --global core.autoencoding UTF-16
> 
> All files marked with the value "auto" will use the encoding defined in
> `core.autoencoding`.
> 
> Would that work?

Yeah, that was along the lines that I was thinking. I wonder if anybody
would ever need two such auto-encodings, though. Probably not. But
another way to think about it would be to allow something like:

  working-tree-encoding=foo

and then in your config "foo" to map to some encoding.

But that may be over-engineering, I dunno. utf8 has always been enough
for me. :)

-Peff
