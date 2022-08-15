Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD51C25B06
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiHOPB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiHOPBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:01:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE91EAF3
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so9377411wru.8
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=aHrEoXg3NRytpDj794bhH6mWULC744o/iGxSTgfgNPo=;
        b=DQYBY1Fw18267ec2FTcmOZXjE4VEazj5DoUQkeESkXUSEeuLRLRNf8iT8i4PFgLTRM
         LWijm7uQCdtDSViWjEhP8uy5qNVcaptPCSekhPibiuQFcJRlHOT+KZmAKvfr+V8EGXzG
         jXXgRO49MK7mCbqpULcsel3+dxFI1hU3zulwX8S9ncplHZIHGM7vTRf7L6yUtXvBAxCW
         5cMDVhKVmWoIO4oR4nP+Ny2GyNWTl/HRd/RMO1Y+lYyqxIrLrbR0tKqUksWczksfCodQ
         /421VeouGUZCb/rCB3QXgheV8A2/ktvlN8BDmSUqWnyZVQxg35382kh+RqLTMMlkG0bu
         KskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=aHrEoXg3NRytpDj794bhH6mWULC744o/iGxSTgfgNPo=;
        b=CnUjmnINRVO46RcHTCOdDt/8qM6KZXz+fzgUnE9SrlB/f9C/3viLK+AeIzfpzPesCl
         CaI77cA8S6UPh6gNnau8PsqE+Pq2Fs3VjugwQt+Q1uAWB20YsveO5SwiKP3WJcuItpYQ
         GKJn8y1DSPYC/F+GJ1JLFbyH41SSI63sFm8xJds/cd35pGEZCRIQxZ/5lEC8KYIaYgYK
         s5fMbLPuruYpTr1PR6jeNeop/J//AlYWL2IWFr4gJAbx0ag9ayXBy5q1ZqAdYjpS6oan
         OhAPsX6s/kaPkzUfy+Bha9GBDESjo1MErnKL4FeQDzYhMc1KCLjPQ6ns0Lti8cPh3612
         fA+w==
X-Gm-Message-State: ACgBeo0gYyxmc1lbg7EnZlcWl3iXI9utJQ6l2GtPek1WvFvIyZawkRRR
        bBhY5SkRg5e9p9ySem7a+0UJFpK0zGY=
X-Google-Smtp-Source: AA6agR42mrzfY7O+HNQvFnq61mQUTC3YXhBnca/REbfVialaJwDNJK3MxTD5+fEgtZ8uov9+c8YKfA==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr8694697wre.237.1660575693290;
        Mon, 15 Aug 2022 08:01:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b0021d221daccfsm7505641wrq.78.2022.08.15.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:01:32 -0700 (PDT)
Message-Id: <8c5ae78de478ec469efa331be4b489175f5fe4a7.1660575688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
References: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
        <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:01:28 +0000
Subject: [PATCH v4 3/3] doc: add documentation for the hide-refs hook
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
index a16e62bc8c8..456998bba56 100644
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
+check each matched reference, a 'hide' response means the reference will
+be hidden for its private data even if `allowTipSHA1InWant` and
+`allowReachableSHA1InWant` are set to true.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
-- 
gitgitgadget
