Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A5E202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbdCIT30 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 14:29:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33189 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754704AbdCIT3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 14:29:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id 77so7742552pgc.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zS6uJCknMwf/Qtr7QzXrPVIX/d35aK12WMzzASq5KBk=;
        b=QrnoADkJtcWHWqk6BfeQ+I9VkUMzv5q4AKJ1kKc3SDwcy/8rYKBqf2AiUy+0SWMZ62
         S8qoNQ5p+YLsOyBt4MIFXF6TPujHR4ICHN54hyrx92YbCi7rVXY2O56Le+7CCnf29Iu7
         i4A7+KtzHd/mLGrZlo7FpVxXrOw2ysmDTMXF1nKSfTPs5fiy9A6yogHwjl3du3wg/TXa
         gzcmdHF4S5KeS3j/weOfQpTMQL5V+rwRoysq0IHLIAuCVBSM6jPiC7zp0qSyCmX4BJ6y
         fYlW2Y/2MUbtGBFT6YNKWO+6PpqX/gXnT+cGvgMYcmYxqm5QAK5en/InWG1yazSPAkfF
         gVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zS6uJCknMwf/Qtr7QzXrPVIX/d35aK12WMzzASq5KBk=;
        b=O8B7WqpeJbYmn89qW5yxbEdbozT5VYAXDed4pVF/8pA3o+mbUMs3YvMO63hHUs9J3H
         uYRNwEY7N+hY0kOJifCojGujPoyXLJUh4zYjOb/kJRrrQ/o579D0OIdHnnymxrf3LnvZ
         LePlvggeWL8YIdHqV5v5GAmKuZ38nQZOB3c3RlAj+SdA+GGxvzFFaGnE+O6OmxEfftH0
         wRZ/T6ZU/fZEnuT7tCtTMJjbT8Fg4uU1D66C5HNEifI/mTm+rlQOHv3vCdr6BOkCkAwR
         ObCsgQY4SlHuK5X37xE13n1JSgBTQHlSHdzMWLlSnRr/uaGQZ8ubOSvEeshJwpR5cnS5
         g1Vw==
X-Gm-Message-State: AMke39lZN8BCngd5KTzPPNOjzi0NhyrPLlQVqdwlHX6hYdB+y7cQSA31AsWBrqzZ2r8dQQ==
X-Received: by 10.99.167.9 with SMTP id d9mr15416686pgf.19.1489087217548;
        Thu, 09 Mar 2017 11:20:17 -0800 (PST)
Received: from localhost.localdomain ([47.11.13.247])
        by smtp.gmail.com with ESMTPSA id z68sm14116231pgz.11.2017.03.09.11.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 11:20:16 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     christian.couder@gmail.com
Cc:     jdl@jdl.com, git@vger.kernel.org, pc44800@gmail.com
Subject: [PATCH] t2027: avoid using pipes
Date:   Fri, 10 Mar 2017 00:48:07 +0530
Message-Id: <20170309191807.32361-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAP8UFD19njU30HODYvp1pddpZaVSVGgn7whcTa2rdjMPe-vzYQ@mail.gmail.com>
References: <CAP8UFD19njU30HODYvp1pddpZaVSVGgn7whcTa2rdjMPe-vzYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh <pc44800@gmail.com>

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh <pc44800@gmail.com>
---
 t/t2027-worktree-list.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f36..d8b3907e0 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -31,7 +31,8 @@ test_expect_success '"list" all worktrees from main' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -40,7 +41,8 @@ test_expect_success '"list" all worktrees from linked' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -73,7 +75,8 @@ test_expect_success '"list" all worktrees from bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -96,7 +99,8 @@ test_expect_success '"list" all worktrees from linked with a bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C there worktree list | sed "s/  */ /g" >actual &&
+	git -C there worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -118,9 +122,9 @@ test_expect_success 'broken main worktree still at the top' '
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
 		echo "ref: .broken" >../.git/HEAD &&
-		git worktree list --porcelain | head -n 3 >actual &&
+		git worktree list --porcelain >out && head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-		git worktree list | head -n 1 >actual.2 &&
+		git worktree list >out && head -n 1 out >actual.2 &&
 		grep -F "(error)" actual.2
 	)
 '
@@ -134,7 +138,7 @@ test_expect_success 'linked worktrees are sorted' '
 		test_commit new &&
 		git worktree add ../first &&
 		git worktree add ../second &&
-		git worktree list --porcelain | grep ^worktree >actual
+		git worktree list --porcelain >out && grep ^worktree out >actual
 	) &&
 	cat >expected <<-EOF &&
 	worktree $(pwd)/sorted/main
-- 
2.11.0

