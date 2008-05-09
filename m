From: drafnel@gmail.com
Subject: [PATCH 3/5] mktag.c: rename verify_tag to verify_tag_buffer
Date: Thu,  8 May 2008 21:19:47 -0500
Message-ID: <5164765.1210299531781.JavaMail.teamon@b301.teamon.com>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <1210299589-10448-3-git-send-email-drafnel@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIRA-00059u-2e
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbYEICdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbYEICdO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:14 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755074AbYEICdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:10 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492IpG10503;
	Fri, 9 May 2008 02:18:51 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210299589-10448-3-git-send-email-drafnel@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81593>

From: Brandon Casey <drafnel@gmail.com>

This is in preparation for merging mktag.c with builtin-tag.c and
using verify_tag_buffer within the git-tag code path.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 mktag.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mktag.c b/mktag.c
index 352747b..6204001 100644
--- a/mktag.c
+++ b/mktag.c
@@ -39,7 +39,7 @@ static int verify_object(unsigned char *sha1, const char *expected_type)
 #define PD_FMT "%td"
 #endif
 
-static int verify_tag(const char *buffer, size_t size)
+static int verify_tag_buffer(const char *buffer, size_t size)
 {
 	int typelen;
 	char type[20];
@@ -171,7 +171,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buf.buf, buf.len) < 0)
+	if (verify_tag_buffer(buf.buf, buf.len) < 0)
 		die("invalid tag signature file");
 
 	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
-- 
1.5.5.67.g9a49
