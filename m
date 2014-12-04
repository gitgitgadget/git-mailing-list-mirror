From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/23] refs.c: don't expose the internal struct ref_lock in the header file
Date: Fri,  5 Dec 2014 00:08:35 +0100
Message-ID: <1417734515-11812-24-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWc-00038c-4n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363AbaLDXJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:24 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65158 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933354AbaLDXJO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:14 -0500
X-AuditID: 1207440d-f79976d000005643-9a-5480e9999bf1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 24.16.22083.999E0845; Thu,  4 Dec 2014 18:09:13 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deK027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:12 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqDvzZUOIwazJchZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujL29/5gLNnFWzG5fztrAuIu9i5GTQ0LAROLGi0ZGCFtM4sK99WxdjFwcQgKX
	GSXmLWpihXCOMUn8OHqTFaSKTUBXYlFPMxOILSKgJjFz1WywDmaBE4wSvyZ3g40SFoiWeHB4
	F1gRi4CqRMvSNrBmXgFXiZZrG4BsDqB1chJb13mDhDmBwlNntoK1Cgm4SDzbtJB9AiPvAkaG
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghwcW7g/H/OplDjAIcjEo8vAW7
	60OEWBPLiitzDzFKcjApifKefdoQIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE1/gIUI43JbGy
	KrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHL9QKoUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7S0DaectLkjMBYpCtJ5iVJQS57UGSQiAJDJK
	8+DGwlLGK0ZxoC+FeUtBqniA6Qau+xXQYCagwWcbakEGlyQipKQaGMu01RLmVSww7j7rxtgh
	surqrwNLI41l2Z5UfT3uG9WZWDxl8uzOnzsyHzzgjjCYqbTp8iLuM6ketrNm7/n/qWZG6xO2
	jz36L7dpHGlg8nUqnq3xkrPr9A/nsOi36ivu1F7f5iNs8f/YzgVPPbv4r8oXr3r+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260823>

From: Stefan Beller <sbeller@google.com>

Now the struct ref_lock is used completely internally, so let's
remove it from the header file.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++++++
 refs.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index f3564cf..40c5591 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,15 @@
 #include "dir.h"
 #include "string-list.h"
 
+struct ref_lock {
+	char *ref_name;
+	char *orig_ref_name;
+	struct lock_file *lk;
+	unsigned char old_sha1[20];
+	int lock_fd;
+	int force_write;
+};
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 174863d..2957641 100644
--- a/refs.h
+++ b/refs.h
@@ -1,15 +1,6 @@
 #ifndef REFS_H
 #define REFS_H
 
-struct ref_lock {
-	char *ref_name;
-	char *orig_ref_name;
-	struct lock_file *lk;
-	unsigned char old_sha1[20];
-	int lock_fd;
-	int force_write;
-};
-
 /*
  * A ref_transaction represents a collection of ref updates
  * that should succeed or fail together.
-- 
2.1.3
