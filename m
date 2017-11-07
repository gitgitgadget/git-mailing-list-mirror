Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6796202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 18:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbdKGSpR (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 13:45:17 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:57170 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbdKGSpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 13:45:16 -0500
Received: by mail-io0-f182.google.com with SMTP id m81so3193409ioi.13
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUCGasi1Rg7snLNaHxAZTBtRA3bseOBJIJ+of0GA/RI=;
        b=uRetSKRvTfsLKN5b65hAO5ylhSTbxiJeOBBHPDyof8t2/uTLI4G3w+4GRXY6STgAPz
         rnpyXcQbzEo8PIllxrpOwaT4qWEtITyW4tk7lLoGDgwFsmct4WasUJkA2vbjkEMOPjbQ
         YtSybegWOJoSxMOAroBStCeLiyoT0iFkhSw1y2MPrksoEi+C2n44AmWQuqVJhbpPsGnv
         wnONoVHtytIR0zfS2v1Z1NXhq6GUqzq7M3K5r0O0ofGsLy6Bl3S+vEChzkQYIhjgUdWN
         NRn8LMpbJWsghJlNX4VPDX8XxBrjVTGClhhg1UbyIqLimUwsdJaCF5gz5kVlmFbR7MY9
         xByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUCGasi1Rg7snLNaHxAZTBtRA3bseOBJIJ+of0GA/RI=;
        b=HiXxCNDkuhepVr8duFZhDsb4p6MHs+0EAiQRyQM2jwRVUq4ihqokGE+JrKnVqdq6Px
         4kOl/CCBwnqqbgbjI8U25EnjefBvebizfZ6tzZZZBPBwonROoglPRpFl9nEufOGmSQim
         GZLOf1WFS92DdzU6uy0uNfIBC91ri1e+o4YFQqfUnf4dN+JfFZ7XlBFqZS4wS8tg8AFq
         aCtiHvTWyOsY9AYlZt6+j71JqrRfiG7MbelC4Ty03FTnChKHFzKg8/8QO3DHrpBYixyk
         ogbpoGFpammu+eL31JfF9nDj/un0pkYWAJE233SKssF81ltegfQf9AEemxyKTecFHDw8
         uWsg==
X-Gm-Message-State: AJaThX7QZMsXLAbaxlpGb/oChXaECRdXHKncSI6saouv5MVArDUfLj1W
        CBM9iDi/ouAv+4oUlPmHP8xZjw==
X-Google-Smtp-Source: ABhQp+Szojc++jHtZ4OPnoc3WXy/K0wVp/Hss8Io8YGT3O5vPTF0AAJHlVRKZnBAPbb3pS7WPF6K0g==
X-Received: by 10.107.146.86 with SMTP id u83mr25057316iod.37.1510080315647;
        Tue, 07 Nov 2017 10:45:15 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id 196sm879408ioe.66.2017.11.07.10.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Nov 2017 10:45:14 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     jonathantanmy@google.com, sbeller@google.com
Subject: [PATCH v2] Tests: clean up and document submodule helpers
Date:   Tue,  7 Nov 2017 10:45:08 -0800
Message-Id: <20171107184509.136564-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.1.g989a7cb82.dirty
In-Reply-To: <xmqq8tfihn3a.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tfihn3a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the commonalities from test_submodule_switch() and
test_submodule_forced_switch() in lib-submodule-update.sh, and document
their usage.

This also makes explicit (through the KNOWN_FAILURE_FORCED_SWITCH_TESTS
variable) the fact that, currently, all functionality tested using
test_submodule_forced_switch() do not correctly handle the situation in
which a submodule is replaced with an ordinary directory.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks for the review.

Change from v1:

- changed commit message title
- moved a test to the common function, so that it runs both on
  test_submodule_switch and test_submodule_forced_switch
---
 t/lib-submodule-update.sh | 251 +++++++++-------------------------------------
 1 file changed, 46 insertions(+), 205 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d26f8680..bb94c2320 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -306,9 +306,9 @@ test_submodule_content () {
 # to protect the history!
 #
 
-# Test that submodule contents are currently not updated when switching
-# between commits that change a submodule.
-test_submodule_switch () {
+# Internal function; use test_submodule_switch() or
+# test_submodule_forced_switch() instead.
+test_submodule_switch_common() {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
@@ -332,7 +332,7 @@ test_submodule_switch () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	# ... and doesn't care if it already exists ...
+	# ... and doesn't care if it already exists.
 	test_expect_$RESULT "$command: added submodule leaves existing empty directory alone" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
@@ -347,19 +347,6 @@ test_submodule_switch () {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	# ... unless there is an untracked file in its place.
-	test_expect_success "$command: added submodule doesn't remove untracked unignored file with same name" '
-		prolog &&
-		reset_work_tree_to no_submodule &&
-		(
-			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
-			>sub1 &&
-			test_must_fail $command add_sub1 &&
-			test_superproject_content origin/no_submodule &&
-			test_must_be_empty sub1
-		)
-	'
 	# Replacing a tracked file with a submodule produces an empty
 	# directory ...
 	test_expect_$RESULT "$command: replace tracked file with submodule creates empty directory" '
@@ -441,6 +428,11 @@ test_submodule_switch () {
 		# submodule files with the newly checked out ones in the
 		# directory of the same name while it shouldn't.
 		RESULT="failure"
+	elif test "$KNOWN_FAILURE_FORCED_SWITCH_TESTS" = 1
+	then
+		# All existing tests that use test_submodule_forced_switch()
+		# require this.
+		RESULT="failure"
 	else
 		RESULT="success"
 	fi
@@ -522,7 +514,6 @@ test_submodule_switch () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
-
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# submodule's work tree, subsequent update will fail
 	test_expect_$RESULT "$command: modified submodule does not update submodule work tree to invalid commit" '
@@ -555,42 +546,51 @@ test_submodule_switch () {
 	'
 }
 
-# Test that submodule contents are currently not updated when switching
-# between commits that change a submodule, but throwing away local changes in
-# the superproject is allowed.
-test_submodule_forced_switch () {
+# Declares and invokes several tests that, in various situations, checks that
+# the provided transition function:
+#  - succeeds in updating the worktree and index of a superproject to a target
+#    commit, or fails atomically (depending on the test situation)
+#  - if succeeds, the contents of submodule directories are unchanged
+#  - if succeeds, once "git submodule update" is invoked, the contents of
+#    submodule directories are updated
+#
+# Use as follows:
+#
+# my_func () {
+#   target=$1
+#   # Do something here that updates the worktree and index to match target,
+#   # but not any submodule directories.
+# }
+# test_submodule_switch "my_func"
+test_submodule_switch () {
 	command="$1"
-	######################### Appearing submodule #########################
-	# Switching to a commit letting a submodule appear creates empty dir ...
-	test_expect_success "$command: added submodule creates empty directory" '
-		prolog &&
-		reset_work_tree_to no_submodule &&
-		(
-			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_dir_is_empty sub1 &&
-			git submodule update --init --recursive &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# ... and doesn't care if it already exists ...
-	test_expect_success "$command: added submodule leaves existing empty directory alone" '
+	test_submodule_switch_common "$command"
+
+	# An empty directory does not prevent the creation of a submodule of
+	# the same name, but a file does.
+	test_expect_success "$command: added submodule doesn't remove untracked unignored file with same name" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			mkdir sub1 &&
-			$command add_sub1 &&
-			test_superproject_content origin/add_sub1 &&
-			test_dir_is_empty sub1 &&
-			git submodule update --init --recursive &&
-			test_submodule_content sub1 origin/add_sub1
+			>sub1 &&
+			test_must_fail $command add_sub1 &&
+			test_superproject_content origin/no_submodule &&
+			test_must_be_empty sub1
 		)
 	'
-	# ... unless there is an untracked file in its place.
+}
+
+# Same as test_submodule_switch(), except that throwing away local changes in
+# the superproject is allowed.
+test_submodule_forced_switch () {
+	command="$1"
+	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
+	test_submodule_switch_common "$command"
+
+	# When forced, a file in the superproject does not prevent creating a
+	# submodule of the same name.
 	test_expect_success "$command: added submodule does remove untracked unignored file with same name when forced" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
@@ -603,165 +603,6 @@ test_submodule_forced_switch () {
 			test_dir_is_empty sub1
 		)
 	'
-	# Replacing a tracked file with a submodule produces an empty
-	# directory ...
-	test_expect_success "$command: replace tracked file with submodule creates empty directory" '
-		prolog &&
-		reset_work_tree_to replace_sub1_with_file &&
-		(
-			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
-			$command replace_file_with_sub1 &&
-			test_superproject_content origin/replace_file_with_sub1 &&
-			test_dir_is_empty sub1 &&
-			git submodule update --init --recursive &&
-			test_submodule_content sub1 origin/replace_file_with_sub1
-		)
-	'
-	# ... as does removing a directory with tracked files with a
-	# submodule.
-	test_expect_success "$command: replace directory with submodule" '
-		prolog &&
-		reset_work_tree_to replace_sub1_with_directory &&
-		(
-			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
-			$command replace_directory_with_sub1 &&
-			test_superproject_content origin/replace_directory_with_sub1 &&
-			test_dir_is_empty sub1 &&
-			git submodule update --init --recursive &&
-			test_submodule_content sub1 origin/replace_directory_with_sub1
-		)
-	'
-
-	######################## Disappearing submodule #######################
-	# Removing a submodule doesn't remove its work tree ...
-	test_expect_success "$command: removed submodule leaves submodule directory and its contents in place" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
-			$command remove_sub1 &&
-			test_superproject_content origin/remove_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# ... especially when it contains a .git directory.
-	test_expect_success "$command: removed submodule leaves submodule containing a .git directory alone" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
-			replace_gitfile_with_git_dir sub1 &&
-			$command remove_sub1 &&
-			test_superproject_content origin/remove_sub1 &&
-			test_git_directory_is_unchanged sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# Replacing a submodule with files in a directory must fail as the
-	# submodule work tree isn't removed ...
-	test_expect_failure "$command: replace submodule with a directory must fail" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# ... especially when it contains a .git directory.
-	test_expect_failure "$command: replace submodule containing a .git directory with a directory must fail" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
-			test_superproject_content origin/add_sub1 &&
-			test_git_directory_is_unchanged sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# Replacing it with a file must fail as it could throw away any local
-	# work tree changes ...
-	test_expect_failure "$command: replace submodule with a file must fail" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# ... or even destroy unpushed parts of submodule history if that
-	# still uses a .git directory.
-	test_expect_failure "$command: replace submodule containing a .git directory with a file must fail" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
-			test_superproject_content origin/add_sub1 &&
-			test_git_directory_is_unchanged sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-
-	########################## Modified submodule #########################
-	# Updating a submodule sha1 doesn't update the submodule's work tree
-	test_expect_success "$command: modified submodule does not update submodule work tree" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
-			test_superproject_content origin/modify_sub1 &&
-			test_submodule_content sub1 origin/add_sub1 &&
-			git submodule update &&
-			test_submodule_content sub1 origin/modify_sub1
-		)
-	'
-	# Updating a submodule to an invalid sha1 doesn't update the
-	# submodule's work tree, subsequent update will fail
-	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
-		prolog &&
-		reset_work_tree_to add_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			$command invalid_sub1 &&
-			test_superproject_content origin/invalid_sub1 &&
-			test_submodule_content sub1 origin/add_sub1 &&
-			test_must_fail git submodule update &&
-			test_submodule_content sub1 origin/add_sub1
-		)
-	'
-	# Updating a submodule from an invalid sha1 doesn't update the
-	# submodule's work tree, subsequent update will succeed
-	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
-		prolog &&
-		reset_work_tree_to invalid_sub1 &&
-		(
-			cd submodule_update &&
-			git branch -t valid_sub1 origin/valid_sub1 &&
-			$command valid_sub1 &&
-			test_superproject_content origin/valid_sub1 &&
-			test_dir_is_empty sub1 &&
-			git submodule update --init --recursive &&
-			test_submodule_content sub1 origin/valid_sub1
-		)
-	'
 }
 
 # Test that submodule contents are correctly updated when switching
-- 
2.15.0.403.gc27cc4dac6-goog

