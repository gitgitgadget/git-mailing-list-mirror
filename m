Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA2C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiB1Nyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiB1Ny3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:54:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED9641FB3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so15542498wra.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=orx+tEFDgMXxen+rAC9g4k/4vx8G/hRICbZCGxrMaWM=;
        b=HKoUsLrfEAeOQoF8KxpYI0MrRAZ3p/mLlldLWTBaD6iUbbnnZZhFU2JqYYrr7DaJ52
         HR9cSSwJhKsIXaQUf8H5OOUDsEWhq//pXUJVildip6u69cJJUi1NSgvHr/JNytFO2pg4
         igi9846mZN7Foe7O3QPNre6mbuPnlJkioqnuRm7alJJ7oc3LWtXsHpAJILJXI5gN8AvG
         ALSCF5CqmKEtGYJRiH07+hHIrFXhGWhaDhrrQEDESJm9O9ZgU0iPhA9DEvpJW+RFHTj8
         VL1HKIgEmqxiUeVQEdxCE/zLh4p3OnI/w1392QCus5yyLmMnldNXOwNUIXxR1cbHYQHE
         puGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=orx+tEFDgMXxen+rAC9g4k/4vx8G/hRICbZCGxrMaWM=;
        b=x34Tq6Q8/VDdB7zzssgrkOItOD5017lckzrVBEqHvyh7D41Y0vibJBKsvn95Yb5XVG
         PUAGJz5sLWaCuolwx29itya0crl0KpcTtudwhASC6fqYzFUTIMD9M9WSQWte9dQ0j9K5
         SR5FHTJcfou6zmmNCI09Wp+qOSKImSETAOiJVZ+rA1NZIVzH/H339uHhyb6HWvGHz6OT
         G+qZtYXD/QEkAQYLzxOnqD20twibFAJTO+KCdM8IH+smHtl0o8DBRlA2kla+YN9deHAm
         BlC1d3g2rEvgB7pzg6DnEMP0ctToQNLO1L/tXXTj4fTvwUPwKWeIabGTA6rhCOE5NE26
         oeOQ==
X-Gm-Message-State: AOAM531tGSACW28aFdAXmBFjg3TsSUmJidhK9sIVMAEmaeWhMJ//VRGc
        QUQNFuyuD2hZBSuMKmIxgxVsP3l1+T4=
X-Google-Smtp-Source: ABdhPJzQUVA9jn9H1gxHXDus4L8nGiqXj269qatVmqJnYLGM4sPSgNZq5HHNjArLAwDw/LPqOKntUA==
X-Received: by 2002:a05:6000:1846:b0:1ea:7f4d:c56f with SMTP id c6-20020a056000184600b001ea7f4dc56fmr15909170wri.25.1646056428028;
        Mon, 28 Feb 2022 05:53:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5411000000b001e688b4ee6asm11532038wrv.35.2022.02.28.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:53:47 -0800 (PST)
Message-Id: <193217c71e0aaf3f56a02d9abec6753bd19aba71.1646056423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 13:53:43 +0000
Subject: [PATCH v2 4/4] commit-graph: fix generation number v2 overflow values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Generation Data Chunk was implemented and tested in e8b63005c
(commit-graph: implement generation data chunk, 2021-01-16), but the
test was carefully constructed to work on systems with 32-bit dates.
Since the corrected commit date offsets still required more than 31
bits, this triggered writing the generation_data_overflow chunk.

However, upon closer look, the
write_graph_chunk_generation_data_overflow() method writes the offsets
to the chunk (as dictated by the format) but fill_commit_graph_info()
treats the value in the chunk as if it is the full corrected commit date
(not an offset). For some reason, this does not cause an issue when
using the FUTURE_DATE specified in t5318-commit-graph.sh, but it does
show up as a failure in 'git commit-graph verify' if we increase that
FUTURE_DATE to be above four billion.

Fix this error and update the test to require 64-bit dates so we can
safely use this large value in our test.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          |  2 +-
 t/t5318-commit-graph.sh | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8e52bb09552..b86a6a634fe 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -806,7 +806,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 				die(_("commit-graph requires overflow generation data but has none"));
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
-			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
+			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
 		} else
 			graph_data->generation = item->date + offset;
 	} else
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1afee1c2705..f4ffaad661d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -815,6 +815,15 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 	)
 '
 
+# The remaining tests check timestamps that flow over
+# 32-bits. The graph_git_behavior checks can't take a
+# prereq, so just stop here if we are on a 32-bit machine.
+
+if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
+then
+	test_done
+fi
+
 # We test the overflow-related code with the following repo history:
 #
 #               4:F - 5:N - 6:U
@@ -832,10 +841,10 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 # The largest offset observed is 2 ^ 31, just large enough to overflow.
 #
 
-test_expect_success 'set up and verify repo with generation data overflow chunk' '
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
 	objdir=".git/objects" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
-	FUTURE_DATE="@2147483646 +0000" &&
+	FUTURE_DATE="@4000000000 +0000" &&
 	test_oid_cache <<-EOF &&
 	oid_version sha1:1
 	oid_version sha256:2
@@ -867,4 +876,8 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
 
+# Do not add tests at the end of this file, unless they require 64-bit
+# timestamps, since this portion of the script is only executed when
+# time data types have 64 bits.
+
 test_done
-- 
gitgitgadget
