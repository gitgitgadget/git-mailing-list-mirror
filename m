Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B06F1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGMUe0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:34:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33305 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:34:26 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so12643506plb.0
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=m+FsaZQrdlhCzDq1yfETYj0eWan8JCrhgLz29HwSU30=;
        b=pZWxivlKrN8DeVbM3H5gMHBYOWA/EkuBSpAXoYaayw3Qy4BEHmYiTJfMQMpMa79ihN
         SD1ps8OLGTiidsDKozgIGbml5cwl9BsGSODw3E1f4YQUr14MAmDCyYkXlNvWfx3egSJk
         XpP69M0qKaYdj/0jlBZgKb3V8ilhoAGChNF77t3dzxZ22l01pPHEK/SBTgmfSt/TdYcS
         J6VG2IIQWzW94kuPlx8Q8rVrtYcAJeLVUWLcndj7GiQksp/8ixDevqgCmWQV7k+IDg9G
         POqzNupboJwa8RELFKtFViet0p9Ta3nW90LjxUBQdBC+Sm6RjkQnJkEUENZcoKo4MmcK
         ApvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=m+FsaZQrdlhCzDq1yfETYj0eWan8JCrhgLz29HwSU30=;
        b=cUSaK9JOTBpm2SiK/hWScbKHAk9Qwzt4hGtcSUwdbz7cCeRjGFEvnc6m9teZSx84Yo
         faVnymjfxGHX0dMuX1LsDGjxW66A3FwPl3qn2u8K1++mt6WZ/pqIe6Y82gR4+nLe6mS9
         Hy+P28NohqwH6TeqsHAJBNRXJIT9BbCq4rB/bXaHx7ijO9PYOpFEwsqnfYP7v5rS5mzA
         /UAj0ubqrcBzNVyQ+JIiAs6ME604qimlkIrJE7RsUfizrOLXN9SoJhttVpGPPDA6vOzd
         w+Sg2d07Zhyh1tvP57D4kTaVo277cYDsJL380c6o79FucUHv2Xug6xH2EfjTmy4k1opK
         U3iQ==
X-Gm-Message-State: AOUpUlHANl6b14jf61Cn/EtFK/kzGeJ65KkgPXcXON9xLQ1a5mwLfTIj
        jAJIrZl4ksaaKdjABZLUAmBxdg==
X-Google-Smtp-Source: AAOMgpczVliz+9Gcz0CvMIuFFaMK8Llnsl9W/iS8d4pPWTgRnn3Uz/hIda/MaeA9P6mLDP80mBW5mQ==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr7977646plt.288.1531513096830;
        Fri, 13 Jul 2018 13:18:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id m10-v6sm35263591pgq.89.2018.07.13.13.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:18:16 -0700 (PDT)
Message-Id: <d2be4013134c0e9dc032f934c6af82721fec4eba.1531513093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.git.gitgitgadget@gmail.com>
References: <pull.9.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jul 2018 00:17:33 +0200
Subject: [PATCH 1/2] repack: point out a bug handling stale shallow info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A `git fetch --prune` can turn previously-reachable objects unreachable,
even commits that are in the `shallow` list. A subsequent `git repack
-ad` will then unceremoniously drop those unreachable commits, and the
`shallow` list will become stale. This means that when we try to fetch
with a larger `--depth` the next time, we may end up with:

	fatal: error in object: unshallow <commit-hash>

Reported by Alejandro Pauly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 943231af9..561485d31 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,4 +186,31 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_failure '.git/shallow is edited by repack' '
+	git init shallow-server &&
+	test_commit -C shallow-server A &&
+	test_commit -C shallow-server B &&
+	git -C shallow-server checkout -b branch &&
+	test_commit -C shallow-server C &&
+	test_commit -C shallow-server E &&
+	test_commit -C shallow-server D &&
+	d="$(git -C shallow-server rev-parse --verify D)" &&
+	git -C shallow-server checkout master &&
+
+	git clone --depth=1 --no-tags --no-single-branch \
+		"file://$PWD/shallow-server" shallow-client &&
+
+	: now remove the branch and fetch with prune &&
+	git -C shallow-server branch -D branch &&
+	git -C shallow-client fetch --prune --depth=1 \
+		origin "+refs/heads/*:refs/remotes/origin/*" &&
+	git -C shallow-client repack -adfl &&
+	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
+	! grep $d shallow-client/.git/shallow &&
+
+	git -C shallow-server branch branch-orig D^0 &&
+	git -C shallow-client fetch --prune --depth=2 \
+		origin "+refs/heads/*:refs/remotes/origin/*"
+'
+
 test_done
-- 
gitgitgadget

