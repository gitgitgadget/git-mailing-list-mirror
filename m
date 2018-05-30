Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C9D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeE3VHH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:07:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45931 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeE3VHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:07:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id w3-v6so30866032wrl.12
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uiq6IQAOLUu2dP0KDCGpwE1HpYy3KZHSFBD43BmyzQM=;
        b=eW9fGQ50cOTDNzphqs2Nf4TMJAn9JtovvLtUlXYcGm/48NqCuewLwmyXbNSytAzu2C
         TLF7yUgmgNGydjjHSpJhcpZNAnGmokpIVCRXcRB1FeNv9YF03jGYXWR7yy848bwRQzAn
         c35dijEVI/34INhVIhwZCVn6itMHLsXt1vX1sGUAcjulrgB6OCcY7p9E3g0I2WbCVRwd
         wGHzSrulGVCwF/jnW6c6Hu6gK2Mbr+jDRl6ypIdtXeMbjEs9TatjKhRJwKXF8OnfpOlI
         B/qr6toyIrJecwL9Ws2FFjI0dneFUuWF11zEeRskAMLhlGAIXSgUpjj4tFO2KjyvOhc0
         Pokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uiq6IQAOLUu2dP0KDCGpwE1HpYy3KZHSFBD43BmyzQM=;
        b=GRL94Cpb+Cv5LorcHUVXTAuM7XUIReG8crcpCQlIF52wOIuK8UOMyk08EfvtGzLW0J
         9iVP4Bs8CuJ2VEjmZE0X3z7hL7l3TbABBS/BDqaB6FcfTLpYPNgfdeziMplCfhZshSmm
         ZIZ+agFMTapSQyyfOi44S4G5K1TfkRLBRNal0CERpbWrG10xqPIkqVAggDW6eMTJO+BH
         aeMgPNLOqkliI5jYe3j1xGPB4xxwoLrXVQ20oQ0JRO4a4SavlQ3MOja/4UQemf/nfqC0
         v1QjTV1LT64mRka1YSv5yV7PfOZIfCkhr/LOQyjS5ctJKg4NygBKmG4nB+fmfvIJYYSf
         j0Tg==
X-Gm-Message-State: ALKqPwcPaJOPUfQ/gbAfVS40IIbb9Obxdcj3jzbGR1lqpou5wfz1cYn5
        jOGnU8rat9JENHN8+t5S1hjU+78c
X-Google-Smtp-Source: ADUXVKK6jBUc/cvsz8sTS12YOtFVOQ/t0B/zSf350UqQPxySNRmwfnrIO8/+OsoBvhHmtkJZ1cfFYg==
X-Received: by 2002:adf:ac69:: with SMTP id v96-v6mr3161795wrc.5.1527714420631;
        Wed, 30 May 2018 14:07:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18237097wri.67.2018.05.30.14.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 14:06:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/4] color.ui config: don't die on unknown values
Date:   Wed, 30 May 2018 21:06:40 +0000
Message-Id: <20180530210641.19771-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180530210641.19771-1-avarab@gmail.com>
References: <20180530210641.19771-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change git will die on any unknown color.ui values:

    $ git -c color.ui=doesnotexist show
    fatal: bad numeric config value 'doesnotexist' for 'color.ui': invalid unit

This makes the failure mode of introducing any new values in the
future really bad, as explained in the documentation being added
here. Instead let's warn and fall back to "auto".

The reason for the !warned++ pattern is when stepping through this in
the debugger I found that git_config_colorbool() is called more than
once on e.g. a "show" if color.ui=foo is set in the config, but
color.ui=bar in the command-line, and would then warn about
both.

Maybe we should warn about both in that case, but I don't know if
there's other cases where not doing this would cause a warning flood,
and in any case the user is unlikely to have such a bad value in
multiple places, so this should be good enough.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt |  5 +++++
 color.c                  | 13 +++++++++++++
 t/t7006-pager.sh         | 16 ++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4767363519..b882a88214 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1291,6 +1291,11 @@ color.ui::
 	want such output to use color when written to the terminal (as
 	determined by a call to `isatty(3)`) or to a pager (unless
 	`color.pager` is set to false).
++
+Setting this to some value unknown to git will warn and fall back to
+`auto`. This is so that new values can be recognized in the future
+without the git configuration file being incompatible between versions
+to the point of most porcelain commands dying on the older version.
 
 column.ui::
 	Specify whether supported commands should output in columns.
diff --git a/color.c b/color.c
index b1c24c69de..e52c6cdd29 100644
--- a/color.c
+++ b/color.c
@@ -311,6 +311,19 @@ int git_config_colorbool(const char *var, const char *value)
 	if (!var)
 		return -1;
 
+	/*
+	 * If future git versions introduce new color.ui settings we
+	 * don't want to die right below when git_config_bool() fails
+	 * to parse them as bool.
+	 */
+	if (git_parse_maybe_bool(value) < 0) {
+		static int warned = 0;
+		if (!warned++)
+			warning(_("unknown value '%s' for '%s', falling back to 'auto'"),
+				value, var);
+		return GIT_COLOR_AUTO;
+	}
+
 	/* Missing or explicit false to turn off colorization */
 	if (!git_config_bool(var, value))
 		return 0;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 7541ba5edb..b16f2ac28b 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -309,6 +309,14 @@ test_expect_success 'no color when stdout is a regular file' '
 	! colorful colorless.log
 '
 
+test_expect_success 'unknown color.ui values default to "auto" (regular file)' '
+	rm -f colorless.log &&
+	test_config color.ui doesnotexist &&
+	git log >colorless.log 2>err &&
+	test_i18ngrep "falling back" err &&
+	! colorful colorless.log
+'
+
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
@@ -316,6 +324,14 @@ test_expect_success TTY 'color when writing to a pager' '
 	colorful paginated.out
 '
 
+test_expect_success TTY 'unknown color.ui values default to "auto" (pager)' '
+	rm -f paginated.out &&
+	test_config color.ui doesnotexist &&
+	test_terminal git log 2>err &&
+	test_i18ngrep "falling back" err &&
+	colorful paginated.out
+'
+
 test_expect_success TTY 'colors are suppressed by color.pager' '
 	rm -f paginated.out &&
 	test_config color.ui auto &&
-- 
2.17.0.290.gded63e768a

