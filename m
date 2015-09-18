From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] Documentation: make explicit that optional arguments must be stuck
Date: Fri, 18 Sep 2015 17:01:50 +0200
Message-ID: <1442588510-7379-4-git-send-email-Matthieu.Moy@imag.fr>
References: <20150917174306.GA29171@sigill.intra.peff.net>
 <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 17:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcxLO-0007tb-DC
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbbIRPLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:11:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36106 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbbIRPCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:02:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1uHo031176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 17:01:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1wtM014919;
	Fri, 18 Sep 2015 17:01:58 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZcxAk-00023s-Jc; Fri, 18 Sep 2015 17:01:58 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 17:01:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IF1uHo031176
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443193319.24002@KXWWEp7TH86xbLYiiorubw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278198>

The behavior of command-line options with optional arguments is
documented in gitcli(7), but it is easy for users to miss, and hard for
the same user to understand why e.g. "git status -u no" does not work.

Document this explicitly in the documentation of each short option having
an optional argument: they are the most error prone since there is no '='
sign between the option and its argument.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-am.txt          | 3 ++-
 Documentation/git-cherry-pick.txt | 3 ++-
 Documentation/git-commit-tree.txt | 3 ++-
 Documentation/git-commit.txt      | 3 ++-
 Documentation/git-grep.txt        | 4 +++-
 Documentation/git-merge.txt       | 4 +++-
 Documentation/git-rebase.txt      | 3 ++-
 Documentation/git-revert.txt      | 3 ++-
 Documentation/git-status.txt      | 5 +++--
 9 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index dbea6e7..5f0082e 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -141,7 +141,8 @@ default.   You can use `--no-utf8` to override this.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commits.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 --continue::
 -r::
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 83b3cc2..383f57d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -103,7 +103,8 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commits.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 --ff::
 	If the current HEAD is the same as the parent of the
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index f5f2a8d..da2f359 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -56,7 +56,8 @@ OPTIONS
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commit.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 --no-gpg-sign::
 	Countermand `commit.gpgSign` configuration variable that is
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 904dafa..99fab5f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -314,7 +314,8 @@ changes to tracked files.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commit.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 --no-gpg-sign::
 	Countermand `commit.gpgSign` configuration variable that is
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 1c07c7f..563d011 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -165,7 +165,9 @@ OPTIONS
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
-	the first match automatically.
+	the first match automatically. The `pager` argument is
+	optional; if specified, it must be stuck to the option
+	without a space.
 
 -z::
 --null::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a62d672..8543d88 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -67,7 +67,9 @@ include::merge-options.txt[]
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign the resulting merge commit.
+	GPG-sign the resulting merge commit. The `keyid` argument is
+	optional; if specified, it must be stuck to the option
+	without a space.
 
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ca03954..1894431 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -294,7 +294,8 @@ which makes little sense.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commits.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 -q::
 --quiet::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 6388089..cdc3588 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -82,7 +82,8 @@ effect to your index in a row.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-	GPG-sign commits.
+	GPG-sign commits. The `keyid` argument is optional; if
+	specified, it must be stuck to the option without a space.
 
 -s::
 --signoff::
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 335f312..e1e8f57 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -53,8 +53,9 @@ OPTIONS
 --untracked-files[=<mode>]::
 	Show untracked files.
 +
-The mode parameter is optional (defaults to 'all'), and is used to
-specify the handling of untracked files.
+The mode parameter is used to specify the handling of untracked files.
+It is optional: it defaults to 'all', and if specified, it must be
+stuck to the option (e.g. `-uno`, but not `-u no`).
 +
 The possible options are:
 +
-- 
2.5.0.402.g8854c44
