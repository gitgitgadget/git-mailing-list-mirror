Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB06CCA47B
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357026AbiFNV2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbiFNV15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:27:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A096A27CF7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a15so12888473wrh.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h+9+nitqEtTXKr9Ey6ONDalegAbsuEUZYi3BRfqGkdE=;
        b=HklN4pZkjVA7ODuctJ3QLTD4AQ6Kng5zA7wJDeMB/n0N6c6RsdQWmYm4mochjpR7hO
         SHWMdUiDoWKTukr+PaCdu3KEADc6qU2lfRsAbzOG2j2YaM4Ge8eutUZrb4DzFRaOlvpY
         Vtbaddmmx2hYMdfI9cI/Indi/W1SxQY2yMrdvH7IgoUNFIBOoxJpz5MmBh/TVdPrbDiC
         Nv6kiSfcY2Y20V5mF50mjdTXhMYFops/6dx3AAKOWw+iwXmv91F+dxOw3tMJr4WNQhEA
         bvEvvMrcYG4d4yqEnu2+XS3uYF3njjn78Gh2XNzpV8mfXIV4x33EMCkc4s7SJ9/L76II
         BElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h+9+nitqEtTXKr9Ey6ONDalegAbsuEUZYi3BRfqGkdE=;
        b=DB/yR2HSMmR+nYmMZO3w/Q/ZwlHPruv47UnQGTXOHW2AahJ1o5WIcbmXiOJuIC3ZHx
         NHfz4O6A0+0U1d9SEjGCJIYE2JEoVq5wGDEbz6kQYsFAHls8k+PwoIVmRhYdTUdlKXxr
         7cO6BjHaQfScolXkJox4PFA1qtV/gU+wc97IT1VEUBJOnRpJAOou7XI6G6sBRcobubKE
         FkVyklHOgRJyxXtfAL0QPAPciOGXSo9yXRwJk7JdoWtaO8GCYdaYun9I8ZB/g4ZDmUx8
         vTqJLYezCjBavIhi4Bj+f/6jqSdxwlHhTVfWq/QLqaWjAT9jTdTDsarXdawUvT+wnTgn
         WeMA==
X-Gm-Message-State: AJIora+A0lEUIh6uaLYIcpbeoIgVhCKi+LryKawmMLPm2lDedGT2PfSO
        OqBlgD4WQPkVK3luO8lVwC8/BOEKy+KP9w==
X-Google-Smtp-Source: AGRyM1vPbLDDTnVewKeFoeMPteB4MMcubQe51CxaDja0plOUuVPeV454i1Xqbxd+aFw0jIo5EeuyRA==
X-Received: by 2002:a05:6000:12d0:b0:210:2ba3:e67 with SMTP id l16-20020a05600012d000b002102ba30e67mr6841845wrx.382.1655242074707;
        Tue, 14 Jun 2022 14:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020adfed8f000000b0020c5253d926sm12800326wro.114.2022.06.14.14.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:27:54 -0700 (PDT)
Message-Id: <f59a0c326a01ab5f4e415a7ed03ff046b84b337b.1655242070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 21:27:48 +0000
Subject: [PATCH 2/4] t5329: test 'git gc --cruft' without '--prune=now'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Replace a 'git repack --cruft -d' with the wrapper 'git gc --cruft' to
exercise some logic in builtin/gc.c that adds the '--cruft' option to
the underlying 'git repack' command.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5329-pack-objects-cruft.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index b481224b93d..55bb9c0e7b5 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -451,11 +451,13 @@ test_expect_success 'expiring cruft objects with git gc' '
 		sort <reachable.raw >reachable &&
 		comm -13 reachable objects >unreachable &&
 
-		git repack --cruft -d &&
+		# Write a cruft pack instead of deleting files.
+		git gc --cruft &&
 
 		mtimes=$(ls .git/objects/pack/pack-*.mtimes) &&
 		test_path_is_file $mtimes &&
 
+		# Ignore the cruft pack and delete every unreachable object.
 		git gc --cruft --prune=now &&
 
 		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
-- 
gitgitgadget

