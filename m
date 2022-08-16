Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FCEC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 11:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiHPLUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiHPLUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 07:20:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5F65677
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660643347;
        bh=1oS6B/3Ql+6kzHLRuV7n2i9/VuNNouCNK28RVHX0+ko=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X/P+LUcATpiEyuF5v2XeeJ/zoesIcgeryoCKHyDO0h6Ob7uAbHGW08XHrBXoUb58j
         BueQOJzR/eA5SUkTBErT9DmQOr0n2sHTGlKqUyc9c3Np/GzeEFKUJhg+MyBkP0yqia
         UPuHmAub6hoPlXtMqsWE8EZ3ZckqxUlFUj46jN/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1oGTbV3uot-007Rwc; Tue, 16
 Aug 2022 11:49:07 +0200
Date:   Tue, 16 Aug 2022 11:49:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous
 branch"
In-Reply-To: <xmqqk07iu3c3.fsf@gitster.g>
Message-ID: <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com> <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> <xmqqk07iu3c3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-746212442-1660643349=:241"
X-Provags-ID: V03:K1:WM9iTM5tgHI1WJcN4CBasqn7B+EZAC3aq+MWNSUMTEuFECYU1sH
 OdnrE/9a2sfYylSkNDn3zZkPldo1MWFOk9gGd70A9rTmHcyg7qPtGGG2v7hsbpaxGxFwCN0
 1GlM3rNIDXX1nUIF1ykBjY7Mc9+2Jd4JjfFPWV/oaBo46zdIYqc4wMeMLR7HZZ+bu70p8Dq
 hUo5Kyu/eDXr8xu9dBZHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jb9SmRfdp7w=:AmcIkkA6ULrNUwfRxp04kV
 xLHOO/DInjIbq9/8WH/h0EOWX6F1BVJCiiKmGp5N63dqqx3zqtJb3fBZmSPv/bFAzXl9GNRQH
 HljPCEyrw1l/k/Yt2kXHVHh5hMxwGhqjSp0B4xMcKogJ7ARWtUhd/SFTxSKXnpfKtjHEbLOSu
 YyQmrtm3o6at1CCVjx35ebzxokH2H0VW4TWuXKKnRku1fV3yCZzFv1vRfTGBTtP9GbJ5LuOzq
 R/L6JqRIz17XtGGdqEu8IsmfHErudZLrkXihieM5j4Jv4nhgzT+/zv3JH0L2luc/8PREeh4Nm
 U0e8uqfQEyafPtrzRJJer2tmSo2Drd7/oX3QyV3qzy17isPW+zMd38HEuxuqNJYf3oIBHqBx1
 6HhLuhACV7T9C2FQQCscf5CWQfuIaiZ1QKZFz1QdtoA3QWbVbeyDLNUehOsBVmG4JJ8P6hKQ6
 4fwfZgi1ybCNtzqZXjLBoZBIlFOge3yOSdjkEr24kigZEZzhxCIIzYq9MlQPTxdnioEuvi45F
 bobZY94Uykco6DHO0pSEiDlxF+5xmt8mvdfKB8ndgQpXAP9yI+XrjjH1/5J0QtnBatVnmpjCe
 6O29rg2SQ1tzZTervSwo/qsXxIk4boH5VftarUYVp3gTSvKBAEiETR7LKNOSGxTwePPf3ynJy
 6uGW35SfXtRkuJ6ULmLiIb/ON2gUwUJ/P+Wym5aoT6zVc7jmMfevoA405x1GhqIhf5/MQ37Oy
 C8I+iUbl2pe1g++qYsBwRmjCMSUpjxUgYPKYUnbzzQyITwRPGKTnTeyO6PPriguV+J04jfJwD
 4RuCXFTYXE7Lau9+k0ZR+dKNzv0mw+OitzuAbWB0xmk8dEaRrNanXN1+1uxgTh6pTuCiJlD0K
 MZ3reZzS2A5eTSYqv/b7vwQA3yYdWzzCu0GZOO/7k8LZ9SREMtAS7EoCgplFTB1daTI7i/I6o
 BNeZQrzh+1KRtrYx4kABdxPKTIb7LO+OIAAu3/HrSRTCFbvtu0pMjq6SvKTTnDAQIfU3qr+78
 6EoE9IOb3poGaafCme+HVutravTkKQAkYJ9Y1DXTX7weMFlkF0bk0TrF3qZm53SxDsxWauj8e
 FUu6qcauJyhq4eRbLP7iACfycjZRaUVM6JaMxp7JtXQ4Ul+OZDoLq41xw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-746212442-1660643349=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 8 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > @@ -1420,6 +1420,12 @@ static int interpret_nth_prior_checkout(struct =
repository *r,
> >  	const char *brace;
> >  	char *num_end;
> >
> > +	if (namelen =3D=3D 1 && *name =3D=3D '-') {
> > +		brace =3D name;
> > +		nth =3D 1;
> > +		goto find_nth_checkout;
> > +	}
> > +
> >  	if (namelen < 4)
> >  		return -1;
> >  	if (name[0] !=3D '@' || name[1] !=3D '{' || name[2] !=3D '-')
>
> If a solution along this line works, it would be far cleaner design
> than the various hacks we have done in the past, noticing "-" and
> replacing with "@{-1}".

Indeed, but it does not work as-is: `interpret_nth_prior_checkout()` is
used on prefixes of a rev, and for the special handling of `-` we cannot
have that.

To illustrate what I mean: `-` should not be idempotent to `@{-1}` because
we want to allow things like `@{-1}^2~15` but we do not want `-^2~15` to
be a synonym for that.

Therefore, the layer where this `-` handling needs to happen is somewhere
above `interpret_nth_prior_checkout()`, but still well below
`delete_branches()`.

> For one thing, we wouldn't be receiving a "-" from the end user on the
> command line and in response say @{-1} does not make sense in the
> context in an error message.  That alone makes the above approach to
> deal with it at the lowest level quite attractive.
>
> In the list archive, however, you may be able to find a few past
> discussions on why this is not a good idea (some of which I may no
> longer agree with).  One thing that still worries me a bit is that
> we often disambiguate the command line arguments by seeing "is this
> (still) a rev, or is this a file, or can it be interpreted as both?"
> and "-" is not judged to be a "rev", IIRC.

I haven't had the time to perform a thorough analysis (and hoped that
Rub=C3=A9n would rise up to the challenge), but I have not seen a lot of p=
laces
where `-` would be ambiguous, especially when taking into account that
revision and file name arguments can be separated via `--`.

One thing we could do, however, would be to patch only
`repo_interpret_branch_name()`, i.e. only allow `-` to imply the previous
branch name in invocations where a branch name is asked for _explicitly_.
I.e. not any random revision, but specifically a branch name.

This would address all of the `git branch` operations we care about, and
leave invocations like `git diff -` unaddressed (which might be more
confusing than we want it to be).

> Luckily, not many commands we have take "-" as if it were a file and
> make it read from the standard input stream, but if there were (or
> if we were to add a command to behave like so), treating "-" to mean
> the same thing as "@{-1}" everywhere may require the "does this look
> like a rev?"  heuristics (which is used by the "earlier ones must be
> rev and not file, later ones must be file and cannot be interpreted
> as rev, for you to omit '--' from the command line" logic) to be
> taught that a lone "-" can be a rev.
>
> So it is quite a lot of thing that the new code needs to get right
> before getting there.

I am not claiming that it will be easy to perform that analysis. It will
be worth the effort, though, I am sure.

And it will be necessary because the current approach of
special-special-casing `git branch -d -` is just too narrow, and a recipe
for totally valid complaints by users.

Ciao,
Dscho

--8323328-746212442-1660643349=:241--
