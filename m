From: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] checkout: add a space between the commit and "..."
Date: Tue, 28 Sep 2010 15:23:32 -0700
Message-ID: <20100928222332.GA28859@soprano.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <jkain@nvidia.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ic1-0000EH-87
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0I1WZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 18:25:12 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:2082 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263Ab0I1WZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:25:09 -0400
Received: from hqnvupgp04.nvidia.com (Not Verified[172.20.161.15]) by hqemgate04.nvidia.com
	id <B4ca26aaf0003>; Tue, 28 Sep 2010 15:22:39 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp04.nvidia.com (PGP Universal service);
  Tue, 28 Sep 2010 15:25:09 -0700
X-PGP-Universal: processed;
	by hqnvupgp04.nvidia.com on Tue, 28 Sep 2010 15:25:09 -0700
Received: from soprano.nvidia.com (172.16.173.9) by hqemhub02.nvidia.com
 (172.17.98.27) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 28 Sep
 2010 15:23:33 -0700
Content-Disposition: inline
X-NVConfidentiality: public
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157484>

Switching to a detached head prints something like

  HEAD is now at 9d14017... dir.c: squelch false uninitialized memory warning

These dots get selected when you double-click on the abbreviated
commit hash, which makes it annoying to copy and paste.

Add a space between the abbreviated commit and the dots, to improve
copy and pasteability.

Reported-by: Joe Kain <jkain@nvidia.com>
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a54583b..ca1cae3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -303,7 +303,7 @@ static void describe_detached_head(char *msg, struct commit *commit)
 	struct pretty_print_context ctx = {0};
 	parse_commit(commit);
 	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, &ctx);
-	fprintf(stderr, "%s %s... %s\n", msg,
+	fprintf(stderr, "%s %s ... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
 }
-- 
1.7.0.4
