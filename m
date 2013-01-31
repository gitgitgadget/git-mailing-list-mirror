From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] docs: clarify git-branch --list behavior
Date: Thu, 31 Jan 2013 01:45:46 -0500
Message-ID: <20130131064545.GA25315@sigill.intra.peff.net>
References: <20130131064357.GA24660@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:46:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nuV-0007Ge-3E
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab3AaGpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:45:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54446 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab3AaGpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:45:49 -0500
Received: (qmail 3731 invoked by uid 107); 31 Jan 2013 06:47:12 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 01:47:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 01:45:46 -0500
Content-Disposition: inline
In-Reply-To: <20130131064357.GA24660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215098>

It was not clear from the "description" section of
git-branch(1) that using a <pattern> meant that you _had_ to
use the --list option. Let's clarify that, and while we're
at it, reword some clunky and ambiguous sentences.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 45a225e..01aa87f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -22,13 +22,15 @@ DESCRIPTION
 DESCRIPTION
 -----------
 
-With no arguments, existing branches are listed and the current branch will
-be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both. This list mode is also
-activated by the `--list` option (see below).
-<pattern> restricts the output to matching branches, the pattern is a shell
-wildcard (i.e., matched using fnmatch(3)).
-Multiple patterns may be given; if any of them matches, the branch is shown.
+If `--list` is given, or if there are no non-option arguments, existing
+branches are listed; the current branch will be highlighted with an
+asterisk.  Option `-r` causes the remote-tracking branches to be listed,
+and option `-a` shows both local and remote branches. If a `<pattern>`
+is given, it is used as a shell wildcard to restrict the output to
+matching branches. If multiple patterns are given, a branch is shown if
+any it is matched by any of the patterns.  Note that when providing a
+`<pattern>`, you must use `--list`; otherwise the command is interpreted
+as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
-- 
1.8.1.2.5.g1cb3f73
