Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68809ECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiHaUbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaUbY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:31:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D584DEA59
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b16so12109810wru.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=B5OloREVnRuTJApLBPJqTGxixZTGgP2/aSJTQDVnViQ=;
        b=U1lEsD6QgkOvWzbH/iPuDFjpj5invsGA3gM+aq9jpJ90FNWXctlX93rPXjbXcH+fT2
         BpsMqx2vbeGZjln9E3Od+CuTEpnT/Opf+3/30ef/mF48S8kyKuAhWUK3nVYy/Y4hYNLJ
         o87mbXofQf5t14M3nHYX7SsYv+PaTv1ifTWpNUtDCGDWIumJR4up2S6jggWy6aZGZT59
         /Pe2B6JFNWk9ymvA1msxWTor8vyKxYPeLTK9M424at6tCMBm7vCMk9w5CcQRqoBd708M
         jUPIotrbMP8Mb9tkOaCpNuqZ8mU5ci/V8Po2tRAKpuJ68lsXnpV6nNYYraJaVaHCyK1G
         Jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=B5OloREVnRuTJApLBPJqTGxixZTGgP2/aSJTQDVnViQ=;
        b=Hv3IQDiiglSMfr3kYy4BlZVropXI6aAQ/g+vekN66AP9ff1wmJQGkQhkuEphDZBtE7
         bPZBOwNPDaSNkzYmJpfZSIXb+e0Kqo7Fm1lO0mera5psDUueK6QhTlysxrQ/aFc6EmCS
         oKKGVCwE2Up+SfoQ9d+UPnb/gUSqV2UyZawx2zrSBxibnIOF+oRlm/G3/d7ilkV11c4z
         RUEwYw4ozgLGektMjxFhi7zzqxFPYnQKF3sQQ2GKlcioL+Pf5519Em6wOBjcJMNZxwG0
         t9P54bldaAPr4+zzalPkPGHUB7HhS64g3yiDsVmHd6QYOkdoojpY+IpwPHNGWkBnNnP0
         1A2w==
X-Gm-Message-State: ACgBeo3+ghPK+Uhj5sKTbjNGbjKtNo2evcDGl85HPgFe77DDsq1JeQzf
        YkapDutq/SblaPta5BJa4ygDtEIzepI=
X-Google-Smtp-Source: AA6agR6H1/LCBay8czWkPuYbr+TZWzVSBzk/NwbThvfu0m9CotmO9CTkMgOhdiprEdtNnAoUkyvCuA==
X-Received: by 2002:a05:6000:616:b0:226:d80b:76ab with SMTP id bn22-20020a056000061600b00226d80b76abmr10007341wrb.547.1661977881353;
        Wed, 31 Aug 2022 13:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b0021d80f53324sm12883331wru.7.2022.08.31.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:31:20 -0700 (PDT)
Message-Id: <25187c3a3c2bb440ab0af34011db41361d4e2496.1661977877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
        <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 20:31:15 +0000
Subject: [PATCH v4 1/3] add -p: detect more mismatches between plain vs
 colored diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When parsing the colored version of a diff, the interactive `add`
command really relies on the colored version having the same number of
lines as the plain (uncolored) version. That is an invariant.

We already have code to verify correctly when the colored diff has less
lines than the plain diff. Modulo an off-by-one bug: If the last diff
line has no matching colored one, the code pretends to succeed, still.

To make matters worse, when we adjusted the test in 1e4ffc765db (t3701:
adjust difffilter test, 2020-01-14), we did not catch this because `add
-p` fails for a _different_ reason: it does not find any colored hunk
header that contains a parseable line range.

If we change the test case so that the line range _can_ be parsed, the
bug is exposed.

Let's address all of the above by

- fixing the off-by-one,

- adjusting the test case to allow `add -p` to parse the line range

- making the test case more stringent by verifying that the expected
  error message is shown

Also adjust a misleading code comment about the now-fixed code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 5 ++++-
 t/t3701-add-interactive.sh | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..34f3807ff32 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -592,7 +592,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			if (colored_eol)
 				colored_p = colored_eol + 1;
 			else if (p != pend)
-				/* colored shorter than non-colored? */
+				/* non-colored has more lines? */
+				goto mismatched_output;
+			else if (colored_p == colored_pend)
+				/* last line has no matching colored one? */
 				goto mismatched_output;
 			else
 				colored_p = colored_pend;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3b7df9bed5a..8a594700f7b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -761,9 +761,10 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "sed 1d" &&
+	test_config interactive.diffFilter "sed 6d" &&
 	printf y >y &&
-	force_color test_must_fail git add -p <y
+	force_color test_must_fail git add -p <y >output 2>&1 &&
+	grep "mismatched output" output
 '
 
 test_expect_success 'handle very large filtered diff' '
-- 
gitgitgadget

