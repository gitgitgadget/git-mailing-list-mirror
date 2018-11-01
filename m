Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E4A1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeKAVBn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:01:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33594 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeKAVBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:01:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so930691wmb.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1dqqhFTY4KYnmDlx2os9wirfk6K1Q2g1wlrgfvE15Y=;
        b=NhwQ/JSJmN5QduugZsAwySpws1yADOoK7x/yj254i/3ZfIaEXzLjvesJU0kENUaUhl
         EJK/3uMy5lE8RaS0Bq+P8DXQP0gGlZPB2jFMBUzDIsoCVtDef4IeC5NxLyFqrAf1aMhT
         /csRI4W5GXEjqTfKnCDXQ/b7FZwkuy8LjQV3VLa+uat9mS4f5QWjYQs1U2CdbEO8U2tI
         C78XAMstk6MmQ5UMl6TIxhCX28ZInAn4LfHlBxdC9zu5+ERoDh+ci/2dwvCC3WFf9tXw
         KRWezH0TWkqVlKkuAKkDE+4meOPDYxYW7f7oXFLRkuFONLjO18msEQ/MJB2XVBrNM1Mz
         HbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1dqqhFTY4KYnmDlx2os9wirfk6K1Q2g1wlrgfvE15Y=;
        b=hc5inCVukQwbOJA16Clb+JfynNxbqVYsPhDVuT/Q3WIzJnDoRy+k3yw6kQRcwsceSF
         r6wZ38K23pL/lnHsw4QKSrtSwJNiMtVs35iU9NB0DvSGDRrOqq/o0zvWtg8thVXSqeYD
         mepq2BaCZvhCJ6S5lNnZL2B78gteNXk2Epfi2xzR1KEJ3ZQ1AtcOYjzJwZC9jh+9Z7/4
         jxkM+cEJj6Tz+LH47WUJI4im8ZGzXgbeuuq1rCKuarqY+cy0g4a9v9dO5gbz3/Sdv2RW
         6/OuWrTs/l2qDD44Ffc4JJceTd6vkPBD9ESIsxAct4EA/ORDSXrNPEMnAhgRxhtMaRLD
         j7fg==
X-Gm-Message-State: AGRZ1gLRavmczlIUWtyd8OIH9qPD3YYfJkRnKSc4Lg6yM9IDQR7AmMIx
        0DzItLRbjnexVX6uUAVqj4c=
X-Google-Smtp-Source: AJdET5cWatMskrgud3kEUrEuuLiTqm/+1WViXi5ajhu2rJkX/ppL4aaH5ioyUDFetXQwA6Z8StLZSw==
X-Received: by 2002:a1c:9805:: with SMTP id a5-v6mr5313366wme.106.1541073543094;
        Thu, 01 Nov 2018 04:59:03 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.57])
        by smtp.gmail.com with ESMTPSA id n2-v6sm10232367wrm.36.2018.11.01.04.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 04:59:02 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH 1/3][Outreachy] t3903-stash: test without configured user.name and user.email
Date:   Thu,  1 Nov 2018 12:58:34 +0100
Message-Id: <20181101115834.19044-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <20181101115546.13516-1-slawica92@hotmail.com>
References: <20181101115546.13516-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test to assert that stash fails if user.name and user.email
are not configured.
In the final commit, test will be updated to expect success.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3903-stash.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9e06494ba0..aaff36978e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1156,4 +1156,19 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_failure 'stash works when user.name and user.email are not set' '
+	git reset &&
+	>1 &&
+	git add 1 &&
+	test_config user.useconfigonly true &&
+	test_config stash.usebuiltin true &&
+	sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME &&
+	sane_unset GIT_COMMITTER_EMAIL &&
+	test_unconfig user.email &&
+	test_unconfig user.name &&
+	git stash
+'
+
 test_done
-- 
2.19.1.windows.1

