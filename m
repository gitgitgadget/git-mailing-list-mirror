Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742651F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbfJ1K5i (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 06:57:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:58781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfJ1K5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 06:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572260247;
        bh=nDDRaGWvShGM4HeBgletuefJl0JgdaqulEEGgnUu22I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XGBYqWQWLKshSjXPuYoGsSvXvBit++H55a3cFbsTMXbMA2Nu2AmvC7s7Pwqcy3imY
         CGMDsL4YdZhy+9U8HzbFhi97OTxFByF6pVWJgPhPcZJM/naQkMATDXaCXNsfuVeugd
         u9ADVREoFEpE1aLy759JY80MLu5iQbEmuVPiRaf4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1hobxr1Qbk-00aXYy; Mon, 28
 Oct 2019 11:57:27 +0100
Date:   Mon, 28 Oct 2019 11:57:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
In-Reply-To: <20191021160043.701-6-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910281155220.46@tvgsbejvaqbjf.bet>
References: <20191021160043.701-1-szeder.dev@gmail.com> <20191021160043.701-6-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1182291941-1572260247=:46"
X-Provags-ID: V03:K1:2pO2VugeG3Xv/wByWZXS4Gk0pJYODrOfmrwqpCRX1/zdAJknm3l
 LaPT4Wx08JRWVwpWVHoZCSpflsl8Qz8SvEpky2jaV4G409bQyMHvequMXx7D9HUuEApoP5S
 B6IcnZ10cdGJ7b9dCfGaDpwBEFcWrRdth6fzvZUf4MuQvi3LNDDa7yU1pkewGaebEIUtaXh
 e451G/iWdNFufJsRjFlqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kNsmpqLQTcs=:hUC+BtBERk+nYBtdG92u+Y
 wFkjikIIjksMaZG09S0qmX+klbuV3G5xY4Hps4RbcLfs9S/DtULTIPJhLmRy324ajq4G4nGTo
 TKehRNRwyUYrT/jS4Px4utvhFSWad3Org+wlbgvUsNKeelilOiMxRO3d6YXCuhSzaF2DF3sV+
 aQg7N0cItpAZ1gSbNXk50pfdOz8TOkddGXUn9uYg46un3A9j+gCxIsjpp2yoreB+YXJlq/W03
 0Eh2QqtKKQcLEnxJNqOECFzLfxW7JVaMgemj9QechjUYbhrvWy80C4olGOa6YqA7Jy/9SAIRf
 Rx8ILNPf8NMJHSOnUEbEdSPjxJD/RAQkhNJpWFL7ttyMG4Cv78NRtLXwxATGAsza77HYt+WTh
 p9xzHXdSJJVoKv6SM6gST02nr/MtBz7uYXPM1iUMl+b4117811ZiiB0a0cZO2Zwz9QKcF2Ak2
 uQExSZ4hOjzlxVuNdFf8OTWZhsS8tZ6kK5xCn7BZwPDRMc83gxMXUI37S+Shwun8bR/pP/XVx
 7XWJFZuyogoYznkZ3Lk2CTWcdMSkzU1OEQtKzu40EEJZi073iKPpAbL+Bt+ahfk0HTE/rZ4fw
 rtay9LXIpmFMLY/+5AEqRqk8nQvaaBXsd6HYty2qTfZkLX1N52Uup44gsjjg14yMXroowTBuF
 y3KFoErjXKWyOCTFIU8pK4CeEOzphjah2eKsyBmNHIcWcOF0nW/KMZgvPdWe5RLlcDfCRu8W+
 GutuUubtCfybJEKvTiOpo8zdjQUTszRbDcAv+CilBW/gsq51yHuDBtSa8vR0tqZLOv3NZeXez
 Zronqb3RLns1xZFu7JcFNW3yZ56S2tIFkMgKxuGxkXpDHjQZrDZvMbZgIpPSI75c8OLmdA8wx
 vZcxMaduPLvpsXEofABFnv4D5yM99mvE7Iunl/IAXNwdXdTaMc/5mVqzdqq5vWttH/YUbhOrM
 IyDmxNISLRhZCh3y8DpSSF8v4lg2eRoQ0TWLPJLJ9BoclIDzy0pvkglAbwJXB1xcSkjpQoLPX
 vbKdAYOLMmNRm5HTZ4yDsqFRY2kSh8OAN+TbQlpSOE1o7AS7FbWkJz/H+hHvo+WgYRHfw1yGG
 E9O1SUGiJIjVWrODtnTBcI1xpLwHcm9upRlGizwyMx1YloSfQpiiPgwXOYZgTM1ecQype67+F
 r0F7DnrWAkKRSCPj4p503AXmpvCXffyrhBszQXaXeWwam2L0LeHogmXrrDAisaRDa2OzUp+PL
 9JnlwAcJPpl64O8bK40T2GOl3byvTPfowNESbwuodyB2oeVEB78bmdzLyD3g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1182291941-1572260247=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 21 Oct 2019, SZEDER G=C3=A1bor wrote:

> 'logs/refs' is not a working tree-specific path, but since commit
> b9317d55a3 (Make sure refs/rewritten/ is per-worktree, 2019-03-07)
> 'git rev-parse --git-path' has been returning a bogus path if a
> trailing '/' is present:
>
>   $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
>   /home/szeder/src/git/.git/logs/refs
>   /home/szeder/src/git/.git/worktrees/WT/logs/refs/
>
> We use a trie data structure to efficiently decide whether a path
> belongs to the common dir or is working tree-specific.  As it happens
> b9317d55a3 triggered a bug that is as old as the trie implementation
> itself, added in 4e09cf2acf (path: optimize common dir checking,
> 2015-08-31).
>
>   - According to the comment describing trie_find(), it should only
>     call the given match function 'fn' for a "/-or-\0-terminated
>     prefix of the key for which the trie contains a value".  This is
>     not true: there are three places where trie_find() calls the match
>     function, but one of them is missing the check for value's
>     existence.
>
>   - b9317d55a3 added two new keys to the trie: 'logs/refs/rewritten'
>     and 'logs/refs/worktree', next to the already existing
>     'logs/refs/bisect'.  This resulted in a trie node with the path
>     'logs/refs', which didn't exist before, and which doesn't have a
>     value attached.  A query for 'logs/refs/' finds this node and then
>     hits that one callsite of the match function which doesn't check
>     for the value's existence, and thus invokes the match function
>     with NULL as value.
>
>   - When the match function check_common() is invoked with a NULL
>     value, it returns 0, which indicates that the queried path doesn't
>     belong to the common directory, ultimately resulting the bogus
>     path shown above.
>
> Add the missing condition to trie_find() so it will never invoke the
> match function with a non-existing value.  check_common() will then no
> longer have to check that it got a non-NULL value, so remove that
> condition.
>
> I believe that there are no other paths that could cause similar bogus
> output.  AFAICT the only other key resulting in the match function
> being called with a NULL value is 'co' (because of the keys 'common'
> and 'config').  However, as they are not in a directory that belongs
> to the common directory the resulting working tree-specific path is
> expected.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Thank you for this entire patch series. Just one nit:


> diff --git a/path.c b/path.c
> index cf57bd52dd..e21b00c4d4 100644
> --- a/path.c
> +++ b/path.c
> @@ -299,9 +299,13 @@ static int trie_find(struct trie *root, const char =
*key, match_fn fn,
>
>  	/* Matched the entire compressed section */
>  	key +=3D i;
> -	if (!*key)
> +	if (!*key) {
>  		/* End of key */
> -		return fn(key, root->value, baton);
> +		if (root->value)
> +			return fn(key, root->value, baton);
> +		else
> +			return -1;

I would have preferred this:

+		if (!root->value)
+			return -1;
+		return fn(key, root->value, baton);

... as it would more accurately reflect my mental model of an "early
out".

But as I said, this is just a nit-pick.

Thank you for working on this!
Dscho

> +	}
>
>  	/* Partial path normalization: skip consecutive slashes */
>  	while (key[0] =3D=3D '/' && key[1] =3D=3D '/')
> @@ -345,9 +349,6 @@ static int check_common(const char *unmatched, void =
*value, void *baton)
>  {
>  	struct common_dir *dir =3D value;
>
> -	if (!dir)
> -		return 0;
> -
>  	if (dir->is_dir && (unmatched[0] =3D=3D 0 || unmatched[0] =3D=3D '/'))
>  		return dir->is_common;
>
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index c7b53e494b..501e1a288d 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -288,6 +288,8 @@ test_git_path GIT_COMMON_DIR=3Dbar index            =
        .git/index
>  test_git_path GIT_COMMON_DIR=3Dbar HEAD                     .git/HEAD
>  test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD                .git/logs/H=
EAD
>  test_git_path GIT_COMMON_DIR=3Dbar logs/refs/bisect/foo     .git/logs/r=
efs/bisect/foo
> +test_git_path GIT_COMMON_DIR=3Dbar logs/refs                bar/logs/re=
fs
> +test_git_path GIT_COMMON_DIR=3Dbar logs/refs/               bar/logs/re=
fs/
>  test_git_path GIT_COMMON_DIR=3Dbar logs/refs/bisec/foo      bar/logs/re=
fs/bisec/foo
>  test_git_path GIT_COMMON_DIR=3Dbar logs/refs/bisec          bar/logs/re=
fs/bisec
>  test_git_path GIT_COMMON_DIR=3Dbar logs/refs/bisectfoo      bar/logs/re=
fs/bisectfoo
> --
> 2.24.0.rc0.472.ga6f06c86b4
>
>

--8323328-1182291941-1572260247=:46--
