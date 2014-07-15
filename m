From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/20] refs.c: make lock_ref_sha1 static
Date: Tue, 15 Jul 2014 16:34:13 -0700
Message-ID: <1405467258-24102-16-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFn-0003aH-1m
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbaGOXfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:35:05 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:49608 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934317AbaGOXeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:25 -0400
Received: by mail-yk0-f201.google.com with SMTP id 9so7115ykp.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15AHnvsTDP+B3JQ8HZfdE+YNiQjA9vPis4nf+I8bemI=;
        b=I543B9glusD2Tf1m6HSfhVPEKbvGLFduKS0fD45T3nMP+hlmp11ebFFqElWTcFZomO
         b7nSHNPBv1RNI8AULl1syGNnQGXcUw99EITRCU90ozugipLP5itxU/UfSF5fNtTRFSAZ
         CVYyxSiTfM7CnfDXzSg7Bllfh+FWqXRl2fAC0QzNkWRJF1bYiGHYtJUvPOsQUx5cmNqY
         Y9RMXM7AthWPBEFBMIpb0mX0ePljYABrJSrm3TEiTZmJ9T/AfM7jjEUolyDOP/bZ31P/
         yOEKgoDntV1Wsfr0WVbp6b1PpF1cknatWyBnLITs4rzjHUqgIhqQdY+X0E3s+HJ9YVoN
         py9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15AHnvsTDP+B3JQ8HZfdE+YNiQjA9vPis4nf+I8bemI=;
        b=I96vM1qboNVzPCHNjc7fERTiRJU76krx2gljW5vRIh0kSbYIxSnLxFE1/LOVRGujU0
         0ElI22Y0a7+uS6MFr7w489eCg4LIZK+zdUlhAZSxaAY7Ws04397zPUYFar+yMsvRA//z
         QJHBIjNa658XTVtDMhNKSsYKk7UcFmPWL/8lFS1IIz4cCvULHi4I+d6FTXZXvtvPBkaM
         NHHv6OeshCi1TSrBl3wd63OicggdiTEuH5Gc/6l/o5xZuKbaR9vR6I3Tnxh6mGzcoNiX
         Lp8ylBuOkS+Gal9L2QxETnfocnQVIukKiX4uxsi6wHcSX/X3Ad95tjeTz9tKEDMaQ2KB
         aiiA==
X-Gm-Message-State: ALoCoQn6+R+UjzvLMvp59/OJDzVF0mSQFsjEED8se0bpxpM3Z8rE7pqRLi32mX0mCaclpkh3zhcd
X-Received: by 10.236.164.106 with SMTP id b70mr10826224yhl.1.1405467264835;
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1058686yhl.7.2014.07.15.16.34.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AE9F931C2D7;
	Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 72609E0B27; Tue, 15 Jul 2014 16:34:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253638>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index ff4e799..10cea87 100644
--- a/refs.c
+++ b/refs.c
@@ -2170,7 +2170,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index 3f37c65..65dd593 100644
--- a/refs.h
+++ b/refs.h
@@ -170,12 +170,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
- */
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 /* errno is set to something meaningful on failure */
-- 
2.0.1.442.g7fe6834.dirty
