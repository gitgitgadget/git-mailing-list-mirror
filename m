Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9061F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeACQge (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:34 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38434 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeACQen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so3636749wme.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/X7r6V3Ff1bI7KxchvvjBUrFC5EibqTLwvO0SKyC7c=;
        b=ON0aO4cHmx8J7ch7KRZtqq/2NtqcSW1lklKIiWNTv/Cw/YZxqVsv71+F6XO/XhUM5s
         LShAf7QwKRqw8vn7INoKS1OpjsE7di8rMjSjiBbQmIRrhccJvLYSulIJNcMrx92K+apc
         +9fcIb31lK/Fn9wfSa9ZU+FGoJNsE91hcUPATdWWY/AY1ZyJvhmE+t9GVOYBDpq9TDcq
         i9E4ylTURDid2PoPnePoarC4ZCQpn4IsWp/aPyyGtp/AOLD0Dzrr8coLDSl1rlX83Yr1
         Jdlqy9+hIkiCd3ATBX2aGVFtQtyRXBpACPC6VIu7RNvOZeQnu4rJuhbLpyuErvTnxPKl
         VitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/X7r6V3Ff1bI7KxchvvjBUrFC5EibqTLwvO0SKyC7c=;
        b=VNMKYvn1FzC0z7CNdf+Vx1E75vqy/ycIrP6e1al0VlZ8Wcc2ZW8jf76o958eJ8MCqU
         AQIh3KYahjukK3zW+oD4yNDuwThEX3K2RSYlzlGhkUqwwSGV3vugWhjLAcRNfKQyizdR
         dXepW4ffDn7Cz+4lIu3/hhecq2MHMTky5OIL5IbXsEWeYFeYKnU1lapS+EoI3KYKVqAH
         tCTvTVDb/18EyIGAWw+i/0Vphbkno803athkpZx7nEZDoVgWHH0lpp5B64HUQU9J0oMb
         EBwi7ie/qMKhDbTQtD8Vyvd+fgZTkFmf8beKxCBoFFsYul3hfZYBN7avIGKTzyJjh7zX
         ll5w==
X-Gm-Message-State: AKGB3mJdraQJYGPTgn+e8uaUcPvnDLiilcKF6HtbTiRc1noSQ/utFJPJ
        yMBtNu3Y4ipbYBPnNdfFWowNawN9
X-Google-Smtp-Source: ACJfBovLdSoHxqn1IEEr1mIniUAP1svhQWBsHP1ywch1fymuVJ4XrO31271FXs79SbkBwG01nxhsUg==
X-Received: by 10.28.49.195 with SMTP id x186mr1716736wmx.116.1514997280996;
        Wed, 03 Jan 2018 08:34:40 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:40 -0800 (PST)
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
Subject: [PATCH 16/40] odb-helper: add 'enum odb_helper_type'
Date:   Wed,  3 Jan 2018 17:33:39 +0100
Message-Id: <20180103163403.11303-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there will be different kinds of helpers, let's add
an "enum odb_helper_type" to tell between the different
kinds.

Let's add a field with this type in "struct odb_helper",
and set it when reading the config file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/odb-helper.h b/odb-helper.h
index 90b279c07e..4f2ac5e476 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -1,9 +1,18 @@
 #ifndef ODB_HELPER_H
 #define ODB_HELPER_H
 
+enum odb_helper_type {
+	ODB_HELPER_NONE = 0,
+	ODB_HELPER_GIT_REMOTE,
+	ODB_HELPER_SCRIPT_CMD,
+	ODB_HELPER_PROCESS_CMD,
+	OBJ_HELPER_MAX
+};
+
 struct odb_helper {
 	const char *name;
 	const char *dealer;
+	enum odb_helper_type type;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

