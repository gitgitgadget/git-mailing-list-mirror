Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A81220FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 10:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbcGAKk7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 06:40:59 -0400
Received: from sdaoden.eu ([217.144.132.164]:37486 "EHLO sdaoden.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbcGAKk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 06:40:58 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
	id 0270D1604A; Fri,  1 Jul 2016 12:40:52 +0200 (CEST)
Date:	Fri, 01 Jul 2016 12:41:31 +0200
From:	Steffen Nurpmeso <steffen@sdaoden.eu>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: --abbrev-commit gives longer hash than necessary
Message-ID: <20160701104131.HERNyrxUU%steffen@sdaoden.eu>
References: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
 <20160701062247.GB5358@sigill.intra.peff.net>
In-Reply-To: <20160701062247.GB5358@sigill.intra.peff.net>
User-Agent: s-nail v14.8.9-269-g036bccc
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah:	Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello Jeff!

Jeff King <peff@peff.net> wrote:
 |On Thu, Jun 30, 2016 at 09:38:45PM +0200, Steffen Nurpmeso wrote:
 |> For some time (currently with 2.9.0) know see that a single commit
 |> gives a longer hash than necessary, even though there is no
 |> ambiguity:

 |I don't know what your "git longca" alias is, but presumably it's
 |running "git log". That will show just _commit_ hashes, but the
 |abbreviation code will consider all objects.

Ah!  That indeed explains it, i didn't know that!

 |There are some places you can use an abbreviated sha1 that know they are
 |looking for a commit, but most places will generally complain if there
 |is ambiguity between a blob and commit (e.g., "git show $foo").

 |Try "git rev-list --objects --all | grep ^786d0c9".

It clashes a file blob:

  ?0[steffen@wales ]$ git rev-list --objects --all | grep ^786d0c9
  786d0c9c88e5d69eba603e3ed75d1f9cc6ec4e81
  786d0c9d09aaf4107bcaf6c201307ed9db205df5 dotlock.c

Thanks for the explanation!
It seems the left side of my brain degenerates faster than the
right one.  Uff.  How lucky i am!
Ciao.

--steffen
