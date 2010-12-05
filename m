From: jari.aalto@cante.net
Subject: [PATCH] git-filter-branch.txt: (Checklist for Shrinking): Adjust commands and options
Date: Sun,  5 Dec 2010 21:14:47 +0200
Organization: Private
Message-ID: <1291576487-12120-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 20:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPK63-00051g-4C
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 20:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0LETOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 14:14:52 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:41638 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0LETOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 14:14:51 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id D45B513B3E0
	for <git@vger.kernel.org>; Sun,  5 Dec 2010 21:14:49 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03A1EC7DAD; Sun, 05 Dec 2010 21:14:49 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id C546C2BD43
	for <git@vger.kernel.org>; Sun,  5 Dec 2010 21:14:48 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PPK2p-00039x-Rm; Sun, 05 Dec 2010 21:14:47 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162956>

From: Jari Aalto <jari.aalto@cante.net>

Add a little more explanation to bullet that talks about cryptic
--tag-name-filter options. Suggest also option --expire-unreachable=3D0 i=
n
"git reflog" call. Add option --aggressive to garbage collect call.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-filter-branch.txt |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filt=
er-branch.txt
index 796e748..180fdaa 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -380,8 +380,10 @@ objects until you tell it to.  First make sure that:
   over its lifetime.  `git log \--name-only \--follow \--all \--
   filename` can help you find renames.
=20
-* You really filtered all refs: use `\--tag-name-filter cat \--
-  \--all` when calling git-filter-branch.
+* You really filtered all refs. Without the following, you could have
+  some branches or tags still pointing to the commits before
+  filtering:
+  `\--tag-name-filter cat \-- \--all`
=20
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
@@ -399,12 +401,12 @@ warned.
   for-each-ref \--format=3D"%(refname)" refs/original/ | xargs -n 1 git
   update-ref -d`.
=20
-* Expire all reflogs with `git reflog expire \--expire=3Dnow \--all`.
-
-* Garbage collect all unreferenced objects with `git gc \--prune=3Dnow`
-  (or if your git-gc is not new enough to support arguments to
-  `\--prune`, use `git repack -ad; git prune` instead).
+* Expire all reflogs with `git reflog expire \--expire=3Dnow \--all
+  \--expire-unreachable=3D0`.
=20
+* Garbage collect all unreferenced objects with `git gc \--aggressive
+  \--prune=3Dnow`. Or if your git-gc is not new enough to support
+  arguments to `\--prune`, use `git repack -ad; git prune` instead.
=20
 Author
 ------
--=20
1.7.2.3
