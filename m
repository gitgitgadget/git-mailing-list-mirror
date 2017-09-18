Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7C02047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbdIRREl (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:04:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37798 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932941AbdIRREk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:04:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id q132so630988lfe.4
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRmFWHH4ZqihhBappAqxYeeTKHl3TyxlLz0HJL4i9H8=;
        b=Jg9jgJRZCuFe0orEHYbADe6ivfslMiWl1+xxmw/rFwDTB9x1bSm8+AEpJpg7SgfU80
         le1bSbsLplEUJVVGBQfNcIu0BLr7qRIDlYgf2NzO0AoW0GdqvJoQknos3hX5LCIEdjCI
         rIH6czXHk3qIRvBE0bqUSPCynkb+bw4HRJK7HVfF+E8eJ9kCUnMB5G456b6dTCkAgiPt
         /IQykZBbEJO3WrLeJe9/tt3giaCk+NSCLEtfk5yjDXUcu9GWeoa29EWkB5qD0eix7Qke
         6eNfwFdkFVGJaYJ8LtVOYySSm4N9hh5WnXoPonYxnpo2HQ1/6S9+MmNfJYUrMOPHQWml
         cdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wRmFWHH4ZqihhBappAqxYeeTKHl3TyxlLz0HJL4i9H8=;
        b=YZEr18E5YKmftzaYG/hqCyFHyC7VPWCSHRzz5xc+nuljoliPmT+3L7j5ofx64V90CG
         WkhoSAibk/ii5lg3AEssT5l3STthqFfz99IwwI8NDGruRIipayR6AC47sxPjXyH5Mbhd
         DHugCmFPggOIfsFOMCCxgPaCrPjRdIzITty5UStvABBFWTGrNbV1aAQb380whJKR7mY/
         rsG6/f0ZGooef3xt+7jwecSJNsXENjTEFW2nBH6cipZfrxHvDf5hW4MRm1m0rgopXirD
         8FisNQVSkx3aQ6vnobspZITzofsg4FtN25E7e5HYUV2bWrjnOgDu8yZIs5GZ2zYjGGZj
         wfbQ==
X-Gm-Message-State: AHPjjUgHrBwOQ20T+M1pSVJJlpPuhQ4W1K7ZlRfm7zfpWjJ0eRs48Jj0
        LvTrqMIGWALXrFWl
X-Google-Smtp-Source: AOwi7QBkvXFJAs1X5oH4wKOWx04hLXdAwLyQUXh8b5K+MSb7O+b4BkyYScarVyfw+vseahWBvX3Zkw==
X-Received: by 10.25.169.21 with SMTP id s21mr3562928lfe.158.1505754278302;
        Mon, 18 Sep 2017 10:04:38 -0700 (PDT)
Received: from localhost.localdomain (114.138.16.62.customer.cdi.no. [62.16.138.114])
        by smtp.gmail.com with ESMTPSA id 1sm1923615ljo.13.2017.09.18.10.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 10:04:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] rev-parse: rev-parse: add --is-shallow-repository
Date:   Mon, 18 Sep 2017 19:04:29 +0200
Message-Id: <20170918170429.8328-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.11.0.485.g4e59582
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running `git fetch --unshallow` on a repo that is not in fact shallow
produces a fatal error message. Add a helper to rev-parse that scripters
can use to determine whether a repo is shallow or not.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 Documentation/git-rev-parse.txt |  3 +++
 builtin/rev-parse.c             |  5 +++++
 t/t1500-rev-parse.sh            | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b1293f24b..0917b8207 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -235,6 +235,9 @@ print a message to stderr and exit with nonzero status.
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
+--is-shallow-repository::
+	When the repository is shallow print "true", otherwise "false".
+
 --resolve-git-dir <path>::
 	Check if <path> is a valid repository or a gitfile that
 	points at a valid repository, and print the location of the
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2bd28d3c0..c923207f2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -868,6 +868,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
+			if (!strcmp(arg, "--is-shallow-repository")) {
+				printf("%s\n", is_repository_shallow() ? "true"
+						: "false");
+				continue;
+			}
 			if (!strcmp(arg, "--shared-index-path")) {
 				if (read_cache() < 0)
 					die(_("Could not read the index"));
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 03d3c7f6d..9d3433a30 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git-path shallow repository' '
+	test_commit test_commit &&
+	echo true >expect &&
+	git clone --depth 1 --no-local . shallow &&
+	test_when_finished "rm -rf shallow" &&
+	git -C shallow rev-parse --is-shallow-repository >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path notshallow repository' '
+	echo false >expect &&
+	git rev-parse --is-shallow-repository >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'showing the superproject correctly' '
 	git rev-parse --show-superproject-working-tree >out &&
 	test_must_be_empty out &&
-- 
2.11.0.485.g4e59582

