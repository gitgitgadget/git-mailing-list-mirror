From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 05/10] refname_is_safe(): improve docstring
Date: Tue, 10 Nov 2015 12:42:35 +0100
Message-ID: <e3b0c07b34f78996c53df88c17d01cd6a494899d.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7KR-0000Mo-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbKJLnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:04 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49683 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864AbbKJLnB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:01 -0500
X-AuditID: 1207440c-f79e16d000002a6e-16-5641d843d048
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 50.36.10862.348D1465; Tue, 10 Nov 2015 06:42:59 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj9014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:58 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqOt8wzHM4PJLa4v5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGd82BxY8I6rYlLXSaYGxlMcXYyc
	HBICJhJfTq5khrDFJC7cW8/WxcjFISRwmVFi06+lzBDOCSaJpe/OgVWxCehKLOppZgKxRQTU
	JCa2HWIBsZkFljFJzNprC2ILC9hJHN34jRHEZhFQlThx9ykriM0rECXxaNd5FohtchJT7rcD
	zeHg4BSwkJh7LgMkLCRgLnG8fSLjBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVy
	M0v0UlNKNzFCApFnB+O3dTKHGAU4GJV4eCd8cwgTYk0sK67MPcQoycGkJMq7/5RjmBBfUn5K
	ZUZicUZ8UWlOavEhRgkOZiURXvsXQOW8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQne2utAQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP
	0N7ZIO28xQWJuUBRiNZTjIpS4rxaIAkBkERGaR7cWFh6ecUoDvSlMO9ekCoeYGqC634FNJgJ
	aPBSf5CHiksSEVJSDYx5+u9sOKVeTtlQftnpvV7lstPz997nfyDz6butxS5XFsYeb1vFGR49
	5/hucfz5tcKoZAJHbTnTNn3zH0sD13a+Upl5UKBiwv7//+bKFue+Tlddn86q5Gr8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281107>

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
