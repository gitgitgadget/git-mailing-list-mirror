From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH Illustration] branch --contains=<commit>
Date: Mon, 19 Nov 2007 00:04:23 -0800
Message-ID: <7vsl32oe48.fsf@gitster.siamese.dyndns.org>
References: <7v4pfircka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 09:05:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1cq-0008KA-Lm
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 09:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXKSIE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 03:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXKSIE3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 03:04:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53930 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbXKSIE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 03:04:28 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AE4C52EF;
	Mon, 19 Nov 2007 03:04:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BB86956B0;
	Mon, 19 Nov 2007 03:04:47 -0500 (EST)
In-Reply-To: <7v4pfircka.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 18 Nov 2007 22:09:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65411>

This renames the --with=<commit> option to --contains=<commit>, but still
supports the earlier --with=<commit> variant as a hidden synonym.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * An example usage of the ".help = NULL" member in the options
   structure.

 builtin-branch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index fd36e4f..5dc0c57 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -562,9 +562,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
-		OPT_CALLBACK(0, "with",    &with_commit, "commit",
+		OPT_CALLBACK(0, "contains",&with_commit, "commit",
 			     "print only branches that contain the commit",
 			     opt_parse_with_commit),
+		OPT_CALLBACK(0, "with",    &with_commit, "commit",
+			     NULL,
+			     opt_parse_with_commit),
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
-- 
1.5.3.6.1788.gcc5c4
