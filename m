From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 44/44] refs.c: remove forward declaration of write_ref_sha1
Date: Fri, 16 May 2014 10:37:32 -0700
Message-ID: <1400261852-31303-45-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5N-0007jD-1T
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbaEPRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:16 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:59450 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so518802pbc.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=08bKKhl+xiAVQa9ktaV4Cfa9FINHUKPex9QqPjyAfVc=;
        b=OOeS75KTzsWcwOv40zDgRAV3ioTOfVLjcRtlwRwmvqGimahxiX+6kfp5hXxPkvzbyR
         JNGc3rCD1wOjD4EuhbhN/qvk4u7nf0Zn4wQ/P6BexwhYpM8aQNJlivN3rL2mcFtEqzpk
         OF3kQQKxxCVAjTkKkZ5G2R+fpkIfFVK2tTkE2btWxQkjx6DRk08qoeNKaXBJlWluDMFk
         knfhw0vvvkAXL0TuPDvXk37DM+RbhS+8JvuAVIl7ya5OT0Jfg7fMzU3PjggN1rqpuiHL
         2zLVzNJxV/IANrDm0tu7OVcwuPioOz7IP4bGjcP+j1qe4+Hm6fBXpc3338heIHDAh4Gk
         TEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=08bKKhl+xiAVQa9ktaV4Cfa9FINHUKPex9QqPjyAfVc=;
        b=JKnGjvAZzN2U0pzh+v9POtl4jp9JuSUVUQcpxmHAPMEYmvTrSCLp08Ed6VdIv/+Rgm
         HdB+MRFNf0OkTo4kReSdLSxat+UzK0NXCWIQZtzbVbx6FhtubO7JrdgJ9kxJTpk5nw3D
         WodSfB2hRRwNt2KQQ61Ul95Joxz2VEhoKjPaIFYFROeR9DzGP9wCqFTVSu+kMbNSrrs9
         fJoN/h2sC+Yzb7eWjnbTo7mHwVIQ9XgKWYtuw+vxg25nBnCBq5jpQHz7lwbUPOTWKXDq
         ir7ri8xes4FOf2bdb6pqkSzPEYV85f+T9e6QUn2v2lmMKij8jyOxtBXE9DjZfgi/wA/b
         6nog==
X-Gm-Message-State: ALoCoQneRe750MMC5aPwJ0F/Fndn69QyKFxD75KJnsZE5oT5eC3HiVczsGCUWzkb101xtQP/le/Q
X-Received: by 10.66.141.135 with SMTP id ro7mr8673286pab.28.1400261858835;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si441763yhb.6.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A38C05A4292;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 857E6E0A04; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249365>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index 71e3059..bf84306 100644
--- a/refs.c
+++ b/refs.c
@@ -260,8 +260,6 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
-static int write_ref_sha1(struct ref_lock *lock,
-			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
-- 
2.0.0.rc3.510.g20c254b
