From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 09/10] Add support for unsetting config vars.
Date: Thu, 15 Mar 2007 01:27:15 +0100
Message-ID: <20070315002715.9094.93088.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdoT-0003MN-VI
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbXCOA1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbXCOA1R
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:27:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59042 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422772AbXCOA1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:27:17 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 01B7B81D6;
	Thu, 15 Mar 2007 01:27:16 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 8EC091F095;
	Thu, 15 Mar 2007 01:27:15 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42264>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/config.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index b016fbd..79cd12f 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -103,6 +103,9 @@ class GitConfig:
     def set(self, name, value):
         self.__run('git-repo-config', [name, value])
 
+    def unset(self, name):
+        self.__run('git-repo-config --unset', [name])
+
     def sections_matching(self, regexp):
         """Takes a regexp with a single group, matches it against all
         config variables, and returns a list whose members are the
