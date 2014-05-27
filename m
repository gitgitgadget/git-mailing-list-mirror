From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 41/41] refs.c: make write_ref_sha1 static
Date: Tue, 27 May 2014 13:26:00 -0700
Message-ID: <1401222360-21175-42-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxC-0002FS-AM
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbaE0U01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:27 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:40410 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so122274igb.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PI9y/+pQ77F/wX6A7+Rwa9jDKrX4qkXniluYH2cQNv0=;
        b=INC+zcJtVGX9Bvdk93eEAl0lY0htd2ZWTv4OWmYcTLmL0nPJfsjFYzxUauxQiiu4hm
         hSz4X87GUhX0TqQDJ+E5zcipEB9gSA1VIV6OTCdNlLyH1KpDsCrBHqEdrHMx4/JWLigl
         /P+rqatTT3RZTwoQqEwn2dc2z7Z5M8EKtsqFt/09X6BZfTunWDnXNDBF3YKv1LsSpS53
         ENnrN5T0Q+T7DeR5dH3k4W7YlkW1RLHzwhLBLVzOIwDiiXwWjktE7M/zGKPBBkQQQkrt
         3i5DWQd2L3F6liIWr7TeAC+Z8kUsBsYlfgypdAQRM4D1GvVgyz9fJ6KDGwEgrMKQhrlR
         5Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PI9y/+pQ77F/wX6A7+Rwa9jDKrX4qkXniluYH2cQNv0=;
        b=Wy/MGNvcfqJzND20THaF7KNI1jn91SUGWEKp9WFCgP4hsbXqzCxVkxNcuQUfBLyfqR
         4Z3jJ0MI/g4VuNiQeUt6PJi6Jyg2ZOFNcakl5d3D1kIj4J3xHRDy3TchQhxY3VDTItDG
         HBVHkMuxKoqarc3VwlPK+pq5rfSaCsckC3kucK+LSM1fvzWOObj0DmYIjcDVAHulE4vt
         /37jsqOosOAO7HG2PmFONONwUO6TYWDhn7YGvwkB9vQkUUzXw07Q99Zx/cW74JQUHUtr
         J22f1UjoDKq64kRNh9gwKHYFKhyPLP/WxYg1j7cM+fuM1YkeIv44agtvv66kyg0HrKpJ
         evxg==
X-Gm-Message-State: ALoCoQlOMYUVvfs5+MOhlspQRkEnm3CZFLN5QcNJZ8+a0/9Q31AedsHtUZBe3XZNy+NS+gXhKWt7
X-Received: by 10.182.20.195 with SMTP id p3mr14284031obe.26.1401222365644;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1574925yhk.4.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7B9B7370587;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B84EE0D62; Tue, 27 May 2014 13:26:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250202>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 refs.h | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c108007..2b51547 100644
--- a/refs.c
+++ b/refs.c
@@ -2622,6 +2622,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2855,7 +2858,8 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+/** Writes sha1 into the ref specified by the lock. **/
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index 2823b72..47775e8 100644
--- a/refs.h
+++ b/refs.h
@@ -147,9 +147,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.474.g0203784
