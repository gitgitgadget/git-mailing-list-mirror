From: brilliantov@inbox.ru
Subject: [PATCH] compat/inet_ntop.c: Use INET_ADDRSTRLEN and INET6_ADDRSTRLEN macroses
Date: Tue, 25 Aug 2015 13:34:39 +0300
Message-ID: <1440498879-12382-1-git-send-email-brilliantov@inbox.ru>
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 13:14:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUCB4-0005QG-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 13:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbbHYLOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 07:14:01 -0400
Received: from mail.byterg.ru ([217.12.248.131]:41517 "EHLO mail.byterg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbHYLOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 07:14:00 -0400
Received: from [192.168.10.51] (helo=kirill.byterg.ru)
	 by mail.byterg.ru with esmtp  (envelope-from <brilliantov@inbox.ru>)
	 id 1ZUAjB-0004Nl-FB ; Tue, 25 Aug 2015 13:41:13 +0400
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276518>

From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
---
 compat/inet_ntop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 90b7cc4..fcd3b15 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -47,7 +47,7 @@ static const char *
 inet_ntop4(const u_char *src, char *dst, size_t size)
 {
 	static const char fmt[] = "%u.%u.%u.%u";
-	char tmp[sizeof "255.255.255.255"];
+	char tmp[INET_ADDRSTRLEN];
 	int nprinted;
 
 	nprinted = snprintf(tmp, sizeof(tmp), fmt, src[0], src[1], src[2], src[3]);
@@ -78,7 +78,7 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
 	 * Keep this in mind if you think this function should have been coded
 	 * to use pointer overlays.  All the world's not a VAX.
 	 */
-	char tmp[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"], *tp;
+	char tmp[INET6_ADDRSTRLEN], *tp;
 	struct { int base, len; } best, cur;
 	unsigned int words[NS_IN6ADDRSZ / NS_INT16SZ];
 	int i;
-- 
2.1.4
