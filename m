Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E671F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeFHWmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54554 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWmM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so5695569wmf.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XRxgJoafas8capSj9n2tmppJFU3FBRRz0OZ7IOwgcA=;
        b=DV6zy7MH1ock37ZZ3ccG8kPhQKD5jh7yUCx3CIXixup0sYB7t8rXG1QLz7pEHw3lJt
         awIXfyMvAxF2aWFMOc/YRr7G4VLyR4xx5pRYdqbqA56wS0lnUBVx+lck/tgCPGGHvS9T
         6sz836ej+4NOiUJO3DTQMaDIKQ3/aVRzUhetLQUExEn+kwhCVfhXYmallXlLl7EGAr9L
         M/cMWzyiU1Grg7V3QOFAfQAtZp86AQeQ0cyLSvO6swMH1sFlGH8taS4Hde9zHBDeZNrI
         8oM8zS4+ORAMMhFmivVIqZ1cCKcYM5syp7Fyn8aI0Fq8nnB/txBVTDHA0YZp2IcCeiRq
         Ubow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XRxgJoafas8capSj9n2tmppJFU3FBRRz0OZ7IOwgcA=;
        b=GInFioYIGrUAN+iRaqqan+8ucI9g6SwdRs3qFzxYXA0eUUip/vxTVkwZsTamlUctgy
         +rx58abRfFAY4Dm1nVtzmvLkEPfuFCv+gExEbd51Hyi5j4L/UXCZEn2shj9y6/DDsMvW
         YDum81rGv7+BXDIVgApT1K29paOmwNiGzErYO5g2yNrheD7isOLjMWl+enMyvr0fx/uv
         JPhRYWt/pECpRB7KWY9jyKNoChOYTSJV75PJKzrYptHEPhJ3Q+6zGbcRhXLhGJ3kA7xY
         vyfGlxOjuDaMzJAeketVx8cfWHsw41fvAV+xoEPNF15p2XzVtH+N1j9uZAM+sO473L2f
         80pw==
X-Gm-Message-State: APt69E102dRYr1FOqgsZGw0wbxLEUEHrIGtyGSEgn6u1xVg9vufYVVRc
        A0fpd0CATaRVqTLU0dn5tVlAf8N0
X-Google-Smtp-Source: ADUXVKIw6Yk3OfHzCb5muaXtHwsyCmu47ixYnAAh8xysziAxfLfxlpihc1pMPg1ugO1pyLi/KGnlxg==
X-Received: by 2002:a1c:150:: with SMTP id 77-v6mr2848321wmb.3.1528497730927;
        Fri, 08 Jun 2018 15:42:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/20] abbrev: unify the handling of empty values
Date:   Fri,  8 Jun 2018 22:41:33 +0000
Message-Id: <20180608224136.20220-18-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For no good reason the --abbrev= command-line option was less strict
than the core.abbrev config option, which came down to the latter
using git_config_int() which rejects an empty string, but the rest of
the parsing using strtoul() which will convert it to 0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c             |  2 ++
 parse-options-cb.c |  2 ++
 revision.c         |  2 ++
 t/t0014-abbrev.sh  | 22 ++++++++--------------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 75935322f1..cab79d24ab 100644
--- a/diff.c
+++ b/diff.c
@@ -4802,6 +4802,8 @@ int diff_opt_parse(struct diff_options *options,
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
 		char *end;
+		if (!strcmp(arg, ""))
+			die("--abbrev expects a value, got '%s'", arg);
 		options->abbrev = strtoul(arg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", arg);
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e3cd87fbd6..aa9984f164 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -16,6 +16,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg) {
 		v = unset ? 0 : DEFAULT_ABBREV;
 	} else {
+		if (!strcmp(arg, ""))
+			return opterror(opt, "expects a value", 0);
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
 			return opterror(opt, "expects a numerical value", 0);
diff --git a/revision.c b/revision.c
index aa87afa77f..d39a292895 100644
--- a/revision.c
+++ b/revision.c
@@ -2048,6 +2048,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
 		char *end;
+		if (!strcmp(optarg, ""))
+			die("--abbrev expects a value, got '%s'", optarg);
 		revs->abbrev = strtoul(optarg, &end, 10);
 		if (*end)
 			die("--abbrev expects a numerical value, got '%s'", optarg);
diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 203fe316b9..8448f78560 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -38,23 +38,17 @@ test_expect_success 'abbrev empty value handling differs ' '
 	test_must_fail git -c core.abbrev= log -1 --pretty=format:%h 2>stderr &&
 	test_i18ngrep "bad numeric config value.*invalid unit" stderr &&
 
-	git branch -v --abbrev= | cut_tr_d_n_field_n 3 >branch &&
-	test_byte_count = 40 branch &&
+	test_must_fail git branch -v --abbrev= 2>stderr &&
+	test_i18ngrep "expects a value" stderr &&
 
-	git log --abbrev= -1 --pretty=format:%h >log &&
-	test_byte_count = 4 log &&
+	test_must_fail git log --abbrev= -1 --pretty=format:%h 2>stderr &&
+	test_i18ngrep "expects a value" stderr &&
 
-	git diff --raw --abbrev= HEAD~ >diff &&
-	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 4 diff.3 &&
-	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 4 diff.4 &&
+	test_must_fail git diff --raw --abbrev= HEAD~ 2>stderr &&
+	test_i18ngrep "expects a value" stderr &&
 
-	test_must_fail git diff --raw --abbrev= --no-index X Y >diff &&
-	cut_tr_d_n_field_n 3 <diff >diff.3 &&
-	test_byte_count = 4 diff.3 &&
-	cut_tr_d_n_field_n 4 <diff >diff.4 &&
-	test_byte_count = 4 diff.4
+	test_must_fail git diff --raw --abbrev= --no-index X Y 2>stderr &&
+	test_i18ngrep "expects a value" stderr
 '
 
 test_expect_success 'abbrev non-integer value handling differs ' '
-- 
2.17.0.290.gded63e768a

