Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740E11F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeHHVUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:36 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36809 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:36 -0400
Received: by mail-wr1-f45.google.com with SMTP id h9-v6so2943511wro.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fELtQ5n9y0ckTD3aTDFW8A4DF0I64fXJ6ie8+DPOFZ0=;
        b=DDi9vbV27KX9fa7oRO7Kum4XxGnf7WRLZ4zpVnIYop8pOPXoTHcTeqt7HwBjIGMSic
         kG22YBnl7kqcXmVVPTY1j+wFJVe0SYYOeD8y0pMJYnUJ43Wpp0yr7ELQ0kQxvih/bZ7e
         AjBfv3d7NUnNb/MORBi/tgwge9/5R23pisaVQerQJrPo515mdfF98jr9UzM3nmbU/1kb
         NNcF9d5ibTxnswXVRd1OGWS1uTZJXXOYFjMnczZsd0mWptA+0ZN//Ko4IsiqdPzHNbam
         9uwZBxocvLoJUpiLURneK6ylxZnyduOZfXtyxtmToXwGLGXikS8NN2DcMAGI33CZFXzF
         CopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fELtQ5n9y0ckTD3aTDFW8A4DF0I64fXJ6ie8+DPOFZ0=;
        b=Mq9xl0k2sv8dlVYAenK0FrFh6Ksk4lpoFzemrPvfyIz5V78P9z816Ja1HGgyDtTzQC
         av3DRpl00/rBJd3glPWshsaKcGGWcUNBe1R+SGN8jXNBcpMZ771JEuU1k6KB0cfF/623
         ylNNQRef/oH84FltXXILD2p5Chn1R6npEF1BaQJsF78WtivNwJtAGplmozrlo4ZANQcN
         XRbLOIYj/pLZmIO8qOUV/sLvEGGRkj2DAKhoVN7WdJ5/kcmJsOFCGciWyhpsekKWxRZu
         1EK9gBreFIhAX7cVMgU6cgdJs56tRvgcVeuv1gxz+thqVr1jlKnhILqgTJDIIK79XvPf
         39QQ==
X-Gm-Message-State: AOUpUlH3XjatIsfShkGHb3vTyuJUSId/Q7GAHc9F9AYi0cUWD7Kgczb2
        iCqBjfHDoy1auSLRBasbVTtLDbiu
X-Google-Smtp-Source: AA+uWPxOUDImJy02k7eYu6EXI7K6s0iJqyTTb92XQlWbQTIBVt/t3V9Q+2e3VoS+dbL2HoSHqEvbBw==
X-Received: by 2002:a5d:55c8:: with SMTP id i8-v6mr2648636wrw.38.1533754774976;
        Wed, 08 Aug 2018 11:59:34 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:34 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 20/26] stash: add tests for `git stash push -q`
Date:   Wed,  8 Aug 2018 21:58:59 +0300
Message-Id: <5ec3429340f43caad79e4213a7994738cb5d33c7.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces more tests for the quiet option of
`git stash push`.
---
 t/t3903-stash.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 8d002a7f2..b78db74ae 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,6 +1064,27 @@ test_expect_success 'push: <pathspec> not in the repository errors out' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'push: -q is quiet with changes' '
+	>foo &&
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet with no changes' '
+	git stash push -q >output 2>&1 &&
+	test_must_be_empty output
+'
+
+test_expect_success 'push: -q is quiet even if there is no initial commit' '
+	git init foo_dir &&
+	cd foo_dir &&
+	touch bar &&
+	test_must_fail git stash push -q >output 2>&1 &&
+	test_must_be_empty output &&
+	cd .. &&
+	rm -rf foo_dir
+'
+
 test_expect_success 'untracked files are left in place when -u is not given' '
 	>file &&
 	git add file &&
-- 
2.18.0.573.g56500d98f

