Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C673F1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeFETyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:54:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42351 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeFETyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:54:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so3692595wrk.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tBLR2stFNG64BbFQePcuxctDxZmWPaT5IOMrHN3G7Xk=;
        b=g/wla+P7sKdQNDP8cmh6smOWCpnw/u8pVPQDxvbMmntQRTb9jhq5Dw8tni7I/5BXgX
         1Rz5gr56AnWjAj8X1qTDmDlhNcmpP72JeOdMK32wiM+3tNkbc2vtP/cZlRfnfMwJUuSw
         9d+j6Zhqx0b1umIXOwPROF3r6DGieejOOVOq88hzgC8LS9I35Jtvk61kaf5FpIUO74jn
         2Kiqp1WsibvhjGBU4bUg26dslfMTV9VJMnskrcynZnlrIZ04BjYpeEkDitVu5tmkYIc8
         RHWrERj7ayTFTjBzVMuNYH7ym1vREhVo7tR/5vKrwWB0M3fs3LHOMPCO8pNGbLLdedMi
         C22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tBLR2stFNG64BbFQePcuxctDxZmWPaT5IOMrHN3G7Xk=;
        b=G8id+CQunZyurs58zGMSjUdjzmWrSmu+uc5uDBzqfK+AKEyIolbghuLWNUCN2VimWq
         AzkgWzRxPC15nEyrrO5AlGYdwIvNcSjOga3ifKwINdr61OT7GGG6T/fVHUBS4v7nsF/A
         l/Y1DotvzJZK9JEjhT/LPXvy3hDUEx4yfJSzGoeAtgavbc5ztX/vxeAOriv5OGT4k66v
         flTySEZUo83DrOYvSGEdYHjsTn7N5r/C6RQAy6Gxi/vDEPkhlst2GWa8j4VQcisb0gi5
         ddgN3WxjUTaId+cohVDEHgH25pCaUgc5M5YQDbJ3bX7Q2nSPl8z4GbyHpNcgCbifUhmE
         vuSw==
X-Gm-Message-State: APt69E3odQSLWeNVjRGq2xseMTfEitMDx9jJfJMo6JAVKQ+5yJ1cEpm2
        V4ubvhWLKKcsEMQPCjh97ZBQZ52t
X-Google-Smtp-Source: ADUXVKIRqiYtAq1JWz6jO2ZZ2LptgWDRtojDO7mHWp6qLdfLoCAi61M35YP6omp0IqgECP/QG4DkWg==
X-Received: by 2002:adf:88b2:: with SMTP id f47-v6mr17089wrf.55.1528228491270;
        Tue, 05 Jun 2018 12:54:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2252533wmo.24.2018.06.05.12.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 12:54:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] refspec: s/refspec_item_init/&_or_die/g
Date:   Tue,  5 Jun 2018 19:54:38 +0000
Message-Id: <20180605195440.8505-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605195440.8505-1-avarab@gmail.com>
References: <20180605195440.8505-1-avarab@gmail.com>
In-Reply-To: <20180605162939.GA158365@google.com>
References: <20180605162939.GA158365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the refspec_item_init() function introduced in
6d4c057859 ("refspec: introduce struct refspec", 2018-05-16) to
refspec_item_init_or_die().

This follows the convention of other *_or_die() functions, and is done
in preparation for making it a wrapper for a non-fatal variant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 2 +-
 builtin/pull.c  | 2 +-
 refspec.c       | 5 +++--
 refspec.h       | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 99e73dae85..74a804f2e8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1077,7 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
+	refspec_item_init_or_die(&refspec, value.buf, REFSPEC_FETCH);
 
 	strbuf_reset(&value);
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 1f2ecf3a88..bb64631d98 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -684,7 +684,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;
 
-	refspec_item_init(&spec, refspec, REFSPEC_FETCH);
+	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
 		spec_src = "HEAD";
diff --git a/refspec.c b/refspec.c
index 78edc48ae8..0fd392e96b 100644
--- a/refspec.c
+++ b/refspec.c
@@ -124,7 +124,8 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	return 1;
 }
 
-void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
+void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
+			      int fetch)
 {
 	memset(item, 0, sizeof(*item));
 
@@ -152,7 +153,7 @@ void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;
 
-	refspec_item_init(&item, refspec, rs->fetch);
+	refspec_item_init_or_die(&item, refspec, rs->fetch);
 
 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
 	rs->items[rs->nr++] = item;
diff --git a/refspec.h b/refspec.h
index 3a9363887c..4caaf1f8e3 100644
--- a/refspec.h
+++ b/refspec.h
@@ -32,7 +32,8 @@ struct refspec {
 	int fetch;
 };
 
-void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
+void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
+			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
 void refspec_init(struct refspec *rs, int fetch);
 void refspec_append(struct refspec *rs, const char *refspec);
-- 
2.17.0.290.gded63e768a

