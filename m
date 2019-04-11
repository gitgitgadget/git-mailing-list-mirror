Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CC520248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDKNNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44023 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKNNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so3492217pgu.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IW8mzFA5tIN9tURG1EnzEXtPhTiscH+IJrKSrvOxTX4=;
        b=lv4uC9doOYPbwHncSMG3hB1VTxPdSd/e+pf4fnse3IV/AkJuV00Mg2DApBEAwTWqjw
         ZWSj8f3v3J5IaKId4kEMHKFYgVPCcSnhmkVLxiXpqLAAioxFWQZ6CCNPksGOIN7c58aP
         Eb3KpKN7b8l0IWLblNmwcLkDA8E1Xhr6BlgnLaCD7z7xrK4R6I1yBhAVizjHoMfEUFkM
         xHjrwPjNzF51Q7MiTBwBT8ZqQssWKCVHogyCA8QxC99yMRsWfnRehyofFNMPPFwCkxO6
         0AuV3YPIBTZ53Ln0sot7BjCwopChUbXjNg4FWYCPOWFaQlD67Hxzgbb9hethy+t4Q4Fy
         5vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW8mzFA5tIN9tURG1EnzEXtPhTiscH+IJrKSrvOxTX4=;
        b=JEs3biJuAXrxSS9JYC8JCCBdMtYp0OC6FcWI9K4fL/Mtqy0zjaGend2Ttdt4K7vC3f
         6h0qpE5uFJd/SmZo2CiNHZVMgQZNIzCZoEF0byBQFS7ak6EJtgzabwy/DV36ZXfHSdSa
         ctV8x6bq5odH0/KKANg7dcJOlxhkOdwnLZo1GSH1bFL6bWb2cZZZ+WeSjrBy+G+ciQcK
         lyXbQPgO37gVSYhn0MJuNW0YosrRLj3WTaiQkrkwucKy+e6QCz5rrRt2nW+rGp/1k9LI
         4RRN4FRgtXDmYIXYG5E1Q/IXHl4+z7UOLDAs9D5ZrudCQRH1cb3yRDrmPFjeg2z1yVu5
         wlww==
X-Gm-Message-State: APjAAAX8C7RMEMjsRpgJJQuYDsXX7v/iD5x7SOjOfSDPqVYYmDyTCSiU
        1+78SLxrIJHu5lw97xdbfbE=
X-Google-Smtp-Source: APXvYqw7wXIkVYrGuoWoQhtzWzk5WxbuT3Fj7Qqa/3WqQAFXIYP86Jv+snJpW52EpFATN6K/2Ftg5A==
X-Received: by 2002:a65:6645:: with SMTP id z5mr21908614pgv.251.1554988398007;
        Thu, 11 Apr 2019 06:13:18 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id m8sm40584671pgn.59.2019.04.11.06.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 07/16] restore: reject invalid combinations with --staged
Date:   Thu, 11 Apr 2019 20:12:09 +0700
Message-Id: <20190411131218.19195-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-checkout rejects plenty of invalid option combinations. Since
git-checkout is equivalent of either

    git restore --source --staged --worktree

or

    git restore --worktree

that still leaves the new mode 'git restore --index' unprotected. Reject
some more invalid option combinations.

The other new mode 'restore --source --worktree' does not need anything
else.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e855c64cfe..71e2589340 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -433,6 +433,16 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s' must be used when '%s' is not specified"),
 		    "--worktree", "--source");
 
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->writeout_stage)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--ours", "--theirs", "--staged");
+
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->merge)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--merge", "--conflict", "--staged");
+
 	if (opts->patch_mode) {
 		const char *patch_mode;
 
-- 
2.21.0.682.g30d2204636

