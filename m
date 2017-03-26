Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A5220966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdCZCp5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:57 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35559 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdCZCp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:56 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so4670778pge.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7LeJoYQ7JKJ/yrOC6qw7yVLl0UMdWCYgUJandrSPfI=;
        b=QDHO9pwF8cHj2Sp1t65Gp7JgHPr+3dNyonhDstuo7snre1ULSwCIU6QJRw+a87YEqQ
         J4J6Ua8/iIbfDFxY/gRyIHg+KigaNrDTPKa+iUr9yur7fHOg+jtcT73sFCFwC8E4uu92
         XfWlLEIcUWsOIvFpwYZ/kZBarrV7HvjYzB27poOsszKFN4kvWMckhv7v9gCa65E1BI0G
         RxyeNJcvO174VY/5qdWQj9jgTI92kZs0zpxb/E2o6nSyAek2l78p32b7v2pPQRd2ba2F
         KglfXqPqyG7+LS+347oS+9gGOfy9lraOejzE9wGGlHhjl93jKikutoTB1SpUDjUXZjKh
         PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7LeJoYQ7JKJ/yrOC6qw7yVLl0UMdWCYgUJandrSPfI=;
        b=RUp4mf2kX+a8lDlR9tv1tm9DJ8Q0KyqTq/lrL3cohMYgyW9isva/dRicu1DBWsrZCO
         mX/hFhBPZvq/J6/7QWqODMRl59O/1Wahz2B2VPvm5ORlhghJHXK8pm4pX3n1/gQMiZGW
         WwiYL1CWUG18sfF1hqNUV2FaDjie4xUNW1h/di1NeEAqQ74xrCgUAhdMTwndbJ5sefQs
         ktEUQrIzJ+j11etfeSo5jzEpqoDGXUBllqzMhafdcJ6fIrfvO2Q1xifNNCwAn27ehku4
         Fq8Nmx4DFSXks2agt4/ELgT+nA/HXI8PjVEAA0ptsze36ZomHUSGGwCE+trXRcd1sLUb
         fr3w==
X-Gm-Message-State: AFeK/H1veXc0tHZ1CNf8uULe4FZfhtJCGPJASanHLmcnF824yqrAHHoR9dmGIRTgmoyvxA==
X-Received: by 10.84.231.201 with SMTP id g9mr20307212pln.91.1490496350217;
        Sat, 25 Mar 2017 19:45:50 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id h71sm12820627pfj.65.2017.03.25.19.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 28/28] refs.h: add a note about sorting order of for_each_ref_*
Date:   Sun, 26 Mar 2017 09:42:41 +0700
Message-Id: <20170326024241.31984-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.h                         | 4 ++--
 t/t1405-main-ref-store.sh      | 6 ++++++
 t/t1406-submodule-ref-store.sh | 6 ++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 1a07f9d86f..49e97d7d5f 100644
--- a/refs.h
+++ b/refs.h
@@ -230,7 +230,7 @@ typedef int each_ref_fn(const char *refname,
  * it is not safe to modify references while an iteration is in
  * progress, unless the same callback function invocation that
  * modifies the reference also returns a nonzero value to immediately
- * stop the iteration.
+ * stop the iteration. Returned references are sorted.
  */
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
@@ -370,7 +370,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
- * and returns the value
+ * and returns the value. Reflog file order is unspecified.
  */
 int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_reflog(each_ref_fn fn, void *cb_data);
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 77e1c130c2..490521f8cb 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -53,6 +53,12 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_ref() is sorted' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	sort actual > expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'resolve_ref(new-master)' '
 	SHA1=`git rev-parse new-master` &&
 	echo "$SHA1 refs/heads/new-master 0x0" >expected &&
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 22214ebd32..13b5454c56 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -47,6 +47,12 @@ test_expect_success 'for_each_ref(refs/heads/)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_ref() is sorted' '
+	$RUN for-each-ref refs/heads/ | cut -c 42- >actual &&
+	sort actual > expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'resolve_ref(master)' '
 	SHA1=`git -C sub rev-parse master` &&
 	echo "$SHA1 refs/heads/master 0x0" >expected &&
-- 
2.11.0.157.gd943d85

