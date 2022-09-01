Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E3ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiIAPm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiIAPm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:42:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8636F549
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:42:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay12so9240594wmb.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=B5OloREVnRuTJApLBPJqTGxixZTGgP2/aSJTQDVnViQ=;
        b=ihvOvHqFG566TYLqdJystxVyCC1hkWwdaoOsqtm4vN/VYzg4GhTlYNIjjBRBaONcpF
         ip1WmqrnhpDjE2oOqLQj34DTLShtetsjT12OhmGeM60VzMraXmg8FLXMI+xcC25JPact
         2L6zGoOU6n4hanM0rnozbecNfPZ4yATGaYU8eHhrFbuXC0TTWxfjVXGtxl9kHvTRd15G
         SXUy9oPbHVLn0td5wOy1kThD4NYTVZgqRGU+AtHn7a0mMjdR7Co75c/tvMCfjmIA4MVn
         FYHLUIGO/DamNLl50/nbPXfbGrn3RKlT5ANIUBQtUe+rEJk4XtQnCz2WqhJ3hFD742cG
         7Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B5OloREVnRuTJApLBPJqTGxixZTGgP2/aSJTQDVnViQ=;
        b=OwK6sDefUn6wZKmwFMIrI8X1W4pH+mLrNXQ0tIMdXF7j6ruZRopuHR4xZyjGR23L0P
         LWJK1y2CKxe5/4u5w3tjGvakJX06LXnWIYiOhfizxbbjU6z+BpfATw325eI7ZIXt0O9S
         /vMfDTsx8EqSHODNK5soFSc1cP9bz2vmCWqsFzdIUQyOow4tW86OSlJ8yzXS0JuCzwhs
         fIYLPWkzREo34NmYNzVFIAy5xSC9e9/rwL9HEYmd3y2A9ITyxRMtfeIQ0404mOvp+wUN
         dtrTuYqfmZ+UuVOXAeVpEQd+9zv5n9U05pvfLWfAjv4ELMnSrDL0jtYOJxIr38O017I7
         GT0Q==
X-Gm-Message-State: ACgBeo2WpBoXxEtGr6hJJoQ4Tykk+hG0mIEjpyJhGmF7VA8nSu4qfNZS
        UPx9s0igzegSc2CTzo0T1wA8pDwKeY8=
X-Google-Smtp-Source: AA6agR7zqghXxmmgsy7bLPEkVc841Pp8ujKLmy7uD2NRn5FvQ9zom4rZeo7aYPneKSwDPHoAz9y7Uw==
X-Received: by 2002:a1c:f016:0:b0:3a8:3d3b:6b8a with SMTP id a22-20020a1cf016000000b003a83d3b6b8amr5661588wmb.168.1662046943155;
        Thu, 01 Sep 2022 08:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d464f000000b0022526db2363sm14813238wrs.30.2022.09.01.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:42:22 -0700 (PDT)
Message-Id: <25187c3a3c2bb440ab0af34011db41361d4e2496.1662046939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 15:42:17 +0000
Subject: [PATCH v5 1/3] add -p: detect more mismatches between plain vs
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

