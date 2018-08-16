Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8EE1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbeHPJJu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:09:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34486 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbeHPJJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so14665630wme.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pMQcM9MyHrGmfuLm+iHj2i3DiJfpxgwi2AEkFV3oSo=;
        b=k0wlI6IR3qQ0xzbnN4YVdlO3Woyfly+X8nba95ieWv2nPu4CctGNjEvAJL7vhezhol
         etO4D8My57u+5O5qyASrFpvva5NxAtiQbBkiJRNt8RUzpYPxmawE7XZzAHXXLrnq/cmB
         2X9SPt6ft4hJVbGfpbI88WRfr/FdBEztCku3gDhAPnp3IgOOruYiIB/Bv+9Dw7SbZbR2
         K+DIloB4FoYqH6z1S7u4bSiX/Yxke8ST1PZfyCpR/5Qgos3A3YR4Fm4sfrxiGl5FHiCU
         YGjHS/wLIix51QwfOfVJtjjmJT84EHHwF/Dcns4Wp8rSh08G2mQQ3C41uXCeiRcB4adY
         PkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pMQcM9MyHrGmfuLm+iHj2i3DiJfpxgwi2AEkFV3oSo=;
        b=V9G6Id2ymwaO62JRz/f93uyuxW/qVLXl7sw+FEJ+aA5qfqslBOjrw6zDJ0Xdt2fKKM
         myAY1q4RL7ldjcA3u+C1WuRBdY7aMiUlJ6sJF44IEGgIrKos4gMFJFoXGoSYtU3fqXd1
         LpaQGvNA9DioS87m97QcbIeP4yJEwPzIZUZ7+Q9sQrgvlZSwq7au//xOAivx98kCy229
         DdTwuMTF2lHpW/76YbLVLe+/Zj13zixeIBrRLvx3RQCYnqL+VjDN2p8/UM6veC7WS+yK
         x3nGQhK2Yv+wNlrnpkk6zc8c/DVGjsJkJE7GvNRGY4qJcuHaBbd/nj1eECjgF2IZ1IbK
         uQqg==
X-Gm-Message-State: AOUpUlFrjV+yudFbnDfFIvjEzwgTesNn+74yoCNVo1VZNEfJ1ziBbCvX
        tfU4EEIJKDaVoB+2wnshcivsPAma
X-Google-Smtp-Source: AA+uWPyLtT5k13ahpMuVwg/CwS2zUhIMTe/AQqGpJVQiM1bn2ozSxws6/9Vp843RvAZ/KiQAmkb0Ig==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191-v6mr5514878wmf.103.1534400017594;
        Wed, 15 Aug 2018 23:13:37 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id d8-v6sm22325182wrv.68.2018.08.15.23.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:36 -0700 (PDT)
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
Subject: [PATCH v5 5/7] t: add t5319-delta-islands.sh
Date:   Thu, 16 Aug 2018 08:13:11 +0200
Message-Id: <20180816061313.19298-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.673.gcd86e60100
In-Reply-To: <20180816061313.19298-1-chriscool@tuxfamily.org>
References: <20180816061313.19298-1-chriscool@tuxfamily.org>
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
2.18.0.673.gcd86e60100

