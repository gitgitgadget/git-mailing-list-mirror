Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C0C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiG2M2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiG2M2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:28:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE924F38
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so1609981wru.8
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dYH/PJWKrAZvl1XQlIdFcunJNpZNVCkruyhnh38JqkU=;
        b=HQWd6a9Q51nwm37RIYiiE9gBPCoSSOfHKnKSZvhV1HLe5v8RhO5dpWVD7Xt2o88imz
         96WTZFjSCufFpVn35l9vT2QSRNtuvmGIn3V2JcWuzFiDxzF77qUILE8eCKsZ8fNAQZPn
         AV62JF9IRuGZq+jZmilzq0KCPjgLf9mkeHgZejKeBtVx3Z1pzdEg0w9WdQemmaaem/Ic
         3CxsvPfkm04I6Mu7cMY4vynOlvQF+yzl7u0yalUDLkS2yN1eZxA/dlSmE646jFrLKx8w
         WMrYfay5SjgJ+TxO9zSiIXjTQOYtLnn0miUJYXOKyjBi+UgGFXVijhcv44ZmIs/R8YBW
         6htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dYH/PJWKrAZvl1XQlIdFcunJNpZNVCkruyhnh38JqkU=;
        b=Z6950Ff7f5h+SB8fUYuSS4PHsKkHhAvCRDnhTICQbGDOUwLms1jdH2fjwqudLBFnD3
         szx3fLotK4JMggRQIxzu1SglL0lHTEoOqKfQ4bM66IXqrladhSRPfULuevOUrdRdBGcA
         dvAh4+u30N7JOSCN+3+/KbWXecf6SYvJ2sjr0EaWwphOyxWh2YWcziQH6Vc9vILolM8L
         FbVLJHR7lCXcNI8hxM2EHUmGvAi44WemVjUWzgCu5sHTo7+76FIaVGvQbIUMWWRwa3KE
         nTuEoULY/sc1vwfDBdq0H7fVeyMBFxtnwrOCxP1v+h2S0h3Tqb7kiSiUjBgfJZYlDxLv
         fT3g==
X-Gm-Message-State: ACgBeo1EY+eFWPOEhTI/sE/mGCmS7oI0uW2CZ4lKGlyjNQZ36Gc0k1Za
        /ydA0/DGr2eP+Z5HGjDXzj2ZxWzbJTs=
X-Google-Smtp-Source: AA6agR5EQ3RNeZHMwgUxDheAMGaQi9PSKFWTN33X8e+1Oo+BwC8lNMBxeNZyUBHjhnzs5d5sPEXfsQ==
X-Received: by 2002:a5d:5266:0:b0:21f:1280:85f with SMTP id l6-20020a5d5266000000b0021f1280085fmr1515425wrc.412.1659097727096;
        Fri, 29 Jul 2022 05:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003a0375c4f73sm4000640wmb.44.2022.07.29.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:28:46 -0700 (PDT)
Message-Id: <501a89aa0b2de396b0c7b82b2e24046b9c98c382.1659097724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 12:28:43 +0000
Subject: [PATCH 1/2] t5351: avoid relying on `core.fsyncMethod = batch` to be
 supported
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

On FreeBSD, this mode is not supported. But since 3a251bac0d1a (trace2:
only include "fsync" events if we git_fsync(), 2022-07-18) t5351 will
fail if this mode is unsupported.

Let's address this in the minimal fashion, by detecting that that mode
is unsupported and expecting a different count of hardware flushes in
that case.

This fixes the CI/PR builds on FreeBSD again.

Note: A better way would be to test only what is relevant in t5351.6
"unpack big object in stream (core.fsyncmethod=batch)" again instead of
blindly comparing the output against some exact text. But that would
pretty much revert the idea of above-mentioned commit, and that commit
was _just_ accepted into Git's main branch so one must assume that it
was intentional.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bulk-checkin.c                  |  2 ++
 t/t5351-unpack-large-objects.sh | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 98ec8938424..855b68ec23b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -340,6 +340,8 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	 */
 	if (!bulk_fsync_objdir ||
 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
+		if (errno == ENOSYS)
+			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
 		fsync_or_die(fd, filename);
 	}
 }
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index f785cb06173..dd7ebc40072 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -70,9 +70,15 @@ test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 	GIT_TEST_FSYNC=true \
 		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
-	check_fsync_events trace2.txt <<-\EOF &&
+	if grep "core.fsyncMethod = batch is unsupported" trace2.txt
+	then
+		flush_count=7
+	else
+		flush_count=1
+	fi &&
+	check_fsync_events trace2.txt <<-EOF &&
 	"key":"fsync/writeout-only","value":"6"
-	"key":"fsync/hardware-flush","value":"1"
+	"key":"fsync/hardware-flush","value":"$flush_count"
 	EOF
 
 	test_dir_is_empty dest.git/objects/pack &&
-- 
gitgitgadget

