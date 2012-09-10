From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/6] api-string-list.txt: initialize the string_list the easy way
Date: Mon, 10 Sep 2012 23:18:46 +0200
Message-ID: <1347311926-5207-7-git-send-email-mhagger@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBOM-0000q5-2e
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab2IJVTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:25 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59114 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884Ab2IJVTT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:19:19 -0400
X-AuditID: 1207440d-b7f236d000000943-dc-504e59566860
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 02.B5.02371.6595E405; Mon, 10 Sep 2012 17:19:18 -0400 (EDT)
Received: from michael.fritz.box (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALIwqR020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:19:17 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqBsW6RdgsLBNw6LrSjeTRUPvFWaL
	2yvmM1v8aOlhdmDx+Pv+A5PHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cdcf+UaMEf
	topHx9YwNzB+Y+1i5OSQEDCR+NUwHcoWk7hwbz1bFyMXh5DAZUaJZe+WMUE4Z5gkNpy9wAZS
	xSagK7Gop5kJxBYRUJOY2HaIBcRmFkiR6HjezQhiCwuESFw8eRUsziKgKrFpQTNQLwcHr4Cz
	xOPzXBDLFCV+fF/DDGJzCrhI7O7fyg5iCwGVfF/xj2UCI+8CRoZVjHKJOaW5urmJmTnFqcm6
	xcmJeXmpRbpGermZJXqpKaWbGCHBw7uD8f86mUOMAhyMSjy8Gjx+AUKsiWXFlbmHGCU5mJRE
	eQ1DgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeOM1gXK8KYmVValF+TApaQ4WJXFetSXqfkIC
	6YklqdmpqQWpRTBZGQ4OJQnekgigRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ
	XMQXAyMDJMUDtDcXpJ23uCAxFygK0XqKUZdj9s0V9xmFWPLy81KlxHkNQIoEQIoySvPgVsBS
	xStGcaCPhXm7QKp4gGkGbtIroCVMQEt8PXxAlpQkIqSkGhgj1IOs7W6y3kmqfCDKsuKGjt+O
	4ylGypXMn0wXxxtqXIqau/xjYzZflJWA5F6pQwmZPLmFuyZunXC78oFUrPeT78esDlnxtecH
	HObfP9Nr3a+5WVmHmZ/cvLThYcSylWaH2D+HzpgtOz/Z2nT3vIji7M1969s1nvuf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205191>

In the demo code blurb, show how to initialize the string_list using
STRING_LIST_INIT_NODUP rather than memset().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 231a877..88330ff 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -44,10 +44,9 @@ member (you need this if you add things later) and you should set the
 Example:
 
 ----
-struct string_list list;
+struct string_list list = STRING_LIST_INIT_NODUP;
 int i;
 
-memset(&list, 0, sizeof(struct string_list));
 string_list_append(&list, "foo");
 string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
-- 
1.7.11.3
