Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B398A2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdCRCeh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:34:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33518 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdCRCeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:34:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so3407319pgf.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5bjOZdrQGys7Nne0gj9jXcpnXlYnnVr7f3HkMcWt4g=;
        b=TQz9RBUKlJIbwImfRDcdZImt6b/KY4GO9yG7ymCE8S14VWp4Nn96oidyiZ3OQy9TjE
         pwmlJpiLfK+iJsaUHCwhFmSUpbC/2SXm6LJhWgI4q2exBSojaYBbPhE6Fb8KHXloDr+F
         iCASaLbM4v800xRvnCdkbWcrTRsMlK+8gQbQqFezpelNqsad6/wrxp9UtLyeh1gt82fK
         u5sZBpRLCfiPGQsRIh7ziG9bXKr2QEahEkLUIRjiUtLD/uS7OVdPBqjzO/kUFEp17LBz
         y6cs6I2tNaFuH9bIXL8Rov0Qu5WpLYBuIRsl5QMZ1laZO/4hUXz6u/dfyzJv9wQIQkeJ
         8ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5bjOZdrQGys7Nne0gj9jXcpnXlYnnVr7f3HkMcWt4g=;
        b=AmDER4ELNHlIKyLVvdPg8B15KmZSGGxTXXK2coNEW7NoUQnjWvT5himIdDtl3wwKe0
         0uOKZ2SEBZwcyB+oc1JzpbYn3rd3IArtzYfrN5YJ3ExScbH81DTsfyT1S6TPARciuPai
         4pD8c+b+a27saO4FPoq4INgfj+Axqz2HW+z3EVrhp7tJl/UlPJaGjEo64G4PW/axTrmw
         eUtyzbgS/7rHwQHKKprJkDNEf+cKWbi6T4DFeMWfCjdp0gf3ALzvPID2jhn/EKAlHzB3
         0VAGBO6+K/fnoby80U0bXBR9ZmCzVyoB7dKxBpxPMP88BAKDiPq1oeOhXuu4AisHpAHR
         kPiA==
X-Gm-Message-State: AFeK/H1xsN5v2Or6LA7MijZ9YEk8VbOXlvlT5Z+SiNBst8NgIjq7vs0UbqAlLVwA/eUZig==
X-Received: by 10.99.181.86 with SMTP id u22mr19656892pgo.120.1489802655313;
        Fri, 17 Mar 2017 19:04:15 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id d10sm19141418pfl.59.2017.03.17.19.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:09 +0700
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
Subject: [PATCH v6 02/27] files-backend: make files_log_ref_write() static
Date:   Sat, 18 Mar 2017 09:03:12 +0700
Message-Id: <20170318020337.22767-3-pclouds@gmail.com>
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

Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
but probably never used outside refs-internal.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 +++
 refs/refs-internal.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e92f9..0a6d2bf6bc 100644
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
index fa93c9a32e..f732473e1d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -228,10 +228,6 @@ struct ref_transaction {
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

