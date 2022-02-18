Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB564C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiBRSXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:23:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbiBRSXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:23:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430E48E71
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c192so5744808wma.4
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=KPjsJ1NCNUofMW2MWtihyWUQuh/G9H8MlfdGs8Xa3oR+NA/MIG8i/45f5M9H29DVK4
         IlxnWxwgkhF5n/3vvs7jHKy5EW0HdNBGquHCuZ2r8CZuArulpYyzmC5gwp/BzCjpQAI2
         +eyWFuc14p1iVaUx3NLIJGKZ1vtaMh7yZVxz4iqGdoivfAnvUU+OCGVRKeDQxcfKliOo
         UBRxIAcum6H8G8rQqL48241FkUJue1nI5CgxLfenAp523ZfpFCMN+LH+KBF9P+Y84K4d
         Ccn3qvwV1xds78uwJY5oIicKNpNLLDzFJEafRbvWj+GJs2ubVL5zEQVXqun0q7BOSkGv
         DoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UC9fF+KP+NxF+UpJJq9w730NXczpWlLCADgKQQkkAMM=;
        b=cHBsbK/055bvaHRx9ha/vN8PLFVWd2Mu8KcAq3uXk3W4smWKJzXvRk+ORKdt8EacH5
         6+ugqWhY5vT5pLQk8/sVpH6L5zCsWstrwNHIXN2TiBNdp5yDENZYQOYvkPKLXruppYbs
         30U80M2DctED3vaks/2hoBEXVHXbzp4xiww/+5zKrVMghZAtkTOumQbcsJ5YEu1mVvjD
         +ldzHP6A7sjYmWpwbBNUE4RJ5F5yZzA+ar46A1/xcISR6sGWp/B48AOfnSkR2OKyjU5i
         xr5ltWbEKgQa3w08bhEIXCj5e+GVJIsmaoWvxWrWH8SvVu/N19Is7IESx6mLDoi3sONd
         h1pw==
X-Gm-Message-State: AOAM5313cpe11Hg9he2ISB49XGnmKf0OOaXNUH/sNAHpYpiLnBprxCea
        mApO0jjLNv89YdCXXPpGSCZeqSH3Y7E=
X-Google-Smtp-Source: ABdhPJzxUYNpcR8o3UaK6Z6VtYsDflS7PhKY/at2Bw5JqwzB8xKu6/ihYEBpuAP1jHKfJDMzNoIuEQ==
X-Received: by 2002:a05:600c:14c6:b0:37c:440:c0e with SMTP id i6-20020a05600c14c600b0037c04400c0emr11923354wmh.87.1645208598571;
        Fri, 18 Feb 2022 10:23:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm227706wmq.24.2022.02.18.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:23:18 -0800 (PST)
Message-Id: <bf74b6cd75bd886c1b5954693beeaccdfd2e51ec.1645208594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:23:13 +0000
Subject: [PATCH v10 3/4] cat-file: add remove_timestamp helper
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

