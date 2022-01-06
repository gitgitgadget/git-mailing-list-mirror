Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C7C433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiAFWfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiAFWfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D1C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:35:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 2-20020a05600c02c200b003470f96e778so1736982wmn.5
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i40JuX6lX3aJIPo8eIeALPFNnCxCCoU3xfnyOhE2HM0=;
        b=MIhCJL02X9DOkdjXFuZddXwHs/mQGKakrY2m4EMmx+AuX8BvLbZWStCwp4/eYYC9IG
         R9abuZiByb6+KHyaHKjuHHsZ6/f4IAD7UGVsFHmTdTSf/gIgKg1cmb0COXAU31aE4atg
         Hui4brtj2m6CX6xsoC70Lpko+pm+5wh9oDLmgmUqyxRGYCzRrQxTHH2DVyLxLzAAt31s
         TZMc5TKyQh+5MmIx3J3iOb9d5gvMAnqH9/dUdUYLEsyRKiBSPo1N4BFyPD1DPTFwvQXy
         4tVPC9VHBo683YbiCmKLAqUaxN/I1c7r9IB/k9Nywg6LgeMkrkPqSOKd6MBaPjV3dTHg
         Vf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i40JuX6lX3aJIPo8eIeALPFNnCxCCoU3xfnyOhE2HM0=;
        b=ofGfa0KBL4bdKWbwA0KBBM01qEwVq2P5mR8vwwSSP4wazRFh5wANlVyaEpU5eA+zam
         KrVd346eDmlpdqX9xLqLa2OxaibhHc7mCexYC19fNF1fqf6p7yLR1PzUiqTYvoufSe9C
         Pc6U4u0/Jt4eJqb1j6eWbFjbaANNhBZZ2REqbrco/jNlouC/pkjrFkmEK9MTAykZZykT
         9Nt9ITTKA2G60Q5MKyjyGpc0sC8TRaAfHclwmgiDIllm1+Zoo2U0sTAGe5/FNhv+hp++
         Flxpk80CRSjNNjubBf9gTyZdFS4VBB6A4Vm84XuAAUhhPdXK7RFaoTTfXS8MVadqlMZE
         UVeQ==
X-Gm-Message-State: AOAM530O7GTKpy+tgljEfI05/2MEfZZ3/WwaOjY8zHpQxAuOhBkXQfX0
        +mgMgcvbIlJ2GlxkXpGO9Kl1I/xIpHc=
X-Google-Smtp-Source: ABdhPJwe2ZlHZjkfsh25NkBsA5/8WT1+W7FADxreAkOalJtb7oUSOVd3qxsgVStF64Evf/ZpTNUZRg==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr6667662wmi.105.1641508500874;
        Thu, 06 Jan 2022 14:35:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az1sm212585wrb.104.2022.01.06.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:35:00 -0800 (PST)
Message-Id: <e6301e9d770bc7b6a2a3eeddcaf4e0123a0b23ab.1641508499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 22:34:55 +0000
Subject: [PATCH v3 1/4] test-lib: introduce API for verifying file mtime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

Add functions `test_set_magic_mtime` and `test_is_magic_mtime` which can
be used to (re)set the mtime of a file to a predefined ("magic")
timestamp, then perform some operations and finally check for mtime
changes of the file.

The core implementation follows the suggestion from the
mailing list [1].

[1] https://lore.kernel.org/git/xmqqczl5hpaq.fsf@gitster.g/T/#u

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/test-lib-functions.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 389153e5916..01dd8c01f59 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1806,3 +1806,31 @@ test_region () {
 test_readlink () {
 	perl -le 'print readlink($_) for @ARGV' "$@"
 }
+
+# Set a fixed "magic" mtime to the given file,
+# with an optional increment specified as second argument.
+# Use in combination with test_is_magic_mtime.
+test_set_magic_mtime () {
+	# We are using 1234567890 because it's a common timestamp used in
+	# various tests. It represents date 2009-02-13 which should be safe
+	# to use as long as the filetime clock is reasonably accurate.
+	local inc=${2:-0} &&
+	local mtime=$((1234567890 + $inc)) &&
+	test-tool chmtime =$mtime $1 &&
+	test_is_magic_mtime $1 $inc
+}
+
+# Test whether the given file has the "magic" mtime set,
+# with an optional increment specified as second argument.
+# Use in combination with test_set_magic_mtime.
+test_is_magic_mtime () {
+	local inc=${2:-0} &&
+	local mtime=$((1234567890 + $inc)) &&
+	echo $mtime >.git/test-mtime-expect &&
+	test-tool chmtime --get $1 >.git/test-mtime-actual &&
+	test_cmp .git/test-mtime-expect .git/test-mtime-actual
+	local ret=$?
+	rm .git/test-mtime-expect
+	rm .git/test-mtime-actual
+	return $ret
+}
-- 
gitgitgadget

