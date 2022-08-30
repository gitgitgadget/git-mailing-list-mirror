Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77CCECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiH3Nyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiH3Nyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:54:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50990EE04
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b16so6702207wru.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=MgfEjg3FO0CYpwLLDEFhPRr5SOj8a7Q0ikofGG3LKYLr2pDJGGzjt9EBfmjMGX29d+
         NgOiQbRT4ehMbLOyzN9cp4ZRgiSrQA6AwVzdjSjCD1pTfFjgvK2t5xleccaOgU31vWd7
         ixfqmqWv951dzMvQGkzojVsm1ZrEc9iU473LVJhgM9rQvEqiED4ckylSzGS/ozN0wMKR
         +3Bsq7vN09/tPWg05WZf7PbvMFVLdfBIQk+ITI8te3IQsy7KJDvBRH5lwxiiSZOfSv4W
         lSm85elBFj8zg8gWb2I8FZcAaeG9NcIx4w0G6agd3hhrC63hV/FbuAlBtfUtEryqyEFK
         Gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=0Pfw+c3KbnXYAbfCar/7oUvB/A6Y64nSC7Cb0JId5M1++eTcyXRA9zyFFaSTWcaO/O
         NgRD7c5M3A+vun8RAtCIb2MaF2H6RrWN/LJ2vKPTtcjcGH3acTGjOT/WuOGe+vjx/Go+
         iEbxv7S9uuujwjghbFYHg7ji2yEElrmkKLUQeSW/0rsv+z3sH3eWIVetwrVZrkQcieZi
         99wO9wCT3MFkth1UXlLWTvSj2z3nPgeWRF5war6GwEA1ALm/3yO6OGaHMHquott7oy73
         I/1UMme1Gc/aMSDaecT4Jz/2Cqx1taUqUDyS42WKIxPwSxSOIlQVXx6/bxXJSq6yF1J0
         C1Nw==
X-Gm-Message-State: ACgBeo1nIBpf8MW8u/S7YrGplHIIQTLUtAfVCXXVBcpT45y8mnIotNOf
        78ynGX8PTchUkwsBg8dxVN56pnmP9PQ=
X-Google-Smtp-Source: AA6agR57OaJUOo6jBuZQ1QNr4UNBckglNaLZLw1mIuJ6f3iDO/Emo1YGKha3xJr/SidsGnOfCwl0bw==
X-Received: by 2002:a05:6000:178f:b0:221:7dcb:7cbf with SMTP id e15-20020a056000178f00b002217dcb7cbfmr9204498wrg.58.1661867667766;
        Tue, 30 Aug 2022 06:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c225600b003a3442f1229sm12769650wmm.29.2022.08.30.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:54:27 -0700 (PDT)
Message-Id: <0691d7eaaa03e8bf8b460b9e20ec05eec09fb574.1661867664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 13:54:22 +0000
Subject: [PATCH 1/3] add -p: avoid ambiguous signed/unsigned comparison
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the interactive `add` operation, users can choose to jump to specific
hunks, and Git will present the hunk list in that case. To avoid showing
too many lines at once, only a maximum of 21 hunks are shown, skipping
the "mode change" pseudo hunk.

The comparison performed to skip the "mode change" pseudo hunk (if any)
compares a signed integer `i` to the unsigned value `mode_change` (which
can be 0 or 1 because it is a 1-bit type).

According to section 6.3.1.8 of the C99 standard (see e.g.
https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
happen is an automatic conversion of the "lesser" type to the "greater"
type, but since the types differ in signedness, it is ill-defined what
is the correct "usual arithmetic conversion".

Which means that Visual C's behavior can (and does) differ from GCC's:
When compiling Git using the latter, `add -p`'s `goto` command shows no
hunks by default because it casts a negative start offset to a pretty
large unsigned value, breaking the "goto hunk" test case in
`t3701-add-interactive.sh`.

Let's avoid that by converting the unsigned bit explicitly to a signed
integer.

Note: This is a long-standing bug in the Visual C build of Git, but it
has never been caught because t3701 is skipped when `NO_PERL` is set,
which is the case in the `vs-test` jobs of Git's CI runs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..3524555e2b0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1547,7 +1547,7 @@ soft_increment:
 			strbuf_remove(&s->answer, 0, 1);
 			strbuf_trim(&s->answer);
 			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
-			if (i < file_diff->mode_change)
+			if (i < (int)file_diff->mode_change)
 				i = file_diff->mode_change;
 			while (s->answer.len == 0) {
 				i = display_hunks(s, file_diff, i);
-- 
gitgitgadget

