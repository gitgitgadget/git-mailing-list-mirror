Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DA21F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeDHJfg (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:35:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37928 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeDHJfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:35:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id m13so5319002wrj.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OC57oxEdyiOGtKAzKPls7exYP/nRP6/no3Ul3RYv/v0=;
        b=Ad6JGTDbTI071diIl182rLMyXfHOt915wqZtsJIURkSF7fTAQ5IWx6hZMir0Br7qBF
         RJ5oPBiCaxeaFDGzPhfprTrHJKzdpzAqW50Vyw+3AM+Hy+CsagFX3OUSCno9Ft2bMOrJ
         Ex5/8TJXEALyayz2rQaK5JOp7WxtSZ34BstbqOBWJW1BWjcevu+81tzD5FQ1BeFZJCQf
         R/5eIVc+smiBYXm2rW5VgCe9yDlScgKD+tQIKzAQF+HvA2RUrgpnKSJnnWm9ghHSlvQ9
         tj2mVvHAH7txHJ65z9xidy8bMykBLy3hUoOIWtS5s+P2huK9uejkthGaWn4iipMtTCQO
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OC57oxEdyiOGtKAzKPls7exYP/nRP6/no3Ul3RYv/v0=;
        b=YORdb89XmBfxXu1qV72oR8ZyvSYK3E0g4ni+4kepGLm7uxeootGZPQkDsjlA8JXXrq
         CajutyI9nMWWRnsGdMH+rwX5ZGEZFiGtBxW52KotANVCCOMY6GCU4ICAMSQWhfHgeN5O
         zKwwhLppTBy59FpInXttai8zDkgmBb1mJ2buHOe/cYBixuFWJRo2mpjkqS6lbqIovWP/
         tc7bhDetpu2no64jMB9ccNdXN+VXiV0peDIb44k364VgCjGVC6uRlAvaxx7u5bk3dVsD
         1UoQNcG32CjNSpcuX3y/y+lh3ZwQxyUOglsZuezv5XEpUJ2+NwDH64KsOGBvWZPz6Ap5
         RleA==
X-Gm-Message-State: AElRT7E4g4VkY4rbzicT8IJ6kPJ7M80ldIu2KTd9XZeDYWvgaqa399ra
        CGT+IRTeBpETfyL0OjlSQHnsv9oc
X-Google-Smtp-Source: AIpwx4+zo6u+llQz7sxcrCrjoSdyPk46Q0KC6/ct1GQkk9dxfY7azp9Ga9utDuqUL1vCTizB8dtrXg==
X-Received: by 10.223.181.149 with SMTP id c21mr24734933wre.233.1523180132889;
        Sun, 08 Apr 2018 02:35:32 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v75sm13910014wrc.90.2018.04.08.02.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 02:35:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 2/2] t/perf: add scripts to bisect performance regressions
Date:   Sun,  8 Apr 2018 11:35:13 +0200
Message-Id: <20180408093513.17769-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
In-Reply-To: <20180408093513.17769-1-chriscool@tuxfamily.org>
References: <20180408093513.17769-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new bisect_regression script can be used to automatically bisect
performance regressions. It will pass the new bisect_run_script to
`git bisect run`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/bisect_regression | 73 ++++++++++++++++++++++++++++++++++++++++
 t/perf/bisect_run_script | 47 ++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100755 t/perf/bisect_regression
 create mode 100755 t/perf/bisect_run_script

diff --git a/t/perf/bisect_regression b/t/perf/bisect_regression
new file mode 100755
index 0000000000..a94d9955d0
--- /dev/null
+++ b/t/perf/bisect_regression
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+# Read a line coming from `./aggregate.perl --sort-by regression ...`
+# and automatically bisect to find the commit responsible for the
+# performance regression.
+#
+# Lines from `./aggregate.perl --sort-by regression ...` look like:
+#
+# +100.0% p7821-grep-engines-fixed.1 0.04(0.10+0.03) 0.08(0.11+0.08) v2.14.3 v2.15.1
+# +33.3% p7820-grep-engines.1 0.03(0.08+0.02) 0.04(0.08+0.02) v2.14.3 v2.15.1
+#
+
+die () {
+	echo >&2 "error: $*"
+	exit 1
+}
+
+while [ $# -gt 0 ]; do
+	arg="$1"
+	case "$arg" in
+	--help)
+		echo "usage: $0 [--config file] [--subsection subsection]"
+		exit 0
+		;;
+	--config)
+		shift
+		GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")
+		export GIT_PERF_CONFIG_FILE
+		shift ;;
+	--subsection)
+		shift
+		GIT_PERF_SUBSECTION="$1"
+		export GIT_PERF_SUBSECTION
+		shift ;;
+	--*)
+		die "unrecognised option: '$arg'" ;;
+	*)
+		die "unknown argument '$arg'"
+		;;
+	esac
+done
+
+read -r regression subtest oldtime newtime oldrev newrev
+
+test_script=$(echo "$subtest" | sed -e 's/\(.*\)\.[0-9]*$/\1.sh/')
+test_number=$(echo "$subtest" | sed -e 's/.*\.\([0-9]*\)$/\1/')
+
+# oldtime and newtime are decimal number, not integers
+
+oldtime=$(echo "$oldtime" | sed -e 's/^\([0-9]\+\.[0-9]\+\).*$/\1/')
+newtime=$(echo "$newtime" | sed -e 's/^\([0-9]\+\.[0-9]\+\).*$/\1/')
+
+test $(echo "$newtime" "$oldtime" | awk '{ print ($1 > $2) }') = 1 ||
+	die "New time '$newtime' shoud be greater than old time '$oldtime'"
+
+tmpdir=$(mktemp -d -t bisect_regression_XXXXXX) || die "Failed to create temp directory"
+echo "$oldtime" >"$tmpdir/oldtime" || die "Failed to write to '$tmpdir/oldtime'"
+echo "$newtime" >"$tmpdir/newtime" || die "Failed to write to '$tmpdir/newtime'"
+
+# Bisecting must be performed from the top level directory (even with --no-checkout)
+(
+	toplevel_dir=$(git rev-parse --show-toplevel) || die "Failed to find top level directory"
+	cd "$toplevel_dir" || die "Failed to cd into top level directory '$toplevel_dir'"
+
+	git bisect start --no-checkout "$newrev" "$oldrev" || die "Failed to start bisecting"
+
+	git bisect run t/perf/bisect_run_script "$test_script" "$test_number" "$tmpdir"
+	res="$?"
+
+	git bisect reset
+
+	exit "$res"
+)
diff --git a/t/perf/bisect_run_script b/t/perf/bisect_run_script
new file mode 100755
index 0000000000..038255df4b
--- /dev/null
+++ b/t/perf/bisect_run_script
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+script="$1"
+test_number="$2"
+info_dir="$3"
+
+# This aborts the bisection immediately
+die () {
+	echo >&2 "error: $*"
+	exit 255
+}
+
+bisect_head=$(git rev-parse --verify BISECT_HEAD) || die "Failed to find BISECT_HEAD ref"
+
+script_number=$(echo "$script" | sed -e "s/^p\([0-9]*\).*\$/\1/") || die "Failed to get script number for '$script'"
+
+oldtime=$(cat "$info_dir/oldtime") || die "Failed to access '$info_dir/oldtime'"
+newtime=$(cat "$info_dir/newtime") || die "Failed to access '$info_dir/newtime'"
+
+cd t/perf || die "Failed to cd into 't/perf'"
+
+result_file="$info_dir/perf_${script_number}_${bisect_head}_results.txt"
+
+GIT_PERF_DIRS_OR_REVS="$bisect_head"
+export GIT_PERF_DIRS_OR_REVS
+
+./run "$script" >"$result_file" 2>&1 || die "Failed to run perf test '$script'"
+
+rtime=$(sed -n "s/^$script_number\.$test_number:.*\([0-9]\+\.[0-9]\+\)(.*).*\$/\1/p" "$result_file")
+
+echo "newtime: $newtime"
+echo "rtime: $rtime"
+echo "oldtime: $oldtime"
+
+# Compare ($newtime - $rtime) with ($rtime - $oldtime)
+# Times are decimal number, not integers
+
+if test $(echo "$newtime" "$rtime" "$oldtime" | awk '{ print ($1 - $2 > $2 - $3) }') = 1
+then
+	# Current commit is considered "good/old"
+	echo "$rtime" >"$info_dir/oldtime"
+	exit 0
+else
+	# Current commit is considered "bad/new"
+	echo "$rtime" >"$info_dir/newtime"
+	exit 1
+fi
-- 
2.17.0.rc1.36.g098d832c9.dirty

