Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956471F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfA1STL (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:19:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:51718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727304AbfA1STK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:19:10 -0500
Received: (qmail 8190 invoked by uid 109); 28 Jan 2019 18:19:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 18:19:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27671 invoked by uid 111); 28 Jan 2019 18:19:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 13:19:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 13:19:08 -0500
Date:   Mon, 28 Jan 2019 13:19:08 -0500
From:   Jeff King <peff@peff.net>
To:     "Moocowmoo ." <moocowmoo@masternode.me>
Cc:     git@vger.kernel.org
Subject: Re: env GIT_WORK_TREE ignored by git describe --dirty
Message-ID: <20190128181908.GA11337@sigill.intra.peff.net>
References: <CANMbfiuUHxkw822AvA+y0cJ+ao=pcrza7w4fgMn7vVx8AZqCwQ@mail.gmail.com>
 <CANMbfitE+5HLo1sMowr5erJGwzLVv3Z9sHKEgvOeso5OeWVrBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANMbfitE+5HLo1sMowr5erJGwzLVv3Z9sHKEgvOeso5OeWVrBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 07:52:24PM -0500, Moocowmoo . wrote:

> git describe --dirty shows dirty when cwd not repo work directory.
> 
> Confirmed by osse on freenode irc #git
> 
>   ubuntu@wrk:~/tmp$ pwd
>   /home/ubuntu/tmp
>   ubuntu@wrk:~/tmp$ git clone https://github.com/ipfs/go-ipfs.git
>   ubuntu@wrk:~/tmp$ GIT_DIR=/home/ubuntu/tmp/go-ipfs/.git
> GIT_WORK_TREE=/home/ubuntu/tmp/go-ipfs git describe --dirty
>   v0.4.18-381-gca77ecc76-dirty

It sounds like this this is the same bug being discussed in:

  https://public-inbox.org/git/20190126204951.42455-1-koraktor@gmail.com/

-Peff
