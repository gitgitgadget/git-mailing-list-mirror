Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5BD1F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEGKyw (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfEGKyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id a12so11560115wrn.4
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Zkkgp/ob9zkgDuNnkdRdtmUJHUeS94yO2FeDQ/OFv0=;
        b=YIUOO043SdUG/VCIYYD4hVW4NVv9CBATe99H6b03WSmevGqBLIrEz0jS1gLMsrEJUr
         5M9TUvVNwsEDuJv4OZUqAnVjt3N4Ik9Ey/iimuDDurQhbE3jS6EKv4DUazuHcTGHJKN+
         KcHTmxv+lcqCc19IZbbhfJ8wyySv9fnHDdeYCuoZfaCTCiKJVQyVe29SYk2rqf5PIdeB
         iqGScedO5fDryGJ1QN4ERdmjkzFMxjd0L4GXnVmI1QJOuIjpufHWMrDXGva1EV45vjiw
         JTNSC2t1L2FYEGxre0+6hwEYs7rxdFGn1ImBMV1s4QTFdXHCdZlzfYUGpr3ChhtjrGAm
         Ll/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Zkkgp/ob9zkgDuNnkdRdtmUJHUeS94yO2FeDQ/OFv0=;
        b=ik2AY1p5h15LPW9LyvWu+fVrAJauBgq+ucxxls2wII+zsDYiyqWfYbYjUZLa/WqbWA
         BvzHCIml0nh/qRHaEzQ0p3CV0b1pl3SWSo7HfU6VFZMRYzRBWiOkfJqmlQ1GIAmEhZWz
         KTHlITTrOSQsYpOSR/FhzCjNoBIIdzAiUbe3JLOpeJZObQPB2blGWBo0JGKLusIN/B4s
         v/kX6DmSC1j2rDgYYNKcXh2L1zEL1apQKwMRR33In71oGrgPVCwfq9a7coFV8vqWTwYI
         Mw9GOo1lfFytfQg4erJoLlH5pNF8f0pngYXpbqK6ilwXiHWZdrUwwr2001/IIQnzEKLS
         Ucuw==
X-Gm-Message-State: APjAAAX6qdrfurvy1JL9gw1H/Y6T15OLKe8d0wjUINug6Qdd35eN8XLm
        AEU/o4HFY+1YSE4pL+aAn8/nsafu+eE=
X-Google-Smtp-Source: APXvYqz35Zg66vYG8dyB6nCrQ/7CT3N+AiyDT/G4bjiHn+PrVc4E3HYYrn3C3a1IRn1o3PrRZYUWuA==
X-Received: by 2002:adf:e712:: with SMTP id c18mr6452576wrm.202.1557226488535;
        Tue, 07 May 2019 03:54:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] perf-lib.sh: make "./run <revisions>" use the correct gits
Date:   Tue,  7 May 2019 12:54:31 +0200
Message-Id: <20190507105434.9600-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a really bad regression in 0baf78e7bc ("perf-lib.sh: rely on
test-lib.sh for --tee handling", 2019-03-15). Since that change all
runs of different <revisions> of git have used the git found in the
user's $PATH, e.g. /usr/bin/git instead of the <revision> we just
built and wanted to performance test.

The problem starts with GIT_TEST_INSTALLED not working like our
non-perf tests with the "run" script. I.e. you can't run performance
tests against a given installed git. Instead we expect to use it
ourselves to point GIT_TEST_INSTALLED to the <revision> we just built.

However, we had been relying on '$(cd "$GIT_TEST_INSTALLED" && pwd)'
to resolve that relative $GIT_TEST_INSTALLED to an absolute
path *before* test-lib.sh was loaded, in cases where it was
e.g. "build/<rev>/bin-wrappers" and we wanted "<abs_path>build/...".

This change post-dates another proposed solution by a few days[1], I
didn't notice that version when I initially wrote this. I'm doing the
most minimal thing to solve the regression here, a follow-up change
will move this result prefix selection logic entirely into the "run"
script.

This makes e.g. these cases all work:

    ./run . $PWD/../../ origin/master origin/next HEAD -- <tests>

As well as just a plain one-off:

    ./run <tests>

And, since we're passing down the new GIT_PERF_DIR_MYDIR_REL we make
sure the bug relating to aggregate.perl not finding our files as
described in 0baf78e7bc doesn't happen again.

What *doesn't* work is setting GIT_TEST_INSTALLED to a relative path,
this will subtly fail in test-lib.sh. This has always been the case
even before 0baf78e7bc, and as documented in t/README the
GIT_TEST_INSTALLED variable should be set to an absolute path (needs
to be set "to the bindir", which is always absolute), and the "perf"
framework expects to munge it itself.

Perhaps that should be dealt with in the future to allow manually
setting GIT_TEST_INSTALLED, but as a preceding commit showed the user
can just use the "run" script, which'll also pick the right output
directory for the test results as expected by aggregate.perl.

1. https://public-inbox.org/git/20190502222409.GA15631@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/perf-lib.sh | 4 ++++
 t/perf/run         | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 169f92eae3..b15ee1d262 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
 if test -z "$GIT_TEST_INSTALLED"; then
 	perf_results_prefix=
 else
+	if test -n "$GIT_PERF_DIR_MYDIR_REL"
+	then
+		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
+	fi
 	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
 	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
 fi
diff --git a/t/perf/run b/t/perf/run
index 9aaa733c77..0a7c8744ab 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -91,10 +91,14 @@ run_dirs_helper () {
 	if test "$mydir" = .; then
 		unset GIT_TEST_INSTALLED
 	else
-		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
+		GIT_PERF_DIR_MYDIR_REL=$mydir
+		GIT_PERF_DIR_MYDIR_ABS=$(cd $mydir && pwd)
+		export GIT_PERF_DIR_MYDIR_REL GIT_PERF_DIR_MYDIR_ABS
+
+		GIT_TEST_INSTALLED="$GIT_PERF_DIR_MYDIR_ABS/bin-wrappers"
 		# Older versions of git lacked bin-wrappers; fallback to the
 		# files in the root.
-		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$mydir
+		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_ABS
 		export GIT_TEST_INSTALLED
 	fi
 	run_one_dir "$@"
-- 
2.21.0.593.g511ec345e18

