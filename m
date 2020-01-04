Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A03C32771
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C4E21734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L8fNcAfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgADVWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:22:23 -0500
Received: from mout.gmx.net ([212.227.15.19]:48737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgADVWX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 16:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578172934;
        bh=ZTgW8XUFgARUBxqJ3jgw5B240jtY8UlGi9lAGYuV808=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L8fNcAfOy9l/29kgISLGH/kOS3rPHT51HwGuz44CL1HVw9z+l3Qv7Xo0beR+9ZXzg
         CqT/2nfmR35aw3LL34W43yPGlq50WEAl5oB4YRSq1ZUqa9/rA9e+5GY8YlF9+ZuCAg
         qNIGow/5Lk5WAUpOlap9piLGE3gzn2PISrurt8Pg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1irRF30gxT-004D4U; Sat, 04
 Jan 2020 22:22:14 +0100
Date:   Sat, 4 Jan 2020 22:21:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matthew DeVore <matvore@comcast.net>
cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
In-Reply-To: <20200103201423.GA20975@comcast.net>
Message-ID: <nycvar.QRO.7.76.6.2001042131430.46@tvgsbejvaqbjf.bet>
References: <20191029003023.122196-1-matvore@google.com> <20191031003929.GA22855@google.com> <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet> <20200103201423.GA20975@comcast.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mCYnoH7TEsSmwOTxU8iubFZM6OZi9wi5o5OKppbIulUIjTWODmy
 bMuo+SMErQTszMefSX9zGCvkqLDA8QL8O/cQfI1jsbLcCmAINvGt1Sr25IjJPQa407uOog8
 yl8RDvVNY4Bz+B1+uvQkQzK5N4inW4HanPIRGqmT2owa33rkZR3IvXdVFLdh+nP0dRgwDOO
 XDA58+TAGKmqulwj3trlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1NmgI86r7kA=:pok2DFJRn/B3rQhY+OF3SQ
 EnPSbOh9cYpBVFis8IQcHZqURh99PCUambBQV0M+WaJIPnKqjJOcZRVJqWL17X2tSe2al1/V+
 oQz6M7D2bihgxR2Y3Zd1/xy5EvtHyvT8Fb0KarEgf2MRFOPkyxaHSNz0CB2gVMi4di8nOgAx8
 9Cbpz4wn/oBUYtB/zQgi3zTOt2ahWbWtqBidNphVM/j/3vfsQZLrdKyjKgprgNep8iGkvO88h
 kPoqwcD8fTmCE0Q0g5+N+e1CZTOcELqQ54Dq39z3U7qjSXhHfoNamsa73Gq6+Zkwlth3qZn0/
 wYT+rG6mCWTFl1K2xr4+up1gkFYR9zTlfgHqcGX+gWSHKmXqp3y5taElfkaX1UPGz5wF7XTu7
 uqR7VN4PHRaLHtaMmQRjscba2Dkh833UfdhZ9/x7rWyU0c6FKlEbsKQ9UabqgwvRh0Xu9FKEO
 OA+UH6lFN6LR22hAYbkLLhv0NRPksMDgrS8Hf7+rLATMlOu7ti6ZqCpSAmHrp+F5QG9Qsj3lR
 xZ6tWNDJ8cjNlPRWRJXVPYktHq4iujyXxaZPJWJNkjzk5R9OyKPnUXURXVIfk4pvZ5yeaKXdW
 q7sev3o3Cjuez3889g/28MvpBJfBIzzM7w5NtZWEc/pzIloJlZogWypKr8Nvqv+X8gcW9pCC0
 sC9DndzXBqS9HfautuCpYIwbGxMjn/H8iIGo3bau+YjM8ZsPqsSKBpBl6dXdgIIKxztODTIzn
 Ow+QzUpPI4XKqnminiV1wIuO3B/WErXBiIRR3vAECMQab69eQHRR+YwwO+4ygWvRkNd7l2l23
 DZbRabxxAxT7iLqXhBE8hjsAiH/yEPfQl8AiAqPOXvS19dZGlgFQ2ZFZtVRZwIIhsdJf7Nyzs
 O06jA5QRZJd43XYHbrxGvWewjfroIE6I6uJGWrOOQdmZDEg16Z/VJq8c4EHAmMhH8397edxRG
 Xyc5LL6q1lYXrSXvPlE1nxn/GbnMnGyZ9waqUT0MEnpEC2xWS6ERJIFa2JZyQVG64486eKACN
 +Orc2+pUyuuFvu+d/tUIxlXitK1w+8z09oB6D+R82aTmT1OMmBNjEEF0mF+jgf10ClH2Ho1EN
 9h5s+HQP5aLxSdPrbPxQ9JSZSjEnqH0uhvxeKVgfDHD3BsPFpqs9ZT58XrxNbwO1OaJq51DUg
 BfBpXK8H7GJPZ5fKm8LRCsGIMqLi6gUsC01Ywuw8t7FxDt+adsR0Mr+xNX1c6x/q0agMRuQQT
 9SY4s0uYMN8OBt1fJI7z7j5q/Ush7j5Lf1Xp5hG00kNrAi++Wp4Wn38hshhQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Fri, 3 Jan 2020, Matthew DeVore wrote:

> On Thu, Oct 31, 2019 at 09:26:48AM +0100, Johannes Schindelin wrote:
> >
> > am stands for "apply mbox", and I think that the only reason it is not
> > called `git apply-mbox` is that the Linux maintainer uses it a lot and
> > wanted to save on keystrokes.
> >
> > Having said that, I do agree that `xl` is not a good name for this. It
> > is neither intuitive, nor is it particularly easy to type (on a
> > US-English keyboard, the `x` and the `l` key are far apart), and to ad=
d
>
> There is a subjective element to this, but I would consider it easy to t=
ype
> since it is using two different hands. The property of "keys are far apa=
rt" is
> only bad if it's the same or close fingers doing the typing (i.e. on qwe=
rty
> layout "ve" or "my")

Of course it is subjective! That's what I pointed out. And based on that
reasoning, I think it would be a mistake to use that name: it is _waaaaay_
too subjective.

> I'm not trying to justify an unpopular name, though :) There are other
> reasons to avoid "xl". I just found your statement surprising.

I hope I got my point across. I still think that my reason to avoid `xl`
should have been enough, even without all those other reasons (which I
actually not recall, this thread being so stale by now).

> > insult to injury, _any_ two-letter command is likely to shadow
> > already-existing aliases that users might have installed locally.
>
> "wip" seems more descriptive to me,

"wip" says "Work-In-Progress" to me. I would strongly suspect `git wip` to
mean something similar to `git stash`.

So no, it does not strike me as a good name for your command because it
suggests something _totally_ different to me, and I am not exactly what
you might call a Git newbie.

> or "logx", as I mentioned in the reply to Emily.

That name does not get my support, either. My mathematician self
associates `logx` with the natural logarithm of `x`.

I don't find this intuitive at all.

Mind, there are tons of unintuitive parts in Git's UI, but that should not
encourage anyone to make the situation even worse. To the contrary, it
should encourage you to do better than what is there already (think "Lake
Wobegon Strategy").

> > In addition, I would think that the introduction of ephemeral refs
> > should deserve its own patch. Such ephemeral refs might come in handy
> > for more things than just `xl` (or whatever better name we find).
> >
> > The design of such ephemeral refs is thoroughly interesting, too.
> >
> > One very obvious question is whether you want these refs to be
> > worktree-specific or not. I would tend to answer "yes" to that
> > question.
>
> We could key each set of ephemeral refs off of the ttyname(3) or as you
> suggested getsid(2). As you say, the Windows analog would be the handle
> of the Win32 console. (I'm guessing there is no concept of a terminal
> multiplexer unless you're using MinGW or WSL, in which case we can use
> getsid).
>
> getsid(2) seems the least likely to overlap with previous "keys" so we m=
ay
> prefer that one.
>
> getppid would not work that well if anyone ran the command (or any git c=
ommand
> that refers to the ephemeral refs) in a wrapper script (I don't mean an
> automated script, which we definitely don't want people to try).
>
> I'm not so sure I would prefer this keying mechanism myself - I may be
> compelled to turn it off. I sometimes have two terminals open, visible a=
t the
> same time, and expect them to share this kind of state. So I'm reserving
> judgment about whether it should be configurable or not. But it should p=
robably
> be enabled (key by session ID) by default.

You have a good point. This should be an add-on patch. If you won't have
the time or inclination to implement it, I will feel compelled to do it.

> Now, if we key the refs off of the current session, it seems unnecessary=
 to key
> off the worktree as well.

That's probably beneficial: if I `cd` to a worktree, `git log --devore` a
few commits, then `cd` back and want to cherry-pick one of the previously
show commits, I definitely do not want the ephemeral revisions to be
per-worktree.

> If someone remains in the current session, but cd to a different
> worktree, it would be natural for them to assume that the ephemeral refs
> that are still visible in the terminal window would stil work.

Yes.

> > Further, another obvious question is what to do with those refs after =
a
> > while. They are _clearly_ intended to be ephemeral, i.e. they should
> > just vanish after a reasonably short time. Which raises the question:
> > what is "reasonably short" in this context? We would probably want to
> > come up with a good default and then offer a config setting to change
> > it.
>
> I would propose expiring refs as the user introduced more sessions (gets=
id
> values) without using old ones, like and LRU cache, and to limit the rep=
ository
> to holding 16 getsid keys at a time. This way, we don't have concept of =
a
> real-world clock, and we let people go back to a terminal window which t=
hey
> left open for a month and still use refs that were left there (assuming =
of
> course they haven't been using the repository heavily otherwise, and the
> terminal content is still showing those ref numbers for them to refer to=
).

I don't know about you, but personally, when I find a window that had been
open for a gazillion days, there is a good chance that it is stale.

For example, I frequently find myself hitting the `Enter` key just to
trigger a re-rendering of the command prompt (which contains not only the
branch name, but also the information whether a rebase is in progress or
not) *just* because I suspect that that particular worktree is now at a
different branch.

I imagine that I am not the only person with this particular issue, so no,
I am not in favor of using an LRU. I _really_ think that we have to let
those ephemeral revisions expire based on age.

> Now, if in session 42, the user generated some ephemeral refs with
> "git log --ephemeral-refs", these would automatically destroy any existi=
ng
> ephemeral refs that were created by past invocations in session 42. I do=
n't
> know how important it is that we clean those up, but it seems like the r=
ight
> thing to do anyway to save disk space (at least 40 bytes per commit).

I might be wrong, but in the non-public presentation I got the impression
that the use case was pretty much "I call `git xl` and then I want to use
one of those commits in a subsequent Git command".

In that respect, I really do not see the point of holding on to these
ephemeral revisions for even as much as 15 minutes. My suggestion to make
the maximal age configurable was more a conservative concern. I would be
very surprised if anybody wanted to use those ephemeral revisions for
anything else than an immediate reference.

But even then, if such a use case arises, we can easily implement it then.
_If_ it arises. Until then, I would rather avoid catering to unrealistic
(read: unneeded) scenarios.

> > Another important aspect is the naming. The naming schema you chose
> > (`h/<counter>`) is short-and-sweet, and might very well be in use
> > already, for totally different purposes. It would be a really good ide=
a
> > to open that schema to allow for avoiding clashes with already-existin=
g
> > refs.
> >
> > A better alternative might be to choose a naming schema that cannot
> > clash with existing refs because it would not make for valid ref names=
.
> > I had a look at the ref name validation, and `^<counter>` might be a
> > better naming schema to begin with: `^1` is not a valid ref name, for
> > example.
>
> I like having a new kind of syntax to make the ref names easier to type =
as well
> as non-conflicting with current use cases. "^" is hard-to-type if you're=
 not
> a good touch-typist, but I guess that's fine. If you're a good touch-typ=
ist,
> "^" seems a tad easier to type than "h/" IMO.
>
> I don't see any mention of "%" in "gitrevisions(7)" so maybe that's OK t=
o use?
> That is a little more of an everyday symbol than "^" so users are likely=
 used to
> typing it, and is closer to the fingers' home position. But if I remembe=
r right
> this has special meaning in Windows shell (expand variables), so I guess=
 it's
> not a good idea.

=46rom the current `refs.c`:

	/*
	 * How to handle various characters in refnames:
	 * 0: An acceptable character for refs
	 * 1: End-of-component
	 * 2: ., look for a preceding . to reject .. in refs
	 * 3: {, look for a preceding @ to reject @{ in refs
	 * 4: A bad character: ASCII control characters, and
	 *    ":", "?", "[", "\", "^", "~", SP, or TAB
	 * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
	 */

There is _no_ mention of `%`. In fact, `git update-ref refs/heads/% HEAD`
succeeds, while `git update-ref refs/heads/^ HEAD` fails with:

	fatal: update_ref failed for ref 'refs/heads/^': refusing to
	update ref with bad name 'refs/heads/^'

Also, I actually liked the implicit connotation of `^` being kind of an
upward arrow, as if it implied to refer to something above.

I fail to see any such connotation for the percent sign.

Maybe you see something there that I missed?

> > Side note: why `h/`? I really tried to think about possible motivation=
s
> > and came up empty.
> >
>
> Mostly because it's easy to type and didn't require exotic new syntax :)=
 And the
> "h" stands for hash.

And it totally clashes with a potential ref name:

	$ git update-ref refs/heads/h/1 HEAD

	$ git rev-parse h/1
	79208035afdb095548daae82679b7942c6bb9579

Should we really _try_ to go out of our way to introduce ambiguities that
have not been there before? I would contend that we _do not_ want that.
Not unless forced, and I really fail to see the necessity here.

> > I would like to caution against targeting scripts with this. It is too
> > easy for two concurrently running scripts to stumble over each other.
>
> I think my wording before was too confusing. I totally agree we should
> discourage automated scripts. Convenience scripts that are meant to be u=
sed
> interactively (e.g. glorified aliases and workflow-optimization scripts)=
 should
> be allowed, and I don't think we need to do anything special to make tha=
t work.

I would really like to caution against even _suggesting_ such "glorified"
usage of this feature. Scripts _can_, and therefore _should_, be more
stringent than to rely on ephemeral revisions. I would really make it
clear that this is _only_ intended for interactive use, by humans.

It strikes me as being similar to short revs: of course you _can_ use
shortened object names in scripts, but why _would_ you? It only opens
those scripts to run into collisions with new objects whose names
abbreviate to the same short object name. Those short names (and those
ephemeral revisions) come in handy only when there is a human who has to
type out these beasts. A script does not type, so they don't tire of using
the full names (or revision names).

Scripts which use those ephemeral revisions are very likely susceptible to
problems that non-ephemeral revisions simply do not have. So why even
bother to suggest using ephemeral revisions for scripts? I would actually
do the opposite: discourage script writers from relying on _ephemeral_
clues.

Ciao,
Dscho
