From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: include 'merge.branchdesc' for merge and config as well
Date: Wed, 27 May 2015 23:52:23 +0200
Message-ID: <1432763543-3168-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjGe-000652-PW
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbE0Vxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 17:53:33 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38666 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbbE0Vxd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 17:53:33 -0400
Received: from x590c2e9c.dyn.telefonica.de ([89.12.46.156] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1YxjGR-0004g7-IP; Wed, 27 May 2015 23:53:30 +0200
X-Mailer: git-send-email 2.4.2.349.g6883b65
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1432763610.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270104>

'merge.branchdesc' is only mentioned in the docs of 'git fmt-merge-msg'=
=2E

The description of 'merge.log' is already duplicated between
'merge-config.txt' and 'git-fmt-merge-msg.txt'; instead of duplicating =
the
description of another config variable, extract the descriptions of bot=
h
of these variables from 'git-fmt-merge-msg.txt' into a separate file an=
d
include it there and in 'merge-config.txt'.

Leave 'merge.summary' only in git-fmt-merge-msg.txt, as it is marked fo=
r
deprecation.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/fmt-merge-msg-config.txt | 10 ++++++++++
 Documentation/git-fmt-merge-msg.txt    | 12 +-----------
 Documentation/merge-config.txt         |  6 +-----
 3 files changed, 12 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/fmt-merge-msg-config.txt

diff --git a/Documentation/fmt-merge-msg-config.txt b/Documentation/fmt=
-merge-msg-config.txt
new file mode 100644
index 0000000000..c73cfa90b7
--- /dev/null
+++ b/Documentation/fmt-merge-msg-config.txt
@@ -0,0 +1,10 @@
+merge.branchdesc::
+	In addition to branch names, populate the log message with
+	the branch description text associated with them.  Defaults
+	to false.
+
+merge.log::
+	In addition to branch names, populate the log message with at
+	most the specified number of one-line descriptions from the
+	actual commits that are being merged.  Defaults to false, and
+	true is a synonym for 20.
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fm=
t-merge-msg.txt
index bb1232a52c..55a9a4b93a 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -51,17 +51,7 @@ OPTIONS
=20
 CONFIGURATION
 -------------
-
-merge.branchdesc::
-	In addition to branch names, populate the log message with
-	the branch description text associated with them.  Defaults
-	to false.
-
-merge.log::
-	In addition to branch names, populate the log message with at
-	most the specified number of one-line descriptions from the
-	actual commits that are being merged.  Defaults to false, and
-	true is a synonym for 20.
+include::fmt-merge-msg-config.txt[]
=20
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 8a0e52f8ee..002ca58c21 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -26,11 +26,7 @@ merge.ff::
 	allowed (equivalent to giving the `--ff-only` option from the
 	command line).
=20
-merge.log::
-	In addition to branch names, populate the log message with at
-	most the specified number of one-line descriptions from the
-	actual commits that are being merged.  Defaults to false, and
-	true is a synonym for 20.
+include::fmt-merge-msg-config.txt[]
=20
 merge.renameLimit::
 	The number of files to consider when performing rename detection
--=20
2.4.2.349.g6883b65
