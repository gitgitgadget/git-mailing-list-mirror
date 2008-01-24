From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Don't keep old committer when rewriting a commit
Date: Thu, 24 Jan 2008 09:09:35 +0100
Message-ID: <20080124080912.25671.67795.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 09:10:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHxA1-0006M9-4E
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 09:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYAXIJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 03:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYAXIJj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 03:09:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2903 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbYAXIJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 03:09:39 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JHx9T-0005MP-00; Thu, 24 Jan 2008 08:09:35 +0000
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71604>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I think this is what the old infrastructure does too.

 stgit/lib/transaction.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index a60c5ff..809eabf 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -176,6 +176,7 @@ class StackTransaction(object):
         conflicts to them."""
         i =3D self.unapplied.index(pn)
         cd =3D self.patches[pn].data
+        cd =3D cd.set_committer(None)
         s =3D ['', ' (empty)'][cd.is_nochange()]
         oldparent =3D cd.parent
         cd =3D cd.set_parent(self.__head)
