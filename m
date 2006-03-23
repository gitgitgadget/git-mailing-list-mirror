From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] doc: add clarification of existing GPLv2 license terms to manual pages
Date: Thu, 23 Mar 2006 13:58:50 +1200
Message-ID: <20060323015847.4624.61707.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Thu Mar 23 02:59:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMF6r-0002st-4w
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCWB7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWCWB7D
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:59:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:33157 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932391AbWCWB7B
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 20:59:01 -0500
Received: by watts.utsl.gen.nz (Postfix, from userid 1003)
	id BF63D5260; Thu, 23 Mar 2006 13:58:50 +1200 (NZST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17846>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Licensing code under the GPL, rather than, say, the Lesser GPL, means
that your intention is that all code that uses it as a library must
also be GPL compatible.

One problem with the GPLv2 is that it is quite vague on when a license
propagates to a piece of code that uses it, and when it does not.

For instance, if you take a GPL library and export its API via the
network, code that uses that API on the other end of the network must
be under a GPL compatible license.  Any program, whether it is a
command line tool or a network oriented API, that simply wraps a
library function does not detract from the fact that you are wrapping
a library function - you cannot circumvent the GPL this easily,
otherwise the GPL would be worthless.

The GPLv3 is less ambiguous on these things, but a decision on the use
of GPLv3 has already been deferred.

Normally this is an easy question, with one rule of thumb is the
'using as a program implies not a library'.  However, most of git's
core library functions have been developed as standalone binaries.

So, we add clarification to a handful of tools on a per-tool basis.
The overall position is that the requirements of the GPL license
propagate to the programs that are internal tools, whether they are
libified or not.  For instance 'git-status', 'git-checkout' and
'git-pull' are considered programs, but 'git-cat-file',
'git-merge-octopus' and 'git-hash-object' are considered library
functions.

Note that we are not making any new licensing decisions here; just
clarifying the existing terms under which people have been
contributing code so far.  For those undocumented commands (like
git-merge-octopus), no particular clarification is offered, but this
patch adds plenty of comparable clarifications, which still helps
those building tools that use or are based around git know whether
their product will be encumbered by the GPL or not.
---

 Documentation/git-add.txt                |    4 ++++
 Documentation/git-am.txt                 |    4 ++++
 Documentation/git-apply.txt              |    4 ++++
 Documentation/git-applymbox.txt          |    4 ++++
 Documentation/git-applypatch.txt         |    4 ++++
 Documentation/git-archimport.txt         |    4 ++++
 Documentation/git-bisect.txt             |    4 ++++
 Documentation/git-branch.txt             |    4 ++++
 Documentation/git-cat-file.txt           |    4 ++++
 Documentation/git-check-ref-format.txt   |    4 ++++
 Documentation/git-checkout-index.txt     |    3 +++
 Documentation/git-checkout.txt           |    8 ++++++++
 Documentation/git-cherry-pick.txt        |    4 ++++
 Documentation/git-cherry.txt             |    4 ++++
 Documentation/git-clone-pack.txt         |    4 ++++
 Documentation/git-clone.txt              |    4 ++++
 Documentation/git-commit-tree.txt        |    4 ++++
 Documentation/git-commit.txt             |    4 ++++
 Documentation/git-convert-objects.txt    |    4 ++++
 Documentation/git-count-objects.txt      |    4 ++++
 Documentation/git-cvsexportcommit.txt    |    4 ++++
 Documentation/git-cvsimport.txt          |    4 ++++
 Documentation/git-cvsserver.txt          |    4 ++++
 Documentation/git-daemon.txt             |   12 ++++++++++++
 Documentation/git-describe.txt           |    4 ++++
 Documentation/git-diff-files.txt         |    4 ++++
 Documentation/git-diff-index.txt         |    4 ++++
 Documentation/git-diff-stages.txt        |    4 ++++
 Documentation/git-diff-tree.txt          |    4 ++++
 Documentation/git-diff.txt               |    4 ++++
 Documentation/git-fetch-pack.txt         |    4 ++++
 Documentation/git-fetch.txt              |    4 ++++
 Documentation/git-fmt-merge-msg.txt      |    4 ++++
 Documentation/git-format-patch.txt       |    4 ++++
 Documentation/git-fsck-objects.txt       |    4 ++++
 Documentation/git-get-tar-commit-id.txt  |    4 ++++
 Documentation/git-grep.txt               |    4 ++++
 Documentation/git-hash-object.txt        |    4 ++++
 Documentation/git-http-fetch.txt         |    4 ++++
 Documentation/git-http-push.txt          |    4 ++++
 Documentation/git-index-pack.txt         |    4 ++++
 Documentation/git-init-db.txt            |    4 ++++
 Documentation/git-local-fetch.txt        |    4 ++++
 Documentation/git-log.txt                |    4 ++++
 Documentation/git-lost-found.txt         |    3 +++
 Documentation/git-ls-files.txt           |    4 ++++
 Documentation/git-ls-remote.txt          |    4 ++++
 Documentation/git-ls-tree.txt            |    4 ++++
 Documentation/git-mailinfo.txt           |    4 ++++
 Documentation/git-mailsplit.txt          |    4 ++++
 Documentation/git-merge-base.txt         |    4 ++++
 Documentation/git-merge-index.txt        |    4 ++++
 Documentation/git-merge-one-file.txt     |    4 ++++
 Documentation/git-merge.txt              |    4 ++++
 Documentation/git-mktag.txt              |    4 ++++
 Documentation/git-mv.txt                 |    4 ++++
 Documentation/git-name-rev.txt           |    4 ++++
 Documentation/git-pack-objects.txt       |    4 ++++
 Documentation/git-pack-redundant.txt     |    4 ++++
 Documentation/git-parse-remote.txt       |    4 ++++
 Documentation/git-patch-id.txt           |    4 ++++
 Documentation/git-peek-remote.txt        |    4 ++++
 Documentation/git-prune-packed.txt       |    4 ++++
 Documentation/git-prune.txt              |    4 ++++
 Documentation/git-pull.txt               |    4 ++++
 Documentation/git-push.txt               |    4 ++++
 Documentation/git-read-tree.txt          |    4 ++++
 Documentation/git-rebase.txt             |    4 ++++
 Documentation/git-receive-pack.txt       |    4 ++++
 Documentation/git-relink.txt             |    4 ++++
 Documentation/git-repack.txt             |    4 ++++
 Documentation/git-repo-config.txt        |    4 ++++
 Documentation/git-request-pull.txt       |    4 ++++
 Documentation/git-rerere.txt             |    4 ++++
 Documentation/git-reset.txt              |    4 ++++
 Documentation/git-resolve.txt            |    4 ++++
 Documentation/git-rev-list.txt           |    4 ++++
 Documentation/git-rev-parse.txt          |    4 ++++
 Documentation/git-revert.txt             |    4 ++++
 Documentation/git-send-email.txt         |    4 ++++
 Documentation/git-send-pack.txt          |    4 ++++
 Documentation/git-sh-setup.txt           |    4 ++++
 Documentation/git-shell.txt              |    4 ++++
 Documentation/git-shortlog.txt           |    4 ++++
 Documentation/git-show-branch.txt        |    4 ++++
 Documentation/git-show-index.txt         |    4 ++++
 Documentation/git-show.txt               |    4 ++++
 Documentation/git-ssh-fetch.txt          |    4 ++++
 Documentation/git-ssh-upload.txt         |    4 ++++
 Documentation/git-status.txt             |    4 ++++
 Documentation/git-stripspace.txt         |    4 ++++
 Documentation/git-svnimport.txt          |    4 ++++
 Documentation/git-symbolic-ref.txt       |    4 ++++
 Documentation/git-tag.txt                |    4 ++++
 Documentation/git-tar-tree.txt           |    5 +++++
 Documentation/git-unpack-file.txt        |    4 ++++
 Documentation/git-unpack-objects.txt     |    4 ++++
 Documentation/git-update-index.txt       |   18 ++++++++++++++++++
 Documentation/git-update-ref.txt         |    4 ++++
 Documentation/git-update-server-info.txt |    4 ++++
 Documentation/git-upload-pack.txt        |    4 ++++
 Documentation/git-var.txt                |    4 ++++
 Documentation/git-verify-pack.txt        |    4 ++++
 Documentation/git-verify-tag.txt         |    4 ++++
 Documentation/git-whatchanged.txt        |    4 ++++
 Documentation/git-write-tree.txt         |    4 ++++
 106 files changed, 449 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index ae24547..908fd6c 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -77,6 +77,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-add implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 910457d..4e0037b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -96,6 +96,10 @@ Documentation
 --------------
 Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-am implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 1c64a1a..d26f051 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -135,6 +135,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano
 
+Linking Information
+-------------------
+Use of the git-apply implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
index f74c6a4..3315fd8 100644
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -86,6 +86,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-applymbox implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
index 2b1ff14..e2e9f08 100644
--- a/Documentation/git-applypatch.txt
+++ b/Documentation/git-applypatch.txt
@@ -44,6 +44,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-apply implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 5a13187..47336b4 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -100,6 +100,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano, Martin Langhoff and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-archimport implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ac4b496..a087fa6 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -130,6 +130,10 @@ Documentation
 -------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-bisect implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 71ecd85..c8d027f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -73,6 +73,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-branch implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 504eb1b..55012c3 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -61,6 +61,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-cat-file implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 7dc1bdb..9393990 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -46,6 +46,10 @@ refname expressions (see gitlink:git-rev
 . colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
   value and store it in dstref" in fetch and push operations.
 
+Linking Information
+-------------------
+Use of the git-check-ref-format implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 
 GIT
 ---
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 09bd6a5..10704fc 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -178,6 +178,9 @@ Documentation
 Documentation by David Greaves,
 Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-checkout-index implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
 
 GIT
 ---
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 985bb2f..22755b8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -138,10 +138,18 @@ Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
+License Implications
+--------------------
+Use of the git-checkout program does NOT constitute 
+
 Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-checkout implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bfa950c..3ac1600 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -54,6 +54,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-cherry-pick implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 9a5e371..b65db2f 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -36,6 +36,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-cherry implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
index 09f43ee..7f6a850 100644
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -57,6 +57,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-clone implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 
 GIT
 ---
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9ac54c2..50ec673 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -136,6 +136,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-clone implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 
 GIT
 ---
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 41d1a1c..27b3d12 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -94,6 +94,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-commit-tree implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d04b342..2bf2477 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -141,6 +141,10 @@ Author
 Written by Linus Torvalds <torvalds@osdl.org> and
 Junio C Hamano <junkio@cox.net>
 
+Linking Information
+-------------------
+Use of the git-commit implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 
 GIT
 ---
diff --git a/Documentation/git-convert-objects.txt b/Documentation/git-convert-objects.txt
index b1220c0..8bb7e2f 100644
--- a/Documentation/git-convert-objects.txt
+++ b/Documentation/git-convert-objects.txt
@@ -23,6 +23,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-convert-objects implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 47216f4..4c27d97 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -22,6 +22,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-count-objects implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index d30435a..081d14d 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -70,6 +70,10 @@ Documentation
 --------------
 Documentation by Martin Langhoff <martin@catalyst.net.nz>
 
+Linking Information
+-------------------
+Use of the git-cvsexportcommit implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b0c6d7c..32798b6 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -135,6 +135,10 @@ Documentation
 --------------
 Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
 
+Linking Information
+-------------------
+Use of the git-cvsimport implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4dc13c3..0e0be49 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -143,6 +143,10 @@ Documentation
 --------------
 Documentation by Martyn Smith <martyn@catalyst.net.nz> and Martin Langhoff <martin@catalyst.net.nz> Matthias Urlichs <smurf@smurf.noris.de>.
 
+Linking Information
+-------------------
+The situation with the git CVS server is much the same as git-daemon.  However, most of the CVS protocol cannot be said to be "internal functions", as the CVS protocol is a fairly simple translation of CVS commands to a network pipe. 
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 924a676..c3e1363 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -96,6 +96,18 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+This is not a command line access to a library function as other programs, rather it is a daemon which offers parts of the git API over the network.
+
+Currently no special GPL exception is granted to reimplementations of the git protocol that deal with non user-interface functions.  As many methods of the git network protocol requires the ability to request packs - an internal API function - currently accessing git repositories over a network requires the freedoms granted by the GPL to hold for those programs.
+
+So, for instance, a reimplementation of `git-ls-remote' would not be required to be Free Software, but a reimplementation of `git-send-pack' would.  Even a complete reimplementation of `git-clone', a user interface program, would be required to be Free Software - as by necessity it must speak to internal git API functions that are exported over the network.
+
+Note that the only impact of this is that you cannot sell or give away software to people that directly uses any of the internal API methods of git via the git protocol (as documented on their corresponding manual page), unless you can also give them the source code to the application that you use for this if they ask, unencumbered from restrictions as required by the GPL.  A re-implementation designed to be Free Software under a non-copyleft license, such as the BSD license with the ''obnoxious advertising clause'' removed, is acceptable, and may only be linked with a non-free program if the logical interface it presents to the git repository that was not based around the git internal API.
+
+Accessing git repositories via HTTP does not pose this 'problem', for instance.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7a253ea..45e905e 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -73,6 +73,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-describe implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 481b8b3..ba2ccef 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -52,6 +52,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-diff-files implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 5d2096a..106a6b3 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -127,6 +127,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-diff-index implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff-stages.txt b/Documentation/git-diff-stages.txt
index 3273918..6612cb9 100644
--- a/Documentation/git-diff-stages.txt
+++ b/Documentation/git-diff-stages.txt
@@ -35,6 +35,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-diff-stages implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 9153e4c..a4cf85f 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -156,6 +156,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-diff-tree implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 890931c..483d05e 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -110,6 +110,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-diff implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index bff9aa6..ca781e8 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -68,6 +68,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-fetch-pack implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index a9e86fd..38f5c3d 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -43,6 +43,10 @@ Documentation
 -------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-fetch implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a70eb39..e18edfe 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -33,6 +33,10 @@ Documentation
 --------------
 Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-format-patch implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 7cc7faf..8237fb0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -109,6 +109,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-format-patch implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
index 93ce9dc..da5729a 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -133,6 +133,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-fsck-objects implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 48805b6..266fb8e 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -31,6 +31,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-get-tar-commit-id implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fbd2394..a1287fe 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -50,6 +50,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-grep implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 04e8d00..fd4b7ca 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -40,6 +40,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-hash-object implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index bc1a132..8b5a990 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -41,6 +41,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-http-fetch implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 7e1f894..e009d2c 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -84,6 +84,10 @@ Documentation
 --------------
 Documentation by Nick Hengeveld
 
+Linking Information
+-------------------
+Use of the git-http-push implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 71ce557..94bb0da 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -38,6 +38,10 @@ Documentation
 -------------
 Documentation by Sergey Vlasov
 
+Linking Information
+-------------------
+Use of the git-index-pack implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index aeb1115..96007c2 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -76,6 +76,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-init-db implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index 87abec1..4c13efe 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -37,6 +37,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-local-fetch implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e995d1b..6f8fe1a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,6 +56,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-log implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-found.txt
index f52a9d7..ef2a075 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -72,6 +72,9 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-lost-found implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
 
 GIT
 ---
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e813f84..1d33050 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -228,6 +228,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-ls-files implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ae4c1a2..3870ab2 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -57,6 +57,10 @@ Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
 
+Linking Information
+-------------------
+Use of the git-ls-remote implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 5bf6d8b..d624b21 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -67,6 +67,10 @@ Documentation by David Greaves, Junio C 
 
 This manual page is a stub. You can help the git documentation by expanding it.
 
+Linking Information
+-------------------
+Use of the git-ls-tree implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ea0a065..92dea69 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -66,6 +66,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-mailinfo implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 209e36b..8bb1ff6 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -46,6 +46,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-mailsplit implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index d1d56f1..d3d5eb0 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -27,6 +27,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-merge-base implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index fbc986a..80b7a28 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -82,6 +82,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-merge-index implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index 86aad37..4b4259f 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -24,6 +24,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-merge-one-file implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4ce799b..3c3a4ee 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -153,6 +153,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-merge implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 2860a3d..0f30a86 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -41,6 +41,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-mktag implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 207c43a..a320ff1 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -48,6 +48,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-mv implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 6870708..6245e3c 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -60,6 +60,10 @@ Documentation
 --------------
 Documentation by Johannes Schindelin.
 
+Linking Information
+-------------------
+Use of the git-name-rev implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 4991f88..e31efa0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -106,6 +106,10 @@ See Also
 gitlink:git-repack[1]
 gitlink:git-prune-packed[1]
 
+Linking Information
+-------------------
+Use of the git-pack-redundant implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index 8fb0659..0015577 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -52,6 +52,10 @@ gitlink:git-pack-objects[1]
 gitlink:git-repack[1]
 gitlink:git-prune-packed[1]
 
+Linking Information
+-------------------
+Use of the git-pack-redundant implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index fc27afe..3aedc73 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -43,6 +43,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-parse-remotes implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 723b8cc..b6bdeb2 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -37,6 +37,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-patch-id implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
index a00060c..33d3d83 100644
--- a/Documentation/git-peek-remote.txt
+++ b/Documentation/git-peek-remote.txt
@@ -46,6 +46,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-peek-remote implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 2348826..05f0c52 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -45,6 +45,10 @@ See Also
 gitlink:git-pack-objects[1]
 gitlink:git-repack[1]
 
+Linking Information
+-------------------
+Use of the git-prune-packed implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f694fcb..2c01528 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -55,6 +55,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-prune implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 51577fc..8710607 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -126,6 +126,10 @@ Documentation by Jon Loeliger,
 David Greaves,
 Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-pull implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d5b5ca1..bc4f8bb 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -81,6 +81,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-push implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 844cfda..54c409b 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -317,6 +317,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-read-tree implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b36276c..37a79e2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -69,6 +69,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-rebase implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 60debca..2cc1f5c 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -94,6 +94,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-relink implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index aca6012..bd35ee1 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -31,6 +31,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-relink implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d2f9a44..2be4c3a 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -68,6 +68,10 @@ See Also
 gitlink:git-pack-objects[1]
 gitlink:git-prune-packed[1]
 
+Linking Information
+-------------------
+Use of the git-repack implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 26759a8..1cb3eb8 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -171,6 +171,10 @@ Documentation
 --------------
 Documentation by Johannes Schindelin.
 
+Linking Information
+-------------------
+Use of the git-repo-config implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 478a5fd..6c81e0b 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -34,6 +34,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-request-pull implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 8b6b651..bdf2943 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -172,6 +172,10 @@ Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
 
+Linking Information
+-------------------
+Use of the git-rerere implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b7b9798..35b67e0 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -179,6 +179,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-reset implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-resolve.txt b/Documentation/git-resolve.txt
index 4e57c2b..5bf6f7f 100644
--- a/Documentation/git-resolve.txt
+++ b/Documentation/git-resolve.txt
@@ -30,6 +30,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-resolve implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 8255ae1..bf658a7 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -110,6 +110,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-rev-list implementation this manual page documents constitutes deriving under section 2.b of the GPL, but only when used with the `--objects-edge' option.  Use of the command without this option does not consititute deriving in this manner.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8b95df0..164312b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -181,6 +181,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-rev-parse implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 71f7815..bb27c42 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -51,6 +51,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-revert implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8c58685..6a0171b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -88,6 +88,10 @@ Documentation
 --------------
 Documentation by Ryan Anderson
 
+Linking Information
+-------------------
+Use of the git-send-email implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 08e0705..72f08de 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -105,6 +105,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-send-pack implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 6742c9b..22bd477 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -29,6 +29,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-sh-setup implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index cc4266d..8b63294 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -29,6 +29,10 @@ Documentation
 --------------
 Documentation by Petr Baudis and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-shell implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 54fb922..04939cb 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -24,6 +24,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-shortlog implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index f115b45..eb757a2 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -156,6 +156,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-show-branch implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 
 GIT
 ---
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index be09b62..20050e3 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -29,6 +29,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano
 
+Linking Information
+-------------------
+Use of the git-show-index implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b4df3f..9e5da1c 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -43,6 +43,10 @@ Documentation by David Greaves, Petr Bau
 
 This manual page is a stub. You can help the git documentation by expanding it.
 
+Linking Information
+-------------------
+Use of the git-show implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
index b7116b3..5780278 100644
--- a/Documentation/git-ssh-fetch.txt
+++ b/Documentation/git-ssh-fetch.txt
@@ -45,6 +45,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-ssh-fetch implementation this manual page documents constitutes deriving under section 2.b of the GPL.  See `git-pull' and `git-fetch' for an interface to this operation that does not.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
index 702674e..39bca11 100644
--- a/Documentation/git-ssh-upload.txt
+++ b/Documentation/git-ssh-upload.txt
@@ -41,6 +41,10 @@ Documentation
 --------------
 Documentation by Daniel Barkalow
 
+Linking Information
+-------------------
+Use of the git-ssh-upload implementation this manual page documents constitutes deriving under section 2.b of the GPL.  See `git-push' for an interface to this operation that does not.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e446f48..eef8082 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -39,6 +39,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-status implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 3a03dd0..53d9c77 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -27,6 +27,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-stripspace implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index b1b87c2..9063762 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -154,6 +154,10 @@ Documentation
 --------------
 Documentation by Matthias Urlichs <smurf@smurf.noris.de>.
 
+Linking Information
+-------------------
+Use of the git-svnimport implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 68ac6a6..817825c 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -47,6 +47,10 @@ Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
 
+Linking Information
+-------------------
+Use of the git-symbolic-ref implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 45476c2..d25573d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -70,6 +70,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-unpack-file implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 2139b6f..06f50e4 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -32,6 +32,11 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-tar-tree implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index 213dc81..d99c573 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -30,6 +30,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-unpack-file implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 1828062..3c410dc 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -36,6 +36,10 @@ Documentation
 -------------
 Documentation by Junio C Hamano
 
+Linking Information
+-------------------
+Use of the git-unpack-objects implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 0a1b0ad..0150f92 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -305,6 +305,24 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-update-index implementation this manual page documents constitutes deriving under section 2.b of the GPL, unless only a selection of the following options are used:
+
+  --refresh
+  -q
+  --unmerged
+  --ignore-missing
+  --chmod
+  --assume-unchanged
+  --no-assume-unchanged
+  --force-remove
+  --replace
+  --stdin
+  --verbose
+  -z
+  --
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 475237f..88bd9c8 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -53,6 +53,10 @@ Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>.
 
+Linking Information
+-------------------
+Use of the git-update-ref implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 88a03c7..2b34411 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -52,6 +52,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-update-server-info implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 4795e98..6986faf 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -34,6 +34,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano.
 
+Linking Information
+-------------------
+Use of the git-upload-pack implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 90cb157..8107975 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -55,6 +55,10 @@ Documentation
 --------------
 Documentation by Eric Biederman and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-var implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 4962d69..2cd65d7 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -48,6 +48,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano
 
+Linking Information
+-------------------
+Use of the git-verify-pack implementation this manual page documents constitutes deriving under section 2.b of the GPL.  Use `git-fsck-objects' for an interface to this operation that does not constitute linking.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0f9bdb5..d0965f7 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -26,6 +26,10 @@ Documentation
 --------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-verify-tag implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index f02f939..7998835 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -75,6 +75,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-whatchanged implementation this manual page documents does not constitute deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index 77e12cb..bf71bfa 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -38,6 +38,10 @@ Documentation
 --------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
+Linking Information
+-------------------
+Use of the git-write-tree implementation this manual page documents constitutes deriving under section 2.b of the GPL.
+
 GIT
 ---
 Part of the gitlink:git[7] suite
