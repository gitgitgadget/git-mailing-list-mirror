Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633406;
	b=KCWbFCdP/M9DDICZXf8d2QX/m1615JxF3QLffrQ+Uzsz2PQrKyERKczDNDw7mRzsjeS8
	 uHyOdrbNtV1hPfFxIk3ZVAZqJHS7MYRwmE84c9CFZ+gS+eK4Tyifq9X/yZDBW5V3xhwNT
	 iTimiCqy1+r/hNSHGhrB9yg5TvlsXUMd2xVEFKHxmL95moCVyXO1XxNlmgHann3B7fpn3
	 Gikykf2PitLX2A3/F7g33VHwCGiKzz/16/sggADa5YZdCi/D9GalO5C8NfLdIgnoSBe5A
	 R6zjWex6z2+6yVqFlgDpZazjNN4zAAGY1Dyo8SVMwNX+jZgVXnjtrcX6L9/F86Y3sbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=rbWW2ZAGk4cUCYXbtM/R29eew1lnJwfGZLG7lPLsuqk=;
	b=RYGVqtWwimt4enILmR5c6RrrSn/ng+EQUiZlbf1By9T2UBMknD0AbTmar98+jTo8o+ca
	 n6lKDt0ADpp9nqMUo+D0kKw687noFBmP++rztmUyJ587ZUak7nghbHtvCvJvzBX9xP5p8
	 olVUZbI/IeYH0NWQ5sG5A8+YkxOdiq6uTaGbOaM+qvrdX4wmqturPsd1pC7v4yuTzl9pb
	 QwU8l0PhQuvzFXlLs19TzerIC8GqXsbjNj7heyMWRfnUFzZITKsteXbgxHoJWU8U3ZD6o
	 AjPIYDqVv2jTzMdKOZSMcEq0tEucqboPPsI4fNbToehPtfmIzR2RRV29ifxqnPH747g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Igp2NGQa;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E5606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 060E5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Igp2NGQa
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-71ad5f20016so4010768eaf.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633405; x=1796238205; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rbWW2ZAGk4cUCYXbtM/R29eew1lnJwfGZLG7lPLsuqk=;
        b=Igp2NGQak+ELFTs2U8elBRSa6HlLdpNBWlRT+F8XcYT28R7T1e1tRqEXzqODvKLJhs
         I0WA9LBsAaLg3+ZPsmZ2P/758N6pSO13B+nw6A5hLRfvHVQ+E8tOuBPNIFA3iP8MdSLp
         zu4Vl6N40YiBeRBPUIUHjb9vImCCJmR+l38WnXv+Pc7T9pn0v351frQM/vx6jrLdR/M9
         IUJxb8g8R4C0Rk1QWvhIlEEB/OMDtlSj7YEFvJqbRtn4AUNhOT2qCE406gBcPu6KZa/J
         gfV4IkSOLeRfh46M09/AT9/Unb2s6Iy3BiEqgtOmM1R0FynebZ/+K/D9XIP0kJQ34J6k
         Dusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633405; x=1796238205;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rbWW2ZAGk4cUCYXbtM/R29eew1lnJwfGZLG7lPLsuqk=;
        b=hv7JrWTig1PtmFLwFPbFKxdy7UY5UxU7afWOA5keFu89pQIvSojmOio4E2b5cYaipV
         6Yl0Mb84iYzQzaIMvtcf2pvjuNT3hbKCXz08LYaYx754dWA0sVh9J98j/pOWSQbH2R8F
         qJGH9ZWJsdHjLgcDZv6FG2fMmmCaCUtw5Sv7SSlZQlMKphgNmsp4+VFbo3v7Q+w2Ni2D
         mCQONhs67vj7klPwJdw6J/NElXCB04ufbmM7F334KaNYOIdXdOb47XRhqEPrYi6mGGdH
         XBywONWWrDclp+lc97sThT8ClbwfwTUEUhOcJimTILZlsc6Z8cw3cuHpIrGzKzzAHtJb
         MUmw==
X-Gm-Message-State: APuU4Z+8+xGbCY9d5xh+5NtMZ1g89QhrdW5r3ZNfXGlAA2RxfTs/NCM5
	2yPAAFAAXEG1xcVTAY27jW6KGlKBGTrVT/400ffeV5ARliaT8IJIOKQqHYDkP3wA
X-Gm-Gg: AZFdTZeV2hcgACphU5Y8Uj3AmtkdWA1T1yRt2qF5/H13M7vQW0PbaHZC+hTFn3DAXc0
	GrfZnUXM8+V6NqZwzjQyQsXXo4TYDwvriiGePfh3nkD1d0hTdhMQx0mhJiuyLIOCJa+cHghFp0n
	XX4vPyuN+w/BT2UHF4ekT6/m0/b0s85l2uk3kaJg+iXtBi+eCvVtIJkOvTQ5uYzA/HXvOLBVoGK
	SKNPs0+xkEgUMm6xIfSvJnR5nPwcpjZqXnSP6azyAXnsXbAppky/vTM3ajNZazROzThXmQb+91y
	dClfePvvTPAz9HUxLVtqmxvx7WZ7P/ADBkEvYMlNcbUUVez8kkncu3cWGbxAWx9WeYVVfk0xBcG
	abaYggK/9wuoUZJuyKjmGs/qx5Y8ZRajJyjobazF2RZSoZ59GUrzWLrFoPARiHyTN6h1WKtdmsE
	EGje1apvleC7vlQ8E+5MfWN66BPZ0nxeFo3XV4aUcouH3pFN6rlq2liWFuvxSM1R5QT86FOhiTT
	CVuedLCstCWq+vts1BWU31iGvuFR713tTxiPvWDfAT98hMSe5eXnIcfGQYls52Cy55jJ9TcS17/
	emPrOaly7MrInaB1vIGqSZrCIIAznySH1AUdftDvybM7fDGen7XyOrk=
X-Received: by 2002:a05:6820:a09a:b0:6b7:8415:d790 with SMTP id 006d021491bc7-71b39516d44mr12576496eaf.59.1795633404566;
        Wed, 25 Nov 2026 11:03:24 -0800 (PST)
Received: from [127.0.0.1] ([132.196.54.233])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168c1bc5sm13019717a34.6.2026.11.25.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:03:22 -0800 (PST)
Message-Id: <pull.2463.git.git.1795633401382.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:03:21 +0000
Subject: [PATCH] history: squash the commits not in the upstream by default
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git history squash" with no arguments refuses to run and asks for a
revision range, even though the commits to squash are usually the ones
on the current branch that its upstream does not have.

The subcommand added in 6fd039c984 (history: add skeleton for squash
subcommand, 2026-09-08) started out on the list as "git rebase --squash
[<upstream>]", which folded "@{upstream}..HEAD" when given no argument.
It moved to "git history" to take any range, and that default was lost
in the move.

Squash the commits since the branch forked off its upstream, so this
keeps working after a fetch brings in new upstream commits.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    history: squash the commits not in the upstream by default
    
    Make git history squash with no range default to the commits on the
    current branch that are not in its upstream, like git rebase does.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2463%2FHaraldNordgren%2Fhistory-squash-default-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2463/HaraldNordgren/history-squash-default-upstream-v1
Pull-Request: https://github.com/git/git/pull/2463

 Documentation/git-history.adoc |  8 ++++--
 builtin/history.c              | 49 ++++++++++++++++++++++++++--------
 t/t3455-history-squash.sh      | 31 +++++++++++++++++++--
 3 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1fcc30150a..eaf75102d7 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,7 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
-git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] [<revision-range>]
 
 DESCRIPTION
 -----------
@@ -117,7 +117,7 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
-`squash <revision-range>`::
+`squash [<revision-range>]`::
 	Fold all commits in _<revision-range>_ into the oldest commit of that
 	range. The resulting commit keeps the oldest commit's authorship and
 	takes the tree of the range's newest commit, so the whole range
@@ -133,6 +133,10 @@ given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
 already on `topic`. Rev-list options may also be given, but any that would
 change how the range is walked are overridden with a warning.
 +
+Without _<revision-range>_, all commits on the current branch that are not in
+its upstream are squashed, starting from the merge base of `HEAD` and
+`@{upstream}`.
++
 An editor opens pre-filled with the messages of all the folded commits so you
 can combine them. With `--no-edit`, the oldest commit's message is preserved
 instead, except that an `amend!` commit targeting it replaces its message.
diff --git a/builtin/history.c b/builtin/history.c
index 43ba76f5a1..0e5c5f2cc8 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -38,7 +38,7 @@
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
 #define GIT_HISTORY_SQUASH_USAGE \
-	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>")
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] [<revision-range>]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1319,7 +1319,7 @@ static int build_squash_message(struct repository *repo,
 				struct strbuf *out);
 
 static int setup_squash_revisions(struct repository *repo,
-				  int argc, const char **argv,
+				  struct strvec *args,
 				  struct rev_info *revs)
 {
 	repo_init_revisions(repo, revs, NULL);
@@ -1331,9 +1331,9 @@ static int setup_squash_revisions(struct repository *repo,
 	revs->limited = 1;
 	revs->ancestry_path_implicit_bottoms = 1;
 
-	argc = setup_revisions(argc, argv, revs, NULL);
-	if (argc > 1)
-		return error(_("unrecognized argument: %s"), argv[1]);
+	setup_revisions_from_strvec(args, revs, NULL);
+	if (args->nr > 1)
+		return error(_("unrecognized argument: %s"), args->v[1]);
 
 	if (revs->reverse != 1 || revs->topo_order != 1 ||
 	    revs->sort_order != REV_SORT_IN_GRAPH_ORDER ||
@@ -1372,7 +1372,7 @@ static int setup_squash_revisions(struct repository *repo,
 static int resolve_squash_range(struct repository *repo,
 				bool update_branches,
 				bool edit_message,
-				int argc, const char **argv,
+				struct strvec *args,
 				struct commit **oldest_out,
 				struct commit **tip_out,
 				char **message_out)
@@ -1387,7 +1387,7 @@ static int resolve_squash_range(struct repository *repo,
 	struct ref_array refs = { 0 };
 
 	subject_data.edit_message = edit_message;
-	ret = setup_squash_revisions(repo, argc, argv, &revs);
+	ret = setup_squash_revisions(repo, args, &revs);
 	if (ret < 0)
 		goto out;
 
@@ -1612,6 +1612,28 @@ out:
 	return ret;
 }
 
+static int default_squash_range(struct repository *repo, struct strvec *args)
+{
+	struct commit *upstream, *head;
+	struct commit_list *bases = NULL;
+
+	upstream = lookup_commit_reference_by_name("@{upstream}");
+	if (!upstream)
+		return error(_("could not resolve the upstream of HEAD"));
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head)
+		return error(_("could not resolve HEAD"));
+	if (repo_get_merge_bases(repo, upstream, head, &bases) < 0)
+		return -1;
+
+	strvec_push(args, "squash");
+	for (struct commit_list *b = bases; b; b = b->next)
+		strvec_pushf(args, "^%s", oid_to_hex(&b->item->object.oid));
+	strvec_push(args, "HEAD");
+	commit_list_free(bases);
+	return 0;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1636,6 +1658,7 @@ static int cmd_history_squash(int argc,
 		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
+	struct strvec args = STRVEC_INIT;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct commit *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1647,19 +1670,22 @@ static int cmd_history_squash(int argc,
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
-		ret = error(_("command expects a revision range"));
-		goto out;
+		ret = default_squash_range(repo, &args);
+		if (ret < 0)
+			goto out;
+	} else {
+		strvec_pushv(&args, argv);
 	}
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
 
 	strbuf_addstr(&reflog_msg, "squash: updating ");
-	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
+	strbuf_join_argv(&reflog_msg, args.nr - 1, args.v + 1, ' ');
 
 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
 				   edit,
-				   argc, argv, &oldest, &tip,
+				   &args, &oldest, &tip,
 				   &message_template);
 	if (ret < 0)
 		goto out;
@@ -1693,6 +1719,7 @@ static int cmd_history_squash(int argc,
 	ret = 0;
 
 out:
+	strvec_clear(&args);
 	strbuf_release(&reflog_msg);
 	release_revisions(&revs);
 	free(message_template);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 237afdfa26..ac33d1cec3 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -111,9 +111,36 @@ test_expect_success 'setup linear history touching two files' '
 		test_commit three file d
 '
 
-test_expect_success 'errors on missing range argument' '
+test_expect_success 'errors on missing range argument without an upstream' '
 	test_must_fail git history squash 2>err &&
-	test_grep "expects a revision range" err
+	test_grep "no upstream configured" err
+'
+
+test_expect_success 'squashes the commits not in the upstream by default' '
+	test_when_finished "rm -rf upstream downstream" &&
+	git init upstream &&
+	(
+		cd upstream &&
+		test_commit base
+	) &&
+	git clone --single-branch upstream downstream &&
+	(
+		cd upstream &&
+		test_commit upstream-moved
+	) &&
+	(
+		cd downstream &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git fetch &&
+		git history squash --no-edit &&
+		check_log_subjects HEAD <<-\EOF &&
+		one
+		base
+		EOF
+		test_cmp_rev three^{tree} HEAD^{tree}
+	)
 '
 
 test_expect_success 'errors on an empty range' '

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
