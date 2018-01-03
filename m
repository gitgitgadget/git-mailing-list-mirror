Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0047D1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeACQh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44526 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeACQeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id t8so3629787wmc.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nBs43gKQN06maoKahaCfDV3jg+++RdlxeMxuEAVoZmU=;
        b=dduGy/2DZzMU2BCEOzpjYx9HQ4tYosuSvGCtn4z4yTwmxP+ARE1I1g89VdJLX3aB9x
         IbwH2WMBdGd86a6tQWGKuTj97X+wpA8992P3X1XhqRRpAFPU4F3qSFreUyW5486IRhIs
         CWP74VyW0WqR9zghOqvoKZwIAKA+fvsWnAqT8eqNjhZdtHoLK9xJcBZs7Cix+EROLxyx
         OOd6+uUhGcbIoMAi8U/S5rkGQFe3/zw3P7WpDnOOBrkZASruEw1wORLQ+Qij/T5x5KFI
         CvBTFLGmTH+y3fwaWCdGiWsagvpg6Vvy1YEkDrntUiXm3G4qzm5RWkkiZaZQJ6SOHpwE
         f3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nBs43gKQN06maoKahaCfDV3jg+++RdlxeMxuEAVoZmU=;
        b=dpFWX4ElL6I6Myk7v09iaYTLfIiSot4xmb533/SHDBA8d3wqjVVP30W2zWE7ViVQiR
         Qb8oMxex46yoYnKYbIfiEsFtM2K1KQKW718CbuV1hhxemG9L1eBepYNHK0c7RTJEqpS3
         xWZhjVwEXim2cDB1kuneR5r5ydroYU18GAB4APziGMqRNk+3wkX38BLxXqp+nRvGDtAj
         NG/BRDRAKrov8yDFAAanSxe/4X+jcaiqasVz8OOZtBzlViGbqe6z/p3Xr4PQQdRCa5Kx
         +3y3bKG0E2BqrtTIHvLZm0YX+PBINCl46QDF5Ka5ZKyAkywmchgQ6M7aaPhNPNCkyAFD
         0RMw==
X-Gm-Message-State: AKGB3mJKl+VlB1ME9MHaiez/M6BggAhIudCULNT0SYr5r4Rd5eo/vgJU
        g70RJQ7HXGLQopazQNPt8I/P1YMw
X-Google-Smtp-Source: ACJfBotUau9cQ6U/k6RiofKcJaRCLSkPJ8QYPIRvRqKXFSaDfVcjiuPMZcXeMycZZMbS9FOsrCMp7Q==
X-Received: by 10.28.35.4 with SMTP id j4mr1713373wmj.55.1514997259975;
        Wed, 03 Jan 2018 08:34:19 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:19 -0800 (PST)
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
Subject: [PATCH 03/40] external-odb: add has_external_odb()
Date:   Wed,  3 Jan 2018 17:33:26 +0100
Message-Id: <20180103163403.11303-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used to check if the external odb
mechanism is actually used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 7 +++++++
 external-odb.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 390958dbfe..d26e63d8b1 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -50,6 +50,13 @@ static void external_odb_init(void)
 	git_config(external_odb_config, NULL);
 }
 
+int has_external_odb(void)
+{
+	external_odb_init();
+
+	return !!helpers;
+}
+
 const char *external_odb_root(void)
 {
 	static const char *root;
diff --git a/external-odb.h b/external-odb.h
index ae2b228792..9a3c2f01b3 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -1,6 +1,7 @@
 #ifndef EXTERNAL_ODB_H
 #define EXTERNAL_ODB_H
 
+extern int has_external_odb(void);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

