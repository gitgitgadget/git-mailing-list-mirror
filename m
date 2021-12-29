Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AAFC4332F
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhL2SzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhL2SzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85BC06173F
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t26so46116663wrb.4
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=LvAAHctc5YduUBHbl27HZjchERL34ubTw3A1rUUPWP0=;
        b=hAeeCYRUAr1pQiZ7kG6/g18T1q6xGVH8006s0u83O1inbCX3E58F+ksJMHa8+hbzTi
         xNih/GoRDomxQQADDZyhIWgCqgJuFv5UTcglKBK9nAUZyI3WGd5JgHIZtB8iMr49bvwE
         h8ffDljnTdhrPRW1TigMrYwoshptM1Sitc65SDlsSJzdI3GvPtZePO8iVki7X23n8MKj
         JEg9wbvvuTGpjLvrEMzW632HyTdTZP9LDgeVPfrwHkUTzsW3KQae+g2bqiWEzeCIfM8B
         4k0LeWCCMl/OQ6s7vF5DcZPZeEx/JGIlGpsWAXfwnB3znvIHsyp3hZvlZtOD1xlfUOYj
         yQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=LvAAHctc5YduUBHbl27HZjchERL34ubTw3A1rUUPWP0=;
        b=CtTXTZBqJK8C/2ZCOgXFH5G+btNGg2PmqaSt/v/uuS9YqFyTzbPlqJ6R/QVMu0OhYU
         x8HQWDAqeGo/Z+srZBw4JQ3WAL5oIu//T2jryjDtsaW16Nd9rSacWT7rIb3yDBdELix5
         L9wHD1kf2WEoq6FqYy1MhetWWO5M0ov3Ll3sJwGFYP/2c4G8TX5cufw8WlRuLZeCBANH
         O3xtOtXR/c/w63Vs3G1YWo74Ln++zXF+TgHAhZVnrAJ55KuN1xMDpcAhIBtlln4AULQ7
         tMMbm9EEppYHBIRwfuh5i+L6+q6ZbCPt3UU19nMC0nvIcfDZEMkieHPSqxKyDNsNsbDD
         /D/Q==
X-Gm-Message-State: AOAM531wNW22C4/jfJJDHYxse0qAO5ib7KEsgJPCdLjRdmfWEGUTBaIw
        3KXI/xGBvCf1TZRUAC0vuwKCaourxGM=
X-Google-Smtp-Source: ABdhPJw1litKIiXvFa9R6UilDC1eCJY7vCEw63IzhgnfPRK0eUWyOPqE/KPmZe41xVloMB/fTIEP2g==
X-Received: by 2002:a5d:6c63:: with SMTP id r3mr21568090wrz.678.1640804112771;
        Wed, 29 Dec 2021 10:55:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm16292519wrr.53.2021.12.29.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:12 -0800 (PST)
Message-Id: <2d83654c48a75cd50573f472d643851d950ebafc.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:01 +0000
Subject: [PATCH v3 05/11] i18n: tag.c factorize i18n strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/tag.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6f7cd0e3ef5..c8fcb552ef1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret = 0;
+	const char *only_in_list = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -542,13 +543,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed in list mode"));
-	if (filter.with_commit)
-		die(_("--contains option is only allowed in list mode"));
-	if (filter.no_commit)
-		die(_("--no-contains option is only allowed in list mode"));
-	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed in list mode"));
+		only_in_list = "-n";
+	else if (filter.with_commit)
+		only_in_list = "--contains";
+	else if (filter.no_commit)
+		only_in_list = "--no-contains";
+	else if (filter.points_at.nr)
+		only_in_list = "--points-at";
+	if (only_in_list)
+		die(_("the '%s' option is only allowed in list mode"), only_in_list);
 	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd') {
-- 
gitgitgadget

