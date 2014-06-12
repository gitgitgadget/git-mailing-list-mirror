From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 48/48] refs.c: make write_ref_sha1 static
Date: Thu, 12 Jun 2014 10:21:39 -0700
Message-ID: <1402593699-13983-49-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hm-0007Gc-LA
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbaFLRWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:21 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:60206 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so309107ieb.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a7KPEQNGCmfyiz7O+X35v9z9+RKASWxVqhBuIFvXmEk=;
        b=Ykl5Su+jdy7+92i70fRusWQXBWI65JEDeKHQXuTreWk8Hcues7QDgMym2rMzRqSSzx
         1XwulW13Uu1cTcRaGwplc/2Q6Mt8Cjo0qVbwhKaNwgQ+ex0jcwJDBUZ3qVg8OQcjIsTJ
         kwzFgwib9jEO6x17NPoVqjI3Mqi+4S/EhANNgrNQ9pOsDiV3HG5+KVmiS0xNJyQDlP1A
         KJZyhmJT/nVnG8aZGC6k51gnHXGZuvfsm3V9+cjHSeflfmrSRsiK/KptUwAw4SywgncT
         GtZpHz3LqbOnOEac229k3V9285VlMeR6Bw4bQPZWtLeBROBqrbbQut65nGCu3CEjTw2T
         sAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a7KPEQNGCmfyiz7O+X35v9z9+RKASWxVqhBuIFvXmEk=;
        b=kAufu3SN0Kw+Yh0o+C8PtR6ucIo5K8xeG1JlZIkqbDlHHm/Ax/8q0IQiLNu3uGxoqA
         gdYoIMWF2XGIm2bebzYeJHWe1jrM3SwmSGG6ThmjkBsu+E9ipJ71RqnEkWTZsiak46X+
         +tTUBPvvfyx7ir87uirTjtQlXFMOB05q5D2BD9u3KlcQAqtoPudpxvtXrZ2gYVi4ppXm
         Bb8mtzlkvWPe4HZygRTFoh6JSRW2pI03xYiHdcHcBxv2glMnkzD/tdrosa2RYkPyf16i
         yAYXbesWoNKBtkWPzORpdmNCkU2GEBU5XLTGMoOSmNr/ODRFHHvFwa3RqBtB/FV9q3q2
         70jg==
X-Gm-Message-State: ALoCoQnY7LKTNKMWyHLT8yfMqZkXnmcAbVyoq/wOH+yVCEorbQcDgFjrvkr5SsFk/h92CJsOJdK0
X-Received: by 10.182.249.115 with SMTP id yt19mr358224obc.25.1402593705017;
        Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si111189yhl.7.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D42F85A47FA;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B6BC7E0A87; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251427>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8917832..31d7616 100644
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
2.0.0.599.g83ced0e
