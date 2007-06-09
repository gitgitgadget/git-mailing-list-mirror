From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/2] Have series show empty hidden patches as hidden
	rather than empty.
Date: Sat, 09 Jun 2007 19:25:21 +0200
Message-ID: <20070609172520.30912.80799.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 19:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx4gm-0003Up-H7
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbXFIRZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbXFIRZT
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 13:25:19 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46111 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755350AbXFIRZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 13:25:18 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 66AC98192;
	Sat,  9 Jun 2007 19:25:16 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 23D281F019;
	Sat,  9 Jun 2007 19:25:21 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49584>

It is probably more important to show the hidden status of an empty
patch, since "clean" will not delete it anyway, and the display would
be ambiguous for a patch tagged "0" just before a patch tagged "!".
---

 stgit/commands/series.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 402356c..fe4e468 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -215,4 +215,4 @@ def func(parser, options, args):
             __print_patch(p, branch_str, '- ', '0 ', max_len, options)
 
         for p in hidden:
-            __print_patch(p, branch_str, '! ', '0 ', max_len, options)
+            __print_patch(p, branch_str, '! ', '! ', max_len, options)
