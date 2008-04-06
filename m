From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/6] doc: moved merge.* config variables into separate
	merge-config.txt
Date: Sun,  6 Apr 2008 03:23:42 +0200
Message-ID: <1207445027-3152-2-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
	<1207445027-3152-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:24:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJch-0004gD-FV
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbYDFBYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 21:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYDFBYA
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:62531 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYDFBX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:23:59 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1JiJbr09Jm-0002QX; Sun, 06 Apr 2008 03:23:52 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <1207445027-3152-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/gDqxUN5I04zToC+sHJrlIJLNF8kTVNFgIUTv
 VgPDzk3HuDLXtrXfGbD3Sy59lkOkXX1w6PZ7b7541AZg0hqncz
 Y1mthnpmuvuw55uIdi/0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78875>

Include the new file from config.txt and git-merge.txt.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/config.txt       |   32 +-------------------------------
 Documentation/git-merge.txt    |   13 +------------
 Documentation/merge-config.txt |   31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/merge-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04c01c5..f009740 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -768,37 +768,7 @@ man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
=20
-merge.summary::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
-
-merge.tool::
-	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
-	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
-	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponing mergetool.<tool>.cmd option.
-
-merge.verbosity::
-	Controls the amount of output shown by the recursive merge
-	strategy.  Level 0 outputs nothing except a final error
-	message if conflicts were detected. Level 1 outputs only
-	conflicts, 2 outputs conflicts and file changes.  Level 5 and
-	above outputs debugging information.  The default is level 2.
-	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
-
-merge.<driver>.name::
-	Defines a human readable name for a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.driver::
-	Defines the command that implements a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
-
-merge.<driver>.recursive::
-	Names a low-level merge driver to be used when
-	performing an internal merge between common ancestors.
-	See linkgit:gitattributes[5] for details.
+include::merge-config.txt[]
=20
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..821e21b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -46,18 +46,7 @@ linkgit:git-reset[1].
=20
 CONFIGURATION
 -------------
-
-merge.summary::
-	Whether to include summaries of merged commits in newly
-	created merge commit. False by default.
-
-merge.verbosity::
-	Controls the amount of output shown by the recursive merge
-	strategy.  Level 0 outputs nothing except a final error
-	message if conflicts were detected. Level 1 outputs only
-	conflicts, 2 outputs conflicts and file changes.  Level 5 and
-	above outputs debugging information.  The default is level 2.
-	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
+include::merge-config.txt[]
=20
 branch.<name>.mergeoptions::
 	Sets default options for merging into branch <name>. The syntax and
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
new file mode 100644
index 0000000..cc815cc
--- /dev/null
+++ b/Documentation/merge-config.txt
@@ -0,0 +1,31 @@
+merge.summary::
+	Whether to include summaries of merged commits in newly created
+	merge commit messages. False by default.
+
+merge.tool::
+	Controls which merge resolution program is used by
+	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
+	"opendiff".  Any other value is treated is custom merge tool
+	and there must be a corresponing mergetool.<tool>.cmd option.
+
+merge.verbosity::
+	Controls the amount of output shown by the recursive merge
+	strategy.  Level 0 outputs nothing except a final error
+	message if conflicts were detected. Level 1 outputs only
+	conflicts, 2 outputs conflicts and file changes.  Level 5 and
+	above outputs debugging information.  The default is level 2.
+	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
+
+merge.<driver>.name::
+	Defines a human readable name for a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.driver::
+	Defines the command that implements a custom low-level
+	merge driver.  See linkgit:gitattributes[5] for details.
+
+merge.<driver>.recursive::
+	Names a low-level merge driver to be used when
+	performing an internal merge between common ancestors.
+	See linkgit:gitattributes[5] for details.
--=20
1.5.5.rc3.9.gba703
