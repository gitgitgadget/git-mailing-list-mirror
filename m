Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397791F454
	for <e@80x24.org>; Fri,  1 Nov 2019 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfKAQt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 12:49:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726825AbfKAQt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 12:49:56 -0400
Received: (qmail 27692 invoked by uid 109); 1 Nov 2019 16:49:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 16:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12288 invoked by uid 111); 1 Nov 2019 16:53:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 12:53:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 12:49:55 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191101164955.GA26219@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <20191031181920.GB70819@generichostname>
 <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
 <20191031200739.GA19313@sigill.intra.peff.net>
 <822d51af-d522-bf2c-72de-f54a4ccb3b38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <822d51af-d522-bf2c-72de-f54a4ccb3b38@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 12:29:43PM +0000, Phillip Wood wrote:

> > > I'd love to see a consensus around putting remote versions of refs/foo under
> > > refs/remote/<remote-name>/foo. To share notes I add a refspec that fetches
> > > to refs/remote/<remote-name>/notes. It is a pain that 'git pull' wont merge
> > > them for me though.
> > 
> > The trouble with that sort of scheme is that it conflicts with the
> > current namespace scheme, which puts the remote "notes" branch in
> > "refs/remotes/<remote-name>/notes". And it's not just a problem if you
> > want to have a branch called "notes". Think about what "git fetch
> > --prune" would do.
> 
> I was suggesting a convention of using refs/remote/ not refs/remotes/ for
> tracking remote refs that are not branches to avoid that problem. It's not
> ideal to have remote branches under a different namespace to all the other
> remote refs but it does avoid breaking current setups. I haven't thought it
> through but perhaps in the long run we could migrate remote branches to
> refs/remote/<remote-name>/heads/ and treat refs/remotes/<remote-name>/ as an
> alias for refs/remote/<remote-name>/heads/. As you say below we'd need to
> think about how to use remote tags as well.

Oh indeed, I totally missed that subtlety. Sorry.

> Thanks for the links, I'll have a read through them.

Maybe I've managed to trick you into working on the greater refs/remotes
organization problem, though. ;)

-Peff
