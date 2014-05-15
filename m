From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 28/44] refs.c: make write_ref_sha1 static
Date: Thu, 15 May 2014 16:15:25 -0700
Message-ID: <1400195741-22996-29-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tq-0007Dp-31
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbaEOXRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:06 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:49102 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so108284ykp.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a6K7zJttxXvgoqUVz4ulMAcVH6h9+FFwPWwq0DNt0dM=;
        b=XNfEHs7J6DD9zVwLktKrG5WS16eYBoN8pRsZ5Yu/7bBlgy8iLEh4lnf4Or/J4Lyrrn
         3slHZUgtxrKfSMRw+0HOIqtWMmmmKWto88Em+TZyE8QcufwRDxGZ7gYOi7CeYpBP2iPc
         OEZYgOrU57hq8eMlAUv9VszBUzYiNt0qkXlioXDxduLiapiCZTA9peBoCx3hcS8fBdgZ
         C5fUjEFeEzstHn6FqGzchtFrDfQbPyZWXhZWHNa5SGl8L1ukr7ihG/7yn3BFOc2hraGR
         J+bylAm47ncI2VX4UwdyUAhcP3f9lR0Rd6lrXuRMm33SM7xTZAvapnO2qd6mTtG/i9Sa
         0dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a6K7zJttxXvgoqUVz4ulMAcVH6h9+FFwPWwq0DNt0dM=;
        b=GR+cLvNJdBPS0fyeCvTxSm2ilFyKK7+jlzyxVTEjxZDqO0h1UEv8EICQIE1eOBF9lo
         88Vp9xD6jhf1+01Rf9+ScUCDnThhIjSyDEhFoow7s36lYPMwl1kRUt1qG7LVe40m6RrC
         kNXy9eQtj9V7JaZ6sCv5k/Rt96/000K5Tl1e7D/K24DK28LxKjl2hj8Efu3bRe40izFb
         5XTfjgq1o489DiiGSpuEGy5CIuONv7q0Aj5+asrgxhewdtV6q2bmDTCkhtWExMwIjl0q
         F1kLwX3rA1D9EUeSx/W1YtGDhlCDmSSNmN7MittZtRyJVfQPC4PhC6b3yQ5U83H+GVRW
         uEIA==
X-Gm-Message-State: ALoCoQn0O7oDbZGcwnsF8QfhM7QodhQanWzu5sef7VgpR5PrrQFTWH9xyO7IZMukjoxFbUdUF2IR
X-Received: by 10.52.36.211 with SMTP id s19mr5569168vdj.7.1400195745636;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318641yhk.4.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7D36331C25B;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59572E0FBE; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249247>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 016206b..6151c3c 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2833,7 +2835,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index 608ca10..a45712c 100644
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
2.0.0.rc3.477.gffe78a2
