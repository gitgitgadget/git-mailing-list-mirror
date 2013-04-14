From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/33] pack-refs: rename handle_one_ref() to pack_one_ref()
Date: Sun, 14 Apr 2013 14:54:38 +0200
Message-ID: <1365944088-10588-24-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTl-00050P-7w
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab3DNMzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:54 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43740 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751981Ab3DNMzw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:52 -0400
X-AuditID: 12074411-b7f286d0000008e8-61-516aa7583c63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A1.8C.02280.857AA615; Sun, 14 Apr 2013 08:55:52 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkK007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:51 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqBuxPCvQYHa3rEXXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGdM+/6fpWA7R8XDaUtYGhh/sHUxcnBICJhIdMxl7GLkBDLFJC7cWw8U5uIQErjMKPFs
	0j5mCOcsk8SuZwuYQKrYBHQlFvU0M4E0iwhkS+xeKw8SZhZwkNj8uRFskLCAt8SZte3MIDaL
	gKrExveXWEBsXgFXiX977zJBLFOQOL59G1g9J1B8+vNj7CC2kICLxKzNs1knMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESUII7GGeclDvEKMDBqMTD+4IxK1CI
	NbGsuDL3EKMkB5OSKO/CpUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryOrUA53pTEyqrUonyY
	lDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IEr8YyoEbBotT01Iq0zJwShDQTByeI4ALZ
	wAO04S3Idt7igsTc4sx0iKJTjIpS4rwfQRICIImM0jy4AbDYf8UoDvSPMO9TkCoeYNqA634F
	NJgJaLDP3nSQwSWJCCmpBkapCc7F53c9vOPGtHXX5a2KgnFfZNZsYubSV1798JXpobgnC68J
	CAnuWKLCO/dn2EPxO4oauTYf4talL2+e3e14z0nugV7SFmeWj7Wv7S4kVTh+1pt/455MIpv8
	CZMTR4ot+mWe2p22lbRl6TrN15F+1uDlq4ggG9PqgqSQ8ufHraOclTwFNyuxFGck 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221117>

This code is about to be moved, so name the function more
distinctively.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 pack-refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index 4461f71..d840055 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -23,7 +23,7 @@ static int do_not_prune(int flags)
 	return (flags & (REF_ISSYMREF|REF_ISPACKED));
 }
 
-static int handle_one_ref(const char *path, const unsigned char *sha1,
+static int pack_one_ref(const char *path, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
@@ -130,7 +130,7 @@ int pack_refs(unsigned int flags)
 	/* perhaps other traits later as well */
 	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
 
-	for_each_ref(handle_one_ref, &cbdata);
+	for_each_ref(pack_one_ref, &cbdata);
 	if (ferror(cbdata.refs_file))
 		die("failed to write ref-pack file");
 	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-- 
1.8.2.1
