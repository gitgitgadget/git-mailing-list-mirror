Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F501F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfILWMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45680 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfILWMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id x3so12345509plr.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5mQ7jGVi1GSepIUqmAEyMSklEa2/GbTtq0381ie0A4=;
        b=KoQZ9eMIHOce9Z9/vChMex7Yclxd2Ee3hBTfQ7Ku+09XhIaZ/V9UVL/OLnir7vrceG
         lXFNbBH9l+0z5s+3NjeJx3oU4SdfWV8DgYbwUgw9W3WvrCWa8/jP3qBae9MJwRzhZ2ac
         viguNPwFwU/RSQOC2ow75/quBX3Xvq34/8z2ysTWUvUSeQLrKe2i7R4ixPYLgQSMY4m/
         FOqmdHNMvSQ3Q4WzeDi9jPxgQvV1SApXJlEi7eOf4wdkIyyfeSFz1wHRw9T9KYbqMn9l
         I+ue23fyXysXewCXapetFTSO6C8PIKuv52Nptg2jPjvtLM0g5wtxmcjsyOIcUP2gD5GW
         ZGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5mQ7jGVi1GSepIUqmAEyMSklEa2/GbTtq0381ie0A4=;
        b=THMJbKWa1QaAw7eSn8f8pz7nupgxBfnqWUe9F7Uz+PfR7SyFXHsFknbUE/EVfnvUf7
         2EYD3sYX+mP7mJaswTS0+Vb8xQNVFndIITCIE3Jb6n61KXn+g1VNKfbj+E6xTJSIEoLz
         vVU8WEKcjX/Ii6zxdvDuLG401JIRphDDJ+GkZIe2AL78LrsHiQdJ8YqRLkSOq49kveAy
         35mTUs4/xDz+5NiujWWc0ysdjqS2HaGeUgp+rSkzmiWSlGKSwXem1IQ0JOvjzMrsLeZ3
         JDD/bsWpP0Sc5hUANDFaO8VQGJpml+95lD2K6Q0ejhO1ezdpjEclcgSfyf3P9QjOPyRv
         OxoA==
X-Gm-Message-State: APjAAAX0QXiwF4UPuE0/+Kep0/IpIQVpd1Kt9hWo3va5CC29WUk9H+TS
        pLJjwpJgYddxv5LYDQGLfW7ShM5FpBg=
X-Google-Smtp-Source: APXvYqz45ADHPQZpUPTZlwUcMtVz7erf1NhuTQ/i9m5MaWetvFNGUwaoACOLh1HZnKGUx58fbEQpqw==
X-Received: by 2002:a17:902:6f0f:: with SMTP id w15mr23966462plk.200.1568326370502;
        Thu, 12 Sep 2019 15:12:50 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 04/12] dir: also check directories for matching pathspecs
Date:   Thu, 12 Sep 2019 15:12:32 -0700
Message-Id: <20190912221240.18057-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if a directory doesn't match a pathspec, it is possible, depending
on the precise pathspecs, that some file underneath it might.  So we
special case and recurse into the directory for such situations.  However,
we previously always added any untracked directory that we recursed into
to the list of untracked paths, regardless of whether the directory
itself matched the pathspec.

For the case of git-clean and a set of pathspecs of "dir/file" and "more",
this caused a problem because we'd end up with dir entries for both of
  "dir"
  "dir/file"
Then correct_untracked_entries() would try to helpfully prune duplicates
for us by removing "dir/file" since it's under "dir", leaving us with
  "dir"
Since the original pathspec only had "dir/file", the only entry left
doesn't match and leaves nothing to be removed.  (Note that if only one
pathspec was specified, e.g. only "dir/file", then the common_prefix_len
optimizations in fill_directory would cause us to bypass this problem,
making it appear in simple tests that we could correctly remove manually
specified pathspecs.)

Fix this by actually checking whether the directory we are about to add
to the list of dir entries actually matches the pathspec; only do this
matching check after we have already returned from recursing into the
directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 5 +++++
 t/t7300-clean.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index bf1a74799e..76a3c3894b 100644
--- a/dir.c
+++ b/dir.c
@@ -1951,6 +1951,11 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
+
+			if (!match_pathspec(istate, pathspec, path.buf, path.len,
+					    0 /* prefix */, NULL,
+					    0 /* do NOT special case dirs */))
+				state = path_none;
 		}
 
 		if (check_only) {
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 2c254c773c..12617158db 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -699,7 +699,7 @@ test_expect_failure 'git clean handles being told what to clean' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean handles being told what to clean, with -d' '
+test_expect_success 'git clean handles being told what to clean, with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd */ut &&
@@ -715,7 +715,7 @@ test_expect_failure 'git clean works if a glob is passed without -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed with -d' '
+test_expect_success 'git clean works if a glob is passed with -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -ffd "*ut" &&
-- 
2.23.0.173.gad11b3a635.dirty

