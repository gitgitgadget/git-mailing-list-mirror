From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/2] tutorial: Use only separate layout
Date: Wed, 17 Jan 2007 01:09:12 +0100
Message-ID: <87irf6ikev.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 01:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6yNC-0008Pm-Uc
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 01:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbXAQAJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 19:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbXAQAJt
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 19:09:49 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:39225 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbXAQAJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 19:09:48 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0H09je28352
	for <git@vger.kernel.org>; Wed, 17 Jan 2007 01:09:45 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36984>


Then the newbies only have to understand one layout.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 Hi *,

   updated patch.

 Santi

 Documentation/tutorial.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 8325c5e..1b93013 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -283,10 +283,12 @@ at /home/bob/myrepo.  She does this with:
=20
 ------------------------------------------------
 $ cd /home/alice/project
-$ git pull /home/bob/myrepo master
+$ git remote add bob /home/bob/myrepo
+$ git pull bob master
 ------------------------------------------------
=20
-This merges the changes from Bob's "master" branch into Alice's
+First it adds the "remote" Bob's repository with the name "bob" and
+then it merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.  (Note that the
 "master" argument in the above command is actually unnecessary, as it
@@ -296,18 +298,16 @@ The "pull" command thus performs two operations: =
it fetches changes
 from a remote branch, then merges them into the current branch.
=20
 You can perform the first operation alone using the "git fetch"
-command.  For example, Alice could create a temporary branch just to
-track Bob's changes, without merging them with her own, using:
+command without merging them with her own branch, using:
=20
 -------------------------------------
-$ git fetch /home/bob/myrepo master:bob-incoming
+$ git fetch bob
 -------------------------------------
=20
-which fetches the changes from Bob's master branch into a new branch
-named bob-incoming.  Then
+which fetches the changes from Bob's branches.  Then
=20
 -------------------------------------
-$ git log -p master..bob-incoming
+$ git log -p master..bob/master
 -------------------------------------
=20
 shows a list of all the changes that Bob made since he branched from
@@ -318,21 +318,21 @@ could merge the changes into her master branch:
=20
 -------------------------------------
 $ git checkout master
-$ git merge bob-incoming
+$ git merge bob/master
 -------------------------------------
=20
-The last command is a merge from the "bob-incoming" branch in Alice's
+The last command is a merge of the "bob/master" branch in Alice's
 own repository.
=20
 Alice could also perform both steps at once with:
=20
 -------------------------------------
-$ git pull /home/bob/myrepo master:bob-incoming
+$ git pull bob
 -------------------------------------
=20
-This is just like the "git pull /home/bob/myrepo master" that we saw
+This is just like the "git pull bob master" that we saw
 before, except that it also stores the unmerged changes from bob's
-master branch in bob-incoming before merging them into Alice's
+master branch in bob/master before merging them into Alice's
 current branch.  Note that git pull always merges into the current
 branch, regardless of what else is given on the commandline.
=20
--=20
1.5.0.rc1.gaa1c42
