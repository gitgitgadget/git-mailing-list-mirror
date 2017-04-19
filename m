Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849071FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762491AbdDSLCO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:14 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35106 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762477AbdDSLCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so3585998pge.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7Zn8IVBL3RVEP7QoV5gOVdOyys7eXuYH51nSufBV68=;
        b=AdE1d7wR4I6+Rj0ws6mWBiVVKB3Xl5WSULvXLqx/41Y7tHvu+/nBaQTSNK830BD3DE
         SdienzLWEgG0h0+cl01IZ/3o27nxfm4Kcn9dUECniL97036qPFn8XbAcsby9Omt4vIEH
         jI2CiWRtNYcFMOLmTIl8z3kKSNsUkEAjiz6L43pYHTLQNL+a+cLWkGLarzEx0fjxZEA1
         e0A6XETUi5UlAK/HDLx3wZnHFCV2xsGT6MhA5QPDrR15pY/HeyjNWHXNGsnhgHI3YRHX
         DZAtzUOekzm17F7kxn0M4zSdnzeQfwBnKquzSam3PJS77Jcmc5sKDpX9iQ9nZffXJdkg
         XOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7Zn8IVBL3RVEP7QoV5gOVdOyys7eXuYH51nSufBV68=;
        b=aaxqzxROvYgUY4niHCl60FJcy7sN0T+WmNHDhNMG6E6sVaRio6dShzyJDnCf63CpcE
         HiuLolr+ed3/byp5zpeF1Oe2TC+bajVWoZr9u11biJLjuX1TYEyI00nDDnlub4GZSSoP
         vp+yF1qJAftS1pA+DanNPKLbVGYvbnWZBbDul8BqvTcBNbPE82I2qZc+mmU5F1l/jmJR
         OcXppY7ELklIP8bFgB/6cP/uAMczhHRhwDmfgChcLfOxxt6nLe//qIfMPguSVlaXWpyQ
         SQPsn6Xp7oaFcRVcWJ0Llv2ezYY5JVXg3X8vcuWj5U2DFlp2Kwz5TlTqDOiUDPSVsCFs
         h48w==
X-Gm-Message-State: AN3rC/5KujKTvjqXMbWHIeexOO6w27f3iev4u6ChqzEgDQkbS0wvFgBw
        +O8J/N6VliG7Ig==
X-Received: by 10.99.55.78 with SMTP id g14mr2484541pgn.191.1492599732985;
        Wed, 19 Apr 2017 04:02:12 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id l85sm3001389pfg.123.2017.04.19.04.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 02/12] revision.c: refactor add_index_objects_to_pending()
Date:   Wed, 19 Apr 2017 18:01:35 +0700
Message-Id: <20170419110145.5086-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core code is factored out and take 'struct index_state *' instead so
that we can reuse it to add objects from index files other than .git/index
in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 7ff61ff5f7..98146f179f 100644
--- a/revision.c
+++ b/revision.c
@@ -1263,13 +1263,13 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 
 }
 
-void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
+static void do_add_index_objects_to_pending(struct rev_info *revs,
+					    struct index_state *istate)
 {
 	int i;
 
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
 
 		if (S_ISGITLINK(ce->ce_mode))
@@ -1282,13 +1282,19 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 					     ce->ce_mode, ce->name);
 	}
 
-	if (active_cache_tree) {
+	if (istate->cache_tree) {
 		struct strbuf path = STRBUF_INIT;
-		add_cache_tree(active_cache_tree, revs, &path);
+		add_cache_tree(istate->cache_tree, revs, &path);
 		strbuf_release(&path);
 	}
 }
 
+void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
+{
+	read_cache();
+	do_add_index_objects_to_pending(revs, &the_index);
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 			    int exclude_parent)
 {
-- 
2.11.0.157.gd943d85

