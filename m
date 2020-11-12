Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E7C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D028822240
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WrsDeRk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgKLOVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:21:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:34581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgKLOVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605190898;
        bh=X7l2n/phqdYGCoCFsfU0ubJKOPykyOtE/NxFv3FK8Bw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WrsDeRk1Ds3imsUpibsirFqEfspctM3G55gIPF2znLjI1tqKl95ZtUlwv+Uu+4DSr
         TqHOaAV3KUPNC/lRGT2vpIllUYU3flgaAvRwLDdn+0LB5OJsI3iT9EkFcKIJ2fu9DG
         FH39X+ephwzczXjisvj8C6qmZ6j/gQylPMvR6mbI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1kB0Vl1G71-012m6D; Thu, 12
 Nov 2020 15:21:38 +0100
Date:   Thu, 12 Nov 2020 15:20:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix color handling in git add -i
In-Reply-To: <20201111184527.GD9902@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011121504110.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <20201111184527.GD9902@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1618576477-1605190840=:18437"
X-Provags-ID: V03:K1:57utJl5xp8B0CLlxJKACMi260ir9qoIZeeC/14jUlR0ChBPVeu5
 l1knsdev+Fql1Ym+4f8JL51CoM//DxtvU39b4WJS5yJaHarD8sNlJZfvedxXOn0mW2tD6Sg
 BddKZE4UdNGfC8iCwTZez8JqfI3E8s/rnCNgCRIRchu00/gM6EfEijhH9Sz97ADPCaH9YE2
 3glrrqJTq+TgUfmPBJnow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Boa3+Hdh19Q=:Cu2lKjiPqDjoFefE8RhiZs
 dXa6qTWhr0IZxfKU5jsJLOargUUniqypoMsJx/NCZVrB7vHBti+zyKGPhoUH1fvXY2Ep3ppJf
 qyV+D35WzwSPdfwked+ex/W/l76cdE3htREwKHhsE01KFN0e7D09CAfFroIC3rKlpB1DnNza5
 qYIIE54ARQlhlsMu6TeiYPa0gZlSCrE/f3t/3aGXkJ42xVK/vrnlYmmYRbKrXOb3AIUd4+S40
 FTIvF/sfU6opaSi/qXyBwVTAPl+69JlR+P0Wu5merMkc3jWuJy0/2pILdLTqrsumSGgW6AAWI
 gy+eBPsIV+DTYgOZmiE7sA0IDMmRF9yfQIgfQPMPxa7OGv9qjKf+Lbylq7c1EjI17YuRp5HWw
 +jykWJ5Wlcak0/5aUkEugW6f8DlgxltGST5ZtXz1CDYAsKLkUq9QuDsLSNRdtC4i76H9eoyqH
 xLaDefbwyggIc5V03hBQPLeVSQMzADOcYy4sPtirkCz7AHkSTpNHc4txz7ORWJVl7uxhsNf0D
 UJRojj0lckwmn6D1gOCRRrLZtbdNhmctri7ZNauPjfh5dBAqafiSRnLE6zh0VecBzRSv0NhPb
 6f1qxocio+r/uo+Pwj2LdPTSMds9UI0DSDAMUqbNOTBELXs0c7y1QuhzPI9Zr68+0Ga7HToKB
 Q5DjWCnsvckG2klEqi+GTY14y9FGUKsmMBG0QGy0lGw8KrFmxdi8mwEliYnxdYo8C9tWyYMs0
 anfxKU9RftwfARNej/rljEDldNdLZPWXf3ObG5w4pnCw6Fvwmc2hBcOt5k3osvzof71HU6D8Y
 /TuxCHX1v7shzWlbT57L8CGZeD8KnGhHj1/D3CCcVT6kCfumz82Iwo17Nd6KKCeSbguE16ZIX
 +DYGL6tOHR1sBXvvkVdw7PW2GKHa/LmAOHMxDRbs0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1618576477-1605190840=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Wed, 11 Nov 2020, Jeff King wrote:

> On Wed, Nov 11, 2020 at 12:28:13PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Changes since v1:
> >
> >  * The regression test now actually exercises the re-coloring (that is=
 the
> >    primary purpose of git add -p looking at the color.diff.* variables=
).
> >  * The way the built-in git add -p renders hunk headers of split hunks=
 was
> >    aligned with how the Perl version does things.
> >  * We now consistently prefer color.diff.context over color.diff.plain=
, no
> >    matter whether using the Perl or the built-in version of git add -p=
.
> >  * The commit message for the regression test no longer confuses reade=
rs by
> >    mentioning dash.
> >  * The regression test was structured a bit better, first testing erro=
r
> >    message coloring, then the menu in git add -i and then the diff col=
oring
> >    in git add -p.
>
> The changes were less scary than I was led to believe after reading your
> earlier response. :)
>
> Everything here looks sensible. As I said elsewhere, I do worry there
> may be a lingering issue with how parse_diff() looks at the filtered
> diffs. Let me see if I can get diff-so-fancy working...
>
> Aha, yes. I think using diff-so-fancy here isn't entirely robust,
> because it has some cases where it fails at the 1-to-1 line
> correspondence, but they're aware of the issue. But it does work in
> simples cases now (there's some coloring which makes the output more
> meaningful, but I obviously won't paste it here):
>
>   $ git -c interactive.difffilter=3D'diff-so-fancy' add -p
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   modified: file
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   @ file:1 @
>   old
>   new
>   (1/1) Stage this hunk [y,n,q,a,d,e,?]?

It might _seem_ that it works. But try to split a hunk. I did this with
the test case (interrupting it just before running `add -p`):

=2D- snip --
$ git -C ./t/trash\ directory.t3701-add-interactive/ -c
interactive.difffilter=3D'diff-so-fancy' -c add.interactive.usebuiltin=3Df=
alse add -p
<BOLD>=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80</BOLD>
<BOLD>modified: color-test</BOLD>
<BOLD>=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80</BOLD>
<MAGENTA>@ color-test:1 @</MAGENTA>
context
<RED>old</RED>
<GREEN>new</GREEN>
more-context
<GREEN>another-one</GREEN>
<BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]?</BLUE> s
<BOLD>Split into 2 hunks.</BOLD>
<MAGENTA>@@ -1,3 +1,3 @@</MAGENTA>
<RED>old</RED>
<GREEN>new</GREEN>
more-context
<GREEN>another-one</GREEN>
<BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?</BLUE>
=2D- snap --

Obviously, I marked it up so you can see what parts were colored.

See how it first _looks_ as if it works? But then you split the hunk, but
instead of showing only the old/new part, it shows the old/new/another-one
part!

In other words, it does not work at all, and the fact that it does not
even warn you about it is misleading, and that's pretty much all I will
say about it.

> But with the builtin:
>
>   $ git -c interactive.difffilter=3D'diff-so-fancy' \
>         -c add.interactive.usebuiltin=3Dtrue \
> 	add -p
>   error: could not parse colored hunk header '?[1m?[38;5;1m?[31mold?[m'

Granted, this is not quite helpful. I _think_ what is happening is that
the number of lines is different, and `add -p` goes like: noooope! But it
could probably be better at describing what the issue is. Or it could
cater to `diff-so-fancy`, if that is what people use these days, and
special-case it by falling back to detecting the hunk boundaries in a
manner that is compatible with `diff-so-fancy`.

Or we might be able to come up with a strategy that is not so limited and
that works for more than just `diff-so-fancy`.

> I don't use it myself, and as I said, I think they have some fixes to
> make for it to be robust as a diff-filter. But I suspect this may be a
> problem once the builtin version becomes the default.
>
> I don't think it should be dealt with in this patch series, though.

Oh, _that_ I wholeheartedly agree with.

> While it may touch on some of the coloring code, it's otherwise
> orthogonal to the fixes here. And while the fix is likely to be to make
> render_hunk() stop re-coloring in the non-edit cases, your more-robust
> test here will still be checking what you expect (because it really is
> triggering the edit case, not relying on the extra coloring to see the
> effect of in-process color config).

I don't actually think that we _can_ stop re-coloring the hunk header in
the general case because we need to keep this working even for split
hunks. It would be a very bad idea to make it work for non-split cases and
then something like `die()` only when the hunk is split. Better re-color
all of them, then, to not even risk that situation.

Ciao,
Dscho

--8323328-1618576477-1605190840=:18437--
