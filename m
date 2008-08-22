From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Added details about resolving conflicts
Date: Fri, 22 Aug 2008 15:49:13 -0700
Message-ID: <7vtzdc64ye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Hensgen <dan@methodhead.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 00:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfSa-0001OM-7p
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYHVWtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYHVWtT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:49:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYHVWtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:49:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D340069AA8;
	Fri, 22 Aug 2008 18:49:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 31C9069AA4; Fri, 22 Aug 2008 18:49:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D4853A4-709C-11DD-9CD7-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93390>

From: Dan Hensgen <dan@macbook.danhensgen.com>
Date: Thu, 21 Aug 2008 23:32:00 -0400
Subject: [PATCH] Added details about resolving conflicts

Signed-off-by: Dan Hensgen <dan@methodhead.com>
---

 * This was sent in private to me by mistake; redistributing it for wider
   comments.

 Documentation/git-merge.txt |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 17a15ac..685e1fe 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -126,13 +126,25 @@ After seeing a conflict, you can do two things:
    up working tree changes made by 2. and 3.; 'git-reset --hard' can
    be used for this.
 
- * Resolve the conflicts.  `git diff` would report only the
-   conflicting paths because of the above 2. and 3.
-   Edit the working tree files into a desirable shape
-   ('git mergetool' can ease this task), 'git-add' or 'git-rm'
-   them, to make the index file contain what the merge result
-   should be, and run 'git-commit' to commit the result.
+ * Resolve the conflicts.  Git will mark the conflicts in
+   the working tree.  Edit the files into shape and
+   'git-add' to the index.  'git-commit' to seal the deal.
 
+You can work through the conflict with a number of tools:
+
+ * Use a mergetool.  'git mergetool' to launch a graphical
+   mergetool which will work you through the merge.
+
+ * Look at the diffs.  'git diff' will show a three-way diff,
+   highlighting changes from both the HEAD and remote versions.
+
+ * Look at the diffs on their own. 'git log --merge -p <path>'
+   will show diffs first for the HEAD version and then the
+   remote version.
+
+ * Look at the originals.  'git show :1:filename' shows the
+   common ancestor, 'git show :2:filename' shows the HEAD
+   version and 'git show :3:filename' shows the remote version.
 
 SEE ALSO
 --------
