From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 04/10] diff.c/diff.h: expose userdiff_funcname
Date: Thu, 27 Mar 2014 14:50:50 -0400
Message-ID: <72e13d200ede2908cb5d9780a6a2b478b568c2fb.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOp-0004s5-V9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbaC0Svb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50653 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757142AbaC0Sv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:28 -0400
X-AuditID: 12074413-f79076d000002d17-8b-5334732f8ea4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.C7.11543.F2374335; Thu, 27 Mar 2014 14:51:27 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TM013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:26 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsUixO6iqKtfbBJscGErj8XclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4MrYdX81a8EVrore4wtZGhjfcHQxcnJICJhITNmwhBHCFpO4cG89WxcjF4eQwGVGiRfz
	fzFBOCuZJA58ng1WxSbgLLHp134mEFtEQFzi7fGZ7CBFzAILGSXe7pnM3MXIwSEsYCex5WEs
	SA2LgKrEj0U/GUHCvAJREr0N9hDLDCQ+PTvDDGJzCjhITJ6/EaxTSMBe4uNSW4hwtMTrrYvZ
	QGwhoM7XW0+yTGDkX8DIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJACF
	dzDuOil3iFGAg1GJh3eGlUmwEGtiWXFl7iFGCQ5mJRHeuQVAId6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rxqS9T9hATSE0tSs1NTC1KLYLJMHJxSDYzbwt6+Oj5T5HbHl+2WvPq1ke/Z5tWc7LHw
	bK/cqL987YMf30UaDSdc4e+r1bd9yFvjsCyvmPMCX5mQx47I8D/1xtl8AiedJuS0C2xL+Xpg
	qopGZ9+6NY/Fa++lNPwp2sPdOp93tt51vb+bNeudVl7J3yF65myV/+NpTTOv9J7/kzHVykGy
	L1+JpTgj0VCLuag4EQAUVpurPAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245311>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

The functionality of userdiff_funcname (determining the language in use
for a given file and setting up patterns to match "function names" in
that language) is useful outside of diff.c, so here we remove its static
specifier and declare it in diff.h.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diff.c | 2 +-
 diff.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index e343191..f978ee7 100644
--- a/diff.c
+++ b/diff.c
@@ -2203,7 +2203,7 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 	return one->is_binary;
 }
 
-static const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *one)
+const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *one)
 {
 	diff_filespec_load_driver(one);
 	return one->driver->funcname.pattern ? &one->driver->funcname : NULL;
diff --git a/diff.h b/diff.h
index a24a767..9e96fc9 100644
--- a/diff.h
+++ b/diff.h
@@ -349,4 +349,6 @@ extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
+const struct userdiff_funcname *diff_funcname_pattern(struct diff_filespec *);
+
 #endif /* DIFF_H */
-- 
1.7.12.4 (Apple Git-37)
