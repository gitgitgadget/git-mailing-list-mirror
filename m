Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102EBC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiHHTIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbiHHTH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:07:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3033C38BA
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:07:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c22so5252629wmr.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=WLLzEk0tEpM086uwcSHnfqVAlaswC/LvmnlQi0T/sIXKCEJZve177IShCa70ZTMqLw
         Ruo2B3sOAEAE8i+9x4erAeIV8ioCu62dSE6cui3w/NZV+19J2fDTaILWoRAId9BUmLJ7
         UIxU2SbVqoHnpAKDyLaYz639+3ZfAjWxx0Od9YTO3y0ruAUa8WrmD3XJk2B1B1L4CL5w
         RXzq8FaXSV3JPG2tx7J2LEImdT8aO3YBfAjYhPbQc5KKqnK2Pk3bI0WFLEujDZyunNLY
         bR9v/NEo6a2MfQvZJ8TaguKsPz3yVbbzYZXwT0yuoWmj+nd/3QsuwFA7dD/hA3P75sPL
         5fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=et1PaJaUzIniCGaPEofTXnfy1LRHsTbdzRiSgtGzlE/Fy5TEH3+KxBYQJngrQZueLe
         P/xy0aFCqR1QPbLOJlflXf8d1JfOcOaEQAf7Gdm6mfKU3d32l4dkdl9RSmiDYkoDVj1H
         gSWgQ69ozHR4+8QoZ36A8MZH+fC4zPWps+f50VwNaWhH2yAGdrMQI/NPiHpYEA75sO3E
         8gYNWLs7J+dGVelAShbq7KYSRReITbTadz92FO4LpuEqUg6FCWtxtgYHPcBds1vY3+zQ
         OzSIVMuvRn2Z8CMZFIFsvDS4id3G2NYAzfIU6InW/WRwt4P1f1tg5ahMwCtrdDhWIeGx
         YrIw==
X-Gm-Message-State: ACgBeo2TsFqxYouv3EtGn4DTtf8tZsic+0IMfB5n1rgbdbch2JFZwChV
        PhKaCyufAOZo07XJQFDUpZSQZQnhdDg=
X-Google-Smtp-Source: AA6agR4NFI0cuDVESxlL2yTJ6/uQW9iYiv+z7kIkPwRDzL4b++BiOq2ScsKvPCiuhth7zyBYZ7lBZw==
X-Received: by 2002:a05:600c:4fcf:b0:3a3:40f6:4c4d with SMTP id o15-20020a05600c4fcf00b003a340f64c4dmr17728158wmq.60.1659985676345;
        Mon, 08 Aug 2022 12:07:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b003a2e7c13a3asm14947316wmb.42.2022.08.08.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:07:55 -0700 (PDT)
Message-Id: <55c77ba4b291fffe3031fbef67dcee9aa91a105c.1659985672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
        <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 19:07:50 +0000
Subject: [PATCH v3 2/4] oneway_diff: handle removed sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'do_oneway_diff()' to perform a 'diff_tree_oid()' on removed sparse
directories, as it does for added or modified sparse directories (see
9eb00af562 (diff-lib: handle index diffs with sparse dirs, 2021-07-14)).

At the moment, this update is unreachable code because 'unpack_trees()'
(currently the only way 'oneway_diff()' can be called, via 'diff_cache()')
will always traverse trees down to the individual removed files of a deleted
sparse directory. A subsequent patch will change this to better preserve a
sparse index in other uses of 'unpack_tree()', e.g. 'git reset --hard'.
However, making that change without this patch would result in (among other
issues) 'git status' printing only the name of a deleted sparse directory,
not its contents. To avoid introducing that bug, 'do_oneway_diff()' is
updated before modifying 'unpack_trees()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 diff-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 7eb66a417aa..2edea41a234 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -466,6 +466,11 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
+		if (S_ISSPARSEDIR(tree->ce_mode)) {
+			diff_tree_oid(&tree->oid, NULL, tree->name, &revs->diffopt);
+			return;
+		}
+
 		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
 				     tree->ce_mode, 0);
 		return;
-- 
gitgitgadget

