Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1BC2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4D222C4
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 20:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="Z5vYNNLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgACUOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:14:31 -0500
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:50511 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgACUOa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Jan 2020 15:14:30 -0500
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id nT60i0rhracYcnTL3is6mV; Fri, 03 Jan 2020 20:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1578082469;
        bh=drGnZGp402S/bpbJpysMkKNKtm7MBJiWZxIGTh4lS+s=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Z5vYNNLirVxoZX81I4reIAY1vriZKXVQeRSSVUGqNyvUupUvdh1nf261K7UnTsz6C
         W5jo9dIA9oGRZogfQ1iHH+TW4rZp93pNAbr+N9dtmWCESZF3pwTYoDKZQaTvK/J/R9
         WghA8mNwpTvbEYWSo17jcelUYbJg9firYwH3kIkPHaczipCb18ICn8u2sYhywR2Ky5
         9b8DvobZr6yNzsg7+vXePx0RYKDPOQnBbr3Vb0AdiuK1sMEO/9jiQJf1fiySwTDlMs
         UrUUIIL9G7Menr6doK0Xns/Ci5iBBK3HQ7GjF3gjwNqm3ylSp32LwsZSXDsPT0nRDu
         wX6NrEUs0oafw==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:cde:e858:39ea:9e])
        by resomta-po-02v.sys.comcast.net with ESMTPSA
        id nTKxi5dWotZw9nTL2iOC1Z; Fri, 03 Jan 2020 20:14:29 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Date:   Fri, 3 Jan 2020 12:14:23 -0800
From:   Matthew DeVore <matvore@comcast.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
Message-ID: <20200103201423.GA20975@comcast.net>
References: <20191029003023.122196-1-matvore@google.com>
 <20191031003929.GA22855@google.com>
 <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 09:26:48AM +0100, Johannes Schindelin wrote:
> 
> am stands for "apply mbox", and I think that the only reason it is not
> called `git apply-mbox` is that the Linux maintainer uses it a lot and
> wanted to save on keystrokes.
> 
> Having said that, I do agree that `xl` is not a good name for this. It
> is neither intuitive, nor is it particularly easy to type (on a
> US-English keyboard, the `x` and the `l` key are far apart), and to add

There is a subjective element to this, but I would consider it easy to type
since it is using two different hands. The property of "keys are far apart" is
only bad if it's the same or close fingers doing the typing (i.e. on qwerty
layout "ve" or "my")

I'm not trying to justify an unpopular name, though :) There are other reasons
to avoid "xl". I just found your statement surprising.

> insult to injury, _any_ two-letter command is likely to shadow
> already-existing aliases that users might have installed locally.
> 

"wip" seems more descriptive to me, or "logx", as I mentioned in the reply to
Emily.

> In addition, I would think that the introduction of ephemeral refs
> should deserve its own patch. Such ephemeral refs might come in handy
> for more things than just `xl` (or whatever better name we find).
> 
> The design of such ephemeral refs is thoroughly interesting, too.
> 
> One very obvious question is whether you want these refs to be
> worktree-specific or not. I would tend to answer "yes" to that question.

We could key each set of ephemeral refs off of the ttyname(3) or as you
suggested getsid(2). As you say, the Windows analog would be the handle of the
Win32 console. (I'm guessing there is no concept of a terminal multiplexer
unless you're using MinGW or WSL, in which case we can use getsid).

getsid(2) seems the least likely to overlap with previous "keys" so we may
prefer that one.

getppid would not work that well if anyone ran the command (or any git command
that refers to the ephemeral refs) in a wrapper script (I don't mean an
automated script, which we definitely don't want people to try).

I'm not so sure I would prefer this keying mechanism myself - I may be
compelled to turn it off. I sometimes have two terminals open, visible at the
same time, and expect them to share this kind of state. So I'm reserving
judgment about whether it should be configurable or not. But it should probably
be enabled (key by session ID) by default.

Now, if we key the refs off of the current session, it seems unnecessary to key
off the worktree as well. If someone remains in the current session, but cd to
a different worktree, it would be natural for them to assume that the ephemeral
refs that are still visible in the terminal window would stil work.

> 
> Further, another obvious question is what to do with those refs after a
> while. They are _clearly_ intended to be ephemeral, i.e. they should
> just vanish after a reasonably short time. Which raises the question:
> what is "reasonably short" in this context? We would probably want to
> come up with a good default and then offer a config setting to change
> it.

I would propose expiring refs as the user introduced more sessions (getsid
values) without using old ones, like and LRU cache, and to limit the repository
to holding 16 getsid keys at a time. This way, we don't have concept of a
real-world clock, and we let people go back to a terminal window which they
left open for a month and still use refs that were left there (assuming of
course they haven't been using the repository heavily otherwise, and the
terminal content is still showing those ref numbers for them to refer to).

Now, if in session 42, the user generated some ephemeral refs with
"git log --ephemeral-refs", these would automatically destroy any existing
ephemeral refs that were created by past invocations in session 42. I don't
know how important it is that we clean those up, but it seems like the right
thing to do anyway to save disk space (at least 40 bytes per commit).

> 
> Another important aspect is the naming. The naming schema you chose
> (`h/<counter>`) is short-and-sweet, and might very well be in use
> already, for totally different purposes. It would be a really good idea
> to open that schema to allow for avoiding clashes with already-existing
> refs.
> 
> A better alternative might be to choose a naming schema that cannot
> clash with existing refs because it would not make for valid ref names.
> I had a look at the ref name validation, and `^<counter>` might be a
> better naming schema to begin with: `^1` is not a valid ref name, for
> example.

I like having a new kind of syntax to make the ref names easier to type as well
as non-conflicting with current use cases. "^" is hard-to-type if you're not
a good touch-typist, but I guess that's fine. If you're a good touch-typist,
"^" seems a tad easier to type than "h/" IMO.

I don't see any mention of "%" in "gitrevisions(7)" so maybe that's OK to use?
That is a little more of an everyday symbol than "^" so users are likely used to
typing it, and is closer to the fingers' home position. But if I remember right
this has special meaning in Windows shell (expand variables), so I guess it's
not a good idea.

> 
> Side note: why `h/`? I really tried to think about possible motivations
> and came up empty.
> 

Mostly because it's easy to type and didn't require exotic new syntax :) And the
"h" stands for hash.

> I would like to caution against targeting scripts with this. It is too
> easy for two concurrently running scripts to stumble over each other.

I think my wording before was too confusing. I totally agree we should
discourage automated scripts. Convenience scripts that are meant to be used
interactively (e.g. glorified aliases and workflow-optimization scripts) should
be allowed, and I don't think we need to do anything special to make that work.

Thank you for the feedback!
- Matt
