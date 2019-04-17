Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5276520248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfDQOdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39780 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfDQOdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so3866329wmk.4
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=vBYHgDWbDaKF9A5UfZDeMsu8tOyr/BCe+UTtCyUerjQ=;
        b=LWIFZ+ThS+MCUn6l324krt5bIZ5grq9Vx5xTPc9sm/u43wntyVwczDV1xrBm/IQ3Yi
         gWFlGOvTzJ5ipDsfS6MaKx5OO64hAZHDUy2njEjoAnsYbF9l3wmNF4t2U2Addpc0sk3a
         U1xvYayfuTzhtIJ59AcQUoQlT5X3RLfl7Hn03ltfqiEfMrI7cJJjnxui4U3I+utiCkvn
         QFbLG7AUC+x2uvtMEm973Om6Mc6WpYQA4aGjEvzycg3aF9ZB0EGwq5cUiD1ljTi43IID
         yEArk/S5vPn4kbHXnvu7JX83hQvCaFOkgAvLydAZBy20ev7T6Dje+p157csIq91JFSle
         KXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=vBYHgDWbDaKF9A5UfZDeMsu8tOyr/BCe+UTtCyUerjQ=;
        b=RZtkiEjerQaBUZBUcGPcE6JeD8jVeK2upWjao2IizZaoPqRqHANR80Av/4b+RoQuqh
         OxIDds7//SDXO96xAt1gapCxkHDnMJqnJ2IxDw4awndPFW1KyiRPBVvWt6XPS7M4w3kD
         x7YgMXuaAAHog1bAhI7A92pcHIEdTFY6uEIeFYxHvz6OYe1AWDpkZOjyKMYzPzuJ/dXU
         YTQkeqeBKNqIE1MI3HYxg9jQwJkXyjeA/fGqLcC1fu+f7DBtYlzKxXQDX+zjpnqTwla3
         zKzUyZS/jr3mR5WzbMGFCCtk9iWgsDVQuZuobPbsomlVf4R0B+/RBqeK6B5FWmwy5XIb
         ujsg==
X-Gm-Message-State: APjAAAUPByCuaCc9d7LPlqddNwo/SCr5+cIIfm/3kuIXAbkZcrhAoKz4
        EBsF81Dm/u8FP5sA7CBUWNesMX17lLQ=
X-Google-Smtp-Source: APXvYqzD3TmKGU/ASV9ETxwy7JSqVm2C3Vv5HRbWH1JbptgeH3My0eLRYrGWBBiOSxTC5Lq9INrxKg==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr31855317wmb.84.1555511579076;
        Wed, 17 Apr 2019 07:32:59 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:32:58 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v1 02/12] rebase: don't translate trace strings
Date:   Wed, 17 Apr 2019 15:30:34 +0100
Message-Id: <20190417143044.17655-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

commit b3a5d5a80c ("trace2:data: add subverb for rebase", 2019-02-22)
mistakenly marked the subverb names for translation and unnecessarily
NULL terminated the array.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52114cbf0d..239a54ecfe 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1027,14 +1027,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
-	static const char *action_names[] = { N_("undefined"),
-					      N_("continue"),
-					      N_("skip"),
-					      N_("abort"),
-					      N_("quit"),
-					      N_("edit_todo"),
-					      N_("show_current_patch"),
-					      NULL };
+	static const char *action_names[] = { "undefined",
+					      "continue",
+					      "skip",
+					      "abort",
+					      "quit",
+					      "edit_todo",
+					      "show_current_patch" };
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
-- 
2.21.0

