From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 6/6] Better error message if merge fails
Date: Sun, 26 Aug 2007 22:43:05 +0200
Message-ID: <20070826204305.16700.16459.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOxE-0002R4-HN
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbXHZUnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXHZUnT
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:43:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2224 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbXHZUnS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:43:18 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOws-00061y-00; Sun, 26 Aug 2007 21:43:06 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56730>

This message is no longer printed in case of conflicts, just in case
the merge really failed; so don't talk about conflicts in the error
message.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index d2ca0e2..080231f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1079,8 +1079,7 @@ class Series(PatchSet):
                     ex.list()
                 except git.GitException, ex:
                     out.error('The merge failed during "push".',
-                              'Use "refresh" after fixing the conflict=
s or'
-                              ' revert the operation with "push --undo=
".')
+                              'Revert the operation with "push --undo"=
=2E')
=20
         append_string(self.__applied_file, name)
=20
