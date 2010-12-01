From: jari.aalto@cante.net
Subject: [PATCH] git-rebase.txt: (OPTIONS): order alphabetically
Date: Wed,  1 Dec 2010 20:01:18 +0200
Organization: Private
Message-ID: <1291226478-17289-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNr0L-0005xr-0B
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0LASBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:01:47 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:40495 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab0LASBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:01:45 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 3F81E8C4C1
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:01:44 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01FFF3B67B; Wed, 01 Dec 2010 20:01:44 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 61DEE27D87
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:01:42 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNqzW-0004VH-3Q; Wed, 01 Dec 2010 20:01:18 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162559>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-rebase.txt |  183 +++++++++++++++++++++---------------=
------
 1 files changed, 93 insertions(+), 90 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..297b85b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -204,6 +204,10 @@ rebase.autosquash::
=20
 OPTIONS
 -------
+
+<branch>::
+	Working branch; defaults to HEAD.
+
 <newbase>::
 	Starting point at which to create the new commits. If the
 	--onto option is not specified, the starting point is
@@ -218,66 +222,24 @@ leave out at most one of A and B, in which case it =
defaults to HEAD.
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name.
=20
-<branch>::
-	Working branch; defaults to HEAD.
-
---continue::
-	Restart the rebasing process after having resolved a merge conflict.
-
 --abort::
 	Restore the original branch and abort the rebase operation.
+	See also `--continue' and `--skip'.
=20
---skip::
-	Restart the rebasing process by skipping the current patch.
-
--m::
---merge::
-	Use merging strategies to rebase.  When the recursive (default) merge
-	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+--autosquash::
+--no-autosquash::
+	When the commit log message begins with "squash! ..." (or
+	"fixup! ..."), and there is a commit whose title begins with
+	the same ..., automatically modify the todo list of rebase -i
+	so that the commit marked for squashing comes right after the
+	commit to be modified, and change the action of the moved
+	commit from `pick` to `squash` (or `fixup`).
 +
-Note that a rebase merge works by replaying each commit from the working
-branch on top of the <upstream> branch.  Because of this, when a merge
-conflict happens, the side reported as 'ours' is the so-far rebased
-series, starting with <upstream>, and 'theirs' is the working branch.  I=
n
-other words, the sides are swapped.
-
--s <strategy>::
---strategy=3D<strategy>::
-	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+This option is only valid when the '--interactive' option is used.
 +
-Because 'git rebase' replays each commit from the working branch
-on top of the <upstream> branch using the given strategy, using
-the 'ours' strategy simply discards all patches from the <branch>,
-which makes little sense.
-
--X <strategy-option>::
---strategy-option=3D<strategy-option>::
-	Pass the <strategy-option> through to the merge strategy.
-	This implies `\--merge` and, if no strategy has been
-	specified, `-s recursive`.  Note the reversal of 'ours' and
-	'theirs' as noted in above for the `-m` option.
-
--q::
---quiet::
-	Be quiet. Implies --no-stat.
-
--v::
---verbose::
-	Be verbose. Implies --stat.
-
---stat::
-	Show a diffstat of what changed upstream since the last rebase. The
-	diffstat is also controlled by the configuration option rebase.stat.
-
--n::
---no-stat::
-	Do not show a diffstat as part of the rebase process.
-
---no-verify::
-	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5]=
.
+If the '--autosquash' option is enabled by default using the
+configuration variable `rebase.autosquash`, this option can be
+used to override and disable this setting.
=20
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
@@ -285,6 +247,16 @@ which makes little sense.
 	context exist they all must match.  By default no context is
 	ever ignored.
=20
+--continue::
+	Restart the rebasing process after having resolved a merge conflict.
+	See also `--abort' and `--skip'.
+
+--committer-date-is-author-date::
+--ignore-date::
+	These flags are passed to 'git am' to easily change the dates
+	of the rebased commits (see linkgit:git-am[1]).
+	Incompatible with the --interactive option.
+
 -f::
 --force-rebase::
 	Force the rebase even if the current branch is a descendant
@@ -299,23 +271,62 @@ fresh commits so it can be remerged successfully wi=
thout needing to "revert
 the reversion" (see the
 link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for d=
etails).
=20
+-i::
+--interactive::
+	Make a list of the commits which are about to be rebased.  Let the
+	user edit that list before rebasing.  This mode can also be used to
+	split commits (see SPLITTING COMMITS below).
+
 --ignore-whitespace::
 --whitespace=3D<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Incompatible with the --interactive option.
=20
---committer-date-is-author-date::
---ignore-date::
-	These flags are passed to 'git am' to easily change the dates
-	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --interactive option.
+-m::
+--merge::
+	Use merging strategies to rebase.  When the recursive (default) merge
+	strategy is used, this allows rebase to be aware of renames on the
+	upstream side.
++
+Note that a rebase merge works by replaying each commit from the working
+branch on top of the <upstream> branch.  Because of this, when a merge
+conflict happens, the side reported as 'ours' is the so-far rebased
+series, starting with <upstream>, and 'theirs' is the working branch.  I=
n
+other words, the sides are swapped.
=20
--i::
---interactive::
-	Make a list of the commits which are about to be rebased.  Let the
-	user edit that list before rebasing.  This mode can also be used to
-	split commits (see SPLITTING COMMITS below).
+-n::
+--no-stat::
+	Do not show a diffstat as part of the rebase process.
+
+--no-ff::
+	With --interactive, cherry-pick all rebased commits instead of
+	fast-forwarding over the unchanged ones.  This ensures that the
+	entire history of the rebased branch is composed of new commits.
++
+Without --interactive, this is a synonym for --force-rebase.
++
+You may find this helpful after reverting a topic branch merge, as this =
option
+recreates the topic branch with fresh commits so it can be remerged
+successfully without needing to "revert the reversion" (see the
+link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for d=
etails).
+--no-verify::
+	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5]=
.
+
+-s <strategy>::
+--strategy=3D<strategy>::
+	Use the given merge strategy.
+	If there is no `-s` option 'git merge-recursive' is used
+	instead.  This implies --merge.
++
+Because 'git rebase' replays each commit from the working branch
+on top of the <upstream> branch using the given strategy, using
+the 'ours' strategy simply discards all patches from the <branch>,
+which makes little sense.
+
+--skip::
+	Restart the rebasing process by skipping the current patch.
+	See also `--abort' and `--contnue'.
=20
 -p::
 --preserve-merges::
@@ -326,6 +337,10 @@ with the `--interactive` option explicitly is genera=
lly not a good
 idea unless you know what you are doing (see BUGS below).
=20
=20
+-q::
+--quiet::
+	Be quiet. Implies --no-stat.
+
 --root::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
@@ -335,32 +350,20 @@ idea unless you know what you are doing (see BUGS b=
elow).
 	root commits will be rewritten to have <newbase> as parent
 	instead.
=20
---autosquash::
---no-autosquash::
-	When the commit log message begins with "squash! ..." (or
-	"fixup! ..."), and there is a commit whose title begins with
-	the same ..., automatically modify the todo list of rebase -i
-	so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).
-+
-This option is only valid when the '--interactive' option is used.
-+
-If the '--autosquash' option is enabled by default using the
-configuration variable `rebase.autosquash`, this option can be
-used to override and disable this setting.
+--stat::
+	Show a diffstat of what changed upstream since the last rebase. The
+	diffstat is also controlled by the configuration option rebase.stat.
=20
---no-ff::
-	With --interactive, cherry-pick all rebased commits instead of
-	fast-forwarding over the unchanged ones.  This ensures that the
-	entire history of the rebased branch is composed of new commits.
-+
-Without --interactive, this is a synonym for --force-rebase.
-+
-You may find this helpful after reverting a topic branch merge, as this =
option
-recreates the topic branch with fresh commits so it can be remerged
-successfully without needing to "revert the reversion" (see the
-link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for d=
etails).
+-v::
+--verbose::
+	Be verbose. Implies --stat.
+
+-X <strategy-option>::
+--strategy-option=3D<strategy-option>::
+	Pass the <strategy-option> through to the merge strategy.
+	This implies `\--merge` and, if no strategy has been
+	specified, `-s recursive`.  Note the reversal of 'ours' and
+	'theirs' as noted in above for the `-m` option.
=20
 include::merge-strategies.txt[]
=20
--=20
1.7.2.3
