Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495911FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762560AbdDSLCk (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36741 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762545AbdDSLCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so2086290pfd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbA5/AFuNYmRLReRGSwPvseUatvEM3Jjfg5QHTyOGlM=;
        b=iWrvx7jcIjuXxyqWontgcpyTCECl4rN9MaNKRU8GYNQJ2KmnWx17Dw0ssOF9HH1Ut5
         LoJag3a2y0+BI5GiLdGgWpBFBDZ/YUNK8H6N0fQlMQLGBPbUkBS7ER+apYq0WF/O8BX2
         +jG8V0mW9alV/Q2jYSnycfNGSX3sRwVJjw9LwDjHFVEB7dMcZ1QMs75CcX3O2Aso8Otb
         pejPizd6PBoDCqfxj5LQVPoZNCa8hIoMaie17B0+C3x8/EnP+TZ+9fOYEcOfDTDpn5RK
         zJi/hLKBzyIKGmAinZQibHrohhBtcFHMRmGi9gtsg0oSMslzSVNgrCTie3jiKpsCGc1p
         O7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbA5/AFuNYmRLReRGSwPvseUatvEM3Jjfg5QHTyOGlM=;
        b=gVRel3xOp41uRBT1qfjLAIf0YjuW3CWADz4K9dgNlVsXkMTs4kAHsApw7lLiupsZND
         hoEEm76EfNIV2RYc46i/rpIugn6DN5w8gX7pauwZdNHvQf7MkFzWDC/QQk3XZ98uheh3
         o0XswGQpfWl4gYdadag4lHYaDyk+L7Fv8hIV/1+zT+/A6tIQvbyeCn0zoPBi7TroGNPQ
         3EoHRwsZKDmmqCf/aP9/YFZAP27l5vfiQR6r5fuwgZ1US6o/3YizKdBFcT/nwrnDxDOB
         wQpPdWOZ9ljPS3Jjm0p/Zn72k2GykPxZLGFFr98RVO9jy9ehGFQQvOMzu426MYuZnDC9
         YEfQ==
X-Gm-Message-State: AN3rC/7UaG/hcnlplVyVE9wxxEx+mCgrUYNU3ePE/UEC41iXmMPoOtEf
        8gOGQHe/mSfulw==
X-Received: by 10.98.160.148 with SMTP id p20mr2461427pfl.249.1492599755647;
        Wed, 19 Apr 2017 04:02:35 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z22sm3972208pfg.117.2017.04.19.04.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 06/12] refs: add refs_head_ref()
Date:   Wed, 19 Apr 2017 18:01:39 +0700
Message-Id: <20170419110145.5086-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 +++++++++----------
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 26474cb62a..a252ae43ee 100644
--- a/refs.c
+++ b/refs.c
@@ -1208,27 +1208,26 @@ int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
-	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
-			return fn("HEAD", &oid, 0, cb_data);
-
-		return 0;
-	}
-
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
+				oid.hash, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
 
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
+}
+
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return head_ref_submodule(NULL, fn, cb_data);
+	return refs_head_ref(get_main_ref_store(), fn, cb_data);
 }
 
 /*
diff --git a/refs.h b/refs.h
index 447381d378..0572473ef7 100644
--- a/refs.h
+++ b/refs.h
@@ -233,6 +233,8 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
+int refs_head_ref(struct ref_store *refs,
+		  each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-- 
2.11.0.157.gd943d85

