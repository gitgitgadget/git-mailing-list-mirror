Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0957F2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 00:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbdCCAp3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 19:45:29 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35686 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdCCAp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 19:45:28 -0500
Received: by mail-pg0-f43.google.com with SMTP id b129so37648019pgc.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 16:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9I8v2hAdDUpcpYH/wy9SIqV8oxvGmOI9uBnvLhHet8=;
        b=u6jksp7vBT3Gn1UaZav+xbpe1nBXfauotLRBSPGruoMaoHETMr6AyJhCrxF3chH6DT
         z7TdV0EZe7exIqtOI9kSnsbmemdTwKiVAqKkJyWR4xZatckEke9lF9QuFBmCwxpUHHDE
         15+/NN0oPJDn0ZhqTVXySPG8j8oyAYRgCD/elaifNZY8CY62AmPqKIH9+6JYncJ6rjSc
         mRpOXDdmsktQlGcwudzgp3mkWz8dj+RlB7hFkp57a2tC4BEQg11FX4U3Robo9I4i7Phh
         +ydEosbnDEoeJKiFrns3PW3hrYWbmWq+9TPX7gDWca+LaGtTA/bT1xQPQJlql8YojFjo
         xK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9I8v2hAdDUpcpYH/wy9SIqV8oxvGmOI9uBnvLhHet8=;
        b=A7n+1SqEowN92L0ZQkmktwEJFvR4YBJkF/pBGHgX7Om1A2QFXUBhm1li+E8PqQs9YW
         5fVK0hKc2xUYLmqJgIULLk1Q7Jv/r0rtXFK+A5pshq9YqAqfucaV2NXNCYUBrYdLwFqo
         0XaG3K4BP4JtCP1XpRiu1s7m+rG2sCjatKwxCM+G1AeZOxzhRPzu0bWc/4K/+I5t9OJy
         7Ra0ciIGle13DmJXZjKcLx/zdQTvvc8ntbFfPgb3rsShRCsi/bfvU3HgflMaV5HZSkPK
         I8XpkxB+uIITl3Jy/9dmBgVeI+EJ5W/0mPXs+mu6hmwLv7QCUqOsvx3ePOjdQc8NF9cj
         xBgg==
X-Gm-Message-State: AMke39lU+u0SjNOEU0AARVSVuGnQB3K/1JMWjDMXu8s37fJbVSb0WlPwfuppgd7q/BzM171h
X-Received: by 10.84.208.227 with SMTP id c32mr21516376plj.71.1488491172997;
        Thu, 02 Mar 2017 13:46:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d033:6603:834d:8912])
        by smtp.gmail.com with ESMTPSA id x10sm18883919pfi.117.2017.03.02.13.46.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 13:46:12 -0800 (PST)
Date:   Thu, 2 Mar 2017 13:46:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170302214610.GA86054@google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
 <20170226011359.GI11350@io.lakedaemon.net>
 <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Jeff King wrote:
> On Sun, Feb 26, 2017 at 01:13:59AM +0000, Jason Cooper wrote:
> 
> > On Fri, Feb 24, 2017 at 10:10:01PM -0800, Junio C Hamano wrote:
> > > I was thinking we would need mixed mode support for smoother
> > > transition, but it now seems to me that the approach to stratify the
> > > history into old and new is workable.
> > 
> > As someone looking to deploy (and having previously deployed) git in
> > unconventional roles, I'd like to add one caveat.  The flag day in the
> > history is great, but I'd like to be able to confirm the integrity of
> > the old history.
> > 
> > "Counter-hashing" the blobs is easy enough, but the trees, commits and
> > tags would need to have, iiuc, some sort of cross-reference.  As in my
> > previous example, "git tag -v v3.16" also checks the counter hash to
> > further verify the integrity of the history (yes, it *really* needs to
> > check all of the old hashes, but I'd like to make sure I can do step one
> > first).
> > 
> > Would there be opposition to counter-hashing the old commits at the flag
> > day?
> 
> I don't think a counter-hash needs to be embedded into the git objects
> themselves. If the "modern" repo format stores everything primarily as
> sha-256, say, it will probably need to maintain a (local) mapping table
> of sha1/sha256 equivalence. That table can be generated at any time from
> the object data (though I suspect we'll keep it up to date as objects
> enter the repository).
> 
> At the flag day[1], you can make a signed tag with the "correct" mapping
> in the tag body (so part of the actual GPG signed data, not referenced
> by sha1). Then later you can compare that mapping to the object content
> in the repo (or to the local copy of the mapping based on that data).
> 
> -Peff
> 
> [1] You don't even need to wait until the flag day. You can do it now.
>     This is conceptually similar to the git-evtag tool, though it just
>     signs the blob contents of the tag's current tree state. Signing the
>     whole mapping lets you verify the entirety of history, but of course
>     that mapping is quite big: 20 + 32 bytes per object for
>     sha1/sha-256, which is ~250MB for the kernel. So you'd probably not
>     want to do it more than once.

There were a few of us discussing this sort of approach internally.  We
also figured that, given some performance hit, you could maintain your
repo in sha256 and do some translation to sha1 if you need to push or
fetch to a server which has the the repo in a sha1 format.  This way you
can convert your repo independently of the rest of the world.

As for storing the translation table, you should really only need to
maintain the table until old clients are phased out and all of the repos
of a project have experienced flag day and have been converted to
sha256.

-- 
Brandon Williams
