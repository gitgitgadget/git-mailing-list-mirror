From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] refs.c: make repack_without_refs static
Date: Fri, 25 Jul 2014 10:55:25 -0700
Message-ID: <1406310926-4080-5-git-send-email-sahlberg@google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjiT-000254-8s
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760762AbaGYRze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:55:34 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:54182 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbaGYRza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:55:30 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so1307906oac.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dwnPOJsmpABIbBfOejdJjbhCKedR15MgrrSFQs44tSI=;
        b=ZZONGV7i8Yx21AwUK1XfXVmhUzP9YQ2Xoi4s5gFTVw+XPls0yhVkzT1xLTDJrf3qUu
         3o1z1iJzL5ENSq54OaVvqR+mF4j45Xklpo6OBSTNlP6M4RMl2R8zfIbgmXgQ1qgj9hJq
         2gcN775NN3Uxhxx8hgBwsxU/RkdPo6jE14UDRFvaigytjmkCaCleJ62N4ZpoD9Poc3vK
         6fQF73We2no2FocAGa4ZbOpqB4PXGtTXqleBZqkIGFZPW2kJhTK77taDeLRv5zde8PSU
         7viVoxYM2dA5ugJr8z3BHuzampVQuKhZ+cygRz2Pd01eRhRUIJIH+wf28qz5QcehnXKu
         EEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dwnPOJsmpABIbBfOejdJjbhCKedR15MgrrSFQs44tSI=;
        b=YGuKzZiWV4w5+MKSSBNpGM2w49XaMh2Xokj2wqTIvl+hbiumPeq3xxIqDG/rxlIwbw
         CfBmIMnUODxXpLEjsTKvyOXsygDqTv9NHLx2tK4jcIV3sgif1cDFTvXE563knC3HLCwM
         nj81OreZPHfIY0txcUVpycFgzEnl1xIixd0GYhrUQL9DRPwbR2z8FKgBt2EhxVqdSrzX
         3S2k+lQ59iw+OYhRpimGB6SUco63DRFXN+cRLtwJSl04GTaHAYtMCEjm5DdHrDUcY02F
         IMN4Z4zeJa0fkFs3l3UmuCn/iLd/P5xTFQmrTj5eSNync1ZaLDjUBxL11dZ0Ssrxn4b5
         AOng==
X-Gm-Message-State: ALoCoQkg+kzQ75VAei0mu7tIJQqz5NmJon/McebLNd171P1l80T9Air2Jg0XNJztoZr/VdCwC3M4
X-Received: by 10.42.207.146 with SMTP id fy18mr9233345icb.12.1406310930222;
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id kx2si186082igb.0.2014.07.25.10.55.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C2D3631C659;
	Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2D639E0D03; Fri, 25 Jul 2014 10:55:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.518.g4f5a8ad
In-Reply-To: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254245>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index efa4f0d..5696d18 100644
--- a/refs.c
+++ b/refs.c
@@ -2534,7 +2534,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 /*
  * Must be called with packed refs already locked (and sorted)
  */
-int repack_without_refs(const char **refnames, int n, struct strbuf *err)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index eb918a0..7183e8e 100644
--- a/refs.h
+++ b/refs.h
@@ -155,9 +155,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 /*
-- 
2.0.1.518.g4f5a8ad
