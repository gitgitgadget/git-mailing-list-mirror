Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B0A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGPN1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38403 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeGPN1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so6240158pff.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lB04JKwskabFxR6iDhLuKE9r9pjnKt1CNJ/YEM4EqdE=;
        b=MkIWSUzZGBCdmcs6jw49YDd1Zq9KBFQhm6ZOH5kDagTaHZZ55F+N90sp+ZojvqkBW+
         AXkf/jiIKi/oKXPkjXq7YkPN2kX6GVKdTij9WPY/Zihw4m9Szx+NRUd2zSTn5zoyvmf8
         AYiSCKreKRvtIYs+0FOqfzjV2tQT6exh451MOjyHKPdOP8FMbH+HBZb44jA6PG3UyIHw
         728j1sQNOZI8ZVygPBvlKkrFdsvOdSi9cr/9DclJVXrFotpRbhiupykw79AMjbOcnIBx
         qaaCG03D5lgf4sUXhtQI1xAVZcZ9Xow9c7Iz9YDSYc0T7TZdxZcONMWyDUzpU8xoao/W
         FIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lB04JKwskabFxR6iDhLuKE9r9pjnKt1CNJ/YEM4EqdE=;
        b=BzL+yQcJyBZafOGsmJtZHd7Fx1afMKE+jFzwWKWYHQQVB+qgfCcOXfhJp/pm4Irplt
         W6W9hk6LwyFSp+lkpp6j9ukkdTUzBIj8d5984Etuy1gu+W9F+wxJeSUIWv1oCC9Vv7W3
         uzeDUkxfzpy6bBlTNQ+2s59/YexQiaKeGQBqTG9stlmap9PfNAjwB92+Z7s7lL1FwWmP
         R4PMEQ/2uhC+uv7St8CU0P+aO1YJBiOBt1Wtk/KXnMJr9bZAMUU9gyqOfd3fcQuYIZFW
         vR59c0GalePZ+Plw0BZjdviH30pkqOSuCtcLaCGuhQ5XrjwtuIxFAh5N8e6Y9Q/XWwJR
         2F3w==
X-Gm-Message-State: AOUpUlEmwcpiBim98wU6g6UCOA+lg57Msw1JWdKb3vDyydjFnHzJX1OW
        QUYeAO8HDbiZooqec+uj8XMa3w==
X-Google-Smtp-Source: AAOMgpdF2bkS0KJDjmpg9v8B0Uc2kR0tUMykftoQzMgjSmLbvEfYyhMahf36/fAixsYyDjNxgrWSuQ==
X-Received: by 2002:a63:5a5e:: with SMTP id k30-v6mr15770193pgm.123.1531746027881;
        Mon, 16 Jul 2018 06:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id c68-v6sm5004315pfj.51.2018.07.16.06.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:27 -0700 (PDT)
Message-Id: <dbe75e7d2192a493825ef34fecfecbc021e3d4fb.1531746011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 10:28:05 -0400
Subject: [PATCH 09/16] test-reach: test in_merge_bases
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
 t/helper/test-reach.c |  6 ++++++
 t/t6600-test-reach.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 8cc570f3b..29104d41a 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -8,6 +8,7 @@
 int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
+	struct commit *A, *B;
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
@@ -16,6 +17,7 @@ int cmd__reach(int ac, const char **av)
 	if (ac < 2)
 		exit(1);
 
+	A = B = NULL;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct object_id oid;
@@ -43,10 +45,12 @@ int cmd__reach(int ac, const char **av)
 		switch (buf.buf[0]) {
 			case 'A':
 				oidcpy(&oid_A, &oid);
+				A = c;
 				break;
 
 			case 'B':
 				oidcpy(&oid_B, &oid);
+				B = c;
 				break;
 
 			default:
@@ -57,6 +61,8 @@ int cmd__reach(int ac, const char **av)
 
 	if (!strcmp(av[1], "ref_newer"))
 		printf("%s:%d\n", av[1], ref_newer(&oid_A, &oid_B));
+	else if (!strcmp(av[1], "in_merge_bases"))
+		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 4ffe0174d..d065f2602 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -83,4 +83,22 @@ test_expect_success 'ref_newer:hit' '
 	test_three_modes ref_newer
 '
 
+test_expect_success 'in_merge_bases:hit' '
+	cat >input <<- EOF &&
+		A:commit-5-7
+		B:commit-8-8
+	EOF
+	printf "in_merge_bases(A,B):1\n" >expect &&
+	test_three_modes in_merge_bases
+'
+
+test_expect_success 'in_merge_bases:miss' '
+	cat >input <<- EOF &&
+		A:commit-6-8
+		B:commit-5-9
+	EOF
+	printf "in_merge_bases(A,B):0\n" >expect &&
+	test_three_modes in_merge_bases
+'
+
 test_done
-- 
gitgitgadget

