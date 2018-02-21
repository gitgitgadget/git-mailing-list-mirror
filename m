Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CD61F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUWPT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:15:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:59926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750738AbeBUWPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:15:19 -0500
Received: (qmail 17738 invoked by uid 109); 21 Feb 2018 22:15:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 22:15:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27700 invoked by uid 111); 21 Feb 2018 22:16:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 17:16:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 17:15:16 -0500
Date:   Wed, 21 Feb 2018 17:15:16 -0500
From:   Jeff King <peff@peff.net>
To:     Dorian Taylor <dorian.taylor.lists@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug in HTTP protocol spec
Message-ID: <20180221221516.GA7944@sigill.intra.peff.net>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 10:29:35AM -0800, Dorian Taylor wrote:

> I didn’t get an insight until I ran with GIT_TRACE_PACKET=true on a known-good remote (i.e. GitHub), that the null packet-line `0000` has to follow the service line. This is not reflected in the example here:
> 
> https://github.com/git/git/blob/6464679d9620d91b639e2681b9cc6473f3856d09/Documentation/technical/http-protocol.txt#L216

This is missing the trailing flush after the ref advertisement, too.

> It is also not reflected in the BNF:
> 
> https://github.com/git/git/blob/6464679d9620d91b639e2681b9cc6473f3856d09/Documentation/technical/http-protocol.txt#L279
> 
> (Note these links are from the most recent commit of this file as of this writing.)
> 
> Just thought somebody would like to know.

Thanks, I agree the document is buggy. Do you want to submit a patch?

-Peff
