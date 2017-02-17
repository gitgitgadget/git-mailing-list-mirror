Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E267201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934956AbdBQUoV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:44:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:57409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934894AbdBQUoT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:44:19 -0500
Received: (qmail 20169 invoked by uid 109); 17 Feb 2017 20:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 20:44:13 +0000
Received: (qmail 5819 invoked by uid 111); 17 Feb 2017 20:44:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 15:44:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 15:44:11 -0500
Date:   Fri, 17 Feb 2017 15:44:11 -0500
From:   Jeff King <peff@peff.net>
To:     greg0ire <postmaster@greg0ire.fr>
Cc:     git@vger.kernel.org
Subject: Re: dotfiles in git template dir are not copied
Message-ID: <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:31:37AM +0100, greg0ire wrote:

> I noticed yesterday that dotfiles inside the directory configured in
> init.templatedir are not copied when creating a new repository.
> 
> Here is the line I think is responsible for this behavior :
> https://github.com/git/git/blob/master/builtin/init-db.c#L48
> 
> Is it a bug or a feature?

I think it's probably a feature. You could, for example, have your
template directory itself be a git repository. You would not want to
copy the ".git" directory around.

I wouldn't be surprised if the documentation could be improved, though.

-Peff
