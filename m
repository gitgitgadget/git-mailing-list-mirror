From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] branch: add -u as a shortcut for --set-upstream
Date: Thu,  5 Jul 2012 09:57:15 +0200
Message-ID: <1341475035-14310-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 09:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgwE-0004IZ-AM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab2GEH5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 03:57:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:37969 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab2GEH5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:57:17 -0400
Received: from flaca.cmartin.tk (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 2663846057
	for <git@vger.kernel.org>; Thu,  5 Jul 2012 09:57:15 +0200 (CEST)
Received: (nullmailer pid 14345 invoked by uid 1000);
	Thu, 05 Jul 2012 07:57:15 -0000
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201039>

Add this shortcut just like git-push has it.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

I've seen threads commenting how it's odd that this doesn't exist[0],
but nobody seems to have done anything about it yet.

This may need some updates to the shell completions, but I've no idea
how those work and I'd rather not change things randomly.

[0] see e.g. http://thread.gmane.org/gmane.comp.version-control.git/165=
794/focus=3D165856

 Documentation/git-branch.txt | 1 +
 builtin/branch.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 47235be..447325f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -167,6 +167,7 @@ start-point is either a local or remote-tracking br=
anch.
 	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
=20
+-u::
 --set-upstream::
 	If specified branch does not exist yet or if `--force` has been
 	given, acts exactly like `--track`. Otherwise sets up configuration
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..9f2bb6f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -724,7 +724,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT__QUIET(&quiet, "suppress informational messages"),
 		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pu=
ll(1))",
 			BRANCH_TRACK_EXPLICIT),
-		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
+		OPT_SET_INT('u', "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking bran=
ches",
--=20
1.7.11.1.104.ge7b44f1
