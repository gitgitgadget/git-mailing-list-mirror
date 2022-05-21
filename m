Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF7FC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbiEUWTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346344AbiEUWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AA4EF7A
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e28so15307994wra.10
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=pnpgYtzE8eCl+OV5Z9Qsot3aHuK9I6XMOW/tXVdFGMfKAkllTarp/scudzRP9H0ued
         VPwdEEC6MD1MlkEpNyA0A+t/YNo+pAwNujSTbb9vwsI31hZz95aY8eJXEbR5ZCPR2LjR
         8oDwzNeebh2Bv4DCjRy8BQ39RwtHidFQOYsfWjbk3d5Mu7GmLlqAZqyv6jXDebh3pnGY
         LY+SnkNJe4odJypUtd+kRPYKpnCXb1it5zga0neekjyQyINb96uIKNKWmH6q9QavvHwI
         kik1cx6gAyt3HxR7amy4fIBINZcrm62J+wHTzL23dCbrYgomVPYdCYHqrDzYComfWQ+C
         /fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iGAE3SZGJU7eojvkhG0qydiDez1X+uPg8UYp38uGbF0=;
        b=shP1R27ZZPo3u7ZJlFyR6e3e0HIfxK3DXbZ22/rqvwk/rXzS+6R+I4c96lm4ivXMcI
         d8/Utanlij5sPIfDaH5OjNUG+9yb4j5Vh/T4ajtYOTsBo6G24dZDUUX+Incfr4I72D8X
         lz+7r3eqq7amfVZ60PpDq2U+YYaPqkueldYYEHPIGCgTgQ0mLmSzh4pF/rMY84rWWG6w
         HxvQf2t9TV/IoSBtjd5osPB6dANhPl61TCexHKaFHZWCLhKo2NHaG+gISLxRE0Nho/rP
         phLKb6y3lrkCj3r64gEJmOmGfs8mmx4TRVxS348upObolu1j+R8BO7bIObdmgehGYGjb
         PVxw==
X-Gm-Message-State: AOAM533zafciX/cGwFmI30QrowMSCfXPQHUYELBHHL097frxPhJGzlQD
        kMMaxY5qbYCwogmheBAwAzxwFjJFfGk=
X-Google-Smtp-Source: ABdhPJxTDJ4ii3jI9F4cZ4CuUf6SrbDt2lWOtgtamp6IuAzYvc29b/mKFDukgB48zi2tcpTXt9eQVA==
X-Received: by 2002:a05:6000:1841:b0:20c:788b:9306 with SMTP id c1-20020a056000184100b0020c788b9306mr13129820wri.369.1653171541147;
        Sat, 21 May 2022 15:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adf8bc9000000b0020d07958bb3sm6119835wra.3.2022.05.21.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:00 -0700 (PDT)
Message-Id: <30ccd602108fea74d64a5b81e6665fcc7efb6f0a.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:47 +0000
Subject: [PATCH v3 03/12] test(junit): avoid line feeds in XML attributes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
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

