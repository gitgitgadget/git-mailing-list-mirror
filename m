From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 09/12] fmt-merge-msg: mark summary-related option and
	config variable as deprecated
Date: Wed, 16 Apr 2008 02:39:08 +0200
Message-ID: <1208306351-20922-10-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-8-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-9-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:27:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhs-0007aE-BD
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbYDPAjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756376AbYDPAja
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:56268 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbYDPAjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:25 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1JlvgG0nfO-0008Rv; Wed, 16 Apr 2008 02:39:20 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-9-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1+SdM/vJTzStpQElpo1hluAsFByF05OthmKgb4
 sH+59SVVTNUIGDRHYFSz+YIqHIVsw4C+JSJZMXt1d4tHvucl1O
 XK75zAiPJEitH5iEy8hNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-fmt-merge-msg.txt    |   16 +++++++++++-----
 Documentation/merge-config.txt         |    4 +++-
 builtin-fmt-merge-msg.c                |    2 +-
 contrib/completion/git-completion.bash |    1 -
 t/t6200-fmt-merge-msg.sh               |    2 +-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fm=
t-merge-msg.txt
index cd441c5..6e23e6c 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-git-fmt-merge-msg [--[no-]log | --[no-]summary] <$GIT_DIR/FETCH_HEAD
-git-fmt-merge-msg [--[no-]log | --[no-]summary] -F <file>
+git-fmt-merge-msg [--[no-]log] <$GIT_DIR/FETCH_HEAD
+git-fmt-merge-msg [--[no-]log] -F <file>
=20
 DESCRIPTION
 -----------
@@ -25,16 +25,20 @@ OPTIONS
 -------
=20
 --log::
---summary::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
 	merged.
=20
 --no-log::
---no-summary::
 	Do not list one-line descriptions from the actual commits being
 	merged.
=20
+--summary::
+	Deprecated equivalent of --log.
+
+--no-summary::
+	Deprecated equivalent of --no-log.
+
 --file <file>, -F <file>::
 	Take the list of merged objects from <file> instead of
 	stdin.
@@ -43,10 +47,12 @@ CONFIGURATION
 -------------
=20
 merge.log::
-merge.summary::
 	Whether to include summaries of merged commits in newly
 	merge commit messages. False by default.
=20
+merge.summary::
+	Deprecated equivalent of merge.log.
+
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 5000162..45b107d 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -6,10 +6,12 @@ merge.diffstat::
 	Deprecated equivalent of merge.stat.
=20
 merge.log::
-merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
=20
+merge.summary::
+	Deprecated equivalent of merge.log.
+
 merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 3df8ff8..d49f545 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -6,7 +6,7 @@
 #include "tag.h"
=20
 static const char *fmt_merge_msg_usage =3D
-	"git-fmt-merge-msg [--log | --summary] [--no-log | --no-summary] [--f=
ile <file>]";
+	"git-fmt-merge-msg [--log] [--no-log] [--file <file>]";
=20
 static int merge_summary;
=20
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index adc1a75..49ada35 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1025,7 +1025,6 @@ _git_config ()
 		merge.tool
 		merge.stat
 		merge.log
-		merge.summary
 		merge.verbosity
 		pack.window
 		pack.depth
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 20704eb..926ca50 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -177,7 +177,7 @@ test_expect_success 'merge-msg command line options=
 #2' '
 	git diff actual msg.left.log
 '
=20
-test_expect_success 'merge-msg command line options #3' '
+test_expect_success 'merge-msg deprecated command line options' '
 	git fmt-merge-msg --summary <.git/FETCH_HEAD >actual &&
 	git diff actual msg.left.log
 '
--=20
1.5.5.76.g546c
