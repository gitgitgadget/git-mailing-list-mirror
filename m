From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Ship sample hooks with .sample suffix
Date: Tue, 24 Jun 2008 19:09:03 -0700
Message-ID: <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
 <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Holtje <docwhat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 04:10:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBKSc-00045R-2T
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 04:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYFYCJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 22:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYFYCJR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 22:09:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYFYCJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 22:09:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6402116523;
	Tue, 24 Jun 2008 22:09:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 98B9E1651F; Tue, 24 Jun 2008 22:09:07 -0400 (EDT)
In-Reply-To: <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 Jun 2008 16:59:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5688382-425B-11DD-A804-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86195>

We used to mark hooks we ship as samples by making them unexecutable, but
some filesystems cannot tell what is executable and what is not.

This makes it much more explicit.  The hooks are suffixed with .sample
(but now are made executable), so enabling it is still one step operation
(instead of "chmod +x $hook", you would do "mv $hook.sample $hook") but
now they won't get accidentally enabled on systems without executable bit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is for actual application.  Hopefully I got all the "to enable
   this hook, make it executable" in the samples right.

 Documentation/githooks.txt                         |    3 ++-
 ...applypatch-msg => hooks--applypatch-msg.sample} |    2 +-
 ...{hooks--commit-msg => hooks--commit-msg.sample} |    2 +-
 ...ooks--post-commit => hooks--post-commit.sample} |    2 +-
 ...ks--post-receive => hooks--post-receive.sample} |   13 ++++++-------
 ...ooks--post-update => hooks--post-update.sample} |    2 +-
 ...pre-applypatch => hooks--pre-applypatch.sample} |    2 +-
 ...{hooks--pre-commit => hooks--pre-commit.sample} |    2 +-
 ...{hooks--pre-rebase => hooks--pre-rebase.sample} |    0
 ...commit-msg => hooks--prepare-commit-msg.sample} |    2 +-
 templates/{hooks--update => hooks--update.sample}  |    2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)
 rename templates/{hooks--applypatch-msg => hooks--applypatch-msg.sample} (86%)
 mode change 100644 => 100755
 rename templates/{hooks--commit-msg => hooks--commit-msg.sample} (93%)
 mode change 100644 => 100755
 rename templates/{hooks--post-commit => hooks--post-commit.sample} (63%)
 mode change 100644 => 100755
 rename templates/{hooks--post-receive => hooks--post-receive.sample} (40%)
 mode change 100644 => 100755
 rename templates/{hooks--post-update => hooks--post-update.sample} (63%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-applypatch => hooks--pre-applypatch.sample} (84%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-commit => hooks--pre-commit.sample} (96%)
 mode change 100644 => 100755
 rename templates/{hooks--pre-rebase => hooks--pre-rebase.sample} (100%)
 mode change 100644 => 100755
 rename templates/{hooks--prepare-commit-msg => hooks--prepare-commit-msg.sample} (94%)
 mode change 100644 => 100755
 rename templates/{hooks--update => hooks--update.sample} (97%)
 mode change 100644 => 100755

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4f06ae0..262a4f1 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -17,7 +17,8 @@ Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
 `git-init` is run, a handful example hooks are copied in the
 `hooks` directory of the new repository, but by default they are
-all disabled.  To enable a hook, make it executable with `chmod +x`.
+all disabled.  To enable a hook, rename it by removing its `.sample`
+suffix.
 
 This document describes the currently defined hooks.
 
diff --git a/templates/hooks--applypatch-msg b/templates/hooks--applypatch-msg.sample
old mode 100644
new mode 100755
similarity index 86%
rename from templates/hooks--applypatch-msg
rename to templates/hooks--applypatch-msg.sample
index 02de1ef..8b2a2fe
--- a/templates/hooks--applypatch-msg
+++ b/templates/hooks--applypatch-msg.sample
@@ -7,7 +7,7 @@
 # appropriate message if it wants to stop the commit.  The hook is
 # allowed to edit the commit message file.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "applypatch-msg".
 
 . git-sh-setup
 test -x "$GIT_DIR/hooks/commit-msg" &&
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg.sample
old mode 100644
new mode 100755
similarity index 93%
rename from templates/hooks--commit-msg
rename to templates/hooks--commit-msg.sample
index 4ef86eb..6ef1d29
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg.sample
@@ -6,7 +6,7 @@
 # status after issuing an appropriate message if it wants to stop the
 # commit.  The hook is allowed to edit the commit message file.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "commit-msg".
 
 # Uncomment the below to add a Signed-off-by line to the message.
 # Doing this in a hook is a bad idea in general, but the prepare-commit-msg
diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit.sample
old mode 100644
new mode 100755
similarity index 63%
rename from templates/hooks--post-commit
rename to templates/hooks--post-commit.sample
index 8be6f34..2266821
--- a/templates/hooks--post-commit
+++ b/templates/hooks--post-commit.sample
@@ -3,6 +3,6 @@
 # An example hook script that is called after a successful
 # commit is made.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "post-commit".
 
 : Nothing
diff --git a/templates/hooks--post-receive b/templates/hooks--post-receive.sample
old mode 100644
new mode 100755
similarity index 40%
rename from templates/hooks--post-receive
rename to templates/hooks--post-receive.sample
index b70c8fd..18d2e0f
--- a/templates/hooks--post-receive
+++ b/templates/hooks--post-receive.sample
@@ -1,16 +1,15 @@
 #!/bin/sh
 #
-# An example hook script for the post-receive event
+# An example hook script for the "post-receive" event.
 #
-# This script is run after receive-pack has accepted a pack and the
-# repository has been updated.  It is passed arguments in through stdin
-# in the form
+# The "post-receive" script is run after receive-pack has accepted a pack
+# and the repository has been updated.  It is passed arguments in through
+# stdin in the form
 #  <oldrev> <newrev> <refname>
 # For example:
 #  aa453216d1b3e49e7f6f98441fa56946ddcd6a20 68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
 #
-# see contrib/hooks/ for an sample, or uncomment the next line (on debian)
-#
-
+# see contrib/hooks/ for an sample, or uncomment the next line and
+# rename the file to "post-receive".
 
 #. /usr/share/doc/git-core/contrib/hooks/post-receive-email
diff --git a/templates/hooks--post-update b/templates/hooks--post-update.sample
old mode 100644
new mode 100755
similarity index 63%
rename from templates/hooks--post-update
rename to templates/hooks--post-update.sample
index bcba893..5323b56
--- a/templates/hooks--post-update
+++ b/templates/hooks--post-update.sample
@@ -3,6 +3,6 @@
 # An example hook script to prepare a packed repository for use over
 # dumb transports.
 #
-# To enable this hook, make this file executable by "chmod +x post-update".
+# To enable this hook, rename this file to "post-update".
 
 exec git-update-server-info
diff --git a/templates/hooks--pre-applypatch b/templates/hooks--pre-applypatch.sample
old mode 100644
new mode 100755
similarity index 84%
rename from templates/hooks--pre-applypatch
rename to templates/hooks--pre-applypatch.sample
index eeccc93..b1f187c
--- a/templates/hooks--pre-applypatch
+++ b/templates/hooks--pre-applypatch.sample
@@ -6,7 +6,7 @@
 # The hook should exit with non-zero status after issuing an
 # appropriate message if it wants to stop the commit.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "pre-applypatch".
 
 . git-sh-setup
 test -x "$GIT_DIR/hooks/pre-commit" &&
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit.sample
old mode 100644
new mode 100755
similarity index 96%
rename from templates/hooks--pre-commit
rename to templates/hooks--pre-commit.sample
index b25dce6..71c10f2
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit.sample
@@ -5,7 +5,7 @@
 # exit with non-zero status after issuing an appropriate message if
 # it wants to stop the commit.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "pre-commit".
 
 # This is slightly modified from Andrew Morton's Perfect Patch.
 # Lines you introduce should not have trailing whitespace.
diff --git a/templates/hooks--pre-rebase b/templates/hooks--pre-rebase.sample
old mode 100644
new mode 100755
similarity index 100%
rename from templates/hooks--pre-rebase
rename to templates/hooks--pre-rebase.sample
diff --git a/templates/hooks--prepare-commit-msg b/templates/hooks--prepare-commit-msg.sample
old mode 100644
new mode 100755
similarity index 94%
rename from templates/hooks--prepare-commit-msg
rename to templates/hooks--prepare-commit-msg.sample
index d3c1da3..aa42acf
--- a/templates/hooks--prepare-commit-msg
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -7,7 +7,7 @@
 # message file.  If the hook fails with a non-zero status,
 # the commit is aborted.
 #
-# To enable this hook, make this file executable.
+# To enable this hook, rename this file to "prepare-commit-msg".
 
 # This hook includes three examples.  The first comments out the
 # "Conflicts:" part of a merge commit.
diff --git a/templates/hooks--update b/templates/hooks--update.sample
old mode 100644
new mode 100755
similarity index 97%
rename from templates/hooks--update
rename to templates/hooks--update.sample
index 4b69268..93c6055
--- a/templates/hooks--update
+++ b/templates/hooks--update.sample
@@ -3,7 +3,7 @@
 # An example hook script to blocks unannotated tags from entering.
 # Called by git-receive-pack with arguments: refname sha1-old sha1-new
 #
-# To enable this hook, make this file executable by "chmod +x update".
+# To enable this hook, rename this file to "update".
 #
 # Config
 # ------
-- 
1.5.6.56.g29b0d
