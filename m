From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/33] pack-refs: rename handle_one_ref() to pack_one_ref()
Date: Mon, 22 Apr 2013 21:52:31 +0200
Message-ID: <1366660361-21831-24-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMw0-0007GU-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab3DVUBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:44 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63878 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755143Ab3DVUBn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:43 -0400
X-AuditID: 1207440d-b7fd06d000000905-a3-517595587695
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FD.0E.02309.85595715; Mon, 22 Apr 2013 15:54:00 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOa008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:59 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqBsxtTTQ4MddMYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y9v0/S8F2joqH05awNDD+
	YOti5OSQEDCRaN10ih3CFpO4cG89WFxI4DKjxJ7d3l2MXED2BSaJ0/N2MoMk2AR0JRb1NDOB
	2CICahIT2w6xgNjMAg4Smz83MoLYwgJ+Er+2PQGrYRFQlfg27zvYAl4BV4kzH+eyQixTkDi+
	fRtYPSdQ/HTHCRaIxS4SKw5OZZnAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5m
	iV5qSukmRkio8O5g/L9O5hCjAAejEg+vgHtpoBBrYllxZe4hRkkOJiVRXo4pQCG+pPyUyozE
	4oz4otKc1OJDjBIczEoivKL5QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgRvBshQwaLU9NSKtMycEoQ0EwcniOAC2cADtCESpJC3uCAxtzgzHaLoFKOilDiv2ySg
	hABIIqM0D24ALKpfMYoD/SPM6wHSzgNMCHDdr4AGMwENzkwoARlckoiQkmpgNE5cs95zDq+k
	YejdskmHZT711HcdFzwfr72mrag9Uat/d0pUo4dK7IpVpTZGX1crrf4fxL9N4mfNrKOsfkEi
	Ib1f8r898NvKKfXiVKU0M7N+hpDhyptfn7YFrDUSOKcb45cXEMDan8ifsvmy4O0tIssbj9fv
	nv0uxWSljXejwRbu1Z9+ii5RYinOSDTUYi4qTgQAGIAQssUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222079>

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
