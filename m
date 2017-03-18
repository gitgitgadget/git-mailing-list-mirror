Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14352095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdCRCH3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34306 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id o126so10331768pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7LeJoYQ7JKJ/yrOC6qw7yVLl0UMdWCYgUJandrSPfI=;
        b=vdFtwIXAEzQM7Ok+QoMsafdKqx5Q3vs57AzzQyrSgiMJEEcyV4RPwLq6UTdRsrbTWd
         9z79J897r67n5PDrxgs5HMNh4U5W26oje0z5wZm+o2LAEdq05xdzk7WxOYtMlFttn0kH
         wUaAqpi/JZqX5xm1AxBMiFXtijni9vpNQ3bUx89l4BA9NNqOBUncjRuf5pBryM9lKMG9
         WXzp+6EpHs4TNo+bHIqlCjwk5tulxSlwnR9QEGbCvCzsxFW1v6Z2fzT/mo0TGg7N6ndr
         LW1YQ/rYabmuonBrCDwVTcOwU34Rw6VlMPCu15a5wkotTCbL3vr/pwM/ZWJ1rnraAJbA
         IRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7LeJoYQ7JKJ/yrOC6qw7yVLl0UMdWCYgUJandrSPfI=;
        b=cG6bk9fr+VWbsgicA18tJzgl8/iTo4FAJSpR3XKDDSDfbvQnJLIxrRykvIAt01zL6e
         JhDSvGHYbCs9dmYgBTSzpMSk5QmIyU+oNCiH3bMOASQvi0KC3XLzBnljI4wErN4wySJt
         IWZK85QB/dQwrizEmDY58GvqEM21JQOgKyzbXUTi8xt39QfUT/jxnZFVIGVFG8jL7opr
         ptkCsKL7ShW3MYl8DxEXzTKYdAZMm9hIYQVtXuNwWdTKg6qDt9VGkDr3KP7WxDUhB8w1
         sthsDOTQQ3NFJ4ER812rJ/BGlhS1OYR0Pd+jGpXshXcbtKsERFMMyeclHJGMnqzbbcID
         xxxw==
X-Gm-Message-State: AFeK/H24JUsIjZQJIzxVYlUYnebe4MBFOjgVM16llA/MSWWG25d7IXhdCQPkvNnLOWjcbA==
X-Received: by 10.84.218.138 with SMTP id r10mr18681471pli.165.1489802810104;
        Fri, 17 Mar 2017 19:06:50 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id v186sm19182311pgv.44.2017.03.17.19.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:06:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:06:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 27/27] refs.h: add a note about sorting order of for_each_ref_*
Date:   Sat, 18 Mar 2017 09:03:37 +0700
Message-Id: <20170318020337.22767-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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

