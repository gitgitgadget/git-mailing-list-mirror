Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034ACC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 01:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DB20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 01:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="EJjYbEP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgBGBjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:39:25 -0500
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:34260 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbgBGBjZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 20:39:25 -0500
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id zry5ikMTUWJ0Pzsc8iPakn; Fri, 07 Feb 2020 01:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1581039564;
        bh=3tDhUDFV6hj0R5D7yAMYbQKMYuDpHvD9NsLIP0uN6YY=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=EJjYbEP21Boe1nTlfmrUuM9yQgo+6yT5VU7s86OYvQ6/7XHpyV42vuRn3R0Qh0SGg
         sAHle9lxWiT/t4/96H1PgUqH8sI6bl0xSFLgoPjRvjgwINM+uP5HdMI6k4nutgCrbA
         DsF3J4cd05CBbbbTmu2sSrmtcRlVXb22SK7/klHXrCROBXLa/hc0jdJXCEcfZeYc4e
         gsOtzjSWP7Wi/YIZV5RWyKtrGIAuoisNURbFTEvRPKi5WlsXQR1CbkkQiqHOtdMxwE
         9L6asYx4HDOmS83N76+vVnzuO7jsRYgOg0rIHNUGJPxnNgLVg3k/vJ3rHxO2OjiUau
         2XOUHlkkaGaDA==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:b507:9923:3e5f:c456])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id zsc2iOEqa1cVdzsc7iizof; Fri, 07 Feb 2020 01:39:23 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Date:   Thu, 6 Feb 2020 17:39:18 -0800
From:   Matthew DeVore <matvore@comcast.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
Message-ID: <20200207013918.GA459@comcast.net>
References: <20191029003023.122196-1-matvore@google.com>
 <20191031003929.GA22855@google.com>
 <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
 <20200103201423.GA20975@comcast.net>
 <nycvar.QRO.7.76.6.2001042131430.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001042131430.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 04, 2020 at 10:21:59PM +0100, Johannes Schindelin wrote:
> > There is a subjective element to this, but I would consider it easy to type
> > since it is using two different hands. The property of "keys are far apart" is
> > only bad if it's the same or close fingers doing the typing (i.e. on qwerty
> > layout "ve" or "my")
> 
> Of course it is subjective! That's what I pointed out. And based on that
> reasoning, I think it would be a mistake to use that name: it is _waaaaay_
> too subjective.
> 

OK, the names I've given so far are pretty bad, and we don't have to give it a
name anyway, since we can just make it a "mode" on an existing command, so
there's not a whole lot left to discuss.

But I'm confused about this particular part of this thread, and since this is
related to naming in general, and I think about this kind of thing constantly
for a pet project, I'd like to get clarification: how exactly is "xl" hard to
type? So the keys are far apart on they keyboard - is that actually what makes
it hard? I always thought using two separate hands made something easy to type.

> > or "logx", as I mentioned in the reply to Emily.
> 
> That name does not get my support, either. My mathematician self
> associates `logx` with the natural logarithm of `x`.
> 
> I don't find this intuitive at all.
> 
> Mind, there are tons of unintuitive parts in Git's UI, but that should not
> encourage anyone to make the situation even worse. To the contrary, it
> should encourage you to do better than what is there already (think "Lake
> Wobegon Strategy").
> 

Fair enough. I basically agree with all the other things you said about naming.

> > I would propose expiring refs as the user introduced more sessions (getsid
> > values) without using old ones, like and LRU cache, and to limit the repository
> > to holding 16 getsid keys at a time. This way, we don't have concept of a
> > real-world clock, and we let people go back to a terminal window which they
> > left open for a month and still use refs that were left there (assuming of
> > course they haven't been using the repository heavily otherwise, and the
> > terminal content is still showing those ref numbers for them to refer to).
> 
> I don't know about you, but personally, when I find a window that had been
> open for a gazillion days, there is a good chance that it is stale.
> 

Yes, there is a good chance that it is stale, especially for your work
flow and habits (I know not everyone garbage collects their terminals
pro-actively). But still, the text is there on the screen, and for some people,
the fact that it's on the screen is enough to consider it meaningful.

There is an obvious peril to choosing an expiration date for the refs, and that
is that for someone somewhere, you chose an expiration date that was too soon.
So you solve it by extending the expiration date out a long time. Imagine we
determine that expiration date that won't screw anyone over is 1 week in the
future. Now you have no risk of bothering anyone. But what have you
accomplished then? You have protected the user from referencing a ref which
they would not in their right mind think is valid because it is so old.

So you are better off not relying on time for expiration.

> > > Another important aspect is the naming. The naming schema you chose
> > > (`h/<counter>`) is short-and-sweet, and might very well be in use
> > > already, for totally different purposes. It would be a really good idea
> > > to open that schema to allow for avoiding clashes with already-existing
> > > refs.
> > >
> > > A better alternative might be to choose a naming schema that cannot
> > > clash with existing refs because it would not make for valid ref names.
> > > I had a look at the ref name validation, and `^<counter>` might be a
> > > better naming schema to begin with: `^1` is not a valid ref name, for
> > > example.
> >
> > I like having a new kind of syntax to make the ref names easier to type as well
> > as non-conflicting with current use cases. "^" is hard-to-type if you're not
> > a good touch-typist, but I guess that's fine. If you're a good touch-typist,
> > "^" seems a tad easier to type than "h/" IMO.
> >
> > I don't see any mention of "%" in "gitrevisions(7)" so maybe that's OK to use?
> > That is a little more of an everyday symbol than "^" so users are likely used to
> > typing it, and is closer to the fingers' home position. But if I remember right
> > this has special meaning in Windows shell (expand variables), so I guess it's
> > not a good idea.
> 
> From the current `refs.c`:
> 
> 	/*
> 	 * How to handle various characters in refnames:
> 	 * 0: An acceptable character for refs
> 	 * 1: End-of-component
> 	 * 2: ., look for a preceding . to reject .. in refs
> 	 * 3: {, look for a preceding @ to reject @{ in refs
> 	 * 4: A bad character: ASCII control characters, and
> 	 *    ":", "?", "[", "\", "^", "~", SP, or TAB
> 	 * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
> 	 */
> 
> There is _no_ mention of `%`. In fact, `git update-ref refs/heads/% HEAD`
> succeeds, while `git update-ref refs/heads/^ HEAD` fails with:
> 
> 	fatal: update_ref failed for ref 'refs/heads/^': refusing to
> 	update ref with bad name 'refs/heads/^'
> 
> Also, I actually liked the implicit connotation of `^` being kind of an
> upward arrow, as if it implied to refer to something above.
> 
> I fail to see any such connotation for the percent sign.
> 
> Maybe you see something there that I missed?
> 
> > > Side note: why `h/`? I really tried to think about possible motivations
> > > and came up empty.
> > >
> >
> > Mostly because it's easy to type and didn't require exotic new syntax :) And the
> > "h" stands for hash.
> 
> And it totally clashes with a potential ref name:
> 
> 	$ git update-ref refs/heads/h/1 HEAD
> 
> 	$ git rev-parse h/1
> 	79208035afdb095548daae82679b7942c6bb9579
> 

I don't see it as a huge problem if it conflicts with a potential ref name. This
is an optional feature - no one is coerced to use it, so the name clash will not
create an emergent problem. And the ref name prefix should be configurable.

Punctuation tends to be harder to type than numbers, and numbers harder to type
than letters (I consider / about as hard to type as a bottom-row letter like
Z). "^" is a pretty inconvenient location on the keyboard for something I may
have to type many times. And "%" is a little better (index finger need not move
as much), but not a lot better. I would still prefer a non-exotic alphanumeric
sequence for the ref prefix.

Note that "^" will not work trivially - this is used in the `revset` command as
a prefix to refs. So you'll have to make the "^" contextually sensitive.

> > > I would like to caution against targeting scripts with this. It is too
> > > easy for two concurrently running scripts to stumble over each other.
> >
> > I think my wording before was too confusing. I totally agree we should
> > discourage automated scripts. Convenience scripts that are meant to be used
> > interactively (e.g. glorified aliases and workflow-optimization scripts) should
> > be allowed, and I don't think we need to do anything special to make that work.
> 
> I would really like to caution against even _suggesting_ such "glorified"
> usage of this feature. Scripts _can_, and therefore _should_, be more
> stringent than to rely on ephemeral revisions. I would really make it
> clear that this is _only_ intended for interactive use, by humans.
> 

I don't think you're getting my meaning when I say "glorified alias." Imagine I
do this in my shell's rc file:

alias badnamethatonlymattlikes="git branch -va && echo '--------' && git status --short"

Then I convert it to a script because the alias is getting too long:

	#!/bin/sh
	
	git branch -va
	echo '--------'
	git status --short "$@"
	
	git log --with-ephemeral-refs # ...

This should work.

If we use the PID to key off the ref, this obviously won't work, because the
script is already dead before you want to refer to the ref. getsid should work
fine.

- Matt
