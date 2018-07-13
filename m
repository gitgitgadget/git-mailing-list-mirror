Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9281F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeGPN1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46694 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeGPN1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so26230249pfl.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WrhaIhOJ1HNYvbXqjiVirhxQCisRwh5DXBlFCHcckAU=;
        b=bP1lY7v4vZ9ulc0ESiDTc2+YVm60Sc21oub8PckYleSN0WSVQweDaEI2SBVH47wwfc
         KrGXaxBliUdCRghE7ZAUpotwdzvsxL3j9cYtLKsqflbcwFv7nPVH2hycgc0T7uDIck4J
         rFsRDJ0B4VgTNP11080yCUyrRYLqiqBXxgcJrY1wuDcpDPilO42DrnZmaehs1K345bzQ
         rIdbayHPK0GjMajVJxkjcm6fqw1j1oWoQs03k6H8CiU47rCuTTS8Vjs0kQui1sc0HWdE
         EowjSDoNRcDYp25hS7Knc8Q0LZyqfGnr1ejnCUs32zw+YiEJxE0Vq0rPxTyqsUCzJ1PK
         CkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WrhaIhOJ1HNYvbXqjiVirhxQCisRwh5DXBlFCHcckAU=;
        b=JA4UgaWTjEK71IbIjgUzk17x28hxyjHDNq/UtrWKS7UNeCKD3GPtGWFPldfR3D4K2r
         LPJNppL0AhDt6BESOoYLwB5g83aZQtTeaIeeb/oBQalDuoVDRjI0hN44fv1lxEgcpxkM
         s2omJQp43WD/cW2sl9xLQnMrWgYZaTilqcW7q+UQPfwMXFLF4gyvqBUzX2tOPtoGr+cp
         IHEPnSW8QpU4wZlACrl27DinxAvKwXJQDWtW4ZlczlLBFX9//Dd0DzSZdJvr327vxSxm
         6wT9SCuAyD/DX8tagkpwubA4ZyP30oGFkrjCiLpuvPjNJpH1kXsEof8DnWDnj+7mzPOd
         EkSg==
X-Gm-Message-State: AOUpUlGyYjgjgbxK/XAA/u61v/MKMNm18OfUXFKv5g2+4qxzggwjSxdv
        wNnvULwzTLo21QRf/WFqliGe2g==
X-Google-Smtp-Source: AAOMgpdrl+9+p9xxuQNodTlA6lQ80lp01uiST5UL8aWciIi+xc0kZ+sUC/EfxlgSIRTIpXJ8OcDM0Q==
X-Received: by 2002:a65:44c3:: with SMTP id g3-v6mr15404410pgs.231.1531746030832;
        Mon, 16 Jul 2018 06:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id p11-v6sm69392868pfj.72.2018.07.16.06.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:30 -0700 (PDT)
Message-Id: <7a3e3815c585dd3972e9bea6798a7664232157a3.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 10:51:05 -0400
Subject: [PATCH 11/16] test-reach: test get_merge_bases_many
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

The get_merge_bases_many method returns a list of merge bases for a
single commit (A) against a list of commits (X). Some care is needed in
constructing the expected behavior because the result is not the
expected merge-base for an octopus merge with those parents but instead
the set of maximal commits that are reachable from A and at least one of
the commits in X.

Add get_merge_bases_many to 'test-tool reach' and create a test that
demonstrates that this output returns multiple results. Specifically, we
select a list of three commits such that we output two commits that are
reachable from one of the first two, respectively, and none are
reachable from the third.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c | 15 +++++++++++++++
 t/t6600-test-reach.sh | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 149e8f32c..97c726040 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -10,6 +10,8 @@ int cmd__reach(int ac, const char **av)
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
 	struct commit_list *X;
+	struct commit **X_array;
+	int X_nr, X_alloc;
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
@@ -20,6 +22,9 @@ int cmd__reach(int ac, const char **av)
 
 	A = B = NULL;
 	X = NULL;
+	X_nr = 0;
+	X_alloc = 16;
+	ALLOC_ARRAY(X_array, X_alloc);
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct object_id oid;
@@ -57,6 +62,8 @@ int cmd__reach(int ac, const char **av)
 
 			case 'X':
 				commit_list_insert(c, &X);
+				ALLOC_GROW(X_array, X_nr + 1, X_alloc);
+				X_array[X_nr++] = c;
 				break;
 
 			default:
@@ -71,6 +78,14 @@ int cmd__reach(int ac, const char **av)
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
+	else if (!strcmp(av[1], "get_merge_bases_many")) {
+		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
+		printf("%s(A,X):\n", av[1]);
+		while (list) {
+			printf("%s\n", oid_to_hex(&list->item->object.oid));
+			list = list->next;
+		}
+	}
 
 	exit(0);
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 99444e0f7..19e39ad7c 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -123,4 +123,19 @@ test_expect_success 'is_descendant_of:miss' '
 	test_three_modes is_descendant_of
 '
 
+test_expect_success 'get_merge_bases_many' '
+	cat >input <<-\EOF &&
+		A:commit-5-7
+		X:commit-4-8
+		X:commit-6-6
+		X:commit-8-3
+	EOF
+	{
+		printf "get_merge_bases_many(A,X):\n" &&
+		git rev-parse commit-5-6 &&
+		git rev-parse commit-4-7
+	} >expect &&
+	test_three_modes get_merge_bases_many
+'
+
 test_done
-- 
gitgitgadget

