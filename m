Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B591C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiFOOFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356622AbiFOODZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 10:03:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4414D05
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655301774;
        bh=RktB7X1+scvX7NtB9BHBgW1P+Ti2CODOKMsKYIYlyIg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T16xmyaJC+oEUU7+9kf7uGUxd2nuMwfvFsNu798kkUITbAIHgipborkcZAHC6qsg8
         NTrqeTZ1qcOdoOq72DPBpo2Xy7HtN/0MI741JsaejMwai2ZM/8oVNfg5DCbfEmqPVY
         RUJrPm25TjzKrt4ZcB6Hu1TaL6nvN0X6QfMIlqyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1nVjgv1kSd-00hvkK; Wed, 15
 Jun 2022 16:02:54 +0200
Date:   Wed, 15 Jun 2022 16:02:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com
Subject: Re: [PATCH v5 4/4] git-compat-util: allow root to access both SUDO_UID
 and root owned
In-Reply-To: <20220513010020.55361-5-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206151557510.349@tvgsbejvaqbjf.bet>
References: <20220510174616.18629-1-carenas@gmail.com> <20220513010020.55361-1-carenas@gmail.com> <20220513010020.55361-5-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-14294196-1655301774=:349"
X-Provags-ID: V03:K1:ZPSWtGlWRH9HekL4VNXDxVYtHoelkwTR/xsSk7TThbWWdBeZbcf
 cAPhBXPpIzTPo/jyRAvwBMRrIjfODd2+aOgtrnzQoQoSzTKWt4Gve2zitPKEHWC/DKF95vA
 z0FdtqjoAyw9CwhyXd6XsN5XOkfQ7ERYo3RsVi6ecvwifKeBuSQIrH2xLwCFimsS7iWRPqB
 nwSYyy2t+3pDY4ws4G7xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bd1eHUarpQ0=:LXK2W8aYiU26sqm7sEM2eG
 44Ji3nwxgQhIdnbPE+1nqhrxdBh2aHF4x92arbF2vFHteuXTW1jk9uc2Qs70LdOT9YN+GgkZQ
 AYK9GiDvW3rBkBZihwR75pskcpIFMFM7Uv0S3g/jqfOEouOKynRkfDmiCp45dHYl5MvG35LQm
 1VaRQRXXVsL8oa5BcYRPnkEdWZ8auajXjNO0/lLMI+ws0uohbrNxDrfrMQ/ZdNn9ENMGA2i0h
 Wbn7yL8pIFxL+7Sfrj0DxlzRjfCoAT7KaHuh3qHO9Tlzx1QQrvUp7cTAN47c9NcXv9gxriYH9
 rZMlYPbtd3ABHfeyzTgHyAX1sRKsnuRGZyRuhXbfFlBRisbKEaBvmFXkzBauH4DTdlwhSHqK0
 xmr9qP5nFUUrvYn8/7w17697xobEqOThtr0hDTIG3IzWeGMp1RGwpod5GpX+384rQ1WXm6R4V
 owIIkTzhvix93J9dGQmX7TfdRaxnHBWXJI6wVX7wluWIwOOcPZJgTitBioMH4nl9oHdIy2fuF
 nkL5yGGvNtOGuK0dBKA4I/L8UP/orst1GHa+4nYRw57lP0wGbTfOdGqbnc4LoxcPWLvoZ1UGV
 OHsFqE5PZwR2Pp05hcP4ArPQsX+x4hCmbqqq3AyX9XzuCaTpwiMqmBwcofTlw50QBg2ytmlfu
 mdVaNwotBQuchLeqHlz1tncGu7o+kUJaDb9lLsoEGoGnXmYIR8mg9RvplVznCp53H2BMhxUS4
 wvl2zPiMJfUOag6VibK7s/oLm90zeI6+cpsIKFCUKYechTrsbo8Xw+mKhNUW/jCrQ5qtLQzc7
 cegYKm2vrpVcFSyZDM12faOwb+3bTiR1+tjVdiDtSBLGE7dv03qNrb6GcaqTJDaqKPilBpC9I
 MV1AlZXRwPeOsQlSzikV7M14naFABu2q0h+71cNxRicvdDbn0gnyCTda/ImwRyPO1vI47ORze
 fJXBQksPMLwN2PKCvTjhfjj7tZIkEIMrUghIu0ylUiM5PpOqBlSyri7NknBV7BmK6spa5rFSg
 foRuR1KtIV/EYng26sQDCEEgBhwfOW2g1Gm5/Ga+o/uTc7yc3L/kp0V+azsEHJRHV6UufWdrW
 dMu7EeDYkQ59Kr69CKvsSl71VnRdLjshf9rMFjxqsa4u9h0tDL0H0cT0w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-14294196-1655301774=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 12 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index e7cbfa65c9a..0a5a4ee7a9a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -420,9 +420,10 @@ static inline int git_offset_1st_component(const ch=
ar *path)
>   * maybe provide you with a patch that would prevent this issue again
>   * in the future.
>   */
> -static inline void extract_id_from_env(const char *env, uid_t *id)
> +static inline int id_from_env_matches(const char *env, uid_t id)

I agree somewhat with Gab=C3=B3r's concern that this patch tries to do too=
 many
things at once, including this rename.

We have a recent history of introducing so many regressions that `.1`
releases have become the norm rather than the exception, and from where I
sit, the reason is squarely with the uptick in refactoring (including
renames like this one).

So unless the refactoring is done to any other end than for refactoring's
own sake (which is really not a good reason), I see it as problematic.

>  {
>  	const char *real_uid =3D getenv(env);
> +	int matches =3D 0;
>
>  	/* discard anything empty to avoid a more complex check below */
>  	if (real_uid && *real_uid) {
> @@ -432,9 +433,10 @@ static inline void extract_id_from_env(const char *=
env, uid_t *id)
>  		errno =3D 0;
>  		/* silent overflow errors could trigger a bug here */
>  		env_id =3D strtoul(real_uid, &endptr, 10);
> -		if (!*endptr && !errno)
> -			*id =3D env_id;
> +		if (!*endptr && !errno && (uid_t)env_id =3D=3D id)
> +			matches =3D 1;
>  	}
> +	return matches;
>  }
>
>  static inline int is_path_owned_by_current_uid(const char *path)
> @@ -446,10 +448,13 @@ static inline int is_path_owned_by_current_uid(con=
st char *path)
>  		return 0;
>
>  	euid =3D geteuid();
> +	if (st.st_uid =3D=3D euid)
> +		return 1;
> +
>  	if (euid =3D=3D ROOT_UID)
> -		extract_id_from_env("SUDO_UID", &euid);
> +		return id_from_env_matches("SUDO_UID", st.st_uid);

A much shorter, much more obvious patch would look like this:

-	if (euid =3D=3D ROOT_UID)
+	if (st.st_uid !=3D euid && euid =3D=3D ROOT_UID && )
 		extract_id_from_env("SUDO_UID", &euid);

It accomplishes the same goal, but is eminently easier to review. For
regression fixes, I much prefer the safety and confidence that comes with
that.

Ciao,
Dscho

--8323328-14294196-1655301774=:349--
