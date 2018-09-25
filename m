Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6511F453
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeIYSBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34766 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeIYSBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so15133797wrx.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1TPPzAYx8eTf+3tateUOwAke8GGbgZ4/amSbQjcKUE=;
        b=N2iG4u3eVudnYNOCa3lyRXA94/7ndlMWk1uEKfCbWC7lae/AjmbhzyuHaBhi7iVqwZ
         UdrRvohFLiMX1mDoje6bQt6Ihh73KZsa0GwjXo2Yoh6PQnoayKPx0ZHg15cXigSrodAc
         PDsy/PxI02Sp5MbzcfEW7eyHMPS0OPozVyN1aT1RfuLu2RsE5K4wrZmSXXAwCFlM+JxH
         ZXEVzm9ThXesgFDP0D9deifZqlEF9vpZZ3WbfK60FIBAB+KUnrT3HLeEI6KhX25F1DLr
         KY8DVpZ270HZFSgHc1R4w04peo/80phz/Dqu/9MHnaU7ZFlZjLLaG8kZhaNeiJlSZM8G
         PtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1TPPzAYx8eTf+3tateUOwAke8GGbgZ4/amSbQjcKUE=;
        b=iZTa4jCZoqbaa8YwkpP62ZjNBCTUnTpiTR3VkWRVlKNvir9g3Fcb/+jolvueGYJjCL
         iGLpP2ePQ4QJujoHT8rvCjapYLKQLHVvLEiNAiTZ8Elm4tnmYquTRmqmJg3ZGb5TLVNf
         7KJTJNR9wzH6ublE1clov4MtgfZLM8dxbzU1uSzyAcNuC7oD4vM0MvekaNideLFpuXcS
         imDcB9DkSFcruRvRp53sHbh4pc5hky5EwZvuUWBEKAwFBt7rn5lpA7NRMbecoyglOh6L
         BQ7f2TAK8ZBrYan1xpkYsE45Y840Qxwsgu2E1YuO6G0B2rYwl/HmM3rM9ZvQsRIU727w
         SdCQ==
X-Gm-Message-State: ABuFfoizr2ZbNwyLB/KToicNtSipQS8xFZ0aKg6MoR3mXv377o8VcGQV
        jm2oXzMuyKnfdfxuFFq+ArT2G4ZN
X-Google-Smtp-Source: ACcGV62pCNzBKkuWWrkyXhuTimwvanxFoUM8MpvCJTqpjqz491+AE6+v9d7VKkvCTcJXnwGFC/uxMQ==
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr676124wrx.28.1537876446606;
        Tue, 25 Sep 2018 04:54:06 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:05 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 4/8] remote-odb: add remote_odb_reinit()
Date:   Tue, 25 Sep 2018 13:53:37 +0200
Message-Id: <20180925115341.19248-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We will need to reinitialize the remote odb configuration
as we will make some changes to it in a later commit when
we will detect that a remote is also a remote odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-odb.c | 14 ++++++++++++--
 remote-odb.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/remote-odb.c b/remote-odb.c
index 53900203ae..cd1b393b79 100644
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
+void remote_odb_reinit(void)
+{
+	remote_odb_do_init(1);
+}
+
 struct odb_helper *find_odb_helper(const char *remote)
 {
 	remote_odb_init();
diff --git a/remote-odb.h b/remote-odb.h
index 221305d1b6..0d1170cf41 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_ODB_H
 #define REMOTE_ODB_H
 
+extern void remote_odb_reinit(void);
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const struct object_id *oids, int oid_nr);
-- 
2.19.0.278.gca5b891cac

