Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E99F201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 08:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdKNIn6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 03:43:58 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:48507 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdKNIn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 03:43:56 -0500
Received: by mail-wr0-f180.google.com with SMTP id 15so16754976wrb.5
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6syPSn9euvRyNMCfliUnHAX7gGkbAUTzWYS2o5VaTXo=;
        b=VBcefAQQJmJHQPj1LnKe8QS4w9iXlqgXrAtDris6eCfc+xnpMSqYJgkn7kgF4Jwat4
         43JxyRjAVB9K1YEWehEgB7dUDKQXA65wbitdGUoHxcS110ZQBaG1Sk0u6KZaBa04Gr5D
         +XBPXgseWeFyVo00l6bbDuXaRzU8GcOCyFFUQlNWfTRERfqAh6aj1arFty2ZQFM60pJd
         qwc5dl7MfrnpG39eLxT+F90IoY8Jqpiz8nSdXbDaO4KXlIzMuutz5I3ebVARNWhG/hEG
         qjJsEeu5fGqQLfuFFp4eI6eSaXaa0K7Ys+qDXT/NJlfmgHurr/1DUdmyg5W4VguYmpd4
         UVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6syPSn9euvRyNMCfliUnHAX7gGkbAUTzWYS2o5VaTXo=;
        b=IxipyFgflcwf+FGdWJsjq6OoA1ecx39djRhG8Srbj69jkjyGmUMdJDS3dc/2DlBG+V
         BMg5dEDAT0LbGy9wC4CMHjinm9MF1ewtA5AlNw8EdK5E9gVvCzaHHGkWLajJ4HfDhCV/
         W+BEwf6Gh1oAt4b5/1Me6RTl9O0kR7GBh/w8O3r0/c66ekzt17BE1d3btIgfYSCHBgvK
         FazTSGmC+ks4n3j1J3Bv58Xs01sHWO+PX/Jv9c+Fec52v1vv7cb3t/SXaQLQhqZM45Wu
         8/u/hRkyfHrm6sjwyR7p493pK1vtgXj/C5V7GtiJ04XLIjcLdQqTS6S5pbmScGAUBovg
         JX+w==
X-Gm-Message-State: AJaThX7AuDhyBxUZJLE7LypG60ZHreuRosRoAUdADC3yPaGzZQ/28wmn
        tpnYCo42Q8pcTL8mPzcR02k=
X-Google-Smtp-Source: AGs4zMbtAV5ax0xCYmhESM3GVXvuTkwsLvULGfNgDxsneTNsMCRZ1umLL1fTgyj+BU9xbWQdQ6hXBQ==
X-Received: by 10.223.199.138 with SMTP id l10mr8721988wrg.121.1510649034708;
        Tue, 14 Nov 2017 00:43:54 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id h8sm5649555wme.30.2017.11.14.00.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Nov 2017 00:43:53 -0800 (PST)
Date:   Tue, 14 Nov 2017 08:45:17 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
Message-ID: <20171114084517.GA12097@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > I'm a bit torn about hiding his behind an additional flag in git
> > worktree add or not.  I would like to have the feature without the
> > additional flag, but it might break some peoples expectations, so
> > dunno.
> 
> Yeah, I agree with the sentiment.  But what expectation would we be
> breaking, I wonder (see below)?
> 
> At the conceptual level, it is even more unfortunate that "git
> worktree --help" says this for "git worktree add <path> [<branch>]":
> 
>     If `<branch>` is omitted and neither `-b` nor `-B` nor
>     `--detach` used, then, as a convenience, a new branch based at
>     HEAD is created automatically, as if `-b $(basename <path>)` was
>     specified.
> 
> which means that it already does a DWIM, namely "since you didn't
> say what branch to create to track what other branch, we'll fork one
> for you from the HEAD, and give a name to it".  That may be a useful
> DWIM for some existing users sometimes, and you may even find it
> useful some of the time but not always.  Different people mean
> different things in different situations, and there is no single
> definition for DWIMming that would fit all of them.
> 
> Which in turn means that the new variable name DWIM_NEW_BRANCH and
> the new option name GUESS are way underspecified.  You'd need to
> name them after the "kind" of dwim; otherwise, not only the future
> additions for new (third) kind of dwim would become cumbersome, but
> readers of the code would be confused if they are about the existing
> dwim (fork a new branch from HEAD and give it a name guessed by the
> pathname) or your new dwim.

Yeah I definitely agree with that.  I was mainly thinking about my
personal use case with --guess, and didn't fully think through that it
might mean different things to other people.

> This also needs a documentation update.  Unlike the existing DWIM,
> it is totally unclear when you are dwimming in absence of which
> option.

Sorry about that, I totally forgot about the documentation for this.
Will add in the next round.

> I am guessing that, when you do not have a branch "topic" but your
> upstream does, saying
> 
>     $ git worktree add ../a-new-worktree topic
> 
> would create "refs/heads/topic" to build on top of
> "refs/remotes/origin/topic" just like "git checkout topic" would.
> 
> IOW, when fully spelled out:
> 
>     $ git branch -t -b topic origin/topic
>     $ git worktree add ../a-new-worktree topic
> 
> is what your DWIM does?  Am I following you correctly?

It's not quite what my DWIM does/what I originally intended my DWIM to
do.  What it does is when

    $ git worktree add ../topic

and omitting the branch argument, it would behave the way you spelled
out, i.e.

    $ git branch -t -b topic origin/topic
    $ git worktree add ../topic topic

instead of just checking it out from HEAD.  I must confess I missed
the branch argument, so that still behaves the old way with my code,
while what you have above would make a lot more sense.

> If so, as long as the new DWIM kicks in ONLY when "topic" does not
> exist, I suspect that there is no backward compatibility worries.
> The command line
> 
>     $ git worktree add ../a-new-worktree topic
> 
> would just have failed because three was no 'topic' branch yet, no?

Indeed, with this there would not be any backwards compatility
worries.

Ideally I'd still like to make

    $ git worktree add ../topic

work as described above, to avoid having to type 'topic' twice (the
directory name matches the branch name for the vast majority of my
worktrees) but that should then come behind a flag/config option?
Following your reasoning above it should probably be called something
other than --guess.

Maybe --guess-remote and worktree.guessRemote would do?  I'm quite bad
at naming though, so other suggestions are very welcome.
