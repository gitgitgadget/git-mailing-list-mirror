Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A491FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762581AbdDSLCz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36077 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762418AbdDSLCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id 34so3581939pgx.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzTY40S/AhN7OxVRCSKqJhnwdMF/ZmQj9GaCBwIl4cE=;
        b=tZrBXzxdxuJta9KpIEFkJm5SG3lHRyhFANd10X3nnjrF3/MsL0c+qlEhh/Yhp2KZqY
         8vUYQHodf7pEdweVNxEKDKFRTblin7XHMCEPE7SeIxNfNr3QD6cQmpCEpTxfeU3xSNHB
         K5mYuzwRik5roagFnf82+akapNX/GbqTdKEwfP0DNgGBp0ZJxPMa82ZlX0DQA18A30mL
         Q5nxL94yEbcNiDtE+pA68N2TEpYuoSY+eRHYdopHNQnpGdoahV3KbUqIJ6Sl5+1VgZiV
         GfclHvyywQz4VVw3/O+h4FIRJZif/poY3n+ngySGqDeHTmyAp6tDy7wUEMPrD5aI0csL
         sDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzTY40S/AhN7OxVRCSKqJhnwdMF/ZmQj9GaCBwIl4cE=;
        b=sS5ZfOD11u2JwVe4O7usTIiEM3sjPGwZKKEZnsdU2tPo26sEq0+4WwqvsTZxILptgh
         6lal5Y73bBWEv69G98tUwCNihQY1nZwEFNJTdkwD31o2u3wJ7hcngX1U5B5g/s20CD0O
         GC9aG1FaQobMn12hl2HRvwNkMvl8yPrWwkRNzIC0Ld03unlBj5886qAg9VpB7UnBS5JH
         KzcfXgG4d2OTxbDMZbFvaHf14IFddJ2uvV7LeQzrTkEs2Bj5dDKrofsSlp4Qngh/wZmj
         xMhUz5hp/DCXmgaeKlkLyiyGwwGYO4EUIz7OMmmc++ldH5ozY7s4D5R2ft41Qo/eQGia
         dIMQ==
X-Gm-Message-State: AN3rC/6NKKC0eNxw3wiUv00wHpO/JGcURaqykwzUEisUXIfh/B1U2ReB
        pVRKqCc1JzBY2k5e
X-Received: by 10.99.121.195 with SMTP id u186mr2462808pgc.202.1492599767134;
        Wed, 19 Apr 2017 04:02:47 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id c7sm4017888pgn.24.2017.04.19.04.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:41 +0700
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
Subject: [PATCH v3 08/12] refs: remove dead for_each_*_submodule()
Date:   Wed, 19 Apr 2017 18:01:41 +0700
Message-Id: <20170419110145.5086-9-pclouds@gmail.com>
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

These are used in revision.c. After the last patch they are replaced
with the refs_ version. Delete them (except for_each_remote_ref_submodule
which is still used by submodule.c)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/technical/api-ref-iteration.txt |  7 ++-----
 refs.c                                        | 29 ---------------------------
 refs.h                                        |  9 ---------
 3 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 37379d8337..c9e9a60dbd 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -32,11 +32,8 @@ Iteration functions
 
 * `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
 
-* `head_ref_submodule()`, `for_each_ref_submodule()`,
-  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
-  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions described above but for a specified
-  submodule.
+* Use `refs_` API for accessing submodules. The submodule ref store could
+  be obtained with `get_submodule_ref_store().
 
 * `for_each_rawref()` can be used to learn about broken ref and symref.
 
diff --git a/refs.c b/refs.c
index a252ae43ee..537052f7ba 100644
--- a/refs.c
+++ b/refs.c
@@ -316,12 +316,6 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_tag_ref(get_submodule_ref_store(submodule),
-				     fn, cb_data);
-}
-
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
@@ -332,12 +326,6 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_branch_ref(get_submodule_ref_store(submodule),
-					fn, cb_data);
-}
-
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
@@ -1220,11 +1208,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(), fn, cb_data);
@@ -1263,11 +1246,6 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_ref(get_main_ref_store(), fn, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
@@ -1289,13 +1267,6 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 			       prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-			      each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_ref_in(get_submodule_ref_store(submodule),
-				    prefix, fn, cb_data);
-}
-
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(),
diff --git a/refs.h b/refs.h
index 0572473ef7..e06db37118 100644
--- a/refs.h
+++ b/refs.h
@@ -259,15 +259,6 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-int for_each_ref_submodule(const char *submodule,
-			   each_ref_fn fn, void *cb_data);
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
-		each_ref_fn fn, void *cb_data);
-int for_each_tag_ref_submodule(const char *submodule,
-			       each_ref_fn fn, void *cb_data);
-int for_each_branch_ref_submodule(const char *submodule,
-				  each_ref_fn fn, void *cb_data);
 int for_each_remote_ref_submodule(const char *submodule,
 				  each_ref_fn fn, void *cb_data);
 
-- 
2.11.0.157.gd943d85

