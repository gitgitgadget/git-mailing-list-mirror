Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270551F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeEMKdF (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55879 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeEMKdC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:33:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8-v6so8842546wmg.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YnvYTnNEy0ZbdjmQHdbKi/JVJZnFXB8Twya24S1zKMU=;
        b=UOS5zc0CLPoExGeNuvvwTEVA8ATQU9s3Ny73ZPSb3OB2HOHNOjHJ3vCvkfaiPaCFLu
         E/n+YqpauAcLvQO801HHmzfJtpwYivWMxE7F+jm6hh4zLvct/VAlYqrjB2Heq6UVHpJr
         8xiZuwYTqrEGtFUZYy4BI+uwExGnOwl1q9pQ/e9h7xHOcCvZvHp0J4Gb7egHBLx5+97p
         8AouPGeUzVwaILaCIw6oreoujrW7w6Yyr6J/di6N2g/gqcsbyP39UVjICuVt/ZoW+nH4
         aS2i6aMoORmRQPvYtX+Pis59lABKKIBFwb4egiasHRf77zul5+B/EVxo4S+nbiLbe9i9
         GDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YnvYTnNEy0ZbdjmQHdbKi/JVJZnFXB8Twya24S1zKMU=;
        b=lFIAruIbTF9TGFkDmDhi1+ciSRlBFqSNCnT60n11cXj6rHBPe/w3ldIuALVj8dFECV
         Ulen2n40gVDtWsp4cmtstJ8+hv4v2J6Kc9jtIyzr2rFRwmDGogawikWwkoWAEm+6bt4+
         MWru1kT52xjIP2Ix3GZIycKOQLjoMAN6xOQyejb/X57k60dqB065XuI8tyauk4XeKhwn
         UF/QX/o8G8d8IQX45+2UKmXIl4Yy17DRhswc2l9u9w4Zg1bAzfxI0eCKepDjLxa9L2s7
         BU036biWKS7EYd4LbBi/QBZmZPLkW1mRh8s6ciSZN7iUhUJel2/MHtctyPQsAXzyyONo
         9woQ==
X-Gm-Message-State: ALKqPwcO224iaPfz5EBE8BY6tkHWEITK86XFqW0bObwotlcytAV0rdYS
        cw90gaQ8FxMc8Oa+10wNbY31l1E1
X-Google-Smtp-Source: AB8JxZoWznNcBfipCzk9XtEpfXY8nS8/aeuAmP8qoBLnuDw6WQIPEAByf8R/q1Knms/IIYkXS74++g==
X-Received: by 2002:a1c:d34e:: with SMTP id k75-v6mr2868996wmg.29.1526207581206;
        Sun, 13 May 2018 03:33:01 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:33:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 5/8] odb-remote: add odb_remote_reinit()
Date:   Sun, 13 May 2018 12:32:29 +0200
Message-Id: <20180513103232.17514-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will need to reinitialize the odb remote configuration
as we will make some changes to it in a later commit when
we will detect that a remote is also an odb remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-remote.c | 14 ++++++++++++--
 odb-remote.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/odb-remote.c b/odb-remote.c
index 9a1561430c..0a734ff379 100644
--- a/odb-remote.c
+++ b/odb-remote.c
@@ -39,17 +39,27 @@ static int odb_remote_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void odb_remote_init(void)
+static void odb_remote_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(odb_remote_config, NULL);
 }
 
+static inline void odb_remote_init(void)
+{
+	odb_remote_do_init(0);
+}
+
+inline void odb_remote_reinit(void)
+{
+	odb_remote_do_init(1);
+}
+
 struct odb_helper *find_odb_helper(const char *dealer)
 {
 	struct odb_helper *o;
diff --git a/odb-remote.h b/odb-remote.h
index e6cedde722..d862216a8f 100644
--- a/odb-remote.h
+++ b/odb-remote.h
@@ -1,6 +1,7 @@
 #ifndef ODB_REMOTE_H
 #define ODB_REMOTE_H
 
+extern void odb_remote_reinit(void);
 extern struct odb_helper *find_odb_helper(const char *dealer);
 extern int has_odb_remote(void);
 extern int odb_remote_get_direct(const unsigned char *sha1);
-- 
2.17.0.590.gbd05bfcafd

