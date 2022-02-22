Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC17C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiBVSbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiBVSbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:31:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369DEFF99
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso2518891wme.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3cAjZee38Pq4APZpZCYvwIOhIsW/vc6X6mS+Nc9ilTs=;
        b=B9w4vZa5LoDobscHqr+Z4OBNAcbCkTilZ318iiK5G70N1jvf4kBUXBDqMP11w5F87x
         sm2eV/U/EvG4k158339Soz8O/jum6y5TBKplKpC2BBuEG2//J9c7KSTGeidLyMlZPUAY
         4LAtm3AlDhv3Bws+x+A8QWpA0wBzrmpTRTIWxfP8L2mrCjkilhE3n7O1US9+rx3aev3e
         B0OsfLQ2wwFC8OgaT9ZURfXVs6LBKYMcrI0f9c419iDQX1IoIjjboy615zwMbbcSnFpI
         d8eEH/zgqj39fvFJtow0Pzs2QQ8nyZK9i0Wyo+yzOUjTitru4wHFFpIKKgNuB0FlJj0y
         FvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3cAjZee38Pq4APZpZCYvwIOhIsW/vc6X6mS+Nc9ilTs=;
        b=rm9eJ1nz2zwR09P2qUMA+JOQLhmASLwFWH7KRL3cadsV26r/kVZJoa+XbqkkjZfii9
         8IdutU9BkLTtcOobM473BCl3O4oJS7Qdv9IZLhU0mMMfFpfTQRmSE61Ca6z1bZzkomve
         f7rwgt3wPExQsXjyIasRBt2xntYzptEpoUgP3pEcVOiJ9CkBYPJsMoeYaHobxaA5GZIu
         nbO8sf4eppBt5jSStVx9bc0lQVoEOuIVoPTIan4Gks7Cksu3wMlu6UYkicxN4tSOq9BC
         nU+OYuveSlh2Wiab14QNciwYZgsOeXkfAfEAjNrst5OL0tV8/7++/62mJ462j0KWPGkb
         17GQ==
X-Gm-Message-State: AOAM530sWEcmsb+xV3FzSqqGxv4sAoa5Hc79rL2Ncs2G98mITyxCAsxQ
        fPbxED+24MUMyINOoSWL/D7bgC4Wj5Q=
X-Google-Smtp-Source: ABdhPJwkTMmZPSk7W0yRv/CgMGzpHDOUWC0imHlDdDfDQj22QZIURAbNenebqaNNtyoMOZVtwiTTNQ==
X-Received: by 2002:a05:600c:4107:b0:37b:c3f3:b4c3 with SMTP id j7-20020a05600c410700b0037bc3f3b4c3mr4418201wmi.105.1645554655110;
        Tue, 22 Feb 2022 10:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm28979876wrr.16.2022.02.22.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:30:54 -0800 (PST)
Message-Id: <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:30:49 +0000
Subject: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref
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
 t/t3903-stash.sh | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b149e2af441..ec9cc5646d6 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -185,10 +185,33 @@ test_expect_success 'drop middle stash by index' '
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
+test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
+	git reset --hard &&
+	echo 9 >file &&
+	git stash &&
+	oid="$(git rev-parse stash@{0})" &&
+	git stash drop stash@{1} &&
+	cut -d" " -f1-2 .git/logs/refs/stash >actual &&
+	cat >expect <<-EOF &&
+	$(test_oid zero) $oid
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
-	test 3 = $(cat file) &&
+	test 9 = $(cat file) &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file) &&
 	test 0 = $(git stash list | wc -l)
-- 
gitgitgadget

