Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE8C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiBPAxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiBPAxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:53:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B16C7E65
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k41so290556wms.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=GiWoeH2mS7t2V3HD8F5l2FNNjArh5+dmM0wIQ0J3Tvn+VQ2l2guReJ7edRA0YV/gD5
         +e+uMc7QmNLlouZq3BEBXA3vfyxe8uSp0y6JvT7eAXbCS7BaGzw8I8YWYylZRXbjRdbX
         MsGn7b/iw2JS5mMfNuH1yUlZjJbDFiWSSLb6vHaR6v1jSnP7habFPGXDA3P3uaGdsuNC
         ah38+vhFlBNXc83f6drfYtimhNB8Nvb8Luwu8HLru/HwhNchgbUgkMqN9vyJvbuN1TJy
         zlXxyWCfkKNvcsug+zju0S/BA+C1nOF9HE1jrqLw9KD7hYwNQkJiFmyruIEa75RvjDoV
         qNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=jf/phmAKWX7ViJNI9aElspDXHmjDXAnalcunJNffGLK1ajq188TZd0H1SkBkzZ8pe2
         e8by2HIbkJqSX/bPlrLBBealyDTZq2RMHjrkUBwtMJm5EwQXVRpghs45HQ7fFm/Ty/IW
         Q6CPLe86OBlGBaGhnipd/Y4n/47e/2AvWKzLekukGDmAKepW8xLDBuNsE50ZcrVnb3f+
         fuWGC6kYH1hAKGW3DyWEkw3Tv1EQTYMf0i8C4d9I3RMvUSWWlVTE0cWs5tw4Kr5HPbEu
         KQQqrmHkZICsYc07LiyrcGHn28Br0So9gmN4VFG22aTRa0KUL4be99YrtXXCKxNEzVTG
         mh3g==
X-Gm-Message-State: AOAM532VrbuonqemaYSV8AjMMJqV8huqd0Itfn0gyzyljWwJ9EOsyx2O
        i7L792xkgo4Cvx7yy//vSG6GdZ8T7rY=
X-Google-Smtp-Source: ABdhPJx680pmVGz0+y/K6nFKIdr99ihQGSLe62iVLOoxVQPBfOi1rcRT+/ghU3SLpFpEw6xJtcGO7g==
X-Received: by 2002:a1c:7906:0:b0:37d:25c9:1c2a with SMTP id l6-20020a1c7906000000b0037d25c91c2amr5102865wme.112.1644972813744;
        Tue, 15 Feb 2022 16:53:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm19630939wma.27.2022.02.15.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:53:33 -0800 (PST)
Message-Id: <486ee84781679d587f137b9c24fb5377e4b138d8.1644972810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
        <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 00:53:29 +0000
Subject: [PATCH v7 3/4] cat-file: add remove_timestamp helper
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

