Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA2F1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeIZEoH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:07 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45107 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeIZEoH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:07 -0400
Received: by mail-ed1-f50.google.com with SMTP id j2-v6so160893edp.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JOTR0TkRuhZcKsYYruGMsHpp+QWUg9K3rRvY7NIt26I=;
        b=iLCNcrDC3UQ3ZURJQrdbcvh8/uSlQLjwQEeUOwBBqvI4YpdIcm2lgcKQC7SKIy78w/
         wEeq7v9Zjzs3xpXOHI5U4hQ2EgaONZnGfcBW1wEKw2rvfP2lnVW0Vk+Ik59CSUGgVrvp
         OE/eQwcu3LEt5KGGRLYMonHPsHZUsaMITaleUn8bLco7/Oalgoxy126reOT0LIovkojd
         lctB3ieh+MBqVj1jSf521mlGFigV+3Aj92zgFqpnBcSn6JJWUEwQEe5UX3e0spthUR51
         aJWwffsT5KQ9xJmWppzAsTRpx127Xm1d3bFbXHG48fKg/rpq2KQuwLx1niABMYexwDF7
         cXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOTR0TkRuhZcKsYYruGMsHpp+QWUg9K3rRvY7NIt26I=;
        b=Qj8kBIkZEl+cTwh6drsouIRAxtxiEXUwtUa+c6gQMUl0p8ywxvdhCJl3/Ac6kUOzIJ
         uklyGcz68gSwL9txjh3Hmsh9eGxQXHDGfrLYzbmCVAYNzYfEH4qBcrP4VIi1qNySq9XF
         QSzjfrrpI8EDd/ar14qqp3KP4LJWKyRenQ70IRFKR+B55737xEq/70j7dSa3h8jScyiC
         onHqfj3qg9AZ0NEO1/i3zgxeB/8u1a+ebH0qkGk36hDtOaoGGkJ7hTFaW2Hf1VwC+laL
         8H7OB1v3+7IOEeo3fdOJHAb5JCZWeYxiWnYKJTyLBfB9PevIDUUwa63DFuVI7q1St6ZH
         CVGA==
X-Gm-Message-State: ABuFfojhMj5qmvGCfes9p5XMGy04ObjHCXEicpb+p+OedHQqWPAXV3L8
        zW/MIbwZJ7pZAw1CzQXU/ynRVuAM
X-Google-Smtp-Source: ACcGV63EbSgl313Jtt5vQ3HJb06PKkeEKVCwed9I8MiQQXQfOifhR36OG60qXR9OUwOmjC/oX3w9iQ==
X-Received: by 2002:a50:bb69:: with SMTP id y96-v6mr5005655ede.10.1537914860670;
        Tue, 25 Sep 2018 15:34:20 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:19 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v9 02/21] stash: improve option parsing test coverage
Date:   Wed, 26 Sep 2018 01:33:13 +0300
Message-Id: <42423f6af38dd9029c7f7fe870593efbeabe3f1c.1537911869.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many parameters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1f871d3cca..af7586d43d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'giving too many ref arguments does not modify files' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	echo foo >file2 &&
+	git stash &&
+	echo bar >file2 &&
+	git stash &&
+	test-tool chmtime =123456789 file2 &&
+	for type in apply pop "branch stash-branch"
+	do
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many revisions" err &&
+		test 123456789 = $(test-tool chmtime -g file2) || return 1
+	done
+'
+
+test_expect_success 'drop: too many arguments errors out (does nothing)' '
+	git stash list >expect &&
+	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
+	test_i18ngrep "Too many revisions" err &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show: too many arguments errors out (does nothing)' '
+	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out &&
+	test_i18ngrep "Too many revisions" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'stash create - no changes' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -479,6 +509,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.19.0.rc0.23.g1c0a08a5d3

