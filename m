Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A2AC0502E
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 05:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiH1FSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiH1FSG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 01:18:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CE31ED3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z16so6323934wrh.10
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=gwTlIKyOe2QThf0Yr8VcfrqGBitnhSbLhbGyZxD5R1Q=;
        b=SwbveS+InO2WJppNhZ3d4nBezjOUy5hUDytivyZ4s8Y8MHZ0fY9F67Jo42PQeqb2Px
         1RpZaMnWO/+z6afpZk45pJOgBxU/U5ap0AmKdcofEc69YT5FD7DQk4nUG7tguAyMMG4/
         Bd02vO9wQic6pKBNhqa1loDV/IeUpL83Msrm/vvQhjz9lgHeoZhKOwUjyQ/lqunu2cMb
         j/WP0J/H/kULfi2Uq6506WkQt7/HPl8nVbiGZ/jCAukPHM/iVbDV8CiJcXBI6Rpmv+ca
         pQadWMIU5Nj2zwzX++VGDHfV5nxBZD55Wx8RhTneijhYC/bZmCY+f6sqTM6IHpP5H7MP
         eNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=gwTlIKyOe2QThf0Yr8VcfrqGBitnhSbLhbGyZxD5R1Q=;
        b=cBs4TpZckhCRXLdsZVkkL+kqU6BEsLaPFpaHoqusvU2YAlQeA89ebjLN0LlvBJzxY6
         aATrLvXq60etjakQSoRG4AUL3VkL8zs68XLsRFQItf5CTWICe5QGiF9M7cY9RAImb4LB
         Uhzy7tPx7C8TmEC8Q8OHRMbVmkg5GDQaESmIwz9PBTDRy/VYBCk5B/oD41WTr3P3oM8C
         Zx6HCL1enIRyeYDHUkHXvQdkzdwg5h+kbl5Mq/Wl3DvRPYfIh1uDkAcI/E0UIryIIHjF
         pHr5pUMbVv8pxSib6dJc07/9pqe/X3eQeTKgPPeL5euTQwl3M39GXXuI+adEDgG5Zs13
         J+Bw==
X-Gm-Message-State: ACgBeo3QL+YIsNiLqjUfv4M6WUI61guckBylRkjZN/UoW8Gpb7QxhlzN
        DDzVV/49CBNPOgDHmMgCQq7hd74hh0A=
X-Google-Smtp-Source: AA6agR7cW0kKP4rrTNJ9rjzdfmCkXtVXvI47dBl4FZuDmdRTIvdt9nImJcfmI48ndAmmkgi75ysbOQ==
X-Received: by 2002:a05:6000:1c0c:b0:225:569c:dd2c with SMTP id ba12-20020a0560001c0c00b00225569cdd2cmr3191347wrb.628.1661663883661;
        Sat, 27 Aug 2022 22:18:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b003a5c244fc13sm4956450wmb.2.2022.08.27.22.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:18:02 -0700 (PDT)
Message-Id: <dce35a47012fecc6edc11c68e91dbb485c5bc36f.1661663880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 05:17:58 +0000
Subject: [PATCH 2/3] t4031: fix broken &&-chains and add missing loop
 termination
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Fix &&-chain breaks in a couple tests which went unnoticed due to blind
spots in the &&-chain linters. In particular, the "magic exit code 117"
&&-chain checker built into test-lib.sh only recognizes broken &&-chains
at the top-level; it does not work within `{...}` groups, `(...)`
subshells, `$(...)` substitutions, or within bodies of compound
statements, such as `if`, `for`, `while`, `case`, etc. Furthermore,
`chainlint.sed`, which detects broken &&-chains only in `(...)`
subshells, missed these cases (which are in subshells) because it
(surprisingly) neglects to check for intact &&-chain on single-line
`for` loops.

While at it, explicitly signal failure of commands within the `for`
loops (which might arise due to the filesystem being full or "inode"
exhaustion). This is important since failures within `for` and `while`
loops can go unnoticed if not detected and signaled manually since the
loop itself does not abort when a contained command fails, nor will a
failure necessarily be detected when the loop finishes since the loop
returns the exit code of the last command it ran on the final iteration,
which may not be the command which failed.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4301-merge-tree-write-tree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index d44c7767f30..82a104bcbc9 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -150,7 +150,7 @@ test_expect_success 'directory rename + content conflict' '
 		cd dir-rename-and-content &&
 		test_write_lines 1 2 3 4 5 >foo &&
 		mkdir olddir &&
-		for i in a b c; do echo $i >olddir/$i; done
+		for i in a b c; do echo $i >olddir/$i || exit 1; done &&
 		git add foo olddir &&
 		git commit -m "original" &&
 
@@ -662,7 +662,7 @@ test_expect_success 'directory rename + rename/delete + modify/delete + director
 		cd 4-stacked-conflict &&
 		test_write_lines 1 2 3 4 5 >foo &&
 		mkdir olddir &&
-		for i in a b c; do echo $i >olddir/$i; done
+		for i in a b c; do echo $i >olddir/$i || exit 1; done &&
 		git add foo olddir &&
 		git commit -m "original" &&
 
-- 
gitgitgadget

