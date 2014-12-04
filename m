From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/13] refs.c: remove lock_any_ref_for_update
Date: Thu,  4 Dec 2014 00:29:20 -0800
Message-ID: <1417681763-32334-11-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnX-0005oD-DF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbaLDI3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:50 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35198 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbaLDI3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:47 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so15236268iga.8
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ueRLiTNCVvgdgOBdBfleh9lK/llGF78W1yAoM6UC7O0=;
        b=lvhtNGlTSUBl4sPTUJ+fcJ3c2mFNneTxynKLPBDgfRKS9iTct2rKRkYodovGO0kt8W
         hY9lbHmZALd56+DxGmGGt5RK3z/D5zJ9JGYu3fZxnuuOiwVsweDlDSe94UwlHSu6VoMO
         x13D/Vf0iv6V2EByb+qAHkwuhG23gzWx0BpyRgP45vnz4qnEr/9nkpvu3/HXgEK5O5jM
         ro0iFoLqgzxz+TS+sLktO1r3h7LUC3yWbsSf9x96PuJzXym6BdGSagW/TGr14ptF7abB
         W+Y3WQIQccQ40hWx5rRUDSyIFabLEIRTBk2wUB1Pl6HemaFyzHJvqZqVoOxYn15dYvv2
         d/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ueRLiTNCVvgdgOBdBfleh9lK/llGF78W1yAoM6UC7O0=;
        b=iqujvK9DY7C2NZpquIL6dw+3zxnPctxVtNAZUk49rqmmAvV8/wqyQa0qulpTZrSSLU
         ThjRFINDb+duFyfakMUXQgO7MEcH0AhJTTNZZBinh1DMsnRJpfjE4CPwnOHBSFijtDFp
         GQ/jupYeKvZ1dZFJaA9N3xK2C6Wws8OJyUJ4XBcv9NvxdbRSn0KA0DGT6yByO/WPQrLb
         +OT9JgUmwhqTlWOMiclBMD3WOERYuMDHk9kmPORSsjKj8HXThqraeXLgCSTiCB30sqKK
         UPl1xdc31PBcgjc/ZH6RzQeCUQArXdiByrRg+eeVPpED62LIbRDQHO6XGvhxcc99+vmS
         COLw==
X-Gm-Message-State: ALoCoQmzjzPgzXTtXT5Q1LTCxg+U5ldYav/C5UQ+p5/Bvsr0/cy4uK/J2fsZpArZCWuz+n2k0Z7E
X-Received: by 10.107.137.92 with SMTP id l89mr8552060iod.22.1417681786244;
        Thu, 04 Dec 2014 00:29:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id a1sm14054353ioa.27.2014.12.04.00.29.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:45 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260741>

From: Ronnie Sahlberg <sahlberg@google.com>

No one is using this function so we can delete it.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 7 -------
 refs.h | 9 +--------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 1468c00..796b7cc 100644
--- a/refs.c
+++ b/refs.c
@@ -2346,13 +2346,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *refname,
-					 const unsigned char *old_sha1,
-					 int flags, int *type_p)
-{
-	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
-}
-
 /*
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
diff --git a/refs.h b/refs.h
index fdbdea6..166aab8 100644
--- a/refs.h
+++ b/refs.h
@@ -181,8 +181,7 @@ extern int is_branch(const char *refname);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), transaction_update_ref(),
- * transaction_create_ref(), etc.
+ * Flags controlling transaction_update_ref(), transaction_create_ref(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
@@ -191,12 +190,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  */
 #define REF_NODEREF	0x01
 #define REF_DELETING	0x02
-/*
- * This function sets errno to something meaningful on failure.
- */
-extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-						const unsigned char *old_sha1,
-						int flags, int *type_p);
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-- 
2.2.0
