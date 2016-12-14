Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F20E203C1
	for <e@80x24.org>; Wed, 14 Dec 2016 08:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbcLNIAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:00:24 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50090 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754689AbcLNIAY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:00:24 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9EB65203C1;
        Wed, 14 Dec 2016 07:59:03 +0000 (UTC)
Date:   Wed, 14 Dec 2016 07:59:03 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: some updates for public-inbox readers
Message-ID: <20161214075903.GA22774@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, bad news:

There's been some hardware problems the past week or so and a
few minutes of scattered downtime and high latency as a result.
Hopefully no lost messages, as SMTP should retry.

Getting things migrated to different hardware in a few
minutes, so maybe the new hardware will have fewer gremlins
(but we could always end up with more gremlins...)

To encourage independently-run mirrors and decentralization:
I will never guarantee the continued availability of any
service I run.


The (maybe) good news:

I'm probably a day or so away from deploying RFC 4685 support
for threading the Atom feeds at
http://hjrcffqmbrq6wope.onion/git/new.atom
http://czquwvybam4bgbro.onion/git/new.atom
https://public-inbox.org/git/new.atom

The implementation is here:
http://hjrcffqmbrq6wope.onion/meta/20161213023330.6104-1-e@80x24.org/
http://czquwvybam4bgbro.onion/meta/20161213023330.6104-1-e@80x24.org/
https://public-inbox.org/meta/20161213023330.6104-1-e@80x24.org/

But I'm not sure if there's any widely-used feed readers capable
of doing proper threading like a good mail/news client can, yet.
Perhaps this will be a step to get feed reader authors
to implement threading support (and find bugs in my generator!).

I don't believe this feature will break existing feed readers;
at least not the command-line ones I've tried.  But maybe it
does and I'll have to put threading in a different endpoint
(that would hurt cache hit rates :<)


I'll also increase the size of the feed from the measly 25
entries to something more at some point....  Hopefully it won't
cause somebody's feed reader to fall over when the feed grows; but
25 entries is not enough for higher-traffic lists, and a recent
change means buffering big feeds for slow clients is now bounded
to one message (instead of potentially using all space):
http://hjrcffqmbrq6wope.onion/meta/20161203015045.9398-1-e@80x24.org/
http://czquwvybam4bgbro.onion/meta/20161203015045.9398-1-e@80x24.org/
https://public-inbox.org/meta/20161203015045.9398-1-e@80x24.org/


Anyways, if you always want to be up-to-date; don't feel bad
about hammering the Atom feed every few seconds, or even running
"git fetch" every minute.  The servers can handle it; and we'll
find out if they don't!

And of course you can also clone the code:

	git clone http://hjrcffqmbrq6wope.onion/public-inbox
	git clone https://public-inbox.org/

and run everything yourself off your list subscription
(Maybe it's near time to do a proper release;
 I guess the project is 10% "complete" at this point)

Tor hidden service mirrors remain on different (better) hardware
and networks, and have historically higher reliability:

        http://czquwvybam4bgbro.onion/git/
        http://hjrcffqmbrq6wope.onion/git/
        nntp://czquwvybam4bgbro.onion/inbox.comp.version-control.git
        nntp://hjrcffqmbrq6wope.onion/inbox.comp.version-control.git

But it's winter and storms are coming...
