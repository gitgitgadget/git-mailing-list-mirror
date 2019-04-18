Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D02820248
	for <e@80x24.org>; Thu, 18 Apr 2019 19:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfDRTHx (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 15:07:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:34208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725785AbfDRTHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 15:07:53 -0400
Received: (qmail 3059 invoked by uid 109); 18 Apr 2019 19:07:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 19:07:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3458 invoked by uid 111); 18 Apr 2019 19:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 15:08:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 15:07:51 -0400
Date:   Thu, 18 Apr 2019 15:07:51 -0400
From:   Jeff King <peff@peff.net>
To:     "Celestino, Federico" <Celestino@xcmg-erc.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some files not ignored as they should be
Message-ID: <20190418190751.GB12260@sigill.intra.peff.net>
References: <4343deda23de48c981c91c4e9c8b0c88@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4343deda23de48c981c91c4e9c8b0c88@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 09:18:23AM +0000, Celestino, Federico wrote:

> I am facing another issue with Git.
> Please find attached the .gitignore file that I am currently using.
> My intention is to ignore all the files inside any Debug folder,
> except for .map, .hex and .bin files.
> Yet, a .out file is not ignored, as shown in the second attachment.

I don't see anything obviously wrong in your .gitignore, and I couldn't
reproduce your problem with a simple attempt[1]. However, note that
files which are already tracked in the repository will not be ignored
(nor will they be listed by check-ignore). Is it possible that the file
in question is already in the index (try grepping the output of "git
ls-files")?

-Peff

[1] Please consider cutting-and-pasting from the terminal instead of
    attaching a screenshot. It's much easier to read, and allows people
    to try to reproduce the issue without re-typing that horrifically
    long filename.
