Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9EE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeKLXUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:20:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39753 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbeKLXUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:20:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so8133824wmc.4
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puP2AsLjKfO1dcYGA/lYiG6mn1gq2I/toP1Cr6t+PcU=;
        b=EIExVwHIgYS5WDDcHIPXZxlQ1vIzlgb9RixLmhX4KAmrR6J+6p3L3KFqKB5PD5JXim
         TK/6HU3Mk5tDa6RKOV46AuLl7nF00Hf1cWYOSEFj7Yle0DtRJo70rTDGjrh7gHrGebXJ
         juI/98OLqxAJ4yFMK39Q/inTWjVie3WP7n7zwnoze7pNk62kQuAYaaDe7g47cpPDwPV/
         cJrmJuGu7ojBzytUcnNvdrTG4+jKisxfSHSIKydL0bPbLQo1cLDA5mtz846yZQe33l0j
         PGrUKvRYuiHlNVmvUJsaTpVe8G+gNTGspjhDf5CGOYfgnyFMFXcq5GDRUnlC/NejQSaM
         ETxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puP2AsLjKfO1dcYGA/lYiG6mn1gq2I/toP1Cr6t+PcU=;
        b=n6yolFZo/DfzyR6DqJlj5KxJcEKx8tzmc6tlS60rvr+Zgev7XxPqaJzaU+d6NdZNyQ
         mbyOGHQyft8MrXMLFPYTPqEgQrQo4J5p3MGCofxf/fuwqC8XD/RnYZrODDrcMTS7uaE+
         oGO/VV3jm+RKaOA2paICyUwBNqkx8KJymsrQR0CnhDJ7UhzB7eUUj6t1EomAusroHoU6
         KRcYsU6KugTWR8Fn5iErcz3hNNwO+OX6+vXyWGLUlcrwbfTija8ZZ47ARNJ+vkC6ki8w
         uEZ9deVZuUHeHuQm1rSyPxxI1L798b3zXvlf69e1eqSoHi2mjpO+HsvD9EDRM9MY8ZLW
         X3Sw==
X-Gm-Message-State: AGRZ1gKX9+4325VUpVdTIHmRfrZ1Qn6Jat+j7QDLzrL/bq7puMXV8TUw
        lhxUYHPru37+ARWadHFjjURGwXzMKaQ=
X-Google-Smtp-Source: AJdET5fy6W9TBgrZOdE3wkw6O4uQl9eCHPOMWiNWQ3QwP3MwyH+Z+1LysiKTzvfARFnIcNnGhnGkpg==
X-Received: by 2002:a1c:c543:: with SMTP id v64mr1215526wmf.123.1542029201262;
        Mon, 12 Nov 2018 05:26:41 -0800 (PST)
Received: from localhost.localdomain (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id 74-v6sm12405818wmn.42.2018.11.12.05.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:26:40 -0800 (PST)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] refs: show --exclude failure with --branches/tags/remotes=glob
Date:   Mon, 12 Nov 2018 13:25:43 +0000
Message-Id: <20181112132545.31092-2-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112132545.31092-1-rafa.almas@gmail.com>
References: <20181112132545.31092-1-rafa.almas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation of `--exclude=` option from rev-list and rev-parse
explicitly states that exclude patterns *should not* start with 'refs/'
when used with `--branches`, `--tags` or `--remotes`.

However, following this advice results in refereces not being excluded
if the next `--branches`, `--tags`, `--remotes` use the optional
inclusive glob.

Demonstrate this failure.

Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---
 t/t6018-rev-list-glob.sh | 60 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 0bf10d0686..8e2b136356 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -36,7 +36,13 @@ test_expect_success 'setup' '
 	git tag foo/bar master &&
 	commit master3 &&
 	git update-ref refs/remotes/foo/baz master &&
-	commit master4
+	commit master4 &&
+	git update-ref refs/remotes/upstream/one subspace/one &&
+	git update-ref refs/remotes/upstream/two subspace/two &&
+	git update-ref refs/remotes/upstream/x subspace-x &&
+	git tag qux/one subspace/one &&
+	git tag qux/two subspace/two &&
+	git tag qux/x subspace-x
 '
 
 test_expect_success 'rev-parse --glob=refs/heads/subspace/*' '
@@ -141,6 +147,54 @@ test_expect_success 'rev-parse accumulates multiple --exclude' '
 	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
+test_expect_failure 'rev-parse --exclude=glob with --branches=glob' '
+	compare rev-parse "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
+'
+
+test_expect_failure 'rev-parse --exclude=glob with --tags=glob' '
+	compare rev-parse "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
+'
+
+test_expect_failure 'rev-parse --exclude=glob with --remotes=glob' '
+	compare rev-parse "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
+'
+
+test_expect_failure 'rev-parse --exclude=ref with --branches=glob' '
+	compare rev-parse "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two"
+'
+
+test_expect_failure 'rev-parse --exclude=ref with --tags=glob' '
+	compare rev-parse "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
+'
+
+test_expect_failure 'rev-parse --exclude=ref with --remotes=glob' '
+	compare rev-parse "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
+'
+
+test_expect_failure 'rev-list --exclude=glob with --branches=glob' '
+	compare rev-list "--exclude=subspace-* --branches=sub*" "subspace/one subspace/two"
+'
+
+test_expect_failure 'rev-list --exclude=glob with --tags=glob' '
+	compare rev-list "--exclude=qux/? --tags=qux/*" "qux/one qux/two"
+'
+
+test_expect_failure 'rev-list --exclude=glob with --remotes=glob' '
+	compare rev-list "--exclude=upstream/? --remotes=upstream/*" "upstream/one upstream/two"
+'
+
+test_expect_failure 'rev-list --exclude=ref with --branches=glob' '
+	compare rev-list "--exclude=subspace-x --branches=sub*" "subspace/one subspace/two"
+'
+
+test_expect_failure 'rev-list --exclude=ref with --tags=glob' '
+	compare rev-list "--exclude=qux/x --tags=qux/*" "qux/one qux/two"
+'
+
+test_expect_failure 'rev-list --exclude=ref with --remotes=glob' '
+	compare rev-list "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
+'
+
 test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
@@ -233,7 +287,7 @@ test_expect_success 'rev-list --tags=foo' '
 
 test_expect_success 'rev-list --tags' '
 
-	compare rev-list "foo/bar" "--tags"
+	compare rev-list "foo/bar qux/x qux/two qux/one" "--tags"
 
 '
 
@@ -292,7 +346,7 @@ test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 	  "master other/three someref subspace-x subspace/one subspace/two" \
 	  "--glob=heads/*" &&
 	compare shortlog foo/bar --tags=foo &&
-	compare shortlog foo/bar --tags &&
+	compare shortlog "foo/bar qux/one qux/two qux/x" --tags &&
 	compare shortlog foo/baz --remotes=foo
 
 '
-- 
2.19.1

