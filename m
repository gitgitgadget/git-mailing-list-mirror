Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19926C385
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.52.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751992; cv=none; b=g1niE+P/0dlXaWvZWgZtcPuIB/J8ebWNLxj9hBQJERft7YOPIKHMxgpY6sPFGt+Inj/HnlUWDvOTjUVekTkXERpYWQnApLbZoCFw3TeCdWO9UBcjaga8MO2MkoixCrZ8p4Aw4W/qA+km2r5ujxDHF30Bsp553ramNkksUhPdRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751992; c=relaxed/simple;
	bh=/7/4Ow/6jWvb1+nxAfMEpGpsUaPGfbyWi/STJysnr08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCCfcFTiYoQDkBLaDfJD7FMg7VlrI5w6hOR3noEoQ56kJUdXm4jln4YGmCFptlWgZKzcAey4KVrXcplbVtnIEn5dRLOtihS5cskU81sVMLdKWhg4EQletr2W/OYTH2NLls+jqgCb1XxiOCvN1zSXycTdj4mhYfdgjbUhbUE36c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.52.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.249.107])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4gGPbf0hTCz5yj8
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:07:10 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-d4cxr (unknown [10.110.113.233])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B654DC03F4;
	Thu, 14 May 2026 09:07:09 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.114])
	by ghost-submission-7d8d68f679-d4cxr with ESMTPSA
	id kOqGG7yQBWrumSQAmZP82g:T3
	(envelope-from <kernel@schlaraffenlan.de>); Thu, 14 May 2026 09:07:09 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008e57d2722-3256-4e0d-a3ba-94669df6814a,
                    C39F0B467605CB235B8620DBAA124B5209E80D88) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Thu, 14 May 2026 11:07:05 +0200
Subject: [PATCH v4 2/3] bisect: print bisect terms in single quotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bisect-terms-v4-2-b3e3cf1b06ce@schlaraffenlan.de>
References: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
In-Reply-To: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 10429773789516956449
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcOjeNfd26R86/ODmyj5aIGkM2RT+7sDH6zAs5NouMmax32jf8r9BZHnSkO06pjzEa7iyv+AQLSlhEy4AwzQlQT9vxR59c+4GG9yA06dJwDIiKhG06ZkHRRd5NLfA+4vBIMoWcHZVvrEe2rq9Ij2fzHd0SPSwXawvkgNxKIPd7sDmzXcjYHnWCs+nZ5FIW3zRs3NxGQYXkjXWq+z/vIxMqkAnhnPMruSKJHkf5D4cTq7W/MnUotPU12Z0AXyLoE86UmUo6Vnd1JSz8sOc3jxKRE194yjg0FFmTw7+Zd1NbnCWtqxD+tKU/4OoxSqU4BC8UpySOgEbx4VGY5GZPInpkigoNdKDBoC10GDOyCkQEi9Y3fZVMSrzWQQtA9kZJs8pnUyS/HCW9Z1AYYT8f4/v/XU7XQj7pWtWbRJugZLJTjd8vS7/w9rRdRxekA6bARLwcOU7lZKItlH2oIfaWH1oWw8j+Xc0wyLDMvJkPOzYa4EmIiDEIwLTxdxqL3BGynFvNpNBiVUFUUtOcvRQ10zR1NY5ejYsgktJAt33wa/3vp4KG2uya3cV9z6b/0lzvQ5KdSc0XsFxghMOKlMLE7hNfjLmnSvperHLSksD+8Fmjf6je1ovkzxF4FHnW/9W1M3sgVWpGk0oXsNFyp/mWqyT2GbdaiYYK5df1fWpEE7yMIg

As bisect terms can be arbitrarily chosen, they have been quoted in some
status messages, and in even more by translators.

To make the role of bisect terms more clear, including in translations,
and for consistency, 'enquote' all occurrences of bisect terms in status
messages.

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 bisect.c                    |  16 +++----
 builtin/bisect.c            |  24 +++++-----
 t/t6030-bisect-porcelain.sh | 114 ++++++++++++++++++++++----------------------
 3 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/bisect.c b/bisect.c
index ef17a442e5..905a9afb05 100644
--- a/bisect.c
+++ b/bisect.c
@@ -711,7 +711,7 @@ static enum bisect_error error_if_skipped_commits(struct commit_list *tried,
 		return BISECT_OK;
 
 	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first %s commit could be any of:\n", term_bad);
+	       "The first '%s' commit could be any of:\n", term_bad);
 
 	for ( ; tried; tried = tried->next)
 		printf("%s\n", oid_to_hex(&tried->item->object.oid));
@@ -810,7 +810,7 @@ static enum bisect_error handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
 		} else {
-			fprintf(stderr, _("The merge base %s is %s.\n"
+			fprintf(stderr, _("The merge base %s is '%s'.\n"
 				"This means the first '%s' commit is "
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
@@ -820,9 +820,9 @@ static enum bisect_error handle_bad_merge_base(void)
 		return BISECT_MERGE_BASE_CHECK;
 	}
 
-	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
+	fprintf(stderr, _("Some '%s' revs are not ancestors of the '%s' rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistook %s and %s revs?\n"),
+		"Maybe you mistook '%s' and '%s' revs?\n"),
 		term_good, term_bad, term_good, term_bad);
 	return BISECT_FAILED;
 }
@@ -835,7 +835,7 @@ static void handle_skipped_merge_base(const struct object_id *mb)
 
 	warning(_("the merge base between %s and [%s] "
 		"must be skipped.\n"
-		"So we cannot be sure the first %s commit is "
+		"So we cannot be sure the first '%s' commit is "
 		"between %s and %s.\n"
 		"We continue anyway."),
 		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
@@ -928,7 +928,7 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
 	struct commit **rev;
 
 	if (!current_bad_oid)
-		return error(_("a %s revision is needed"), term_bad);
+		return error(_("a '%s' revision is needed"), term_bad);
 
 	filename = repo_git_path(the_repository, "BISECT_ANCESTORS_OK");
 
@@ -1090,7 +1090,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		res = error_if_skipped_commits(tried, NULL);
 		if (res < 0)
 			goto cleanup;
-		printf(_("%s was both %s and %s\n"),
+		printf(_("%s was both '%s' and '%s'\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
@@ -1113,7 +1113,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
 			goto cleanup;
-		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
+		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 
 		show_commit(revs.commits->item);
diff --git a/builtin/bisect.c b/builtin/bisect.c
index ee6a2c83b8..606698b21e 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -465,15 +465,15 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		return;
 
 	if (!state.nr_good && !state.nr_bad)
-		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
+		bisect_log_printf(_("status: waiting for both '%s' and '%s' commits\n"),
 				  terms->term_good, terms->term_bad);
 	else if (state.nr_good)
-		bisect_log_printf(Q_("status: waiting for %s commit, %d %s commit known\n",
-				     "status: waiting for %s commit, %d %s commits known\n",
+		bisect_log_printf(Q_("status: waiting for '%s' commit, %d '%s' commit known\n",
+				     "status: waiting for '%s' commit, %d '%s' commits known\n",
 				     state.nr_good),
 				  terms->term_bad, state.nr_good, terms->term_good);
 	else
-		bisect_log_printf(_("status: waiting for %s commit(s), %s commit known\n"),
+		bisect_log_printf(_("status: waiting for '%s' commit(s), '%s' commit known\n"),
 				  terms->term_good, terms->term_bad);
 }
 
@@ -516,8 +516,8 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 		return error(_("no terms defined"));
 
 	if (!option) {
-		printf(_("Your current terms are %s for the old state\n"
-			 "and %s for the new state.\n"),
+		printf(_("Your current terms are '%s' for the old state\n"
+			 "and '%s' for the new state.\n"),
 		       terms->term_good, terms->term_bad);
 		return 0;
 	}
@@ -635,7 +635,7 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 		strbuf_reset(&commit_name);
 		repo_format_commit_message(the_repository, commit, "%s",
 					   &commit_name, &pp);
-		fprintf(fp, "# possible first %s commit: [%s] %s\n",
+		fprintf(fp, "# possible first '%s' commit: [%s] %s\n",
 			terms->term_bad, oid_to_hex(&commit->object.oid),
 			commit_name.buf);
 	}
@@ -666,7 +666,7 @@ static int bisect_successful(struct bisect_terms *terms)
 	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
 				   &pp);
 
-	res = append_to_file(git_path_bisect_log(), "# first %s commit: [%s] %s\n",
+	res = append_to_file(git_path_bisect_log(), "# first '%s' commit: [%s] %s\n",
 			    terms->term_bad, oid_to_hex(&commit->object.oid),
 			    commit_name.buf);
 
@@ -1265,13 +1265,13 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0 || 128 <= rc) {
-				error(_("unable to verify %s on %s"
-					" revision"), command.buf, terms->term_good);
+				error(_("unable to verify %s on '%s' revision"),
+				      command.buf, terms->term_good);
 				res = BISECT_FAILED;
 				break;
 			}
 			if (rc == res) {
-				error(_("bogus exit code %d for %s revision"),
+				error(_("bogus exit code %d for '%s' revision"),
 				      rc, terms->term_good);
 				res = BISECT_FAILED;
 				break;
@@ -1317,7 +1317,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			printf(_("bisect found first %s commit\n"), terms->term_bad);
+			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9d28d1eedb..081116220a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -258,7 +258,7 @@ test_expect_success 'bisect skip: successful result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first bad commit" my_bisect_log.txt
+	grep "$HASH2 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
@@ -269,7 +269,7 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect skip >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	grep $HASH2 my_bisect_log.txt &&
 	grep $HASH3 my_bisect_log.txt &&
@@ -285,7 +285,7 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	! grep $HASH2 my_bisect_log.txt &&
 	grep $HASH3 my_bisect_log.txt &&
@@ -304,7 +304,7 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 	git bisect good $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	! grep $HASH2 my_bisect_log.txt &&
 	grep $HASH3 my_bisect_log.txt &&
@@ -348,8 +348,8 @@ test_expect_success 'git bisect run: args, stdout and stderr with no arguments'
 	test_bisect_run_args <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	EOF_ARGS
 	running './run.sh'
-	$HASH4 is the first bad commit
-	bisect found first bad commit
+	$HASH4 is the first 'bad' commit
+	bisect found first 'bad' commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -359,8 +359,8 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' "
 	<-->
 	EOF_ARGS
 	running './run.sh' '--'
-	$HASH4 is the first bad commit
-	bisect found first bad commit
+	$HASH4 is the first 'bad' commit
+	bisect found first 'bad' commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -373,8 +373,8 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	<bar>
 	EOF_ARGS
 	running './run.sh' '--log' 'foo' '--no-log' 'bar'
-	$HASH4 is the first bad commit
-	bisect found first bad commit
+	$HASH4 is the first 'bad' commit
+	bisect found first 'bad' commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -384,8 +384,8 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" a
 	<--bisect-start>
 	EOF_ARGS
 	running './run.sh' '--bisect-start'
-	$HASH4 is the first bad commit
-	bisect found first bad commit
+	$HASH4 is the first 'bad' commit
+	bisect found first 'bad' commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -418,7 +418,7 @@ test_expect_success 'git bisect run: unable to verify on good' "
 	fi
 	EOF
 	cat <<-'EOF' >expect &&
-	unable to verify './fail.sh' on good revision
+	unable to verify './fail.sh' on 'good' revision
 	EOF
 	test_when_finished 'git bisect reset' &&
 	git bisect start &&
@@ -439,7 +439,7 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -461,7 +461,7 @@ test_expect_success '"git bisect run" with more complex "git bisect start"' '
 	EOF
 	git bisect start $HASH4 $HASH1 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+	grep "$HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -474,7 +474,7 @@ test_expect_success 'bisect run accepts exit code 126 as bad' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first bad commit" my_bisect_log.txt
+	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success POSIXPERM 'bisect run fails with non-executable test script' '
@@ -485,7 +485,7 @@ test_expect_success POSIXPERM 'bisect run fails with non-executable test script'
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	test_must_fail git bisect run ./not-executable.sh >my_bisect_log.txt &&
-	! grep "is the first bad commit" my_bisect_log.txt
+	! grep "is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect run accepts exit code 127 as bad' '
@@ -497,7 +497,7 @@ test_expect_success 'bisect run accepts exit code 127 as bad' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first bad commit" my_bisect_log.txt
+	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect run fails with missing test script' '
@@ -507,7 +507,7 @@ test_expect_success 'bisect run fails with missing test script' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	test_must_fail git bisect run ./does-not-exist.sh >my_bisect_log.txt &&
-	! grep "is the first bad commit" my_bisect_log.txt
+	! grep "is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -520,14 +520,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -541,7 +541,7 @@ test_expect_success 'bisect run & skip: cannot tell between 2' '
 	EOF
 	git bisect start $HASH6 $HASH1 &&
 	test_expect_code 2 git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
 	! grep $HASH3 my_bisect_log.txt &&
 	! grep $HASH6 my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
@@ -560,7 +560,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	EOF
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH6 is the first bad commit" my_bisect_log.txt
+	grep "$HASH6 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -569,7 +569,7 @@ test_expect_success 'bisect skip only one range' '
 	git bisect skip $HASH1..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip many ranges' '
@@ -578,7 +578,7 @@ test_expect_success 'bisect skip many ranges' '
 	git bisect skip $HASH2 $HASH2.. ..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt
+	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect starting with a detached HEAD' '
@@ -594,7 +594,7 @@ test_expect_success 'bisect starting with a detached HEAD' '
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
-	test_grep "mistook good and bad" rev_list_error &&
+	test_grep "mistook '\''good'\'' and '\''bad'\''" rev_list_error &&
 	git bisect reset
 '
 
@@ -610,7 +610,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
+	grep "$HASH7 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -703,7 +703,7 @@ test_expect_success '"git bisect run --first-parent" simple case' '
 	git bisect good $HASH4 &&
 	git bisect bad $B_HASH &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$B_HASH is the first bad commit" my_bisect_log.txt &&
+	grep "$B_HASH is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset &&
 	test_path_is_missing .git/BISECT_FIRST_PARENT
 '
@@ -777,7 +777,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
+	grep "$PARA_HASH1 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -795,7 +795,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
+	grep "$PARA_HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'skipping away from skipped commit' '
@@ -826,7 +826,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../nocheckout.log
 	) &&
-	grep "$HASH3 is the first bad commit" nocheckout.log
+	grep "$HASH3 is the first '\''bad'\'' commit" nocheckout.log
 '
 
 
@@ -841,7 +841,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first bad commit" defaulted.log
+	grep "$HASH3 is the first '\''bad'\'' commit" defaulted.log
 '
 
 #
@@ -969,7 +969,7 @@ cat > expected.bisect-log <<EOF
 git bisect start '$HASH4' '$HASH2'
 # good: [$HASH3] Add <3: Another new day for git> into <hello>.
 git bisect good $HASH3
-# first bad commit: [$HASH4] Add <4: Ciao for now> into <hello>.
+# first 'bad' commit: [$HASH4] Add <4: Ciao for now> into <hello>.
 EOF
 
 test_expect_success 'bisect log: successful result' '
@@ -988,8 +988,8 @@ git bisect start '$HASH4' '$HASH2'
 # skip: [$HASH3] Add <3: Another new day for git> into <hello>.
 git bisect skip $HASH3
 # only skipped commits left to test
-# possible first bad commit: [$HASH4] Add <4: Ciao for now> into <hello>.
-# possible first bad commit: [$HASH3] Add <3: Another new day for git> into <hello>.
+# possible first 'bad' commit: [$HASH4] Add <4: Ciao for now> into <hello>.
+# possible first 'bad' commit: [$HASH3] Add <3: Another new day for git> into <hello>.
 EOF
 
 test_expect_success 'bisect log: only skip commits left' '
@@ -1031,21 +1031,21 @@ test_expect_success 'bisect start with one new and old' '
 	git bisect new $HASH4 &&
 	git bisect new &&
 	git bisect new >bisect_result &&
-	grep "$HASH2 is the first new commit" bisect_result &&
+	grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with old and new' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first new commit" bisect_result &&
+	grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with CRLF log' '
 	append_cr <log_to_replay.txt >log_to_replay_crlf.txt &&
 	git bisect replay log_to_replay_crlf.txt >bisect_result_crlf &&
-	grep "$HASH2 is the first new commit" bisect_result_crlf &&
+	grep "$HASH2 is the first '\''new'\'' commit" bisect_result_crlf &&
 	git bisect reset
 '
 
@@ -1078,13 +1078,13 @@ test_expect_success 'bisect terms shows good/bad after start' '
 test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset &&
 	git bisect start --term-old term2 --term-new term1 >bisect_result &&
-	grep "status: waiting for both term2 and term1 commits" bisect_result &&
+	test_grep "status: waiting for both '\''term2'\'' and '\''term1'\'' commits" bisect_result &&
 	git bisect term2 $HASH1 >bisect_result &&
-	grep "status: waiting for term1 commit, 1 term2 commit known" bisect_result &&
+	test_grep "status: waiting for '\''term1'\'' commit, 1 '\''term2'\'' commit known" bisect_result &&
 	git bisect term1 $HASH4 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	test_grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -1101,7 +1101,7 @@ test_expect_success 'bogus command does not start bisect' '
 
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
 	git bisect reset
 '
 
@@ -1110,7 +1110,7 @@ test_expect_success 'bisect run term1 term2' '
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
 	git bisect term1 &&
 	git bisect run false >bisect_result &&
-	grep "bisect found first term1 commit" bisect_result &&
+	test_grep "bisect found first '\''term1'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -1120,7 +1120,7 @@ test_expect_success 'bisect start term1 term2' '
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -1154,8 +1154,8 @@ test_expect_success 'bisect start --term-* does store terms' '
 	git bisect start --term-bad=one --term-good=two &&
 	git bisect terms >actual &&
 	cat <<-EOF >expected &&
-	Your current terms are two for the old state
-	and one for the new state.
+	Your current terms are '\''two'\'' for the old state
+	and '\''one'\'' for the new state.
 	EOF
 	test_cmp expected actual &&
 	git bisect terms --term-bad >actual &&
@@ -1212,7 +1212,7 @@ test_expect_success 'bisect handles annotated tags' '
 	git bisect good tag-one &&
 	git bisect bad tag-two >output &&
 	bad=$(git rev-parse --verify tag-two^{commit}) &&
-	grep "$bad is the first bad commit" output
+	grep "$bad is the first '\''bad'\'' commit" output
 '
 
 test_expect_success 'bisect run fails with exit code equals or greater than 128' '
@@ -1236,29 +1236,29 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 test_expect_success 'bisect state output with multiple good commits' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect good "$HASH1" >output &&
-	grep "waiting for bad commit, 1 good commit known" output &&
+	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect log >output &&
-	grep "waiting for bad commit, 1 good commit known" output &&
+	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect good "$HASH2" >output &&
-	grep "waiting for bad commit, 2 good commits known" output &&
+	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output &&
 	git bisect log >output &&
-	grep "waiting for bad commit, 2 good commits known" output
+	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output
 '
 
 test_expect_success 'bisect state output with bad commit' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both good and bad commits" output &&
+	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect bad "$HASH4" >output &&
-	grep -F "waiting for good commit(s), bad commit known" output &&
+	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output &&
 	git bisect log >output &&
-	grep -F "waiting for good commit(s), bad commit known" output
+	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output
 '
 
 test_expect_success 'verify correct error message' '

-- 
2.54.0

