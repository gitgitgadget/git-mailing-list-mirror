Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D59D201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbdBRNeM (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33431 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdBRNeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:11 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so6190291pfg.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV4AsRQFvB8JxXb9wSy43uXLmnkOCay4O/1GenxKpr8=;
        b=jgeR/ZIRhqWBpDw/cUsdaHK6E0N9/5Vn+Q+9cOsxVICflbZf7YQAtoG158tZsJ4yA3
         KPD7/6Z5MkDEyNPP6vTZul3Nx2McU+TcmgTgWpVAznV2nQYWqCj8Hygdxg4Is1eRy/Ms
         ZLIE8N/ewHu3tKws7UQqfr33CIB4NodkeYk9G63W2HTI11TdVozyTBzLdsM+ZYv2wr8E
         7pS7tW9tBjN9dFpRAxYBnRBQaD195iHPb4G0pzMseLuuXDL9GjfdBigwJ/5XfzSHUERa
         PtYitWCLhZhwyFL0HhOJoQhF38Nhbeta/sqCgfrmX9dDN9+SiQgUlHzEynYoxhWCEYCK
         lwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV4AsRQFvB8JxXb9wSy43uXLmnkOCay4O/1GenxKpr8=;
        b=msd3hVaLGC+Lf3fFewHWoah9XERu+R+ETAbXtoBAiCnKAtlLkZkYfS5ECFw0kR3Cn+
         iUtL484q/l9uNEe+5uzbZ3yuhP3x4Khflu5LZ1sR/C6XPAQ+Yo4MjrehOCJcXxyRaNn+
         LXFerAYMQdy4hCTFEAMBY0sO3Gd54CBE6eowVcysvJMwvlkmSCDIWD5rxlCTKVlMNg2k
         5BLFJYBhvGxFcn84KXr4I/QNmLKssGTvhocTw+N6Lsh0fRQvifqfSajS1n7OOqI/h6UO
         +6+fPOyeQo7Ej0C+9X8e1+JCEl5olNHPMnfkw5BSvTK4M4cVdLdpzZSowaAugIGX3A2D
         6ywA==
X-Gm-Message-State: AMke39lG2iECJ9t8cK08o77rM2bOEztOmz0JTlvRyKFWr44dCl2ms2OFgDeG9dqs0PVx/A==
X-Received: by 10.84.229.76 with SMTP id d12mr18410153pln.21.1487424851052;
        Sat, 18 Feb 2017 05:34:11 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t22sm25428971pfa.114.2017.02.18.05.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:03 +0700
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
Subject: [PATCH v4 07/15] refs.c: introduce get_main_ref_store()
Date:   Sat, 18 Feb 2017 20:32:55 +0700
Message-Id: <20170218133303.3682-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index c6af84357..c3bdc99d8 100644
--- a/refs.c
+++ b/refs.c
@@ -1450,15 +1450,23 @@ static struct ref_store *ref_store_init(const char *submodule)
 	return refs;
 }
 
+static struct ref_store *get_main_ref_store(void)
+{
+	struct ref_store *refs;
+
+	if (main_ref_store)
+		return main_ref_store;
+
+	refs = ref_store_init(NULL);
+	return refs;
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
 
 	if (!submodule || !*submodule) {
-		refs = lookup_ref_store(NULL);
-
-		if (!refs)
-			refs = ref_store_init(NULL);
+		return get_main_ref_store();
 	} else {
 		refs = lookup_ref_store(submodule);
 
-- 
2.11.0.157.gd943d85

