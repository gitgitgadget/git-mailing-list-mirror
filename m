From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/33] verify_refname_available(): adjust constness in declaration
Date: Fri,  6 May 2016 18:14:05 +0200
Message-ID: <b2d414be0f99be4a0f9d7325eb43a1eb85dd7fa9.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPN-0008Qc-Fl
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705AbcEFQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:07 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63363 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758677AbcEFQPE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:04 -0400
X-AuditID: 1207440c-c53ff70000000b85-1b-572cc3087aa6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 05.74.02949.803CC275; Fri,  6 May 2016 12:15:04 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV6031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:02 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMtxWCfc4MsTXov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8azGSdYCz5yVhyb08XcwPiQvYuRk0NCwERi0fVl
	TCC2kMBWRok7D6K6GLmA7ONMEismrgcrYhPQlVjU0wxWJCIQIdHwqoWxi5GDg1ngM6PESm6Q
	sLBAqMTnrzdYQGwWAVWJe6vmsILYvAJREu+e72KC2CUncXn6AzYQm1PAQuJQ73GoveYSHWtv
	sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyS8eHYwflsnc4hR
	gINRiYf3wGntcCHWxLLiytxDjJIcTEqivN8LdMKF+JLyUyozEosz4otKc1KLDzFKcDArifBe
	2QeU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8AYdBGoULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB4V/fDEwAkBSPEB75UHaeYsLEnOBohCtpxh1OY7s
	v7eWSYglLz8vVUqc1wCkSACkKKM0D24FLJm8YhQH+liYdxJIFQ8wEcFNegW0hAloyfu5miBL
	ShIRUlINjPEbTb6H9Z9bpctrfkOa94m58Gq5fuGzYv872ZxvP+yKrjnd6bv94SSL3nvLElzW
	aKof3yPLeNChWbJq8yRG6UDF3/VrYjtfGarKxb85fFRM/iXPxbzoA9eNXooXnlZq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293812>

The two string_list arguments can be const.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 refs/refs-internal.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ad53b6e..f0eef9e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2299,8 +2299,8 @@ out:
 }
 
 int verify_refname_available(const char *newname,
-			     struct string_list *extras,
-			     struct string_list *skip,
+			     const struct string_list *extras,
+			     const struct string_list *skip,
 			     struct strbuf *err)
 {
 	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 85f4650..9686e60 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -116,8 +116,8 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
  * extras and skip must be sorted.
  */
 int verify_refname_available(const char *newname,
-			     struct string_list *extras,
-			     struct string_list *skip,
+			     const struct string_list *extras,
+			     const struct string_list *skip,
 			     struct strbuf *err);
 
 /*
-- 
2.8.1
