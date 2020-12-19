Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DAC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA30723BA9
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLSAJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:09:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:57333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgLSAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608336493;
        bh=0frp106+N8+XcYzIsTkIhWQVPQKcIQnoknRvx2nDPIo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JN+etGP6kz5lw5dWgxabV6oJlGmZHVj2uqTQLZQjoZqqJIFIZUuacmOINcCacMAK1
         EL8A9Abw446GqrVnoufEMK/xacsgxZvqwVDK+OM9eyTUiIxMyQtKKh2/opv2E41rEl
         /yMSMdQRYJPGjSPXnxkxeppvIXz0qP7EoD+f2rf0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([89.1.213.150]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1kMtSD25NM-00lWKI; Sat, 19
 Dec 2020 01:08:13 +0100
Date:   Sat, 19 Dec 2020 01:08:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <periperidip@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 1/3] dir: change the scope of function
 'directory_exists_in_index()'
In-Reply-To: <20201214231939.644175-2-periperidip@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
References: <20201214231939.644175-1-periperidip@gmail.com> <20201214231939.644175-2-periperidip@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ktD2JAkdaBX2tzKPiNL+FPH10x85PUumIB2YWPcH6K5FJavpdCo
 llXJMZz4DIouoDmdFh5W6D5AyifDcCLiCEoZ1eMAydHJOOklc7CgudZQnIrcj8esb+0AlMl
 2yip50ayV2aG4PxJxc3QtmiNAY+bMZd5xvW91mFIrIRZyggVJrC0vb8Jr6UL+KnBQsd0Np/
 wiyGPLOBZ0M7iBviYe97g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o9IMgnCZ8Sw=:tFB37c/l/9zWgIMVh7OMvy
 Xga+dv1b9/KQWIcnH0l8QUkXnenrwJ4e7wauR7f/Fr2iAtBYiCOZsLieqM1Gom6q30rzGMNQ2
 F2H1vuEsXdWtFC8Bvj7KzdEIOwegaa8UaJbhPpPm02rmw1maRpFP6F20f7mB2fhi5tZaOh9/q
 C6in+EHPzIx64G7oiOm7h+xvxV7d3mRCbxRuRjEPKV1JnrobJX88lqaPv3tsHAQz2FE9Jhl9I
 F8+qKlcSJ32/X3BiyXzPZ+fNiN/rTS7fo6N6XfwPwwoxxV/0K4yG7pUbv46cOkvI4vLHs4KJ6
 PodfFHM1JTgmwwXGEm3AlLt+lBJ3g8UXghXh6FL740FxlHN7Y9OrjXFNB4zBiWz+wTdQsXw/R
 znWshJT6LN/VL1fb1Q5vQ5cK8h8djIoAqGToizPO/dqm4IRkSlKUZ4MHMXMEIsNyJW9KaOIWO
 tQEvBZ8AacOfbg4j63Z0PSN1ZpJl2ddx9p0i01y0mhaOFfGLOuemVR8iT+8Jbt6oB7zoMXr3w
 AbDvFBA97IwQTTWGT5iOsUVkEht6DhOfEx0/xWjvbsKZzkBTTtXcM++Ten527oRX5BmDiJwwH
 /FoHWBI27l6QBSeLosZoGIRrzLhnZclDk85ebxRJUZht627KPrTXxsb6lNcwytxaGYxYt0gbs
 diYLb2ZMmprFDKu8NV7vWa9lRxeLUpTrLgaVM+KagdtbHjC/OdDZTKH161g6aNrBEV1IAFAVY
 ps6L5WnO9NtYMB0PLGptvRlkCJKItsKjiyBCFl0Y+krtj192D8v2DWvGy8Hy493t9AL0V0RSH
 UC4aPK6C3fuuGOh/ZZqDnfX5n25sHbY/AnLIeGuunzI0Kg5e0QCZLmjrge/QDpWizQx66Kc7R
 zKwfA/AFnhyQyCdcrL1INKo1Gp2YkSNUMdgoVHIzE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Tue, 15 Dec 2020, Shourya Shukla wrote:

> Change the scope of the function 'directory_exists_in_index()' as well
> as declare it in 'dir.h'.
>
> Since the return type of the function is the enumerator 'exist_status',
> change its scope as well and declare it in 'dir.h'. While at it, rename
> the members of the aforementioned enum so as to avoid any naming clashes
> or confusions later on.

This makes it sound as if only existing code was adjusted, in a minimal
way, but no new code was introduced. But that's not true:

>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <periperidip@gmail.com>
> ---
>  builtin/submodule--helper.c | 408 ++++++++++++++++++++++++++++++++++++
>  dir.c                       |  30 ++-
>  dir.h                       |   9 +
>  3 files changed, 429 insertions(+), 18 deletions(-)

Tons of new code there. And unfortunately...

>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c30896c897..4dfad35d77 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2744,6 +2744,414 @@ static int module_set_branch(int argc, const cha=
r **argv, const char *prefix)
>  	return !!ret;
>  }
>
> +struct add_data {
> +	const char *prefix;
> +	const char *branch;
> +	const char *reference_path;
> +	const char *sm_path;
> +	const char *sm_name;
> +	const char *repo;
> +	const char *realrepo;
> +	int depth;
> +	unsigned int force: 1;
> +	unsigned int quiet: 1;
> +	unsigned int progress: 1;
> +	unsigned int dissociate: 1;
> +};
> +#define ADD_DATA_INIT { 0 }
> +
> +/*
> + * Guess the directory name from the repository URL by performing the
> + * operations below in the following order:
> + *
> + * - If the URL ends with '/', remove that.
> + *
> + * - If the result of the above ends with zero or more ':', followed
> + *  by zero or more '/', followed by ".git", drop the matching part.
> + *
> + * - If the result of the above has '/' or ':' in it, remove everything
> + *  before it and '/' or ':' itself.
> + */
> +static char *guess_dir_name(const char *repo)
> +{
> +	const char *start, *end;
> +
> +	start =3D repo;
> +	end =3D repo + strlen(repo);
> +
> +	/* remove the trailing '/' */
> +	if (repo < end - 1 && end[-1] =3D=3D '/')
> +		end--;
> +
> +	/* remove the trailing ':', '/' and '.git' */
> +	if (repo < end - 4 && !memcmp(".git", end - 4, 4)) {
> +		end -=3D 4;
> +		while (repo < end - 1 && end[-1] =3D=3D '/')
> +			end--;
> +		while (repo < end - 1 && end[-1] =3D=3D ':')
> +			end--;
> +	}
> +
> +	/* find the last ':' or '/' */
> +	for (start =3D end - 1; repo <=3D start; start--) {
> +		if (*start =3D=3D '/' || *start =3D=3D ':')
> +			break;
> +	}
> +	/* exclude '/' or ':' itself */
> +	start++;
> +
> +	return xmemdupz(start, end - start);
> +}
> +
> +static int can_create_submodule(unsigned int force, const char *path)
> +{
> +	int cache_pos, dir_in_cache =3D 0;
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	cache_pos =3D cache_name_pos(path, strlen(path));
> +	if(cache_pos < 0 &&
> +	   directory_exists_in_index(&the_index, path, strlen(path)) =3D=3D is=
_cache_directory)
> +		dir_in_cache =3D 1;
> +
> +	if (!force) {
> +		if (cache_pos >=3D 0 || dir_in_cache)
> +			die(_("'%s' already exists in the index"), path);
> +	} else {
> +		struct cache_entry *ce =3D NULL;
> +		if (cache_pos >=3D 0)
> +			ce =3D the_index.cache[cache_pos];
> +		if (dir_in_cache || (ce && !S_ISGITLINK(ce->ce_mode)))
> +			die(_("'%s' already exists in the index and is not a "
> +			      "submodule"), path);
> +	}
> +	return 0;
> +}
> +
> +static const char *parse_token(const char *cp, int *len)
> +{
> +	const char *p =3D cp, *start, *end;
> +	char *str;
> +
> +	start =3D p;
> +	while (*p !=3D ' ')
> +		p++;
> +	end =3D p;
> +	str =3D xstrndup(start, end - start);
> +
> +	while(*p =3D=3D ' ')
> +		p++;
> +
> +	return str;
> +}

This function is not careful enough to avoid buffer overruns. It even
triggers a segmentation fault in our test suite:
https://github.com/gitgitgadget/git/runs/1574891976?check_suite_focus=3Dtr=
ue#step:6:3152

I need this to make it pass (only tested locally so far, but I trust you
to take the baton from here):

=2D- snipsnap --
=46rom c28c0cd3ac21d546394335957fbaa350ab287c3f Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 19 Dec 2020 01:02:04 +0100
Subject: [PATCH] fixup??? dir: change the scope of function
 'directory_exists_in_index()'

This fixes the segmentation fault reported in the linux-musl job of our
CI builds. Valgrind has this to say about it:

=3D=3D32354=3D=3D
=3D=3D32354=3D=3D Process terminating with default action of signal 11 (SI=
GSEGV)
=3D=3D32354=3D=3D  Access not within mapped region at address 0x5C73000
=3D=3D32354=3D=3D    at 0x202F5A: parse_token (submodule--helper.c:2837)
=3D=3D32354=3D=3D    by 0x20319B: report_fetch_remotes (submodule--helper.=
c:2871)
=3D=3D32354=3D=3D    by 0x2033FD: add_submodule (submodule--helper.c:2898)
=3D=3D32354=3D=3D    by 0x204612: module_add (submodule--helper.c:3146)
=3D=3D32354=3D=3D    by 0x20478A: cmd_submodule__helper (submodule--helper=
.c:3202)
=3D=3D32354=3D=3D    by 0x12655E: run_builtin (git.c:458)
=3D=3D32354=3D=3D    by 0x1269B4: handle_builtin (git.c:712)
=3D=3D32354=3D=3D    by 0x126C79: run_argv (git.c:779)
=3D=3D32354=3D=3D    by 0x12715C: cmd_main (git.c:913)
=3D=3D32354=3D=3D    by 0x2149A2: main (common-main.c:52)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4f1d892b9a9..29a6f80b937 100644
=2D-- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2834,12 +2834,12 @@ static const char *parse_token(const char *cp, int=
 *len)
 	char *str;

 	start =3D p;
-	while (*p !=3D ' ')
+	while (*p && *p !=3D ' ')
 		p++;
 	end =3D p;
 	str =3D xstrndup(start, end - start);

-	while(*p =3D=3D ' ')
+	while(*p && *p =3D=3D ' ')
 		p++;

 	return str;
=2D-
2.29.2.windows.1.1.g3464b98ce68

