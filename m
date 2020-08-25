Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C0C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5266620706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UCFseXJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgHYLnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:43:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:52787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgHYLnk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598355807;
        bh=X5V5IDBpQNSE2lE+EQJuatwJaVp+uvvMJffhBxrEAMw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UCFseXJ5NNA0ZlNr4qkGa2v5RAd1K1IruEICUXguSgKzSJ/USFg+VlsASbZd11tH5
         r0Q9DZoD66mEAMCzo3mrOWB+h3ost9m3SiZop0FD8W4QkPOl8+DiCDIPkR5Fgp2QAw
         zD4N4WzeLYv76/dZV4qXckkPreX3Y64LF7JBG6MM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([213.196.212.184]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1kHNuY1dZB-006wM8; Tue, 25
 Aug 2020 13:43:27 +0200
Date:   Tue, 25 Aug 2020 10:30:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed
 versions
In-Reply-To: <xmqqimd750dr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008251020260.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <pull.411.v2.git.1598283480.gitgitgadget@gmail.com> <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com> <xmqqimd750dr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g+y12rNvnU1k3kniRRVs6kZAweTdWj5Q7p8+SCfWvgZg5tnN3/5
 jrZwDiNsCcponQZRr7Io6j8TWQ4YL2jZVXUs85fxvIEXXn71SvZy4Dorm9hjIJHbmavF1zL
 tAdS5NZKLbI80rNqfmwJnbqY4HaUK2BQ+ff0OT++Bwp1ZuCi2gc7NfNeCjYk3HZzkvt8iv+
 /R/hUrK+ZOpgZtjoVqI9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Eq5FmkiD+gE=:9Cx5rrjfHSKpy4GC8HzUa4
 ukRW8jJVe7/DWW8e/YS8nKBbyH8ouLGVqZblNUJUd0BhtRdRsZolMgUoPIAVIyymCp5f3Hi8+
 +Qcbr5FSjkNX2iHlp7HiCjakNrJL9d0Yz8ot+uf+mJ/mMtxIzGCDx2fBgOGP5aImxEoeAJBp2
 7XZrVcnLww24qwprjg3aj4FuqhSnNH4VFXOiqHJIxcc36Np5hr4pA4xrGbWPhdb7DGwginDHp
 ynSt8xoZjnEqBI2pjcdCISral+l4B3DzyykhL8ZT2P79rG2Z3CkqAFI+Gr0V22Bt6VatndQR+
 RoJ0Wi1CUz727rTIte9JM4M0aV22HyddtuoKHRsP4HEyPrZ/aR1E62i+5/gTk+yA3wFFVm1e5
 ptNP2zFhRSqQpB+DyFdOhZfW9TjpY7zTnt29jSZsSMj5cVo/kaD4eoMvNSSFVe8nBTJxmeWBF
 HEtfjfV2QzUBeY4JuU0iuxqsSTPz4eMKdzS6s2T8y121kd6hYfZIXdXIGHeRIKnGYjN29i8bH
 hfOAPe9RPnSmQeZiClILHLL4wIOVbv2/n33cgV4x0stXGi+yJJTODdU2mdz2ZzrYsk4lTSyZA
 hpUSMwO4tiwqZxIDLgvovQD+l+Dhv3w2qRvncYrGLilw4/jH3cw25/wR+S/nKeAafRx7CXslE
 EdlzRp5mLNSWNAbfXuAWJIwE4CvdWMuU9Bo4mUKWHhY3aWFycFmInx9IJurMTZcYmgWOuDN7Y
 Gpjb2+CWSAQ5WMsNPdbvgtLwPyEYdfPy6Eh2GPblS6c06pWhNDcOee0Iy2h9virTKJZWinhsH
 6he2MoRNBVsJrEFmXG7ldp151TCo4F/yaFJF63RMrl3PrqO64g66F7d2A9iUa6RCJiIYBNT6g
 IRAR1L52DWKTMZD2XjjzHC7LsUfkZ32Y4MpSwwqkoMuxzgL+JgFI301so1xUEWB0XH1juSkYt
 C2Bq+aFi+8A/0mfAAB4Tyol4NuUb6+1eYLRP1adUfynzn9A+fzwtkgGXoD+n4L9aTGqsr06pW
 DtR6tu1YgIMYY6jMEBTlJBey7CpwdsoimonzeZOe5reekUSeyESzN8olJHYhjO37b4ZKSUzmJ
 EBQzNSeKVvrA4CvqxeM/rD163dkdUQ6btSX8OGhV2rmGduzZAhMeKaKxWoNqeTOIZGbC3wRzd
 Pwh8VAWuyvIpZp5fGwYwTXJ3oUJq0IQRwJoDLjqUpSyI8fjBo3nMCmHt1EasqeCQqTyIdmqcZ
 1r0Sr/tII7B9JA25wgPCl8YCaksnub+CEQe2Qaw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Aug 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Originally, all of Git's subcommands were implemented in their own
> > executable/script, using the naming scheme `git-<command-name>`. When
> > more and more functionality was turned into built-in commands (i.e. th=
e
> > `git` executable could run them without spawning a separate process),
> > for backwards-compatibility, we hard-link the `git` executable to
> > `git-<built-in>` for every built-in.
> >
> > This backwards-compatibility was needed to support scripts that called
> > the dashed form, even if we deprecated that a _long_ time ago.
>
> This paragraph is irrelevant.  We are keeping the support for it and
> this topic is not newly deprecating or removing anything.  We need
> to argue for a need to test an installation that lacks these builtin
> subcommands anywhere on disk under their own names, which you did
> succinctly below (and there is no need for "For that reason,"
> there).

Could we please keep it? It will help me in the future when stumbling over
this commit, to remember the context.

> > For that reason, we just introduced a Makefile knob to skip linking
> > them. TO make sure that this keeps working, teach the CI
>
> s/TO/To/

Thanks! I guess my keys got sticky or something ;-)

> > (and PR) builds to skip generating those hard-links.
>
> What is not justified enough is why we no longer test installations
> with dashed builtins on disk.  If this topic is primarily about
> Windows (as 2/3 said), perhaps we can do this only for Windows tasks
> before we make a colletive decision to _DROP_ support for the on-disk
> builtin subcommands?

Oh, sorry, I will amend the commit message to clarify that the dashed form
is actually not tested at all anymore. Specifically since e4597aae6590
(run test suite without dashed git-commands in PATH, 2009-12-02), in fact.

All this change does is to make it an even stronger committment to run the
test suite without dashed Git commands.

Thanks,
Dscho

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index 6c27b886b8..1df9402c3b 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -a=
w "$cache_dir/.prove")";;
> >  *) ln -s "$cache_dir/.prove" t/.prove;;
> >  esac
> >
> > -make
> > +make SKIP_DASHED_BUILT_INS=3DYesPlease
> >  case "$jobname" in
> >  linux-gcc)
> >  	make test
>
