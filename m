From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Add --merged option to rebase.
Date: Mon, 12 Feb 2007 22:08:24 +0100
Message-ID: <20070212210824.28413.71656.stgit@gandelf.nowhere.earth>
References: <20070212210628.28413.87407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 22:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGiQq-0003UQ-2k
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 22:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965409AbXBLVJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965413AbXBLVJp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 16:09:45 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47407 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965409AbXBLVJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 16:09:45 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 948C5279A4;
	Mon, 12 Feb 2007 22:09:43 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 679381F01C;
	Mon, 12 Feb 2007 22:08:24 +0100 (CET)
In-Reply-To: <20070212210628.28413.87407.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39439>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/rebase.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 8b7bca0..2951421 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -31,6 +31,9 @@ Pop all patches from current stack, move the stack base to the given
 
 options = [make_option('-n', '--nopush',
                        help = 'do not push the patches back after rebasing',
+                       action = 'store_true'),
+           make_option('-m', '--merged',
+                       help = 'check for patches merged upstream',
                        action = 'store_true')]
 
 def func(parser, options, args):
@@ -59,6 +62,6 @@ def func(parser, options, args):
 
     # push the patches back
     if not options.nopush:
-        push_patches(applied)
+        push_patches(applied, options.merged)
 
     print_crt_patch()
