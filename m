From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 6/6] test-path-utils: Add subcommand "prefix_path"
Date: Thu, 28 Jul 2011 12:37:05 +0200
Message-ID: <1311849425-9057-7-git-send-email-mhagger@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 12:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNyJ-0007Q2-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab1G1KhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:37:23 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32853 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1G1KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:37:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmNvm-0001Zr-Ek; Thu, 28 Jul 2011 12:35:06 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178057>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 test-path-utils.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index a410e30..471406c 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -35,6 +35,19 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc >= 4 && !strcmp(argv[1], "prefix_path")) {
+		int nongit_ok;
+		setup_git_directory_gently(&nongit_ok);
+		char *prefix = argv[2];
+		int prefix_len = strlen(prefix);
+		while (argc > 3) {
+			puts(prefix_path(prefix, prefix_len, argv[3]));
+			argc--;
+			argv++;
+		}
+		return 0;
+	}
+
 	if (argc == 4 && !strcmp(argv[1], "strip_path_suffix")) {
 		char *prefix = strip_path_suffix(argv[2], argv[3]);
 		printf("%s\n", prefix ? prefix : "(null)");
-- 
1.7.6.8.gd2879
