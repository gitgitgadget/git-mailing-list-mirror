Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833F11F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbcHSWfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:35:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52290 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755223AbcHSWfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:35:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 51B971F859;
        Fri, 19 Aug 2016 22:35:47 +0000 (UTC)
Date:   Fri, 19 Aug 2016 22:35:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160819223547.GB16646@dcvr>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608191720040.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 18 Aug 2016, Eric Wong wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > Old dogs claim the mail list-approach works for them. Nope. Doesn't.
> > > Else you would not have written all those custom scripts.
> > 
> > git and cogito started as a bunch of custom scripts, too.
> 
> The difference is that neither git nor cogito were opinionated. Those
> custom scripts are. They are for one particular workflow, with one
> particular mail client, with a strong bias to a Unix-y environment.
> 
> I work really hard to make Git for Windows as easy and fun to use as
> possible. I just wish that we were working together to make it as easy and
> fun to contribute to Git, too.

I guess this is a fundamental difference between *nix and
Windows culture.

I enjoy using and contributing to git because it interacts well
with generic tools.  *nix kernels are optimized for this with
decent (not great)[*] process spawning and IPC performance.

I know Windows users have major performance problems with
shell scripts; but they are also largely helpless to improve
Windows kernel performance.

So, I guess monolithic tools became popular on Windows, instead.

> > I see a choice of mail client as no different than a choice of
> > text editor.  Neither my mail client or text editor is heavily
> > customized.  The key feature I rely on from both tools is piping
> > data to external commands.
> 
> There you go. That key feature seems to be unavailable in the most
> wide-spread email client: Outlook. So by not restricting the choice you
> should make it possible to use that mail client, too, right?
> 
> We do not even have a section on Outlook in our SubmittingPatches.
> 
> Okay, if not the most popular mail client, then web mail? Nope, nope,
> nope. No piping *at all* to external commands from there.
> 
> So you basically slam the door shut on the vast majority of email users.

Users have a choice to use a more scriptable mail client
(but I guess the OS nudges users towards monolithic tools)

It's unfortunate the world is so full of proprietary things;
but I think it's our responsibility as Free Software developers
to encourage the use of Free (or "Open Source") tools which
users can control.

> That is not leaving much choice to the users in my book.

Users of alpine, gnus, mutt, sylpheed, thunderbird, kmail,
roundcube, squirelmail, etc. can all download the source, hack,
fix and customize things.  It's easier with smaller software,
of course:  git-send-email does not even require learning
the build process or separate download.

<snip stuff Stefan already covered>

> > Users ought to be able to pick, choose, and replace tools as
> > they wish as long as an interchange format remains stable
> > and widely-supported.
> 
> Right. Let's talk about the interchange format called mails, for the data
> called patches. Is it stable and widely-supported?
> 
> Can users really pick and choose the tools they like most to send patches
> to the Git project? Like, the Outlook client? Or the GMail client?

Personally, I don't mind patches as MIME attachments if that
avoids corruption, MIME seems well-supported at this point.
It's not my call, though.  But as Stephan pointed, Linus
does it, too.



[*] Guess what: I have performance problems with fork/execve on
    Linux, too.  However, Linux developers already provide
    mechanisms to improve spawn performance (CLONE_VFORK and
    vfork(2)); so the next step is to get userspace like dash,
    make, perl, etc to support these.

    glibc 2.24 was just released with an improved posix_spawn
    for Linux (using CLONE_VFORK), so that's a step forward and
    might make sharing code with Windows easier, too.

    It's not a high priority for me at the moment, but I intend
    to get everything in my toolset which relies on fork+execve
    to use posix_spawn or vfork+execve instead.  I have the
    source to all of these, so at least I can do something
    about it.
