From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] Translate git_more_info_string consistently
Date: Sun, 10 Mar 2013 17:10:20 +0200
Message-ID: <1362928220-7503-1-git-send-email-kevin@bracey.fi>
Cc: Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 16:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEhzF-0005MX-3j
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 16:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3CJPQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 11:16:06 -0400
Received: from mo4.mail-out.ovh.net ([178.32.228.4]:36233 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab3CJPQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 11:16:05 -0400
Received: from mail638.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 142F3104DDD6
	for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:21:41 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 10 Mar 2013 17:11:46 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 10 Mar 2013 17:11:46 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.8.g96befb6.dirty
X-Ovh-Tracer-Id: 11723151306428879070
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 52
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 52
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrfeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlhedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217807>

"git help" translated the "See 'git help <command>' for more
information..." message, but "git" didn't.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index d33f9b3..e484644 100644
--- a/git.c
+++ b/git.c
@@ -536,7 +536,7 @@ int main(int argc, const char **argv)
 		commit_pager_choice();
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-		printf("\n%s\n", git_more_info_string);
+		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
 	}
 	cmd = argv[0];
-- 
1.8.2.rc3.8.g96befb6.dirty
