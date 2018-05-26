Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8481F42D
	for <e@80x24.org>; Sat, 26 May 2018 02:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031030AbeEZCdk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 22:33:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43089 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030648AbeEZCdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 22:33:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id r13-v6so12018156wrj.10
        for <git@vger.kernel.org>; Fri, 25 May 2018 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MPqyIplXKfu5q8oG7tTQlsdwC0RwEeF5UULRyGbrXPc=;
        b=TAiOt7qFDWpIyJR/jZXOIIw7YedZH+aZD5k3aBA25CFVOiKRWDUmYhp89rmRxKK7ld
         5g0NuBQu4Ya1qIRwhO3Ysl+11a6z2OQgo2PMVOTwF8FG4GEdDQAfKzS8inkT3+30S8Kf
         sRLNzBMSqrXuePfzorKRk5o4g+hj8lmtSHZks7glFsi7b6hyIYjQXO4Ju43Ss98rQdhg
         yNHS/RHiphgrY/F5E2AO/DWi7HDT/9wvtb/GNL5uykFIlOoDAz8Tb+xVzCrIJTOXXmrW
         DQ7OroqDcoK2R/uWRvUCaIwK6ekmYhSq9XbgYlYKFq31CtRLXptodaLw/gZ08ilukaNQ
         NaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MPqyIplXKfu5q8oG7tTQlsdwC0RwEeF5UULRyGbrXPc=;
        b=qHcu4dWarRN386LLD/7SIzyDR+Ayd8q7siizGGKn2vDD999SeQnFeyCWsWSeG9Iabf
         KO8PYg2na45a4XHCdIlHzHpVrlCu2l6BMlsZ015WPhkXM5vtMxGLnmKTNpBaWaEyAEnP
         BeTKWugQiog6A71B2yUV+JH4GP2YipNTDCNLHZSHLLNu+XwJtv+jTTirIe2zrYK5P1Tv
         HAdetBqUNP7qUMOM6luUHcf+ZMwtyKNBxt/wTFgAQZzjndY6+HYLrxJ3HzkVNcyoKdxQ
         +KRBPzeHwpEr3BY1EiE/et6P4rov01neg0dXNtS7oHjEtiD3cGNOZO5E67v+lSYCDNG5
         U3FA==
X-Gm-Message-State: ALKqPwfTU8gcJ49QAHlkmzKBw3/ji7SnLIVoy+d8m2hZDIUW6WbHDOJ2
        8cUJChr+/99NEpHyttuqy3T7+QZ/
X-Google-Smtp-Source: AB8JxZreJBZe2cXNv4uCqVcO2VenloiaSXVSXtkIMK/COjEPngQ29BuTC6h8it9VdfnukcbAQ+ydWw==
X-Received: by 2002:adf:d250:: with SMTP id o16-v6mr3860668wri.59.1527302017807;
        Fri, 25 May 2018 19:33:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e81-v6sm4598030wmi.28.2018.05.25.19.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 19:33:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
        <20180525024002.GA1998@sigill.intra.peff.net>
        <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
        <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 26 May 2018 11:33:36 +0900
In-Reply-To: <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 26 May 2018 11:32:35 +0900")
Message-ID: <xmqqwovrm9hb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> With these two patches queued on top of jk/branch-l-0-deprecation,
> the follow-up patches jk/branch-l-1-removal that makes 'branch -l'
> to fail and then jk/branch-l-2-reincarnation that makes 'branch -l'
> a synonym to 'branch --list' needs rebasing.  Both are trivial and
> hopefully I did them correctly.
>
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Mon, 26 Mar 2018 03:29:22 -0400
> Subject: [PATCH] branch: drop deprecated "-l" option

And this is the final "reincarnation" step.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 26 Mar 2018 03:29:48 -0400
Subject: [PATCH] branch: make "-l" a synonym for "--list"

The other "mode" options of git-branch have short-option
aliases that are easy to type (e.g., "-d" and "-m"). Let's
give "--list" the same treatment.

This also makes it consistent with the similar "git tag -l"
option.

We didn't do this originally because "--create-reflog" was
squatting on the "-l" option. Now that sufficient time has
passed with that alias removed, we can finally repurpose it.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
[jc: adjusted the new tests added earlier]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c  | 2 +-
 t/t3200-branch.sh | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 01b35b3c3d..1d06f5c547 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -612,7 +612,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
-		OPT_BOOL(0, "list", &list, N_("list branch names")),
+		OPT_BOOL('l', "list", &list, N_("list branch names")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index eca75d3ca1..022d6a41c8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -45,12 +45,6 @@ test_expect_success 'git branch HEAD should fail' '
 	test_must_fail git branch HEAD
 '
 
-test_expect_success 'git branch -l no longer is --create-reflog' '
-	test_when_finished "git branch -D new-branch-with-reflog || :" &&
-	test_must_fail git branch -l new-branch-with-reflog &&
-	test_must_fail git rev-parse --verify refs/heads/new-branch-with-reflog
-'
-
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
@@ -294,7 +288,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_failure 'git branch -l eventually is --list' '
+test_expect_success 'git branch -l is --list' '
 	git branch --list >expect &&
 	git branch -l >actual &&
 	test_cmp expect actual
-- 
2.17.0-775-ge144d126d7

