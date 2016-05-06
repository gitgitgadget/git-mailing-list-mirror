From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/33] commit_ref_update(): write error message to *err, not stderr
Date: Fri,  6 May 2016 18:13:50 +0200
Message-ID: <76fc394d50efef8f1308a0f0d56087f502dac689.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:16:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiQ6-0000at-9z
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758631AbcEFQOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63737 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758533AbcEFQOh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:37 -0400
X-AuditID: 1207440d-bc7ff7000000090b-b8-572cc2eddf43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CF.38.02315.DE2CC275; Fri,  6 May 2016 12:14:37 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUp031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:35 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqPv2kE64wbMDfBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxdM14wFqxjqTi+fCNzA+NJ5i5GTg4JAROJq3c7
	gGwuDiGBrYwSDQfnMUI4x5kkWo8tZwOpYhPQlVjU08wEYosIREg0vGoBKuLgYBb4zCixkhsk
	LCwQJjHpzXZGEJtFQFXibOM0FhCbVyBK4s3PvYwQy+QkLk9/ADaSU8BC4lDvcbCRQgLmEh1r
	b7BPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkwHh3MP5fJ3OI
	UYCDUYmHN+OkdrgQa2JZcWXuIUZJDiYlUd7vBTrhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	r+wDyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHiDDgI1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiIL4YGAMgKR6gvfIg7bzFBYm5QFGI1lOMxhwL
	ftxey8RxZP+9tUxCLHn5ealS4rxzQUoFQEozSvPgFsFSyytGcaC/hXkvg1TxANMS3LxXQKuY
	gFa9n6sJsqokESEl1cAokunOfWPT9xcvX5bwLL24aX/GizXSyZt/Fa233HMt5sNfl6g8x8dJ
	Tb/XaM2Uqf/kUMTLI9WTIFf4pOJaRwNzxt7GbvONy5ddPRrkN2/D5sqlLek5Dz2/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293823>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0cc116d..2d3a8c6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2719,7 +2719,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		}
 	}
 	if (commit_ref(lock)) {
-		error("Couldn't set %s", lock->ref_name);
+		strbuf_addf(err, "Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
-- 
2.8.1
