Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89D2209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdFFSnk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:43:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:35522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbdFFSmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:42:03 -0400
Received: (qmail 21118 invoked by uid 109); 6 Jun 2017 18:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 18:42:02 +0000
Received: (qmail 26671 invoked by uid 111); 6 Jun 2017 18:42:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 14:42:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jun 2017 14:42:01 -0400
Date:   Tue, 6 Jun 2017 14:42:01 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        David <bouncingcats@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: What does this output of git supposed to mean ?
Message-ID: <20170606184200.4xohdrwxqqvxgkr7@sigill.intra.peff.net>
References: <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
 <20170606114355.30749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170606114355.30749-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 01:43:55PM +0200, SZEDER Gábor wrote:

> > An alternative ,with slightly less textual change, could be "Waiting for 
> > initial commit"
> > </bikeshed>
> 
> We should consider orphan/unborn branches, too:
> 
>   git (master)$ git checkout --orphan newroot
>   Switched to a new branch 'newroot'
>   git (newroot +)$ git reset --hard
>   git (newroot #)$ git status
>   On branch newroot
>   
>   Initial commit
>   
>   nothing to commit (create/copy files and use "git add" to track)
> 
> A purely textual change will not be sufficient, I'm afraid.  Saying
> "Repository is empty" right after 'git init' is fine, I like it.
> However, on an unborn branch with empty index it would be just wrong.
> 
> "Waiting for initial commit" is much better even in this case, but I
> still don't like that "initial", though I can't say why, and don't
> have any better suggestion either.  Though users experienced enough to
> create an empty unborn branch would probably not be confused by that.

I agree. If the state we are describing is limited to the current
branch, how about saying so? Like "Your current branch has no commits".

-Peff
