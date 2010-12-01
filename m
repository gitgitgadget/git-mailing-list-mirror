From: jari.aalto@cante.net
Subject: [PATCH] git-clone.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:09:32 +0200
Organization: Private
Message-ID: <1291234172-20927-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNszt-0006vW-CH
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab0LAUJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:09:36 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:50279 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab0LAUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:09:35 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 5053113B913
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:09:34 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0391746885; Wed, 01 Dec 2010 22:09:34 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 1F217E51A3
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:09:32 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNszc-0005Rx-Lq; Wed, 01 Dec 2010 22:09:32 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162596>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-clone.txt |  173 ++++++++++++++++++++++---------------=
------
 1 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 42e7021..35f5017 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -37,8 +37,37 @@ configuration variables.
=20
 OPTIONS
 -------
---local::
+
+--bare::
+	Make a 'bare' GIT repository.  That is, instead of
+	creating `<directory>` and placing the administrative
+	files in `<directory>/.git`, make the `<directory>`
+	itself the `$GIT_DIR`. This obviously implies the `-n`
+	because there is nowhere to check out the working tree.
+	Also the branch heads at the remote are copied directly
+	to corresponding local branch heads, without mapping
+	them to `refs/remotes/origin/`.  When this option is
+	used, neither remote-tracking branches nor the related
+	configuration variables are created.
+
+-b <name>::
+--branch <name>::
+	Instead of pointing the newly created HEAD to the branch pointed
+	to by the cloned repository's HEAD, point to `<name>` branch
+	instead. In a non-bare repository, this is the branch that will
+	be checked out.
+
+--depth <depth>::
+	Create a 'shallow' clone with a history truncated to the
+	specified number of revisions.  A shallow repository has a
+	number of limitations (you cannot clone or fetch from
+	it, nor push from nor into it), but is adequate if you
+	are only interested in the recent history of a large project
+	with a long history, and would want to send in fixes
+	as patches.
+
 -l::
+--local::
 	When the repository to clone from is on a local machine,
 	this flag bypasses the normal "git aware" transport
 	mechanism and clones the repository by making a copy of
@@ -52,13 +81,61 @@ OPTIONS
 	but still avoid the usual "git aware" transport
 	mechanism, `--no-hardlinks` can be used.
=20
+--mirror::
+	Set up a mirror of the source repository.  This implies `--bare`.
+	Compared to `--bare`, `--mirror` not only maps local branches of the
+	source to local branches of the target, it maps all refs (including
+	remote-tracking branches, notes etc.) and sets up a refspec configurati=
on such
+	that all these refs are overwritten by a `git remote update` in the
+	target repository.
+
+-n::
+--no-checkout::
+	No checkout of HEAD is performed after the clone is complete.
+
 --no-hardlinks::
 	Optimize the cloning process from a repository on a
 	local filesystem by copying files under `.git/objects`
 	directory.
=20
---shared::
+-o <name>::
+--origin <name>::
+	Instead of using the remote name `origin` to keep track
+	of the upstream repository, use `<name>`.
+
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
+-q::
+--quiet::
+	Operate quietly.  Progress is not reported to the standard
+	error stream. This flag is also passed to the `rsync'
+	command when given.
+
+--recursive::
+--recurse-submodules::
+	After the clone is created, initialize all submodules within,
+	using their default settings. This is equivalent to running
+	`git submodule update --init --recursive` immediately after
+	the clone is finished. This option is ignored if the cloned
+	repository does not have a worktree/checkout (i.e. if any of
+	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--reference <repository>::
+	If the reference repository is on the local machine,
+	automatically setup `.git/objects/info/alternates` to
+	obtain objects from the reference repository.  Using
+	an already existing repository as an alternate will
+	require fewer objects to be copied from the repository
+	being cloned, reducing network and local storage costs.
++
+*NOTE*: see the NOTE for the `--shared` option.
+
 -s::
+--shared::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
 	`.git/objects/info/alternates` to share the objects
@@ -85,96 +162,20 @@ If you want to break the dependency of a repository =
cloned with `-s` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
=20
---reference <repository>::
-	If the reference repository is on the local machine,
-	automatically setup `.git/objects/info/alternates` to
-	obtain objects from the reference repository.  Using
-	an already existing repository as an alternate will
-	require fewer objects to be copied from the repository
-	being cloned, reducing network and local storage costs.
-+
-*NOTE*: see the NOTE for the `--shared` option.
-
---quiet::
--q::
-	Operate quietly.  Progress is not reported to the standard
-	error stream. This flag is also passed to the `rsync'
-	command when given.
-
---verbose::
--v::
-	Run verbosely. Does not affect the reporting of progress status
-	to the standard error stream.
-
---progress::
-	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal, unless -q
-	is specified. This flag forces progress status even if the
-	standard error stream is not directed to a terminal.
-
---no-checkout::
--n::
-	No checkout of HEAD is performed after the clone is complete.
-
---bare::
-	Make a 'bare' GIT repository.  That is, instead of
-	creating `<directory>` and placing the administrative
-	files in `<directory>/.git`, make the `<directory>`
-	itself the `$GIT_DIR`. This obviously implies the `-n`
-	because there is nowhere to check out the working tree.
-	Also the branch heads at the remote are copied directly
-	to corresponding local branch heads, without mapping
-	them to `refs/remotes/origin/`.  When this option is
-	used, neither remote-tracking branches nor the related
-	configuration variables are created.
-
---mirror::
-	Set up a mirror of the source repository.  This implies `--bare`.
-	Compared to `--bare`, `--mirror` not only maps local branches of the
-	source to local branches of the target, it maps all refs (including
-	remote-tracking branches, notes etc.) and sets up a refspec configurati=
on such
-	that all these refs are overwritten by a `git remote update` in the
-	target repository.
-
---origin <name>::
--o <name>::
-	Instead of using the remote name `origin` to keep track
-	of the upstream repository, use `<name>`.
-
---branch <name>::
--b <name>::
-	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repository's HEAD, point to `<name>` branch
-	instead. In a non-bare repository, this is the branch that will
-	be checked out.
+--template=3D<template_directory>::
+	Specify the directory from which templates will be used;
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
=20
---upload-pack <upload-pack>::
 -u <upload-pack>::
+--upload-pack <upload-pack>::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
=20
---template=3D<template_directory>::
-	Specify the directory from which templates will be used;
-	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
-
---depth <depth>::
-	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
-	are only interested in the recent history of a large project
-	with a long history, and would want to send in fixes
-	as patches.
-
---recursive::
---recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+-v::
+--verbose::
+	Run verbosely. Does not affect the reporting of progress status
+	to the standard error stream.
=20
 <repository>::
 	The (possibly remote) repository to clone from.  See the
--=20
1.7.2.3
