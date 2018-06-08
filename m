Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86CCF1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeFHWmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34376 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so3878585wmc.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQ/tCriA40J97JM0MXV4Nj2QzoqX98mHVWxwKH559Jk=;
        b=mbDqRgc6oGo3c3uxGVNHCovcghS10EYM7ivlaSSb7qXRon0MQ7OAGpSwM/4SRwEouV
         mVwIncCx//e6ko2kU2v1LG6QQeUqSuAN6BWZGL8mVhAu3+/Jw6VBaSOMdBHuW+LjEVsG
         kh+CzE7NIzmLyHUiyHSPt5ot8aHrWXsO1J8teYNYN0IE/cZEWtrVM2s+gcBY6iH8tcTL
         MxeXCBPcs5mElCjPozsbPLOYLwI/L8NYeJgzZTFEmasDJLDhi0FVylv49w8HoT2/3z9a
         /x86AVDaNQBUXk90xQnOJRDs28lqSV6rVeT5qjL+fmZraqINPVEQmjgREgMIX0rpfCa/
         2G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQ/tCriA40J97JM0MXV4Nj2QzoqX98mHVWxwKH559Jk=;
        b=mkVgquf0Vkfgn9iZufxluMpaEjkscdCurNEjupjO2MEVTvGPTSksyaeTS42c1u+MvJ
         c/AWkZwRJQORiqquXzdD6pB7gX0DaGDct7Cln26yBBxQYEuQJbv1ULQdkibxQqj70uF2
         3fZJ+FtSvgV8ktWJgV2CztXSm/PA8vRMghCnoRvyuek69QNXfHPK6PxO4dd1JhhcQn+s
         Fc43BrTCqRONyknEtHq/cvm9PQxdEvUQBtyH+FtVrR0zTiOr1VWqJupCTf6QPbjV2TQN
         UsjT1sJkcdJNN7EowRQCwcdgmSqOel7I0C9q6IEnzB173N7E3YGLeCn6/8PnvCo3SQrJ
         UVZg==
X-Gm-Message-State: APt69E3cPTuz6CS/thiiR3wpEnd9kv/gKgMx9l2dS1ND9yHCmStzrt/J
        o2D2y+24+eXSUQG38LxNugcy0mxJ
X-Google-Smtp-Source: ADUXVKKbDfDRA5BDG9UWW8k8civY1Eqais/45tfcMgVrVt8zHffYVP25G5u69DzGfFpW/iAV4hq0pQ==
X-Received: by 2002:a1c:630b:: with SMTP id x11-v6mr2755452wmb.104.1528497734536;
        Fri, 08 Jun 2018 15:42:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/20] abbrev: add a core.validateAbbrev setting
Date:   Fri,  8 Jun 2018 22:41:36 +0000
Message-Id: <20180608224136.20220-21-avarab@gmail.com>
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

Operations that need to abbreviate a lot of SHA-1s such as 'git log
--oneline' experience degraded performance when traversing a lot of
packs. See [1] and [2] for some relevant performance numbers.

One way to address this is something like the MIDX to make looking up
the SHA-1s cheaper.

This change adds an alternate method of achieving some of the same
ends (but possibly not all, see [3] and replies to the original thread
at [1]).

Instead of trying really hard to find an unambiguous SHA-1 we can with
core.validateAbbrev=false, and preferably combined with the new
support for relative core.abbrev values (such as +4) unconditionally
print a short SHA-1 without doing any disambiguation check. I.e. it
allows for picking a trade-off between performance, and the odds that
future or remote (or current and local) short SHA-1 will be ambiguous.

With the included performance test my git.git repacked with with `git
repack -A -d --max-pack-size=X` gives the following results against
git.git itself with X=64M:

    Test                                        HEAD~             HEAD
    ------------------------------------------------------------------------------------
    0014.1: git log --oneline --raw --parents   2.53(2.48+0.05)   2.20(2.14+0.05) -13.0%

With one big pack -7.6%, and with 16M packs -23.8%.

1. https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/
2. https://public-inbox.org/git/20180607140338.32440-1-dstolee@microsoft.com/
3. https://public-inbox.org/git/87lgbsz61p.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt            | 43 ++++++++++++++++++++++++++
 cache.h                             |  1 +
 config.c                            |  7 +++++
 environment.c                       |  1 +
 sha1-name.c                         |  4 +++
 t/perf/p0014-abbrev.sh              | 13 ++++++++
 t/t1512-rev-parse-disambiguation.sh | 47 +++++++++++++++++++++++++++++
 7 files changed, 116 insertions(+)
 create mode 100755 t/perf/p0014-abbrev.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abf07be7b6..df31d1351f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -925,6 +925,49 @@ means to add or subtract N characters from the SHA-1 that Git would
 otherwise print, this allows for producing more future-proof SHA-1s
 for use within a given project, while adjusting the value for the
 current approximate number of objects.
++
+This is especially useful in combination with the
+`core.validateAbbrev` setting, or to get more future-proof hashes to
+reference in the future in a repository whose number of objects is
+expected to grow.
+
+core.validateAbbrev::
+	If set to false (true by default) don't do any validation when
+	printing abbreviated object names to see if they're really
+	unique. This makes printing objects more performant at the
+	cost of potentially printing object names that aren't unique
+	within the current repository.
++
+When printing abbreviated object names Git needs to look through the
+local object store. This is an `O(log N)` operation assuming all the
+objects are in a single pack file, but `X * O(log N)` given `X` pack
+files, which can get expensive on some larger repositories.
++
+This setting changes that to `O(1)`, but with the trade-off that
+depending on the value of `core.abbrev` we may be printing abbreviated
+hashes that collide. Too see how likely this is, try running:
++
+-----------------------------------------------------------------------------------------------------------
+git log --all --pretty=format:%h --abbrev=4 | perl -nE 'chomp; say length' | sort | uniq -c | sort -nr
+-----------------------------------------------------------------------------------------------------------
++
+This shows how many commits were found at each abbreviation length. On
+linux.git in June 2018 this shows a bit more than 750,000 commits,
+with just 4 needing 11 characters to be fully abbreviated, and the
+default heuristic picks a length of 12.
++
+Even without `core.validateAbbrev=false` the results abbreviation
+already a bit of a probability game. They're guaranteed at the moment
+of generation, but as more objects are added, ambiguities may be
+introduced. Likewise, what's unambiguous for you may not be for
+somebody else you're communicating with, if they have their own clone.
++
+Therefore the default of `core.validateAbbrev=true` may not save you
+in practice if you're sharing the SHA-1 or noting it now to use after
+a `git fetch`. You may be better off setting `core.abbrev` to
+e.g. `+2` to add 2 extra characters to the SHA-1, and possibly combine
+that with `core.validateAbbrev=false` to get a reasonable trade-off
+between safety and performance.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/cache.h b/cache.h
index 0fb4211804..6dc5af9482 100644
--- a/cache.h
+++ b/cache.h
@@ -773,6 +773,7 @@ extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int default_abbrev_relative;
+extern int validate_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index cd95c6bdfb..fd11e1047d 100644
--- a/config.c
+++ b/config.c
@@ -1146,6 +1146,13 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.validateabbrev")) {
+		if (!value)
+			return config_error_nonbool(var);
+		validate_abbrev =  git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index 0d48d52fba..4a24d8126b 100644
--- a/environment.c
+++ b/environment.c
@@ -23,6 +23,7 @@ int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int default_abbrev_relative = 0;
+int validate_abbrev = 1;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/sha1-name.c b/sha1-name.c
index 75f1bef7d1..57dc782782 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -612,6 +612,10 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 		}
 		len += dar;
 	}
+	if (!validate_abbrev) {
+		hex[len] = 0;
+		return len;
+	}
 
 	mad.init_len = len;
 	mad.cur_len = len;
diff --git a/t/perf/p0014-abbrev.sh b/t/perf/p0014-abbrev.sh
new file mode 100755
index 0000000000..15c3764265
--- /dev/null
+++ b/t/perf/p0014-abbrev.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+test_description="Tests core.validateAbbrev performance"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_perf 'git log --oneline --raw --parents' '
+	git -c core.abbrev=15 -c core.validateAbbrev=false log --oneline --raw --parents >/dev/null
+'
+
+test_done
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 96fe3754c8..89565af508 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -232,6 +232,53 @@ test_expect_success 'more history' '
 
 '
 
+test_expect_success 'ambiguous objects and core.abbrev' '
+	cat >expected <<-\EOF &&
+	00000000006
+	0000000005
+	00000000008
+	000000000004
+	0000000000e
+	EOF
+	git -c core.abbrev=4 log --pretty=tformat:%h >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ambiguous objects and core.validateAbbrev' '
+	git -c core.abbrev=4 -c core.validateabbrev=true log --pretty=tformat:%h >actual &&
+	test_cmp expected actual &&
+
+	cat >expected <<-\EOF &&
+	0000
+	0000
+	0000
+	0000
+	0000
+	EOF
+	git -c core.abbrev=4 -c core.validateabbrev=false log --pretty=tformat:%h >actual &&
+	test_cmp expected actual &&
+
+	cat >expected <<-\EOF &&
+	00000000006
+	0000000005b
+	00000000008
+	000000000004
+	0000000000e
+	EOF
+	git -c core.abbrev=+4 log --pretty=tformat:%h >actual &&
+	test_cmp expected actual &&
+
+	cat >expected <<-\EOF &&
+	00000000006
+	0000000005b
+	00000000008
+	00000000000
+	0000000000e
+	EOF
+	git -c core.abbrev=+4 -c core.validateabbrev=false log --pretty=tformat:%h >actual &&
+	test_cmp expected actual
+'
+
 test_expect_failure 'parse describe name taking advantage of generation' '
 	# ambiguous at the object name level, but there is only one
 	# such commit at generation 0
-- 
2.17.0.290.gded63e768a

