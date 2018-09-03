Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C241F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeICTKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39679 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeICTKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so1421621wmq.4
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OA/wg0bD639PjKWT9LVb3qqMGShnIG2LTupb8OzDWVg=;
        b=igB27RjfaU11GReW8Tmnl5fclrhYYa1+EFc8WHIYAc2/9BQrwGrml64NRQSZEWpKSw
         j969UOhaRVCVWXsiSpKZUY0eHIN2daa7CH/3j8v2g/G3QTqWmc82ALIPCdxDMVLWNgE8
         vvzD7BGuDCFvLBkXue9IsZTFdqPXkjJnzsojw+tdxrD3XteoT93TSPIlbFhyq/KhaRd3
         O1F4Ir88YeGukr22kw5xtoWYkFrr+7SXEucsempg8x8XegQGGhcvXNV0seHHnJr9jSoL
         wBUxLtIdCd4bbc1pcMzWekiIOkzygEZ3XL/eDtAe1EpjUA9tdgYqKYcgxNxQ/VbW5U0f
         2bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OA/wg0bD639PjKWT9LVb3qqMGShnIG2LTupb8OzDWVg=;
        b=Mg0mjqNLBxXTGKhTcEdsG5Lsh5PpaXVyBKb/0tR3MPRe+AOkLDQJvp9wAnc9tn2KJn
         BIGeTe513ugAXagbfH6gwhBoMY8ZahvmEErZOuBdF24aLrNWROd4keMaZCIoDhk8JDqX
         genqbf6d5XGVkn8OF7zGJF9/HaA6G5n4AIDWC0/ZJj9pT+kMqldahguX3AoWseZaGowC
         s4FstpWhcJHDAUAqHHr2OHjxpshmeu4B8YpOf+KBwt2fFbKmpLBSslWNEjtplCa0ns9l
         yG7teDKrE1dl8RB9/n2LaO36Uz2Dmmv24Tjxo0u2dL1p962ILx8/OiIrhfmVayGh7pmb
         xp7g==
X-Gm-Message-State: APzg51DXtZdyTnap3ZcQOqMWOrFDwL+FsBBVvnRB9KE8swg4zjtiJoRE
        nxh64XaGNeQ3LKCRMBhjxT2zpaC46Gg=
X-Google-Smtp-Source: ANB0VdYxbZGABNDsce+ubv6GCP7DWnufI+R+H+g3EsUrI5mHoYuTP/WaozgihOrXD/LMdUyd/dkESw==
X-Received: by 2002:a1c:1ec5:: with SMTP id e188-v6mr5438660wme.1.1535986189674;
        Mon, 03 Sep 2018 07:49:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/10] fsck: add a performance test for skipList
Date:   Mon,  3 Sep 2018 14:49:25 +0000
Message-Id: <20180903144928.30691-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

Create a performance test to see how the skipList implementation
performs. First we setup N bad commits, then we see how progressively
working our way up to 0..N in increments of 10x does. I.e. the
needle(s) in the haystack get progressively more numerous.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p1451-fsck-skip-list.sh | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/perf/p1451-fsck-skip-list.sh

diff --git a/t/perf/p1451-fsck-skip-list.sh b/t/perf/p1451-fsck-skip-list.sh
new file mode 100755
index 0000000000..c2b97d2487
--- /dev/null
+++ b/t/perf/p1451-fsck-skip-list.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='Test fsck skipList performance'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+n=1000000
+
+test_expect_success "setup $n bad commits" '
+	for i in $(test_seq 1 $n)
+	do
+		echo "commit refs/heads/master" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$i.Q." &&
+		echo "EOF"
+	done | q_to_nul | git fast-import
+'
+
+skip=0
+while test $skip -le $n
+do
+	test_expect_success "create skipList for $skip bad commits" '
+		git log --format=%H --max-count=$skip |
+		sort >skiplist
+	'
+
+	test_perf "fsck with $skip skipped bad commits" '
+		git -c fsck.skipList=skiplist fsck
+	'
+
+	case $skip in
+	0) skip=1 ;;
+	*) skip=${skip}0 ;;
+	esac
+done
+
+test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

