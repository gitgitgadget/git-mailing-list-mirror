From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 35/48] refs.c: make lock_ref_sha1 static
Date: Thu, 12 Jun 2014 10:21:26 -0700
Message-ID: <1402593699-13983-36-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iZ-00087X-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbaFLRW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:59 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:33754 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so309761iec.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uSYZexX36BntJEIrPoMXVBP+z+Szn8eyv1ZMv8Oaceg=;
        b=BdPjJh4ptXLp+/hot2wnYloetDBh/8ZxZnDu/EC7o9D3Hr254055Y6xfShf+BBp3Ev
         nRjAYUeO6v+Nc/XIIkmKJ+2z2KBDOkA9VgkU9H4WU5NG4TuRqKcr6hHjmg68QisKr6tN
         tqQk4VVP4XdHDMT78tn1soYfE/vpfhXngpz+zuO8gikI9AECHQTtQKuWKR1/3pmBOIeB
         58fQcAZcmzBGLxHtcgP8c/TMFDoGasdBT4APNgC7dcVbEAO+A/OEp2o1NQvl0Ib814Ad
         7Oc+PacC9w9h5Vx8ZWdCYp4UEKVEFKl/u/t27rf+5sE6qoXSDcUrlWw8Dj5MJqQXI2XP
         MzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uSYZexX36BntJEIrPoMXVBP+z+Szn8eyv1ZMv8Oaceg=;
        b=FnocERXZuXwYjfThw3fkMw5uOQBCmcB7nMHNo2KkkRaFVXSJkFVesyJfFjDdRNxZI9
         ytSOZaSOcxXQBwnP2hUDWghF7BliNQ6yhCncfmadL4Ce2sOWZHSKRL0ZHywlom03AXEr
         oKeZYT2pFBxvnsCHJ+62zFNnwOJMw23jI4crvJGH2+pOgNbH6KDnK7SY7nfyOQZKJwOl
         TZNnzEADwz6QvOgXRY1xZznJMPrQruIZwKdP8ap7gL+nwlgdNCFvMoNSuEx+tceZKtJ9
         xC2QH7YBg4R7qOjAiq4gvccRGUOFbh+k+2Q83cw+sZNU3UjXnNAIjRTVWz45Gh2bGUXR
         ZFvQ==
X-Gm-Message-State: ALoCoQmSSvs3vjjGYEJk/IeQtk4BRtrbWqdwhBWbE7NPtgtqmIG9Dwgxff3hRp4+sPxBhxVK7sUc
X-Received: by 10.42.194.207 with SMTP id dz15mr5678572icb.10.1402593704582;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si111890yhp.6.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6C39B5A47F2;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2DC81E01A0; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251440>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 30b5db1..8c0f046 100644
--- a/refs.c
+++ b/refs.c
@@ -2143,7 +2143,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index c27467e..21ec3f9 100644
--- a/refs.h
+++ b/refs.h
@@ -173,12 +173,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningfull.
- */
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 /* errno is set to something meaningful on failure */
-- 
2.0.0.599.g83ced0e
