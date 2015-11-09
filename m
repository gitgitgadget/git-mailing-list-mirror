From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 06/11] refname_is_safe(): improve docstring
Date: Mon,  9 Nov 2015 18:03:43 +0100
Message-ID: <cffa0c3c8d4f466eedaf6102b783dcef31db4b4d.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvprx-0007tx-I5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbbKIREZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:25 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43754 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751493AbbKIREU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:20 -0500
X-AuditID: 1207440c-f79e16d000002a6e-34-5640d20e7607
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.19.10862.E02D0465; Mon,  9 Nov 2015 12:04:14 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Yt026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:13 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMt3ySHMYNtRS4v5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+PD5sCCd1wVk7pOMjUwnuLoYuTkkBAwkTjw8wwj
	hC0mceHeejYQW0jgMqPEv0nFEPYJJokDv8xAbDYBXYlFPc1MILaIgJrExLZDLF2MXBzMAh8Z
	Jeb+WAiWEBawk/h//z4riM0ioCrx8eAXsKG8AlES/S8ms0Isk5OYcr8drJ5TwEJix4l/jBDL
	zCUmrlrDNIGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkLDj2cH4
	bZ3MIUYBDkYlHl6G6fZhQqyJZcWVuYcYJTmYlER5o084hAnxJeWnVGYkFmfEF5XmpBYfYpTg
	YFYS4S3YBZTjTUmsrEotyodJSXOwKInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnwbroA1ChY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPiov4YmBkgKR4gPbuAGnnLS5IzAWKQrSe
	YlSUEuddBJIQAElklObBjYUlk1eM4kBfCvPagFTxABMRXPcroMFMQIOX+oMNLklESEk1MGYq
	6O8o6a1jXMxxs93/Wt/jZQKl96Lk1yjY550QXWMQ0Him4KCGQXLAvyAbt2PNrJF3WdwUr131
	10/WSNIW3db+3Pb7Xb4FNgZzIm5lH47hS5GcMmNyyOKdEmc/B10RbU3iey/J5dP/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281063>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 82129f0..f48c58a 100644
--- a/refs.c
+++ b/refs.c
@@ -341,13 +341,17 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 /*
- * Check if a refname is safe.
- * For refs that start with "refs/" we consider it safe as long they do
- * not try to resolve to outside of refs/.
+ * Return true iff refname is minimally safe. "Safe" here means that
+ * deleting a loose reference by this name will not do any damage, for
+ * example by causing a file that is not a reference to be deleted.
+ * This function does not check that the reference name is legal; for
+ * that, use check_refname_format().
  *
- * For all other refs we only consider them safe iff they only contain
- * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
- * "config").
+ * We consider a refname that starts with "refs/" to be safe as long
+ * as any ".." components that it might contain do not escape "refs/".
+ * Names that do not start with "refs/" are considered safe iff they
+ * consist entirely of upper case characters and '_' (like "HEAD" and
+ * "MERGE_HEAD" but not "config" or "FOO/BAR").
  */
 static int refname_is_safe(const char *refname)
 {
-- 
2.6.2
