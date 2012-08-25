From: mhagger@alum.mit.edu
Subject: [PATCH v2 02/17] Rename static function fetch_pack() to http_fetch_pack()
Date: Sat, 25 Aug 2012 08:44:12 +0200
Message-ID: <1345877067-11841-3-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7J-0002FH-SK
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab2HYGpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:02 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50437 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab2HYGpA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:00 -0400
X-AuditID: 12074414-b7f846d0000008b8-d8-5038746cdb11
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.16.02232.C6478305; Sat, 25 Aug 2012 02:45:00 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSd011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:44:58 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJtTYhFgcG+pjEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M85tPcBWcJqjouPvd8YGxjb2LkZODgkBE4ldrxYxQdhiEhfurWfrYuTiEBK4zCjR1fWd
	CcI5yyRx9W8vG0gVm4CUxMvGHrBuEQE1iYlth1hAipgFuhgllq/7BVYkLBAkMbP5MdhYFgFV
	iZ6N/5lBbF4BF4mn7a9ZIdYpSvz4vgYszingKjHh10WwoUJANU3HrrBMYORdwMiwilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkqER2MB45KXeIUYCDUYmH98YZ8wAh1sSy
	4srcQ4ySHExKorxihRYBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4vzMA5XhTEiurUovyYVLS
	HCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHhri4EaBYtS01Mr0jJzShDSTBycIIILZAMP
	0IZkkELe4oLE3OLMdIiiU4yKUuK8BiAJAZBERmke3ABY/L9iFAf6R5h3ZhFQFQ8wdcB1vwIa
	zAQ0uNzVHGRwSSJCSqqBcUbR03NbM03Dslbnbdz0gWdmp73BOmHxRFn35/0Fb8oXXcx+a84m
	eS1O8Vkk33O7j8oMQe3+tTlRn2S4YjZp58k2LdRksZ4wz+ftulajxQ6xUbxSy11Mlz6NPsp0
	6mOTrq2c4a1J4SpLe//teKCa/vin55unpgu+37XJFNEKzVrAr227/soPJZbijERD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204250>

From: Michael Haggerty <mhagger@alum.mit.edu>

Avoid confusion with the non-static function of the same name from
fetch-pack.h.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-walker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 51a906e..1516c5e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -396,7 +396,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	return ret;
 }
 
-static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
 {
 	struct packed_git *target;
 	int ret;
@@ -524,7 +524,7 @@ static int fetch(struct walker *walker, unsigned char *sha1)
 	if (!fetch_object(walker, altbase, sha1))
 		return 0;
 	while (altbase) {
-		if (!fetch_pack(walker, altbase, sha1))
+		if (!http_fetch_pack(walker, altbase, sha1))
 			return 0;
 		fetch_alternates(walker, data->alt->base);
 		altbase = altbase->next;
-- 
1.7.11.3
