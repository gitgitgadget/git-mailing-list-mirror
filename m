Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85954C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiBPU7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:59:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBPU7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 15:59:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659220204C
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso4637632wme.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=orCEFit4EeuuN80Kc+9dhdhgf47zTUAPvmERdIRwbuXtoG5cwEdzYTm1s+lSPW4CfD
         hn2HG4Xyf71eLRCqjIbeVGWjQEVYf8352kkbmVgOVHYB4evQyDWM8Kq987bslpGMnOj0
         ANmxNFUITtmPaTxpqLCQ3fm2MM7uWBVTcLAX8UlUq6X9kcmPYGP0J79TYLRleKpMDxU+
         FRskjyrgt6OeBf6zh6QMEi1K4gYfWXhBwxgiSHoj/6FMMBTNL1ozRxN045Bakmp/wqkk
         uBIVGe41l1R6l9NtIZlInB4SgnwghlGJoV/CIiZ001jLG/1K6pV0+PSZqicvYb32OHeI
         g45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=7BFA1YUuumV0Z2KqbP0MGGP3ufzbWmtYOB+e+aiKRCpU7GvoyyFqnQthuyGnw52eFQ
         5soi2dxUGsAf36DFsWrqaJM8cRlLomPwE3GJ5fNVaHCXt6DXLh4aRDeb/JpqXn8Dsted
         AaQjsGsgvOjTBs/cp7C4DDLuDlURVbBt5Xs8E8T6RX1Fp+FBpAJUerFs4tqmRYV/jycY
         Uphdj2CH+Nwhc+3p4/Ufho61+wL2qh1sHYIN9LuNKNm08eTe6lPDWKD1SlsbXJ4q7zQk
         GsYaL5P9T0TjzJ1NPfrUMZtbzWUSPpHFm2HANbh7OmYkNVQLqiudMhZB+6Ez3QRB6Jug
         VmqQ==
X-Gm-Message-State: AOAM532KKAejaLusC6xIcMtIUxpNtXM8+Q1hp551sAA470v0BiufrSwx
        +kDtHcWW4b57//9h4jgBLIxaEb0G9oY=
X-Google-Smtp-Source: ABdhPJz+HBiC0CmxtadWp2l4W+k/bWr6Kt2HL1S1vkOYNeWwiT4x1EkyPE4m6vrHQLi7SYyRiryOhQ==
X-Received: by 2002:a05:600c:4891:b0:37b:97db:7574 with SMTP id j17-20020a05600c489100b0037b97db7574mr3240718wmp.104.1645045162152;
        Wed, 16 Feb 2022 12:59:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba14sm14325157wrb.56.2022.02.16.12.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:59:21 -0800 (PST)
Message-Id: <bf74b6cd75bd886c1b5954693beeaccdfd2e51ec.1645045157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 20:59:16 +0000
Subject: [PATCH v9 3/4] cat-file: add remove_timestamp helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

maybe_remove_timestamp() takes arguments, but it would be useful to have
a function that reads from stdin and strips the timestamp. This would
allow tests to pipe data into a function to remove timestamps, and
wouldn't have to always assign a variable. This is especially helpful
when the data is multiple lines.

Keep maybe_remove_timestamp() the same, but add a remove_timestamp
helper that reads from stdin.

The tests in the next patch will make use of this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1006-cat-file.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 145eee11df9..2d52851dadc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -105,13 +105,18 @@ strlen () {
 }
 
 maybe_remove_timestamp () {
-    if test -z "$2"; then
-        echo_without_newline "$1"
-    else
-	echo_without_newline "$(printf '%s\n' "$1" | sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//')"
-    fi
+	if test -z "$2"; then
+		echo_without_newline "$1"
+	else
+		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
+	fi
 }
 
+remove_timestamp () {
+	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
+}
+
+
 run_tests () {
     type=$1
     sha1=$2
-- 
gitgitgadget

