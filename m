From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/12] refs.c: make write_ref_sha1 static
Date: Wed, 16 Jul 2014 15:23:11 -0700
Message-ID: <1405549392-27306-12-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xkr-0007rq-8L
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbaGPWcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:32:50 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:51119 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbaGPWcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:32:48 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so482288iec.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDbbbjPfW4xZRt6qoQZjcEKRGzEmbYBBfcbSMMnDX34=;
        b=Z9Q4M8paMnkQpo7DqWtaDhMqH8zrNGlHSXSxwm0Rj6aTeOLf4lUfIzvbfG43WAVhfh
         cCQvdcIkZGbKM13/9vSGx7ayoSX0TYLNF2mn8KR+/UW0jCx5J7yj5EKcOgGUsR2KTNXi
         DyckSuuT0sU3ob/lykloh0AnVmJBh9bA47DoKQVyI7evipHRK2UEPfDwtAZYyTLrM5Dq
         C/56bD0jS7n0JB98SJubhmP2nhnzxKZtFEuDai2WTTVEok+seqSPaGpxY0TwqtIGxvOt
         MXe468SoA6+0hhCtriDeKalyKzn+yNSS8o0aA3UlJd5cGTtSftpElLZ9TZNBzgICaIWy
         z9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDbbbjPfW4xZRt6qoQZjcEKRGzEmbYBBfcbSMMnDX34=;
        b=SPka4XDqG/gE9nhT12No9XJGttenVJJXvuGXsADg93jcLuDmt0WQAZnc/KOyuPWJVz
         6GrGSBUXG+kXC9w8tLYhDdDbmwwAOEaraaOVuIAAI/AOJa3ch1IdUIODA5qc4Ni8ejok
         kT2aJqHEq+61R5yVusj1zzGt8DkEa3LRZRtlyZh9d/JYMc1gq5g4FCQcDvk+u69OBnlG
         My4kFZZ/NqscX2n9RNgGISQsItQB1NymWkAZwaz6K8/9vrKSRKw7AwV1M6N/HbonvXBg
         Kom+PyzTpql2RUnfHl7xHsK7rSga8bwODnseRCFiXWmbU/XPF8hlbC0wZmU633tDkeMN
         gyvw==
X-Gm-Message-State: ALoCoQnTMLCFza+0Zg7eqrs2gqz3SSX+4buOIq92Qv4ejpJF2SNqo4JWeh54DnzR923IcCuLGAhI
X-Received: by 10.182.55.104 with SMTP id r8mr16976353obp.11.1405549968058;
        Wed, 16 Jul 2014 15:32:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si78196yhv.0.2014.07.16.15.32.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:32:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1939231C321;
	Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9435E0700; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253713>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 69cbca5..6c7a9d2 100644
--- a/refs.c
+++ b/refs.c
@@ -2643,6 +2643,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2892,8 +2895,11 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-/* This function must return a meaningful errno */
-int write_ref_sha1(struct ref_lock *lock,
+/*
+ * Writes sha1 into the ref specified by the lock. Makes sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index fc7942c..b0476c1 100644
--- a/refs.h
+++ b/refs.h
@@ -196,9 +196,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.0.1.527.gc6b782e
