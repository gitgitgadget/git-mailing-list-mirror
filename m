Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298281F424
	for <e@80x24.org>; Tue,  3 Apr 2018 09:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbeDCJ0Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:26:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34574 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeDCJ0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:26:24 -0400
Received: by mail-io0-f193.google.com with SMTP id d6so19205142iog.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5ZjO+ft3eG4uwWz0sxmWwbxbRYT7dfspD7J5gawXks=;
        b=OVdd41XkbWXS9WJrM/DfhPZcZrxu33nUJN1scu3/FYoKCk/p2LRUgtkuX4LUveKC+d
         8ycnzfbJY2sHPYY60nj+8AJC4cvLDcyXQaqR1rAGNRaGDEJspQD1ZVEc5gnCzwHpTO8K
         weYzZz5G/OXEIuLM/S/9d6PN4UzDhsEdL5/8fbuZW4gG22vX2S3KjJcq8gIP6Nm2gNfM
         2lvhEsTpsy7vjDPYDC2OlBN9zekIBB2vteUjmJvveHeThAXnbahfTMusrl2slNOFLbWZ
         Y//olMVZ6t3UELPcd4Mtp4sgTHUx72aJeXVUJgvrKViPobdFqKj+XjWqWU3lkjeuTGlh
         J2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=N5ZjO+ft3eG4uwWz0sxmWwbxbRYT7dfspD7J5gawXks=;
        b=RjkaT4QWZ0YAkEUX+zIcRSPuAh/M6AOboV0zFFzXzj2J8xQ/Y36XCKsbr2yvJrhcCs
         JrhKR+oqSb8gpukUc/rArLDd3yse95PcjaixKfVGXv9eMt8wkbefEcaXLI8ObG2cG2Z2
         YSwNuhvBMDhNYkS/DnS8y63M6xMt00PgB71XK/qsBd621qRgTKco9/Fq/UiPx7V/cBpP
         CJn0ZJTPZVVM4yohEN+nRPXkU0iLx//QqhXuk4RQFgBBzelbE7BFSaUmAMXih5OYmbHX
         yrwdGESjOmYrcMR7aYm+0KL6wjENEsGQf2wLbawcboLi2qUX/WUzPgGVzcXNKhVvysFj
         PSJw==
X-Gm-Message-State: AElRT7FxnZvlltOPQ3IRGQAddYDQbtax9/6ku4C8yS6HTiUSW4oAih/r
        RTK3eeVp7/dGjTrMt7y3PsIymQ==
X-Google-Smtp-Source: AIpwx4/X+ass9KAn7li/JVbfwmkTW8rYrQpLda/aeRk6vyT+wmFJhOAHTOppE0+AtetZAKsagBD1yA==
X-Received: by 10.107.63.131 with SMTP id m125mr11182417ioa.219.1522747583318;
        Tue, 03 Apr 2018 02:26:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w71sm1429480iow.87.2018.04.03.02.26.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Apr 2018 02:26:22 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jens=20Kr=C3=BCger?= <Jens.Krueger@frm2.tum.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t2028: tighten grep expression to make "move worktree" test more robust
Date:   Tue,  3 Apr 2018 05:25:41 -0400
Message-Id: <20180403092541.43920-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following a rename of worktree "source" to "destination", the "move
worktree" test uses grep to verify that the output of "git worktree list
--porcelain" does not contain "source" (and does contain "destination").
Unfortunately, the grep expression is too loose and can match
unexpectedly. For example, if component of the test trash directory path
matches "source" (e.g. "/home/me/sources/git/t/trash*"), then the test
will be fooled into thinking that "source" still exists. Tighten the
expression to avoid such accidental matches.

While at it, drop an unused variable ("toplevel") from the test and
tighten a similarly too-loose expression in a related test.

Reported-by: Jens Krüger <Jens.Krueger@frm2.tum.de>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

t2028 in 2.17.0 can be fooled into failing depending upon the path of
the test's trash directory. The problem is with the test being too
loose, not with Git itself. Problem report and diagnosis here[1].

[1]: https://public-inbox.org/git/26a00c2b-c588-68d5-7085-22310c20e6df@frm2.tum.de/T/#m994cdb29f141656b0ab48dd0d152432c7e86fc20

 t/t2028-worktree-move.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 5d5b3632ba..5f7d45b7b7 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -72,12 +72,11 @@ test_expect_success 'move locked worktree' '
 '
 
 test_expect_success 'move worktree' '
-	toplevel="$(pwd)" &&
 	git worktree move source destination &&
 	test_path_is_missing source &&
 	git worktree list --porcelain >out &&
-	grep "^worktree.*/destination" out &&
-	! grep "^worktree.*/source" out &&
+	grep "^worktree.*/destination$" out &&
+	! grep "^worktree.*/source$" out &&
 	git -C destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
@@ -93,7 +92,7 @@ test_expect_success 'move worktree to another dir' '
 	test_when_finished "git worktree move some-dir/destination destination" &&
 	test_path_is_missing destination &&
 	git worktree list --porcelain >out &&
-	grep "^worktree.*/some-dir/destination" out &&
+	grep "^worktree.*/some-dir/destination$" out &&
 	git -C some-dir/destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
-- 
2.17.0.484.g0c8726318c

