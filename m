Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67026C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiCAKZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiCAKZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:25:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82575E53
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:24:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so7236729wma.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=Y8uIFiaLmQSFZnLFqP/Iu7ayQaHg3tegF1DHJ4CmHXW+36x+w+KU0f+uSFCecTk8zW
         hhNWLsk9meW26TIZaA/13PCtPZKRmMtP1o88LDbIFW3EMqRM8Lwd/tlchBrPwWuAzxrl
         J5cObSccvkHJaQfSlY+LgyRngSGO1tfHp1L87/w5XrRxgzB6CulO9r4SL7AoVRY92ZGy
         uMfPDGmRIagectVDFOISLE3LaRyxSfuIpj1+KD9qDSeAwTDHVkiDJt6uTi1vS4UwVyNR
         2V4hcEwECs9pn0Lh4/Oi5+wJz0qFH6LHWu/m2PrYznHPRgWFg2GWjCD88EGAYYuu+scF
         dEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=M2nlbvuOBxq82H7NNjVmfWAM4EDqyR16vJo/RU2vfwtXj/oNibXIyKLl04InVB1rSk
         4d6dP6j144aIlqiRCKoWZE3fwW+dQxH/kKDebx+txM2bI2Mfggq2kY3KVcp4SF7wpL0Y
         lw/8pDZs/dqJrUTSYAiHJWZmKr/NT1CvZhB3ltAAyAVNGB30Upe61DGvEBdoXIlQjXA4
         /F2BhFach9tUPkb3Z6RMq3gU9s4BKPhnu9kfrp/6p9AoNOCFNNPhKsYcNT6QA55saJPG
         76DbLza+B2Ewgv+Ht/h3WYVBB6CXS5SXZGali1bgN64wBMMYPk5tEXemM3G/+lEJ6jOD
         zNRQ==
X-Gm-Message-State: AOAM530Qym+b4MZtr7xJrocZdhMCHsPm2tRFHwFQCE6t4t0V8vofDlP0
        MfRgkFjbRcjICiz4bVMrDbIPhaAJ6CY=
X-Google-Smtp-Source: ABdhPJzBFE2BgeVLK2ZLEwVPfMZOHGrvUNb2I5IR/etGQ7R/nFwA2sfVgQ9sbNrF2nxGv6WfDCkYww==
X-Received: by 2002:a05:600c:190d:b0:381:6ea1:8cc with SMTP id j13-20020a05600c190d00b003816ea108ccmr5838630wmq.118.1646130295004;
        Tue, 01 Mar 2022 02:24:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm2764747wmj.18.2022.03.01.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:24:54 -0800 (PST)
Message-Id: <c8b240af749225c1084c722aa150d212e38f2a89.1646130289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 10:24:46 +0000
Subject: [PATCH v2 6/9] test(junit): avoid line feeds in XML attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the test case's output, we do want newline characters, but in the XML
attributes we do not want them.

However, the `xml_attr_encode` function always adds a Line Feed at the
end (which are then encoded as `&#x0a;`, even for XML attributes.

This seems not to faze Azure Pipelines' XML parser, but it still is
incorrect, so let's fix it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-junit.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 9d55d74d764..c959183c7e2 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -50,7 +50,7 @@ finalize_test_case_output () {
 		;;
 	failure)
 		junit_insert="<failure message=\"not ok $test_count -"
-		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode --no-lf "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
 			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
 			   then
@@ -74,12 +74,12 @@ finalize_test_case_output () {
 		set "$* (known breakage)"
 		;;
 	skip)
-		message="$(xml_attr_encode "$skipped_reason")"
+		message="$(xml_attr_encode --no-lf "$skipped_reason")"
 		set "$1" "      <skipped message=\"$message\" />"
 		;;
 	esac
 
-	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
+	junit_attrs="name=\"$(xml_attr_encode --no-lf "$this_test.$test_count $1")\""
 	shift
 	junit_attrs="$junit_attrs classname=\"$this_test\""
 	junit_attrs="$junit_attrs time=\"$(test-tool \
@@ -122,5 +122,11 @@ write_junit_xml () {
 }
 
 xml_attr_encode () {
-	printf '%s\n' "$@" | test-tool xml-encode
+	if test "x$1" = "x--no-lf"
+	then
+		shift
+		printf '%s' "$*" | test-tool xml-encode
+	else
+		printf '%s\n' "$@" | test-tool xml-encode
+	fi
 }
-- 
gitgitgadget

