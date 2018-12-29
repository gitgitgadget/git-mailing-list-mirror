Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73671F405
	for <e@80x24.org>; Sat, 29 Dec 2018 06:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeL2GNw (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 01:13:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44440 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeL2GNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 01:13:52 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1F3E21F405;
        Sat, 29 Dec 2018 06:13:52 +0000 (UTC)
Date:   Sat, 29 Dec 2018 06:13:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org, meta@public-inbox.org
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
Message-ID: <20181229061352.GA5935@dcvr>
References: <20181229034342.11543-1-e@80x24.org>
 <20181229035621.cwjpknctq3rjnlhs@dcvr>
 <20181229043858.GA28509@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229043858.GA28509@pure.paranoia.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Sat, Dec 29, 2018 at 03:56:21AM +0000, Eric Wong wrote:
> > Hey all, I just added this to the TODO file for public-inbox[1] but
> > obviously it's intended for git.git (meta@public-inbox cc-ed):
> > 
> > > +* Contribute something like IMAP IDLE for "git fetch".
> > > +  Inboxes (and any git repos) can be kept up-to-date without
> > > +  relying on polling.
> > 
> > I would've thought somebody had done this by now, but I guess
> > it's dependent on a bunch of things (TLS layer nowadays, maybe
> > HTTP/2), so git-daemon support alone wouldn't cut it...
> 
> Polling is not all bad, especially for large repository collections. I'm
> not sure you want to "idle" individual repositories when there's
> thousands of them. We ended up writing grokmirror for replicating
> repo collections using manifest files.

I wasn't intending it for giant sites like korg, but for
individual hackers on their workstations tracking a handful of
projects they follow.

The cost for a hackers' machine would be the same as the current
situation where developers idle on IRC channels for the projects
they're involved in.

> > Anyways, until this is implemented, feel free to continue
> > hammering a way on https://public-inbox.org/git/ with frequent
> > "git fetch".  I write C10K servers in my sleep -_-
> 
> The archive is also mirrored at
> https://git.kernel.org/pub/scm/public-inbox/vger.kernel.org/git.git, and
> also on kernel.googlesource.com.

Now, I'm wondering if you can make a v2 public-inbox mirror of
git@vger and run it on lore.  Converting public-inbox.org/git to
v2 would break things for everybody fetching, right now :<
