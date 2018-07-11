Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2631F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbeGMUe2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:34:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44724 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:34:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so23219809pfh.11
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=U3tR45RwSYu04qKB81mLpjGiQ+QM45wlTBSJvRRA9Sc=;
        b=awrj4aRu8Bs1VRd4dL7dgXFLBJj7h4d5jQ7K5ElcwCpXxcu34zhZh30secl44v28UO
         gwfEaFH9Ain3a8REf8u8VhqYOgOrJfzPxwF8Dt6fMQrkM18/tLvFZOOljThY6KUW38/V
         lYzpFCHWUJTSTFF1BF4395t4UOiadx0AQtiOIJ9To2mMat9d0crrwuequOvlBMop5GEk
         INVk1Jm0TQF0ocL2AztraETGIMAN5RpIlGPTnbBBZ+qHypXdkElu21y7+e4CJPMytE9w
         34bR0NOy5QMQoeVx/zEYm8lICDaXXTiGvPYL3GZZ8ruMAzzZwyv4yPtO0Rz4v5wzt1ud
         juig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=U3tR45RwSYu04qKB81mLpjGiQ+QM45wlTBSJvRRA9Sc=;
        b=UAEN2BKMLKFBuq/kRnYGxXdzghNE4lwsdGhyhZXtw9o+tKTVsp+g1kWO3OploGsNVN
         Hq5DAI95E5Ev5nJGPc+RA5S1fMVQSw38Mtfp5fNF+2WskrEoLU55JGmZhDwTT3KqiTn0
         ++niJr4uEhzixzZECaAihj6BU4MEUZtzDSD06EtCc2V5+DXHjuzNVPuwp8WUuWXS8gIB
         bYBukO0yHLDUBMSKpd74znDf+2faY1tsGddwnVOWPFWWgwXaWuZQtLrx3ESNewpjeYCZ
         7Db1KTEJVerPPEZyF6dILZQscYF4U7fe2VbBbRP2stAp2h0QEW+C/0OfYJ+wpOiQyO65
         HjOg==
X-Gm-Message-State: AOUpUlFbcwEKQ8AH84HSFhyiPnzp9GKBuvd3ZZpQOSeigtTX1siNXmoE
        r0cdiCAkkM09KvKIab0DUCaq+g==
X-Google-Smtp-Source: AAOMgpcheERzdniv58Zz8J1005IF8BlW73yJs6kiszpeUJ0WSVRALs8hZln36VnacjM2gQ4fRpNntA==
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr8573739pff.199.1531513098339;
        Fri, 13 Jul 2018 13:18:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 133-v6sm42938952pfu.158.2018.07.13.13.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:18:17 -0700 (PDT)
Message-Id: <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.9.git.gitgitgadget@gmail.com>
References: <pull.9.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Jul 2018 00:23:28 +0200
Subject: [PATCH 2/2] repack -ad: prune the list of shallow commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While it is true that we never add unreachable commits into pack files
intentionally (as `git repack`'s documentation states), we must not
forget that a `git fetch --prune` (or even a `git fetch` when a ref was
force-pushed in the meantime) can make a commit unreachable that was
reachable before.

Therefore it is not safe to assume that a `git repack -adlf` will keep
unreachable commits alone (under the assumption that they had not been
packed in the first place).

This is particularly important to keep in mind when looking at the
`.git/shallow` file: if any commits listed in that file become
unreachable, it is not a problem, but if they go missing, it *is* a
problem. One symptom of this problem is that a deepening fetch may now
fail with

	fatal: error in object: unshallow <commit-hash>

To avoid this problem, let's prune the shallow list in `git repack` when
the `-d` option is passed, unless `-A` is passed, too (which would force
the now-unreachable objects to be turned into loose objects instead of
being deleted).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/repack.c         | 4 ++++
 t/t5537-fetch-shallow.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159..45f321b23 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -444,6 +444,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
+
+		if (!(pack_everything & LOOSEN_UNREACHABLE) &&
+		    is_repository_shallow())
+			prune_shallow(0);
 	}
 
 	if (!no_update_server_info)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 561485d31..d32ba20f9 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,7 +186,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '.git/shallow is edited by repack' '
+test_expect_success '.git/shallow is edited by repack' '
 	git init shallow-server &&
 	test_commit -C shallow-server A &&
 	test_commit -C shallow-server B &&
-- 
gitgitgadget
