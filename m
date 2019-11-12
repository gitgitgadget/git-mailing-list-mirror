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
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BAF1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKLANt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41809 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLANt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so11942299pfq.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFSKVgEmAKukDvWGZUss3bBJoER8Qp3Fd1savgjuB3E=;
        b=DsaYDHlK8hMm8lHaNok9KlFWg2Rb2/c2TbMKBXmdqOlqK56z8Ip2mrK09sI8zF5+7a
         k4VAS9Sq7BqR5gAfkH8KOk8S0inE1s+ZUJ+Yrip/uZ6pjVOMhS0vARc8QYgrmzvg/1g4
         VpBc0Nj/usZoaCTI93sfVov4vMc140hinuBslMcTtir2cFu2nhnfkCVt9OJAY+NkG5pQ
         Nb2sPAlGR7e9D7ZFkSi/S3+9nFCJBzSpf5hQljgrxlgTb6Kczlkn4ZVVCq7dULEGgxRs
         DFdJyZNAY3bFpwDLSIHI27g41NsHtdiPFUtiCL8LZ/OprLY+yEXiHE16S9HUs6Ta/b4B
         Ar6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFSKVgEmAKukDvWGZUss3bBJoER8Qp3Fd1savgjuB3E=;
        b=CFS0muKgIfFhQ/BXTgZlcM+5/qIqb0B0EuHi8zCM0daIgfqqac33HJjIoaX/JMwIdF
         w8hMIekZXP1qD9RYcMnxNaYE/Euk36mu2z80tJ52GGYv+JPTN8Uq46u/hGWKvZAVvCyO
         /39Tin+dW9Wb/rnIUkoznRM6rHzHcY7Dk8g9L+AhJutikKvEQl2AzYQtkK+PZ4nPojwT
         vWMT4Ow1FNixNJut2i+I8hYIqwRDgCpkSg9ns2Ryxvfu6wN3Xb5tHhcpRYE+bJ4eIhvO
         FC4OLI9t202WinjD8s9BIgEuLd3T5+Gp27UFL0pDYE3E9Ymkbe3iIDW3v7KhZ2h+1F+u
         IK7g==
X-Gm-Message-State: APjAAAUZrz+vuZwytctaTiXt/fK0zHxQP5dW5L+naFOeBXTJIRbaWsfN
        sZsMkx8QAicwi2fyhsLR2ATVLHXL
X-Google-Smtp-Source: APXvYqyK+IXwVwlkVkbLSYOsL5XbpiVyyQ3aTeSxcKw1RtOPhp8eA/Dpo6d0FRNtMyAa1uvu5gZ8gQ==
X-Received: by 2002:aa7:868c:: with SMTP id d12mr14831135pfo.189.1573517628262;
        Mon, 11 Nov 2019 16:13:48 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c6sm17273448pfj.59.2019.11.11.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:47 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 03/14] t5520: use sq for test case names
Message-ID: <1bb65a59dac978bfb698e87a8cde90f4fb9e4278.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for two test case names that use variables within.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 51d6ce8aec..a3de2e19b6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -408,7 +408,7 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success "pull --rebase warns on --verify-signatures" '
+test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
@@ -416,7 +416,7 @@ test_expect_success "pull --rebase warns on --verify-signatures" '
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
-test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
+test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
-- 
2.24.0.300.g722ba42680

