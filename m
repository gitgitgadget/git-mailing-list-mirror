Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C5C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 14:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiHOO4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiHOO4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 10:56:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B41A054
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:56:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v3so9393155wrp.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=YNGX5+6bxFZhs7BEJQxZevUZRqwerWm3EU+dZZKtTYY=;
        b=TiGUXVzrDy2PuhovIXhxzMKRm4KmuuYJn9kDoWzdUVa/iahW2Lmxf4Mn/zKQ+06yEn
         g1x1B71GqLgvfqp2sFzUbqb49L86AKgfeZckA4cRKZQ5KFDIW7Jl8oyRqzzh+kWH9AqG
         WVgC5uau//baW/9EmVQhI/EXifgf9F2gC3mC96g+BHGqvATp3Vv+wIJetKoIsIHFFt1K
         41z36ZmxAWiQRrhc9vYDUYy9BBWVIzKyPck3oZbpGtOeh4DS9YHbG85DhjN8VfH1WjbZ
         pdywDz1JkEe+eelUfsrn4pCDZjKNo2Oq/AFbxye5ct/QnxnV6wKv7VLvQ4KFQkiC2HDH
         ZODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=YNGX5+6bxFZhs7BEJQxZevUZRqwerWm3EU+dZZKtTYY=;
        b=E+NoVIWA4OghI2akKotp7EBm2T4ObjeLoYpNKlwBAAdQzU7YGVeDNfkGm5F+x3ZeJp
         EaOqvHzs9sKYNcN7gqDWPcV+me/RnlFhbR0v1RuaupzlTPvAphwjOptTc5cKpTVDFPA4
         S35M1zRV8xVScJmrQ7YZZM5vf5KmmdNTbUaeL0bWEx9eZgtnsG4ActyE0+qDxc4jhv4K
         oCxWIRN0plgSwc0wGQ1Pj11af8Dz5mHiQPAF1B/CQDaG0c9BogugI+fVAdF/uFXMXIIV
         2w2+4WHX0/4cicsK7nnnBsKkEJJ2OKYyXcQLRQBil/EfXdYcVLyDwPBw40bGG7JC5lii
         TKQA==
X-Gm-Message-State: ACgBeo2k3iOVhVNJAO8F8V3FeTwesY3tHB8ViYIemNWy7wg8t4ZtpWA+
        5tk3RpQg9ho4gWOv9sPvMWYFPeEQShE=
X-Google-Smtp-Source: AA6agR4TWU2/T5P0kQ4cxInZ/Qk2Aq9MjF1Qj/FEJ8t5A116CnCaH2ltZm4qITdelDF8hAD+IP0b/Q==
X-Received: by 2002:adf:f905:0:b0:224:f876:c001 with SMTP id b5-20020adff905000000b00224f876c001mr4480323wrr.201.1660575389210;
        Mon, 15 Aug 2022 07:56:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a7bcd82000000b003a5c999cd1asm12484831wmj.14.2022.08.15.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:56:28 -0700 (PDT)
Message-Id: <99755b377f04b8f152c8fa30bf71fbc8e7c4772e.1660575385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
        <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 14:56:24 +0000
Subject: [PATCH v3 3/3] doc: add documentation for the hide-refs hook
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

"git upload-pack" or "git receive-pack" can use "hide-refs"
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
