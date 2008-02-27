From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 9/9] Documentation: update api-builtin and api-setup
Date: Wed, 27 Feb 2008 23:40:45 +0700
Message-ID: <20080227164045.GA28142@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPLd-0002PQ-FJ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbYB0Qky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbYB0Qky
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:40:54 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:64465 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbYB0Qkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:40:53 -0500
Received: by an-out-0708.google.com with SMTP id d31so645391and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=kh/FzwKQG3JREbrCP7ePpQ7a0xizwVyzTI5XtJbPOyA=;
        b=gUUVCf6/ZclTEdyIUeWFiebraorvqi7xvG39jX6l0UIBJt8eTHw1SFt5UxKd+5Yf0duLXBX2DtlRBLcYbc23z6AB4dJsW6wdq2SyJv/lt9scywp3CwN7MrhoP9BY7EZ0r8v7NcBysKlbwkFz5xYkS0R1ebRrRu+W/JtYri/jM4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=FvNRCCjssUVzq9CY1YzI/f1mbg7o+GhJYgHAcLwKff4VUypt/yBIgeVHLsfMDWAP5g4bh3UjGejzG3f04p7FHNI4L+lVaoW3wyHJw1LAFD1tBrR5QqtkGmYmIwBy4J/YOjWTPhgbRCHVPT/IdyQMiQ9VOwsGQIpu6Y7Ay7MWMs0=
Received: by 10.101.68.19 with SMTP id v19mr12575476ank.62.1204130452422;
        Wed, 27 Feb 2008 08:40:52 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id h27sm10513218elf.1.2008.02.27.08.40.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:40:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:40:45 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75241>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/api-builtin.txt |   10 ++++
 Documentation/technical/api-setup.txt   |   70 +++++++++++++++++++++++=
++++----
 2 files changed, 72 insertions(+), 8 deletions(-)

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
index 4f63a04..43e5a81 100644
--- a/Documentation/technical/api-setup.txt
+++ b/Documentation/technical/api-setup.txt
@@ -1,13 +1,67 @@
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
+  it will be setup automatically.
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
--=20
1.5.4.2.281.g28d0e
