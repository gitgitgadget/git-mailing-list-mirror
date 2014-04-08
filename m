From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] Remove the close_ref function.
Date: Tue,  8 Apr 2014 14:17:10 -0700
Message-ID: <1396991830-20938-2-git-send-email-sahlberg@google.com>
References: <1396991830-20938-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 23:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXdOm-0001nS-PR
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200AbaDHVRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:17:34 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:49453 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171AbaDHVRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:17:19 -0400
Received: by mail-oa0-f73.google.com with SMTP id n16so328136oag.4
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K3QMWv0EDx7WMhjYMDMhC0/wg9IItxSMRWGStoBKDo0=;
        b=RiAHbMo5cxuQ0dKeTecK4zFMJStnm82ldL2g06JuoKdWUO6vxoPuZSvUdn6JeZOFes
         Xg/txcnp8DIpDR90/OP7o+lymXndcQQbvO2U7Z4JZd6Z5uLO+1dMj7Hvx+yQQUoMgqnr
         P/YTTGGPUKqhWUYqA00OXlmGDNfgQ4M+qu/qNX7vzeFwHq0BcPURyslE+Bwggi9dpCQd
         43cqkd9wNzQ63qnIfYmsoJdEDfCY9Nkto+/fm477xopIfikAO1grHzbhqHXlscFhEtbC
         yDW3MfqzUwI22YJqwH3H5hFTabrN3kKbztG1+U1DS7GOK/5MKIHeItMux3QIJdmAJsTJ
         Ggyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K3QMWv0EDx7WMhjYMDMhC0/wg9IItxSMRWGStoBKDo0=;
        b=MrI5QSRmPG8ovtQ3PBDx4q93DNfOATstu/q4Wgp7yltxwg5Zw5T8Akc08zdRuiuRvQ
         TKcr5dbU2YoPf33vVVn2fHlDfamM6GeDPZmWolUOvIObH6K2lomL+/5J4fNMXV41EPKY
         w1WQi4R+UFe915VBhqIEu+A43kVUretamWYDVU8q+YRtSAIK1y/a9N8dfzFkuH1+cBkL
         bcwAJ6yNkMByTW1/qV2VVHivTgH70L6/WvRXc5yH1tW4mrrhYH8DxS9aBPfp1yKlOUSV
         Jvc4xDhGQaokeWt56NKnzaKO0mpWPj7529Gvfd4/Y2yKmt90tnaFYVKHKaodEoqcLewW
         3p1A==
X-Gm-Message-State: ALoCoQm8OUdV2WCgVr0Gnylv83n47UBiPa2wOYAm2Y83nsuyRDtbI+5hbT6pyeKGwes66bAzHfhVB9FYtxJ9fQd8GPPJZ9GzE9Wme6eOby7ZnjlvRGMrhtN8RBxAicWx/eHlbUm7HjzQTR8ZwMjBFt52aEzNGNWFDwy1T+lm1zQHIJV2VNkoUygdqNkaoH830iHfZYpiyU9P
X-Received: by 10.182.22.133 with SMTP id d5mr3000879obf.27.1396991838778;
        Tue, 08 Apr 2014 14:17:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si636126yhb.6.2014.04.08.14.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Apr 2014 14:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 912705A4223;
	Tue,  8 Apr 2014 14:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 53554E07A7; Tue,  8 Apr 2014 14:17:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.475.ge4eef26.dirty
In-Reply-To: <1396991830-20938-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245958>

close_ref() is only called from two codepaths semi-immediately before unlock_ref() is called.
Since unlock_ref() will also close the file if it is still open, we can delete close_ref() and
let the file become closed during unlock_ref().
This simplifies the refs.c api by removing a redundant function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c |  3 +--
 refs.c           | 11 +----------
 refs.h           |  3 ---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c12a9784..b67fbe6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -428,8 +428,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		} else if (cmd->updateref &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
-			 close_ref(lock) < 0)) {
+			 write_str_in_full(lock->lock_fd, "\n") != 1)) {
 			status |= error("Couldn't write %s",
 				lock->lk->filename);
 			unlink(newlog_path);
diff --git a/refs.c b/refs.c
index 28d5eca..094b047 100644
--- a/refs.c
+++ b/refs.c
@@ -2665,14 +2665,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
-{
-	if (close_lock_file(lock->lk))
-		return -1;
-	lock->lock_fd = -1;
-	return 0;
-}
-
 int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
@@ -2824,8 +2816,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) != 1
-		|| close_ref(lock) < 0) {
+	    write_in_full(lock->lock_fd, &term, 1) != 1) {
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
 		return -1;
diff --git a/refs.h b/refs.h
index 87a1a79..d8732a5 100644
--- a/refs.h
+++ b/refs.h
@@ -153,9 +153,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
 /** Close and commit the ref locked by the lock */
 extern int commit_ref(struct ref_lock *lock);
 
-- 
1.9.1.423.g4596e3a
