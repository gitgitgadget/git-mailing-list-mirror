Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E25E1F4B6
	for <e@80x24.org>; Tue, 16 Jul 2019 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfGPPBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 11:01:39 -0400
Received: from mout.web.de ([217.72.192.78]:39539 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfGPPBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 11:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563289291;
        bh=9lKCPCnGYW11lV9f/WZOUBv961s/hpGGTgwRuoL1huA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cxru9wrwBELVK0wkTYmcuVpGMfP/i9sAMRG5EP7gt4Xk+wog1ypSYMWcQWUlGNqc1
         RMLB8uVuiwvW1xgaY31pLMSum226jjXI9KHV7wVgLtVjQeax8xtm+jiF44b7Nr8LFl
         Ih4p4tC6SSfBo36a2kRIRt7DiXv4bB08FrXWU82g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSads-1huzex0CTk-00RXkw; Tue, 16
 Jul 2019 17:01:31 +0200
Subject: Re: [PATCH 1/1] clean: show an error message when the path is too
 long
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.219.git.gitgitgadget@gmail.com>
 <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a7fee3c7-8fd5-11ef-8b0d-ff8053987b0c@web.de>
Date:   Tue, 16 Jul 2019 17:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <36677556a26cca9eafd859c88aa9b2c5a6cde309.1563285862.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fk45LQN0qInO9UC/i33UkksIakwJmMMWqTO2m9vElYstXvvlPB5
 pFizSXmIhUmWO29kNbbTd9pcLjB3ZO5wzBbzucd/IZKwyLE4pQsWBMqIADPE5I4EwZN5Jtf
 rhy4G7mcq8kfEExMzFhkwmJcOCEhbB2u6t/7if2HVA+81k0Fe+mpLZkFp2j1BWAqQDM14vF
 pP6YMbmW5HyC8IE0N16PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKZN0cEvkdM=:/9ekJluPim1jTePN1Jt/rM
 TLeMJDcDbeEbLGO8aQRmW6/IUHBFs/zRNF5rLZ9xBJ2cfr8xd2IgwkDYBrJQ++pNKW5/h/391
 eZazpcCEW5N5Bc8f28dvOZxABSY3lTl3mu1/6Vn5Y/40S5vkG0cUeJg9pmT/joaO0ME4hIUD0
 G2qq0qQic4Eevf5werH6UoWfa8c4MF3hyb479X6AV1lRV5D2lPYXE17mxum+F8sEgrf95Sj4B
 88EH+sWVA7iUw9yzU7D/NNzwn6wLkji1bD9A5Qmy5osjnoCw3z0EnTaMIwdMLPO6iZSlimRea
 IG+hj2lmfZjG6Aza1FsF/aSESa9753fHk/NgYLSHfs8Gqq5/oiz6jxBZ4gpsUII1/x2RnOOA/
 JkW6OEyQyzwyL/wy61myZZc3xvQmI3P71Ju9fJt6HrjBHO6/LRh5MSS898zhJ2EjslFboEnkB
 uDnOoKc+jsPz1cLg/yuWFy9+iwLwJ1j2eqCbl7Ap+FNrZBYmYDItcqHB8dfl7OjOs4K+jO4Qs
 0kaCcaErtNYFu4aV29P0UNBNGMqcOTaPveCqXMzC2VDMW+ZoUT6ZSpuI4ZkhGbOU6fpqeq2FY
 gDzajeeNoRgyf+XpEmuYPNHra72E9awQleSxm6MtZaqne0jA+J8LL7AdWfpTtSBaiSNVX7EbF
 8JZsnfM1L4mySC7bx1zrjY0lXlP9ODq/ge2tadwuysmmeoMEXlw6/SrQhsbPROKg9s4j9JrB8
 FRAQbkS2ElRL3T6QWaby9RmgWoHCtTDNPZp9/bDW7RHC3MpNZdqXeqpIlsYKijLBgXJnrrbvH
 VhTOgEOWyHAhyJK3MSo0H8up86Q/EvT2LOp0jSBY+I/2xpRCMzMtVLzC8BqIFSji57H/mAksv
 qjAof+v/sQWKepi2vHI4K1fLOA9A6C8xyRCpTeAdS+9P81v0HaO3IC1EdzBznJGTqg/xxhbYB
 7Pfd54i5J7urbp8zL9nxVnF4TPVHUQnN6vDLmEnvKRYLnPXVU3XhpKNjG8ZBmC9ukyP9Gbjxl
 hjHBF2KhzRha0I2PB9DmzraxR/4wzUMaGzgA3wtrrnagcszC5rAyLVAzhvA+k7M26B+RcGR1L
 GbtAeYjz63HiK8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.19 um 16:04 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Without an error message when stat() failed, e.g. `git clean` would
> abort without an error message, leaving the user quite puzzled.
>
> In particular on Windows, where the default maximum path length is quite
> small (yet there are ways to circumvent that limit in many cases), it is
> very important that users be given an indication why their command
> failed because of too long paths when it did.
>
> This test case makes sure that a warning is issued that would have
> helped the user who reported this issue:
>
> 	https://github.com/git-for-windows/git/issues/521
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/clean.c  |  3 ++-
>  t/t7300-clean.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index aaba4af3c2..7be689f480 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -194,7 +194,8 @@ static int remove_dirs(struct strbuf *path, const ch=
ar *prefix, int force_flag,
>  		strbuf_setlen(path, len);
>  		strbuf_addstr(path, e->d_name);
>  		if (lstat(path->buf, &st))
> -			; /* fall thru */

I don't understand the "fall thru" comment here.  It only makes sense in
switch statements, doesn't it?  And the code after this if/else-if/else
block is only executed if we pass through here, so why was it placed way
down in the first place?  Perhaps for historical reasons.

dir.c::remove_dir_recurse() has such a comment as well, by the way.

Anyway, I'd keep that strange comment, as I don't see a connection to
your changes.  (Or explain in the commit message why we no longer "fall
thru", whatever that may mean.  Or perhaps I'm just thick.)

> +			warning("Could not stat path '%s': %s",
> +				path->buf, strerror(errno));

The other warnings in that function are issued using warning_errno()
(shorter code, consistency is enforced) and messages are marked for
translation.  That would be nice to have here as well, no?

>  		else if (S_ISDIR(st.st_mode)) {
>  			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
>  				ret =3D 1;
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 7b36954d63..aa08443f6a 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -669,4 +669,15 @@ test_expect_success 'git clean -d skips untracked d=
irs containing ignored files'
>  	test_path_is_missing foo/b/bb
>  '
>
> +test_expect_success MINGW 'handle clean & core.longpaths =3D false nice=
ly' '
> +	git config core.longpaths false &&
> +	test_when_finished git config --unset core.longpaths &&
> +	a50=3Daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
> +	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
> +	touch $a50$a50/test.txt &&
> +	touch $a50$a50/$a50$a50/$a50$a50/test.txt &&
> +	test_must_fail git clean -xdf 2>.git/err &&
> +	grep "too long" .git/err

The pattern "too long" is expected to be supplied by strerror(3), right?
Depending on the locale it might return an message in a different
language, so test_i18ngrep should be used here even if the warning above
is not translated, right?

> +'
> +
>  test_done
>

