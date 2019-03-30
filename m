Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054C920248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfC3LWZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33331 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfC3LWY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2266514pfd.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=AORPUZLRMrVUv0whLSnb0LQKQWeOBaL93iH1riebYV9tgcYLMeT5442CG3DdEcqSfd
         TthAHR1+gY1RuNvrLAykuqRQMAJNZP1ZVnBmeJ9gNb9O3B7F9fD/clZc+TprPtxkyFId
         8noT3zaf51uG1kYphVFZRw4ovD8Q8pKopXNZIMqbiMdad05wXMwZv4gkrqb+nd1jEzea
         9FGIusQOb/q2OftI6sVwqRkTyXWUvPEqcYG+jZf9fFp0ScFwTtqxGrpxKUOQTfBCgxgy
         d9Bhu+EJXpELi68tvtxltmYyFYp9kR2l+konb4wI96cqL+C03yokEwxqGAi2vBj1IEEb
         xn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=pdKfpAx/2N6hjlIMTdgPZTka+3sMPEkd72bn9jtiUp6Iut7VRcf9HivhG7DOWvLt/q
         +RK+8VXZRjsoZi8AtvhsKcw6li33cu7auE7weyFX0nnxPU5oXXSZiKIBlSwV3XJK5m9h
         /Gdr7SXemcPJYS4CrLKjCTomx0orhZ7ss+KvdRvAf6SfQgAb/HfVd03jzC06ATKknzKn
         T/7yX467Q2gaVaya3zHCIkAadRQ5ZiPpzwLTogCKev717A6w2l+gXG/9hbrFuqt0sQo6
         D0PatePS5S5Xg9YkowUE/m7oayA3Sjz7IyXSAuvVtPjRQQ0gzok7y5woDbnQJSCFplKx
         P8zw==
X-Gm-Message-State: APjAAAX43g8eVhw2bVdz1PwzevXaB67wxg72nGXdzRIl8aO9kyiIGA4P
        /YjB00GoEb1dOowNMUI5ZSYiUbY7
X-Google-Smtp-Source: APXvYqwZfaOz3Ic99WYCKERhCiV0jkl6fCXayWMqMIONQlOGy7TySgMspL2Hqd2yz3WD5CxPMy492w==
X-Received: by 2002:a65:6489:: with SMTP id e9mr35053138pgv.364.1553944943717;
        Sat, 30 Mar 2019 04:22:23 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id f65sm7037356pff.21.2019.03.30.04.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/31] sha1-name.c: remove the_repo from handle_one_ref()
Date:   Sat, 30 Mar 2019 18:19:19 +0700
Message-Id: <20190330111927.18645-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5741a9f821..d9050776dd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1189,15 +1189,21 @@ static enum get_oid_result get_oid_1(struct repository *r,
 /* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
 
+struct handle_one_ref_cb {
+	struct repository *repo;
+	struct commit_list **list;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
-	struct commit_list **list = cb_data;
-	struct object *object = parse_object(the_repository, oid);
+	struct handle_one_ref_cb *cb = cb_data;
+	struct commit_list **list = cb->list;
+	struct object *object = parse_object(cb->repo, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(the_repository, object, path,
+		object = deref_tag(cb->repo, object, path,
 				   strlen(path));
 		if (!object)
 			return 0;
@@ -1760,10 +1766,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		char *new_path = NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
+			struct handle_one_ref_cb cb;
 			struct commit_list *list = NULL;
 
-			for_each_ref(handle_one_ref, &list);
-			head_ref(handle_one_ref, &list);
+			cb.repo = repo;
+			cb.list = &list;
+			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
-- 
2.21.0.479.g47ac719cd3

