Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1ED1F461
	for <e@80x24.org>; Fri, 17 May 2019 22:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfEQWC0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 18:02:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:38019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfEQWC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 18:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558130537;
        bh=/uoI+o2r0z/wSibRBhuMLLytx+Tn9vEGMIoaPZw4KS0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CfyodInFs1BnqFRDRKmtouAyMOg7RefnFJZYZ5ZDEXZvzVddSdXZRChECKrxBpVZc
         CxT9c+Z16wBkDpnVJFdE5FQBzxcfbyMBeOy5zhDJcB3H+SAFz/mXAojB2mBvJbbg8v
         4WlivNu8Eb6ioy0WdVe3quEqFyOzcR2XlpvS5OlU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRTiG-1hGmXp0gqe-00ShYl; Sat, 18
 May 2019 00:02:17 +0200
Date:   Sat, 18 May 2019 00:02:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC WIP PATCH v8 13/13] WIP: can_fast_forward() support for
 --preserve-merges and --rebase-merges
In-Reply-To: <20190508001252.15752-14-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905172316260.46@tvgsbejvaqbjf.bet>
References: <cover.1555832783.git.liu.denton@gmail.com> <20190508001252.15752-14-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1307149947-1558130547=:46"
X-Provags-ID: V03:K1:Ia+NKCY7+ezkV8RZWwFAc0e28TxAfqabaiEQR0tal2Oawpb9cgI
 ouT7UOFwgUsPEcZWYtpsosqYr/XrXOp7AHKd0sN4ht0Sz1MAEJIu3ZIbODGN8OdNPWoFS2A
 mNa7MmOahlDzE0WqovDo+2iWqEtmUQ+8O1MaQD+4Vhte1zfKkNLx0n/D15crlzydMf7VsNZ
 QOvG4f7QwZJ0Wcd8MVFZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGCQvXAltVs=:OZqXw5LkwsW+UaIKY78d5A
 KglRfer6sxRxDWs2WcSB7cxLl8hZLTrxd6Vpo+FAJ7BCOdmtzlSaVZ87Vblx7D00XHyA517K4
 FA7py9jIPXvO64P/3t2Dc+zmIlWTfmRcv0rbKFVj2wRlXLHYCGZcM+NGi40ewU0hObeg/T9Xr
 loZjXR331Dwk8y8jLSGngNttDboBUMWyTWBSZQ8pIU6awGqmOurAUgG4Jgc7xO/rR5IvPrkcF
 /oahSKreoW0isfRhmwEIv9lColCK5FVLdhFYaHueNxYfTfNmKUalmv1t2iyncHsDeaA9ogogj
 MnFCS5h0mJ2veRSbt42pp02BfSQnb29qPdI6Ynnan7GHLczmoKFequJvJYs3xB+/h+X8iGLE4
 +Tph9DOUOKHYYnv+6eTxtQTx4kX8a+SO1QDaOiOuwkI8wMV40R4+ZmGp8P9mWA8SXkjpJbG59
 KMIdlmSg50qW+1wQ3QJwWOhaxxQ7heb8J3HwBaGNR69gkYdTtHiE+o5sM7F9YNeFiWU7lGumq
 UDU6SfTsDFzEZh5QGkeH6QPxo0PNO65k1Pl1DPTMhjY8/ZS8JSom6fDbB62cYR/Bnwe3JN+4X
 KzSZ7W6ESLNTFiyb5QTn+OlcmLA+f6N408Z36pgY6XaEph1C/8ayGEByD9G6bDiFdkji6jWpH
 vQGR1A3mBksnHOc24/zsIvk5+DAdN08rA5xDDdEoRTJqd/Vt0VeV0dwQGUruqVTpBdZPU5Hk4
 U3M9aSwhKPqdrQVjBVOjymlQ60Gynd7D1PrTCID+wNbCEXUBlgdScJV6tUHkbBCZPPdqCXk5X
 ggBPeN4YpYqHMkqqN7gBLKhGXFeyYEXBxOegKXjwM0WnwTv7v5U8FJb1T6oktHA/65n4l681F
 PQMmuiAwboqPPMvyPVh88kWAdDryval6QahjjMmnxn6N8PxOXzJhF3fnlPxO6SS265Mus/kMB
 7YMTfueToydi0nsvrPJAXcxDTitTOdRhBZHqVZJODvnVeTYCglcf2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1307149947-1558130547=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 8 May 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This seems to work, needs more tests etc...

I can see how it works, but it is a bit limited, and at the same time
overzealous.

The reason why we do not enter the fast-forwarding block in the
interactive case would appear to me to be that the interactive rebase
*might* want to avoid fast-forwarding e.g. with --force-rebase.

However, that is not the only instance where we must not simply
fast-forward: Think `--exec`. There might be others, too. (I just saw that
`--signoff` sets `FORCE_REBASE`, but `--exec` does not, so you cannot even
use the `FORCE_REBASE` flag as indicator.)

Since `git rebase -rx "make -j8"` is something I use myself, this here
patch would therefore break *my* workflow.

This is the "overzealous" part. Now for the "limited" part:

Let's take a step back and ask how the interactive rebase handles these
potentially fast-forwarding cases? Via `skip_unnecessary_picks()`.

And that function is ill-prepared for rebasing merges (I specifically do
*not* think about `--preserve-merges` at this point, for all I care, it is
already deprecated *and* dropped).

Even if this function *was* well-prepared for rebasing merges, I think
that would miss the mark. Take this todo list, for example:

	label onto

	# Branch dscho
	reset onto
	pick a123 first
	label dscho

	# Branch avar
	reset onto
	pick b789 second
	label avar

	reset onto
	merge -C c124 dscho
	merge -C d314 avar

Two branches, both one patch deep, both merged, one after the other. Now,
if you insert `pick abc zeroth` before the first `pick`, obviously the
first branch would no longer be skippable, but the second one totally
would be!

This is the "limited" part.

To remedy this, I think what we would need is code in `pick_commits()`,
right where `TODO_RESET` is handled (or more toward the beginning of that
function), that would:

- parse the argument (this is currently done in `do_reset()` and would
  have to be refactored out) and pretend that it is `HEAD`,

- look at the following command: if it is

	- a `pick`, and if its parent agrees with `HEAD`, pretend that
	  the `pick` was actually a `reset`, update the pretended `HEAD`
	  and keep looking at the next command,

	- a `merge`, and if its option was `-C <orig-merge>` (not
	  lower-case `-c`!), and if its parent agrees with `HEAD`, and if
	  its merge head(s) agree with the original merge commit's (if
	  any), pretend that it was actually a `reset <orig-merge>`,
	  update the pretended `HEAD` and keep looking at the next
	  command,

	- a `label`, perform it, but with the pretended `HEAD`, and keep
	  looking for the next command,

	- a `reset`, update the `done` and `git-rebase-todo` files and
	  start the entire spiel from the top,

	- otherwise perform the reset.

- all while skipping, this code would need to take care of updating the
  `done` and `git-rebase-todo` files,

- if a `reset` is necessary, and if it fails, the `done` and
  `git-rebase-todo` files should *not* be updated, but the original
  `reset` should be re-scheduled, and

- since this adds quite a bit of code, it should probably be done in a
  separate function.

Instead of marking this as a left-over bit (which I would either forget,
or whose status would be hard to track), I decided to open a ticket:

	https://github.com/gitgitgadget/git/issues/209

(I opened GitGitGadget's issues for exactly this kind of use case, because
I recently tried to find some useful left-over bits as easy project
starters, and even *I* found it super hard to find those, let alone figure
out whether they are being/have been addressed already, a mailing list is
just not a good bug tracker, even if it is still better than trying to
report a bug on Twitter, where I could not even have written this
paragraph in a single Tweet.)

Ciao,
Dscho

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/rebase.c               | 6 ++++++
>  t/t3432-rebase-fast-forward.sh | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 167d4fcf67..de1c5cacb8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -892,6 +892,12 @@ static void populate_merge_bases(struct commit *hea=
d, struct commit *onto,
>
>  static int should_fast_forward(struct rebase_options *opts)
>  {
> +	if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
> +		if (opts->rebase_merges)
> +			return 1;
> +		if (opts->type =3D=3D REBASE_PRESERVE_MERGES)
> +			return 1;
> +	}
>  	return !is_interactive(opts);
>  }
>
> diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forwar=
d.sh
> index e8a9bf42b6..d3e1815057 100755
> --- a/t/t3432-rebase-fast-forward.sh
> +++ b/t/t3432-rebase-fast-forward.sh
> @@ -44,12 +44,13 @@ test_rebase_same_head_ () {
>  	test_expect_$status "git rebase$flag $* with $changes is $what with $c=
mp HEAD" "
>  		oldhead=3D\$(git rev-parse HEAD) &&
>  		test_when_finished 'git reset --hard \$oldhead' &&
> -		git rebase$flag $* >stdout &&
> +		git rebase$flag $* >stdout 2>stderr &&
>  		if test $what =3D work
>  		then
>  			# Must check this case first, for 'is up to
>  			# date, rebase forced[...]rewinding head' cases
> -			test_i18ngrep 'rewinding head' stdout
> +			test_i18ngrep 'rewinding head' stdout ||
> +			test_i18ngrep 'is up to date, rebase forced' stdout
>  		elif test $what =3D noop
>  		then
>  			test_i18ngrep 'is up to date' stdout &&
> @@ -79,6 +80,8 @@ test_rebase_same_head success noop same success noop-f=
orce same --keep-base mast
>  test_rebase_same_head success noop same success noop-force same --keep-=
base
>  test_rebase_same_head success noop same success noop-force same --no-fo=
rk-point
>  test_rebase_same_head success noop same success noop-force same --keep-=
base --no-fork-point
> +test_rebase_same_head success noop same success noop-force same --prese=
rve-merges
> +test_rebase_same_head success noop same success noop-force same --rebas=
e-merges
>  test_rebase_same_head success noop same success work same --fork-point =
master
>  test_rebase_same_head success noop same success work diff --fork-point =
--onto B B
>  test_rebase_same_head success noop same success work diff --fork-point =
--onto B... B
> --
> 2.21.0.1020.gf2820cf01a
>
>

--8323328-1307149947-1558130547=:46--
