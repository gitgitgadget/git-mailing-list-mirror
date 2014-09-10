From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] git-notes.txt: Explain how to transfer notes between repos
Date: Wed, 10 Sep 2014 15:56:54 +0200
Message-ID: <1410357414-691-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 15:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiPM-0003hl-DU
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaIJN5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 09:57:15 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:46430 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaIJN5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:57:13 -0400
Received: from 54-63-118-87.mtulink.net ([87.118.63.54]:50234 helo=localhost.localdomain)
	by smtp.domeneshop.no with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <sunny@sunbase.org>)
	id 1XRiOV-0006sO-HF; Wed, 10 Sep 2014 15:57:11 +0200
X-Mailer: git-send-email 2.1.0.127.g0c72b98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256747>

The documentation for git notes did not mention anywhere how to transfe=
r
notes between repositories, create a section that explains this topic.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 Documentation/git-notes.txt | 39 +++++++++++++++++++++++++++++++++++++=
++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 310f0a5..4237bec 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -264,6 +264,45 @@ prior to the merge, these will also be removed by =
this notes merge
 strategy.
=20
=20
+TRANSFERRING NOTES ACROSS REPOSITORIES
+--------------------------------------
+
+Notes are not transferred by default when using the standard
+fetch/push commands, but has be done explicitly. To fetch all notes
+from a particular remote, use
+
+------------
+$ git fetch origin refs/notes/*:refs/notes/*
+------------
+
+`git fetch` can be configured to automatically fetch notes from a
+remote with this command:
+
+------------
+$ git config --add remote.origin.fetch +refs/notes/*:refs/notes/*
+------------
+
+To transfer notes to a remote repository:
+
+------------
+$ git push origin refs/notes/*
+------------
+
+If you don't want to fetch or push all notes stored under
+`refs/notes/`, replace the asterisk with the specific type of notes
+you want to transfer:
+
+------------
+$ git fetch origin refs/notes/commits:refs/notes/commits
+------------
+
+or
+
+------------
+$ git push origin refs/notes/commits
+------------
+
+
 EXAMPLES
 --------
=20
--=20
2.1.0.127.g0c72b98
