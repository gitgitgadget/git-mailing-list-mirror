Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C35CC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiBYSxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiBYSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:53:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074C2E681
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d28so5860622wra.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NMBxTBIthEBnTsfAoQFAD6Sr4eiKRXcmVrXzk4e+WWg=;
        b=THVp4mR9G2HsKUuUB+P6Wkuh4gp/vF9MAAWmg0Mr3RUsIRwk7M+xUp1JksoonfHUwO
         upqgjx8ywxmRLbmeCFSVfvHiPamacUSeMCK/sUtr8p5ye+pg86SVhlq0hByi63b9o77M
         xli/55ujAQ5YLadPpoLQxteDvB0NlUSHxUnP42AUtRvwAdiMs8cF8AKPqmm0tXIBbtmw
         9sIDH0c10OK1a5o5JxpZkooieIDZzIwjluSk0UhMheP7JRF0p+niD030J7lf+2LqOWA4
         6Jrr1eg4WTM3wVKfCA8Twir4k1gLmh6IbZijdSk25nWM5Ya7TvsnjSYyaNWnxFbpgNkj
         O7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NMBxTBIthEBnTsfAoQFAD6Sr4eiKRXcmVrXzk4e+WWg=;
        b=ynsB+Ac/HalDFXrB/v6bH5WaqPMhP7XqCg3Du22VOGnoJ9EV7VjvZH0KTSSD1y/5eG
         NbnEM4cd4TrMAEWz3S9ilIq0igaoH9LTGPqrjrffZMw3pbfE6gdrrkcvQVOVEOQ+YHQp
         Cd9XmW1POH1n0bJekwDf5yYUOhudQETD6oO5iYv4zc3Vz6iX76DvRDPcQMCWk0VJndoA
         lzC5yxO/AbmV5CyOMJdP7nByZcLHC8bBP9ozLTpTFOm6mi3CYnHYwwb9fW0J2jHGdL+z
         sSjYyAPVU8vQbMGgdQamVV/u4dbLnqzso0kYHT46+Y6RhNS7jaiBrJGPVmCjWaX2E+bo
         rKcQ==
X-Gm-Message-State: AOAM5320QbLLS/+heA7JhsBoWjdVsKLN8JjvPxKy89hv3m2shZxGhlFG
        71W5tSBpB9V1w+8RmXTIsTltEG+hF6M=
X-Google-Smtp-Source: ABdhPJxx4VrOowjleNG98IEbekRfdVSXxxMWZ9uLQt5MaF0gV6aUCAxaGShfTk7xxtJejsKzNtx2Qw==
X-Received: by 2002:adf:fa4a:0:b0:1ef:731c:21e8 with SMTP id y10-20020adffa4a000000b001ef731c21e8mr2622018wrr.518.1645815144993;
        Fri, 25 Feb 2022 10:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c2d4900b0038100a95903sm6316899wmg.41.2022.02.25.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:52:24 -0800 (PST)
Message-Id: <890e016bfc0809d25a4ae8ae924b23895f520810.1645815142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
        <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 18:52:21 +0000
Subject: [PATCH v2 1/2] merge: new autosetupmerge option 'simple' for matching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

This commit introduces a new option to the branch.autosetupmerge
setting, "simple", which is intended to be consistent with and
complementary to the push.default "simple" option.

The push.defaut option "simple" helps produce
predictable/understandable behavior for beginners, where they don't
accidentally push to the "wrong" branch in centralized workflows. If
they create a local branch with a different name and then try to do a
plain push, it will helpfully fail and explain why.

However, such users can often find themselves confused by the behavior
of git after they first branch, and before they push. At that stage,
their upstream tracking branch is the original remote branch, and pull
will be bringing in "upstream changes" - eg all changes to "main", in
a typical project where that's where they branched from.
On the other hand, once they push their new branch (dealing with the
initial error, following instructions to push to the right name),
subsequent "pull" calls will behave as expected, only bring in any
changes to that new branch they pushed.

The new option introduced here, with push.default set to simple,
ensures that push/pull behavior is generally consistent - tracking
will be automatically set up for branches that push will work for
(and pull will be consistent for) only.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    | 18 +++++++++++-------
 branch.c                        | 19 +++++++++++++++++++
 branch.h                        |  1 +
 config.c                        |  3 +++
 5 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 1e0c7af014b..8df10d07129 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -9,7 +9,9 @@ branch.autoSetupMerge::
 	automatic setup is done when the starting point is either a
 	local branch or remote-tracking branch; `inherit` -- if the starting point
 	has a tracking configuration, it is copied to the new
-	branch. This option defaults to true.
+	branch; `simple` -- automatic setup is done only when the starting point
+	is a remote-tracking branch and the new branch has the same name as the
+	remote branch. This option defaults to true.
 
 branch.autoSetupRebase::
 	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c8b4f9ce3c7..ae82378349d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -221,13 +221,17 @@ The exact upstream branch is chosen depending on the optional argument:
 itself as the upstream; `--track=inherit` means to copy the upstream
 configuration of the start-point branch.
 +
-`--track=direct` is the default when the start point is a remote-tracking branch.
-Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
-were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch. Set it to
-`inherit` if you want to copy the tracking configuration from the
-branch point.
+The branch.autoSetupMerge configuration variable specifies how `git switch`,
+`git checkout` and `git branch` should behave when neither `--track` nor
+`--no-track` are specified:
++
+The default option, `true`, behaves as though `--track=direct`
+were given whenever the start-point is a remote-tracking branch.
+`false` behaves as if `--no-track` were given. `always` behaves as though
+`--track=direct` were given. `inherit` behaves as though `--track=inherit`
+were given. `simple` behaves as though `--track=direct` were given only when
+the start-point is a remote-tracking branch and the new branch has the same
+name as the remote branch.
 +
 See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
 how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
diff --git a/branch.c b/branch.c
index 6b31df539a5..81613ade8bf 100644
--- a/branch.c
+++ b/branch.c
@@ -252,10 +252,29 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
+	/*
+	 * This check does not apply to the BRANCH_TRACK_INHERIT
+	 * option; you can inherit one or more tracking entries
+	 * and the tracking.matches counter is not incremented.
+	 */
 	if (tracking.matches > 1)
 		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
+	if (track == BRANCH_TRACK_SIMPLE) {
+		/*
+		 * Only track if remote branch name matches.
+		 * Reaching into items[0].string is safe because
+		 * we know there is at least one and not more than
+		 * one entry (because not BRANCH_TRACK_INHERIT).
+		 */
+		const char *tracked_branch;
+		if (!skip_prefix(tracking.srcs->items[0].string,
+				 "refs/heads/", &tracked_branch) ||
+		    strcmp(tracked_branch, new_ref))
+			return;
+	}
+
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
diff --git a/branch.h b/branch.h
index 04df2aa5b51..560b6b96a8f 100644
--- a/branch.h
+++ b/branch.h
@@ -12,6 +12,7 @@ enum branch_track {
 	BRANCH_TRACK_EXPLICIT,
 	BRANCH_TRACK_OVERRIDE,
 	BRANCH_TRACK_INHERIT,
+	BRANCH_TRACK_SIMPLE,
 };
 
 extern enum branch_track git_branch_track;
diff --git a/config.c b/config.c
index e0c03d154c9..cc586ac816c 100644
--- a/config.c
+++ b/config.c
@@ -1673,6 +1673,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		} else if (value && !strcmp(value, "inherit")) {
 			git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
-- 
gitgitgadget

