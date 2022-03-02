Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14017C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbiCBW2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiCBW2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 17:28:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E88767C
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 14:27:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d3so5010062wrf.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=S5FL+2vRrmukHzhCRHbEGsnIL8x8za4Pg7sdInF+YiE=;
        b=GrSPmqGGKaFCwFF8TDQYPEh13DDOD6aqYu9Jemlcp+i0p1y/oUx0R4JQ/Cqmlmu9zr
         eeelHyOgE1Ye1KCBQm/n4ZJpjWT/ahkmW//Uv4XxUTDu0CrPMBNUmnOFlIckEXIxHnsS
         HDxn6GHHS5TWqfSuj7PNO0NZ2Q8nwXWs8Yw99Z/dV1OBsgwjlc+MpM+REfXFDuNSHMig
         Xn474wsH6M8GkeP76+zzUVaf/IoR9X8kfQQaXh1jj09moXnLufYZszkcTg5oNmbTGu7P
         /O8wvskeHdqKiP8BMZvTOZb7GQSWSp3/0EhnRwAI9NfnVn60zMDbUBwPSYYIuXLU00MG
         Lxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=S5FL+2vRrmukHzhCRHbEGsnIL8x8za4Pg7sdInF+YiE=;
        b=bUY/CkItwEhx838XLcwCJrK3EkJoCDAVfvSWtxQ0Tn8pdO1N4m7gxKLqVn4UYoUY/H
         TrDTLspAVAgttS1B/mfqBA9YDLwwKJkm581CPJEvLAWEI3afVufAv9P9QGz7/LhGeZre
         aXO9M2Ylq2RJE4GTaYmuimn1TM4L3ro9T6L7zg1V5lPeK49j/bsz1wVGREWWAaV+Qrep
         bwfrftJUGrj3Hgkqbhd87d0oP6uFa6rHI1TO4VFY9sFnhAXA9mB0cgIiuw+28+W08y31
         gT51g6w6KYkwNkf2ji7uze8XuPjn3ubqRy8DpuWx7blkIJlEzVQFWSjQvfVXV9IuEBMK
         MK/A==
X-Gm-Message-State: AOAM532o1bne0wu43T0fMoZrmfjnYRv8h51y7WPu6dCU2UYI3ptQ/E1j
        n6ZCT3T0ugNg1FVYUMlA6G1XarqSyJM=
X-Google-Smtp-Source: ABdhPJzZRkUZFSHQ053sTZFoU1oO/q731GXeuJpiVE2z97plMDdMF2ogaJL9hGqGa2TUGxU2KIpnGQ==
X-Received: by 2002:adf:bad3:0:b0:1ef:651e:a5eb with SMTP id w19-20020adfbad3000000b001ef651ea5ebmr21050761wrg.207.1646260045810;
        Wed, 02 Mar 2022 14:27:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b001e68a5e1c20sm253121wrn.4.2022.03.02.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:27:25 -0800 (PST)
Message-Id: <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
        <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 22:27:22 +0000
Subject: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite --updatref
 behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

There is missing test coverage to ensure that the resulting reflogs
after a git stash drop has had its old oid rewritten if applicable, and
if the refs/stash has been updated if applicable.

Add two tests that verify both of these happen.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3903-stash.sh | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af441..a2f8d0c52e7 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -41,7 +41,7 @@ diff_cmp () {
 	rm -f "$1.compare" "$2.compare"
 }
 
-test_expect_success 'stash some dirty working directory' '
+setup_stash() {
 	echo 1 >file &&
 	git add file &&
 	echo unrelated >other-file &&
@@ -55,6 +55,10 @@ test_expect_success 'stash some dirty working directory' '
 	git stash &&
 	git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD
+}
+
+test_expect_success 'stash some dirty working directory' '
+	setup_stash
 '
 
 cat >expect <<EOF
@@ -185,6 +189,43 @@ test_expect_success 'drop middle stash by index' '
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success 'drop stash reflog updates refs/stash' '
+	git reset --hard &&
+	git rev-parse refs/stash >expect &&
+	echo 9 >file &&
+	git stash &&
+	git stash drop stash@{0} &&
+	git rev-parse refs/stash >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
+	git init repo &&
+	(
+		cd repo &&
+		setup_stash
+	) &&
+	echo 9 >repo/file &&
+
+	old_oid="$(git -C repo rev-parse stash@{0})" &&
+	git -C repo stash &&
+	new_oid="$(git -C repo rev-parse stash@{0})" &&
+
+	cat >expect <<-EOF &&
+	$(test_oid zero) $old_oid
+	$old_oid $new_oid
+	EOF
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	test_cmp expect actual &&
+
+	git -C repo stash drop stash@{1} &&
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	cat >expect <<-EOF &&
+	$(test_oid zero) $new_oid
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
-- 
gitgitgadget

