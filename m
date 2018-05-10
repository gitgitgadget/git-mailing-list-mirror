Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF191F406
	for <e@80x24.org>; Thu, 10 May 2018 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeEJTaZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:30:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53584 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbeEJTaY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:30:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id a67-v6so5562433wmf.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHpyTUQS5+0aw0+sOTWZBivrFtjkQ1vJVMB4wlyvUzo=;
        b=KIOERp6COXtPOy1+sbVsSsWX1x6dL16VC26rasDDX50cbMOlzDgaCSQpBssmkzaEfy
         8Zo4sNisF43dbBJ0R0e0gd6kHh4VnHZFLzlMZQBYtjYGqBxyNyTofqGyxy7v7clEBnlc
         jXzleNQNEN8zz8sUqhZ/3TM/+15WMtZe2Zai4AeRVb5IMl8c6ErA7q4l+MvfUR+KxDzw
         ff5gCp/W2tmM5Pr527u2rGC3UuvCrbm2fa08iP4QgBR2594cMmbGLJhtKmF/n1BSFGQ1
         ryr2mP7MyE4YSsKj1cZIne3S0hjy1qVgSxKvc3rbb3F8DSyKAW3/U4nOGgeHGnIJfO2p
         rjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHpyTUQS5+0aw0+sOTWZBivrFtjkQ1vJVMB4wlyvUzo=;
        b=c3T1kXEyt9g9igMaFgMDS4XUBrutivRR0AYIjjjvqUdcR2O8dzCF+IoyNI9SI9O+OP
         9W5MkwfhwhNE4nv6BuTIgqo/SFs/AR3SEuu4yDlY0qa7/YRkZj4Bketq9oUswGrmwDXF
         MZxGaIkoaj5YBP8J7QyHN5jI+Zaby909sL5vn3K8P7XmSjmOyc+SOK0Oc23f/xw8fBTf
         dPzjUp7hnNPOTwDW5H2rIIkLTxGPWn0VWuQGPuTU40rLuch55dcE9EwKc4DrQold8ZW8
         gG2Zu7ItGiZZcX2tfIYrNHxpTDFXUDovlFoT6CVfEZOjRneYTX2TW0flsvRG6G1LrVAt
         X0gg==
X-Gm-Message-State: ALKqPwfkPuKIufSa3MoR5VL1z8Fa0aUsZ3gkRsGNYqz/vOdacYdudwO8
        KbUcrwhHxMS8RWzOLMyO9GBODAA01xs=
X-Google-Smtp-Source: AB8JxZrdB9j4KbxM45tVSNmbt9GDS4GOUePvn/EcfWdXPtrOjTmx2pKfpN1Gvq8n2/q+QNV6GlaTBQ==
X-Received: by 2002:aa7:d056:: with SMTP id n22-v6mr3857149edo.193.1525980622374;
        Thu, 10 May 2018 12:30:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z11-v6sm870817edh.60.2018.05.10.12.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 12:30:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/3] refs: handle zero oid for pseudorefs
Date:   Thu, 10 May 2018 21:29:56 +0200
Message-Id: <1b6b1a25acf42747df479b90b1cc28e4c31eabe0.1525979881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525979881.git.martin.agren@gmail.com>
References: <CAN0heSp-rxqAVJ3Q1KMD=eYqPUkcDP8xBTVTDtGfom6v5WpBLQ@mail.gmail.com> <cover.1525979881.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the documentation, it is possible to "specify 40 '0' or an
empty string as <oldvalue> to make sure that the ref you are creating
does not exist." But in the code for pseudorefs, we do not implement
this, as demonstrated by the failing tests added in the previous commit.
If we fail to read the old ref, we immediately die. But a failure to
read would actually be a good thing if we have been given the zero oid.

With the zero oid, allow -- and even require -- the ref-reading to fail.
This implements the "make sure that the ref ... does not exist" part of
the documentation and fixes both failing tests from the previous commit.

Since we have a `strbuf err` for collecting errors, let's use it and
signal an error to the caller instead of dying hard.

Reported-by: Rafael Ascensão <rafa.almas@gmail.com>
Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1400-update-ref.sh |  4 ++--
 refs.c                | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3996109ba4..faf0dfe993 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -503,12 +503,12 @@ test_expect_success 'delete pseudoref with correct old value' '
 	test_path_is_missing .git/PSEUDOREF
 '
 
-test_expect_failure 'create pseudoref with old OID zero' '
+test_expect_success 'create pseudoref with old OID zero' '
 	git update-ref PSEUDOREF $A $Z &&
 	test $A = $(cat .git/PSEUDOREF)
 '
 
-test_expect_failure 'do not overwrite pseudoref with old OID zero' '
+test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
 	test $A = $(cat .git/PSEUDOREF) &&
diff --git a/refs.c b/refs.c
index 7820a52c4f..26af07fc51 100644
--- a/refs.c
+++ b/refs.c
@@ -681,9 +681,19 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	if (old_oid) {
 		struct object_id actual_old_oid;
 
-		if (read_ref(pseudoref, &actual_old_oid))
-			die("could not read ref '%s'", pseudoref);
-		if (oidcmp(&actual_old_oid, old_oid)) {
+		if (read_ref(pseudoref, &actual_old_oid)) {
+			if (!is_null_oid(old_oid)) {
+				strbuf_addf(err, "could not read ref '%s'",
+					    pseudoref);
+				rollback_lock_file(&lock);
+				goto done;
+			}
+		} else if (is_null_oid(old_oid)) {
+			strbuf_addf(err, "ref '%s' already exists",
+				    pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		} else if (oidcmp(&actual_old_oid, old_oid)) {
 			strbuf_addf(err, "unexpected object ID when writing '%s'",
 				    pseudoref);
 			rollback_lock_file(&lock);
-- 
2.17.0

