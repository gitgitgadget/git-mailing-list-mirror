Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68161F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162502AbeBNTA5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:00:57 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:50880 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162210AbeBNTAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:53 -0500
Received: by mail-yw0-f201.google.com with SMTP id o201so22365772ywd.17
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=F9XVTinjKH8rGfLeF17uDK9lhk+h2ZglqJuYHRltIY4=;
        b=Mo+2eMzcvYuAHfXntbfX2hX+j8FSfHsvnhpP0PrGKn7nHluHuL3V6IeaQqzHnrqcmP
         zK4FLviYri9jMsUxpJtVHagvMIbPhm7P+WvQdVKJl3oXdpOgAYl3tIX9D6UwHL5opDpo
         yhezWoOMOqNNT0s0dnVi+2GjFKWybEEZZQqHrMZ+f74X2GCVBBH4/PeA1v+pBrgIO49J
         abu3SdUPg2fpwevAt4W6905HWWZzeSi+6781BnNHhRQ8fw5+bKHn0CJODVJ5IrCXQRVD
         464beTktfE0F26380aLodRkW5DN4baUcUsc0U8MWO247IfaO26oPfwmQqXWkIbuB+jHA
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=F9XVTinjKH8rGfLeF17uDK9lhk+h2ZglqJuYHRltIY4=;
        b=E/gKapYTAtWoVlITm5k3e1J+JhqJSh3agKlyyBIEJtUe2FmuDxjNMs7YKoUoMCnuwv
         bECDrCcX3DWApbObMUgc+HN9WekeipKBUKG8WWQO8QcFbLv466WQwAGaJtcQjBy8scDy
         syl+OkYjnt22QPa0GMIomgnNpxuOHXKGTqjGMp0gwzvRU5uzsjLzDz75NFA/GedLcanq
         e9K0iegI2molIj4ccXzoqtL3PY6otVbhkJpYttYNav4YUapd8jZE9y2fo521Vl5yu6vl
         BXrLQNGGBc5e5OQodwzd/EtzaHadDVKyH7EuhIBJ37fmy0y5tZ+nHL7aoh8Dnn+yiO2U
         Hc7Q==
X-Gm-Message-State: APf1xPCY02MJ7IaUv2OaNOqwJLW7kPAkJTpBOcFLvcNEIHkv3wz6OdMy
        C1NCi2Jj4lEfVlDOj0eYkykfb8w/eyqZ4DC/ZhokLsb7niC0bT1XAjkQRAlHOzjWx5ghMwjbHfV
        zhaZi4QNgpvcgStPrbvvpaMYj39vVKoPVeB2ctpnGiMolgKZaB0So9vgsQQ==
X-Google-Smtp-Source: AH8x226eXg88y5YbgrnOEXux5cPJokRvZi5NXHLteb3/o4UqhLUI6oUmMK2JMQkQXW1G56dyQKAsbjaYKTo=
MIME-Version: 1.0
X-Received: by 10.37.35.5 with SMTP id j5mr3008566ybj.78.1518634852852; Wed,
 14 Feb 2018 11:00:52 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:26 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-5-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 04/37] pack-objects: rename 'this' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b9cfc289..bfda8602c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1376,10 +1376,10 @@ static void cleanup_preferred_base(void)
 	it = pbase_tree;
 	pbase_tree = NULL;
 	while (it) {
-		struct pbase_tree *this = it;
-		it = this->next;
-		free(this->pcache.tree_data);
-		free(this);
+		struct pbase_tree *tmp = it;
+		it = tmp->next;
+		free(tmp->pcache.tree_data);
+		free(tmp);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pbase_tree_cache); i++) {
-- 
2.16.1.291.g4437f3f132-goog

