Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9875C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4092064E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lZ1QyFH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgJGQ3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:29:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:59645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgJGQ3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602088186;
        bh=Dihopf0M9TvJkr7PUjtBG8JtaIpBY6EXppMGghOKPvw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lZ1QyFH+R7pxH+Mnb9UG4RNpf+T7fBk6/5Ntmudit34gGIboonaG6WkvigMCqYMbW
         39e0t0bB6obBBgdq/RS+6XHufiykNerUXRgQg3uYoVxTdXsy4z4d5eLh4/S4xNcc+B
         px7jrqGb4YeDC49PRo74bQfxpQhPel6rSGuI5iS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1kH5dT27Gr-009BQd; Wed, 07
 Oct 2020 18:29:46 +0200
Date:   Wed, 7 Oct 2020 18:29:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 5/7] subtree: add git subtree use and ignore
 commands
In-Reply-To: <2d103292cecfef3b29d221b3d8f05adb0add4475.1602021913.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010071812400.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <2d103292cecfef3b29d221b3d8f05adb0add4475.1602021913.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9V47QAoTL3VToK6LpUclNIqGTcsNNpIDQB6PCZB8ZSzkfg6zAOw
 80R6BNnsTmg3tzwleurY1YFrmM9MUhE2jVsoQjPl3THBOoGZbbGOQKZQKyX9USPbws2vHGG
 eYKTXJZnDuSIV2pGRYo8XtGiqBgGx+0ApA8VBurdSFsRDd1PmpswxK8iRYd1aF7C2ndMxA4
 VKH6Frnmx4i6mJy3aLXSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RrrkmYIjZYU=:czN8Yr7/MS4UcDjFc4ZYNV
 Sp1uvuXkwZ5upVRLTs/oZb5EcZ1nGJIkXziyBZDbceEWvyDtuVPKQJldTlmtLIfJYBrsEGXV3
 8deQMgq6hPs2h7Hsy929I9tEJGnnnQuOIQIjtPmDLST4DZUATWdzwZnWlcU+wVB4YQ2YAqP1r
 32LkZp0ZIKopW0HF21bZB2Y6kst7upcsAS9KJKfNLyBbw1JBOZ2AIwZtobYpcA2JsagDkVyCW
 s0LLzVmHwX2wgLYYuMvfeoC1g2T6cb0oSMjBPFa2Ssw1DRqtQbASUTeTZO6t3jGb/Fxjnh7XB
 pqL5Nf6Uwnt8P5ZcgaJQpHodDHCmUKrooFWD2wEUJB7djJ19r5aArL/UNi0D913KSlz2oXLPB
 FtHAKZBrlnB/nRpRcoPaTy4Oz2QbVChWtO7sNdu85zBIZow3wNqmz7akB6riz2xSSHnpMhkab
 crpM/UkFLmyxnJ44GKlxSN4Fng/47Q51Auxrab2GRpLu4WolRfra+GJCjAgdKn+Gcy0y/rhIq
 iEE0FifsRPdFkc6rWAjHDeBaqGndF5QnqoUxAYZGDNtvij+BwgPukj1H2VUTQg+2MkdC7qun7
 a439DCntWVJLqGxdrb2u0GOCu/26Tx/k3XcQXyr71kDoH0y4hTKG+/hsDMEqyT3BtQ7+ZAd5O
 6tVSf5fDr7D0Vw2QvXFKATTb2Qh4F+JbhjXW9SxlKjo8W8N4tm/+eaR+bFynO++PFsDLJR+B2
 fJ/ntWJTsCSl2Gc1cDlZzVFkgjYTQbbYVN2oKI7L8OxZWuLp0lV847GB3txPDyEcmuaUUJ8Dr
 bBJ742U+fuSnUB/M8jvqW0HmsnyMlDnQIBOjNKSeQI263JhfrCeBnDsY3nzn1tzgPsM6gVcxY
 mJPLBXso8+Bzr3xoGd10PsOcTQCl5Bs9p6rih4UD0Mv5nqzyzrjq6CLPYS2SG4KKUOtr1zqL0
 KpzgENTUBn5SXuzkt6mAv0Ww1mZOxG0rdnR2UyAdwqMopB+d3BFfVsO5w+tlBoRUiyNlATcHJ
 FYd0Vf6laqiNOdlxkGm2WW+J7rnx2FRIM4QjK/IrEmuPsq4R4opLRo5nUsRQ3bXpZ7LpL14m8
 vr9kUbE7wMqFF5wNtg3qgBVAUIULkGFlM8Z8ZCzWU/SUpe984DpKDsirabEIMscojCkQ8Wrg0
 dT3XiPpTKLIcF76C84DOX4juWyHqybVw7r6B0mW1RLKhLTgkXxjAJF7kqmumK7E4cz2eE5Eo5
 BLp/rjl3MXvfpqOW0d8baTAqaHXc1li/3Kxg+rA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> @@ -796,20 +810,60 @@ cmd_add_commit () {
>  }
>
>  cmd_map () {
> -	oldrev=3D"$1"
> -	newrev=3D"$2"
>
> -	if test -z "$oldrev"
> +	if test -z "$1"

I'd like to keep the nice name. Maybe if it is `local`, there is no longer
a need to replace `$oldrev` by `$1`?

>  	then
>  		die "You must provide a revision to map"
>  	fi
>
> +	oldrev=3D$(git rev-parse --revs-only "$1") || exit $?
> +	newrev=3D
> +
> +	if test -n "$2"
> +	then
> +		newrev=3D$(git rev-parse --revs-only "$2") || exit $?
> +	fi
> +

Would it not make more sense to validate the parameters before calling
`cmd_map`?

In any case, this strikes me like a subject for another commit.

Thanks,
Dscho

P.S.: I'll have to stop reviewing here for the moment, not sure whether
I'll come back to it later today or maybe tomorrow.


>  	cache_setup || exit $?
>  	cache_set "$oldrev" "$newrev"
>
>  	say "Mapped $oldrev =3D> $newrev"
>  }
>
> +cmd_ignore () {
> +	revs=3D$(git rev-parse $default --revs-only "$@") || exit $?
> +	ensure_single_rev $revs
> +
> +	say "Ignoring $revs"
> +
> +	cache_setup || exit $?
> +
> +	git rev-list $revs |
> +	while read rev
> +	do
> +		cache_set "$rev" ""
> +	done
> +
> +	echo "$revs" >>"$cachedir/processed"
> +}
> +
> +cmd_use () {
> +	revs=3D$(git rev-parse $default --revs-only "$@") || exit $?
> +	ensure_single_rev $revs
> +
> +	say "Using existing subtree $revs"
> +
> +	cache_setup || exit $?
> +
> +	git rev-list $revs |
> +	while read rev
> +	do
> +		cache_set "$rev" "$rev"
> +	done
> +
> +	echo "$revs" >>"$cachedir/processed"
> +}
> +
>  cmd_split () {
>  	debug "Splitting $dir..."
>  	cache_setup || exit $?
> @@ -827,7 +881,7 @@ cmd_split () {
>  		done
>  	fi
>
> -	unrevs=3D"$(find_existing_splits "$dir" "$revs")"
> +	unrevs=3D"$(find_existing_splits "$dir" "$revs") $(exclude_processed_r=
efs)"
>
>  	mainline=3D"$(find_mainline_ref "$dir" "$revs")"
>  	if test -n "$mainline"
> --
> gitgitgadget
>
>
