Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C9C83D5D
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1499222265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zy5q+Jy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgKPLwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:52:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:45885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgKPLwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 06:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605527539;
        bh=rUu4iEiIWCjE0TvFWVpWjUwWUSUrbKKQ3HDQ6tGhz/U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zy5q+Jy13DsHIWQQl2Jv1r09B56rhH2EtYxbSCtJU1SPAbf1BIGeLtyJMgCn6FP51
         22PYzh6woJAvsRcfp/gT7Gq/LP+35Cm7Ih1sLASHG3IAhNfjCnjXKuID3R5DZ1K2qy
         hORjMx2+CwAMhXYGmGL5QmPOuRzm8o1XWWIow8PI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1k4lP53ren-00hPnn; Mon, 16
 Nov 2020 12:52:19 +0100
Date:   Mon, 16 Nov 2020 00:35:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
In-Reply-To: <20201112182925.GA701197@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011160027480.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com> <20201111023549.GB806755@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
 <20201111180713.GC9902@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011121448550.18437@tvgsbejvaqbjf.bet> <20201112182925.GA701197@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hcfM9rRgaqvpR/SSsxMGxKTjew+ITdeZcI93jt6JB0NwwviBCea
 4kiWAM7JHk1HnJDySJN8WYwIH3WtVrBAs2tjDaOncJ/Azy2ZOVj5A1sW3r24I3HXLSzLN/p
 8i1MTA0u7sYO5ku0drSddlBKR6rgQoZYDWO78Zdg2Zv8mP8hCmQjGzv/HoAxz3rtNCWQZM/
 vZcE7uoOCOqDCdq9UWjCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U2GHZTtXn7A=:5HnZwb8KpFLX428lveCtAp
 dbFH0a+qATqI/ZirXIbGMflhTVA/Fq6hI8FXz12rQ1WCkXHwMJYerrQrELvE/LtDQeBZwJM/N
 iLDs/+XOfSlaZSmGW9CqoODs+TZH1t8w2CWGXm02FZgxFkibTiX98N3w9N7JVLsQXBKemO2qP
 VOxbxVLRWzIdJKRPEoG83fMW6l8KMnDQpX9R5jv3WULFKG7vahfzxHdNKd+OG+/V+DOk7D81g
 qsIhj2EqEN+m0UnuKiV9FPIb+DKp2xwlsxSy9lgtZ2ZA4OY8k9nYRxKaJpTGiUdGYUvdETg92
 zsfUbdy7jdFCleiqq9+a/md4zPidpiI1Mgeu3xIpxJcxd7IRIlkFyoj88DbEjoCsfn288YWaX
 ytzgPDQ8xgjAYGNEv8dAksMCneoCWXm6tgz/GBNNobI8qx6tMuO/6qWrKVVIH8WVeUcB/Rbbw
 GnkIv7We3+XFzGYIlJMY8xlVVE+iRFxBQWQKbqCYMy1U8q58gZP6OlvQRIqCnvLS4nDBjROjA
 85sjYaTW3ZKSRqBeCkuTFouFuk2x1wLzMlala8LS1QutF76kryRsJIBpG4inWv85Cyl6xAb/Z
 A1MJxjpHl0PBikkKk3Ub0k3sVG4P97DWgFaG5Fb8B9S62XOGJBc+R6yLfvCldAV65v7NtbX4R
 3pp4eEIjwtrps6c8zUuifVSr4311Cvxu3xLt0sxKvUgoTVHmHQD3OuKYDAAZZtHthGaFlSjrl
 jlHYb7wHDyowm2LadsHg7Tnsaa+Edib1ZXSV60KL/LVnn4DTB9bcOIz1c9AWvYBYQH553lSh6
 A4wVVHqBlB8h+rKgGigE7+v9k3YXajqfROc06keXisKo8x2340q6RUHbRJr9PNpLA+6bjblC1
 7bV59vMV58Y407HVPXIedzmSoD4TDIlffXqge9Pfo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 12 Nov 2020, Jeff King wrote:

> On Thu, Nov 12, 2020 at 03:04:01PM +0100, Johannes Schindelin wrote:
>
> > > Hmm. Right, I knew about that weirdness. But I assumed that the buil=
tin
> > > add-interactive was doing the diffs in-core. Otherwise, why would we
> > > have seen the failure to load diff.color.frag in the first place?
> >
> > Oh, that's easy to explain: as you can verify reading
> > https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl=
#L885-L898
> > the Perl version of `git add -p` insists on (re-)constructing the hunk
> > headers manually, and obviously it needs to color them manually, too. =
And
> > https://github.com/git/git/blob/e31aba42fb12/add-patch.c#L649-L672 sho=
ws
> > that the built-in version of `git add -p` slavishly follows that pract=
ice.
>
> But that is only when we split hunks (your link to the perl script is in
> split_hunks()). I agree we must color manually there when creating our
> own hunk header. But outside of that and patch-editing, the perl script
> does not otherwise recolor or rewrite (nor even really parse beyond
> line-splitting) what it gets from the colorized version.
>
> Whereas add-patch parses the colors off of the version and then
> re-colors every hunk header. Which seems doubly weird to me. Even if we
> were going to re-color every hunk (e.g., because we don't want to store
> the original hunk line, but instead a parsed version of it), why bother
> parsing the color version at all, and not just the machine-readable
> version?

Let's continue on this distraction for a bit before I go back to fixing
the patch series, which actually tries to fix a _different_ concern.

The reason why `add-patch.c` "parses the colors off" is that we want to
show the rest of the hunk header, in color, even after splitting hunks
(this will only be shown for the first hunk, of course).

But given that `git add -p` is somewhat of a fringe use, and using
`diffFilter` is _even_ more fringe, I do not really want to spend any
further time on this tangent.

> > > The answer seems to be that render_hunk() always _replaces_ the colo=
rs
> > > we got from running the external diff. Whereas the perl version only
> > > applied coloring when reading back in the results of an edit operati=
on
> > > (and likewise used the frag color when generating a split hunk heade=
r).
> >
> > No, the Perl version also insists on applying `fraginfo_color`, see
> > https://github.com/git/git/blob/e31aba42fb12/git-add--interactive.perl=
#L885-L898
>
> Only when we split. Try this to give different colors between the
> interactive script and diff:
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index e713fe3d02..862a21ff1f 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -28,8 +28,9 @@
>  my $diff_use_color =3D $repo->get_colorbool('color.diff');
>  my ($fraginfo_color) =3D
>  	$diff_use_color ? (
> -		$repo->get_color('color.diff.frag', 'cyan'),
> +		$repo->get_color('color.diff.nonsense', 'yellow'),
>  	) : ();
> +# noop to create split hunk
>  my ($diff_plain_color) =3D
>  	$diff_use_color ? (
>  		$repo->get_color('color.diff.plain', ''),
>
> Running "git add -p" does not result in yellow hunk headers. But issuing
> a split command does.
>
> The distinction is mostly academic, because diff-tree and the
> interactive patch code should be using the same colors, so the result
> should look the same. It could matter if the diff-filter chooses
> different colors, though then the split headers will not match the
> originals in style. We _could_ run the newly created hunk header
> individually through the diff-filter, though I'm not sure how various
> filters would handle that.
>
> That's true of the perl version as well as the builtin one, but I think
> the builtin one's insistence on parsing the colored output is taking us
> in the wrong direction to eventually fix that.

My thinking back then was: what if _I_ want to use a diffFilter? For what
would I use it? Probably to emphasize certain hunk headers more, by adding
more color to the part after the line range.

Anyway. I stand by what I said above: I do not want to spend any further
time on this tangent, at least not right now. There are more pressing
challenges waiting for me, and I expect those other challenge to have a
much bigger "return on investment".

Ciao,
Dscho

> > > I'm not sure that what the builtin version is doing is wrong, but it
> > > seems like it's putting a lot of extra effort into parsing colors of=
f of
> > > the colorized version. Whereas the perl version just assumes the lin=
es
> > > match up. I do wonder if there are corner cases we might hit around
> > > filters here, though. The lines we get from a filter might bear no
> > > resemblance at all to diff lines. The only thing we require in the p=
erl
> > > version is that they have correspond 1-to-1 with the unfiltered diff
> > > lines in meaning.
> >
> > They do have to correspond 1-to-1 because the assumption is that the
> > individual lines will then correspond one-to-one, too. This does not n=
eed
> > to be true, of course, but then the filter is probably less useful tha=
n
> > the user wants it to be.
>
> Right, I'm not disputing the 1-to-1 thing (I was after all the one who
> implemented interactive.diffilter, and added the "complain if the counts
> don't line up" check). But in the perl script they only need to
> correspond _semantically_, not syntactically.
>
> -Peff
>
