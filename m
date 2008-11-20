From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Add Vim modelines for consistent spacing
Date: Thu, 20 Nov 2008 14:59:04 +0100
Message-ID: <1227189544-29750-1-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 20 15:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3A5I-0001nd-Gc
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbYKTN7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbYKTN7S
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:59:18 -0500
Received: from clegg.madduck.net ([193.242.105.96]:44542 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbYKTN7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:59:17 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 77C461D40A9;
	Thu, 20 Nov 2008 14:59:06 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 2AB799F34F;
	Thu, 20 Nov 2008 14:59:05 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 9EAA045F4; Thu, 20 Nov 2008 14:59:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101434>

TopGit shell scripts use sw=8:ts=8:noet and to ensure that everyone complies,
these modelines configure Vim on open.

Signed-off-by: martin f. krafft <madduck@debian.org>

---
 create-help.sh |    1 +
 tg-create.sh   |    2 ++
 tg-delete.sh   |    2 ++
 tg-depend.sh   |    2 ++
 tg-export.sh   |    2 ++
 tg-import.sh   |    2 ++
 tg-info.sh     |    2 ++
 tg-mail.sh     |    2 ++
 tg-patch.sh    |    2 ++
 tg-remote.sh   |    2 ++
 tg-summary.sh  |    2 ++
 tg-update.sh   |    2 ++
 tg.sh          |    2 ++
 13 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/create-help.sh b/create-help.sh
index 766e8d4..8324b2a 100755
--- a/create-help.sh
+++ b/create-help.sh
@@ -15,3 +15,4 @@ fi
 	{ if (incommand) { print $0; } }
 '  > tg-"$1".txt
 
+# vim:sw=8:ts=8:noet
diff --git a/tg-create.sh b/tg-create.sh
index 6ee3f02..677c19d 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -141,3 +141,5 @@ git add -f "$root_dir/.topmsg"
 
 info "Topic branch $name set up. Please fill .topmsg now and make initial commit."
 info "To abort: git rm -f .top* && git checkout ${deps%% *} && $tg delete $name"
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-delete.sh b/tg-delete.sh
index 7f7ede7..37f4bac 100644
--- a/tg-delete.sh
+++ b/tg-delete.sh
@@ -44,3 +44,5 @@ branch_empty "$name" || nonempty=1
 
 git update-ref -d "refs/top-bases/$name" "$baserev"
 git update-ref -d "refs/heads/$name" "$branchrev"
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-depend.sh b/tg-depend.sh
index ff4541c..4539188 100644
--- a/tg-depend.sh
+++ b/tg-depend.sh
@@ -47,3 +47,5 @@ echo "$name" >>"$root_dir/.topdeps"
 git add -f "$root_dir/.topdeps"
 git commit -m"New TopGit dependency: $name"
 $tg update
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-export.sh b/tg-export.sh
index 52af88d..73a6ec8 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -199,3 +199,5 @@ elif [ "$driver" = "quilt" ]; then
 	depcount="$(cat "$output/series" | wc -l)"
 	echo "Exported topic branch $name (total $depcount topics) to directory $output"
 fi
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-import.sh b/tg-import.sh
index b036b86..5c0484c 100644
--- a/tg-import.sh
+++ b/tg-import.sh
@@ -116,3 +116,5 @@ do
 		esac
 	done
 done
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-info.sh b/tg-info.sh
index 9076247..6ae55c3 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -73,3 +73,5 @@ else
 	echo "Up-to-date."
 fi
 rm "$depcheck"
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-mail.sh b/tg-mail.sh
index 7b8f7ff..4d23a0e 100644
--- a/tg-mail.sh
+++ b/tg-mail.sh
@@ -55,3 +55,5 @@ people=
 eval git send-email $send_email_args "$people" "$patchfile"
 
 rm "$patchfile"
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-patch.sh b/tg-patch.sh
index 97338ab..220a0b0 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -44,3 +44,5 @@ echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(git cat-file blob "$name:.topdeps" | paste -s -d' '))"
 branch_contains "$name" "$base_rev" ||
 	echo "tg: The patch is out-of-date wrt. the base! Run \`$tg update\`."
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-remote.sh b/tg-remote.sh
index 4f60c73..2a9c4a0 100644
--- a/tg-remote.sh
+++ b/tg-remote.sh
@@ -59,3 +59,5 @@ git for-each-ref "refs/remotes/$name/top-bases" |
 
 git config "topgit.remote" "$name"
 info "The remote '$name' is now the default source of topic branches."
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-summary.sh b/tg-summary.sh
index 3c90a6b..c165d19 100644
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -98,3 +98,5 @@ git for-each-ref refs/top-bases |
 if [ -n "$graphviz" ]; then
 	echo '}'
 fi
+
+# vim:sw=8:ts=8:noet
diff --git a/tg-update.sh b/tg-update.sh
index 040800d..1114b7d 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -142,3 +142,5 @@ if ! git merge "$merge_with"; then
 	fi
 	exit 3
 fi
+
+# vim:sw=8:ts=8:noet
diff --git a/tg.sh b/tg.sh
index 4dcc15e..137fef4 100644
--- a/tg.sh
+++ b/tg.sh
@@ -283,3 +283,5 @@ help|--help|-h)
 	}
 	. "@cmddir@"/tg-$cmd;;
 esac
+
+# vim:sw=8:ts=8:noet
-- 
tg: (f17218e..) features/vim-modelines (depends on: upstream)
