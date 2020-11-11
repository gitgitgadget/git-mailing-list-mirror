Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82601C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0733520709
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tz0UkoSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKKPxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:53:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:44687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgKKPxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605109993;
        bh=ewaRQwvymUhnJM2GYcDhDbxlMkzgMTH1o4qQhMGHh0k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tz0UkoSjP3cLsB3XBo09B6CEyyESblv3j8/qZbDLstpCXLoRX9ciJh+0d+XWKcC5P
         CJ8aa/Ti4OiMpkiweAna3XQUGaVJjLlayYhMcD4k37mE0jW+9RBuHMoFHAVXV+/toh
         PALBrqFHNIbMuoa4Q1KbVc0lAlCa6f8ZSq3Uzsy0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1kJH733MV6-00t8Ne; Wed, 11
 Nov 2020 16:53:13 +0100
Date:   Wed, 11 Nov 2020 16:53:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
In-Reply-To: <20201111023549.GB806755@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011111635140.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com> <20201111023549.GB806755@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HfJ0vqUnS1Y5xpdvjZ+pcnr2NQK4kZetoYF7raOF0slQQuAUIIi
 b9VxzDYnL4u1sHLouy1YdyHalzG2DbsVEhcjCEBxZGwgDzc/pgdK5dAeKYRumspYrEgxb4z
 PPhaMHTPgsFjFkym6Ptq+uN/bsSO6eGaKRtMt3Mtv417MNh74wchuaVg+zffavhaXlgSJKE
 nNiKhrWO4v84BGYza12yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:otLo9ho+uBo=:oWB+sYBrifyUehBDCk1jkm
 CY4efF3KE9tb/3psgTlkNA7CUEEaMSiKvMcz9CWzEX27KXCdHVPYxVmTUokXMB6Ifyl3StsQf
 S0nSIWSKid4pVlR5cnOtBWbthWGOgEaI8tms8lIILuDHZ1h1bV/HqqlK2CLug8DVq3afs53rl
 CuyfAzW2McMBlQR5Xl6WDe2Mg9aX4SyqarOAvWKKkTJzIBmOpWItfo3mTnnJrURaUNC9dwWhE
 s3HGevdFWceNgXWMkRiPnJlpHjX3Wqca3TOnboDsWw0YSTjefTRvsAM6j7Cdc5Lcgf8XyAQfX
 R5l6SWovR1d8FPP37abGpxyC9SQaOb+Q4LbzpRcJl+iiH35v6bfPvKx7Yhm3wre6vvZxWPy4a
 foSpbd/Qx63EtaUddzN4w5q4GQrNchlo2rDblEgoXGFZE2Ikr1Eu2BBvdcFOKdS6h6lOfrxoF
 Gt12f8XwZBg3WqgLI/wbo+iYlRBDcgtpjeDh7iobQkTdmngOxuc+rZzZf2kvBd2oayh7wF2SJ
 OBHHMAjC1Uxby5hhjg1WfKCjoRFuXXliSN/Uj3QJAQO8TdKHiyfh/h7eTRStpdRbJc+unbBrZ
 0OIixFU1S88OOE5GGZ12dItCTIvJZNxzINMiWstfikMjz0d5MsvgTzFEp7PiaT/LZRZQBTVVa
 WvwrgZ8jJAzMaUL/HizCvCPtWB1BuJUAw1iZ0Xix3sY1hHDsiAJhyIotI7VGPz4CQtJKFgt3N
 NQGM3EVtU7XJ3sRL4gZyo+Wzx6GLAlDphgTq5AeCmOV7wDJ9PUKWyTDCy83QuNTUdh2cpY9CP
 xjKXu6hOAt3MQV4jGc5QofyccZB0GBlP+rLVhyVuDCkW1v0f0aepdYZjiGasTq5rGbylwoTSv
 Rh63F92IeJ8nze+AJbh3M4EtS1a9vl9TYSfzYP2EI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 10 Nov 2020, Jeff King wrote:

> On Tue, Nov 10, 2020 at 11:42:19PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Now that the Perl version produces the same output as the built-in
> > version (mostly fixing bugs in the latter), let's add a regression tes=
t
> > to verify that it stays this way.
> >
> > Note that we only `grep` for the colored error message instead of
> > verifying that the entire `stderr` consists of just this one line: whe=
n
> > running the test script via `dash`, using the `-x` option to trace the
> > commands, the sub-shell in `force_color` causes those commands to be
> > traced into `err.raw` because we set, but do not export
> > `BASH_XTRACEFD`).
>
> Your reasoning here confuses me.

Sorry!

> If we are using dash, then surely BASH_XTRACEFD does not matter either
> way?

It kinda does, though. Dash _does_ respect the `BASH_XTRACEFD` variable,
funnily enough, but does not hand the settings through to sub-shells,
whereas Bash does.

> Perhaps the subshell is important if we are running bash, though.

The most important thing, which I of course _failed_ to describe most
prominently, is that _in general_ `-x` will mess up the `err` file, i.e.
when running with anything but Bash. Therefoer we need the `grep` instead
of a `test_cmp`, and that's what I tried to convey in v2.

> Either way, being forgiving to the use of "-x" is a nice convenience and
> I approve.
>
> > +test_expect_success 'colors can be overridden' '
> > +	test_config color.interactive.header red &&
> > +	test_config color.interactive.help green &&
> > +	test_config color.interactive.prompt yellow &&
> > +	test_config color.interactive.error blue &&
> > +	test_config color.diff.frag magenta &&
> > +	test_config color.diff.context cyan &&
> > +	test_config color.diff.old bold &&
> > +	test_config color.diff.new "bold red" &&
>
> Since you are being so thorough, and since it is already in the output,
> maybe color color.diff.meta, too? Like:
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 28549a41a2..cca866c8f4 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -594,6 +594,7 @@ test_expect_success 'colors can be overridden' '
>  	test_config color.interactive.help green &&
>  	test_config color.interactive.prompt yellow &&
>  	test_config color.interactive.error blue &&
> +	test_config color.diff.meta italic &&
>  	test_config color.diff.frag magenta &&
>  	test_config color.diff.context cyan &&
>  	test_config color.diff.old bold &&
> @@ -625,9 +626,9 @@ test_expect_success 'colors can be overridden' '
>  	  1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
>  	<YELLOW>Patch update<RESET>>> <RED>           staged     unstaged path=
<RESET>
>  	* 1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
> -	<YELLOW>Patch update<RESET>>> <BOLD>diff --git a/color-test b/color-te=
st<RESET>
> -	<BOLD>--- a/color-test<RESET>
> -	<BOLD>+++ b/color-test<RESET>
> +	<YELLOW>Patch update<RESET>>> <ITALIC>diff --git a/color-test b/color-=
test<RESET>
> +	<ITALIC>--- a/color-test<RESET>
> +	<ITALIC>+++ b/color-test<RESET>
>  	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
>  	<CYAN> context<RESET>
>  	<BOLD>-old<RESET>

Oh my. I really had tried to avoid going _this_ deep. The `.meta` setting
is not even read by the interactive add command:

	$ git grep -w meta git-add--interactive.perl add-interactive.c \
		add-patch.c

comes up empty.

The reason is that we actually let the diff machinery do all the coloring.
So why, then, you might ask, do we bother to read those values in the
first place?

Well, you know, in `git add -p`, you can split hunks. That's still fine,
we basically just have to color the hunk header that we insert, and can
reuse the original coloring of the remaining lines, because they are
unchanged.

But. But you can also `edit` hunks.

And after that `edit` step, those hunks have to be re-colored. And _that_
is why `git-add--interactive` bothers to read those `color.diff.*` values
to begin with.

Now, how do you see this re-coloring in action?

I am almost glad that you asked. By simulating that `edit` in the
regression test. But that is not enough because the hunk is staged
immediately after editing. But you _can_ go back to that hunk, even if it
already has been changed, and make up your mind to _not_ stage it, but
that only works if `git add -p` hasn't quit already, which it would do
with a single hunk, so we have to have _two_ hunks.

This not only complicates the regression test, but _of course_ (because
_why would I already be done with this patch series???_) it shows further
differences between the Perl version and the built-in version. It's almost
as if `git add -i` said "Johannes, you think those 500 hours were all you
would spend on converting me to a built-in? Think again!".

One of the issues I found (and fixed in v2) was that the built-in version
tried to be practical and _not_ special-case a count of one in the hunk
header (`@@ -3 +3 @@` is equivalent to `@@ -3,1 +3,1 @@`). Well, now it
does, just like libxdiff and the Perl version.

The other issue was that the Perl version still used `color.diff.plain`
instead of `color.diff.context`. I hope I found a good-enough solution to
the problem that we simply cannot call `git config --get-color` or
`repo_get_config()` with _two_ keys to look for (and the last one wins).

For those reasons, v2 brings more changes than I had hoped for. In the
end, it is a better patch series, obviously. So even if I was reluctant to
work on all this: thank you for prodding me.

Ciao,
Dscho
