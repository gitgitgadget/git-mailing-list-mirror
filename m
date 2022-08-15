Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B30EC25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiHOAyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 20:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHOAyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 20:54:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C2DFA2
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 17:54:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j26so1003380wms.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=E6MkbcVQoIro4eDZKmc04asgsELtgleywxwtqKo7dtA=;
        b=XAoWYdU4aM+WNTht6qD/QnV7uBSrTTV6OC3v2sttLUp3O1sL6LOPTBezYF8Yt7FgxD
         9sRRzLVH3GtQBU4AmGwtHfbjNGdtmrR8D4d0fGUYNT1OcHpHFlYpxhXUgzx9usOdoIje
         AudyYdQ8uOcCAB42wX4NvwvnE3LdBQE5erINbscGBEtlGdkYhzrJ/druVy0Dl+DzMEzl
         dIweKmKFMQV9v1GMLboWzVyv+U51D2hrKeg+wlGdWe/hPKSwxSwlUJPvkjeJEGN6NSHN
         V3zXP5nAu9qNUurD7/xRG6YV2EIo61n71jaM9PlDolWLbKJD7kXYa3EBlt/w0vG2XcV4
         Df9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=E6MkbcVQoIro4eDZKmc04asgsELtgleywxwtqKo7dtA=;
        b=IN2bIVhYAaHdHjOemPrq1cJ2yh4ZDLE+v7h8qWfUYuzXXWhMgcHttuOBTqjPvAbZjg
         wHQ6xHMYXGM5jH1H1F4GcK3vjkQJDd3voSR5Kginy0+pclz/Aen1Km0yKcfSVn4wptfp
         bSh2Bmw3TWJgTPspubxBBz7qsyKvveZxi1U8J+fBc05U83R7xdNhV90dzKDcn29NDfK/
         U979Ih7c7hwWJkN3OqhQFNOMPFVliGDxSl0fZR/2giGyjtrwGA6cgM/WXeu/okpmoEX/
         OseK16bXhlDeBJVCPD7h4SrZCfL7k/fJG6dMRZ8bg/VB/i2xcsChD1fswdyawIyM8mbI
         DfAw==
X-Gm-Message-State: ACgBeo0dOk7V2YxYZZiSzejN3EOem13o7VPQGaH07Leu+jwLBpr8HGfw
        9yPzD1fBP7g+aA6umGm0kWND9TLT3G4=
X-Google-Smtp-Source: AA6agR5Ufxyu5S0nCTjm9ekrSKxFaC8M5K8FSgSYUYgnQamENnrnDMR7mBw7zFFzCbSdCHv33XsD/w==
X-Received: by 2002:a05:600c:3c81:b0:3a3:8606:3840 with SMTP id bg1-20020a05600c3c8100b003a386063840mr8696118wmb.11.1660524870235;
        Sun, 14 Aug 2022 17:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c2abc412sm8426028wmp.44.2022.08.14.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 17:54:29 -0700 (PDT)
Message-Id: <e737997eb31088a0ebe58c1db0e393a45170eabb.1660524865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
        <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 00:54:25 +0000
Subject: [PATCH v2 3/3] doc: add documentation for the hide-refs hook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

"git upload-pack" or "git recevie-pack" can use "hide-refs"
hook to filter the references during reference discovery phase.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Documentation/githooks.txt | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..df712903464 100644
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
+response with its version number.
+
+During reference discovery phase, each reference will be filtered by this
+hook. In the following example, the letter 'G' stands for 'git-receive-pack'
+or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
+decides if the reference will be hidden or not, it sends result back in
+pkt-line format protocol, a response "hide" the references will hide
+to the client and can not fetch it even in protocol V2.
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
+To enable the `hide-refs` hook, we should config hiderefs with `force:`
+option, eg:
+
+	git config --add transfer.hiderefs force:refs/prefix1/
+	git config --add uploadpack.hiderefs force:!refs/prefix2/
+
+the `hide-refs` will be called during reference discovery phase and
+check each matched reference, a 'hide' reponse means the reference will
+be hidden for its private data and even the `allowTipSHA1InWant` and
+`allowReachableSHA1InWant` is set to true.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
-- 
gitgitgadget
