Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3783AC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiBPPCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:02:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiBPPCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:02:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E192982F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f3so3771227wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=jdVeM4uARJGHRlcHCbJrGDRcY8fb0jnM9Ju/6nUG0tTvrpFoiodCwLVeA2oupwCH9q
         HDVy54o/xa8wK+IClcNjcguN66035y9c3QJf/mNegDJFjQsWSa9PHJM7tTTPFHZF3kn9
         fbnsxM+GIaKndvOla3bLtIB2vMvph8Rxvt/V68tgXbfoka5BzteSvDEwYp4B4xYkF47F
         p+0fnYC6RDTQ2HzYnaZbXS3CUn15Ra+hZ8I2zpqTwa2PDfbv3I+fP+0j7jTEAvFl7K2Q
         kUtytjadCj1C3SS6KYb023foFTYtrPdyUO/UfgwiERGsCkDBHXE6A6M8lWoD9719dTYf
         eY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=vsW2JvCn+bdPQ1ahLMV7p0xTq7nZ9ox8RX3eSTh05/WIjvv1fQtmnlqMSZ/OzpgapW
         fF9ShGz3t8MYGa7DrBDFfcZHyWLKQIRPZpbt5Qf0ZQ3bH+atZzLW+UR5Tciyn1JFJxff
         EqGlKuSDGA0sGQJB8I/vIKdZolnLI6eAX++tgcnlCd977x3S206zTYzSNQOfiYKVDZrX
         5K12Ye47IAF+ITNmfU5/v5h9/JFz31S7Flclv5C6ijQjqdZmtPCF2vMOQmX6eNHlLC1m
         Xwi7rjcRPSvgprfr8nIpAdFScELXbV1VVvnLBgWDqn8kC/hHy81+fcdVR/3wSw73UvG8
         ulHw==
X-Gm-Message-State: AOAM532hJlyrMO7lhGR4VtjpwaEHAVUw2dQEAXAZUhzxWcFHubO+HYaZ
        X5QqZ4GrtELgqqaRx9WxS3nimAuQxWM=
X-Google-Smtp-Source: ABdhPJwocTZ5+Z0GpT3DMEKiD0t6GwSCuJ9sheKOhqRY2jUZgs1/jY3J96EjDHwaG7iuivCVBOwITQ==
X-Received: by 2002:a5d:6da1:0:b0:1e3:2bf5:13c with SMTP id u1-20020a5d6da1000000b001e32bf5013cmr2774921wrs.316.1645023745071;
        Wed, 16 Feb 2022 07:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm17654756wmd.44.2022.02.16.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:02:24 -0800 (PST)
Message-Id: <486ee84781679d587f137b9c24fb5377e4b138d8.1645023740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 15:02:19 +0000
Subject: [PATCH v8 3/4] cat-file: add remove_timestamp helper
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

