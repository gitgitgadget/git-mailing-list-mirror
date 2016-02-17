From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 15/21] init: allow alternate ref strorage to be set
 for new repos
Date: Wed, 17 Feb 2016 15:47:16 -0500
Organization: Twitter
Message-ID: <1455742036.7528.18.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-16-git-send-email-dturner@twopensource.com>
	 <56BDF9B1.5050302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 21:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW90O-0005f6-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 21:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbcBQUrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 15:47:21 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33381 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161007AbcBQUrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 15:47:19 -0500
Received: by mail-qk0-f174.google.com with SMTP id s5so10950508qkd.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=856A8wK+ubZfnIvm3nU5zlDlkWmkbqVmabtsB9wA2xI=;
        b=mYeBmTVGHqVAnfLM14yRg/fcbsjOlqugWB1pkSH3Nf7jIzCD/Np9UmEhwrQqvb5/vM
         K7fSlEZoiSFokCD/GcSUcEmvW7fBIaqmmJ0U+HL2aC1eBfTBEpGV0foS5ZuC5faqOhUV
         gvvJN82ZbSLcj/SczApLAdZQcZoMZTMJUHqPTnIZ6tHgWDxB6rfMJX7XfCKgdMw6VC/X
         h+Uejn9FhSsBT3a4nIDP1o+2JVZygEssqjQOOjSMBmIgKjh24k4+J7wd3h5AvN8iwPH1
         JytAngy8HROR+GilFT0NEwbELzX/aOTWT8oI5iM50oz2j8hg3lNyFYd8LTjeKSj76P2m
         Y3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=856A8wK+ubZfnIvm3nU5zlDlkWmkbqVmabtsB9wA2xI=;
        b=LHYXjUs7fJH8LrB3RcYwG5VA9B9L6ZBvIq5yQQ674Qfubpbgpme7iwXzEYiAghCKQm
         9boVh5UXWxp3NvcD4ICuxqF7jCP/altd3Ez+qQi1L1Xln7xdx1TdRDSp5j+x4nGbCKO8
         ABFIjiLq/Yz2J6QhPpFV/UKAIEeanPaVGUgVRUnxGanEtwtpoxJw40kt1fbWg0nUQkTY
         9diJbxwz91tYQUvPWyEZAGcpX/zjPFeNHpjMG6M9X4RoJ8hcCBDHHlDeT+FLNbhJSCna
         e+43EBu3leRNVuqi/Ip5EcLKZZcxe02GkFUX4hFpr5fJXMSpzwqZ20OrHODsQVtToEju
         buJw==
X-Gm-Message-State: AG10YOSMDlMuwyRl1GM1Ux9vg3NtBed21fkNfUGPrJ6RB7JSVFXs6MCDyktGqd89xkPLzA==
X-Received: by 10.55.80.9 with SMTP id e9mr4487477qkb.94.1455742039041;
        Wed, 17 Feb 2016 12:47:19 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id y127sm1253834qky.4.2016.02.17.12.47.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 12:47:18 -0800 (PST)
In-Reply-To: <56BDF9B1.5050302@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286548>

On Fri, 2016-02-12 at 16:26 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > git init learns a new argument --ref-storage.  Presently, only
> > "files" is supported, but later we will add other storage backends.
> >=20
> > When this argument is used, the repository's extensions.refStorage
> > configuration value is set (as well as
> > core.repositoryformatversion),
> > and the ref storage backend's initdb function is used to set up the
> > ref database.
> >=20
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> > ---
> >  Documentation/git-init-db.txt          |  2 +-
> >  Documentation/git-init.txt             |  7 +++++-
> >  builtin/init-db.c                      | 44
> > +++++++++++++++++++++++++++-------
> >  cache.h                                |  2 ++
> >  contrib/completion/git-completion.bash |  3 ++-
> >  path.c                                 | 29 ++++++++++++++++++++--
> >  refs.c                                 |  8 +++++++
> >  refs.h                                 |  8 +++++++
> >  setup.c                                | 12 ++++++++++
> >  t/t0001-init.sh                        | 25 +++++++++++++++++++
> >  10 files changed, 127 insertions(+), 13 deletions(-)
> >=20
> > [...]
> > diff --git a/Documentation/git-init.txt b/Documentation/git
> > -init.txt
> > index 8174d27..d2b150f 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -12,7 +12,7 @@ SYNOPSIS
> >  'git init' [-q | --quiet] [--bare] [-
> > -template=3D<template_directory>]
> >  	  [--separate-git-dir <git dir>]
> >  	  [--shared[=3D<permissions>]] [directory]
> > -
> > +	  [--ref-storage=3D<name>]
> > =20
> >  DESCRIPTION
> >  -----------
> > @@ -113,6 +113,11 @@ does not exist, it will be created.
> > =20
> >  --
> > =20
> > +--ref-storage=3D<name>::
> > +Type of refs storage backend. Default is to use the original
> > "files"
> > +storage, which stores ref data in files in .git/refs and
> > +.git/packed-refs.
> > +
>=20
> Technically, that should be $GIT_DIR/refs and $GIT_DIR/packed-refs.
> But
> it might be that we are not so picky about the distinction in the
> user docs.

We're not (according to grep), but we probably should be.

> >  TEMPLATE DIRECTORY
> >  ------------------
> > =20
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 801e977..d331ce8 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -24,6 +24,7 @@ static int init_is_bare_repository =3D 0;
> >  static int init_shared_repository =3D -1;
> >  static const char *init_db_template_dir;
> >  static const char *git_link;
> > +static char *requested_ref_storage_backend;
> > =20
> >  static void copy_templates_1(struct strbuf *path, struct strbuf
> > *template,
> >  			     DIR *dir)
> > @@ -179,6 +180,7 @@ static int create_default_files(const char
> > *template_path)
> >  	int reinit;
> >  	int filemode;
> >  	struct strbuf err =3D STRBUF_INIT;
> > +	int repo_version =3D 0;
> > =20
> >  	/* Just look for `init.templatedir` */
> >  	git_config(git_init_db_config, NULL);
> > @@ -205,6 +207,32 @@ static int create_default_files(const char
> > *template_path)
> >  	}
> > =20
> >  	/*
> > +	 * Create the default symlink from ".git/HEAD" to the
> > "master"
>=20
> I know that you are just moving this comment, but s/symlink/symref/
> would make it more up-to-date.

OK.

> > +	 * branch, if it does not exist yet.
> > +	 */
> > [...]
> > diff --git a/setup.c b/setup.c
> > index 0deb022..1a62277 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1,5 +1,6 @@
> >  #include "cache.h"
> >  #include "dir.h"
> > +#include "refs.h"
> >  #include "string-list.h"
> > =20
> >  static int inside_git_dir =3D -1;
> > @@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb,
> > const char *gitdir)
> >  	return ret;
> >  }
> > =20
> > +int ref_storage_backend_config(const char *var, const char *value,
> > void *ptr)
> > +{
> > +	char **cdata =3D ptr;
> > +
> > +	if (!strcmp(var, "extensions.refstorage"))
> > +		*cdata =3D xstrdup(value);
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Test if it looks like we're at a git directory.
> >   * We want to see:
> > @@ -390,6 +400,8 @@ static int check_repo_format(const char *var,
> > const char *value, void *cb)
> >  			;
> >  		else if (!strcmp(ext, "preciousobjects"))
> >  			repository_format_precious_objects =3D
> > git_config_bool(var, value);
> > +		else if (!strcmp(ext, "refstorage"))
> > +			ref_storage_backend =3D xstrdup(value);
> >  		else
> >  			string_list_append(&unknown_extensions,
> > ext);
> >  	}
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index 295aa59..31c8279 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -174,6 +174,31 @@ test_expect_success 'reinit' '
> >  	test_i18ncmp again/empty again/err2
> >  '
> > =20
> > +test_expect_success 'init with bogus storage backend fails' '
> > +
> > +	(
> > +		mkdir again2 &&
> > +		cd again2 &&
> > +		test_must_fail git init --ref-storage=3Dtest >out2
> > 2>err2 &&
> > +		test_i18ngrep "Unknown ref storage backend test"
> > err2
> > +	)
> > +'
> > +
> > +test_expect_failure 'reinit with changed storage backend fails' '
> > +
> > +	(
> > +		mkdir again3 &&
> > +		cd again3 &&
> > +		git init >out1 2>err1 &&
> > +		git init --ref-storage=3Dtest >out2 2>err2
> > +	) &&
> > +	test_i18ngrep "Initialized empty" again3/out1 &&
> > +	test_i18ngrep "Reinitialized existing" again3/out2 &&
> > +	>again3/empty &&
> > +	test_i18ncmp again3/empty again3/err1 &&
> > +	test_i18ncmp again3/empty again3/err2
> > +'
> > +
>=20
> Is it worth testing re-initializing with the same --ref-storage?
> Perhaps
> not.

Would be nice, but since we cannot guarantee that any alternate backend
exists, we have no way to test this.  We'd have to add an entire "test"
ref backend just for tests, which seems a bit overboard.

> >  test_expect_success 'init with --template' '
> >  	mkdir template-source &&
> >  	echo content >template-source/file &&
> >=20
>=20
> Michael
>=20
