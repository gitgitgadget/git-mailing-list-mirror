Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4F71F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeFHWmO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35682 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbeFHWmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so6293151wme.0
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWpgLJhTD54kRlWzUXC2X9KCWDW15+uFjhqQwMehicA=;
        b=KaujKsSa1fSyDPpaaMSlHYMmImnVpaz545gdCXDPEaWVI11i8g21P3kRlaTcMX9CzI
         OzKc9JoIsTQCBWeDx2hfx8ukBwE3tqTkMnlK9NmrN4Eqqwr6XuqReqCvt8nQZR94Xk81
         Ttl19OBd+U9nEhDci0BhyLAgxy29tU3IX/bFIbJ9TbKSdvLonpjCgzDl8Jil3JAXy3B3
         jHYu75yvV72BPfLsyP5Ww7UQ8mNrQpFlPPTqTeodDK7vLISUOIgrnuKwdAI0ao4YqMUc
         fTznOvYGE5vNZ/7xfL+k9fGO1hfg3cmc1PQg3royYVjc2lzetDWwQiueZ2WwBGR4g14h
         KYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWpgLJhTD54kRlWzUXC2X9KCWDW15+uFjhqQwMehicA=;
        b=RRaWPx1WjHQnSYSttcYGlFfpz3XrUhrPj60JRB/jWjftPHx73hJEniZaUzJ3/7KNd3
         C7PSQSu9C9mPWpuiQj43HgMoSGkiyhYMZ83K5D/4UvNELSExSsDZYuTfxQYG+WZMR2VO
         3GNELcpRHerVPt+KJbhELX8vxBE8mc48bsffbou4dqGsYLpr6SPvWNj5d/uDPFW7H/Ul
         KEfhbSd4WGjpUPD8VyluArg9Q+W5ShG6Uro4izLdzuQ9BEkxw4tRi10V3b48kwAN3NPE
         8o4BA8LQ6sM3oIjtjoMWdQvf6jJ8Pbz3OepV7TdUho2fSsHcnLSwXSOMB8rBR1fSN8hM
         qlBg==
X-Gm-Message-State: APt69E0e/iAumtrTU6n/tjBBbsaS7KK245DPUFvrXJRTYroaLN1G5tfB
        i6YuEpdUJLv8hS6g75gdhHXagDtC
X-Google-Smtp-Source: ADUXVKITk7YjeBPuk260e0+hKgwJHJhgtv7wJ69EpYXDxRlMgriRRXkrtxHEMTcwNrQiPvn5UP2rTQ==
X-Received: by 2002:a1c:d543:: with SMTP id m64-v6mr2473484wmg.12.1528497729832;
        Fri, 08 Jun 2018 15:42:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/20] abbrev: unify the handling of non-numeric values
Date:   Fri,  8 Jun 2018 22:41:32 +0000
Message-Id: <20180608224136.20220-17-avarab@gmail.com>
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

Unify how --abbrev=XYZ and core.abbrev=XYZ is handled. 2/4 parsers for
these values would just let these invalid values pass, treating them
as though "0" was provided, which due to other inconsistent fallback
logic (soon to be fixed) would be treated as providing MINIMUM_ABBREV.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c            |  5 ++++-
 revision.c        |  5 ++++-
 t/t0014-abbrev.sh | 10 +++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 136d44b455..75935322f1 100644
--- a/diff.c
+++ b/diff.c
@@ -4801,7 +4801,10 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		options->abbrev = strtoul(arg, NULL, 10);
+		char *end;
+		options->abbrev = strtoul(arg, &end, 10);
+		if (*end)
+			die("--abbrev expects a numerical value, got '%s'", arg);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
 		else if (the_hash_algo->hexsz < options->abbrev)
diff --git a/revision.c b/revision.c
index 40fd91ff2b..aa87afa77f 100644
--- a/revision.c
+++ b/revision.c
@@ -2047,7 +2047,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
-		revs->abbrev = strtoul(optarg, NULL, 10);
+		char *end;
+		revs->abbrev = strtoul(optarg, &end, 10);
+		if (*end)
+			die("--abbrev expects a numerical value, got '%s'", optarg);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > hexsz)
diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 6dee92f35e..203fe316b9 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -64,14 +64,14 @@ test_expect_success 'abbrev non-integer value handling differs ' '
 	test_must_fail git branch -v --abbrev=XYZ 2>stderr &&
 	test_i18ngrep "expects a numerical value" stderr &&
 
-	git log --abbrev=XYZ -1 --pretty=format:%h 2>stderr &&
-	! test -s stderr &&
+	test_must_fail git log --abbrev=XYZ -1 --pretty=format:%h 2>stderr &&
+	test_i18ngrep "expects a numerical value" stderr &&
 
-	git diff --raw --abbrev=XYZ HEAD~ 2>stderr &&
-	! test -s stderr &&
+	test_must_fail git diff --raw --abbrev=XYZ HEAD~ 2>stderr &&
+	test_i18ngrep "expects a numerical value" stderr &&
 
 	test_must_fail git diff --raw --abbrev=XYZ --no-index X Y 2>stderr &&
-	! test -s stderr
+	test_i18ngrep "expects a numerical value" stderr
 '
 
 for i in -41 -20 -10 -1 -0 +0 0 1 2 3 41
-- 
2.17.0.290.gded63e768a

