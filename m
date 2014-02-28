From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Fri, 28 Feb 2014 17:29:16 +0100
Message-ID: <1393604957-7571-2-git-send-email-mhagger@alum.mit.edu>
References: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 17:30:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQJz-0004Ph-De
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbaB1Q3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:29:55 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52397 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960AbaB1Q3w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 11:29:52 -0500
X-AuditID: 12074414-f79d96d000002d2b-3c-5310b9804655
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.57.11563.089B0135; Fri, 28 Feb 2014 11:29:52 -0500 (EST)
Received: from michael.fritz.box (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SGTLSe006566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 11:29:50 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqNuwUyDYYNsJAYvbM1uYLbqudDNZ
	NPReYbZYcXUOs8Xbm0sYLW6vmM9sMe/FCzYHdo+/7z8weTw70c7msXPWXXaPi5eUPT5vkgtg
	jeK2SUosKQvOTM/Tt0vgznjQ+ZmloFeg4s76RpYGxum8XYwcHBICJhJzd6h2MXICmWISF+6t
	Z+ti5OIQErjMKLH6bRsThHOcSeJA81pGkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCE5kkNh95
	ww6SEBZIlOjf+ogNZAOLgKrEyieeIGFeAWeJc0/vskFsU5BoWbYLrJxTwEViy/V/TCDlQkA1
	8zf6TmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJMhEdjAeOSl3
	iFGAg1GJh1dykUCwEGtiWXFl7iFGSQ4mJVHe6zuAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	Ly0GyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfDuBRkqWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qL+GJgZICkeID23gZp5y0uSMwFikK0nmJUlBLn
	TQBJCIAkMkrz4MbCUscrRnGgL4V594BU8QDTDlz3K6DBTECDOT3BBpckIqSkGhjZ8s3vVgkq
	zAmN4FV/OW290tr9BgoWio9nhBs6Nj06ud2ajSkgMnyq+rz+uBtyTJYtrZ+WFD3dGfMoNvPa
	1f2vTk0NWyGy4tDWJ1U2nxMdHq3gDPTfUf7Yq9U04Pp8zpsKF7fdz3blW1Jw6Eif 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242983>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h          | 13 +++++++++++++
 replace_object.c |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index b039abc..9407560 100644
--- a/cache.h
+++ b/cache.h
@@ -798,13 +798,26 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 {
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
 }
+
+/*
+ * This internal function is only declared here for the benefit of
+ * lookup_replace_object().  Please do not call it directly.
+ */
 extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+
+/*
+ * If object sha1 should be replaced, return the replacement object's
+ * name (replaced recursively, if necessary).  The return value is
+ * either sha1 or a pointer to a permanently-allocated value.  When
+ * object replacement is suppressed, always return sha1.
+ */
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
 	if (!check_replace_refs)
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+
 static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
 {
 	if (!(flag & LOOKUP_REPLACE_OBJECT))
diff --git a/replace_object.c b/replace_object.c
index c5cf9f4..31fabde 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -92,6 +92,13 @@ static void prepare_replace_object(void)
 /* We allow "recursive" replacement. Only within reason, though */
 #define MAXREPLACEDEPTH 5
 
+/*
+ * If a replacement for object sha1 has been set up, return the
+ * replacement object's name (replaced recursively, if necessary).
+ * The return value is either sha1 or a pointer to a
+ * permanently-allocated value.  This function always respects replace
+ * references, regardless of the value of check_replace_refs.
+ */
 const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 {
 	int pos, depth = MAXREPLACEDEPTH;
-- 
1.8.5.3
