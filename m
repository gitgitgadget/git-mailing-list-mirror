From: Jim Meyering <jim@meyering.net>
Subject: [PATCH for next] insert missing newline in a diagnostic
Date: Mon, 30 Aug 2010 11:40:24 +0200
Message-ID: <87iq2s4ewn.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 30 11:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq0r2-00039Z-GW
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 11:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab0H3Jkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 05:40:32 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39469 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab0H3Jkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 05:40:32 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9AF88940126
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 11:40:25 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 79FD6AA7; Mon, 30 Aug 2010 11:40:24 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154780>


When merging, I would get a message like this:

  error: The following untracked working tree files would be overwritten by merge:
  FILE_NAMEPlease move or remove them before you can merge.

This change inserts the newline after FILE_NAME.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index aadd48c..e81c995 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1307,7 +1307,7 @@ void set_porcelain_error_msgs(const char **msgs, const char *cmd)
 		"Updating the following directories would lose untracked files in it:\n%s";

 	if (advice_commit_before_merge)
-		msg = "The following untracked working tree files would be %s by %s:\n%%s"
+		msg = "The following untracked working tree files would be %s by %s:\n%%s\n"
 			"Please move or remove them before you can %s.";
 	else
 		msg = "The following untracked working tree files would be %s by %s:\n%%s";
--
1.7.2.2.510.g7180a
