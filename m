From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Define constants for lengths of object names
Date: Thu,  1 May 2014 11:06:50 +0000
Message-ID: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 13:07:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfopX-0003A3-Og
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 13:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbaEALG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 07:06:58 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47433 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409AbaEALG5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 07:06:57 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9C85528087;
	Thu,  1 May 2014 11:06:56 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247809>

Using preprocessor constants rather than hardcoded numbers is considered a
good programming practice.  Provide two constants, GIT_OID_RAWSZ and
GIT_OID_HEXSZ, which are the lengths of an SHA-1 object name in bytes and
hex digits, respectively.  These names are the same as those used by
libgit2.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 6e12f2c..f1cff2d 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,13 @@
 #ifndef OBJECT_H
 #define OBJECT_H
 
+/*
+ * The length in bytes and in hex digits of an object name (SHA-1 value).
+ * These are the same names used by libgit2.
+ */
+#define GIT_OID_RAWSZ 20
+#define GIT_OID_HEXSZ 40
+
 struct object_list {
 	struct object *item;
 	struct object_list *next;
@@ -49,7 +56,7 @@ struct object {
 	unsigned used : 1;
 	unsigned type : TYPE_BITS;
 	unsigned flags : FLAG_BITS;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_OID_RAWSZ];
 };
 
 extern const char *typename(unsigned int type);
-- 
2.0.0.rc0
