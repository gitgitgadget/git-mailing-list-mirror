Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2520E1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeASABG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42776 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932748AbeASAA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:00:59 -0500
Received: by mail-wm0-f65.google.com with SMTP id b141so234563wme.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PCR2gIkwChHUheuuCU0tW0teeyQsRQVAIS43VywTn64=;
        b=T4Zq7wiiA2iEsrqnHmhePXPsfTv/W3SVQgfzjQE6Ye/7vo98jq74HMqD/ioxDGl7dF
         Ff/UkyS6VXtCz/Syap1Ol/613vwbqcMKStrPRj6fTLiP70C+5gdPa+rovtAikHosr8dG
         LKg/IMrUVP21HeBk6/szU+N7fVyyTBlsb8S6y93WwQx/auE7aGXwJBLt4Ep3ybKKfmUe
         IFV5yVMw6XkzrwUbQtgO+dWwiMYpTe8k6YpSbkFsMOoYaDxyNEKTzPLRkorNZLF/HzKE
         /lqj1RPih60PJkS4abKWl90qmjvPI8yDXFvmLnlSBf6VEFwgVfs+fpMeM8+T/ybLAK/o
         KCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PCR2gIkwChHUheuuCU0tW0teeyQsRQVAIS43VywTn64=;
        b=sEWRek7RrqbVlM3ewD6IjcOdU9ItudBGBbyJfCgU+jU61dUkZXwvFTRLQxH6GVHd6a
         pJ2qECtqCIBqNM9yumlgAlNdiRQjYefbl8WiiTDyr3gyaaocv+XbRDmpV+bm14hgWE+G
         DSjW0p5a3blNikWo8QGUNmApZ7N/dHDWZPEMehTWejiKpG3oTNgxOKPbKzdSsNFFrezL
         qYQwJa3YklnLZ6/MA8LMuou6q8FZ0o5s9zQCPYTWA2bkAsBf7vI7ZYK3ow7GfszWeU5W
         3holXKveCua08AM5PXbAKOBiIv0ZlK+whu48rjQ7/NEErP6D4g1IR7FiqCl/zT0R14xR
         sNbA==
X-Gm-Message-State: AKwxytdfrMkfBHAE3NZ5FBnJ9X1Rc6hN5XzXdxXscbKi88S+Hugepmfa
        lTXuzk+wuHGZhT3v/fUuSi3vvOvh
X-Google-Smtp-Source: ACJfBov4jeUPIZnsCQ7Fiv91UUgRKSsYT4E0th7QI2hu3o6d8Xwg0VX+zu0u15bVP8xB683MgqxdeQ==
X-Received: by 10.28.185.79 with SMTP id j76mr6224444wmf.35.1516320058110;
        Thu, 18 Jan 2018 16:00:58 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/11] fetch tests: double quote a variable for interpolation
Date:   Fri, 19 Jan 2018 00:00:20 +0000
Message-Id: <20180119000027.28898-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the $cmdline variable contains multiple arguments they won't be
interpolated correctly since the body of the test is single quoted. I
don't know what part of test-lib.sh is expanding variables within
single-quoted strings, but interpolating this inline is the desired
behavior here.

This will be used in a subsequent commit to pass more than one
variable to git-fetch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index fad65bd885..542eb53a99 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -578,7 +578,7 @@ test_configured_prune () {
 			set_config_tristate fetch.prune $fetch_prune &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
-			git fetch $cmdline &&
+			git fetch '"$cmdline"' &&
 			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
-- 
2.15.1.424.g9478a66081

