Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D871F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbfJVXa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:30:27 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33743 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389688AbfJVXa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:30:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id s1so11155924wro.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=klwoiaGF2drb2WbKPmLTKN+jCLzsUucQR80Wp4Qg+7o=;
        b=NEu0bRLnzN8UYkawNVbVrfIQ+T35Tx375lhBDOqYmZcO8Nx1yNg20eCQht/6KLEI37
         UM0dXhj/xK9An5Gv3Ww7jua8VfgQwvz2yu6yrqsWzbnhcm72goS9JZgUt3jF8KmHfNQr
         OqjjMubzgHQHW9lWdSHJehflp2+fgU1J1WI5QjBA8fPqHZWViTEeyPACTSBAnmZDfC2h
         zZC57Rpyn71wAEafR72WNtL/YChkQm5GlrDP3r9aEVjskJncsvw/e7m/4zCMA95E3YY9
         +uJgnX+e30L3IwkeDCvFoDTJqBiyuWPpqYlRN9aGjoUA3TM87T/F04IkvtDBHwT3K9WR
         e4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=klwoiaGF2drb2WbKPmLTKN+jCLzsUucQR80Wp4Qg+7o=;
        b=aXH7TtEeKdeG3BnPvCBqjtztdkKmIWX37cOwNujEdpFEqcA4bQTlAg/ieJf9z7o6BJ
         NyfZmYy6uuukcAPJVI9ZQoSCBytXFusBcqFZVygy2FHlpO6tgKSNxq56RMekPqQbttDQ
         HxDPSN/a4/ECT+Erlok7hp52U1MHx3Dqou5AzW1ykyo1bhFBmOrLIgkOiVG6UhEjsTv1
         Bfx3BGbwAzi5dCDqPJznWkKIt3ckh7AsL28VXpQLhW5VSiAaNryBmDIqHI2zpHmOIG74
         qS8yw+soUfY+De3lPHgj6hi/hJj4xylB8QwQpcuaEOBZhOurmrYQQsyLbiKAIb2BlWMw
         hS2g==
X-Gm-Message-State: APjAAAX9D1YlVoVPENSpNyi4jcteYg92lWtuuzrWu+fWdDluAccfR2Qt
        Eg5ha9NTjbh7vUO6qwBn5Gsd9xA4
X-Google-Smtp-Source: APXvYqzQyayp+xlZpCvbXUSbNpD72XokY651T4hnFQMfxE73CRKewWzktuQZhZwgQJ2AXPPs5/FfnA==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr5663452wrv.54.1571787024215;
        Tue, 22 Oct 2019 16:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22sm16812917wmj.31.2019.10.22.16.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:30:23 -0700 (PDT)
Message-Id: <7e7bb43e0803aefed984b0206ab8ecbdde83190d.1571787022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.417.git.1571787022.gitgitgadget@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 23:30:20 +0000
Subject: [PATCH 1/3] cherry-pick: add test for `--skip` advice in `git commit`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
`git commit` learned to suggest to run `git cherry-pick --skip` when
trying to cherry-pick an empty patch, but that was never tested for.

Here is a test that verifies that a message is given to the user that
contains the correct invocation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3510-cherry-pick-sequence.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 793bcc7fe3..5b94fdaa67 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -123,7 +123,8 @@ test_expect_success 'revert --skip to skip commit' '
 test_expect_success 'skip "empty" commit' '
 	pristine_detach picked &&
 	test_commit dummy foo d &&
-	test_must_fail git cherry-pick anotherpick &&
+	test_must_fail git cherry-pick anotherpick 2>err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
 	git cherry-pick --skip &&
 	test_cmp_rev dummy HEAD
 '
-- 
gitgitgadget

