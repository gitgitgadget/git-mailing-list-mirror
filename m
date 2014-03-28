From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH] MSVC: fix t0040-parse-options
Date: Fri, 28 Mar 2014 16:04:58 +0400
Message-ID: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 13:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTVXJ-0000bM-GE
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 13:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaC1MFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 08:05:18 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:51219 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaC1MFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 08:05:17 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WTVX9-0002YS-69; Fri, 28 Mar 2014 16:05:15 +0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245383>

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 test-parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 434e8b8..7840493 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -11,6 +11,7 @@ static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
 static struct string_list list;
+static const char *default_string = "default";
 
 static int length_callback(const struct option *opt, const char *arg, int unset)
 {
@@ -60,7 +61,7 @@ int main(int argc, char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (unsigned long)"default"),
+			"set string to default", default_string),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
-- 
1.9.1.501.gfbd1a76.dirty.MSVC
