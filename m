From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/4] Don't try to delete the branch twice
Date: Sat, 22 Sep 2007 10:46:25 +0200
Message-ID: <20070922084625.29884.63499.stgit@yoghurt>
References: <20070922084334.29884.60506.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Aneesh Kumar <aneesh.kumar@gmail.com>,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0dT-0005ZG-Cc
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXIVIqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2007 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXIVIqb
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:46:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4106 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbXIVIqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:46:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZ0d8-0001mw-00; Sat, 22 Sep 2007 09:46:26 +0100
In-Reply-To: <20070922084334.29884.60506.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58923>

We already delete it in Stack.delete(), so don't do it here too.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 8c99936..c16fc69 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -99,7 +99,6 @@ def __delete_branch(doomed_name, force =3D False):
         raise CmdException('Cannot delete the current branch')
=20
     doomed.delete(force)
-    git.delete_branch(doomed_name)
=20
     out.done()
=20
