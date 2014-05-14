From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 26/42] refs.c: make write_ref_sha1 static
Date: Wed, 14 May 2014 14:17:00 -0700
Message-ID: <1400102236-30082-27-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgb3-0007HV-8a
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbaENVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:52 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:54678 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbaENVR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:29 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so36226pab.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyPz8lhQfPyhELh8+yhkgoBrDKSCYIm5+e6IweDb7H4=;
        b=c6FXOwLoZtF+UvazDeHlw4OwYf/UxbB/zvjLaIEXE7tD7q9pPI2hkCUVy3LEfw6/o5
         R5TxigZl6JpiceQnQNeW7h8wmeoPNPLD1Gmq2DP3XOOLH05aafSI0eSm5LQ+BZS9hKKL
         A6Px7Pa4tF2TDZe7QvOnBcMg3A+DmtoTKQlYING6iWAJJqG4iNiiV+IxLKXvhxwoAWHY
         o3lZFdC7ecansvCEInmv8RcBqr7ypP3y64JBhgkAZJJjkxK5tsuS9BUGEEJviruj0GuB
         Ghb1RDWU0iWZVJRjoowp0GXFzRfrItWJR2F9egM2h63YldFVfLYGpJgL7gKP+UIsMOfZ
         OPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyPz8lhQfPyhELh8+yhkgoBrDKSCYIm5+e6IweDb7H4=;
        b=OcI+jm7eM3Vf0wEdbUfNnT6fgiqBcSO3gKn/UqUG3w/nGH7JZvsD3m3WCGavHA0nz1
         ETceSAwsPQYtbhDey88atVFgsVbrVSxPkRNcVSEyU/KjIcWbqofcwzPfxLojE2jkjpUJ
         Er/LLEazPUtGDSlKPhPigFXp+sJ1k8je0vrTl2qBfUArwG1W2rSZDD99pZWXct6oC0kb
         TOyriemjDtNHrzvsUjG3UonudqZVTZEWjfjB0RuUN8KUjKqv25Kww0Yu2T2cdjMjaYug
         KGFUf1Qvc66lLj47X4j5gPnPU5mJlTswDisbtcfj0wYP4XakcC8P0WtyDaBcL6s9NSda
         vG7g==
X-Gm-Message-State: ALoCoQkMVAIoCLzC2OJI8hwf6Oc0Tl5GMCUyl08n0ZUOzJRckxj08G8OU3AUzaAb7IVbgMO5VyWf
X-Received: by 10.66.148.10 with SMTP id to10mr2939860pab.12.1400102248812;
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si145200yhk.4.2014.05.14.14.17.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9F0805A42DA;
	Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 61A07E0973; Wed, 14 May 2014 14:17:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248980>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4673cf4..0e88197 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2794,7 +2796,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index b7535b5..9e7a1ca 100644
--- a/refs.h
+++ b/refs.h
@@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.471.g2055d11.dirty
