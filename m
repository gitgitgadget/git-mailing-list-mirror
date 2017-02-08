Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048CB1FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbdBHJqH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 04:46:07 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36153 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbdBHJqF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 04:46:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so14748343pgf.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vs/AC6TlFYbhBSPtnxRtPF0zb7anUPxbTdMjU9ZKAUY=;
        b=f4PJaAkAkRaXZ5G8WJ72Zq09yXZSa50rLN68myrMfikr0ppz3WWYr+Rh536x73IDZQ
         kL0GMbai34YXQPz//QJsRETE/+4IRQMJmVKgxj15PU730gVpkg0AMiqGWVIRgjjyNjpR
         vXwm+dD7vob8OlB59BRntm3ohporjwOef7JSMnIM3zCB3iu2+hmboo4QUsuy/sq5C8vZ
         f8f2ysX21xHe4QKiStehrOfnvxT4S9J5wz9jhjeKPgWfXj4s4MiKEUNPzsuCloTCauWq
         XCYj2o9+fscHpcu+rstcEvCKPVnpG8AXdPXHw/Wxw0Afct4Kk4o2SvCzWrTlljM9qQAl
         v4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vs/AC6TlFYbhBSPtnxRtPF0zb7anUPxbTdMjU9ZKAUY=;
        b=fLtqy3Zjr52M6z84dDzyWmfKaZ8Pf6SeeFvT/IMhO/L1cyUTrSmvM+9Irq75vNlXKW
         u/+yNGx/bIH/zjAMO0zqU9trXlRoHOeIFIWlbb2g0TvSZVzl8R9rJhmMe5r09DRROqCi
         oUxC/9f5TCZAC86aAgKnn/CN6hTttYtDmOBve0ZF6kF5gHuvOesGS4dV4B6h4643fpHI
         O6JKhbop8KTStzj5vRPsbSBKOSc3pA8yh++ptQVz00SZshByS3SYKf8ollJw0ZgTiyVi
         CPsJxJigNYa3fxPzZvHhtBSJZVc/mM9zSs5P/rBl4HkOEEiQXao+eB5S7O1YzF6FBES0
         jV5w==
X-Gm-Message-State: AIkVDXLdcLxyYOW77BMHT4W6gDsclX+PG1Ga88FAdSvpnRTburHLaqTwT3RHZNvMLsVhpg==
X-Received: by 10.84.247.2 with SMTP id n2mr32397662pll.39.1486547164878;
        Wed, 08 Feb 2017 01:46:04 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id l22sm18444074pgc.43.2017.02.08.01.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 01:46:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 08 Feb 2017 16:45:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] refs-internal.c: make files_log_ref_write() static
Date:   Wed,  8 Feb 2017 16:45:58 +0700
Message-Id: <20170208094558.23712-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
but probably never used outside refs-internal.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 +++
 refs/refs-internal.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c041d4ba21..6a0bf94bf1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
+static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 25444cf5b0..4c9215d33f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -220,10 +220,6 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err);
-
 /*
  * Check for entries in extras that are within the specified
  * directory, where dirname is a reference directory name including
-- 
2.11.0.157.gd943d85

