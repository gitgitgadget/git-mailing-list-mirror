From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 34/48] refs.c: make lock_ref_sha1 static
Date: Thu, 19 Jun 2014 08:53:16 -0700
Message-ID: <1403193210-6028-35-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxehB-0000de-2W
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553AbaFSPzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:45 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:62293 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758064AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so294841pab.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Df5m729indQLONNSoBYHHsguWXZ9XDDucrlxu1aJrZM=;
        b=TlBwabpvlSRXvaTZUiM3RIIAyp3+9+T2LLEAS82d+Ft60H2qOg4QkpO9Rji2zwPZ1Q
         LkmXWeosolHmLQyhGES7bLxr8vgYoA7+1+6mcmGAS1rtHUqbqk4+MDeNlHNWGE0FYbdc
         RWrnRJsQp29o2qBrchsZ2k5R+Lms9E3HgRw/O31M0eI+jrxFJa4uAW9rRZEahp1d1trQ
         BUdVGhEAxKHpNQMyodVO/JGgPLrxQRzPz732HvoMVGZVGflswpP90e7O2Uhl8CEKxwXU
         YHOGd7+7tr4melxS62LTUuA0hZphG91LtP4+zMH6Pbqbf62jvHj+vLzy7HnHphpB9QPI
         gOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Df5m729indQLONNSoBYHHsguWXZ9XDDucrlxu1aJrZM=;
        b=D+3ygvRcOB/hbPEK5neeASKBL0KF0W8jbXyQYeXcwvHX5UQWKOUecstDxGLS72MEPW
         cUiQGk2QMHVHS0iIP3frxhlzQQyyQinMDwa2JqYN7mtIwjrlvNjt3IeYqWWSyA+0gaLK
         ailYI2fIYnea2JHxXfWYbK25XV2dRoXTcGGQBPBG6UmnClH9IT4VD8I8msR7lSNTWE6V
         L/AkJi3GwC/b2oKacq72V0wrmd3tZ3ctnJNo/sYgSbZX42gGYWNHjUBGtzullYnP0Z5T
         WKbk2L+kXBPj7dZr2SUJrKrawFGvCpMubbYptEJ7d2+ZTZQdSZoyAP0OlzPGSFEcZP1B
         DR6g==
X-Gm-Message-State: ALoCoQmQY+ptZBnLF+GOnu7CXSrVjDmriK6bchWztrvXVBEchGZ+50GUVZozCexewWQrYs7pMUBK
X-Received: by 10.68.253.66 with SMTP id zy2mr2460728pbc.1.1403193214124;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si420407yhi.1.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EB5095A42EE;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9685E0B50; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252153>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 8b2c598..db8e0a0 100644
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
index e729ea9..4ac4a7d 100644
--- a/refs.h
+++ b/refs.h
@@ -177,12 +177,6 @@ extern int ref_exists(const char *);
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
2.0.0.438.g337c581
