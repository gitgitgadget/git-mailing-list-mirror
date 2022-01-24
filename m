Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954FC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344109AbiAXTBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbiAXS7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDAC0619C0
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a1c4409000000b0034e043aaac7so8640wma.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=eFy71cgRS3uc/7GsQl0qv9RgJ3d1MCMFd2ViMax0lwkRzikMIsMsiXpVDVPGyf00/z
         hYqgooPyWXjeECqf4e7qveBhCDBz75RSzEgDCcoWkgU5gAVAzqHDr0Hn59dzJqbAKxKp
         iM1axcOGkMM5uFydkmtDqYzdFqKiJFYkrfXnMEJ0PLJCk7sOZarl4N1lI3Pya1IFIRC1
         zNbDDFZp7nWPAtpp9y1RndyzEFjdc2G0gN+O1G4nuGjsViYWXLoN3xRgfOxj0BnpUN3M
         f2gpjv6Yy0HpgGgQT+kO0CpZjrOfKqPU5tX8f3TgWl9sYbVKIZfUaycJYsi8p4Xvxgmc
         U6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=f5glT4QyX4FBpHZqXUTl9bEyceWNSbfDoFqp3iMFrxbsmWyhZ19uqOZh0f9dM39L66
         cnMFrNUPPrSn+aQtUrPvLGJiGvYW8QfpbwlGE3e+v0O15iarSzoJQknUYRA/HS6a/Yfy
         4ZnVAM/iFD+ZJxycVyf/0fdnYucR5idEnBT+ZrPPly0odtzoDuZeSsdQv843aDJNyK8I
         nuujaKzEalEe7SOqMgZE4y15hO9jq6KBJk3EK1yjCcmUXRBt/c2STi1Ganv2KpBEzL5p
         Z2vRBBRgdsmauFXyamhjgkJKsL9lcqzjGKMBDe5DN0qsquFOz37urnuvUgQhF+70+jeV
         KA+A==
X-Gm-Message-State: AOAM531lsdQh7IV4r8PbrM0txYRZ9HIp5RaX0FezH4MHYWPmOYRoja8W
        aT8COGCuYPszFyrQGZ0j6jTh8vaJbwY=
X-Google-Smtp-Source: ABdhPJzFYFVS54Le9iaDiyc/7zfZwVtlowmETklsQsHM1vePmdPqOaZmFhWH8PtNxzuE9jGmmH+MSQ==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr2969555wmb.38.1643050586534;
        Mon, 24 Jan 2022 10:56:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j19sm175719wmq.17.2022.01.24.10.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:25 -0800 (PST)
Message-Id: <41230100091e3c53fa87516c9db697ad385d5873.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:11 +0000
Subject: [PATCH 6/9] test(junit): avoid line feeds in XML attributes
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

