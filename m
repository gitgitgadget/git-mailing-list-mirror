Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91EC1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeLTTo4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33335 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTToz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so2990777wrr.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nw+Q3Ds1B6FCAU4EdA/Y7hx16jwbNmV5Tq4z4X0gRrk=;
        b=uMeHFVP3tQ73dQWEshf/wjnbGPbluK/PHe/GFAUIpEGVYvHzsqtAwhoEIfWrJpQUIf
         50X5+CDfGaZjDuBUBzmOSOuO60Lpw9v06CrOWIr2nFSSFgt3LBNF4OJP5MSuQk0pXRwO
         PYHVc/JfeCUwnh2If4DWHnH1sGY716kpuDhSZZbFdBHMCbuEtjtAmZ1CKlMAEpSKjPnD
         ASIIpYxHbKvJY/JyYpMTuiVhfF78L7B7ACPB6wODYfZqe8d8UqOh2YD586oLy8oJHTRq
         6Pi1ajU084xhNbWUnNbqdUlXYHIqSly3WTbWGT/M1l0gW1XZvj8+7ySgyvrnPmrzDEu2
         DUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw+Q3Ds1B6FCAU4EdA/Y7hx16jwbNmV5Tq4z4X0gRrk=;
        b=FlxLoYSGtuXMyURzX19ZfgvWAu00UR4otaT0FrpkH+Mc+hRyW8TlYowwzGfxYTAZ3Q
         9/UK4YmIcXEE43vwOJlOFXuPZ0k+vYlum9Guaacvh6TUfsr9pg2mDHk2BX4Qp6VZyhXL
         G4SmqBbKsodaQKLtfIA6DmwY5iXrI6S6rVfA1rGNfT263NR0OQ3cAED8Jp2/0gdvJgVf
         U7YLslwwujpGAAlkGwHTBbaKCyPaLdCEdNuX1e1lwlhjxBGwDrGL6gBC+aPx2xc10ndZ
         VDOZN28odiT+PkdPS+bGPNjY8CMmMYT9ka7rT2Eg6FSJZFbKkgeS1OmBizh23ufXT69v
         msIQ==
X-Gm-Message-State: AA+aEWbjhreNgvuadl6IWsZZcrFPEkC+3zVhvlGOoZwosGXzdhGDOjWy
        Luz/C4OLNn7r17aNUsNFlHSjaYjl330=
X-Google-Smtp-Source: AFSGD/Ut4BMcc65qajhjvHN3TPebh+7CmKXx7GrnUymQb5AkUkdxhf6Prs40havZ+kCu4UiVmncyFw==
X-Received: by 2002:adf:c888:: with SMTP id k8mr25593547wrh.6.1545335093124;
        Thu, 20 Dec 2018 11:44:53 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:52 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 05/26] stash: improve option parsing test coverage
Date:   Thu, 20 Dec 2018 21:44:21 +0200
Message-Id: <7e3081091a405469e05bd64257fb07eb241b56a6.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index 5f8272b6f9..ac55629737 100755
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
2.20.1.441.g764a526393

