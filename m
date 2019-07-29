Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F381F462
	for <e@80x24.org>; Mon, 29 Jul 2019 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfG2KK4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 06:10:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:53908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726358AbfG2KK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 06:10:56 -0400
Received: (qmail 21727 invoked by uid 109); 29 Jul 2019 10:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 10:10:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27004 invoked by uid 111); 29 Jul 2019 10:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 06:12:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 06:10:55 -0400
From:   Jeff King <peff@peff.net>
To:     Gary Poli <GPoli@innout.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: 2.22 issue across samba
Message-ID: <20190729101054.GB2755@sigill.intra.peff.net>
References: <6e717834410e46d7b194785323dc4cbb@innout.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e717834410e46d7b194785323dc4cbb@innout.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 08:15:49PM +0000, Gary Poli wrote:

> I'm running git for windows installed locally. Windows 10 Pro version
> 1903 OS Build 18362.239. I have a repository on a UNIX machine running
> AIX 7.1 TL4 SP2. I use SAMBA 3.0.23d to mount the drive for use. I
> upgraded to git 2.22 and am having issues. Even starting from a fresh
> clone of the repo, the head immediately detaches. After a few commands
> like status or branch it stops recognizing the repo altogether. I
> suspect it is having trouble reading or writing to itself; perhaps the
> index is getting corrupted. I reverted to git 2.14 and I'm working
> fine again. I've got my system admin looking into updating both AIX
> and SAMBA, but I thought I would report the issue here as well. Let me
> know if you need anything else from me. Thanks.

I don't have any particular thoughts on what might be the cause here.
But if:

  - you can reliably produce the problem on git 2.22 but not on git 2.14

and

  - you are able to build Git from source

then it would be useful to use git-bisect between those versions to find the
commit introducing the problem.

-Peff
