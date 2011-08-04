From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/6] test-path-utils: Add subcommand "prefix_path"
Date: Thu,  4 Aug 2011 06:47:48 +0200
Message-ID: <1312433268-11385-7-git-send-email-mhagger@alum.mit.edu>
References: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoprD-0000n2-W9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab1HDEsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:48:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39760 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab1HDEsD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:48:03 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744ltPb029942;
	Thu, 4 Aug 2011 06:47:59 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178695>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 test-path-utils.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index a410e30..3bc20e9 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -35,6 +35,19 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc >= 4 && !strcmp(argv[1], "prefix_path")) {
+		char *prefix = argv[2];
+		int prefix_len = strlen(prefix);
+		int nongit_ok;
+		setup_git_directory_gently(&nongit_ok);
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
