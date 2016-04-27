From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/29] verify_refname_available(): adjust constness in declaration
Date: Wed, 27 Apr 2016 18:57:37 +0200
Message-ID: <2757ee65c6c9c9c389a6955adba9cea6d3fc5332.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnW-0003nF-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbcD0Q6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53611 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438AbcD0Q6h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:37 -0400
X-AuditID: 12074414-63fff700000008e6-59-5720efbd2358
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 54.72.02278.DBFE0275; Wed, 27 Apr 2016 12:58:37 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6X022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:35 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLv3vUK4we8ffBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyu/T3MBde5KpoeKjYwrufoYuTkkBAwkTj45QIr
	iC0ksJVRomOlahcjF5B9nEni1/89zCAJNgFdiUU9zUwgtoiAg8Tylb/YQYqYBZqYJL4vb2IB
	SQgLBEksX3QXzGYRUJVoubOBHcTmFYiSWLL4NAvENjmJy9MfsIHYnAIWEl9a3zJCbDaXWPJg
	NfsERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUICTGQH45GTcocY
	BTgYlXh4T0gphAuxJpYVV+YeYpTkYFIS5V1yFijEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHf6
	G6Acb0piZVVqUT5MSpqDRUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IEryowkoQEi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQREQXwyMAZAUD9De0ncge4sLEnOBohCtpxgVpcR5
	X4MkBEASGaV5cGNhaeMVozjQl8K8QSBVPMCUA9f9CmgwE9Dgy4dkQQaXJCKkpBoYs3/kxUt/
	lKlfaeqqzpRUm6SVn/np8g7WK3HntCxz82IuT6uvjgx+/UNLuXWV+e7rGw3+iO80nz0/Mq8z
	VU9k+yn/uKflrxqO3HabdJ/j5To3d0erYqWHJ1k3FQYK9vKHu87cZR308cM82/6A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292755>

The two string_list arguments can be const.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is needed because I want to add a new caller that has const
versions of these lists in hand.

 refs/files-backend.c | 4 ++--
 refs/refs-internal.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e4cdd5a..e0d9fa3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2328,8 +2328,8 @@ out:
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
index 6b53ba1..aaf56ea 100644
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
