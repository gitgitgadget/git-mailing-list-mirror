Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66141F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeCSNe1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39527 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933245AbeCSNcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id f125so7349828wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uxwXZzU239pckvfguaKl+EuVd3Wz1qgH5VGQQY6yGdA=;
        b=ZH+G1zkS7SUAvLrQB2Tovt9kjYPvxDcrd8kTRad2uL/vZXEKqk6ySy5PS1F2ZLeFe8
         rv+vo30tj7va8K8xU5OV0PI2iDEJdhydOGD8CvvN9ibYfSw5WSAAHgneSY0fnSfOfmY9
         DleOL2FwjyK5id7bWLjV/D+nk7MUwFe3Hth5vkOhtyoicVVi5eN9H32GicFE3rKgm3zN
         gjfOc66skCsNX4iG76fDMrW3RmZ2L/E2pRh6OC+meVEyVmHx6hWtuBgIPSDXcV/h/PG1
         qaGqhBIrG5WiB4UuNnyNpVif6ieRhgbxhSWx/3yNbNMFU4jnUnQWxe+bOKhnBi2xT/Sp
         mPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uxwXZzU239pckvfguaKl+EuVd3Wz1qgH5VGQQY6yGdA=;
        b=QUT62yOPcxtwUrkn+1oeblR90wh0jeQwiw5d9ua3prgfNF9DbZZM8CxN25e/jPI+xe
         gQB9Jxfmv7PRwklcb0DSauJk1SbtKJ8IkM0+7AxSZfyYqE9wi/KaRVJCz3Cz5qNlI3Rv
         3e+u2lLjDvjiKOOwpEube2HS36j8mWIMcMK6pXsxdHaMTvgCok4bHVAyYbgSYFoPsMdR
         6N3cOnN7ralIxqC9Mf4V8DraQtEYTAPs+pg9ytQ0Xa3Hax9CULUa/YTty7VDLAMH1lKW
         08HzHmKFNYjlC+SMXi/t13iY1hbEO7WVF71Fu8NBMqK+5JQXF4XITYxZzyqtujk9jffi
         URKw==
X-Gm-Message-State: AElRT7HtBXXdEls3l+9l2YivcugVFH7yaEutwe9mU//B0Fnp9DAcHa7j
        jI4ggMd2c2yFR8Qpg85qW0uN1v5d
X-Google-Smtp-Source: AG47ELtBHM46a+h7CKE+Ts59MnNTZ4c2L9P4iHC23O2fGCp3SwBo+BI+5mWbO9RWHsotNSuSnzbQMA==
X-Received: by 10.28.239.18 with SMTP id n18mr9123320wmh.56.1521466339219;
        Mon, 19 Mar 2018 06:32:19 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:18 -0700 (PDT)
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
Subject: [PATCH v2 08/36] external-odb: add external_odb_reinit()
Date:   Mon, 19 Mar 2018 14:31:19 +0100
Message-Id: <20180319133147.15413-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we will need to reinitialize the list of odb helpers
from the config file, let's add external_odb_reinit() for
that purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 14 ++++++++++++--
 external-odb.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 9c77180d6c..82ac80aa04 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -39,17 +39,27 @@ static int external_odb_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void external_odb_init(void)
+static void external_odb_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized || !use_external_odb)
+	if ((!force && initialized) || !use_external_odb)
 		return;
 	initialized = 1;
 
 	git_config(external_odb_config, NULL);
 }
 
+static inline void external_odb_init(void)
+{
+	external_odb_do_init(0);
+}
+
+inline void external_odb_reinit(void)
+{
+	external_odb_do_init(1);
+}
+
 int has_external_odb(void)
 {
 	external_odb_init();
diff --git a/external-odb.h b/external-odb.h
index 27c3d39c1b..254070994a 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -9,6 +9,7 @@ enum odb_helper_type {
 	OBJ_HELPER_MAX
 };
 
+extern void external_odb_reinit(void);
 extern int has_external_odb(void);
 extern struct odb_helper *find_odb_helper(const char *dealer,
 					  enum odb_helper_type type);
-- 
2.17.0.rc0.37.g8f476fabe9

