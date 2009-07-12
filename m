From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 00:17:23 -0700
Message-ID: <4A598E03.10204@gmail.com>
References: <1247352793-25675-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 09:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPtKg-0001C9-S8
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 09:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbZGLHRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 03:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZGLHR3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 03:17:29 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:39332 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbZGLHR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 03:17:28 -0400
Received: by pxi15 with SMTP id 15so55103pxi.33
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=u9GgXZLVygogat3tOwKAeEub6XZqgJxera2fQa4OMXA=;
        b=rYsT7qTZGR4MD+6q5XjK25QJIjQfjAYaFkL/yDHcVJaWwM9V3zDWY9ZHuk9Dm/NJ4O
         r0c/ds1ADRcZwrnIsrg4ADzIEapUBai+MdHEXSUCm64eT1ElpgV35rH9trj+4sp2scn1
         koGGTch/rPkoBAQbGC3nrqz4nnJ37YIEOx74I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=MxKTvCWB44mt1XjfgZWyJEbt3DZdKnNhYpLfwzK1cAY40LKQGjre6Fs3Ndf0XJdOU6
         GxBF2Ai9F+jhIvATsyAZxqDigv1LidXcs6Q1bl8D/LAUmZQYmQbB3m0LmYYlXokkYmhY
         op8iwdXjQUsFty8xleU3R4PrWnj1qpvTh9oKs=
Received: by 10.114.130.15 with SMTP id c15mr6433128wad.59.1247383047856;
        Sun, 12 Jul 2009 00:17:27 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id n33sm5680897wag.56.2009.07.12.00.17.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 00:17:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1247352793-25675-1-git-send-email-michal.kiedrowicz@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123137>

Micha=C5=82 Kiedrowicz wrote:
> Also add missing --bare to init-db synopsis.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---

Heh, I had a very similar patch queued up.

>  Documentation/git-init-db.txt |    2 +-
>  builtin-init-db.c             |   51 ++++++++++++++++++++++++-------=
----------
>  2 files changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-d=
b.txt
> index 1fd0ff2..eba3cb4 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -8,7 +8,7 @@ git-init-db - Creates an empty git repository
> =20
>  SYNOPSIS
>  --------
> -'git init-db' [-q | --quiet] [--template=3D<template_directory>] [--=
shared[=3D<permissions>]]
> +'git init-db' [-q | --quiet] [--bare] [--template=3D<template_direct=
ory>] [--shared[=3D<permissions>]]
> =20
> =20
>  DESCRIPTION
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 4a56006..9b1ce45 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -6,6 +6,7 @@
>  #include "cache.h"
>  #include "builtin.h"
>  #include "exec_cmd.h"
> +#include "parse-options.h"
> =20
>  #ifndef DEFAULT_GIT_TEMPLATE_DIR
>  #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
> @@ -370,8 +371,16 @@ static int guess_repository_type(const char *git=
_dir)
>  	return 1;
>  }
> =20
> -static const char init_db_usage[] =3D
> -"git init [-q | --quiet] [--bare] [--template=3D<template-directory>=
] [--shared[=3D<permissions>]]";
> +static int shared_callback(const struct option *opt, const char *arg=
, int unset)
> +{
> +	*((int *) opt->value) =3D (arg) ? git_config_perm("arg", arg) : PER=
M_GROUP;
> +	return 0;
> +}

What occurs when "--no-shared" is used? I have this callback use an if,
else if, else to handle all possibilities.

> +
> +static const char *const init_db_usage[] =3D {
> +	"git init [-q | --quiet] [--bare] [--template=3D<template-directory=
>] [--shared[=3D<permissions>]]",
> +	NULL
> +};
> =20
>  /*
>   * If you want to, you can share the DB area with any number of bran=
ches.
> @@ -384,25 +393,25 @@ int cmd_init_db(int argc, const char **argv, co=
nst char *prefix)
>  	const char *git_dir;
>  	const char *template_dir =3D NULL;
>  	unsigned int flags =3D 0;
> -	int i;
> -
> -	for (i =3D 1; i < argc; i++, argv++) {
> -		const char *arg =3D argv[1];
> -		if (!prefixcmp(arg, "--template=3D"))
> -			template_dir =3D arg+11;
> -		else if (!strcmp(arg, "--bare")) {
> -			static char git_dir[PATH_MAX+1];
> -			is_bare_repository_cfg =3D 1;
> -			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
> -						sizeof(git_dir)), 0);
> -		} else if (!strcmp(arg, "--shared"))
> -			init_shared_repository =3D PERM_GROUP;
> -		else if (!prefixcmp(arg, "--shared=3D"))
> -			init_shared_repository =3D git_config_perm("arg", arg+9);
> -		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
> -			flags |=3D INIT_DB_QUIET;
> -		else
> -			usage(init_db_usage);
> +	const struct option init_db_options[] =3D {
> +		OPT_STRING(0, "template", &template_dir, "template-directory",
> +				"provide the directory from which templates will be used"),
> +		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
> +				"create a bare repository", 1),
> +		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
> +			"permissions",
> +			"specify that the git repository is to be shared amongst several =
users",
> +			PARSE_OPT_OPTARG, shared_callback, 0},

Or you can add PARSE_OPT_NONEG here and avoid the above comment.

> +		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
> +		OPT_END()
> +	};
> +
> +	parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0=
);
> +
> +	if(is_bare_repository_cfg =3D=3D 1) {
> +		static char git_dir[PATH_MAX+1];
> +		setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
> +					sizeof(git_dir)), 0);
>  	}
> =20
>  	if (init_shared_repository !=3D -1)
