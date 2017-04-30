Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A794B1F78F
	for <e@80x24.org>; Sun, 30 Apr 2017 11:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933511AbdD3L34 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 07:29:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:62118 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756777AbdD3L3x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 07:29:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOBOi-1d86y32Lie-005WDR; Sun, 30
 Apr 2017 13:29:43 +0200
Date:   Sun, 30 Apr 2017 13:29:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Joel Teichroeb <joel@teichroeb.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC V2] stash: implement builtin stash
In-Reply-To: <20170321053135.thk77soxc4irxbqj@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704301216280.3480@virtualbox>
References: <20170313222318.23312-1-joel@teichroeb.net> <20170321053135.thk77soxc4irxbqj@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:86lv6try6eHUa+uKPOg7t2VOrO/1yuo+s4vCQzLno32gaqEjSSM
 qrMYcV/QZCZeQXXvqXgSXmSz1RfqE2ywJ30kqxNqS5XRHQ0RzzsYcz/tMIyFIHoZsK3ODh2
 CtTZ+Qxjfiu6eVU4asO0dIwTcWGShoKOO7dhAEKrYkFmeXzSkkhAUlJ+tcWIL9LaFUN3bJJ
 xdrK0lF2795dVkaj7Oz+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ed3zsdVZTBU=:Ny54UqoemxM2bTG2+fBTJY
 xtp/quTTuor079yKcpf+5q8mAD6gLgUlQMIqc9RVewUVDYP8uimbRauMDJrpN0Zg3mXHHbU0T
 xtsogobrUzW8tY+DgT+tRNO6GOKkuxGPGp5BzxikKRGAfWy+N9m8s2bavdsOMQZPAGWs8VgAR
 KV13cQ+KUxolnL4yeeJ3BD4Vk8oPqM95L+1tPIRrGoxXIM3Doclrg5RA5iW1eMeZsa+urhZ9W
 nluJBvjsvuXEpGGkUwzEZsMvGmFoDhvlnBKYZGVa7BDolzX7RqWg8F+5j5vheGd9MlirrFySU
 8FgGrx6v+wf8hIToDSziEzlAlmfDjY+T+0WpfFICVvAcnk2ke9pLUX/0V95vsqb8Rc1Abe2lS
 ep5RStGWrUB5uQMdtluc59hmd++Wz5dg8MHDvUcwWFpHlsoXpCeR4XRIbptH3PkFfdbfQIknO
 llDhXTPE7MMhEdDlEmTZx2qaANUU5ZqP+vMFZLdzDYpvZ7jx5HfGQZ6q+b762s1opYaFA/Whp
 vSaE/LQrg0uYQBE8L4tRwIgNUETEXuKnEpzf1R7veAMto2sX4j/eoxK3vG70HfYnR3CMjGvYs
 HPNPMjdsL480fmhRr4sBs9VINT28iNDvhDlWwS1v+I5pvFdnqmXjwdde3x8FhPrZPv750LZWw
 gEv9Egs11aUFofCY+ffe6rzjilVnjxumqIV7rrewsmeXnqLUZmcDF5qLMk8kSFo2o5disaDHK
 6mhr1JLa4kFzxmotE6jZwK/cxwSKzDX81//vSLZ8qCP00gHYb942jg78DULtXp7HkeW2yG7my
 2PnI2Lc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Joel,

On Tue, 21 Mar 2017, Jeff King wrote:

> On Mon, Mar 13, 2017 at 03:23:18PM -0700, Joel Teichroeb wrote:
> 
> > I've been working on rewriting git stash as a c builtin and I have all
> > but three tests passing. I'm having a bit of trouble fixing them, as
> > well as a few other issues, so I'd really appreciate some help. Don't
> > bother commenting on the small details yet as I still need to go
> > though the code to make sure it matches the code style guidelines.
> 
> Be careful that this is a bit of a moving target. There's been some
> feature work and some bug-fixes in git-stash.sh the past few weeks.

Maybe more encouraging words would have been in order... converting
scripts to builtins is tedious, hard, and unrewarding. And it is also
highly important, despite the obstacles that are partially technical,
partially social.

So let me try:

Joel, this is awesome work you have done there! It looks already pretty
good, and the fact that it almost passes the test suite is no small feat.

I worked a little bit on this patch and pushed the non-squashed version
here:

	https://github.com/git/git/compare/master...dscho:stash-builtin

Only now, after pushing this branch, did I realize that you have your own
git.git fork with the patch available right there. Oh well... ;-)

Essentially, I changed the patch in the following aspects:

- instead of deleting git-stash.sh, move it into contrib/examples/ (as is
  the recommended way, although I get doubts about that, given that some
  of that code may not even work anymore, let alone follows our style)

- I rebased to the current `master` of git.git

- I forward-ported three changes that git-stash.sh saw in the meantime

- I briefly looked at the style and changed just a couple of instances,
  but then dropped the ball as I agree with your statement that it is not
  yet time to "clean the patch up" according to the coding conventions of
  git.git

- most importantly, I inserted a `read_cache_preload()` before any
  invocation of refresh_index(). This is needed because an empty in-memory
  index would be refreshed, which is not what we want (don't feel bad
  about it, I feel into that trap uncountable times during my work on
  accelerating rebase -i)

It is that last change that fixes t3903.69 for me.

I hope that it is not too hard for you to read my patches; to document
what exactly I did, and in which order, I used what I call "merging
rebases", i.e. rebases that start by a fake merge of the previous history
("fake" as in: it only merges the commit history, the tree is actually
left untouched, in essence starting from a clean slate again).

> > git stash uses the GIT_INDEX_FILE environment variable in order to not
> > trash the main index. I ended up doing things like this:
> > 
> >     discard_cache();
> >     ret = read_cache_from(index_path);
> >     write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
> >     discard_cache();
> >     ret = read_cache_from(index_path);
> > 
> > in order to have an empty cache. Could someone take a look at my uses
> > of the index and point out better ways to do it?
> 
> I suspect in the long run that you could pull this off without writing
> the intermediate index to disk at all. You can store multiple indices if
> you need to (read_cache_from is just a wrapper to operate on the_index).
> But while you're executing sub-programs, you're still probably going to
> need to do a lot of re-reading of the index.

I agree with that, but that is definitely something to leave for later. At
this stage, we still need to work on getting the code correct, and
fiddling with in-memory index (or for that matter, with piping output of
one subprocess to another process directly, instead of using an
intermediate strbuf) would constitute premature optimization.

> Two things that I think might help break up the work:
> 
>   1. Rather than convert stash all at once, you can implement a "stash
>      helper" in C that does individual sub-commands (or even smaller
>      chunks), and call that from git-stash.sh. Eventually it
>      git-stash.sh will just be a skeleton, and you can move that over to
>      C and call the functions directly.
> 
>   2. You may want to start purely as a C wrapper that calls the
>      sub-programs, which communicate with each other via GIT_INDEX_FILE,
>      etc. Then you don't need to worry about manipulating the index
>      inside the C program at first, and can focus on all the other
>      boilerplate.
> 
>      Then piece by piece, you can replace sub-program calls with C
>      calls. But you know you'll be working on top of a functional base.

The patch actually already goes the second route. It does convert a couple
of `git reset-tree()` calls into internal API calls, but other Git commands
are called via the run-command API.

(Interesting side note: a couple of Git commands are called directly via
cmd_(), which I did not think would work, but it does, apparently, at
least in the cases used here. Those functions are, however, suffering from
the "let's use exit() as garbage collector!" syndrome, therefore we really
need to convert the code to use more low-level API functions in the long
run.)

BTW I still see a problem in t7601, but it looks like another
read_cache_preload() may be required somewhere (I ran out of time for now,
maybe you can see whether you can figure it out?).

Ciao,
Johannes
