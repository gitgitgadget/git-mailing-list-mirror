Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26202C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 14:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380310AbiEEOFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbiEEOFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 10:05:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C556F9E
        for <git@vger.kernel.org>; Thu,  5 May 2022 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651759285;
        bh=1pI1cIDy4DPrxcUagfdDx41UfHG9kyllmi18Tu08LMM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SCxQ49slcP9erbppcdpeJAi9OnwmIuS/gYnDeIyiNTWFdsRP1t/v2JoeX3JEMAvJg
         LBSuEjwGMYbNp+1pftkrL9mGdzujh0o6PACe00K7rFJwatOAUNUF2pK/HCMOZCluWv
         iDOniy/VfWasp3k28Xt5rB/S6wzGDYBjkamoeodM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.146.35] ([213.196.213.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1nL3hA3JLo-00Y79g; Thu, 05
 May 2022 16:01:24 +0200
Date:   Thu, 5 May 2022 16:01:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
In-Reply-To: <20220503065442.95699-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com> <20220503065442.95699-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-782665642-1651759284=:355"
X-Provags-ID: V03:K1:ptbpFgf/MPNLfRPgclo3x+XcBP+UwlY0kjf4P0NtmO2nris3aeI
 klXLNAP4x84Lhw1GRpOB/aBDqUD7A9wpojb7EFM2fYxa7At72KSniDDOhdkkl7uWY4WuT9p
 mDi+SkoA9AFaCA2DhRjDPBOQ+1YkcX/LV3lgYyzjtU+gp5lljH/hMGdH+WZAElpUNsE/u1y
 G8yPX1JMI3E+Dfdz4G/Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6vum5JYiHEQ=:l1L7yapWGYXKwecXyPz5t0
 hpxChtmGz/qkaf6L3wptfPzQAY/qD9OM2YiQCRY5ryLUwJZpCHkJdbJTCAULFsNZ5WipCUf4O
 lCAyh3zTtV2LvJpUL+42ZOKATQpdA4bs6FWFrm6EugEhApOn9rKDXy6gLDMEzY3HzD//DGBt3
 b2jZyusEhlnJP/vDb/7muQOSxXJ4k66w1Hzn9xCXdNhZsBAYqXZNaNgC+3H/FNQYsA/I4sQTQ
 h0frudQgDwWZsKwFplYCf1jNyyrIxYDXztShH7j/fHy6PI4jeFbQHqZLAu/sPL7DA5cgFOYAo
 vgSspXxTC6x6NcpgFN0VMqZCIqG3s3K5DXVfI5xNktx6r60016ufL7QtyJJ0JrVWSPncVrrBl
 qsmOktB/TgefYmkfK3dez4egZyeR3PXs2h901v8EP3Q9IP9T1U5Qu38o5jSRt5tRBBH7/UciJ
 SmbslJHPCopfk0WWz0xbU76iJ6blTacs3iUsa1FPRmQNvzqglCEh93mEYpAk4rj1oxH/Xz9hj
 ypFOqT8PHS0/H0HWPpI6aJWZ++BXUE0MPiI0Zw3HuLmxdLwjrbLn+xNLmRVAb0uAMgSBwqEPr
 bS/IKZjg8PHJQmtSKIraGuXEtTj6iCKcwhi8ga7BQtviZDsOPgt0dnUiFG/uATrXCxXeMhOl7
 +ircvyqXoj0Q4B+DUyiyxazu1+XxsSqTo91Qke+dKVTt/gcAyLR8Ik6KnZd7YEAi7VUIGRvrn
 HIpcDtYIhMw5SpP+fMUAUNMcV3WNWeaCyPu4V0SlZRThxls5mNqRhoMiaHBT7HARDIbTt/p1y
 8zgctVMq6iUmLTeTTwQ6h+FA1oPCDTVP1UAzkYHFtvD1Zm99GNnjWm5x/bWqH/swKzgEnQ5Zm
 Qx1GldLF3HJF3cd+2EwTMtEH5EloNyirZAuFfViYQsF1sgdNOWdCdUS9tQ22/KEBgMXYyNAct
 r/3Y8uU0i2EMhme6ef14gQD5M17Mdg3OMsLlnEbCGw1WCxWA3vesnpPTriZzk9snN1oAxMYyI
 wBf9BvE3kNbQm2FNhJXhLf35iNdxGJIsm70Vy0iFbv7IXgVTHetCqEhMwSHKad5kgMc9GMwmd
 dan6DcmNKUB5dM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-782665642-1651759284=:355
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 2 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> bdc77d1d685 (Add a function to determine whether a path is owned by the
> current user, 2022-03-02) checks for the effective uid of the running
> process using geteuid() but didn't account for cases where that user was
> root (because git was invoked through sudo or a compatible tool) and the
> original uid that repository trusted for its config was no longer known,
> therefore failing the following otherwise safe call:
>
>   guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>   [sudo] password for guy:
>   fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by =
someone else)
>
> Attempt to detect those cases by using the environment variables that
> those tools create to keep track of the original user id, and do the
> ownership check using that instead.
>
> This assumes the environment the user is running on after going
> privileged can't be tampered with, and also adds code to restrict that
> the new behavior only applies if running as root, therefore keeping the
> most common case, which runs unprivileged, from changing, but because of
> that, it will miss cases where sudo (or an equivalent) was used to chang=
e
> to another unprivileged user or where the equivalent tool used to raise
> privileges didn't track the original id in a sudo compatible way.

Hmm. I do realize that this is a quite common scenario, and I wish we
would not need to rush for a fix here: Otherwise we could carefully design
an "untrusted" mode in which Git errors out on spawning user-specified
commands and on writing files (and avoids refreshing the index to avoid
having to write a file), but runs normally if none of that is needed.

> diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.t=
xt
> index 6d764fe0ccf..ee558ced8c7 100644
> --- a/Documentation/config/safe.txt
> +++ b/Documentation/config/safe.txt
> @@ -26,3 +26,12 @@ directory was listed in the `safe.directory` list. If=
 `safe.directory=3D*`
>  is set in system config and you want to re-enable this protection, then
>  initialize your list with an empty value before listing the repositorie=
s
>  that you deem safe.
> ++
> +When git tries to check for ownership of git repositories, it will
> +obviously do so with the uid of the user that is running git itself,
> +but if git is running as root, it will check first if it might have
> +been started through `sudo`, and if that is the case, will instead
> +use the uid of the user that did so.
> +If that is not what you would prefer and want git to only trust
> +repositories that are owned by root instead, then you should remove
> +the `SUDO_UID` variable from root's environment.
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 63ba89dd31d..dfdd3e4f81a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -393,12 +393,50 @@ static inline int git_offset_1st_component(const c=
har *path)
>  #endif
>
>  #ifndef is_path_owned_by_current_user
> +
> +#ifdef __TANDEM
> +#define ROOT_UID 65535
> +#else
> +#define ROOT_UID 0
> +#endif

I do wonder whether we have to play this kind of fragile game. Why not
simply respect `SUDO_UID` if it is set? It's not like we expect attackers
to have control over the environment and could set this malicously.

> +
> +/*
> + * this helper function overrides a ROOT_UID with the one provided by
> + * an environment variable, do not use unless the original user is
> + * root
> + */
> +static inline void extract_id_from_env(const char *env, uid_t *id)
> +{
> +	const char *real_uid =3D getenv(env);
> +
> +	/* discard any empty values */
> +	if (real_uid && *real_uid) {
> +		char *endptr;
> +		unsigned long env_id;
> +		int saved_errno =3D errno;
> +
> +		errno =3D 0;
> +		env_id =3D strtoul(real_uid, &endptr, 10);
> +		if (!errno && !*endptr && env_id <=3D (uid_t)-1)

We should not look at `errno` here unless the return value of `strtoul()`
indicates that there might have been an error (i.e. when it is
`ULONG_MAX`).

Likewise, we need to either initialize `endptr` or only look at it when
`strtoul()` succeeded.

We could side-step all of this, of course, if we simply did this:

	euid =3D getuid();
	if (euid =3D=3D ROOT_UID)
		euid =3D git_env_ulong("SUDO_UID", euid);

> +			*id =3D env_id;
> +
> +		errno =3D saved_errno;
> +	}

> +}
> +
>  static inline int is_path_owned_by_current_uid(const char *path)
>  {
>  	struct stat st;
> +	uid_t euid;
> +
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid =3D=3D geteuid();
> +
> +	euid =3D geteuid();
> +	if (euid =3D=3D ROOT_UID)
> +		extract_id_from_env("SUDO_UID", &euid);
> +
> +	return st.st_uid =3D=3D euid;

Since this code is not even compiled on Windows, I believe we need to
adjust the documentation accordingly ("On systems other than Windows,
where `sudo` is available, ...").

>  }
>
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-director=
y.sh
> index 6dac7a05cfd..dd659aed4e1 100755
> --- a/t/t0034-root-safe-directory.sh
> +++ b/t/t0034-root-safe-directory.sh
> @@ -32,7 +32,7 @@ test_expect_success SUDO 'setup' '
>  	)
>  '
>
> -test_expect_failure SUDO 'sudo git status as original owner' '
> +test_expect_success SUDO 'sudo git status as original owner' '
>  	(
>  		cd root/r &&
>  		git status &&
> --
> 2.36.0.352.g0cd7feaf86f

Again, thank you for working on this!
Dscho

--8323328-782665642-1651759284=:355--
