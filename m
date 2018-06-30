Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B2C1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934009AbeF3IgW (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34629 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933567AbeF3IgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so10867035wro.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aCWqxZb1TH7myjLgGoiJ+eBkm4EGCoFAMOixQzntOd8=;
        b=j2bu5znMt6+3zSwDkGsd9M1D2vW8E9wS7MWgWm+5FTnf8oITEQxTBFAxMB2idZSqGl
         7h6wL6kPSjnjbkJhA/gOfFsVcEFbkYrh2P+wOgl/fV66niPz9qVjWFvbd5AV0dqWBQWA
         bpclHHEPVvb9FNzxPBrOI4lmiGsFsNJeNS1EuKOPuWCdTGaOhNFVGkGGWV/ZNHeuxYLV
         6pakOpis+Yf4mUgP7gX/cajzaUGqNqGfZ7WF7Po6QXNgt2yjmfwTH/G7JPvppeb+V4dR
         bEW4BPBRulB9P/5LXmiHL509mCb0Z8CXy6vekV2cUay2faCiH4vflOhxvgDEeSXa6Dnd
         3g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aCWqxZb1TH7myjLgGoiJ+eBkm4EGCoFAMOixQzntOd8=;
        b=OGdDUfTdyAOPuX+nliAn4EGdiV5brxt5NJcgQoR1qSHJ8vixjsgkNqAcBH3gVSs43k
         6LuuMQ8YtniO9T4FgwuOewAI2SJWjQ3w1UkkMcoZtykL1Eritmdz4xdmI9uIusCicvKM
         dSVqjSx99in3/oazwSuMASSZV6x7rytLi/JhgfvJxA6sKKmo8di4r0MXywfgGFOVj2yP
         B9xAdtGvkV0ymlRk9vengrVmz2fVksHNPCWkdG9oANGLn6nWcuny8j6qZEomT7YtfhOZ
         xdaHbYuH9AqeMtoAjQfGapKdg1KlW3LjX/JCHf4uCLF0LWAKXGzdXA6FqaQh/Pn0wRZd
         Owjg==
X-Gm-Message-State: APt69E3s8QTAWgLxBm9K5tYUvUftbsSYmpjHyTeVKGvgkkHr+chxWabN
        l+io24QKOJlTOeV+EDtXaSa89k0q
X-Google-Smtp-Source: AAOMgpdplA72OAWC75J4GOVBVcsl220acP/WFFobekwKb53ucXq7laIhdIUNGETyoZ/7pkVvlLKAiw==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr14825518wrj.109.1530347767093;
        Sat, 30 Jun 2018 01:36:07 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:06 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/9] remote-odb: add remote_odb_reinit()
Date:   Sat, 30 Jun 2018 10:35:38 +0200
Message-Id: <20180630083542.20347-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will need to reinitialize the remote odb configuration
as we will make some changes to it in a later commit when
we will detect that a remote is also a remote odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 remote-odb.c | 14 ++++++++++++--
 remote-odb.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/remote-odb.c b/remote-odb.c
index 5aa36021dd..d465875a4d 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -64,17 +64,27 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void remote_odb_init(void)
+static void remote_odb_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(remote_odb_config, NULL);
 }
 
+static inline void remote_odb_init(void)
+{
+	remote_odb_do_init(0);
+}
+
+inline void remote_odb_reinit(void)
+{
+	remote_odb_do_init(1);
+}
+
 struct odb_helper *find_odb_helper(const char *remote)
 {
 	struct odb_helper *o;
diff --git a/remote-odb.h b/remote-odb.h
index e10a8bf855..79803782af 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_ODB_H
 #define REMOTE_ODB_H
 
+extern void remote_odb_reinit(void);
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const unsigned char *sha1);
-- 
2.18.0.138.gac082779dc

