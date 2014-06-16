From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 48/48] refs.c: make write_ref_sha1 static
Date: Mon, 16 Jun 2014 11:04:19 -0700
Message-ID: <1402941859-29354-49-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbIF-00050U-Q0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbaFPSFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:21 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:35171 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so683840qcv.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEHbcZhScnxohlIGsIACKC/724RScr0tfVDuCcSl9Bc=;
        b=cgMoQ3YVmEmLxk4bZjW/yDLDcO+yqXwWo1NM1RLwI69Oqy+QkzNI7BliDAEGxqVHkq
         w2Av0IruXAPAdWhLxMIPkBu/HQLFvB62s3DUdtAj9/fQ5kQUM8o9JGrWMjVibsWFAfd4
         GRikmw/TQQfyzhtOQQa4yj7C8rRR2xuGj8GLeidkl5pgIJ9Mcd+yoEsWR9OWasZsjJgq
         Xn+xGHCgbp+mRz9WZB0JZP2uhE5PcLkmK/t1gF3pagwfTb0X68ln4RR3O892ynPZkn/4
         dxXTR8LeeAvJzPxpU7d0S+NJBoOfaBGZw5CeBFRq5IuE3OdI8wddItimLwb1yL8FeKLy
         fvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEHbcZhScnxohlIGsIACKC/724RScr0tfVDuCcSl9Bc=;
        b=AYMrqxmTNH7XZbpjMJ1f8i52iBQ3xpJaTtSpHbFVplJ0ugcCXn4cFfOFMQliedAds3
         0kbeFBKbCuvjVfhvFi58d4+QBjvUWzug+99kmG65bURyufBZufOwG6tj4YKMyAdYq7iu
         Wo0F2Bm/WTL90J5WZGWdxKVo+YqrzSNQyErks5wLGnF3neytSFkvtmYe+agP36a1sh7n
         66TEkSJ59QbqA+rlOT/K5rioKw4LtE/sCIhFoEA8pujtQjuBNUD/EzCp+uhwqXvaiPJn
         fRLxK+VlqH50aE72HN1UlIf0MnVhkgyOP8Sgyevwvf44SZxZcDJS8Mo5XzgFJ3BdETGj
         7Lhw==
X-Gm-Message-State: ALoCoQkf/sWH9RSqxwrSzKNEsameWFFQ6Nz7Gt3Z87zeIfFRgzb6qG18ZBnzISQs/2dyARSR4SRL
X-Received: by 10.58.136.10 with SMTP id pw10mr5110569veb.8.1402941864210;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si998071yhg.2.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1539A5A4913;
	Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EBFF4E0961; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251758>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 47575e8..cb56e38 100644
--- a/refs.c
+++ b/refs.c
@@ -2639,6 +2639,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2888,8 +2891,11 @@ static int is_branch(const char *refname)
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
index e03ab44..da70e63 100644
--- a/refs.h
+++ b/refs.h
@@ -199,9 +199,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.0.0.282.g3799eda.dirty
