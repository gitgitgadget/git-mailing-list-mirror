Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E464F1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbeF3JUs (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46052 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeF3JUo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id g3-v6so9078235ljk.12
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsqKDbbBw1Hg3KMiixYzH+2a96c4wW6Wz9/d4NwUyS8=;
        b=ntPD8bq6IXKZVT/I5Osa2qO+Y0TS0nJaC4R5utgbxQ6dKDjV8ZXiOiZuvQ2fGrRs+R
         LXbhnZBmdWGIPdrOoDf/eZvC0WwLY4FQFeSECjGpm7tooXHb2mdlsK/0V9RTvkph43eW
         iRghKIne2poiJ+2kfEwHSVkVZjhL1Pl7X1nqbCvTUE1wUYMOBbz0XDpYNe3WQ9Qh8lgJ
         hHas0iHEeRCn7bC2INn2+4gj6AAiALSGqbDmQbpnyb7vu6uv5xvClIevPbfGBx/3ohVR
         Tsy/urFa+xQCkqfdflBli5U299RgYFAOoZazYd9tiOacN4EsXkl1t0JZi7+MV6vAJqkA
         h8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsqKDbbBw1Hg3KMiixYzH+2a96c4wW6Wz9/d4NwUyS8=;
        b=lmoz+DkVLeCn9DeAkDzzd9Dg+Q8DK0DDN84BC0GzdupDgijvSvRtIDI84444BTftYB
         P4If9ZxCO0WM7eu2Hll/XD6R8WH6rzDQLan3DmaFLKnZ5vWdUoJhxwHDHN22tY98KbHi
         u6TUHp6/U246H8GxHCW1oWHyK9MMNTkPE1Efufgu1k78PGK3tZbGT0JPlqNB4imJ/jZ0
         2MbT2KDAC0hUsOrzZ3gmBV16VrQOf0RZ8bk+poG2mpsO2LrpjPCUc79EeGApBqoYL15l
         IICa+t0Ch5PNXI7wlcc2HhGmHMbza5Ki7FASlt8XSPbEAULWhTmGnxdVjQ8dGfXPRhJr
         fIVQ==
X-Gm-Message-State: APt69E1wee0ZkK6D3UnMAhm347uQbQVq/5okEKU1IKdOwleDHNS6rSr8
        ujcnMOHs01VZJAM98uhZf4oxAA==
X-Google-Smtp-Source: AAOMgpcnca0X7Pn7PUoRiZOp5GbePLHsrH4dyPmrse7/M8Pbfzpc1u+I0gHRA7ng1GmiIFo5nARXyQ==
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr10279130ljs.94.1530350442493;
        Sat, 30 Jun 2018 02:20:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/12] blame.h: drop extern on func declaration
Date:   Sat, 30 Jun 2018 11:20:22 +0200
Message-Id: <20180630092031.29910-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 blame.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/blame.h b/blame.h
index a6c915c277..8c1e14980d 100644
--- a/blame.h
+++ b/blame.h
@@ -159,17 +159,21 @@ static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 		o->refcnt++;
 	return o;
 }
-extern void blame_origin_decref(struct blame_origin *o);
-
-extern void blame_coalesce(struct blame_scoreboard *sb);
-extern void blame_sort_final(struct blame_scoreboard *sb);
-extern unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
-extern void assign_blame(struct blame_scoreboard *sb, int opt);
-extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
-
-extern void init_scoreboard(struct blame_scoreboard *sb);
-extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig);
-
-extern struct blame_entry *blame_entry_prepend(struct blame_entry *head, long start, long end, struct blame_origin *o);
+void blame_origin_decref(struct blame_origin *o);
+
+void blame_coalesce(struct blame_scoreboard *sb);
+void blame_sort_final(struct blame_scoreboard *sb);
+unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entry *e);
+void assign_blame(struct blame_scoreboard *sb, int opt);
+const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
+
+void init_scoreboard(struct blame_scoreboard *sb);
+void setup_scoreboard(struct blame_scoreboard *sb,
+		      const char *path,
+		      struct blame_origin **orig);
+
+struct blame_entry *blame_entry_prepend(struct blame_entry *head,
+					long start, long end,
+					struct blame_origin *o);
 
 #endif /* BLAME_H */
-- 
2.18.0.rc2.476.g39500d3211

