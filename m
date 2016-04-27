From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/29] lock_ref_sha1_basic(): remove unneeded local variable
Date: Wed, 27 Apr 2016 18:57:30 +0200
Message-ID: <6d5914605a939efe1bbe294ad121a002d69d329a.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnT-0003nF-3i
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbcD0Q63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59411 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753466AbcD0Q6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:25 -0400
X-AuditID: 12074413-473ff700000008c7-fc-5720efb0f645
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 22.58.02247.0BFE0275; Wed, 27 Apr 2016 12:58:24 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6Q022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:23 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvhvUK4wbUVFhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozpD1rYC7bxVfxZ3cDUwDiJu4uRk0NCwERi5eIm
	ti5GLg4hga2MEs1rO5kgnONMEvd2PWAHqWIT0JVY1NPMBGKLCDhILF/5ix2kiFmgiUni+/Im
	FpCEsICPxJN1rYxdjBwcLAKqErfXx4CEeQWiJD6+e8kMsU1O4vL0B2wgNqeAhcSX1reMILaQ
	gLnEkger2Scw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERJiwjsY
	d52UO8QowMGoxMNbIKEQLsSaWFZcmXuIUZKDSUmUd8lZoBBfUn5KZUZicUZ8UWlOavEhRgkO
	ZiUR3ulvgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQne8ndAjYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGIgvBkYBSIoHaG8pSDtvcUFiLlAUovUU
	o6KUOO8CkIQASCKjNA9uLCxxvGIUB/pSmHcqSBUPMOnAdb8CGswENPjyIVmQwSWJCCmpBkaL
	z9WepYYLnq25K6HMPOmE1L0dUz48fPHr1J/VojPuseqf9r/fsIlVRY/774adgaeNJ/EfdNo0
	UX/DeYvUmAL5HUnnj2QZnjOsXL1cXdjmzqT/j8pnbW5a9GaqdbVST6y++l3/sn8l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292754>

resolve_ref_unsafe() can cope with being called with NULL passed to its
flags argument. So lock_ref_sha1_basic() can just hand its own type
parameter through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1d2ef2a..b8c1779 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1767,7 +1767,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
-					    unsigned int flags, int *type_p,
+					    unsigned int flags, int *type,
 					    struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
@@ -1775,7 +1775,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int type;
 	int lflags = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
@@ -1795,7 +1794,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
-				     lock->old_oid.hash, &type);
+				     lock->old_oid.hash, type);
 	if (!refname && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
@@ -1813,10 +1812,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
-					     lock->old_oid.hash, &type);
+					     lock->old_oid.hash, type);
 	}
-	if (type_p)
-	    *type_p = type;
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-- 
2.8.1
