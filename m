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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EB11F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFTVJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFTVJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so4402577wrl.11
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRctIvxPgB9PE0jpv4WdLCspT34W7igX1nCADTy4g68=;
        b=Ad6PZ4wRTZ8KRBSKnqRpFd/GYNAi4syGax3wbibsAbqhPE7xX+uE1iZdbAYJLB1uum
         T2elz1JDsoWLGhcA1PVoHzBE3fz7C9z0Jb7wSF7XFDbHrv1liEhzuJ2KgTKLwvN2XlAV
         cbs2P6hkwTRLwrJN+mpKDkx6MNG/krOAGbENhIzr0d2G17lT2IoMjrp/wUfxv8EYsUUy
         zYtkiQIj4Qscs7dZSkrilvJjbvMjhK5d6zVsgNOo08N6iXRpThd3Ff/A2UZ9zewuo7WI
         vFh2hq5kRrXtwVCGDkhxH0JUIWr4AC9WX2PwsekLwWO3HAYPPZUc2nlwH2nSjdhXrRnx
         HL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRctIvxPgB9PE0jpv4WdLCspT34W7igX1nCADTy4g68=;
        b=tth4XTNK0gvr2sNeefteKUgQIgBzCDj1azGRUtapOXGT1bGkxbDT+Rv8hA9ziS9buo
         6AB9H5vNz6++ssjisVliajW6b9/+w9s/9rLUK4hcfPlD7g0rHY/8en80hlxlQ/Lpv1/N
         rs2eIQ0NvcqZfpZx4XOp8auy4Q9PsyFWmWf9Xxix09GPDkPSM688qDQ4bLKIstJI6enG
         z0LRaiwHkkE4Yzw23exmP3c6bKEV0YNnFV9sAdRYODQrrqYWElM5WUimOa/M6/53yRAx
         4IvKE2vS8I8vtfeBte09b8SXWMXQNo9jNNeCLfpgAfvb7l81b70/cIF8DmDPFeJ8bHuV
         L15w==
X-Gm-Message-State: APjAAAVVwiVnnuXzOfcdKI3xMiEZn3Phe5uLRNS0M6NO3wANO9FHOgl+
        ffS7AMcYGq1rpU52jYw9LtTGxYGXKt4=
X-Google-Smtp-Source: APXvYqz/N1QQdPIJ0VbW0B1LfjdjCf8B+3mI7Te6G0BCvAy84hEy2B9if1s7Sc7kTd/8inBq/xawqw==
X-Received: by 2002:adf:9e89:: with SMTP id a9mr79416940wrf.78.1561064967296;
        Thu, 20 Jun 2019 14:09:27 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] config tests: simplify include cycle test
Date:   Thu, 20 Jun 2019 23:09:08 +0200
Message-Id: <20190620210915.11297-2-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify an overly verbose test added in 9b25a0b52e ("config: add
include directive", 2012-02-06). The "expect" file was never used, and
by using .gitconfig it's not as intuitive to reproduce this manually
with "-d" as some other tests, since HOME needs to be set in the
environment.

Also remove the use of test_i18ngrep added in a769bfc74f ("config.c:
mark more strings for translation", 2018-07-21) in favor of overriding
the GIT_TEST_GETTEXT_POISON value.

Using the i18n test wrappers hasn't been needed since my
6cdccfce1e ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08).
As a follow-up change to the yet-to-be-added t0017-env-helper.sh will
show, doing it this way can hide a regression when combined with
trace2's early config reading. That early config reading was added in
bce9db6de9 ("trace2: use system/global config for default trace2
settings", 2019-04-15).

So let's remove the testing for that potential regression here, I'll
instead add it explicitly to t0017-env-helper.sh in a follow-up
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1305-config-include.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 579a86b7f8..6b388ba2d0 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -310,20 +310,13 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icas
 '
 
 test_expect_success 'include cycles are detected' '
-	cat >.gitconfig <<-\EOF &&
-	[test]value = gitconfig
-	[include]path = cycle
-	EOF
-	cat >cycle <<-\EOF &&
-	[test]value = cycle
-	[include]path = .gitconfig
-	EOF
-	cat >expect <<-\EOF &&
-	gitconfig
-	cycle
-	EOF
-	test_must_fail git config --get-all test.value 2>stderr &&
-	test_i18ngrep "exceeded maximum include depth" stderr
+	git init --bare cycle &&
+	git -C cycle config include.path cycle &&
+	git config -f cycle/cycle include.path config &&
+	test_must_fail \
+		env GIT_TEST_GETTEXT_POISON= \
+		git -C cycle config --get-all test.value 2>stderr &&
+	grep "exceeded maximum include depth" stderr
 '
 
 test_done
-- 
2.22.0.455.g172b71a6c5

