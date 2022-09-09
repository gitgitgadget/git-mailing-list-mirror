Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BCECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiIIPHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiIIPGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A913BC6B
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t7so3222401wrm.10
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=iutZqULIGZxPg0oNpzRUy6xgLT5AIrsk9K+6CPN49AU=;
        b=c61+qHkfWor4awthp2xKQcQ5ZXzQ0JheuJDDCdMu6Ihq0AE51ApvzMtT/VoxTPyJ3F
         uIWwnPvmAlqoODpCHxfILvoRnhLFbTujRRoxrtNK2hmN9LSTQV+kiAzfcsmZ8Vbp72Jm
         u4TI+8FJIR3j9wFK1SQcJgS8fqvKMb0Ju/JWWSR5GM0R/Ke9G1bHlgS1YYCSkCgfWuBo
         PCfYSw9e9P8uKP18CgHTUfyT655vmc0L3gcD2ldtaWRBA0qS8Ac59QVc9gtei2+6TX9+
         nWI2gjlkj1y89uL8EOPwwbhUq6lfYwR1y2sCaKNDdUkmBjv8G30au64tIJmvSU6q9lmp
         tXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iutZqULIGZxPg0oNpzRUy6xgLT5AIrsk9K+6CPN49AU=;
        b=zkADBOcidAa75zkeP8LMeCAdSA9SEW0ChBDmzdyRIhDp/7h91WAa0+3dyZnH+nzMbK
         ONK9+b1WzDnLB7kIdxIjEyJCy3yHWZaGILt+Z+HETQ3lh9OlYgjPRNktBWFcLPetscH1
         74Q9IiQZbqEhW+T+74S7b0pv6wDoXRpoWMoNZlhghjcykSYW+GSKG9KR4QUJywazKryL
         9Jk5wuUS8bdLzFBicIBJUajnRVURGL5+p4Nl4UV/Mbt0Yo8JR9s51VlLDv0Og6FdGAIo
         VA3WRmTo0NRna78eYMg5b826902GyDxAYWxWFfVUeXErx+HUPpKz7+4X8jN9Fo60azmh
         Nr2g==
X-Gm-Message-State: ACgBeo1n0ELbqd1zmWKNoFNvT/dPZZMkmZlx26xmP0DExlqGXy6t8fUz
        ewGovKGA+Q8CaVPiwvBz9JK9wSIs8Tw=
X-Google-Smtp-Source: AA6agR4lI+F4IfHxz1boGKDvYGO4zBuyAEBnkKmIF0i7mr2451iVpLIuzn1kZ5sEV8HpNF5cjwTQQg==
X-Received: by 2002:a05:6000:168c:b0:226:f4c2:d6db with SMTP id y12-20020a056000168c00b00226f4c2d6dbmr8148449wrd.659.1662735993666;
        Fri, 09 Sep 2022 08:06:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020adfc98d000000b00228d7078c4esm932602wrh.4.2022.09.09.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:33 -0700 (PDT)
Message-Id: <8a5f7762c2783fb133514f5ee2cda6c541be312b.1662735985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:25 +0000
Subject: [PATCH v5 5/5] doc: add documentation for the hide-refs hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

If uploadpack.allowTipSHA1InWant or
uploadpack.allowReachableSHA1InWant are set to true, the private
commits of hide refs can be fetched by client. The new "hide-refs"
hook are used to hide our refs and we wish to hide the private
commits either.

"git upload-pack" or "git receive-pack" can use "hide-refs" hook to
filter the references during reference discovery phase. If a ref is
hided by "hide-refs" hook, its private data cannot be fetched by
client even if uploadpack.allowTipSHA1InWant or
uploadpack.allowReachableSHA1InWant are set to true.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Documentation/githooks.txt | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..314bddedc1f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -249,6 +249,54 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+[[hide-refs]]
+hide-refs
+~~~~~~~~~
+
+This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
+during the reference discovery phase, each reference and will be filtered
+by this hook. The hook executes once with no arguments for each
+'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
+a version number and server process name ('uploadpack' or 'receive') will
+send to it in pkt-line format, followed by a flush-pkt. The hook should
+respond with its version number.
+
+During reference discovery phase, each reference will be filtered by this
+hook. In the following example, the letter 'G' stands for 'git-receive-pack'
+or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
+decides if the reference will be hidden or not, it sends result back in
+pkt-line format protocol, a response "hide" the references will hidden
+to the client.
+
+	# Version negotiation
+	G: PKT-LINE(version=1\0uploadpack)
+	G: flush-pkt
+	H: PKT-LINE(version=1)
+	H: flush-pkt
+
+	# Send reference filter request to hook
+	G: PKT-LINE(ref <refname>:<refnamefull>)
+	G: flush-pkt
+
+	# Receive result from the hook.
+	# Case 1: this reference is hidden
+	H: PKT-LINE(hide)
+	H: flush-pkt
+
+	# Case 2: this reference can be advertised
+	H: flush-pkt
+
+To enable the `hide-refs` hook, we should config hiderefs with `hook:`
+option, eg:
+
+	git config --add transfer.hiderefs hook:refs/prefix1/
+	git config --add uploadpack.hiderefs hook:!refs/prefix2/
+
+the `hide-refs` will be called during reference discovery phase and
+check each matched reference, a 'hide' response means the reference will
+be hidden for its private data even if `allowTipSHA1InWant` and
+`allowReachableSHA1InWant` are set to true.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
-- 
gitgitgadget
