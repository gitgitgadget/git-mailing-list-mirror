From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 11/16] refs.c: make repack_without_refs static
Date: Mon, 17 Nov 2014 17:44:52 -0800
Message-ID: <1416275097-3616-12-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrD-0003pG-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbaKRBpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:19 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:59345 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaKRBpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:16 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so218120igb.5
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=idu2RSzL/jjPM26YR2spL6mZsrAQSPeFKIhYEFNAPoE=;
        b=BCb5QhKaPk0ssGVd09mNcCOgHI/yGbPbbcl/7a2DuDo2OnJ81ul3y3UsJM7UkAgS4F
         XO/CvYupwDAEy4t4DCs0+A6uKrjXPpEPKWDJyuG5gJ3PvUc20Duj3FfJ970DCuD2qQxx
         PTddH4x92aXDMSLZqaKHMU9to0YXJ+2ZrLOV0af4fjMs3J6mCMQ+fCOTsFH9SGVo28aJ
         uyCLsWoEEFSNZ3BB91FzOM/CR/ewVDxVgysIUW5ZbqRDn01UjZPFeQtnucU5aCT0pfEY
         eYVFe+MW2QyItuq//8f40qJnDzgEyv9/UZ1Db4Wbg38OOWCR2BU34tJQ9xPmKJAdhZjJ
         GuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=idu2RSzL/jjPM26YR2spL6mZsrAQSPeFKIhYEFNAPoE=;
        b=HR/Oqy2Ct18RB4ArNXU3ieS+kTDWR+jnQbcwNHHC6wutznu0tGLMwmL/9f3s2YaCP8
         dRcn15iUGnhAgzfIW8TLqNhgeaiQP+5T9YdCsrezBiPMB2UqtC7WNg5mfaR1/m5HjlAR
         uY8Y+OrsnOG+wRDbgaIyhWw4UTluWGSNGk3hRo/dZItCMVrfZtqXcFU2HzJks5Ls1zqU
         qg6WAgyppBBX4+6R2jGjhfR5bAl5/HwSObDNtPnd9/hz/3I4QtsBIHyIzn6sVLWXBXtq
         MHiB9V45CmkDPxxfhj/IVx+4qhZqB0U7CL8IuaiNIe+TdtY8dbttWbB7H9cZ/N0/g10p
         9tkg==
X-Gm-Message-State: ALoCoQl3UBQrfw7favC5WU9VGwVScHWKt6tng71RRCgiCY7POl6MuAZaS9ism4izVFQMWLqTICsG
X-Received: by 10.107.154.145 with SMTP id c139mr34622811ioe.11.1416275115694;
        Mon, 17 Nov 2014 17:45:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id fk8sm6876204igb.9.2014.11.17.17.45.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:15 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 130d240..899c33e 100644
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
2.2.0.rc2.5.gf7b9fb2
