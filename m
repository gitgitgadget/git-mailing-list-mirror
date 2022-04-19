Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8242C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 01:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiDSBeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 21:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiDSBeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 21:34:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5321E3F8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so20469676wrg.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=88vOcTWf2iEvmsw5UCAeBMnhtdqQ6OwqpFUw+n7vCzk=;
        b=Nw2MNnJMTz46uGbVe55FJMwTrwWhVkxBElIdMRWKKYAxsEFlWqVf+hgkAkeNiPRPkf
         rUVlQZ2MQzdp48LYtn3/JEdRaUMViTWD3RajSZ3qMjtGD5lDU0DnbRk5rYA/Krimcvnd
         npAl+kk1tc8i+t2kzRVA9aLy5LMBGAHIco08imRiSJEc6phZk9iXI2ib0G+u4QoqBXU0
         0JsnaVsJfvmLmAWz2suFITMpkW2wcrZtoVZPDiW6dad+9duubCBzL4Jm0yNBW6VXRCIP
         j75lc51QOBt43wnjcIz3k0ovMd614dV+tohWqauvwkzYEmpHoy4L9tr4JnS4ArazR/nl
         vUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=88vOcTWf2iEvmsw5UCAeBMnhtdqQ6OwqpFUw+n7vCzk=;
        b=H7Ic9cwu0i4/apMyzGmPxSNboSeJFT3gAL6ouNwQzl3xNBUx7jTGmnkfTpbOk5pFES
         xA+71+rCoXsgr3VvXogJTD9zwygvm8hy6oWRAZBCOooYsGR4ryM1WjaUHev76D11Idhe
         8yh80oh6tbYN2kH8qu3Y/AUvnip1Dv/WCjWc2ebGF4xBLUPGfrADELebMhygv2sGMCRP
         y0SgRbHAuPzI7MNBv8kqeJpXoWd7jaHdkhwrh0E/al9Zq+gTM54ixPkDZ3hl+RLtiEjK
         G0qGX2N8tOvB3NUgiYCTPKNiREnuC34Mkb4i/229UByHHWnNXEh8hPHzB8olnColnyxn
         AILw==
X-Gm-Message-State: AOAM5315+xQzRZSf/ddD1cwc6ekdmbVA/iaH7yBYhKGgT55griZU39MI
        tYJRTeSiuI7m3+l1gzYfthCbyP1w8rM=
X-Google-Smtp-Source: ABdhPJx0+m57q5SKnrrAszBVchBJ6NXJb32aSh5bQ0Xe+wTGRcxuGAXLAo9uAg5BhVjj2snb/JpdVg==
X-Received: by 2002:adf:a35c:0:b0:207:aace:b28e with SMTP id d28-20020adfa35c000000b00207aaceb28emr9550049wrb.233.1650331881467;
        Mon, 18 Apr 2022 18:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c320900b0038f0894d80csm14034125wmp.7.2022.04.18.18.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:31:20 -0700 (PDT)
Message-Id: <4f0f4619806b383f280e8f0d0b9000c189a3b540.1650331876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
From:   "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Apr 2022 01:31:16 +0000
Subject: [PATCH 3/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
 p3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jack McGuinness <jmcguinness2@ucmerced.edu>

Split up multiple lines on one line to multiple
Fix style of cd & echo in subshell

Signed-off-by: Jack McGuinness <jmcguinness2@ucmerced.edu>
---
 t/t4202-log.sh | 62 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index fe3976829bb..604b275d6a8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1756,13 +1756,20 @@ test_expect_success '--walk-reflogs --graph --no-graph works' '
 
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
-	( echo sixth && echo fifth ) >expect &&
-	( cd a/b && git log --format=%s .. ) >actual &&
+	(
+		echo sixth &&
+		echo fifth
+	) >expect &&
+	(
+		cd a/b &&
+		git log --format=%s ..
+	) >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'setup signed branch' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b signed main &&
 	echo foo >foo &&
 	git add foo &&
@@ -1770,7 +1777,8 @@ test_expect_success GPG 'setup signed branch' '
 '
 
 test_expect_success GPG 'setup signed branch with subkey' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b signed-subkey main &&
 	echo foo >foo &&
 	git add foo &&
@@ -1778,7 +1786,8 @@ test_expect_success GPG 'setup signed branch with subkey' '
 '
 
 test_expect_success GPGSM 'setup signed branch x509' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b signed-x509 main &&
 	echo foo >foo &&
 	git add foo &&
@@ -1790,7 +1799,8 @@ test_expect_success GPGSM 'setup signed branch x509' '
 test_expect_success GPGSSH 'setup sshkey signed branch' '
 	test_config gpg.format ssh &&
 	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b signed-ssh main &&
 	echo foo >foo &&
 	git add foo &&
@@ -1802,16 +1812,24 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys ha
 	touch file &&
 	git add file &&
 
-	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	echo expired >file &&
+	test_tick &&
+	git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
 	git tag expired-signed &&
 
-	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	echo notyetvalid >file &&
+	test_tick &&
+	git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
 	git tag notyetvalid-signed &&
 
-	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	echo timeboxedvalid >file &&
+	test_tick &&
+	git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
 	git tag timeboxedvalid-signed &&
 
-	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	echo timeboxedinvalid >file &&
+	test_tick &&
+	git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
 	git tag timeboxedinvalid-signed
 '
 
@@ -1878,7 +1896,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b plain main &&
 	echo aaa >bar &&
 	git add bar &&
@@ -1897,7 +1916,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b plain-shallow main &&
 	echo aaa >bar &&
 	git add bar &&
@@ -1917,7 +1937,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag in shallow
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with missing key' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b plain-nokey main &&
 	echo aaa >bar &&
 	git add bar &&
@@ -1936,7 +1957,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with missin
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b plain-bad main &&
 	echo aaa >bar &&
 	git add bar &&
@@ -1958,7 +1980,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with bad si
 '
 
 test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	git checkout -b plain-fail main &&
 	echo aaa >bar &&
 	git add bar &&
@@ -1977,7 +2000,8 @@ test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
 	git checkout -b plain-x509 main &&
@@ -1998,7 +2022,8 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 missing key' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
 	git checkout -b plain-x509-nokey main &&
@@ -2019,7 +2044,8 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
-	test_when_finished "git reset --hard && git checkout main" &&
+	test_when_finished "git reset --hard &&
+	git checkout main" &&
 	test_config gpg.format x509 &&
 	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
 	git checkout -b plain-x509-bad main &&
-- 
gitgitgadget
