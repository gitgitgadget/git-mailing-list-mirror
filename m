Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7BC41535
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJUPON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJUPNy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187D57276
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f11so4893314wrm.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YKNED0AztI6diCfFFOuJ24JT2EwI8iBZ4rE/4egy3c=;
        b=N8MIM2ZZfZw48dRea25nyY/tRdCNrMoQQMWNykgQj8P0PYVufngJD5UlvPqaqbPP8X
         It74DLCUFkqgeP62EE9rOkyzjSq6xhDoXJ7ci15Q6OH7aHrlxKA+D6OHnzFrRjx3Hty0
         Bu+VRQ3WmDTL08Eqf0IyQjddlpaDpgy8HqyTY81fKESXsYjGzLyxKWitIzb6Td45K57l
         ANKtRLjPADsxNwe0kMvL0SFadeHljcoxcfyDikOinLgs/LrOy68slz1rfFKtk/8Q0jYu
         6mPtxuVrbx27//G5TQjzPBeO1kMTZvyaqtONCyLgmvbMs81sxMYo1Gqri4qowbyc32tI
         2N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YKNED0AztI6diCfFFOuJ24JT2EwI8iBZ4rE/4egy3c=;
        b=RCuOBSYARmfBeshYef/Vp49Xi6M//e46J916tFawmV1xm1K7jq4MmW4RkdpE8xJovE
         r6cPuvi+UWMdk7TTdyvZotR6whZLYEzgvQISpzzZhKSNCbc2/mMDzhmGdkS+5GHKlKQi
         lIauxjkw7bdzqeDSHfYHIdg9sldablIq6W8TJMj0b+Lho1pGd1fcxfxTcynqvaNs6CKB
         3Xcr4igqhS4z9KRzlexAOUAgaNgjEoLx00uKF+jhDdqHGi8cRIwtY/6SYdof8noT+XES
         POWyUF9/QHR1QoQoMm/wgWn3HPtfAcn0IHaPbtUiXHipp4bGqRPD/3lXr8/35wDC5fy1
         AD8A==
X-Gm-Message-State: ACrzQf0rQNsQt+SA6/+/Ut5POonf/L6FStXSSxZXvtYE5MTtogazbqMr
        83AP6zlkdLqYEYP6y5dZCmva/aXpiYg=
X-Google-Smtp-Source: AMsMyM6ZOiPbvkTvfTlenwkLoPJPMgEpp6fIyDcHVVVn9rvJuzmvX32HIUze3OK6yKdLpoU0Csn9Tw==
X-Received: by 2002:a5d:64c4:0:b0:231:3d94:6eb2 with SMTP id f4-20020a5d64c4000000b002313d946eb2mr12294269wri.580.1666365232362;
        Fri, 21 Oct 2022 08:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b003b505d26776sm3694737wmb.5.2022.10.21.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:51 -0700 (PDT)
Message-Id: <3e2ea2a8b761fc525c7b9a32d1db3f0e00d7833c.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:37 +0000
Subject: [PATCH 7/9] subtree: process 'git-subtree-split' trailer in separate
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Both functions 'find_latest_squash' (called by 'git subtree merge
--squash' and 'git subtree split --rejoin') and 'find_existing_splits'
(called by git 'subtree split') loop through commits that have a
'git-subtree-dir' trailer, and then process the 'git-subtree-mainline'
and 'git-subtree-split' trailers for those commits.

The processing done for the 'git-subtree-split' trailer is simple: we
check if the object exists with 'rev-parse' and set the variable
'sub' to the object name, or we die if the object does not exist.

In a future commit we will add more steps to the processing of this
trailer in order to make the code more robust.

To reduce code duplication, move the processing of the
'git-subtree-split' trailer to a dedicated function,
'process_subtree_split_trailer'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 2b3c429991b..b90ca0036f7 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -371,6 +371,15 @@ try_remove_previous () {
 	fi
 }
 
+# Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH
+process_subtree_split_trailer () {
+	assert test $# = 2
+	b="$1"
+	sq="$2"
+	sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
+	die "fatal: could not rev-parse split hash $b from commit $sq"
+}
+
 # Usage: find_latest_squash DIR
 find_latest_squash () {
 	assert test $# = 1
@@ -395,8 +404,7 @@ find_latest_squash () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
-			die "fatal: could not rev-parse split hash $b from commit $sq"
+			process_subtree_split_trailer "$b" "$sq"
 			;;
 		END)
 			if test -n "$sub"
@@ -447,8 +455,7 @@ find_existing_splits () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
-			die "fatal: could not rev-parse split hash $b from commit $sq"
+			process_subtree_split_trailer "$b" "$sq"
 			;;
 		END)
 			debug "Main is: '$main'"
-- 
gitgitgadget

