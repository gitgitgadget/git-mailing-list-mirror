From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] user-manual: Fix the interactive rebase example commit range
Date: Sun, 24 Mar 2013 08:23:30 -0400
Message-ID: <c29df638e260ab104bf940cc41ce5d75713707a8.1364127610.git.wking@tremily.us>
References: <7vobfg3tw8.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 24 13:24:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJjyE-00059O-27
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3CXMXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:23:50 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:59459 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab3CXMXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:23:49 -0400
Received: from odin.tremily.us ([unknown] [72.68.93.192])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MK500M0LZRB0H20@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 24 Mar 2013 07:23:37 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 792C4938A71; Sun,
 24 Mar 2013 08:23:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1364127815; bh=/GoBz59zEny5lKJwyKIdsQchlfd6pHEJEuK86b3GElQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmrG9S8jJAyajm+hQmupVQ2zucSWgyPRNX3ZjDakQQIakkQtMcWUJauAVgvhMfYhV
 Jt+lF3/ciaULANZtb3/awtQJUwN0xLwdxV7zfLGxDkJ8+GZznbIsWSaoesWqX17VHu
 UsDAtLJJGtv5WsYET/UezAGqJpXI1h9GC13miIo8=
X-Mailer: git-send-email 1.8.1.5
In-reply-to: <7vobfg3tw8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218948>

From: "W. Trevor King" <wking@tremily.us>

6c26bf4 (user-manual: Reorganize the reroll sections, adding 'git
rebase -i', 2013-02-19) used deadbee as the oldest commit in the pick
list, but as the final commit in the rebased range, due to sloppy
duplication and extension from git-rebase.txt.  This fixes that by
adding a new HEAD commit.

I also reworded the example commit summaries (onelines), because I
think my initial mistake may have been to to misinterpreting "this
commit" as "HEAD" without thinking things through ;).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5f36f81..a839e57 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2617,11 +2617,12 @@ This will open your editor with a list of steps to be taken to perform
 your rebase.
 
 -------------------------------------------------
-pick deadbee The oneline of this commit
-pick fa1afe1 The oneline of the next commit
+pick deadbee The oneline of HEAD~4
+pick fa1afe1 The oneline of HEAD~3
 ...
+pick 1cef15h The oneline of HEAD
 
-# Rebase c0ffeee..deadbee onto c0ffeee
+# Rebase c0ffeee..1cef15h onto c0ffeee
 #
 # Commands:
 #  p, pick = use commit
-- 
1.8.2.rc0.16.g20a599e
