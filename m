From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 11/16] refs.c: make repack_without_refs static
Date: Fri,  7 Nov 2014 11:39:00 -0800
Message-ID: <1415389145-6391-12-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNk-0004FM-E4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbaKGTj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:26 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:59755 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbaKGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:12 -0500
Received: by mail-qa0-f73.google.com with SMTP id f12so282905qad.4
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bSRRjx/DgV6IRWhY3W0AQ4TdmIPaO8Jc87xz+mVDXdE=;
        b=fjZgyU/Y4y+S0SoYu+9RJvFayLta/7XnUvhtowvmeacdrh17RDDPimc99/43LkwUv2
         HCL1r6bAS9oP0D5oWLQOUKS29TlTqfuAc0NakZupuk10qjgW9KRuMEMNCWj9H/3UxIMT
         3P+ZvOmgDDMzLKhDp18bD7MHkMb0GK3pyctMs64AEOHe+MAx69mTltKenh+aVBjCi+Bd
         4YM2hlrpOD/7zJpSJKgWQ2p+N0UKDVDE0zIffGqV3NX6puCzHhfmz4MBK0H7E8ciql+0
         rFiBbQ6d6TCXXlXj/lRvha7LcKzLSKinvJocrsrCsFjufywt1Nr29DyRBPrH91tVz47s
         Y++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bSRRjx/DgV6IRWhY3W0AQ4TdmIPaO8Jc87xz+mVDXdE=;
        b=EH+Er/8z5FUzF8PCIjhsHgBsb/26J3Cl5DhLDDnekVAe8rCeDOPJ8/fgE7ecoehcmd
         M/NdOk1aexCa+NNop4WkKOxb1wxS/pbYLWWZnTl7s1GdUYUAJVm3EWUvMKABfjPVtMW7
         g8BrdriNQjBsOZFM1hzp+tcqhucr1ymB6eIoTBbnYKo1ULGI5DweBB9sra4g3HI/Afus
         BlHTMFIQg2c250Jk7t2ULEQuJlh3wQG+W1lBfQaL6PhxHOe1GYe5sf1Gib85NrCTJ9uC
         FiYHkK77wqa/NKLfhiBBgXxw3yX9sZjJ38IJqxVHDAxzwmTwcLhmqvx40Z288v3UDH/b
         7J9A==
X-Gm-Message-State: ALoCoQnZyj9oCVPFj3dsE1MdGR89UT794rIWLzghaPBVJpcDJcjdrPXMyVuZ1Ys3jT0/gkV3tKuK
X-Received: by 10.236.62.162 with SMTP id y22mr10457114yhc.38.1415389151057;
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si400510yho.7.2014.11.07.11.39.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:11 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id fPW8O0Rs.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D5F60E0BD6; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c1db86f..2c6b0f6 100644
--- a/refs.c
+++ b/refs.c
@@ -2668,7 +2668,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(struct string_list *without, struct strbuf *err)
+static int repack_without_refs(struct string_list *without, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index 0ba078e..ce290b1 100644
--- a/refs.h
+++ b/refs.h
@@ -163,9 +163,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(struct string_list *without,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 extern int is_branch(const char *refname);
-- 
2.1.0.rc2.206.gedb03e5
