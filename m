From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/29] safe_create_leading_directories(): improve docstring
Date: Wed, 27 Apr 2016 18:57:18 +0200
Message-ID: <4e04c27d057a757f82d039d4875a95229e68ac4e.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 19:00:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoq-0004Mm-3A
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 19:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbcD0Q75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63723 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752710AbcD0Q6K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:10 -0400
X-AuditID: 12074412-51bff700000009f7-ad-5720ef9cb8a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9F.56.02551.C9FE0275; Wed, 27 Apr 2016 12:58:04 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6E022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:02 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDvnvUK4wcfD4hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxfr/6wFDxlq5hy9yJ7A+Nh1i5GTg4JAROJNV/n
	MnYxcnEICWxllDi2/TeUc5xJ4uvDVWwgVWwCuhKLepqZQGwRAQeJ5St/sYMUMQs0MUl8X97E
	ApIQFvCWeNn5C8xmEVCVaGnaxghi8wpESbzd+YMJYp2cxOXpD8CGcgpYSHxpfQtWIyRgLrHk
	wWr2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBJnQDsb1J+UO
	MQpwMCrx8BZKKIQLsSaWFVfmHmKU5GBSEuVdchYoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3
	+hugHG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBO/Rd0CNgkWp6akV
	aZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAoiC8GxgFIigdobylIO29xQWIuUBSi9RSjLseC
	H7fXMgmx5OXnpUqJ8y4AKRIAKcoozYNbAUsprxjFgT4W5r0AUsUDTEdwk14BLWECWnL5kCzI
	kpJEhJRUAyPvb9Xj15QMTm26cv3qw77inTY5/LeWshaebj6cf/hZXC7rxkNFnF0aDovPbXyx
	6lFq7tXcQl/Tnz97pQ9GKD3Y+fLrAU6TgO4npQvMZmRmbN51Rf/LsZcb1/3I4Ct+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292771>

Document the difference between this function and
safe_create_leading_directories_const(), and that the former restores
path before returning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048..4134f64 100644
--- a/cache.h
+++ b/cache.h
@@ -993,6 +993,11 @@ int adjust_shared_perm(const char *path);
  * directory while we were working.  To be robust against this kind of
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
+ *
+ * safe_create_leading_directories() temporarily changes path while it
+ * is working but restores it before returning.
+ * safe_create_leading_directories_const() doesn't modify path, even
+ * temporarily.
  */
 enum scld_error {
 	SCLD_OK = 0,
-- 
2.8.1
