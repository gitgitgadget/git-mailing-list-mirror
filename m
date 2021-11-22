Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F15C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhKVNiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:38:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:57637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhKVNiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637588093;
        bh=AaPC3+RWucfcQl2xkCheSzK/pGxUloQDsV2omE6vLos=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OmYGmiM8P+Jb328ul8M5CYzh43nsJo93QpF50ieVdzvsJJ4zGlfvWVpGXswTaw90h
         lyhWg30OxgfPephxW14xwY2v+aHpP4wE3NwiBH0C2CG7Zod64QGXoxa/RuuP6uO/Nh
         KC7RJ/h+bnJpXfTxPymuF3FOKz4il3Glq6skgbhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1mj4eh2LvC-008MHa; Mon, 22
 Nov 2021 14:34:53 +0100
Date:   Mon, 22 Nov 2021 14:34:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 05/15] diff --color-moved=zebra: fix alternate
 coloring
In-Reply-To: <56bb69af36e5e3180d53586d30048d5033a01d14.1637056178.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111221431350.63@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com> <56bb69af36e5e3180d53586d30048d5033a01d14.1637056178.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UzGW3Pnv9mBTEmwCspJfS0Vshc3iqmkqUiBbs2a4gV7Ig0UL1+C
 TEh2MkpPLT4f5Uu+TKVqDW/EV2kK0JJ4QsO//fRCyFDc08rlTBXdTqCwFqJFeeoXpT37ogK
 EJ1m57+Kso1tVWjnR2qTLEuCgGyYtWP+Gdgz4ZkacfzKqD0fAtwQyk0zuN72AfuhAuzf/7C
 elDadPqe++QxfFzHJNa4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGSPaxQXvtc=:3nJ8Q2h4dbfISWUUvMkpeI
 m/ITuDa9pcVHjJ2wWkUyvweXdg4JcZTrQxwJrzOC2BK3JIEWQ/+O4SmdxiqHgNzFxqyocq43b
 3vnxAuiLLOtW3fwTxUohctMGt++28md66SBYw7tN/4BB4JsXUHq+X3TOW344Pq12C6SE8o2U1
 lOmyQ6Hi5xWvHSEB6DagOouTCSoU+sP0NWLq92lNFUspTBIOIUbu1AhsDpBRTI4zqH32UbrBp
 6538cNEU6PywYIQ/SkwTyquVafj3Qa25XmU4+KUUDW9fuIQfW6LsfwQXBFpnpru+2vIn2CXxo
 u4KRCExgPNE2lIlqT67xAc+J9/oA0XhaVXrfzpDvDlkyNp/1Wn577DbIVJYugNpe3tI3/v29r
 2GIJ9jnU88LhV5dN2joc7oWhU/JrFfKXvINRJdp6q9THBpv8VSB6G6/dSRLbGXyzP4CMTlCyl
 3verryCevZXv3z0oy+6dnbihpfPxemprvrazLwWQTAFsTq9iY+pdJjrm4KAT/ZSxrU6nOXfGX
 wNC9bNsAGIG/JfQOqVpmhvKWf+vYfHAeJEOuYP0iYaMi2s38cxQI8LYLFUPDRTe0rBbwByUCi
 ZcR32sBNwcljiQ4pWMrcuTGsysJMnZwwixqhmv98OQxlPlJCkYa8VLIAxTsY8chKTmanqIG/Q
 GZuXssMroRSwEXWtvx8wPmve9/yPpwjwzFyz/wedrHx6e6hM6nziN2p+iULmg0cBHVlfpWFRn
 F8tPzfOX41kVOJ+sDP2A1HVMtdAYd95J8rhM2/feFrnveza+EjEBYFhpLFAU1qstKoZ290Zcf
 GSF2JAidnenvZ2HYRP2f75DtSfReCyj0NhgjfbDmtnkJGGcxw4uwUPLOH9IjUFmCrK5MPtfdN
 aQiRg8D2DgGkEXp+Mobz4R9Vkp597/crjEcda7BNor+QO3z54WWhTwVVqzRVDnchFcHIgoPmu
 RwbMCWhFuNqVtbN8m+iq9iYbo5pL+Mif8jRaHNYyzKVwAyG3Ppk5vdTZHM05C7kcJlxKBIqap
 iksqg18hBI99sOg9uyjnV3dzlQd5Q4OGKoyOKJl56IhGlV5fPCTx2UFJkRJbKuhjyYmwjd8Zc
 oBAQHqn4ZSs/T4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> b0a2ba4776 ("diff --color-moved=3Dzebra: be stricter with color
> alternation", 2018-11-23) sought to avoid using the alternate colors
> unless there are two adjacent moved blocks of the same
> sign. Unfortunately it contains two bugs that prevented it from fixing
> the problem properly. Firstly `last_symbol` is reset at the start of
> each iteration of the loop losing the symbol of the last line and
> secondly when deciding whether to use the alternate color it should be
> checking if the current line is the same sign of the last line, not a
> different sign. The combination of the two errors means that we still
> use the alternate color when we should do but we also use it when we
> shouldn't. This is most noticable when using
> --color-moved-ws=3Dallow-indentation-change with hunks like
>
> -this line gets indented
> +    this line gets indented
>
> where the post image is colored with newMovedAlternate rather than
> newMoved. While this does not matter much, the next commit will change
> the coloring to be correct in this case, so lets fix the bug here to
> make it clear why the output is changing and add a regression test.

What an excellent commit message!

Thank you,
Dscho

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c                     |  4 +--
>  t/t4015-diff-whitespace.sh | 72 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 1e1b5127d15..53f0df75329 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1176,6 +1176,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  	struct moved_block *pmb =3D NULL; /* potentially moved blocks */
>  	int pmb_nr =3D 0, pmb_alloc =3D 0;
>  	int n, flipped_block =3D 0, block_length =3D 0;
> +	enum diff_symbol last_symbol =3D 0;
>
>
>  	for (n =3D 0; n < o->emitted_symbols->nr; n++) {
> @@ -1183,7 +1184,6 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  		struct moved_entry *key;
>  		struct moved_entry *match =3D NULL;
>  		struct emitted_diff_symbol *l =3D &o->emitted_symbols->buf[n];
> -		enum diff_symbol last_symbol =3D 0;
>
>  		switch (l->s) {
>  		case DIFF_SYMBOL_PLUS:
> @@ -1251,7 +1251,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>  							    &pmb, &pmb_alloc,
>  							    &pmb_nr);
>
> -			if (contiguous && pmb_nr && last_symbol !=3D l->s)
> +			if (contiguous && pmb_nr && last_symbol =3D=3D l->s)
>  				flipped_block =3D (flipped_block + 1) % 2;
>  			else
>  				flipped_block =3D 0;
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 308dc136596..4e0fd76c6c5 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1442,6 +1442,78 @@ test_expect_success 'detect permutations inside m=
oved code -- dimmed-zebra' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'zebra alternate color is only used when necessary'=
 '
> +	cat >old.txt <<-\EOF &&
> +	line 1A should be marked as oldMoved newMovedAlternate
> +	line 1B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	line 2A should be marked as oldMoved newMovedAlternate
> +	line 2B should be marked as oldMoved newMovedAlternate
> +	line 3A should be marked as oldMovedAlternate newMoved
> +	line 3B should be marked as oldMovedAlternate newMoved
> +	unchanged
> +	line 4A should be marked as oldMoved newMovedAlternate
> +	line 4B should be marked as oldMoved newMovedAlternate
> +	line 5A should be marked as oldMovedAlternate newMoved
> +	line 5B should be marked as oldMovedAlternate newMoved
> +	line 6A should be marked as oldMoved newMoved
> +	line 6B should be marked as oldMoved newMoved
> +	EOF
> +	cat >new.txt <<-\EOF &&
> +	  line 1A should be marked as oldMoved newMovedAlternate
> +	  line 1B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	  line 3A should be marked as oldMovedAlternate newMoved
> +	  line 3B should be marked as oldMovedAlternate newMoved
> +	  line 2A should be marked as oldMoved newMovedAlternate
> +	  line 2B should be marked as oldMoved newMovedAlternate
> +	unchanged
> +	  line 6A should be marked as oldMoved newMoved
> +	  line 6B should be marked as oldMoved newMoved
> +	    line 4A should be marked as oldMoved newMovedAlternate
> +	    line 4B should be marked as oldMoved newMovedAlternate
> +	  line 5A should be marked as oldMovedAlternate newMoved
> +	  line 5B should be marked as oldMovedAlternate newMoved
> +	EOF
> +	test_expect_code 1 git diff --no-index --color --color-moved=3Dzebra \
> +		 --color-moved-ws=3Dallow-indentation-change \
> +		 old.txt new.txt >output &&
> +	grep -v index output | test_decode_color >actual &&
> +	cat >expected <<-\EOF &&
> +	<BOLD>diff --git a/old.txt b/new.txt<RESET>
> +	<BOLD>--- a/old.txt<RESET>
> +	<BOLD>+++ b/new.txt<RESET>
> +	<CYAN>@@ -1,14 +1,14 @@<RESET>
> +	<BOLD;MAGENTA>-line 1A should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;MAGENTA>-line 1B should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1A should be marked as oldMoved n=
ewMovedAlternate<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 1B should be marked as oldMoved n=
ewMovedAlternate<RESET>
> +	 unchanged<RESET>
> +	<BOLD;MAGENTA>-line 2A should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;MAGENTA>-line 2B should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;BLUE>-line 3A should be marked as oldMovedAlternate newMoved<RES=
ET>
> +	<BOLD;BLUE>-line 3B should be marked as oldMovedAlternate newMoved<RES=
ET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3A should be marked as oldMovedAl=
ternate newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 3B should be marked as oldMovedAl=
ternate newMoved<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2A should be marked as oldMov=
ed newMovedAlternate<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>  line 2B should be marked as oldMov=
ed newMovedAlternate<RESET>
> +	 unchanged<RESET>
> +	<BOLD;MAGENTA>-line 4A should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;MAGENTA>-line 4B should be marked as oldMoved newMovedAlternate<=
RESET>
> +	<BOLD;BLUE>-line 5A should be marked as oldMovedAlternate newMoved<RES=
ET>
> +	<BOLD;BLUE>-line 5B should be marked as oldMovedAlternate newMoved<RES=
ET>
> +	<BOLD;MAGENTA>-line 6A should be marked as oldMoved newMoved<RESET>
> +	<BOLD;MAGENTA>-line 6B should be marked as oldMoved newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6A should be marked as oldMoved n=
ewMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 6B should be marked as oldMoved n=
ewMoved<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4A should be marked as oldM=
oved newMovedAlternate<RESET>
> +	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>    line 4B should be marked as oldM=
oved newMovedAlternate<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5A should be marked as oldMovedAl=
ternate newMoved<RESET>
> +	<BOLD;CYAN>+<RESET><BOLD;CYAN>  line 5B should be marked as oldMovedAl=
ternate newMoved<RESET>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'cmd option assumes configured colored-moved' '
>  	test_config color.diff.oldMoved "magenta" &&
>  	test_config color.diff.newMoved "cyan" &&
> --
> gitgitgadget
>
>
