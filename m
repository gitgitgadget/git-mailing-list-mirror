From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 48/48] refs.c: make write_ref_sha1 static
Date: Fri, 20 Jun 2014 07:43:29 -0700
Message-ID: <1403275409-28173-49-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03D-0001eH-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbaFTOoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:11 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62828 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so505226vcb.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5icHx6kMb1dK7YW6ymib9PS6shUa36/DSJYSWG2MVCM=;
        b=ZdehFerhOe+1rYOOxeOiELyebZ2FTDCTz7jIUlsKKgm4ESnWKmghnvDq+BnqGYqFfv
         eaT4aO081Kgs3835ZU5M9pCHBfTm+wOSh5kLUkUWDlJ+5udNnYwf/n9tyEylgiUzLjfE
         VP4iqM6ksj+McObgFdpOIFRFOMylpyVjWAkZE5S6tsE7aFWsqUqqpDPMad9xLYs1iU/8
         Pq4ZtNZ7bY8mkCno9XV0EZ4kogtG7NR9oSVBd5en/Z5NrOUVMh9J4x/EHm7vFi5j9b9U
         9/S3iPcxyb58M5RB4ppuCGICAEKBZ9ymca/qgMVj9A4IOjuCWYHSeJ6UMzftxUVCWpLT
         WQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5icHx6kMb1dK7YW6ymib9PS6shUa36/DSJYSWG2MVCM=;
        b=I8cC4jbfHUHxGekWbfEMn+T7qPEghfoWoQPL7t9oHUyTIB19ti21amvkT/QeqAKEzi
         HCP4uz4PN0dN3pIs3/rKZkQpIYy2RD7WH1I93FeSaWhxid7OB9aaVJ2X+qg/Etul/zwW
         eDgmK9NWUPP9X1APYIPUp4MdwrFk6ETV62LrpFtjX5hLOfNpJpiCrR9vfnR3gxYTnNTT
         DWqJ3LxeI6UKDFRQrypCxDvaFzGRQvIkfTbAVuOa+sk8QkMmRa01q5MwThFMB2W3kytH
         HyaCAcP7uP8odJuuuh+pChKx8fV+kbLRU2t1z0edO9aw7amnXYjBh13IfDWvy+8ls/Ze
         wWgw==
X-Gm-Message-State: ALoCoQmge5p6x/ACRRNhaFpJHXjLgBVxBTIEihK373kt0UPd04vhCwfkPIyQPv0SDft7xppqbDgw
X-Received: by 10.224.41.74 with SMTP id n10mr1480607qae.1.1403275414158;
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si664354yhk.4.2014.06.20.07.43.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0916531C6B7;
	Fri, 20 Jun 2014 07:43:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DF995E0ABA; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252238>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 ++++++++--
 refs.h |  3 ---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 74a55b5..5a0b138 100644
--- a/refs.c
+++ b/refs.c
@@ -2665,6 +2665,9 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg);
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2914,8 +2917,11 @@ static int is_branch(const char *refname)
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
index 5c0543d..db463d0 100644
--- a/refs.h
+++ b/refs.h
@@ -203,9 +203,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
  */
-- 
2.0.0.420.g181e020.dirty
