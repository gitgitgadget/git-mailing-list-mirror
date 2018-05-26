Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BDA1F42D
	for <e@80x24.org>; Sat, 26 May 2018 02:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030929AbeEZCcj (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 22:32:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33698 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030648AbeEZCci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 22:32:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id a15-v6so12048202wrm.0
        for <git@vger.kernel.org>; Fri, 25 May 2018 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LQYU5DOyBgcRnQL7yzmIGc3nf3A+plbKcOfsjYXd540=;
        b=lGA1MHYB8oCBpna4jGi6pPNf5OBL+ZwDsl9fQieFhj9v3rCb8fEENgF5AI9VZXxiIg
         4LcCfsWWdjK5tN8RxzqLQpzMM/6EWfXp8PihDjv0xoanOsSK0GirdGQgPl6sJqGSRbXb
         Y0917Id/x3/Y5C2vCi9s+rVDtaU+39DCsaLTfvuELHnDgXHszIChdQ+luzTMChjpKM47
         nfdZD33HtU5F4isSvqokkYLnl+mKAQpy85Cvit/jHK1Tw2Woq2dmyZJtEWvzrLPZs1UC
         S86/05vbN0IyAAKwuwGbTdvg/Y7EzSsfr+YAmTc1ooJqdVkzcwgsGnv2TKmagTdo1IIS
         exag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LQYU5DOyBgcRnQL7yzmIGc3nf3A+plbKcOfsjYXd540=;
        b=jVwf4iUuz2r8JkBaKrlgoK3LA5AeYjJBFcpYdp3RliSzHg9NKEfikduR2jT6LSho1x
         3W5Yg4X6kQdrAMwj8cD+jjpPxrncEVs5oj9xtml844hpugVhnDC4WpVu1fqtPoKDJ/J9
         hoy1bf3WdiJJiFlUUT1mT3GkAH2TPP4RJbnUtMOMnq80zLWWCbZ9S/LAz0sGMYEc4S6D
         tIYMzKGhf5YP/PvNwuVUicCxAhhkQf5M1juyRgKqSWhCCkorqTAoL/RJmfklzAOgOOhm
         OKFeH8+W6/01xPE1nGIduFyhMTrfd8oQR7m/iEuR5IIOWIdUGuXt6VJkaaj8lBGsxnW2
         qlbw==
X-Gm-Message-State: ALKqPwe5unZYmnsh5HonJn3g/rHCSrI4DX3YFNR22GxPQ052zypGZYDO
        hR8/TdWpSeAJr2nMRuXmakk=
X-Google-Smtp-Source: AB8JxZoig2PEUL5z2P2wJ64LGzSx/lSt+xe1oE9qFl6UTejOPFZpTmYA2X4Zupb4ZeMzK9WLjH9J5w==
X-Received: by 2002:adf:8f70:: with SMTP id p103-v6mr4349873wrb.181.1527301956814;
        Fri, 25 May 2018 19:32:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i12-v6sm11426452wrn.55.2018.05.25.19.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 19:32:35 -0700 (PDT)
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
Date:   Sat, 26 May 2018 11:32:35 +0900
In-Reply-To: <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 25 May 2018 17:56:34 +0900")
Message-ID: <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Yup, thanks for being extra explicit.  I do imagine there are quite
> a few of us who would be puzzled without this update (but with the
> previous one to unhide it from behind the pager).

With these two patches queued on top of jk/branch-l-0-deprecation,
the follow-up patches jk/branch-l-1-removal that makes 'branch -l'
to fail and then jk/branch-l-2-reincarnation that makes 'branch -l'
a synonym to 'branch --list' needs rebasing.  Both are trivial and
hopefully I did them correctly.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 26 Mar 2018 03:29:22 -0400
Subject: [PATCH] branch: drop deprecated "-l" option

We marked the "-l" option as deprecated back in <insert sha1
here>. Now that sufficient time has passed, let's follow
through and get rid of it.

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
[jc: added a few tests]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c  | 14 --------------
 t/t3200-branch.sh | 12 ++++++++++++
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b0b33dab94..01b35b3c3d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -571,14 +571,6 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
-static int deprecated_reflog_option_cb(const struct option *opt,
-				       const char *arg, int unset)
-{
-	used_deprecated_reflog_option = 1;
-	*(int *)opt->value = !unset;
-	return 0;
-}
-
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -622,12 +614,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
-		{
-			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
-			N_("deprecated synonym for --create-reflog"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			deprecated_reflog_option_cb
-		},
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index da97b8a62b..eca75d3ca1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -45,6 +45,12 @@ test_expect_success 'git branch HEAD should fail' '
 	test_must_fail git branch HEAD
 '
 
+test_expect_success 'git branch -l no longer is --create-reflog' '
+	test_when_finished "git branch -D new-branch-with-reflog || :" &&
+	test_must_fail git branch -l new-branch-with-reflog &&
+	test_must_fail git rev-parse --verify refs/heads/new-branch-with-reflog
+'
+
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
@@ -288,6 +294,12 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
+test_expect_failure 'git branch -l eventually is --list' '
+	git branch --list >expect &&
+	git branch -l >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.17.0-775-ge144d126d7

