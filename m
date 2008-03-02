From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 09/10] Documentation: update api-builtin and api-setup
Date: Sun, 2 Mar 2008 17:35:19 +0700
Message-ID: <20080302103519.GA9011@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlYB-0003e5-ID
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYCBKfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYCBKfc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:35:32 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYCBKfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:35:31 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=YN0+QMdiE0YfudnO+sh6XGjh0TKKJREE1uwZyI4MY04=;
        b=XAdzFD0cBA/16OcpQAW7bf9+2pFAuD4WRblvUajvz7QcQfz4iive1B3YtqacYG490cxtI/CCrYpfwZKn6QxjX1fQ4fpWNApr53mLECZ/48tNqQYdyMoOtX2gmsjXIl77Imi3dtu3TeyPlcHOv3VYWfuvnDkb6a7dLTNQ2fOeRnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=dBukN9wtuVimCwsTXDAbjb5ELCsHhLNqKuSS98FhCdeDdAZTq0wiG+PSVDOBvpTsUOHZw1MXlw78Vj4ab9lcOh0sMa3fiYSLq3u9Pah9XJnQL9uE9gSgpwyY/9iO4SkH01oW9cXAo8jDsKe9+o4szH2D7mv/32VfkAEuxuSzWWo=
Received: by 10.114.174.2 with SMTP id w2mr14547297wae.17.1204454129072;
        Sun, 02 Mar 2008 02:35:29 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id m5sm23164335wag.9.2008.03.02.02.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:35:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:35:19 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75770>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-builtin.txt |   10 ++++
 Documentation/technical/api-setup.txt   |   91 +++++++++++++++++++++++=
+++++---
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/te=
chnical/api-builtin.txt
index 52cdb4c..f0d988b 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -33,6 +33,10 @@ git:
 	If the standard output is connected to a tty, spawn a pager and
 	feed our output to it.
=20
+`NEED_WORK_TREE`::
+
+	Make sure there is a work tree to work on.
+
 . Add `builtin-foo.o` to `BUILTIN_OBJS` in `Makefile`.
=20
 Additionally, if `foo` is a new command, there are 3 more things to do=
:
@@ -59,5 +63,11 @@ to the subdirectory the command started from.  This =
allows you to
 convert a user-supplied pathname (typically relative to that directory=
)
 to a pathname relative to the top of the work tree.
=20
+`NEED_WORK_TREE` also set `prefix` like `RUN_SETUP`. But it will `die(=
)`
+if there is no work tree.
+
+If neither `NEED_WORK_TREE` nor `RUN_SETUP` is set, `prefix` is always=
 `NULL`.
+No chdir(2) will be done.
+
 The return value from `cmd_foo()` becomes the exit status of the
 command.
diff --git a/Documentation/technical/api-setup.txt b/Documentation/tech=
nical/api-setup.txt
index 4f63a04..6f2defa 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -1,13 +1,88 @@
 setup API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Talk about
+End-user point-of-view how the setup works
+------------------------------------------
=20
-* setup_git_directory()
-* setup_git_directory_gently()
-* is_inside_git_dir()
-* is_inside_work_tree()
-* setup_work_tree()
-* get_pathspec()
+. If you have `GIT_DIR` exported, then no discovery is attempted.
+  We use the `GIT_DIR` you set it, and the repository lives
+  there.  `$GIT_DIR/config` is the repository config.
=20
-(Dscho)
+. Otherwise we do the usual discovery going up to find the
+  repository.
+
+. If you have `GIT_WORK_TREE` exported, or otherwise if the
+  config has `core.worktree`, that's where your worktree is.
+  If these variables point to an invalid place, you have no worktree.
+
+. Otherwise, if you have `GIT_DIR` exported, you do not have a
+  worktree.  Else one level above your `$GIT_DIR` is the toplevel
+  of your worktree.
+
+Repository setup
+----------------
+
+At startup:
+
+. If the command always need a repository, call
+  `setup_git_directory()`. It will ensure you have a valid
+  repository. It will `die()` otherwise. If a worktree is detected,
+  it will be setup automatically. Note that `setup_git_directory()`
+  can only be called once.
+
+. If the command can optionally run in a repository, use
+  `setup_git_directory_gently(&nongit_ok)`,which is similar
+  to `setup_git_directory()` except it won't `die()`
+  but sets `nongit_ok` to true if run outside a repository.
+  No chdir(2) is done.
+
+. If you don't want worktree setup at all, but always need a git repos=
itory,
+  you can use `setup_git_directory_gently(NULL)`.
+
+Do not access git repository (even indirectly like `git_config()`) bef=
ore
+calling one of these functions. Otherwise you may encounter `die()` if=
 git
+fails to automatically find/setup a repository.
+
+Working directory setup
+-----------------------
+
+If `setup_git_directory()` is used, worktree can be optionally setup a=
lready.
+To check if work tree has been setup, use `get_git_work_tree()`. The r=
eturn
+value is `NULL` if no work tree is setup or work tree directory otherw=
ise.
+
+If you need a working directory, use `setup_work_tree()`. It will
+move current directory to top-level working directory and return
+a prefix. It will `die()` if unable to setup working directory.
+
+Miscellanous functions
+----------------------
+
+To know where `$GIT_DIR` is, use `get_git_dir()`. It will always retur=
n
+an absolute path. To know where `$GIT_WORK_TREE` is, use
+`get_git_work_tree()`. To check if you are inside a worktree or a git
+repository, use `is_inside_work_tree()` or `is_inside_git_dir()` respe=
ctively.
+There functions may be not valid until `setup_git_directory*()` is cal=
led.
+
+When working with pathspecs and prefix, you can use `get_pathspec()`
+to auto prepend a given prefix to pathspecs. Other helpful functions
+are `prefix_path()`, `prefix_filename()`
+
+Shell-based setup
+-----------------
+
+At startup, you need to `source git-sh-setup`. If your command does no=
t always
+require a repository, set variable `NONGIT_OK` before sourcing git-sh-=
setup.
+
+If the command requires worktree, call `require_work_tree` (after
+git-sh-setup).
+
+Two variables `USAGE` and `LONG_USAGE` can be optionally set before so=
urcing
+git-sh-setup. They will be printed as help usage.
+
+To check if a repository is a bare repository, `is_bare_repository` ca=
n be
+used.
+
+There are several `git rev-parse` options to help shell scripts initia=
lize
+their environment. Those are `--show-prefix`, `--show-cdup`, `--git-di=
r`,
+`--is-inside-git-dir`, `--is-inside-work-tree`, `--is-bare-repository`=
 and
+`--parseopt`. Please refer to `git rev-parse` man page for more inform=
ation.
--=20
1.5.4.2.281.g28d0e
