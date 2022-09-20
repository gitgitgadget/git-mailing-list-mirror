Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63300ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiITI0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiITIZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:25:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401265564
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so2984666wrx.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=icPj4+n9T0s0E0oT3Ca0H/SF1i7z0HjmcAHYFYrnHyY=;
        b=S82NTOfqZWdCCY3Z3EYuVh3v5pJD9QBl8NTM1vWpqn3siUoChfTg+Uy4pD7w3d0PLZ
         2/YOTHuyrjfyixzhuSBizbmo1ixuwqWQ+u73ngqlNhXuNi69QrUJ0ZG77x16qdXUpgFc
         DDlIQ2UvGD1e4MKiPWd4brkXfgKfEVSgsRxq/nqqItN6DRYrfiG+n8djzun/6rNxdwqC
         D+Y8rBiJSUdmTn40mDHa5k7enmWq7jEKnYKrGIRBA2Zy/KdYl9sFiaGGoOYNtpfabALw
         aMhbwdryoGb5VrhHKaC8OnJwrDLU5Zi7QWnXpB4Y3ON314LK4CPHtcy/MolDr+iVpj+i
         ffgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=icPj4+n9T0s0E0oT3Ca0H/SF1i7z0HjmcAHYFYrnHyY=;
        b=nb+oe0Xrv8sOxmuSPDuLLbUN0x7pvYPFe3OsmRj+X9rIb3k6J7ooCI0pUDyNgIY24i
         Wv6pea+9gr3cEQWLH+4XGYjLKoMqngPdxj+nHoTfrkR+iqe5SWf2VqeO6283rAvRDmtD
         12SibUr8VIL0bYCfTJp/gBrlu13KLfTQVpFBtx8IFbTguiNeEQxhZLtkytdRTiX7VdNv
         ZFtC4g/HuxLd1V9LpJBP8krX9m2YYhrPCU+TKT2LCsbWalva/VspJ+Z8ihs489LuL+9s
         b9UfM7LNvjCvoyBLHVBFwu6nWWsGhNGk/GXhqL0A9cy+LvomQlzX1Qsyghn8ZTYIBS1r
         pOFg==
X-Gm-Message-State: ACrzQf1U3fHAqYdkmjgaCUOquuOb+ClWF1ZcHH441TiIbjBbXZuXn3Hg
        29dGvAu/n7weamRyPgFpC64aTVOfd20=
X-Google-Smtp-Source: AMsMyM7ivXSo69/XMWtlmZ5tyKQCWeXZTUzOyTPvxOvemsNwaURBbHsMj109NsqaRrLd9dys0VoSsQ==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr13112351wry.303.1663662173162;
        Tue, 20 Sep 2022 01:22:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003a62400724bsm1690738wms.0.2022.09.20.01.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:22:52 -0700 (PDT)
Message-Id: <0cb019b28da7d9089ca122f8bf4a1a1312090712.1663662167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
References: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 08:22:47 +0000
Subject: [PATCH v6 5/5] doc: add documentation for the hide-refs hook
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

If uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
is set to true, the private commits of hiding refs can be fetched by
the client. The new "hide-refs" hook is used to hide our refs and we
wish to hide the private commits either.

"git-upload-pack" or "git-receive-pack" can use "hide-refs" hook to
filter the references during the reference discovery phase. If a ref
is hidden by the "hide-refs" hook, its private data cannot be fetched
by the client even if uploadpack.allowTipSHA1InWant or
uploadpack.allowReachableSHA1InWant is set to true.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Documentation/githooks.txt | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..b26e50a4ea7 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -249,6 +249,55 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+[[hide-refs]]
+hide-refs
+~~~~~~~~~
+
+This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
+during the reference discovery phase, each reference will be filtered
+by this hook. The hook executes once with no arguments for each
+'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
+a version number and server process name ('uploadpack' or 'receive') will
+send to it in pkt-line format, followed by a flush-pkt. The hook should
+respond with its version number.
+
+During the reference discovery phase, each reference will be filtered by
+this hook. In the following example, the letter 'G' stands for
+'git-receive-pack' or 'git-upload-pack', and the letter 'H' stands for
+this hook. The hook decides if the reference will be hidden or not, it
+sends the result back in pkt-line format protocol, and a response 'hide'
+means the references will be hidden to the client.
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
+	# Receive the result from the hook.
+	# Case 1: this reference is hidden
+	H: PKT-LINE(hide)
+	H: flush-pkt
+
+	# Case 2: this reference can be advertised
+	H: flush-pkt
+
+To enable the `hide-refs` hook, we should config hiderefs with a `hook:`
+option, e.g. if we want to pass all the refs to the new hook except for
+the tags:
+
+	git config --add transfer.hiderefs hook:
+	git config --add transfer.hiderefs hook:!refs/tags/
+
+the `hide-refs` will be called during the reference discovery phase and
+check each matched reference, a 'hide' response means the reference will
+be hidden for its private data even if `allowTipSHA1InWant` or
+`allowReachableSHA1InWant` is set to true.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
-- 
gitgitgadget
