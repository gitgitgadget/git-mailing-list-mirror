Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A643420899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbdHWMi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:38:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36718 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdHWMi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:38:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id c15so1354844pfm.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4yQu8yJiILyUvwR401o3+0gOXEhIvqSJfr7kUuSAgY=;
        b=s4D3LRxuLM3v0K/niECZGixhvfomQc74vjY9gN0lyzNXoy6ni9YnIqfflRIk1MvJWs
         zI5D+Z2nQF60kqNa//vwsZNsGi3z6q4+wrPRatR7ze8lFKcPNmxLfRYYZk4DUIdt61MU
         J1SikhHxHsXDacNE7GrHinHTWOLxZYPwpj0fopOkbFU1mQ7RqYSTEqBGlDyuj8hLjskF
         Cp/bEzBgTbK93xCSRhBBM6zmPBSAk3Lhx2qaXT8i2R8S8m1OX7UhzOpc+TgzSqu2lV8t
         BzB72j5DzRz6Fm2Y5MC04aoXOVFPYIOuaL3HsptR1iYsrVlmI4+4N8yuGOYvwPTKXdrI
         +Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4yQu8yJiILyUvwR401o3+0gOXEhIvqSJfr7kUuSAgY=;
        b=JANFzxu/bJlnft2SALekzZDpIgJraGM+UeyhfUaSVeSlQTSndNFxsGDR0l+OU2KNjc
         HgQacRD0qmmvwt2SgZTfx1Oe4Xw1OHJGLLPhgokeCq09q7mVXmuVkiw8Ln6WrmGd37BC
         yz5QBut/6VZPHVGAhYY28igNCOsVS7oZKHeOhPSbXTjusx/D5WjUQoF4oZ/Nwyq9ffZA
         qxnCslwtUOsFqTVWcyUe8APtGb1UmUWClbxzIhVdxxo2AVO20XCz5h/kBpYJoUtb3GDI
         /cKDQkEsE5/4+hx29KxGc7otiqYzqQirqfWE4mCvtEgoRs37YXfpT2q5Sv6Yty8J+Jp5
         Pn8A==
X-Gm-Message-State: AHYfb5jblP9ZaVFAwzgllk9vm4G2120f1zl+b9q92yREhchIeBdkAvvO
        u4+XCKI4I5Sb1723
X-Received: by 10.84.241.142 with SMTP id b14mr2866137pll.270.1503491936366;
        Wed, 23 Aug 2017 05:38:56 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id e16sm3427233pfb.182.2017.08.23.05.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:38:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:38:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 16/16] refs.c: reindent get_submodule_ref_store()
Date:   Wed, 23 Aug 2017 19:37:04 +0700
Message-Id: <20170823123704.16518-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the new "if (!submodule) return NULL;" code added in the previous
commit, we don't need to check if submodule is not NULL anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index a0c5078901..206af61d62 100644
--- a/refs.c
+++ b/refs.c
@@ -1590,13 +1590,11 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	if (!submodule)
 		return NULL;
 
-	if (submodule) {
-		len = strlen(submodule);
-		while (len && is_dir_sep(submodule[len - 1]))
-			len--;
-		if (!len)
-			return NULL;
-	}
+	len = strlen(submodule);
+	while (len && is_dir_sep(submodule[len - 1]))
+		len--;
+	if (!len)
+		return NULL;
 
 	if (submodule[len])
 		/* We need to strip off one or more trailing slashes */
-- 
2.11.0.157.gd943d85

