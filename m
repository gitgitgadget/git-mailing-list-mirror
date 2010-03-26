From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 07/12] Remove a redundant errno test in a usage of remove_path
Date: Fri, 26 Mar 2010 15:25:35 +0000
Message-ID: <1269617140-7827-8-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQe-0005ou-HK
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab0CZP0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:06 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55556 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0CZP0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:26:00 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001o8-JU; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023M-BW; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143245>

The errno test is redundant because the same test is carried
out in remove_path itself.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 195ebf9..87232b8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -409,7 +409,7 @@ static int remove_file(struct merge_options *o, int clean,
 			return -1;
 	}
 	if (update_working_directory) {
-		if (remove_path(path) && errno != ENOENT)
+		if (remove_path(path))
 			return -1;
 	}
 	return 0;
-- 
1.6.5
