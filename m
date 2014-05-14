From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 26/31] refs.c: make commit_ref static
Date: Wed, 14 May 2014 15:13:25 -0700
Message-ID: <1400105610-21194-27-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhS8-0000IL-Es
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbaENWOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:03 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48863 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbaENWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:41 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so56883obc.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28BQUJ+/q4byBpanYXuJyBQoAoZ4mCFGJeed7fR3ETo=;
        b=S88RDWGDV02ZAoIrrrzl06pANCzzbHthbm+RFko3LZdd3FhpyhNQSz5z7Oh+UYxZTU
         bPmYPm9ti2tCAkN/mWjZLkCia2ByUlCAB+y59y0kptQevFSIL0Ob59EpGX8l4FtgMkkC
         Ys/QG/5752Z72c1gNs7DOgLGpwOVtEHZFPh5bMAdNw3GevlutxfQavtyzq+r+eT/Rws/
         VhuZzXcVIC/KYRgyrpy+8OdnoTB1HqV/P0NIi+Sg9MILeetC6D5yIH3gWzrrcXXFJdZU
         Tvlqy9s1t+A0NC6XEcJnvQG82HVSLKZkzC9mVdMJY1Ht3GkwyLdEvh+kkAEBvj6Lykdt
         L7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28BQUJ+/q4byBpanYXuJyBQoAoZ4mCFGJeed7fR3ETo=;
        b=NdGBk2QeGWn4zWmPeKL/YWtD2VelvBPNKXJ/bZBDrjXh96+0fPnO9khnKy6exFSrt+
         ldJY3dI32vXwAdT82gAke4m7KejYMpxz7mp5mC543q+HpD5R7ULokWx95PXcxvK4v/hW
         C6wdfdvuMq7UFhfPNaXHTpFHjd7F93TrC5UcFVogWUA3vaI++nlMyekTktGFS5OPX5cg
         K6SnBCGFAuxQ9AJjpFB5Tq7YsX0SmseacVZ1Fh+rK/GZgsRJHvjfu+gwNP3uIEZaQurY
         dGBNo3V/BBv8DRE1bOT+b8Mnf9qYMLkRKr8RwzXp2Zc2B8EfirHkBu3hR4yjqFyVKuh0
         mK6w==
X-Gm-Message-State: ALoCoQnmIPMBdwtx1dOgCu6aRUXZYwgGrYZ6TpuiDGR9EJ2kaOnLeQVM4eVvEk3IW2sa2NroulGm
X-Received: by 10.182.19.231 with SMTP id i7mr3142024obe.25.1400105621338;
        Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si78052yhj.5.2014.05.14.15.13.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 30B995A41E5;
	Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E9BF3E0973; Wed, 14 May 2014 15:13:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249029>

We no longer need to export commit_ref. Make the function static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index a430b22..0cb4ae8 100644
--- a/refs.c
+++ b/refs.c
@@ -2676,7 +2676,7 @@ static int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
diff --git a/refs.h b/refs.h
index f211e13..289558c 100644
--- a/refs.h
+++ b/refs.h
@@ -139,9 +139,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close and commit the ref locked by the lock */
-extern int commit_ref(struct ref_lock *lock);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.506.g3739a35
