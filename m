Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5314183BF
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599469; cv=none; b=cfqRvvhMAfqikeFpyQLm2PHbOxX44ps7npXhOov3KVBYmzYKBedDHHAJpiVTx1SpW0bDMlAa/nbqWwH7x7jb7TiiynOT9sm81dfLRWRPNa/t02AuAqiojQV4+6yFkAYCFuH+Pd64OBjev8/W0Q5UFgAMVqnBT7kw6Yd0PLucE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599469; c=relaxed/simple;
	bh=2UChf4HHkY7NtRMuhOUaufj3qCjWt6nBgfOQoTFhlMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDT86OOAR5sSE+f231OLfDgAlUbGlg9GNPHT6T/dXhkls62q00Oz15Jw17DYNy7CtpVv2w9IVp9fakQ2UWFawhnSxaUDonywMHUbDj3iQSk4iD4gnj3k4Ko9cNfmua002ajJtDo4cYuvj9GhZ+EII3tzCZH5gsNlYiAyHhtdYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qlb7o+nn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LnJE0zo3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qlb7o+nn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LnJE0zo3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DD1B01D00119;
	Tue, 16 Jun 2026 04:44:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 04:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781599467;
	 x=1781685867; bh=iEmWNpFXAxgIBlBGANQ62MbMoPxlM4jUYyCzraYgZto=; b=
	Qlb7o+nnnppl3tb8zqPCA1UK+Zj8lYPSO7zMebRTLMRjERF0V1UgM36J/l6i2ths
	KLfM0Ec2zhoche9pMpxSdYmu9F1Hh8vWJnxc3//3X1gYtBA7ATD7soZV7/cePiN9
	N1sEAYskQhsePwORlfZFws8mqzeihPSZH4VT3TlH7BLf7oSoSR0JQz3+dl4KWir6
	XczaFgOVc9K8SUWmsOQeIytzMNFwR+9AyLJk5F4ivhTTIsg5ifVG/PQeqgKO5PZR
	17r6QXHJjdNwfNhamn4xAL3aY3Mu/yyCCZ7xFTZvpVqjL1dBoS8UoC5+fVWKZHXW
	Cx8efGo+22Epql511S74MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781599467; x=
	1781685867; bh=iEmWNpFXAxgIBlBGANQ62MbMoPxlM4jUYyCzraYgZto=; b=L
	nJE0zo3F7jEzjZI8GAf2oLbcVNG+aU1FGl71StmMx34EmQV9+MTNej34PhaZh9rZ
	1Xi467Ol68pZHC4fXGG77RiXZKV5nonBzoGD6w9t4rr88mbG0k9DnxxOCihc2Ziy
	tDsI/CwgOGVwqLyHtVn9VVqrsWFmqkAiedDqLARb1wu6lSa9O85IK3auj8AZDhSt
	Gjnldxtw6hnqL//JyZgptLZTRmreV6BDgw0kArk+MlH6Za0krmKn3aWpH5ruklns
	XKSPGmkmn65xkZHzydcgGBmMcqs5McXk0wBbmf4IA5HHzpk2ic5EZdjBIumqZb+X
	D28Mk6fRr8KDWxT16Xjew==
X-ME-Sender: <xms:6wwxagG_vDSSfx_My3X-qumJUXP18UEgNu_62eQY2SRbluRWCoBYeg>
    <xme:6wwxavXYd9M2g_6hGUiTz28RYDWHjWOB79cD7A_H8oNawphDWGDC_GF6PkjO3jSos
    RQaNt_xmiMZxnfyqfgKtgs27gtslk_e9nxxF8LIUNLRYe_NJ-wx>
X-ME-Received: <xmr:6wwxanx0GGO4C_Q9yMUQ6RxdXe2iglbnDSNQJPiVU3WxR0xZIdOFFalBW-nJoEvIPI7RkbgFRntEP9JVtBY0yWH3tHXd0_YppnSEeTq_nfX7bw>
X-ME-Proxy-Cause: dmFkZTFBk5CWSueBh1W9d8KzddL0zCsFFQZw01Xrj+/G5WsDERV5CEq8iQgMA6rkpb01Ha
    XO2sPvtgztpkfBWoASmLj0xbcH+OHbEp/Ntqa65jJ4lH6/LQsqzJ7SHT2FgmtGJB1bHeOC
    XIiagSI94YMf3JJr8g7IUXkjs6Pr+wY/2pTVtxWi1fdmXxZn+NBj8tS76E8hIvNsBuZH+U
    ZHkSQm05igjvDv2JMx40FszLieL925SSqFNBjj2D1t/vQhNyThEajaqNQ/yZQKKtGC60AS
    8hoKIO7fl2Xgg5O+wx88z/9O8HKF0b73BMtkEJnjSrGaDQbnxxwJdEfVcGMAxHBIm2BdAZ
    49VDxp+LFxN32PbRMfmTjkU+XiJjRP5JUMNkj14GBU/gz+fYBJJXNJgEq3BvADZYAgxhfe
    1v6GHgciFTIyoz5wyK4RN5CYHjhO3rAWo9FXzqZhLuV+nz/UZqKLL6SsPF/wKgoz68QRZ6
    Yp8ZPAd3bdlwVdeK3u9GLWMsEN5t1+BF9BvJBFPe+K+AZh9UmX9Vv0r1GjmAuY8rA2Dgl2
    6HICFgowJSd5893+jUqSo4Bcmt0f7vT/qUMQkkk3cKqFFT0AVg+3ry3vXjC8rSN/gLRUZy
    p1iI9fm5zok+slTIs6vv3JNN35X65uut56I1QA9AbWmIGs3uV7GI8V/GwE5Q
X-ME-Proxy: <xmx:6wwxatNJOzxJNSVQk42O3xWrWE8BmbT5TkCKdrECV9wfR3iteem6pg>
    <xmx:6wwxao5-3NtF-82K7K-LK0G4tnQp1bRUQmP26fe4xEig7LQgs5tkfQ>
    <xmx:6wwxauNhFSMLu5Cw4cKqnOzqRiQshCnPwVsN32GFXbjCwCsfuHv5Qw>
    <xmx:6wwxamlS5RhCAyYzlgeYEfd8HSBzTLB2opzwy-ARfeSdtihETcDPtw>
    <xmx:6wwxardhSpbkG9XUSh33z_t65HFMJ2BdLJBmBr0UiV6kvnS8oRlrxQ2q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:44:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dd9102b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:44:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 16 Jun 2026 10:44:09 +0200
Subject: [PATCH 4/4] builtin/refs: add "rename" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-pks-refs-writing-subcommands-v1-4-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Add a "rename" subcommand to git-refs(1) with the syntax:

  $ git refs rename <oldref> <newref>

It renames <oldref> together with its reflog to <newref>; even when used
on a local branch ref, the current value and the reflog of the ref are
the only things that are renamed. Document it and redirect casual users
to "git branch -m" if that is what they wanted to do.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |  10 ++++
 builtin/refs.c              |  42 ++++++++++++++
 t/meson.build               |   1 +
 t/t1466-refs-rename.sh      | 131 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 0a887cf5e5..85eb100205 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -22,6 +22,7 @@ git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs delete [--message=<reason>] [--no-deref] <ref> [<oldvalue>]
 git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
+git refs rename [--message=<reason>] <oldref> <newref>
 
 DESCRIPTION
 -----------
@@ -65,6 +66,11 @@ update::
 	`<old-value>` is given, the reference is only updated after verifying
 	that it currently contains `<old-value>`.
 
+rename::
+	Rename the reference `<oldref>` to `<newref>`. The old reference must
+	exist and the new reference must not yet exist, and both must have a
+	well-formed name (see linkgit:git-check-ref-format[1]).
+
 OPTIONS
 -------
 
@@ -106,6 +112,10 @@ include::pack-refs-options.adoc[]
 
 The following options are specific to commands which write references:
 
+`--create-reflog`::
+	Create a reflog for the reference even if one would not ordinarily be
+	created.
+
 `--message=<reason>`::
 	Use the given <reason> string for the reflog entry associated with the
 	update. An empty message is rejected.
diff --git a/builtin/refs.c b/builtin/refs.c
index 3238ddf3f0..b90baf5633 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -27,6 +27,9 @@
 #define REFS_UPDATE_USAGE \
 	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
 
+#define REFS_RENAME_USAGE \
+	N_("git refs rename [--message=<reason>] <oldref> <newref>")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -267,6 +270,43 @@ static int cmd_refs_update(int argc, const char **argv, const char *prefix,
 			       UPDATE_REFS_DIE_ON_ERR);
 }
 
+static int cmd_refs_rename(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_rename_usage[] = {
+		REFS_RENAME_USAGE,
+		NULL
+	};
+	const char *message = NULL;
+	struct option opts[] = {
+		OPT_STRING(0, "message", &message, N_("reason"),
+			   N_("reason of the update")),
+		OPT_END(),
+	};
+	const char *oldref, *newref;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_rename_usage, 0);
+	if (argc != 2)
+		usage(_("rename requires old and new reference name"));
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	oldref = argv[0];
+	newref = argv[1];
+
+	if (check_refname_format(oldref, 0))
+		die(_("invalid ref format: %s"), oldref);
+	if (check_refname_format(newref, 0))
+		die(_("invalid ref format: %s"), newref);
+
+	if (!refs_ref_exists(get_main_ref_store(repo), oldref))
+		die(_("reference does not exist: '%s'"), oldref);
+	if (refs_ref_exists(get_main_ref_store(repo), newref))
+		die(_("reference already exists: '%s'"), newref);
+
+	return refs_rename_ref(get_main_ref_store(repo), oldref, newref, message);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -280,6 +320,7 @@ int cmd_refs(int argc,
 		REFS_OPTIMIZE_USAGE,
 		REFS_DELETE_USAGE,
 		REFS_UPDATE_USAGE,
+		REFS_RENAME_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -291,6 +332,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
 		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
+		OPT_SUBCOMMAND("rename", &fn, cmd_refs_rename),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 2063962dab..a1a6880fe6 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -225,6 +225,7 @@ integration_tests = [
   't1463-refs-optimize.sh',
   't1464-refs-delete.sh',
   't1465-refs-update.sh',
+  't1466-refs-rename.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1466-refs-rename.sh b/t/t1466-refs-rename.sh
new file mode 100755
index 0000000000..f80d58e0f4
--- /dev/null
+++ b/t/t1466-refs-rename.sh
@@ -0,0 +1,131 @@
+#!/bin/sh
+
+test_description='git refs rename'
+
+. ./test-lib.sh
+
+setup_repo () {
+	git init "$1" &&
+	test_commit -C "$1" A &&
+	test_commit -C "$1" B
+}
+
+test_ref_matches () {
+	git rev-parse "$1" >expect &&
+	echo "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'rename an existing reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		git refs rename refs/heads/foo refs/heads/bar &&
+		test_must_fail git refs exists refs/heads/foo &&
+		test_ref_matches refs/heads/bar $A
+	)
+'
+
+test_expect_success 'rename moves the reflog along with the reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update --message="rename me" refs/heads/foo $A &&
+		git refs rename refs/heads/foo refs/heads/bar &&
+		git reflog show refs/heads/bar >reflog &&
+		test_grep "rename me" reflog &&
+		test_must_fail git reflog exists refs/heads/foo
+	)
+'
+
+test_expect_success 'rename with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		git refs rename --message="rename reason" refs/heads/foo refs/heads/bar &&
+		git reflog show refs/heads/bar >actual &&
+		test_grep "rename reason" actual
+	)
+'
+
+test_expect_success 'rename a nonexistent reference fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs rename refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "reference does not exist" err
+	)
+'
+
+test_expect_success 'rename to an existing reference fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/bar $B &&
+		test_must_fail git refs rename refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "reference already exists" err
+	)
+'
+
+test_expect_success 'rename with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs rename --message= refs/heads/foo refs/heads/bar 2>err &&
+		test_grep "empty message" err
+	)
+'
+
+test_expect_success 'rename with invalid old reference name fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs rename "refs/heads/foo..bar" refs/heads/bar 2>err &&
+		test_grep "invalid ref format" err
+	)
+'
+
+test_expect_success 'rename with invalid new reference name fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs rename refs/heads/foo "refs/heads/bar..baz" 2>err &&
+		test_grep "invalid ref format" err
+	)
+'
+
+test_expect_success 'rename with too few arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs rename refs/heads/foo 2>err &&
+	test_grep "requires old and new reference name" err
+'
+
+test_expect_success 'rename with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs rename refs/heads/foo refs/heads/bar refs/heads/baz 2>err &&
+	test_grep "requires old and new reference name" err
+'
+
+test_done

-- 
2.55.0.rc0.786.g65d90a0328.dirty

