From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 5/6] test-path-utils: Add subcommand "absolute_path"
Date: Thu, 28 Jul 2011 12:37:04 +0200
Message-ID: <1311849425-9057-6-git-send-email-mhagger@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 12:37:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNyI-0007Q2-RJ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab1G1KhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:37:20 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32855 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab1G1KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:37:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmNvm-0001Zr-E9; Thu, 28 Jul 2011 12:35:06 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178055>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This patch and the following one are purely to allow testing of some
path manipulation commands.  (Perhaps they will inspire somebody to
write unit tests for absolute_path() and or prefix_path(), or document
prefix_path().)  If it is not thought that they will be useful in the
future, they can be discarded.

 test-path-utils.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index e767159..a410e30 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -20,6 +20,15 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc >= 2 && !strcmp(argv[1], "absolute_path")) {
+		while (argc > 2) {
+			puts(absolute_path(argv[2]));
+			argc--;
+			argv++;
+		}
+		return 0;
+	}
+
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
 		int len = longest_ancestor_length(argv[2], argv[3]);
 		printf("%d\n", len);
-- 
1.7.6.8.gd2879
