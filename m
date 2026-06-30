Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3740627B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820161; cv=none; b=Uz+9ZAfZMYXcAD8MPPP722TWBMPAuR8OeYlrAllm6IKyhiL2RVX48DdbnVuOEylk8/Hxs5EndHfqQjJgfs7sIs8X0CoNBQximst0oSeKWAqnCcdl/GOLmCj1aLhwYyiOvTPsgueTlg4V0woRcab82o4l6fEAuyW2aIQhnAn/G8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820161; c=relaxed/simple;
	bh=oRsYUt+OvFNQ3qt3Pr+cFVywbi4vUNqoaQ08vKYI3RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzYbhFpAm3Fq+zuQHTJ1HkKUtgBb57i7yN6Fbq3gmplr+vfXO8B3YbuAZHPv4NEsAM0CiEMH0+wyhtsN10BMzLIsmfREwoT78QNsvgk5QR9UOq8Zm1icpdtSbaC+ZNdUMaU7ZfKNUOs3cXFeDns3dtPZHSa/PaduamjavQNwRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=riNCkS54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R46iVgK9; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="riNCkS54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R46iVgK9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A4CE1D000D6;
	Tue, 30 Jun 2026 07:49:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 07:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820158;
	 x=1782906558; bh=XQPBeukgYe9N+8r2CyyHDIijfdh9KpXhjW7GWU0YD0M=; b=
	riNCkS54XhjOWPvVaumzpn90QK+pWCZwwdKijh/scP23EVBM5/xl/ZnbNi/Jdx8M
	+tRaVSqBg/W9/5BILILpU5SAnGorjjB+IoHlJlrys9sEFbt0NtKseoLqrVTZmfFP
	sF4LPLW1JsY6OrP4kGGIYRiH9W3ohLqin9Xz77z2mdUOMBJzte5I3azvE2tBWrPq
	Mr0NZsh+PWj9NpS+e7jDjDGjt1PiP0Pj50cctZNVE2E8gc+TD/lU017J1TzrPgWG
	Ff1ObbZh1YlyUNn2F65JKQR4332ClpvMLg6rX/aN6D0nmDIa/+pNmxwNC7MEuFrS
	LG0yCy5tR9goAifT9b241g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820158; x=
	1782906558; bh=XQPBeukgYe9N+8r2CyyHDIijfdh9KpXhjW7GWU0YD0M=; b=R
	46iVgK9wFVclwh9VL4TxRJFn2hHmtfcIO013rPvdxYUGesdRbQkKWE7earYGD1OO
	MAMDTUuICtKnL2vcf8sfTiv6tu6d/fcp2lDxueesRMr+GG89MegfLivS9SmmVE1z
	AuWNoCxn0GXbRZylRkhXtCZBIt+FD5iNmIkW2BFU4gKj9y7Avu44wAZJN4MENsWR
	pzhRc9aAyoDfDFFWKdckpo0F2UobnaVbiRL2DtCs83W5WMn0Jm+hrcUCW2bj1jgR
	VU9WrUTGxYs6g/omp0SnPkFWctCjr8VyGTJNEznhKtfiLAqkr+5sLBgJvxcUkxg6
	tas4i04tvRcMwScNrQQEA==
X-ME-Sender: <xms:Pq1Dat6kn3O7U_x9FT5dGK5TPcl8G0wwiAO39fV14qFXscmdFNEr3w>
    <xme:Pq1Dag5GVALESWBooB6PWuTAAV4dTnP2-hOXH6MAr41C-rORM_Xec1Q-QNWusRbfR
    QcKQjPp8n-ePwqd_dKdGhbP8CSvvGDIEcd4cw-SgMHrJOFqpvy5>
X-ME-Received: <xmr:Pq1DaiFeA6JFji9rYGIdZmr78LgTb0QPePxFl4RG5KO_MRboElGN6UG-m_10Lx7cNBXMetKasAYc-jSJIuo5jjqU-oeg0tmQGlgIR9ONLuPzkw>
X-ME-Proxy-Cause: dmFkZTGa65W6+of1Q4+eW6G2IMPlthsJffBXuRILpRstTzA1oUOCmOWTHFUW4BiZ64SG6R
    v0B+R/yU7mkHHGco8rzYcWUss+p9sUt2A4vEaicKdlFfvp1ySYZfQ8+jnPZ0WJqVAI/wT1
    haTi4iiqGSMRmt75N9WtsQUF4C1ZmWBP5HHRHgGhK3sSwA/1aElaMC7bDURFAnu4El1raE
    Um7DuVgwCbmi2FtLLatW2+HbwKcGGU8whY4hHj3Lv27JPYKUl6EXbhQKCEta0Mg1XC2blD
    4BBCkWWmyG53ivt/t4iHYa8gFDObrpO5+XJoaoFtTd6w99tqre8SYtvH2Op4rncNDeCKdH
    wkZrMGGjAdOYwcKEIA5Q3fJmYSkbIOd5OSg3CkxpYPUoDg3Czme78L1s2z7TiyHV4VPNwE
    EswAO37gnEHnu/8jJYqAz7XpIIgLoI1ksXoVY2nvuKiIaCtjjKyBNWkWh6zRdXNmz5iltF
    RkHiug1d4bbE/NOWL0QmjKL745kfW5T/333JAzwIeQsl/fVzG4/IWc0xLeCr156tE7hyqm
    z9TjVmWqbE4WBtC4wrhFn45TUFBAua4v04SxvXUoy1eZgBYtj3Vb08ZnerADSvFE6ikgEs
    VJVfYxUrVGcQP/Sp0lKPSA97Pkzr3CgVxae3gU9tXddN2gd7zz7TJ8uGfU4w
X-ME-Proxy: <xmx:Pq1DahQDR47jh6V7VApDSMGW3pzX6HhRdEp8s4CFVbdIHQ7_ftORPA>
    <xmx:Pq1DajvFNnnIMwczG9dZWZairS1YJBOZctRpuE2adys2agck49xbkA>
    <xmx:Pq1DaozngGuapO0xFR0dffztfJ4FSi0b6oL9rbWIg_hbTM4F6oj1uw>
    <xmx:Pq1Dal4Rj04aRhT-4FreEhdjRLeCNXKcWCVt8qKFc-TvXiBHNzbkzw>
    <xmx:Pq1DahR6LjDBCrx_LwHIeOnrV2AFyQo5Wq5j-YCkJl8DX00Hhdx0no6k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:49:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 094ddf4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:49:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:49:06 +0200
Subject: [PATCH v3 3/5] builtin/refs: add "update" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-refs-writing-subcommands-v3-3-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Add a new "update" subcommand which mirrors `git update-ref <refname>
<oldoid> <newoid>`. This follows the same reasoning as the preceding
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-refs.adoc |  12 ++
 builtin/refs.c              |  55 +++++++++
 t/meson.build               |   1 +
 t/t1465-refs-update.sh      | 268 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 2633934463..6475bdcc62 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -21,6 +21,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
+git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
 
 DESCRIPTION
 -----------
@@ -58,6 +59,13 @@ delete::
 	reference is only deleted after verifying that it currently contains
 	`<old-value>`.
 
+update::
+	Update the given reference to point at `<new-value>`. If `<old-value>`
+	is given, the reference is only updated after verifying that it
+	currently contains `<old-value>`. As a special case, an all-zeroes
+	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
+	ensures that the branch does not yet exist.
+
 OPTIONS
 -------
 
@@ -99,6 +107,10 @@ include::pack-refs-options.adoc[]
 
 The following options are specific to commands which write references:
 
+`--create-reflog`::
+	Create a reflog for the reference even if one would not ordinarily be
+	created.
+
 `--message=<reason>`::
 	Use the given <reason> string for the reflog entry associated with the
 	update. An empty message is rejected.
diff --git a/builtin/refs.c b/builtin/refs.c
index edb7d61663..08453ae1c8 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -24,6 +24,9 @@
 #define REFS_DELETE_USAGE \
 	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
 
+#define REFS_UPDATE_USAGE \
+	N_("git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo)
 {
@@ -224,6 +227,56 @@ static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_update(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_update_usage[] = {
+		REFS_UPDATE_USAGE,
+		NULL
+	};
+	const char *message = NULL;
+	unsigned flags = 0;
+	struct option opts[] = {
+		OPT_STRING(0, "message", &message, N_("reason"),
+			   N_("reason of the update")),
+		OPT_BIT(0 ,"no-deref", &flags,
+			N_("update <refname> not the one it points to"),
+			REF_NO_DEREF),
+		OPT_BIT(0, "create-reflog", &flags, N_("create a reflog"),
+			REF_FORCE_CREATE_REFLOG),
+		OPT_END(),
+	};
+	struct object_id newoid, oldoid;
+	const char *refname;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, opts, refs_update_usage, 0);
+	if (argc < 2 || argc > 3)
+		usage(_("update requires reference name, new value and an optional old value"));
+
+	if (message && !*message)
+		die(_("refusing to perform update with empty message"));
+
+	repo_config(repo, git_default_config, NULL);
+
+	refname = argv[0];
+	if (repo_get_oid_with_flags(repo, argv[1], &newoid,
+				    GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid new object ID: '%s'"), argv[1]);
+	if (argc == 3 &&
+	    repo_get_oid_with_flags(repo, argv[2], &oldoid,
+				    GET_OID_SKIP_AMBIGUITY_CHECK))
+		die(_("invalid old object ID: '%s'"), argv[2]);
+
+	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
+			      &newoid, argc == 3 ? &oldoid : NULL, flags,
+			      UPDATE_REFS_MSG_ON_ERR);
+
+	if (ret < 0)
+		ret = 1;
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -236,6 +289,7 @@ int cmd_refs(int argc,
 		REFS_EXISTS_USAGE,
 		REFS_OPTIMIZE_USAGE,
 		REFS_DELETE_USAGE,
+		REFS_UPDATE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -246,6 +300,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
+		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 1ccf08a3b5..2063962dab 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1462-refs-exists.sh',
   't1463-refs-optimize.sh',
   't1464-refs-delete.sh',
+  't1465-refs-update.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1465-refs-update.sh b/t/t1465-refs-update.sh
new file mode 100755
index 0000000000..a9becdda99
--- /dev/null
+++ b/t/t1465-refs-update.sh
@@ -0,0 +1,268 @@
+#!/bin/sh
+
+test_description='git refs update'
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
+test_expect_success 'update creates a new reference' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A &&
+		test_ref_matches refs/heads/foo "$A"
+	)
+'
+
+test_expect_success 'update an existing reference without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/foo $B &&
+		test_ref_matches refs/heads/foo $B
+	)
+'
+
+test_expect_success 'update with matching oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update refs/heads/foo $B $A &&
+		test_ref_matches refs/heads/foo $B
+	)
+'
+
+test_expect_success 'update with stale oldvalue fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $B 2>err &&
+		test_grep " but expected " err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can create a new branch with oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A $ZERO_OID 2>err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can create a new branch without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update refuses to create preexisting branch' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
+		test_grep "reference already exists" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update can delete a branch with oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		git refs update refs/heads/foo $ZERO_OID $A 2>err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update can delete a branch without oldvalue' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/heads/foo $A 2>err &&
+		git refs update refs/heads/foo $ZERO_OID 2>err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update refuses to delete a branch with mismatching value' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A 2>err &&
+		test_must_fail git refs update refs/heads/foo $ZERO_OID $B 2>err &&
+		test_grep " but expected " err &&
+		git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update refuses to create preexisting branch' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B $ZERO_OID 2>err &&
+		test_grep "reference already exists" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+
+test_expect_success 'update with invalid new value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		test_must_fail git refs update refs/heads/foo invalid-oid 2>err &&
+		test_grep "invalid new object ID" err &&
+		test_must_fail git refs exists refs/heads/foo
+	)
+'
+
+test_expect_success 'update with invalid old value fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update refs/heads/foo $B invalid-oid 2>err &&
+		test_grep "invalid old object ID" err &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update --no-deref rewrites the symref itself' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git symbolic-ref refs/heads/symref refs/heads/foo &&
+		git refs update --no-deref refs/heads/symref $B &&
+		test_must_fail git symbolic-ref refs/heads/symref &&
+		test_ref_matches refs/heads/symref $B &&
+		test_ref_matches refs/heads/foo $A
+	)
+'
+
+test_expect_success 'update does not create a reflog by default' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update refs/foo $A &&
+		test_must_fail git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'update creates a reflog with --create-reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		git refs update --create-reflog refs/foo $A &&
+		git reflog exists refs/foo
+	)
+'
+
+test_expect_success 'update with message records reason in reflog' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		git refs update --message=update-reason refs/heads/foo $B &&
+		git reflog show refs/heads/foo >actual &&
+		test_grep "update-reason$" actual
+	)
+'
+
+test_expect_success 'update with empty message fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		git refs update refs/heads/foo $A &&
+		test_must_fail git refs update --message= refs/heads/foo $B 2>err &&
+		test_grep "empty message" err
+	)
+'
+
+test_expect_success 'update with too few arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	test_must_fail git -C repo refs update refs/heads/foo 2>err &&
+	test_grep "requires reference name, new value" err
+'
+
+test_expect_success 'update with too many arguments fails' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo repo &&
+	(
+		cd repo &&
+		A=$(git rev-parse A) &&
+		B=$(git rev-parse B) &&
+		test_must_fail git refs update refs/heads/foo $A $B extra 2>err &&
+		test_grep "requires reference name, new value" err
+	)
+'
+
+test_done

-- 
2.55.0.795.g602f6c329a.dirty

