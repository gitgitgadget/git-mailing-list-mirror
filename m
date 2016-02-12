From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 15/21] init: allow alternate ref strorage to be set for
 new repos
Date: Fri, 12 Feb 2016 16:26:41 +0100
Message-ID: <56BDF9B1.5050302@alum.mit.edu>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
 <1454701462-3817-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:34:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUFjn-0000ok-30
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 16:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcBLPds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 10:33:48 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44985 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963AbcBLPdq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 10:33:46 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2016 10:33:46 EST
X-AuditID: 12074414-89fff70000005020-59-56bdf9b307a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2F.B3.20512.3B9FDB65; Fri, 12 Feb 2016 10:26:43 -0500 (EST)
Received: from [192.168.69.130] (p548D685F.dip0.t-ipconnect.de [84.141.104.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1CFQfSn019502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Feb 2016 10:26:43 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1454701462-3817-16-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqLvl594wgwP7WSzmbzrBaNF1pZvJ
	YndrlgOzx7tTDaweC57fZ/f4vEkugDmK2yYpsaQsODM9T98ugTvj8JM7bAWftSom3lnB3MB4
	S6GLkZNDQsBE4vPVTSxdjFwcQgJbGSVWPVgB5Zxnkmg60cDcxcjBISwQJfF9Hj9Ig4iAg8Tl
	XUeZIWraGCUe/LzFCJJgFjCVmLVmLwuIzSagK7Gop5kJYoOcRG/3JLA4r4C2xOMjC8DqWQRU
	Jf63/WQDsUUFQiTef33OClEjKHFy5hOwek4BT4mORV+g5qtL/Jl3iRnClpdo3jqbeQKjwCwk
	LbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRkjwiuxgPHJS
	7hCjAAejEg+vwa09YUKsiWXFlbmHGCU5mJREeRuf7Q0T4kvKT6nMSCzOiC8qzUktPsQowcGs
	JMJr0ASU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4D32A6hRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDt3QTSzltckJgLFIVoPcWo
	KCXOmw2SEABJZJTmwY2FpaRXjOJAXwrzigETlBAPMJ3Bdb8CGswENHjH910gg0sSEVJSDYyC
	r5TSwv7kqs4VZ/v74gXvDN2g7w7HNsrsmOO/2CzqpsvXPn8tYanTPBfep1S/F+XOSkrV2MBr
	/E4k12pa1qlihwjmO8ohn354z/R5FnakWrrCYtetOwsYwmM2Fex0iKp+US4WzOWY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286053>

On 02/05/2016 08:44 PM, David Turner wrote:
> git init learns a new argument --ref-storage.  Presently, only
> "files" is supported, but later we will add other storage backends.
>=20
> When this argument is used, the repository's extensions.refStorage
> configuration value is set (as well as core.repositoryformatversion),
> and the ref storage backend's initdb function is used to set up the
> ref database.
>=20
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  Documentation/git-init-db.txt          |  2 +-
>  Documentation/git-init.txt             |  7 +++++-
>  builtin/init-db.c                      | 44 ++++++++++++++++++++++++=
+++-------
>  cache.h                                |  2 ++
>  contrib/completion/git-completion.bash |  3 ++-
>  path.c                                 | 29 ++++++++++++++++++++--
>  refs.c                                 |  8 +++++++
>  refs.h                                 |  8 +++++++
>  setup.c                                | 12 ++++++++++
>  t/t0001-init.sh                        | 25 +++++++++++++++++++
>  10 files changed, 127 insertions(+), 13 deletions(-)
>=20
> [...]
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..d2b150f 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git init' [-q | --quiet] [--bare] [--template=3D<template_directory=
>]
>  	  [--separate-git-dir <git dir>]
>  	  [--shared[=3D<permissions>]] [directory]
> -
> +	  [--ref-storage=3D<name>]
> =20
>  DESCRIPTION
>  -----------
> @@ -113,6 +113,11 @@ does not exist, it will be created.
> =20
>  --
> =20
> +--ref-storage=3D<name>::
> +Type of refs storage backend. Default is to use the original "files"
> +storage, which stores ref data in files in .git/refs and
> +.git/packed-refs.
> +

Technically, that should be $GIT_DIR/refs and $GIT_DIR/packed-refs. But
it might be that we are not so picky about the distinction in the user =
docs.

>  TEMPLATE DIRECTORY
>  ------------------
> =20
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 801e977..d331ce8 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -24,6 +24,7 @@ static int init_is_bare_repository =3D 0;
>  static int init_shared_repository =3D -1;
>  static const char *init_db_template_dir;
>  static const char *git_link;
> +static char *requested_ref_storage_backend;
> =20
>  static void copy_templates_1(struct strbuf *path, struct strbuf *tem=
plate,
>  			     DIR *dir)
> @@ -179,6 +180,7 @@ static int create_default_files(const char *templ=
ate_path)
>  	int reinit;
>  	int filemode;
>  	struct strbuf err =3D STRBUF_INIT;
> +	int repo_version =3D 0;
> =20
>  	/* Just look for `init.templatedir` */
>  	git_config(git_init_db_config, NULL);
> @@ -205,6 +207,32 @@ static int create_default_files(const char *temp=
late_path)
>  	}
> =20
>  	/*
> +	 * Create the default symlink from ".git/HEAD" to the "master"

I know that you are just moving this comment, but s/symlink/symref/
would make it more up-to-date.

> +	 * branch, if it does not exist yet.
> +	 */
> [...]
> diff --git a/setup.c b/setup.c
> index 0deb022..1a62277 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "dir.h"
> +#include "refs.h"
>  #include "string-list.h"
> =20
>  static int inside_git_dir =3D -1;
> @@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, cons=
t char *gitdir)
>  	return ret;
>  }
> =20
> +int ref_storage_backend_config(const char *var, const char *value, v=
oid *ptr)
> +{
> +	char **cdata =3D ptr;
> +
> +	if (!strcmp(var, "extensions.refstorage"))
> +		*cdata =3D xstrdup(value);
> +	return 0;
> +}
> +
>  /*
>   * Test if it looks like we're at a git directory.
>   * We want to see:
> @@ -390,6 +400,8 @@ static int check_repo_format(const char *var, con=
st char *value, void *cb)
>  			;
>  		else if (!strcmp(ext, "preciousobjects"))
>  			repository_format_precious_objects =3D git_config_bool(var, value=
);
> +		else if (!strcmp(ext, "refstorage"))
> +			ref_storage_backend =3D xstrdup(value);
>  		else
>  			string_list_append(&unknown_extensions, ext);
>  	}
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 295aa59..31c8279 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -174,6 +174,31 @@ test_expect_success 'reinit' '
>  	test_i18ncmp again/empty again/err2
>  '
> =20
> +test_expect_success 'init with bogus storage backend fails' '
> +
> +	(
> +		mkdir again2 &&
> +		cd again2 &&
> +		test_must_fail git init --ref-storage=3Dtest >out2 2>err2 &&
> +		test_i18ngrep "Unknown ref storage backend test" err2
> +	)
> +'
> +
> +test_expect_failure 'reinit with changed storage backend fails' '
> +
> +	(
> +		mkdir again3 &&
> +		cd again3 &&
> +		git init >out1 2>err1 &&
> +		git init --ref-storage=3Dtest >out2 2>err2
> +	) &&
> +	test_i18ngrep "Initialized empty" again3/out1 &&
> +	test_i18ngrep "Reinitialized existing" again3/out2 &&
> +	>again3/empty &&
> +	test_i18ncmp again3/empty again3/err1 &&
> +	test_i18ncmp again3/empty again3/err2
> +'
> +

Is it worth testing re-initializing with the same --ref-storage? Perhap=
s
not.

>  test_expect_success 'init with --template' '
>  	mkdir template-source &&
>  	echo content >template-source/file &&
>=20

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
