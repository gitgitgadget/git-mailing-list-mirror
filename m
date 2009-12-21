From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH] Reword -M, when in `git log`s documention, to suggest --follow
Date: Mon, 21 Dec 2009 15:40:59 -0500
Message-ID: <1261428059-31286-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 21:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMp4M-0004ql-1W
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 21:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbZLUUlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757134AbZLUUlX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 15:41:23 -0500
Received: from chmrr.net ([209.67.253.66]:37862 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757087AbZLUUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 15:41:22 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NMp4A-00017h-MX
	for git@vger.kernel.org; Mon, 21 Dec 2009 15:41:22 -0500
X-Mailer: git-send-email 1.6.6.rc0.363.g69d13.dirty
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-21 15:41:22
X-Connected-IP: 75.147.59.54:35224
X-Message-Linecount: 53
X-Body-Linecount: 46
X-Message-Size: 1617
X-Body-Size: 1322
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135564>

The documentation for `git log` is sadly misleading when it comes
to tracking renames.  By far the most common option that users
new to git want is the ability to view the history of a file
across renames.  Unfortunately, `git log --help` shows:

    NAME
           git-log - Show commit logs
    [...]
    OPTIONS
    [...]
           -M
               Detect renames.

...and most users stop reading there.  Unfortunately, what
they're generally looking for comes significantly later:

    [...]
           --follow
               Continue listing the history of a file beyond renames.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 Documentation/diff-options.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8707d0e..bcbad88 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -175,7 +175,13 @@ endif::git-format-patch[]
 	Break complete rewrite changes into pairs of delete and create.
 
 -M::
+ifdef::git-log[]
+	Show renames in diff output.  See `--follow` to track history
+	across renames.
+endif::git-log[]
+ifndef::git-log[]
 	Detect renames.
+endif::git-log[]
 
 -C::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
-- 
1.6.6.rc0.363.g69d13.dirty
