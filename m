From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] Doc: Add a simplified help on top of the "History Simplification"
Date: Wed, 12 Nov 2008 11:51:28 +0100
Message-ID: <1226487088-5308-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 11:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0DLF-0005Us-QQ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbYKLKvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 05:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbYKLKvm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:51:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:1283 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYKLKvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 05:51:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so179082nfc.21
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 02:51:39 -0800 (PST)
Received: by 10.86.3.4 with SMTP id 4mr9092579fgc.44.1226487099261;
        Wed, 12 Nov 2008 02:51:39 -0800 (PST)
Received: from localhost (p5B0D5CF0.dip.t-dialin.net [91.13.92.240])
        by mx.google.com with ESMTPS id 12sm1948819fgg.0.2008.11.12.02.51.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Nov 2008 02:51:38 -0800 (PST)
X-Mailer: git-send-email 1.6.0.rc1.27.g9b6bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100740>

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi,

  This is conceptually on top of:

  [PATCH 2/2] Document "git log --simplify-by-decoration"

  from Nanako. I do not touch the detailed help, I only add a simplifie=
d one at the top.

  Santi

 Documentation/rev-list-options.txt |   48 ++++++++++++++++++++++++++++=
++++++-
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 68a253f..8adce65 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -285,8 +285,52 @@ See also linkgit:git-reflog[1].
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~
=20
-When optional paths are given, 'git rev-list' simplifies commits with
-various strategies, according to the options you have selected.
+Sometimes you are only interested in part of the history, for example =
the
+commits modifying a particular <paths>. But there are two parts of
+'History Simplification', one part is selecting the commits and the ot=
her
+is how to do it, as there are various strategies to simplify the histo=
ry.
+
+The following options select the commits to be shown:
+
+<paths>::
+
+	Commits modifying the given <paths> are selected.
+
+--simplify-by-decoration::
+
+	Commits that are referred by some branch or tag are selected.
+
+Note that extra commits can be shown to give a meaningful history.
+
+The following options affect the way the simplification is performed:
+
+Default mode::
+
+	Simplifies the history to the simplest history explaining the
+	final state of the tree. Simplest because it prunes some side
+	branches if the end result is the same (i.e. merging branches
+	with the same content)
+
+--full-history::
+
+	As the default mode but does not prune some history.
+
+--dense::
+
+	Only the selected commits are shown, plus some to have a
+	meaningful history.
+
+--sparse::
+
+	All commits in the simplified history are shown.
+
+--simplify-merges::
+
+	Additional option to '--full-history' to remove some needless
+	merges from the resulting history, as there are no selected
+	commits contributing to this merge.
+
+A more detailed explanation follows.
=20
 Suppose you specified `foo` as the <paths>.  We shall call commits
 that modify `foo` !TREESAME, and the rest TREESAME.  (In a diff
--=20
1.6.0.rc1.27.g9b6bf
