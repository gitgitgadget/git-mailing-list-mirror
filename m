Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6441F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbeGPN1z (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGPN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so7474096pgp.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mo1CMvb0+wuF+9MKetnsbfwyw0hShCD3RS4eXfMY8EY=;
        b=eC++2xiwriKeOisn2SNrY3lZDyw+DTa/qSh4KATpGQV7+COMlaPY1iFjJ1EPzDCwC9
         KoX7Vfd8yULlWvkJ9pTgDXxPwphX72QWJdMcUkmuQxO/LsSJfWnVAKhCzLPWLUQOtotm
         1NRC7QY9/uUaStG2nk//pyXuCiED6CM/3TOE95tZ8pBP9BeEQ8UxDL1UwPsnGdewtp/V
         uvE7NH1RSPhiQX+EEU9jpAveUGG2f+HWzGEx6Q/54rY6Ghd7GqeEW4dLGC38eLrkfoB2
         kcYhVt5/7jI0ISgzd+63gOz5pPG0gqnAxkGOuOawf0U2j0xC2xohJNdkn+nwWq+kYY3+
         CIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mo1CMvb0+wuF+9MKetnsbfwyw0hShCD3RS4eXfMY8EY=;
        b=ByFHlzlxhakaH11AYlEVOLGxGwVQtuD8oQzS7JZiBoEBd9Xpnf9+gOlRWN5+dC4Y/c
         Gr5pwQjuz852T7+xO2ttP7xNwhUzXZiUYjOhsjM/irsPBby8DnMpY8dU6rrGSjnvf5bE
         F+4A+ezmyLC85tbFn6vDnIX+4vQ/Plhv7d00fg5C/hliigjCcFPXLjUfDgQXz/E8z+JF
         wgR162ZaDgODOtDmP42kH/mZKd/+qL3SMSOckKDwyFLZkeJ5oa08NALg6G7UpiHfBQzB
         NRExP+Q8DxTf65WviEnMOEHY8a0JVLbDIJbU+eNgjm6Vqtjn+KKCcBXSBeZReudI6KcW
         n+wA==
X-Gm-Message-State: AOUpUlHeO2apWdVebZkTkbaoIRkQRMCpQiqwqA7s2uODMW2SNNUcAwhQ
        GiPLcdr1cq4Ilx8ko7rLsdM2pg==
X-Google-Smtp-Source: AAOMgpfuqtoPoI0z+xG6G5yim5xknTIljS0u8B70PRWVpACA5OrIvVGBXGkTIlHqey6mFiFxw86HNA==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr17956702pfo.160.1531746033567;
        Mon, 16 Jul 2018 06:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id x68-v6sm51351571pfb.138.2018.07.16.06.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:32 -0700 (PDT)
Message-Id: <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 13:22:57 -0400
Subject: [PATCH 13/16] test-reach: test can_all_from_reach_with_flags
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

The can_all_from_reach_with_flags method is used by ok_to_give_up in
upload-pack.c to see if we have done enough negotiation during a fetch.
This method is intentionally created to preserve state between calls to
assist with stateful negotiation, such as over SSH.

To make this method testable, add a new can_all_from_reach method that
does the initial setup and final tear-down. Call the method from
'test-tool reach'.

Since this is a many-to-many reachability query, add a new type of input
to the 'test-tool reach' input format. Lines "Y:<committish>" create a
list of commits to be the reachability targets from the commits in the
'X' list. In the context of fetch negotiation, the 'X' commits are the
'want' commits and the 'Y' commits are the 'have' commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 47 +++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        |  2 ++
 t/helper/test-reach.c | 10 +++++++--
 t/t6600-test-reach.sh | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e07ff993f..c5e89a2de 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -593,3 +593,50 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	}
 	return 1;
 }
+
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int cutoff_by_min_date)
+{
+	struct object_array from_objs = OBJECT_ARRAY_INIT;
+	time_t min_commit_date = cutoff_by_min_date ? from->item->date : 0;
+	struct commit_list *from_iter = from, *to_iter = to;
+	int result;
+
+	while (from_iter) {
+		add_object_array(&from_iter->item->object, NULL, &from_objs);
+
+		if (!parse_commit(from_iter->item)) {
+			if (from_iter->item->date < min_commit_date)
+				min_commit_date = from_iter->item->date;
+		}
+
+		from_iter = from_iter->next;
+	}
+
+	while (to_iter) {
+		if (!parse_commit(to_iter->item)) {
+			if (to_iter->item->date < min_commit_date)
+				min_commit_date = to_iter->item->date;
+		}
+
+		to_iter->item->object.flags |= PARENT2;
+
+		to_iter = to_iter->next;
+	}
+
+	result = can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
+					      min_commit_date);
+
+	while (from) {
+		clear_commit_marks(from->item, PARENT1);
+		from = from->next;
+	}
+
+	while (to) {
+		clear_commit_marks(to->item, PARENT2);
+		to = to->next;
+	}
+
+	object_array_clear(&from_objs);
+	return result;
+}
diff --git a/commit-reach.h b/commit-reach.h
index ce3b963e6..58de0df56 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -68,5 +68,7 @@ int reachable(struct commit *from, int with_flag, int assign_flag,
 int can_all_from_reach_with_flag(struct object_array *from,
 				 int with_flag, int assign_flag,
 				 time_t min_commit_date);
+int can_all_from_reach(struct commit_list *from, struct commit_list *to,
+		       int commit_date_cutoff);
 
 #endif
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 73cb55208..dc9710099 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -9,7 +9,7 @@ int cmd__reach(int ac, const char **av)
 {
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
-	struct commit_list *X;
+	struct commit_list *X, *Y;
 	struct commit **X_array;
 	int X_nr, X_alloc;
 	struct strbuf buf = STRBUF_INIT;
@@ -21,7 +21,7 @@ int cmd__reach(int ac, const char **av)
 		exit(1);
 
 	A = B = NULL;
-	X = NULL;
+	X = Y = NULL;
 	X_nr = 0;
 	X_alloc = 16;
 	ALLOC_ARRAY(X_array, X_alloc);
@@ -66,6 +66,10 @@ int cmd__reach(int ac, const char **av)
 				X_array[X_nr++] = c;
 				break;
 
+			case 'Y':
+				commit_list_insert(c, &Y);
+				break;
+
 			default:
 				die("unexpected start of line: %c", buf.buf[0]);
 		}
@@ -92,6 +96,8 @@ int cmd__reach(int ac, const char **av)
 			printf("%s\n", oid_to_hex(&list->item->object.oid));
 			list = list->next;
 		}
+	} else if (!strcmp(av[1], "can_all_from_reach")) {
+		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
 	}
 
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index e365a4ea6..cb07c6431 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -160,4 +160,49 @@ test_expect_success 'reduce_heads' '
 	test_three_modes reduce_heads
 '
 
+test_expect_success 'can_all_from_reach:hit' '
+	cat >input <<-\EOF &&
+		X:commit-2-10
+		X:commit-3-9
+		X:commit-4-8
+		X:commit-5-7
+		X:commit-6-6
+		X:commit-7-5
+		X:commit-8-4
+		X:commit-9-3
+		Y:commit-1-9
+		Y:commit-2-8
+		Y:commit-3-7
+		Y:commit-4-6
+		Y:commit-5-5
+		Y:commit-6-4
+		Y:commit-7-3
+		Y:commit-8-1
+	EOF
+	printf "can_all_from_reach(X,Y):1\n" >expect &&
+	test_three_modes can_all_from_reach
+'
+
+test_expect_success 'can_all_from_reach:miss' '
+	cat >input <<-\EOF &&
+		X:commit-2-10
+		X:commit-3-9
+		X:commit-4-8
+		X:commit-5-7
+		X:commit-6-6
+		X:commit-7-5
+		X:commit-8-4
+		X:commit-9-3
+		Y:commit-1-9
+		Y:commit-2-8
+		Y:commit-3-7
+		Y:commit-4-6
+		Y:commit-5-5
+		Y:commit-6-4
+		Y:commit-8-5
+	EOF
+	printf "can_all_from_reach(X,Y):0\n" >expect &&
+	test_three_modes can_all_from_reach
+'
+
 test_done
-- 
gitgitgadget

