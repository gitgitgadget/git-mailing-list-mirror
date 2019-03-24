Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A2A20248
	for <e@80x24.org>; Sun, 24 Mar 2019 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfCXKCf (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 06:02:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:60729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXKCe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 06:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553421748;
        bh=I9cqYnc2XNXkfBJP3WbMQZ59ncTh3FXZyBSxjXrMKmc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W3hVvUeSd7l+VnKbScNDr6PFjY2rCzzI8v1WDgKaMx/dEP8h2QuIdFgiTGyoZbhag
         PTYy2dKp3fDlD8TiPxBJZTpR6LZTZH/9z04BBJ/RokRn2e8CzX6aFHnm+bEZDyz5cr
         pvqcWNnc7O1HKYW+j/xvlaPja58EZxGkGtichAeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZD0K-1hQdJ22Ifc-00KwlV; Sun, 24
 Mar 2019 11:02:28 +0100
Date:   Sun, 24 Mar 2019 11:02:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] check-docs: fix for setups where executables have
 an extension
In-Reply-To: <20190322184347.GC12155@Taylors-MacBook-Pro.local>
Message-ID: <nycvar.QRO.7.76.6.1903241055230.45@tvgsbejvaqbjf.bet>
References: <pull.162.git.gitgitgadget@gmail.com> <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com> <20190322184347.GC12155@Taylors-MacBook-Pro.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HgwpBDEg6BbGzUp7CKbWxzFwE2NBbGvs21XTHMQHyfU8StE8mLT
 TEXxQRKDCcsuZjPlIFMcZOciEyTmctdjCnNTO3zlCp1XeCHZTCcnUxk2W1JWOJ2XrIQZVxo
 2ZH1xkOQj9KtrBWt2TPehNdDYoYaAkymM4dQerWJcL4meXzPmc/gw9rtyjrpLvTgkUjU9ax
 G2cWAiWkEqVkNJpird2kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UA5rA9vk9jU=:NUJb4DQMD9t0GBSu554FTQ
 xwLMnNOJvILBFk5y07Yha+cHny70Brlc3xmVGf1ARY9RDQeOdTst2+STjBpFsFZjshFep1kYw
 oD9S7+JtZ5RHe+T5O9lawfdzO/pS29Eq33com2piByXbAmnf0gtL4Cb2Yz8mpd8Iz/Wu+oT2f
 0ZumnkPl3EGbZ0YZfpyoZcT7edOPrmnemDd5x9SM1kLeTaHA+10vvoi0CmZlWYoEl2xwik5iF
 +fdO2wHviBBeJ4nkVU4GPA9q2+Ev6b2WEsLQdYNpIBH7VMNGbtDObVU5G7TfREy9wln/A7rB/
 dCoL95mH99L2DXIUJTeiyMyVDEvsHtsVbE4BUjpBRv7aN6J9JLY6GHpxxQ0CMlUlz3EY+nQfC
 IwUzR1xJFc/Yng2kFvVaXcarjs1ocCSXteCqZ16QpfU21SQQnHC8Cg0JHsGPrV8SVFyK4yVTp
 p/QvVe7STKOx2hmTzn2+99G/2DFm1hdnrhLFK7eVqlSD8R1sV6va2m7pmk3c5ln4Nqxxia/sG
 q+4jus6IIf/yL2SM6dBkGAoLfRvk8+7k7Ox4mHN/AtOl/N7dJ0l4Qbg8G03jA4TSwCig9E39Z
 nbREC1NBa6myYsfA0PwdkJUnj7XO7audb2MeU257xC2ufR+LEaO4KDXDEKE/4X2h1T/Ba09aW
 wlc6NCeQkpf5KHNA1YpEqLN/AeHy8o9ob8n8MnquKmINGQZmDwkEC0p/KVywRwcsSwLKKWvhM
 48Rs7JtvFtXSZ/iFCaAIJplNRuwW3uAuvH+O4CUzGVJADC8PKyyuIiMo31B77xb0Ulhg0vrOh
 A/c0U7PR31SKjRzA1a+3ffeqpnNerT/AQnM5zEz+gurtGN8BOlYk4oDmNnuzEDO21SCdtGUs2
 4LDI5A89Zb+/eG7i8XDo12xUOc2bVZ/UXhhWLtXQVfiqtdx/nYlW/ivbeLhG+3tpQg5UBoNiK
 yekAGH7a6vw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 22 Mar 2019, Taylor Blau wrote:

> On Wed, Mar 13, 2019 at 04:56:53AM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, for example, executables (must) have the extension `.exe`.
> > Our `check-docs` target was not prepared for that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 537493822b..df56bf0cd1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3074,7 +3074,7 @@ ALL_COMMANDS +=3D git-gui git-citool
> >  .PHONY: check-docs
> >  check-docs::
> >  	$(MAKE) -C Documentation lint-docs
> > -	@(for v in $(ALL_COMMANDS); \
> > +	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
> >  	do \
> >  		case "$$v" in \
> >  		git-merge-octopus | git-merge-ours | git-merge-recursive | \
> > @@ -3103,7 +3103,7 @@ check-docs::
> >  		    -e 's/\.txt//'; \
> >  	) | while read how cmd; \
> >  	do \
> > -		case " $(ALL_COMMANDS) " in \
> > +		case "  $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
>
> I'm a little late to reading this thread, but I was curious why there
> are now two spaces around the patsubst as opposed to the one around
> ALL_COMMANDS?

Sharp eyes, and a *very* good point. The double space is actually required
for this patch to work as intended. I added the following explanation to
the commit message:

    Note that `$(ALL_COMMANDS)` starts with a space, and that is rather
    crucial for the `while read how cmd` loop: some of the input lines do
    not actually have the form `<how> <cmd>`, but only `<cmd>`, therefore
    `$cmd` evaluates to the empty string, and when we are looking for
    `* $cmd *` in ` $(ALL_COMMANDS)`, we do find it because the latter
    starts with a double space.

    In other words, the double space helps us skip the lines that list
    only a command.

    But in this patch, we want to transform `$(ALL_COMMANDS)` via
    `$(patsubst ...)` which swallows that double space. To help that, we
    prefix the result with *two* spaces instead of just one.

Do you think that is good enough?

Oh, and can I ask you to review *all* of my patches in the future?

Thanks,
Dscho
