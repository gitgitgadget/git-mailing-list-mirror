Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 6882 invoked by uid 107); 24 Aug 2009 08:25:57 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbZHXIZj (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZHXIZj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:25:39 -0400
Received: from blu0-omc1-s16.blu0.hotmail.com ([65.55.116.27]:44171 "EHLO
	blu0-omc1-s16.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751074AbZHXIZi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 04:25:38 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2009 04:25:38 EDT
Received: from BLU0-SMTP39 ([65.55.116.7]) by blu0-omc1-s16.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 01:20:22 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <BLU0-SMTP3926FD52F3B0ED67F486AAAEF90@phx.gbl>
Received: from hobo ([96.49.109.68]) by BLU0-SMTP39.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 01:20:21 -0700
Date:	Mon, 24 Aug 2009 01:20:18 -0700
From:	Sean Estabrooks <seanlkml@sympatico.ca>
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Kai Blin <kai@samba.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
In-Reply-To: <4A92476A.4060205@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	<20090824060710.6117@nanako3.lavabit.com>
	<4A92318F.6050105@microchip.com>
	<200908240946.52813.kai@samba.org>
	<4A92476A.4060205@microchip.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.5; i586-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2009 08:20:21.0540 (UTC) FILETIME=[B8F5F640:01CA2493]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 24 Aug 2009 13:25:22 +0530
Sanjiv Gupta <sanjiv.gupta@microchip.com> wrote:

Hi Sanjiv,

> What I would like is to "test *every* commit" available in the public 
> master. There would be no local changes or commits that aren't pushed in 
> the private copy.
> So I just want to clone one copy from the public master and then just 
> keep pulling commits from the public master one by one and run 
> regressions on each one.

There's no reason to ask for the commits from the public master one by
one.  You can download them all in one operation.   After that it is
a local operation to checkout each new commit and build-test it.  This
is more efficient than needing a network operation to get each commit
individually.

As an aside, you might not really need to test each and every commit.
It is likely enough to just test the most recent commit since it is
built on top of all the commits that came before it.  Essentially
you'd be testing all the new commits at once and only need to test
more commits (git bisect) if you found a regression with that first
test.

> It's a damn simple thing in SVN world.

With Git you have a complete local copy of the history.  Once you're
up to date with remote master you can checkout each new commit at 
your leisure pretty damn simply ;o)

Cheers,
Sean
