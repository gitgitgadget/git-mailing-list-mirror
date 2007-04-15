From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] make git gc a first class citizen
Date: Sun, 15 Apr 2007 11:21:47 +0200
Message-ID: <20070415092147.GA18278@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 11:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd0uu-0006VE-9p
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 11:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXDOJU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 05:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbXDOJU7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 05:20:59 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:59238 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXDOJU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 05:20:59 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id F25D5E30273
	for <git@vger.kernel.org>; Sun, 15 Apr 2007 11:20:57 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id B755B580D2; Sun, 15 Apr 2007 11:21:47 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44491>

Let 'git gc' show up when executing 'git' with no arguments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

hpa recently asked git tree owners on kernel.org to pack their trees.
As I usually do not pack my local trees I started to look into man
pages, executing git etc and came up with 'git repack -d -l -f'
but was told the 'git gc' was the better way to do it.
This patch makes it easier to identify the 'git gc' command.

While investigating this I noticed that all git commands
are linked with help.o has the full set of commands. Seems a bit waste
of space but I did not tackle that.

	Sam

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 975777f..e4e11ad 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -21,6 +21,7 @@ clone
 commit
 diff
 fetch
+gc
 grep
 init
 log
