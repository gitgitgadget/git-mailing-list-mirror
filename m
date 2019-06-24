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
	by dcvr.yhbt.net (Postfix) with ESMTP id 625581F461
	for <e@80x24.org>; Mon, 24 Jun 2019 10:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfFXKNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 06:13:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:50607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfFXKNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561371206;
        bh=a93udMfmvhYWCLGupw1+EPilHBdR2VkWHomvIc4xXh4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OtNpYusvdxv0jFiID9Y1XJ8ac8o6nAQvwBBKgbhdaEfXK+A1m87i4cZy5YirPrdzM
         MYDcgHS+6J6BNylLKfHhRE2zGjabAMsHdTkCQldQt1/02gMNn/VlqwfGVMUITEUj19
         yARadrJPusH24tclgOpnuKZ0MyaevfSqB+tDYVCg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1i5mnG1bFo-00QVcO; Mon, 24
 Jun 2019 12:13:26 +0200
Date:   Mon, 24 Jun 2019 12:13:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906241212220.44@tvgsbejvaqbjf.bet>
References: <pull.151.git.gitgitgadget@gmail.com> <pull.151.v2.git.gitgitgadget@gmail.com> <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet>
 <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U7fTYaozcUCYhhhrsKDEZDDMjB1+yz+ThouUQzUDFdqQDq4YphK
 6eQp8duvfna5g3iQ9Cf2FNO1SNw4LISJKaoLf3O98+guXES/fPPxjzOJWTaB+5A86cg5NZI
 KcSecinF34LXGgv6aMFVY6VdqmHTp6hREYzlX3jf20p7Gyy+BsC7CBs5wDa87Y8OXpq+cNb
 lGJiPZK9H/iSPDoHLAlXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7KXUdeM0iw=:DsvFq5tMl0BDEm/n6WwDR2
 9ALgn5l8USbxhAwNU8wUxU2sqrHyMBWZ9/272nqobGIhPJzKWZeCKLYeZbnKr6jYInkB6aiNM
 jiogSiv/uwp5+F8G3CM/zsVrYe9PUwyX8F42Rp1cG1k0BtnehO1iP1uwqZmEZgb9SDSNfFRng
 TIa3N0qyD8H+I+2iHvlT65r4Is/mGvnxRIH1VVNiitoiJZR5ZbACOH+PmrQwyEyFZmlq/kHkn
 ZXdBm5ulRHPd2fcU1hJlj2IzzlDrLiEbMXV7ApYKpehMWoSl50k+CH0dGV9HgZyTOxmwUjmco
 pDHQOH0L4gI6xOseT22yeC62MOgHYrBTSF208j+x9fOhZqJ+Dtg5fyYwYKBzPh+3QiELk9SIf
 pSBmwW7iRwFazp93K/apfixz6EVntOVdQyng0BY8jXUowijKc42yq4yQHpk86JDLVpi/c3hGf
 Y2Lds0JefWaoLc7GTZ97RSJmWEJrei0qICQ+0xVwOjr5UwW2ddKPKBfB2xxy/mW369+AG8oAZ
 87oCBm5NWZAMK96pbJQYAR+59GjSl8h0Wt0aAsvzMoJuEYl8oWDZEAlFE9SaTFVjYf4OI23Ml
 FOaf7bHEzItzcBUsp45vHKD0kVbN3WNNgOJfDbTaW8Il4d75iuCmY/j0fvgeGnfnZHcz+Vt2o
 k2GeGLjtM7hVNc2XpseB98Jga1/c+XLXswWaF2NaWMfdzY92tKLSIa9wcV0EgilhALTgt9NXP
 ffMHs8tOZPP1yrfFZ5zT6kaL+lvPuaEY/9NJzbiKroLTXfKMoD0Bt3+84YkuuW/n6rRJvDPjb
 Y+4cmwgeZuledG3pYXrSDGLB5ufApUoRsHjgUCrLj/G1GLE88wF8/gu8UIy42r8TlWdtQVma3
 BEo4UtlOXkJIfLDiNWsAirFEloXJfyS8sQQPgr7Ar+07LMWbrwoZowcjBhJyDBLK/185gPhOg
 qFIwzba/ixBnCjm9uhkYh1qCGxAL96IQkOJ9edqPtMr7iXvbHooM5
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 21 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > [Re-sending, as the Git mailing list seems to have decided to silently
> > drop this patch, I cannot see it on public-inbox.org, at least]
>
> Move that below the three-dash lines; otherwise the above two lines
> will make your in-body From: ineffective.

Indeed, sorry, I forgot.

> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 42a263cada..68f713884f 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -307,10 +307,22 @@ test_expect_success 'init prefers command line t=
o GIT_DIR' '
> >  	test_path_is_missing otherdir/refs
> >  '
> >
> > +downcase_on_case_insensitive_fs () {
> > +	test true =3D "$(git config --get --type=3Dbool core.ignorecase)" ||
> > +	return 0
> > +
> > +	for f
> > +	do
> > +		tr A-Z a-z <"$f" >"$f".downcased &&
> > +		mv -f "$f".downcased "$f" || return 1
>
> It is easier to read to enclose the whole filename inside dq pair,
> i.e.
>
> 		tr A-Z a-z <"$f" >"$f.downcased" &&
> 		mv -f "$f.downcased" "$f" || return 1

Okay.

> Not grave enough to be worthy of a reroll on this one alone, though.
>
> >  test_expect_success 'init with separate gitdir' '
> >  	rm -rf newdir &&
> >  	git init --separate-git-dir realgitdir newdir &&
> >  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> > +	downcase_on_case_insensitive_fs expected newdir/.git &&
>
> It is somewhat brittle to munge what is in "newdir/.git", which will
> affect later tests that use newdir/ as a repository (this one will
> be removed soon, but the last one in the sequence this patch touches
> will persist and is used by other tests).  It's not like we are
> testing that Git will function OK even after futzing with the ".git"
> pointer file (if so, we'd want a separate test that specifically is
> designed to test that behaviour).
>
> I wonder if we want (possibly local) test_cmp_fspath that can be
> used more like
>
> 	test_cmp_fspath "$(pwd)/realgitdir" "$(sed -e "s/^gitdir: //" newdir/.g=
it)"
>
> to compare two paths, honoring the case sensitivity of the
> filesystem.

I agree that that's a much better approach to fix the issue.

Thanks,
Dscho

>
> >  	test_cmp expected newdir/.git &&
> >  	test_path_is_dir realgitdir/refs
> >  '
> > @@ -365,6 +377,7 @@ test_expect_success 're-init to update git link' '
> >  	git init --separate-git-dir ../surrealgitdir
> >  	) &&
> >  	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
> > +	downcase_on_case_insensitive_fs expected newdir/.git &&
> >  	test_cmp expected newdir/.git &&
> >  	test_path_is_dir surrealgitdir/refs &&
> >  	test_path_is_missing realgitdir/refs
> > @@ -378,6 +391,7 @@ test_expect_success 're-init to move gitdir' '
> >  	git init --separate-git-dir ../realgitdir
> >  	) &&
> >  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> > +	downcase_on_case_insensitive_fs expected newdir/.git &&
> >  	test_cmp expected newdir/.git &&
> >  	test_path_is_dir realgitdir/refs
> >  '
> > --
> > gitgitgadget
>
