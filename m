Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855371F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbfFJXfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34075 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390650AbfFJXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id c26so16994953edt.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KnA30+e3AAJbIXMVx/anXWrN4GRIvEfiqITdtg6IWO4=;
        b=GFbFdbWRLde+6+UUxxE4feUQRREiW+lTA5HZTLBHgZM0IDUFb3kVl9zhl85rkHeaI/
         fgXDnTUY5IdHGr6LrDfvQ9yFeD8MYk2fOcZ2e/oXKL7FpfPnhQpPb1e/+t/Oc/O5btzv
         phZcC3aVVceatTCidZWbBMiO3asfS/k17b4bqkGcmOjtUruDzpUhewGIoiwUVStfINY/
         ZuDMyEmCRh/9in0QDo/ZBUlKPr/VOf7SxeaJW7WjHM4eQT2bt2zMLX7jFS2+VCtYzYxL
         +ZZCZcf1gak1F7yLu1zkJAkjYQe9/Zr72dcYcD3NB69I0Eo6KkcfgAmWesxV9TbMLVEG
         SZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KnA30+e3AAJbIXMVx/anXWrN4GRIvEfiqITdtg6IWO4=;
        b=gDs3/P//ApCMpO5afbnhjAYqJDzmcHUIOd78ORHdrQJ4YogQ+KH0CHsPd/hqhDVXuj
         JKaK48hNWaXfuzVazErN+mnt5LPlhXhgnmdwCatRlrK7f/BsGWwMdP+qmibPzoJiHhp3
         7RR8JuBotVRuzq+FLirsRmgp6ZxUVa4ElTPEJCcb3l3X6vc4NeQaRaJzIJes0shh4YdY
         lEm8HwPYePl/OVt79aS6ZDmgvc/6CZt+Y+nequZQU3lxX57CUDt0NR+8pGL+aDGJFa6W
         HbD+btAdMdo4gGpvz8hVVAA0GVdq/KZBaWZeKGUmv6cNBKGmApkzNLfhxa/gylOVH/Fn
         LZ+A==
X-Gm-Message-State: APjAAAW0XAIAm350XilFqXJp7l+s1xE4tP3CY48Kidu5d7cerGC4HGGp
        cPPYcFyppk4fXthlTdC2UcnE1uhu
X-Google-Smtp-Source: APXvYqy5X468jnX1nhe+BUqGKdPOarfUBOUBDvOgyTrVmQUDBF8LCcXPaOd30/CM7APKxQ0DuSuVZA==
X-Received: by 2002:a17:906:79d6:: with SMTP id m22mr50522033ejo.187.1560209728222;
        Mon, 10 Jun 2019 16:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm3152165edt.65.2019.06.10.16.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:27 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:27 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:18 GMT
Message-Id: <80c7d2e5810cf851af11154dbe1e5abaa852a224.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/11] multi-pack-index: test expire while adding packs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During development of the multi-pack-index expire subcommand, a
version went out that improperly computed the pack order if a new
pack was introduced while other packs were being removed. Part of
the subtlety of the bug involved the new pack being placed before
other packs that already existed in the multi-pack-index.

Add a test to t5319-multi-pack-index.sh that catches this issue.
The test adds new packs that cause another pack to be expired, and
creates new packs that are lexicographically sorted before and
after the existing packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 6e47e5d0b2..8e04ce2821 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -478,4 +478,36 @@ test_expect_success 'expire removes repacked packs' '
 	)
 '
 
+test_expect_success 'expire works when adding new packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/a-pack <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/z-pack <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index expire &&
+		ls .git/objects/pack/ | grep idx >expect &&
+		test-tool read-midx .git/objects | grep idx >actual &&
+		test_cmp expect actual &&
+		git multi-pack-index verify
+	)
+'
+
 test_done
-- 
gitgitgadget

