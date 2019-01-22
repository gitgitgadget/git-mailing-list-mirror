Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B302141C
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfAVOmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38194 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbfAVOmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so14555529wml.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8EKzOQkw1/a+/VAoKACgWEZrZTAbWG0UF0Fwu6c+Vk=;
        b=uGmn6IhxD/47+EuNLxCLUsFebtvFTtoNNLGtvTZfjxuIK7345JqqBsMNedtLgzHrQl
         Ej+bmmDhl6YWQivTvo3x2JiRq6H1WkCDIikTO044UhZOYICUrAG4j8VKBvtFRIKX4reu
         lhE8YJrF4ocOM9EcIuVYX2o6bJ3zThJupHh1Z8m+on3BgSAFSOXrY72miw9RUPngrRoj
         ZgDhSlJlATj5JIaLKnZFpMNMjtgSutAcqk99ByqtIVDkWDX3j13sXNmzfAa/Jxyssig/
         W8w+S85iZFiHlQ7JqFHcQcyRJNb8Z3r4LSrsUwd7LLSh7DFVrRoPxD8tQCLrKFtoW0C7
         HAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8EKzOQkw1/a+/VAoKACgWEZrZTAbWG0UF0Fwu6c+Vk=;
        b=TGZtOMOHDwLwoWrjm/f/7DkDPs2Zefmpk7k1GldaAaOobZImk5jXBNqK0LJOzhJxAM
         AzcNcqGGJQRGzQdIvSkFqqjPmwU4ay9riAT58AltmyNimlZbhHjhcfRYqakf0CmkvPeb
         K2EiGrV0Gg022JqvdssHorLZxnvPLV6atSVHp7c3UvPDWZMC0OTmVgVBI15NRnhfKDmu
         g68Oyf99pd80qC6NI1A/TiEE5tk2jL6bdKrJyTZNqWlEar/X4DQHU+DlitjqE0F5F01T
         aJHo40dOmhNl7FTRZij627l+PCz/UFQH/mOCaYYPrr0zUyGJOAsJJaw1B+N7Xo7ss6l8
         bsJg==
X-Gm-Message-State: AJcUukdcx+4GNliVMFTRK79iL8xtboWsbGJcwClg5TSEzuqZWftR2o40
        WN/ABblm8i6jqKyVMUNCzmaLTUgQ
X-Google-Smtp-Source: ALg8bN6jzKc1fVlAodQ1BxcEVxvf5jgqhakXcHyNKHu7DGerZrufH2w8iPI5cIlWGPVuBrffr2QiYw==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr3845221wmm.116.1548168154449;
        Tue, 22 Jan 2019 06:42:34 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 06/13] promisor-remote: add promisor_remote_reinit()
Date:   Tue, 22 Jan 2019 15:42:05 +0100
Message-Id: <20190122144212.15119-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We will need to reinitialize the promisor remote configuration
as we will make some changes to it in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++++--
 promisor-remote.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index f86f9d0b84..ea74f6d8a8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -74,17 +74,27 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
-static void promisor_remote_init(void)
+static void promisor_remote_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
 }
 
+static inline void promisor_remote_init(void)
+{
+	promisor_remote_do_init(0);
+}
+
+void promisor_remote_reinit(void)
+{
+	promisor_remote_do_init(1);
+}
+
 struct promisor_remote *promisor_remote_find(const char *remote_name)
 {
 	promisor_remote_init();
diff --git a/promisor-remote.h b/promisor-remote.h
index f9f5825417..f96722bc66 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -10,6 +10,7 @@ struct promisor_remote {
 	struct promisor_remote *next;
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_new(const char *remote_name);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
-- 
2.20.1.322.gd6b9ae60d4

