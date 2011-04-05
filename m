From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] Documentation: update api-builtin and api-setup
Date: Tue, 5 Apr 2011 03:07:29 -0500
Message-ID: <20110405080729.GA25921@elie>
References: <cover.1204130175.git.pclouds@gmail.com>
 <20080227164045.GA28142@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 10:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q71Im-0004rW-FC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 10:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab1DEIHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 04:07:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39844 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab1DEIHi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 04:07:38 -0400
Received: by iyb14 with SMTP id 14so126141iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Plr4qBBw6UZci5KHTQqg8Lt9INhsBH1RAEZUE0UsuwE=;
        b=iWrw61kL1wKex4fJZXJ+LbLukMOwhJtaB0n+NaC3ME7LTr1njousnVoHQnLNqjE7eJ
         udbD9mpVbD5mGS5hsR+KyNM/WT6BZd3O3a6KKJNX0RRRYw/xUYijtGclzT2dCWOU8lbz
         EUrODhhwK9VGoxhZMwXZ4DzVWeOSTLmh074iY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KK4n2enCVAFIqCXg5d+soNzXeWfcrW8Ko0uCFPX+d1bhNgHrDsXg94ZZ2vbJujbLWX
         tQLp3RzQ9t7vCn2h5r9k7dHkp3G7wZIWsV6uD8LAETPiakOqnliOY1YuvUzayfB6/tY6
         2KjawbonIxbnR1DxRSXM0Z1vA4yOCoq0QlKyc=
Received: by 10.43.46.135 with SMTP id uo7mr1140034icb.50.1301990857057;
        Tue, 05 Apr 2011 01:07:37 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id hc41sm4309286ibb.47.2011.04.05.01.07.35
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 01:07:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080227164045.GA28142@laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170873>

Hi,

On 2008-02-27, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  Documentation/technical/api-builtin.txt |   10 ++++
>  Documentation/technical/api-setup.txt   |   70 +++++++++++++++++++++=
++++++----
>  2 files changed, 72 insertions(+), 8 deletions(-)

I'm curious --- did anything ever come of this patch?

> --- a/Documentation/technical/api-setup.txt
> +++ b/Documentation/technical/api-setup.txt
> @@ -1,13 +1,67 @@
>  setup API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +End-user point-of-view how the setup works
> +------------------------------------------

I suppose this is scattered through git(1) and git-config(1) now.
Maybe it would make sense to centralized in git-repository-layout(5)
or gitcli(7) and put cross-references elsewhere.

> +. If you have `GIT_DIR` exported, then no discovery is attempted.
> +  We use the `GIT_DIR` you set it, and the repository lives
> +  there.  `$GIT_DIR/config` is the repository config.
> +
> +. Otherwise we do the usual discovery going up to find the
> +  repository.
> +
> +. If you have `GIT_WORK_TREE` exported, or otherwise if the
> +  config has `core.worktree`, that's where your worktree is.
> +  If these variables point to an invalid place, you have no worktree=
=2E
> +
> +. Otherwise, if you have `GIT_DIR` exported, you do not have a
> +  worktree.  Else one level above your `$GIT_DIR` is the toplevel
> +  of your worktree.

E.g., like this (but simpler somehow):

	Locating the repository
	-----------------------
	Typically git is run from within a work tree with a `.git`
	subdirectory at its top level or within a `<project>.git` directory
	associated to a bare repository.  To find the toplevel directory,
	git will repeatedly chdir("..") and at each level check for (in
	order of preference):

	 a) a subdirectory named ".git" with readable "objects" and
	    "refs" subdirectories and a readable "HEAD" file;
	 b) a file named ".git";
	 c) readable "objects" and "refs" subdirectories and a
	    readable "HEAD" file.

	Each is interpreted differently:

	 a) a .git subdirectory is the repository and the directory
	    containing it is the top of the work tree.
	 b) a .git file is used to locate the repository (see
	    "Platform-independent .git symlink" below) and the
	    directory containing a .git file is the top of the
	    work tree.
	 c) an ancestory of the starting cwd containing objects/,
	    refs/, and HEAD is treated as a bare repository.
	    There is no work tree in that case.

	Limiting the repository search
	------------------------------
	Git will not chdir("..") into a directory named in the
	GIT_CEILING_DIRECTORIES environment variable, nor will it
	chdir("..") into a directory on a different filesystem unless
	the GIT_DISCOVERY_ACROSS_FILESYSTEM variable is set.

	Unusual repository layouts
	--------------------------
	If the GIT_DIR environment variable is set, it will be used
	and no repository search performed.  The work tree defaults
	to ".".

	The GIT_WORK_TREE environment variable can be used to
	specify the top level of the work tree.  It can even be used
	from within a bare repository, to set up a temporary work
	tree.

	The "core.worktree" configuration variable in a repository
	can be used to specify the top level of the work tree,
	relative to the repository root.  This can be useful in
	situations in which the work tree must be completely pristine
	(so that it is not possible to put a .git symlink or .git file
	in the top level).

	Some files usually found in the repository can be placed
	elsewhere if requested through the environment.

	 * GIT_CONFIG - .git/config
	 * GIT_OBJECT_DIRECTORY - .git/objects
	 * GIT_INDEX_FILE - .git/index
	 * GIT_GRAFT_FILE - .git/info/grafts

> +
> +Repository setup
> +----------------
> +
> +At startup:
> +
> +. If the command always need a repository, call
> +  `setup_git_directory()`. It will ensure you have a valid
> +  repository. It will `die()` otherwise. If a worktree is detected,
> +  it will be setup automatically.
> +
> +. If the command can optionally run in a repository, use
> +  `setup_git_directory_gently(&nongit_ok)`,which is similar
> +  to `setup_git_directory()` except it won't `die()`
> +  but sets `nongit_ok` to true if run outside a repository.
> +  No chdir(2) is done.
> +
> +. If you don't want worktree setup at all, but always need a git rep=
ository,
> +  you can use `setup_git_directory_gently(NULL)`.

Simpler advice might be:

 . If the command is builtin and always needs a repository,
   use the RUN_SETUP flag in the builtin table.
 . If the command is builtin and can benefit from a repository,
   use RUN_SETUP_GENTLY.
 . If you have to run a repository search later, call
   "setup_git_directory_gently" or the shortcut "setup_git_directory"
   (which means "setup_git_directory_gently(NULL)").

> +
> +Do not access git repository (even indirectly like `git_config()`) b=
efore
> +calling one of these functions. Otherwise you may encounter `die()` =
if git
> +fails to automatically find/setup a repository.

 . If you try to access the git repository (even indirectly like
   `git_config()`) before calling setup_git_directory_gently then git
   will look in the wrong place.
 . When changing the value of the GIT_DIR environment variable, call
   set_git_dir.  setup_git_directory_gently does this already.

> +
> +Working directory setup
> +-----------------------
> +
> +If `setup_git_directory()` is used, worktree can be optionally setup=
 already.
> +To check if work tree has been setup, use `get_git_work_tree()`. The=
 return
> +value is `NULL` if no work tree is setup or work tree directory othe=
rwise.
> +
> +If you need a working directory, use `setup_work_tree()`. It will
> +move current directory to top-level working directory and return
> +a prefix. It will `die()` if unable to setup working directory.

Did we ever figure out what happens/should happen when the requested
worktree is not an ancestor of cwd?

> +
> +Miscellanous functions
> +----------------------
> +
> +To know where `$GIT_DIR` is, use `get_git_dir()`. It will always ret=
urn
> +an absolute path. To know where `$GIT_WORK_TREE` is, use
> +`get_git_work_tree()`. To check if you are inside a worktree or a gi=
t
> +repository, use `is_inside_work_tree()` or `is_inside_git_dir()` res=
pectively.
> +There functions may be not valid until `setup_git_directory*()` is c=
alled.
> +
> +When working with pathspecs and prefix, you can use `get_pathspec()`
> +to auto prepend a given prefix to pathspecs. Other helpful functions
> +are `prefix_path()`, `prefix_filename()`

What do prefix_* do when there is no worktree?

> -Talk about
> -
> +
> -* setup_git_directory()
> -* setup_git_directory_gently()
> -* is_inside_git_dir()
> -* is_inside_work_tree()
> -* setup_work_tree()
> -* get_pathspec()
> -
> -(Dscho)
> --=20
> 1.5.4.2.281.g28d0e
>=20
