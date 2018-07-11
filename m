Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8BE91F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGKD7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 23:59:24 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33100 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeGKD7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 23:59:24 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so9500811ybb.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 20:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8t3IbcrcsoIqKunrvNFY67w0Vun0a9tAJ3r0R97zoFg=;
        b=CxUTWAw2DbJ2HW7GOeWi2yDX3qJ+vaPdFC+sdwz3DMgl81eGPNGU1QuQHIP0HpYW25
         X6skggT9+H8Qc113/dB8hDRDrensKiYjl/0r9UR1ha5XOOkg7h7VJ8GklpS9rnosLvty
         e0sZd/VfsIeDCivNM/4Kh7b2QowA5uxva8YLyueqIVW4hB4S55BT4fGAAG7jjHdTRVxF
         4n54D9Q7BXOCXPc/ZWOtrYMO7dWBNjS/0O0xYvLmMnQMLt813R3noWrQeVCiynmHdgh8
         8eMEyyDrhcKTUndhZksuTj5YH1m2XjrByZ3F1s9r7zyd+9AP5mSzRluFr82pwGY2hG3J
         yuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8t3IbcrcsoIqKunrvNFY67w0Vun0a9tAJ3r0R97zoFg=;
        b=oggY/A/kM9ZUwvxrlD8lRzJ41cHaeAUiXozwO5fanurfFZMEysJMQ7K53K5VhtHlT9
         MpMZumsmzQntA3LB2D6SStYzkTyUHW3SsBVkd/2mRqz4sRqEjl4O56AzYWne8fOYoxRN
         jBkE9PsgxTdmvJ7+nh+6MoSzfuNTmMCY7Vwhd/wIFhPPaX9KU4khVo6P+qaKZ3dvpKke
         tejpFXkCkmUeUkX28BusRC2Xgkaxh6bvG1d8ysqtTxxwpgh0qvGS9RKDX1NM5ACouI/S
         iLWL0H7qBKmQaI4cmGKy7AqMl+PoNo/pUAlBK5MIG6/MLxJ5A2uVtXARSPOHz/cU4Lz7
         JDvg==
X-Gm-Message-State: APt69E2HEJQUWdGwmY5oIT7PIg4e5ZmjjIX/QodVJt3xCTwmvMC7bR33
        wE9d4VMhIpvTxJgRkgnzhCo=
X-Google-Smtp-Source: AAOMgpfpG1sEpO1LgfNmNK9R3iAnIhhfMY3V5XO436jgrVkmN6Xh31jNMPmvx+F+1wDYJgmbDVA5WA==
X-Received: by 2002:a25:6b0d:: with SMTP id g13-v6mr14483483ybc.75.1531281427798;
        Tue, 10 Jul 2018 20:57:07 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id a62-v6sm1938699ywf.79.2018.07.10.20.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 20:57:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/3] t7405: add a file/submodule conflict
Date:   Tue, 10 Jul 2018 20:56:57 -0700
Message-Id: <20180711035659.27352-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180711035659.27352-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
 <20180711035659.27352-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of a file/submodule conflict, although both cannot exist at
the same path, we expect both to be present somewhere for the user to be
able to resolve the conflict with.  Add a testcase for this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 7bfb2f498..62888c2c5 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -279,4 +279,58 @@ test_expect_success 'recursive merge with submodule' '
 	 grep "$(cat expect3)" actual > /dev/null)
 '
 
+# File/submodule conflict
+#   Commit O: <empty>
+#   Commit A: path (submodule)
+#   Commit B: path
+#   Expected: path/ is submodule and file contents for B's path are somewhere
+
+test_expect_success 'setup file/submodule conflict' '
+	test_create_repo file-submodule &&
+	(
+		cd file-submodule &&
+
+		git commit --allow-empty -m O &&
+
+		git branch A &&
+		git branch B &&
+
+		git checkout B &&
+		echo content >path &&
+		git add path &&
+		git commit -m B &&
+
+		git checkout A &&
+		test_create_repo path &&
+		test_commit -C path world &&
+		git submodule add ./path &&
+		git commit -m A
+	)
+'
+
+test_expect_failure 'file/submodule conflict' '
+	test_when_finished "git -C file-submodule reset --hard" &&
+	(
+		cd file-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+
+		# path/ is still a submodule
+		test_path_is_dir path/.git &&
+
+		# There is a submodule at "path", so B:path cannot be written
+		# there.  We expect it to be written somewhere in the same
+		# directory, though, so just grep for its content in all
+		# files, and ignore "grep: path: Is a directory" message
+		echo Checking if contents from B:path showed up anywhere &&
+		grep -q content * 2>/dev/null
+	)
+'
+
 test_done
-- 
2.18.0.132.g6e63b23f4

