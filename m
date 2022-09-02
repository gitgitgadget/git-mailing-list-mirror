Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1CECAAD2
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 03:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiIBDxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiIBDxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 23:53:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79ECB516E
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 20:53:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s23so517842wmj.4
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=2dowF/lEOIh9jhEAp/HpYglkMI/Sao8T8/ed/D3fawQ=;
        b=Dk287DPFXJTs51as0xH7aYUEuHA3gjD5IVx+50FT9Wa93IYwaK1B/7tidtkkowOxye
         QqR945biBgKN5ww0QSB3Cb6o1/SGbmRxVdzYcdo8IfT709uYRm9Q+0u60/G5VJbLGjgL
         BtwWBV3U5Lbo1sB3SMckHgzbCXdMOYa59ITVwiL8JrmwGCWncMbazJTBzIOFqqBw0H4e
         Bzt6rgRoc8Lns/Tyx5L3u88R+h/wP9zW/PufMXD0q/x/27wT1gXj715ez8YOBhnBIXnx
         skvJSENcexokrV1QqH6FVNJ7Vty69UFM7GE2z6k/rHL/dz6k/dzjO4K3WuLmTywCSUAi
         CvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2dowF/lEOIh9jhEAp/HpYglkMI/Sao8T8/ed/D3fawQ=;
        b=f/JURgs4HSSB0nCI3yG+lDrTE5+4seb2qESuuECoiLRghN/zvvASwWEZ5vWJ1xwm2i
         jHVf0TpblfJc1b0D8RnDVUrJSHvTjec9GNUTfCgwdFbW1WIAy1gWtnCm1Ba1FhIEu5mv
         /b3Q8TUj58Xrqqmc/V/didsESr2CdP4+ImE0EUVrcXXx3cTe/Z9pamKMNlp7ZLBRLoh5
         jU14T3tY171tGGfrLGQ1JhptHyiQrU+FJFInSh47EVfMmUbmYijGWxEcJeh+zw3tWNzI
         tP+O/AuOYbWQJGzn0Tzhu6F/k06f2ftyFTLxCRn9o8hSLxn2zl1Oib3WZzb8FSLVGZ6S
         CVDQ==
X-Gm-Message-State: ACgBeo1RIct1xVVqIG9T81xAYI60ZoLyipoWlWJWFCFQadKHC51eRAZy
        M/rOHfDnDnYl7U3RSeNleJjzJ5ldMRk=
X-Google-Smtp-Source: AA6agR5xTrtGIF9CMCbsjsLeiCYi042Ud4CEiROhiLq54t0t8UIEZHxVwnD95CT4JARdlDZVvI31jA==
X-Received: by 2002:a05:600c:3ac4:b0:3a5:f6e5:1cbc with SMTP id d4-20020a05600c3ac400b003a5f6e51cbcmr1229902wms.92.1662090814265;
        Thu, 01 Sep 2022 20:53:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020adfeb45000000b0021e43b4edf0sm469341wrn.20.2022.09.01.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:53:33 -0700 (PDT)
Message-Id: <084a037756d79d569c19bd85f30bae97b15ec26f.1662090810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
References: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
        <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 03:53:30 +0000
Subject: [PATCH v3 3/3] diff: fix filtering of merge commits under
 --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, the added logic was a bit inconsistent between these two
functions.  diff_queue_is_empty() overlooked the fact that the
additional headers strmap could be non-NULL and empty, which would cause
it to display commits that should have been filtered out.

Fix the diff_queue_is_empty() logic to also account for
additional_path_headers being empty.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 1 +
 t/t4069-remerge-diff.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/diff.c b/diff.c
index 2439310ae1f..e1f9cef2f38 100644
--- a/diff.c
+++ b/diff.c
@@ -5925,6 +5925,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     strmap_get_size(o->additional_path_headers) &&
 	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 95a16d19aec..07323ebafe0 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -56,6 +56,11 @@ test_expect_success 'remerge-diff on a clean merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'remerge-diff on a clean merge with a filter' '
+	git show --oneline --remerge-diff --diff-filter=U bc_resolution >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
-- 
gitgitgadget
