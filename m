Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDCFC19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiHCQRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiHCQRq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:17:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B221821
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:17:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a18-20020a05600c349200b003a30de68697so2048683wmq.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NtjDqc8941W0scOcxm5MoG7+qvzGvfgfZXZpDJZvUzE=;
        b=n6mx7AhckwJKcPUMpJN8mLMngjQSB3cD892McVPLw9islDzZab/MyuwcVeNxCrWz7o
         SWCshq9lGjqUliTpYtAp6auEa3w3H0UJ10P9G3s/G9cdvXQjDJ+sNVTPT2EC9i4EVjyh
         qgYW/3Pu3Ncqkr1qYuz4mE75/llXvvVHO1yjKKgLM6ez+dbh1iKo5G5BrGcFUg2cbv/R
         8ivhIWtOsjQq/d4cOgfqt30Zs2mhJNaQPbbaWTStGQBGH1GRR/vMjDXvlgdTxTKebPEk
         Gn7HxcYNnN7KbPTTmQ9BcasAhP1SqQeNIpHSSgN1tRX68lPv6pm6zLJum0XXTsqknj8B
         hFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NtjDqc8941W0scOcxm5MoG7+qvzGvfgfZXZpDJZvUzE=;
        b=CGQzvCqE4XzHWzFeQrdGikJ/iyCF1R3SF7Pw07EJ+lCzZr4c1s/xMs4ZFzVVPKc/on
         JvGAUOD8pWtwJ8JZlKbAU2m2OCOkK78an6+dFnLS7DB8VGkEi23Gdc2a86ntwbjCTR4/
         V66/dnvVzfRbq9MFvLIkqTnOoXsYDto/RfwtBi5P+jjwgTyAJhs1efxWWgnavD2ZL22L
         LSAnGE/DUcPQmkziHxcDtkpz1CQEig813N5MNefukz7+3uN9S2W/UzCBRi4fezHtj9GA
         up6O9gHpQQHEFO9XoRvheIBKzIQanjg7aTjSPVSdT09ER2hIe6EjDlg7kxq6QI828KBZ
         nbng==
X-Gm-Message-State: ACgBeo2HRNPY/eNFU83bFlZ/fK6hmMhpBVknsMWWG7haBETPAYJqYPkZ
        yFM0ezZzJ1gg+mYU+uuyDLtd38Z0tsc=
X-Google-Smtp-Source: AA6agR5giwBZxhklm3E37ME5ihvv4WBx2gC+7Ys79RnywBBeTf5e2x381xaiGS/O1ChK9tkK+1URuQ==
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id k3-20020a05600c1c8300b003a31f7025a5mr3433540wms.54.1659543462325;
        Wed, 03 Aug 2022 09:17:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk9-20020a0560001d8900b0021d76a1b0e3sm18692210wrb.6.2022.08.03.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:17:41 -0700 (PDT)
Message-Id: <d98357d5f64b4d8ce4c688f7de1089952542d58b.1659543457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Aug 2022 16:17:37 +0000
Subject: [PATCH 3/3] doc: add documentation for the refs-advertise hook
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

"git upload-pack" or "git recevie-pack" can use "refs-advertise"
hook to filter the references and commits during reference discovery
phase and commit fetching phase.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Documentation/githooks.txt | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..616d00a4477 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -249,6 +249,76 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+[[refs-advertise]]
+refs-advertise
+~~~~~~~~~~~~
+
+This hook is invoked by 'git-receive-pack' and 'git-upload-pack' during the
+reference discovery phase and the commit fetching phase, each reference and
+commit to fetch will be filtered by this hook. The hook executes once with
+no arguments for each 'git-upload-pack' and 'git-receive-pack' process and
+if the exit status is non-zero, `git push` and `git fetch` will abort.
+
+Once the hook is invoked, a version number and server process name
+('git-upload-pack' or 'git-receive-pack' or 'ls-refs') should send to it in
+packet-line format, followed by a flush-pkt. The hook should response with
+its version number and process name list it support. If the list does not
+contains the server process name, the server will close the connection with
+the hook and keep going without the hook child process.
+
+During reference discovery phase, each reference will be filtered by this hook,
+In the following example, the letter 'G' stands for 'git-receive-pack' or
+'git-upload-pack' and the letter 'H' stands for this hook. The hook decides if
+the reference will be advertised or not, it sends result back with pkt-line format
+protocol, a response in "ok ref <ref>" format followed by a flush-pkt means
+the references "<ref>" can be advertised, and "ng ref <ref>" means not.
+
+    # Version negotiation
+    G: PKT-LINE(version=1\0git-upload-pack)
+    G: flush-pkt
+    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
+    H: flush-pkt
+
+    # Send reference filter request to hook
+    G: PKT-LINE(ref <ref> <oid>)
+    G: flush-pkt
+
+    # Receive result from the hook.
+    # Case 1: this reference is valid
+    H: PKT-LINE(ok ref <ref>)
+    H: flush-pkt
+    # Case 2: this reference is filtered out
+    H: PKT-LINE(ng ref <ref>)
+    H: flush-pkt
+
+During commit fetch phase of 'git-upload-pack' process, git client may send `want <oid>`
+requests and 'git-upload-pack' will send object filter requests to the hook to check if
+the object "<oid>" will be sent to the client or not. In the following example, the letter
+'G' stands for 'git-upload-pack' and the letter 'H' stands for this hook.
+
+The hook will decides if a commit will be sent to the client or not, it sends result with
+pkt-line format protocol to `git-upload-pack`, a response in "ok obj <oid>" format
+followed by a flush-pkt means the object "<oid>" can be sent to client, and "ng obj <oid>"
+means not.
+
+    # Version negotiation
+    G: PKT-LINE(version=1\0ls-refs)
+    G: flush-pkt
+    H: PKT-LINE(version=1\0git-upload-pack git-receive-pack ls-refs)
+    H: flush-pkt
+
+    # Send commit filter request to hook
+    G: PKT-LINE(obj <oid>)
+    G: flush-pkt
+
+    # Receive result from the hook.
+    # Case 1: this object is valid
+    H: PKT-LINE(ok obj <oid>)
+    H: flush-pkt
+    # Case 2: this object is filtered out
+    H: PKT-LINE(ng obj <oid>)
+    H: flush-pkt
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
-- 
gitgitgadget
