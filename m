From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/14] Rename static function fetch_pack() to http_fetch_pack()
Date: Sun,  9 Sep 2012 08:19:38 +0200
Message-ID: <1347171589-13327-4-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAate-0002rp-T4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2IIGVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:15 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:61160 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964Ab2IIGUc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:32 -0400
X-AuditID: 1207440e-b7f036d0000008b5-b5-504c352f05db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.BD.02229.F253C405; Sun,  9 Sep 2012 02:20:31 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlg029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:29 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqKtv6hNg0POC36LrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGVdubGUpmMVRcfHeavYGxjtsXYycHBICJhKn25pZIGwxiQv31gPFuTiEBC4zSkx8+JYJ
	wjnDJNGz/AhYB5uArsSinmYmEFtEQE1iYtshFpAiZoEuRonl636BFQkLBEnc2/eKGcRmEVCV
	+LT0H9gKXgEXiRlLZ7JCrFOU+PF9DVgNp4CrxKuZuxlBbCGgmk07r7FOYORdwMiwilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkqPh2MLavlznEKMDBqMTDy3zHO0CINbGs
	uDL3EKMkB5OSKG+znk+AEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeq+xAOd6UxMqq1KJ8mJQ0
	B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8HY6BGwaLU9NSKtMycEoQ0EwcniOAC2cAD
	tOE6SCFvcUFibnFmOkTRKUZFKXHehyAJAZBERmke3ABY/L9iFAf6R5j3DEgVDzB1wHW/AhrM
	BDRY5JkHyOCSRISUVAOjy+YPkQ3qmyNKbcpcDqlYdy/bzxU9ffk/m05Gjg3LNm5QEe9cKVbj
	kvtAynvrt6kKrSZSZmKnFwm0WxnwWL+7/SOTcUrUoSl7Xyx+MenU89sdj1y/l3cbeGfJMXYV
	bO214e932iRnt9Ha692J6CWBHgsufS0xP6aWX65savhT/tFxG4sS2yAlluKMREMt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205053>

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
