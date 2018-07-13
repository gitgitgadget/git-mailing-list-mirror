Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63491F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGPN1x (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:53 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40605 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeGPN1x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:53 -0400
Received: by mail-pl0-f53.google.com with SMTP id s17-v6so5829405plp.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vVN4l2yArLuqQXdAt5BZaOZHMmudUPPCwHP3qtXTJqo=;
        b=nDhVvF5cFn07WtI1UxVKw5JUu4KmNWZb823g6fw/GvTqVCrugco6di1LArzcPbqyol
         RsuiMWLrhRswYxun7MXdmlkekJejz+H2Ajg0mwnM5ESZRbNmEL+JzYA6IV5+wKNLXEkI
         pBYVr9TMOYpLvIXPyOeLR2AdZlOWt+b+T0wTbpKYYIL9zx2Czi9WePBlQvhNrF9SJeSY
         l9Xbq+wMOlsUXXZeu7CvF46r2ngeFDVSlWWRJRx/cSkTGSzPfOykZ2lNqRwwsmgeQM3T
         KbaMRLjBt0Rt2/22km8ZekYI+BTXPZFn39dj7bVQdJGejOoqN/OH6a8SwULvjvPHQq0x
         86Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vVN4l2yArLuqQXdAt5BZaOZHMmudUPPCwHP3qtXTJqo=;
        b=hH4gK8jSPWeoDtoIJ1dC0A82FOyOCCJI3bAKEsgCE6y0dLlQQYHbRrhquj2xkG9pLT
         frgM9Zjz5TuSpALVpJTm9DHz0SyJZWQdOsINtO7yV9b+CNlCfJdMCHaZU3aFdi5aKv0i
         Q5qYagHT1sEJWoA10tZ/wefRQXuIpiGOg5XJl9x/Pt9uyApv6CIEqpM+ouEPxZ0oI24z
         4erBIAlgXyu8gSB+Wxzwew5q7cahr8L81BNTepLhWsEE9c0rO+JI599VSjPVAqs9sA2G
         8dR+o8okXlAGBFAvf9oghQSZe/sKevCcv4FPSNqSItd63Uyvo84u0G6G+9cGwGQZs9Ml
         HnMQ==
X-Gm-Message-State: AOUpUlEMIRvp05CYO6zKQusIYE8933EZzuR5hHw2AcW6ejRRiNHAV+cd
        oKk0w4poPpLUFvt9MsfRPYwv0w==
X-Google-Smtp-Source: AAOMgpfIylATcC9YTGc02YfTFNakXAEByZXvs7KepiUx4/CfvsiVPbnCIWMuLMRFgnbsxyKkPynrfg==
X-Received: by 2002:a17:902:b205:: with SMTP id t5-v6mr16270152plr.220.1531746032220;
        Mon, 16 Jul 2018 06:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id s124-v6sm2420283pgc.67.2018.07.16.06.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:31 -0700 (PDT)
Message-Id: <3b0379cf6fb42ca5ee4e10cb20bf42ff333e1456.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 12:51:23 -0400
Subject: [PATCH 12/16] test-reach: test reduce_heads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c |  7 +++++++
 t/t6600-test-reach.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 97c726040..73cb55208 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -85,6 +85,13 @@ int cmd__reach(int ac, const char **av)
 			printf("%s\n", oid_to_hex(&list->item->object.oid));
 			list = list->next;
 		}
+	} else if (!strcmp(av[1], "reduce_heads")) {
+		struct commit_list *list = reduce_heads(X);
+		printf("%s(X):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list = list->next;
+		}
 	}
 
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 19e39ad7c..e365a4ea6 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -138,4 +138,26 @@ test_expect_success 'get_merge_bases_many' '
 	test_three_modes get_merge_bases_many
 '
 
+test_expect_success 'reduce_heads' '
+	cat >input <<-\EOF &&
+		X:commit-1-10
+		X:commit-2-8
+		X:commit-3-6
+		X:commit-4-4
+		X:commit-1-7
+		X:commit-2-5
+		X:commit-3-3
+		X:commit-5-1
+	EOF
+	{
+		printf "reduce_heads(X):\n" &&
+		git rev-parse commit-5-1 &&
+		git rev-parse commit-4-4 &&
+		git rev-parse commit-3-6 &&
+		git rev-parse commit-2-8 &&
+		git rev-parse commit-1-10
+	} >expect &&
+	test_three_modes reduce_heads
+'
+
 test_done
-- 
gitgitgadget

