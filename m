Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A291F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJJV4C (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:56:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:35522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726647AbeJJV4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:56:01 -0400
Received: (qmail 24176 invoked by uid 109); 10 Oct 2018 14:33:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 14:33:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17777 invoked by uid 111); 10 Oct 2018 14:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 10:32:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 10:33:33 -0400
Date:   Wed, 10 Oct 2018 10:33:33 -0400
From:   Jeff King <peff@peff.net>
To:     Naja Melan <najamelan@autistici.org>
Cc:     git@vger.kernel.org, id@joeyh.name
Subject: Re: bug when combined with etckeeper
Message-ID: <20181010143333.GA3854@sigill.intra.peff.net>
References: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 09:33:00AM +0000, Naja Melan wrote:

> I ran into a strange bug. In the following script the commit at the end will fail with: 
> 
> > The following paths are ignored by one of your .gitignore files:
> > .etckeeper
> > Use -f if you really want to add them.
> 
> Note that there is no .gitignore file and no `.etckeeper` file in the
> repository, there is nothing in .git/exclude.

That's weird. Do you have any git-related environment variables set? Or
anything in your config that might be pointing git to an alternate
repository or working tree?

Try:

  env | grep GIT

and:

  git config --list --show-origin

-Peff
