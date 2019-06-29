Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958381F461
	for <e@80x24.org>; Sat, 29 Jun 2019 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF2H6F (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 03:58:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfF2H6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 03:58:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so11176954wmj.3
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFCjoiNgYyHJWueooxUJEOfBSpQyuBpjHK0yCHajNPI=;
        b=VLBJHA777XakOwCsEZXKVRh9wQj/gyh2dRTBibZ5Y4cv9zprTf0Lph20EMcLfhKp04
         ebcMw58Ih2vl4SSRgrE6JOY8zB6jev2omWyS5jwTBtRsAzbZz5/0hWMoQznYiJER2HAR
         9FJL4iSjGF8CbCxa7IDk7KNFU+aKrghxbqZCvlV/PNZSGsSxEsZWWmqeOP4JS5+fO2TX
         LmTe9of4iioOsOktkTJE+0v24jNB7E3B6F6aq/FMrq0bNvOhTdP/65pfVmK3dGcEjyPD
         VRWalO/DZO7KWez01+yQZWSNVHtLG6vFHvlAAzUrI8+EQ2PBip4qQbdfBgbN3rpXGP3v
         0dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFCjoiNgYyHJWueooxUJEOfBSpQyuBpjHK0yCHajNPI=;
        b=ZV4Ol0zTn8MWuzw4nqZxgZTbPINswJLueENiV1VP3Fs/T+Aav+FlmkDm6Nq7a3bLgq
         w/NtQFU7CHJKmtWKzdLUfgNk38svMfZE0hC0SkOcUHu//OAhRsX1EsyI8ItQHt4Y9q1K
         rdNsRkQjC4yeLdEWIK1y2QQvniC07IIQzvOz0df48SMDGHvet+Te49JguhpF4smmTEf9
         A1ZFyX8pcM7K7js+B8LwME5ZoGJKozT61D6TSVx66m6I4IlnNLbT10H6Oet6/6a8xTmt
         tt9yFqhZtSLshxqnFYh1cPz2eS6OSFf1fAYaNqmgm/RUi8lxrrMnQQxRNfTXtgGGOf8n
         8UNw==
X-Gm-Message-State: APjAAAUgQAPDHk2HMt677lsPLQqn8laAeWa7qW+qj41bCJoMzadwedLB
        CbUYQ5iRO4oSSXKUoVe+AiKC9Mn0Ugg=
X-Google-Smtp-Source: APXvYqw6MBs0S/yFb2ew3ALhICzbr167SEyDjiYeN4pbhDzZMN1qL4raJmiPH2/cAf0egKbLcxj6rQ==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr10449080wmc.62.1561795082399;
        Sat, 29 Jun 2019 00:58:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10df:46ae:1d3b:9b5f:d57a:703b])
        by smtp.gmail.com with ESMTPSA id z5sm4155330wrh.16.2019.06.29.00.58.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 00:58:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] test-oidmap: remove 'add' subcommand
Date:   Sat, 29 Jun 2019 09:57:46 +0200
Message-Id: <20190629075747.32586-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.464.g81fc6c5d4a.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'add' subcommand is useless as it is mostly identical
to the 'put' subcommand, so let's remove it.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This and 2/2 follow this discussion about test coverage:

https://public-inbox.org/git/CAP8UFD3VFdCUwDBTb9en22FO7HnWc4vgQ4h0hhariCB=om4b8A@mail.gmail.com/

 t/helper/test-oidmap.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 7036588175..0acf99931e 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -47,21 +47,7 @@ int cmd__oidmap(int argc, const char **argv)
 		if (p1)
 			p2 = strtok(NULL, DELIM);
 
-		if (!strcmp("add", cmd) && p1 && p2) {
-
-			if (get_oid(p1, &oid)) {
-				printf("Unknown oid: %s\n", p1);
-				continue;
-			}
-
-			/* create entry with oidkey from p1, value = p2 */
-			FLEX_ALLOC_STR(entry, name, p2);
-			oidcpy(&entry->entry.oid, &oid);
-
-			/* add to oidmap */
-			oidmap_put(&map, entry);
-
-		} else if (!strcmp("put", cmd) && p1 && p2) {
+		if (!strcmp("put", cmd) && p1 && p2) {
 
 			if (get_oid(p1, &oid)) {
 				printf("Unknown oid: %s\n", p1);
-- 
2.22.0.464.g81fc6c5d4a.dirty

