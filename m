From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 23:40:32 +0700
Message-ID: <20110524164032.GA2059@do>
References: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com>
 <7voc2s850z.fsf@alter.siamese.dyndns.org>
 <BANLkTingh__Yxy_rEM2mV6wB453OdarrwA@mail.gmail.com>
 <7vfwo483qe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Pegon <pegon.marc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:40:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuf3-00006z-QK
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756536Ab1EXQko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2011 12:40:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41240 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab1EXQkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:40:43 -0400
Received: by pwi15 with SMTP id 15so3088889pwi.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nzZzX7IKzB55sjgnku8Ih6MxsXZzIjxIomQcUiJokGs=;
        b=rXrIUGFlr1V4Itc/zaoNsOPOrdAMKjR0iu2ej/OdEM12spcBjQqlpYs+0wEA3qQsEI
         8vmxDx4jioHjxEK4zsmVURTCxZeuvWaqlXegx2+9Fted46nDuStCC9S1bmKmguoPIVl1
         dOJ8Q8bXphSCzLVr4L61+mpYBF4miq93T/fpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sgXPbZBY1MNee3K7sV5DpDpqPMBlAGop2e+x4Uh1yyLJymlhDwD6TLhy+/IKejwG6n
         KGem3FsRW+Izv2kyvzzJPpwH34syjBXXs8TuM8FepQ2KxrZxTpmOnenq+9finDWqGzJe
         L+ufcHuWTvXGR4tf9Y+AvO/V4groxsTjURcT8=
Received: by 10.68.57.168 with SMTP id j8mr3102659pbq.111.1306255242268;
        Tue, 24 May 2011 09:40:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.240.200])
        by mx.google.com with ESMTPS id v8sm5097189pbk.95.2011.05.24.09.40.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 09:40:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 24 May 2011 23:40:32 +0700
Content-Disposition: inline
In-Reply-To: <7vfwo483qe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174329>

On Tue, May 24, 2011 at 09:26:01AM -0700, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>=20
> >> As it hasn't been advertised in the documentation (lucky us), it p=
robably is not too
> >> late to remove it.
> >
> > No objection if you remove it. I was probably thinking of git
> > "symlink" but the traditional -l was taken, so -L.
>=20
> I do not care deeply enough to remove it myself, but it is a bad tast=
e to
> give a short variant to an option that hasn't yet proven to be freque=
ntly
> useful, especially to a command whose other command has no short vari=
ant.

Just had a look at it. The option is documented in init and
clone. init-db is deprecated so I did not bother. I hope this obscure
feature has not been widely used yet and this patch can still apply

-- 8< --
Subject: [PATCH] init/clone: remove short option -L

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt |    3 +--
 Documentation/git-init.txt  |    3 +--
 builtin/clone.c             |    2 +-
 builtin/init-db.c           |    2 +-
 t/t0001-init.sh             |    2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 86eb4c9..b093e45 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git clone' [--template=3D<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository=
>]
-	  [--separate-git-dir|-L <git dir>]
+	  [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--recursive|--recurse-submodules] [--] <reposito=
ry>
 	  [<directory>]
=20
@@ -177,7 +177,6 @@ objects from the source repository into a pack in t=
he cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
=20
--L=3D<git dir>::
 --separate-git-dir=3D<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 58cd011..f2777a7 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,7 +9,7 @@ git-init - Create an empty git repository or reinitiali=
ze an existing one
 SYNOPSIS
 --------
 'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]
-	  [--separate-git-dir|-L <git dir>]
+	  [--separate-git-dir <git dir>]
 	  [--shared[=3D<permissions>]] [directory]
=20
=20
@@ -54,7 +54,6 @@ current working directory.
 Specify the directory from which templates will be used.  (See the "TE=
MPLATE
 DIRECTORY" section below.)
=20
--L=3D<git dir>::
 --separate-git-dir=3D<git dir>::
=20
 Instead of initializing the repository where it is supposed to be,
diff --git a/builtin/clone.c b/builtin/clone.c
index 49c838f..f579794 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -81,7 +81,7 @@ static struct option builtin_clone_options[] =3D {
 		   "path to git-upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
-	OPT_STRING('L', "separate-git-dir", &real_git_dir, "gitdir",
+	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 		   "separate git dir from working tree"),
=20
 	OPT_END()
diff --git a/builtin/init-db.c b/builtin/init-db.c
index ba13a54..025aa47 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -490,7 +490,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 			"specify that the git repository is to be shared amongst several us=
ers",
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
 		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
-		OPT_STRING('L', "separate-git-dir", &real_git_dir, "gitdir",
+		OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
 			   "separate git dir from working tree"),
 		OPT_END()
 	};
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 8106af8..ad66410 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -409,7 +409,7 @@ test_expect_success SYMLINKS 're-init to move gitdi=
r symlink' '
 	cd newdir &&
 	mv .git here &&
 	ln -s here .git &&
-	git init -L ../realgitdir
+	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: `pwd`/realgitdir" >expected &&
 	test_cmp expected newdir/.git &&
--=20
1.7.4.74.g639db

-- 8< --
--=20
Duy
