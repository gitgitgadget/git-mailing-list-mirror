Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2553E20248
	for <e@80x24.org>; Sun, 31 Mar 2019 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfCaNr2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 09:47:28 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54769 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 09:47:27 -0400
Received: by mail-wm1-f52.google.com with SMTP id c1so6231528wml.4
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+z7yJH0rz8re/QWD72sBMaBlK2OUkGVtrqoEeqVwVo=;
        b=Ix3nwWJb4NDp25QjZAaCOY+be40Hy9rjBDp+HD+Fgs2nWeDpn9kUH71ytIcNdmtpft
         Qp8wQ5b9H/TvrDB01nCOVau3dhOj/j0LvofAPyIwbnAfbtsAB2iQCInSjn0zZaFsXtHa
         wv525QV/09yzG1z0Lr8H8cBcLOdlBNWX7eNJUyqMnSTEiZC+8wdlpoAjuq/9kIifAxup
         O6e2D3lTeY+mlkwxjGuFnatFZ3o2d4qNuj0yZo0KFZ56Q6YiqKnTaPRSOLG9qwMJFLPr
         zBUkv5UcFagczWn0IPhN6HqHxag88mcJhgqAts/slGTLoVVmTYqdSbApiHvhgJK3FeO4
         cljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+z7yJH0rz8re/QWD72sBMaBlK2OUkGVtrqoEeqVwVo=;
        b=Cd27VY/v6/7G7knZPAKRLGcIqo0a2z8Dv9bctvZDJJ8Av8+Sq7M4wxIuX+j+71ED7r
         eL+0WC912WPgx231zEC8FJaMOXalcgpcCX6v1qGdLCoLFm2B2db8lJ/a05mBG6JNa7EE
         qv0GdXyFXu4aQGHJBEhF5FzpI6gecmWpsw6Y9Zp/5JApG2vbxwW54/k2tnBTj8F5yHfE
         Vcy5YcQSFkTCkcgxN/P3yBunB6u1u+N23EpCXzz9jEr6CTGL0BYYDMvGzDfVCDCmR1Oc
         FfaE0v6NqoZ7sl+ZhOzp0MIlUe45njs6fOrtVG8fzRIKyyH//UB3T0HdZ9AvOI57WI96
         2hZQ==
X-Gm-Message-State: APjAAAVrw5IhuyezNj3YSygKYpNuwO59oE6w/bFZ4Z4H9GGm2HfZxBfq
        JQAOp1juQO6FioTP4M7L2rjXkb54
X-Google-Smtp-Source: APXvYqzsAdtN+cez2sP1xUiHDY7tjCqrlDAF1MKx2MfyztDB9hwzAsJWAg44IB6argcroEnfMYhPrw==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr9993064wmi.117.1554040045783;
        Sun, 31 Mar 2019 06:47:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10ce:4d96:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id o10sm10290490wru.54.2019.03.31.06.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 06:47:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] t6050: redirect expected error output to a file
Date:   Sun, 31 Mar 2019 15:46:57 +0200
Message-Id: <20190331134659.28808-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.69.g2d86a08d09
In-Reply-To: <20190331134659.28808-1-chriscool@tuxfamily.org>
References: <20190331134659.28808-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise the error from `git rev-parse` is uselessly
polluting the debug output.

Redirecting to a file, instead of /dev/null, makes it
possible to check that we got the error we expected, so
let's check that too.

Reviewed-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 41b177936e..948d278482 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -40,7 +40,8 @@ commit_peeling_shows_parents ()
 	test "$_found" = "$_parent" || return 1
 	_parent_number=$(( $_parent_number + 1 ))
     done &&
-    test_must_fail git rev-parse --verify $_commit^$_parent_number
+    test_must_fail git rev-parse --verify $_commit^$_parent_number 2>err &&
+    test_i18ngrep "Needed a single revision" err
 }
 
 commit_has_parents ()
-- 
2.21.0.69.g2d86a08d09

