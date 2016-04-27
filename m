From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/29] rename_ref(): remove unneeded local variable
Date: Wed, 27 Apr 2016 18:57:24 +0200
Message-ID: <518b8429d7b47dfdb5a74d22c7a72fc2b095c862.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSof-0004Jc-LS
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbcD0Q7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:53 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62997 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753190AbcD0Q6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:16 -0400
X-AuditID: 1207440f-8bbff700000008e4-e4-5720efa68183
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 71.9F.02276.6AFE0275; Wed, 27 Apr 2016 12:58:14 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6K022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:13 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLvsvUK4QVODrsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61dmD3+Pv+A5PHzll32T2e9e5h9Lh4Sdlj/9JtbB4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO6P/5kfWgvWcFbeOr2RrYLzO3sXIwSEhYCKx/3VR
	FyMXh5DAVkaJswdOAcU5gZzjTBIbL/iD2GwCuhKLepqZQGwRAQeJ5St/sYM0MAs0MUl8X97E
	ApIQFnCW+PJ7HVgzi4CqxO6JD9hAbF6BKImOCy8YQWwJATmJy9Mh4pwCFhJfWt8yQiwzl1jy
	YDX7BEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCAox/B2PXeplD
	jAIcjEo8vAUSCuFCrIllxZW5hxglOZiURHmXnAUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGd
	/gYox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4C1/B9QoWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qA+GJgDICkeID2loK08xYXJOYCRSFaTzEqSonz
	LgBJCIAkMkrz4MbC0sYrRnGgL4V5g0CqeIApB677FdBgJqDBlw/JggwuSURISTUwWrLsrK3b
	36K/L6Du9iMX8W0FaWHlTz+Lyy152bx8Y09NhU7Jo0vzBMKl0pv/L1rm1GyhemcFb6rzfX7f
	qeuqPoTbrLnvqXx1qenEhu5jFx3asl8v4b8/wd+mL31R23/Oa43GWtxefl7HxdVW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292769>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index de38517..0ade681 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2351,20 +2351,17 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct ref_lock *lock;
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
-	const char *symref = NULL;
 	struct strbuf err = STRBUF_INIT;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
-				    orig_sha1, &flag);
+	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING, orig_sha1, &flag))
+		return error("refname %s not found", oldrefname);
+
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
-	if (!symref)
-		return error("refname %s not found", oldrefname);
-
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-- 
2.8.1
