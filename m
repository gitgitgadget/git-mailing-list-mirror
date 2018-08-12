Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635651F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeHLHtB (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:49:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55531 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbeHLHtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:49:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so5595615wmc.5
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fE8kd2x0lPTeUvSPZCTbaK2zYzKMTUanUe+E8PXesk8=;
        b=qnY7SE+r/6aWJ7H+qKLgFj0kK9ojohtcgg8TAyh59j4JPoOYT3CI3fZowFLtaz5gbn
         Vr/ygT5EOYIKmyXUiU4bd1SjwEFSIxMRQ8lpsvmEDKs/xcE4sUicR9beID3yrL/Eag6J
         Y3AMHuVy0I6ieLxmTeIGhM2jiU8hlntwyPuW43sYCa5HUzWcURDLZkjtVodNGTY7P7qm
         1V2DViXMljpGZdYupGz0lr6O0CrDgftv6LrEod3TcKnb5O/do6Fgq+9sjWrj8M+awOIc
         0IOBgf/DUFCh74nhQ2qK6pga0MzGi+dWb6nl5O7IWTh7uH0s2tuZBDUJ6qYh6yvcNdrt
         UhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fE8kd2x0lPTeUvSPZCTbaK2zYzKMTUanUe+E8PXesk8=;
        b=GQ6zE5sAjAV60k92/xm11psr3obvQ0/Qv+EAKexldwq7Jk7tLstgJ3b3isck4R0XGz
         AKJEdeFXvqSFjQgxp3fim2u7uiL7E4acgIP2oKnoieXlEN9neJW0+q2NxuNaJ6SuVQz6
         A7HulIK7VetAOvAPeFBUxGVRihejzFompDXmg1AVXxnElWUuqS+bxpkVYzq4hRIjynVK
         gz8DU//KSOGus0ZBsJ7RnS7vwLkBHxG/RxM3+crYSSBWZZWocquEuNtzuM8eIyT9aZaK
         JLFNtn467ODxPFds0ICelaOrfjGV53r10zgyQ2XCaoZZF+PeK7UVJAOrpAccah1C2OXy
         Ho6g==
X-Gm-Message-State: AOUpUlHoGc71M4CFF+PnZet1svWw1BjoFDb1Ccvg8QWwo2rSwQmEPcyf
        5kIPGqy3yHzLUbXiWolDhjm09wes
X-Google-Smtp-Source: AA+uWPyXXFEzXBWVqnZpnHYQwg3N8s+ctmFB5+OeQn7CDiLhbLfr01g8TvtIOzEQ5MZ2VF9knzM14A==
X-Received: by 2002:a1c:e904:: with SMTP id q4-v6mr5185764wmc.154.1534050737710;
        Sat, 11 Aug 2018 22:12:17 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v4 5/7] t: add t5319-delta-islands.sh
Date:   Sun, 12 Aug 2018 07:11:49 +0200
Message-Id: <20180812051151.6425-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
In-Reply-To: <20180812051151.6425-1-chriscool@tuxfamily.org>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5319-delta-islands.sh | 143 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100755 t/t5319-delta-islands.sh

diff --git a/t/t5319-delta-islands.sh b/t/t5319-delta-islands.sh
new file mode 100755
index 0000000000..fea92a5777
--- /dev/null
+++ b/t/t5319-delta-islands.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+
+test_description='exercise delta islands'
+. ./test-lib.sh
+
+# returns true iff $1 is a delta based on $2
+is_delta_base () {
+	delta_base=$(echo "$1" | git cat-file --batch-check='%(deltabase)') &&
+	echo >&2 "$1 has base $delta_base" &&
+	test "$delta_base" = "$2"
+}
+
+# generate a commit on branch $1 with a single file, "file", whose
+# content is mostly based on the seed $2, but with a unique bit
+# of content $3 appended. This should allow us to see whether
+# blobs of different refs delta against each other.
+commit() {
+	blob=$({ test-tool genrandom "$2" 10240 && echo "$3"; } |
+	       git hash-object -w --stdin) &&
+	tree=$(printf '100644 blob %s\tfile\n' "$blob" | git mktree) &&
+	commit=$(echo "$2-$3" | git commit-tree "$tree" ${4:+-p "$4"}) &&
+	git update-ref "refs/heads/$1" "$commit" &&
+	eval "$1"'=$(git rev-parse $1:file)' &&
+	eval "echo >&2 $1=\$$1"
+}
+
+test_expect_success 'setup commits' '
+	commit one seed 1 &&
+	commit two seed 12
+'
+
+# Note: This is heavily dependent on the "prefer larger objects as base"
+# heuristic.
+test_expect_success 'vanilla repack deltas one against two' '
+	git repack -adf &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island repack with no island definition is vanilla' '
+	git repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island repack with no matches is vanilla' '
+	git -c "pack.island=refs/foo" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'separate islands disallows delta' '
+	git -c "pack.island=refs/heads/(.*)" repack -adfi &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'same island allows delta' '
+	git -c "pack.island=refs/heads" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'coalesce same-named islands' '
+	git \
+		-c "pack.island=refs/(.*)/one" \
+		-c "pack.island=refs/(.*)/two" \
+		repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island restrictions drop reused deltas' '
+	git repack -adfi &&
+	is_delta_base $one $two &&
+	git -c "pack.island=refs/heads/(.*)" repack -adi &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'island regexes are left-anchored' '
+	git -c "pack.island=heads/(.*)" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island regexes follow last-one-wins scheme' '
+	git \
+		-c "pack.island=refs/heads/(.*)" \
+		-c "pack.island=refs/heads/" \
+		repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'setup shared history' '
+	commit root shared root &&
+	commit one shared 1 root &&
+	commit two shared 12-long root
+'
+
+# We know that $two will be preferred as a base from $one,
+# because we can transform it with a pure deletion.
+#
+# We also expect $root as a delta against $two by the "longest is base" rule.
+test_expect_success 'vanilla delta goes between branches' '
+	git repack -adf &&
+	is_delta_base $one $two &&
+	is_delta_base $root $two
+'
+
+# Here we should allow $one to base itself on $root; even though
+# they are in different islands, the objects in $root are in a superset
+# of islands compared to those in $one.
+#
+# Similarly, $two can delta against $root by our rules. And unlike $one,
+# in which we are just allowing it, the island rules actually put $root
+# as a possible base for $two, which it would not otherwise be (due to the size
+# sorting).
+test_expect_success 'deltas allowed against superset islands' '
+	git -c "pack.island=refs/heads/(.*)" repack -adfi &&
+	is_delta_base $one $root &&
+	is_delta_base $two $root
+'
+
+# We are going to test the packfile order here, so we again have to make some
+# assumptions. We assume that "$root", as part of our core "one", must come
+# before "$two". This should be guaranteed by the island code. However, for
+# this test to fail without islands, we are also assuming that it would not
+# otherwise do so. This is true by the current write order, which will put
+# commits (and their contents) before their parents.
+test_expect_success 'island core places core objects first' '
+	cat >expect <<-EOF &&
+	$root
+	$two
+	EOF
+	git -c "pack.island=refs/heads/(.*)" \
+	    -c "pack.islandcore=one" \
+	    repack -adfi &&
+	git verify-pack -v .git/objects/pack/*.pack |
+	cut -d" " -f1 |
+	egrep "$root|$two" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unmatched island core is not fatal' '
+	git -c "pack.islandcore=one" repack -adfi
+'
+
+test_done
-- 
2.18.0.554.gdb07901040.dirty

