From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Support tags in uncommit - use git_id instead of rev_parse
Date: Sun, 30 Sep 2007 13:26:47 -0400
Message-ID: <20070930172647.18972.49369.stgit@tt.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 19:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic2ZI-0005Af-4c
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 19:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbXI3R0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756056AbXI3R0v
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 13:26:51 -0400
Received: from c60.cesmail.net ([216.154.195.49]:37682 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbXI3R0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 13:26:51 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 30 Sep 2007 13:26:48 -0400
Received: from tt.roinet.com (c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166])
	by relay.cesmail.net (Postfix) with ESMTP id BAF2D618FE1;
	Sun, 30 Sep 2007 13:26:48 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59546>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/uncommit.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 0cd0fb0..c22d3ea 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -65,7 +65,7 @@ def func(parser, options, args):
         if len(args) != 0:
             parser.error('cannot specify patch name with --to')
         patch_nr = patchnames = None
-        to_commit = git.rev_parse(options.to)
+        to_commit = git_id(options.to)
     elif options.number:
         if options.number <= 0:
             parser.error('invalid value passed to --number')
