Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA8472774
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628333; cv=none; b=et3OmzmwuFaY6LvKnodWNG2gvhsBjPcZfWdmecmALi9YNAnTahJPqPeAQAUDJz6OHRvBIlq0zmrOwUiWIaFlvAgMbUjkz3EdZTI1poWihsm9U0S22cUZ91cXmm1MbRPePW9oXieBPTRKOzb+qg06l7ajSSbcLXe4ypMkvvbIr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628333; c=relaxed/simple;
	bh=xtiSIo+yP9Zdkpg7tnqiQwPUSQfO40SmOPPD2AEnC7c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=o23qJiL9pJnrOh6vwPbxVcqB211qzRZZOnqxinBacR/FLJ+JS9EM8yTG0xGhZ3+wZDUwcuxtEgeGqmiUpoK2WBIZsk/3g9CfC1spUVnORvSAvIIaPkClOlLO6WCjnASzjO/RmvioCo42upxUsQiEnUDE4Y6I5cLbwUquXubYm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0D3hl0Z; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0D3hl0Z"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b338d6so13318057b3.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790628330; x=1791233130; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQ3eaOVs+TPlY+SOp68dVYVU3u4KrTv6swCcIadxRHw=;
        b=Z0D3hl0Z4I6dUPV1B3+E/dsBsItygN0vmTGtsfliT6tlXSwSZW2ndGjo723kGwF/Dg
         wnQyrXhI9p3vvulXHJ5nIe7yLeXKUR78/GE1PJbIc6LEW7Ngy/ElVgwQ74t8GHF/ZA7B
         5R/+05By1g6gCjycQzwSROdgUo8PEPj4sJQmCzTH12DLWovIzQSkFln/DucuQClaBC2y
         WBC1TaVWMA2o3oIwBk8C9MAQfUPmlaRWgnf6pQpWcPM3HtZGT1N12FXX/r+JH/Rarw52
         Wp66BICQE080kto2HdcYfueZffndm/VO7WOG0cIDu9fdr1YwFgFdmCXTvGm4rQ9jKNFJ
         uBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790628330; x=1791233130;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQ3eaOVs+TPlY+SOp68dVYVU3u4KrTv6swCcIadxRHw=;
        b=PPY1ke10papdkJOHTKfm3f+8RDkZQnMN2bJBJe5XxE8KQx7BCCFX7PFjgTMagOhl9k
         Sn1NOtsmMdkqB2niVUcNXpZgn9W4QI/Hl/GRnwe6BRrVCvzVZpPKjgBlg7YIQe1S2rxU
         stNUxSQcL7WyIN0KKgbW7HoShOefuGQHvtfXa67f1Mnhj+VgfYWQ0N/Y5PRi2FO8CkYY
         yoX5KqIs57UeyYqtULeqAxmdvE0jD/jIF4g47NTXX6Z13tC/TIhgqerr+OPijxk0WY5H
         hGW00AxuPtoCZvEQmV6XLOJ81B7kCKMNSJqS6DfKDnBdmAglwBLRWnoLTuLIuBqXF1j9
         dE/Q==
X-Gm-Message-State: AFq9FYJRF9Idjk6BFMrI4lw/rh8a7pHsvT43srAHLUKrOdDpumMlBrrG
	HQ5EAS6vc/eTf9MMf8jp6vuTOShgYhnXcm8Vuawlv0aAF9GfS1ta9ldZkzg5p13k
X-Gm-Gg: AYBFou3auPShSsSRDLLjTr/GEogSNlE87P5+trmvOWoscDBfuIiHizcCvgjLlBy3O1n
	4oNPgRjHSaTahx3uYoj3IwRrKTpn0NYN5vrVogb1ylepuXYzTvc/gVo+m9rZfLH2DDeyA12b4aB
	eIz6gV60sBryt63b2MyymaoyX6nGcmyjAtLAMMje7q4k3K5MK4KOpMCNIPxNwcDE816mldSYXVF
	McXFmRHt1QbqF/e4rgI1rgc/BC9u5TetcT1KTd8V3qvNueuaLFyNspVDV+NapVqcx8Q0Vcle0FB
	cu2XVg+4dXdVkq5sb1hNdNbtB4p/XlN7E9/fFgiVPiNRaQuwRDi2piQAnpeIkiDmSO+WHd+Xcs/
	Fos/a6+sTNEGpZWQzXvA2Fga4lzBp4nr3LOqpQkM1720N9xDdQdYPRyeJ4ORo8bwKHexfNmKgwo
	a5K4Jd73a97PlkiBuWhX1pAU1RZd46s5jnpWYOkbxXxmcbfgvoSniIpUE104Q2bVQQih8DHjfja
	OUpZWONe38LjWLaGpsP5Wbok16qkKTbe7yGipUJ1b3/JpGh7fdi/GN/K1NuiYxmqhmXXJc0Rirx
	QFoDM3nb6IZSZWjFiBWLqpqGhZRzHeG90flFQBhx30QRXUpQ
X-Received: by 2002:a05:690c:e158:b0:8ab:3191:52dc with SMTP id 00721157ae682-8ab319153c1mr11198647b3.5.1790628330391;
        Mon, 28 Sep 2026 13:45:30 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:bd64:154c:955c:5465])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ab3ad11ca3sm5263797b3.26.2026.09.28.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:45:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
Date: Mon, 28 Sep 2026 16:45:19 -0400
Message-Id: <89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Thomas Bachem <mail@thomasbachem.com>
In-Reply-To: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 28 sept. 2026 =C3=A0 10:38, Thomas Bachem via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Thomas Bachem <mail@thomasbachem.com>
>=20
> The "--rebase -f with rebased upstream" test computes its fork point
> from the reflog of refs/remotes/me/copy, and the entry it needs is
> the one that the fetch of the test before it wrote. Like every reflog
> entry the suite writes after test_tick, it is dated 2005, so the
> first "git reflog expire --all" after that fetch removes it. Pull
> then finds no fork point and rebases onto the merge head with the
> merge head as the upstream, and the rewound commits come back as a
> conflict.
>=20
> Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
> default, 2026-02-24) auto maintenance runs that expiry once the reflog
> of HEAD holds a hundred entries it would remove, the default of
> maintenance.reflog-expire.auto. Which run crosses the threshold
> depends on the entries and maintenance runs before it, so the script
> passed by chance: a stash topic that no longer runs "git reset" from
> "stash apply --index" and a rebase topic that runs auto maintenance
> at the end of "git rebase" together move the expiry between the two
> tests.
>=20
> Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
> matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
> as well, which expires reflogs on its own, where turning off the auto
> trigger of the reflog-expire task alone would not.
>=20
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>    t5520: don't expire reflogs where it matters
>=20
>    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
>    bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
>    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.=
com/

Junio, if it=E2=80=99s simpler for you this way: I=E2=80=99ll just pick this=
 patch into my series rather than wait for it to appear in seen and recreate=
 my topic on master + it.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Ft=
homasbachem%2Ft5520-reflog-expire-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomas=
bachem/t5520-reflog-expire-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2243
>=20
> t/t5520-pull.sh | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 27f38ab3c8..bc818605a5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -35,6 +35,12 @@ test_pull_autostash_fail () {
> }
>=20
> test_expect_success setup '
> +    # Commit dates are hardcoded to 2005, and the reflog entries will hav=
e
> +    # a matching timestamp. Maintenance may thus immediately expire
> +    # reflogs if it was running.
> +    git config set gc.reflogExpire never &&
> +    git config set gc.reflogExpireUnreachable never &&
> +
>    echo file >file &&
>    git add file &&
>    git commit -a -m original
>=20
> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
> --
> gitgitgadget
