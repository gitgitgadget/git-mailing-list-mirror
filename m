Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E6C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiHVKTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiHVKT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 06:19:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E113F63
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661163565;
        bh=PxtY28Z2xxh2INpy4axq63SkuK5rttfB19axkyz2YgY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SNGcwuNIi25JA0k4j9PZsEJNTeQzPVr4nUWXIZD5WyZUnGXaRGSZuDJ3ODd6zylSx
         aMicM++3qDQVaUOM6LYcmIxvBSJqR6W3lGP+Qdsks/cFpbkzb6vKRDlzSfafZG1+ga
         I3QjK9hKS+nYqA8JDvgfQnAP22TSjmss8Nkdb/LM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1oY5Gg1tgZ-009dDH; Mon, 22
 Aug 2022 12:19:25 +0200
Date:   Mon, 22 Aug 2022 12:19:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] tests: explicitly skip `chmod` calls on Windows
In-Reply-To: <220811.86wnbfowbg.gmgdl@evledraar.gmail.com>
Message-ID: <p79ppo86-022r-7sss-41q1-39n499n3266s@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <79abfa82c32ea686469cfe2417bc491c04179623.1660143750.git.gitgitgadget@gmail.com> <220811.86wnbfowbg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1591706637-1661163566=:235"
X-Provags-ID: V03:K1:QEXPB8hn2jMqkFsuVVIo14x63C+cEQRc9DihwtSzu3Py9b7fOLs
 3pmmMBkdzPZuw7cmB3gB1FZmKSSYLaJ9feZLoGEhXv3MO3SbwWLxqjwsxcRxXnnV8CDXnmJ
 zgempGRKJ0APYiZciKEzFmdhsL7P9f/su4Yl1Zjg7JYWJ1lSjUyQJ6gCc3lbYgvT1kmckYW
 xWoBURJF1Wd5sGSCNInxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0zACtkkJc6Y=:Lzx3iSkNFe+sPkoOXukIyZ
 bM+6jRCkXt7SyOblFTfMDIygO35myq3cJ7ZdbHWocq45K5x2wlHBXPVUcSl+oEAl3ZW6d/hX7
 9uFGKaAd2Go7pvtUb/7Gdu6sEWMvAyh6jQFck+83mYae0i5/9QeI8SmS+TnT2LVe1T2RVRaNn
 AT2wRUMvfGNs0ulGcVD7LJs4M6oyoaMKjJaM4v9DGVq9W376tVDI2QLlIecfzqIq5MGTG8/eD
 ZL6ZKVMLGY2uV8ZkEahzG0RwZXooWWnnUAdBj+A7iCgMXBzux7kWNi2xpAsedlPpQhWYadFuL
 oIcRV9OCqZWwjrVR9d5c7/c0x5hmox21z8qb0G+ekFwp3x0VgU0dK506x8V1LnkTE0BKXvJ+i
 YgGw0HfvIdQAOzecRUTsQjoxbvcaJtvjiMsqe+ytdke4vmwrm09X5QwO7ksX/CuLxqgwaT0Le
 Cdkzwbtpha5rS7kCWPSnEyK1y5v3FqXpE6KGoPreGvaYodFl2FBxzFe4oh+uAMvZbrbTjfUGk
 rYEtgnu08ZxJKXa/N5XQ1YFh+OEAYt8uPa3Rm3Z4Pox5NxTJtD3bp2lJ0KtWmP4ZwGt52cR+R
 Uz5LxWXBvvVh3zFnz1R7Hg3FZzq7seOqqym4ygmyEMDvRrrZL+wgN3tLAtwW/y0LxCqqXYRDa
 jz/gBfjZCq5ywib5JSJDnd84oMZibt+2gx1Ow4WapmLiDsG0RdEp5t2jtJnTUrCkdgWBZ6o5A
 OKAVj7oBNByI+nsYqDTK7OSjrsaAlpdDYl9tA3el2I9RYBXo4dz9iSgE8tUh9aiRn0DdPwjPn
 MmYZSmEgFFEz7M3NWFvil3FR24DX4360rY/BufBGiRLWWNHNeoYRJDPnEJEpwRN7XQUdvr6P+
 NpjC63L1WdHeqQ8DNQ+ibF0taKa18bGsvWpFR2kOTU4d/lI1RohnB99C4DFbfri41P+LdxyTx
 8tEbSDyNO5y1yHK51Sz7MSs1QZrXdz2X+zj5hx5OFetSbiv28IpTIQDJIBlWkG+7qAzPPudth
 NKzplgEktuGmXThtGzePHg6NnQOw3mT1zUrR6xID1yVoEYHy6tGI+4xBRYmgRv5fVLGih2/Rp
 RALjEmszRCe16e8DOy4zjwl0FPhOkVGwyk/DVhwK49hTCiQV+kobMAQJQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1591706637-1661163566=:235
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 11 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Aug 10 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > [...]
> > However, this quirk is only in effect as long as `chmod` is run inside
> > the pseudo Unix root directory structure or within the home directory.
> > When run outside, such invocations fail like this:
> >
> > 	chmod: changing permissions of '<file>': Invalid argument
>
> ..ok, but...
>
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 6da7273f1d5..7c63b22acab 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -492,7 +492,10 @@ test_commit_bulk () {
> >  # of a file in the working directory and add it to the index.
> >
> >  test_chmod () {
> > -	chmod "$@" &&
> > +	if test_have_prereq !MINGW
> > +	then
> > +		chmod "$@"
> > +	fi &&
> >  	git update-index --add "--chmod=3D$@"
> >  }
> >
> > @@ -548,7 +551,10 @@ write_script () {
> >  		echo "#!${2-"$SHELL_PATH"}" &&
> >  		cat
> >  	} >"$1" &&
> > -	chmod +x "$1"
> > +	if test_have_prereq !MINGW
> > +	then
> > +		chmod +x "$1"
> > +	fi
>
> ... you get +x semantics by default, so we didn't need that "chmod +x"
> in the first place?

No. We do not get that `chmod +x` semantics by default. Those `chmod +x`
statements are treated as (expensive) no-ops by default. This is what I
meant when I said this in the commit message (that is missing from the
quoted text above):

	[...] it pretends that it succeeded, when in reality it did not
	do a thing [...]

I do not know how to say this more clearly.

> The rest of "test_chmod" seems to *happen to* pass +x or -x, but we
> don't care about that, regardless of the "pseudo Unix root directory"?

The rest of "test_chmod" is even quoted above, so we do not need to leave
anybody guessing as to what it does:

	git update-index --add "--chmod=3D$@"

This asks Git to update the index with the executable bit explicitly
turned on or off, regardless of the information that is available on disk.

And yes, Git does what we expect it to do here.

> What if we get a "test_chmod -o <file>", won't this silently do the
> wrong thing?

But we don't?

The code under discussion is Git's test suite, after all, not something
that every Git user is expected to use in more ways than the core Git
developers can imagine.

So even a cursory `git grep test_chmod upstream/seen` could have shown
that there is no such user, and if this was supposed to be a "But what if
we do that at some stage in the future?" feedback, said feedback could be
construed as to intentionally use up valuable contributor time.

> If so isn't something in this direction (untested) a more targeted &
> obvious fix?:
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 10258def7be..1c3b6692388 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1690,6 +1690,16 @@ case $uname_s in
>  	find () {
>  		/usr/bin/find "$@"
>  	}
> +	chmod () {
> +		case "$1" in
> +		+x|-x)
> +			return;
> +			;;
> +		*)
> +			;;
> +		esac &&
> +		/usr/bin/chmod "$@"
> +	}
>  	# git sees Windows-style pwd
>  	pwd () {
>  		builtin pwd -W
>
>

In that form, I will reject this suggestion as over-engineered and
convoluted. Why is the `*)` clause empty? Why is there an early return
guarding a single statement? Why is the `/usr/bin/chmod` call not in the
`*)` clause to begin with? Why does this code take pains to handle cases
other than `-x` and `+x` when we do not have any callers, and even in the
experimental patches, there are no such users in sight? I would like to
encourage you to address such issues during review before even sending the
mail in the future.

Having said that, there is a nugget in this feedback that I find valuable.
Instead of wasting the run time (even on non-Windows platforms!) to
determine whether the `MINGW` prereq is set in order to skip the `chmod`
call or not, we can make `chmod` a no-op explicitly in that `case
$uname_s` block.

I will make it so.

Ciao,
Johannes

--8323328-1591706637-1661163566=:235--
