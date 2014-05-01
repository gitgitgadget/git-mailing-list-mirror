From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 42/42] refs.c: remove forward declaraion of write_ref_sha1
Date: Thu,  1 May 2014 13:37:42 -0700
Message-ID: <1398976662-6962-43-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxkL-00011h-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbaEAUiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:14 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:36466 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaEAUiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:02 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so230775vcb.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2oFNUYVsIXbnkeHtQj++DeJ/QExHGC/6bxQTe4NDJY=;
        b=SP6yV5FsRLSRHjZpk+O2l1CsuEdcB1UHIyopuP4dc/x1ueB75efTpnNs6AexwRPI9q
         ZV3duq5BQhFEd9cJmPFXztDmQ9aSRTZX41w+yVKLXLVVYVtLRmpp9DlT5PR99gy30Lzf
         1Ld7vzYDnqLbfDo2NngtCZXV4q6Whl87g/fO/txXnmHELJBHV7JCyxlc2fKLAbEViY1P
         1bkWs4a/ZWncxK336V59wfnfxmNpVOQ8ZeWdrL37eJYgRSOhk60BXzg+eI8dix6vT/1z
         N+rfG5C4Xgf3q32LRPa9MYCikgjR/5K5M/3QW7wAJv+9HJxQioEr1UUZeFbwQX6I2zmv
         rCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2oFNUYVsIXbnkeHtQj++DeJ/QExHGC/6bxQTe4NDJY=;
        b=Gx1I4YqRT9HmToqDudtRHElWGIfGvX3/7TuqrzT5D+92IHkaPvb4Un6266Kbd6SN4e
         wvSmDKIJvUb1GbJpdJd7HXBlCmRuYM76mdX1I6ucSFdpOaR6Lk71e7hXeKTK0pe9hEbs
         iu0dwx5eWiS8h4eZFy5kNN8dA/E64G8oUW4CvBRz81CZAzxYo91SYWstRDH1+0qy4ASC
         JqsXcttWml5SmSteZEWljLrBZaEydFl+rXqRo6cUVzQF8j9yl9jw1ANysN8Xcyqo5Y5t
         V/rXpk64JWFD9oZnFqFKMa3vtxbcZPp7U1Ky7/PNaaeFYQ3GcLTrAB9Lw2n4gYRgOksv
         nJfw==
X-Gm-Message-State: ALoCoQkfSG4vxUp6gdb0yvXhRYPUaOY24jehpHJIRXJiTdDZ4uJYMwQZ3DXXjoltZN4wzbxO/+Dh
X-Received: by 10.58.225.197 with SMTP id rm5mr6468771vec.5.1398976681843;
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537747yhk.4.2014.05.01.13.38.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:38:01 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A2EDA31C1CC;
	Thu,  1 May 2014 13:38:01 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5B814E097F; Thu,  1 May 2014 13:38:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247842>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index 810a4db..e59bc18 100644
--- a/refs.c
+++ b/refs.c
@@ -251,8 +251,6 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
-static int write_ref_sha1(struct ref_lock *lock,
-			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
-- 
2.0.0.rc1.351.g4d2c8e4
