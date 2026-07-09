Received: from mta246b-ord.mtasv.net (mta246b-ord.mtasv.net [104.245.209.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0F347506
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640355; cv=none; b=H0v83r5z3sCtduyJpUAoofiWzeBUrnMQlIGqFPBZsyCZL9i1+CXjNGUepcO2SxyPQoclQN40onL7zHc1PU4/yaOt2LemY324WMImRqf4ksgobfrxyVjv19lW9VT1iIk829xVkxune8r5l8K5IQrqgAJHQmFFj/F1Ps5AjByY2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640355; c=relaxed/simple;
	bh=+lGChx+foNcUelvpqx54x5rnJTNuojrGOUdwXWAZNrs=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omQwNrxk3vFnyEr3lOYtxam2pdu7P+OH7FxgPb9glCPmWVDFB0Q94PGIMKeKVVeOviNnWfqPB1PpX0IrNcfSJk9gvt1zj5B3ZBVafF0nqMpZUzUOtZtogUKwnd6pU8n8CSA5SBc2A4rJ9eLVMgJkTL57Qv1bxmFU19shiLdVYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=KvDJiLHp; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=D1F1ceQF; arc=none smtp.client-ip=104.245.209.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="KvDJiLHp";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="D1F1ceQF"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=PAzhcmDVUIru4m7PRCLapdS/CE6F73caDRNdG+eyW9E=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1783640169; x=1784244969;
	b=KvDJiLHp/xNxLPpYtFQBTuHoQcYrid35aP6WWFhw1WKBy9KuDsIvUYoQfCl8U8ggWifn3KWaH
	5p++/oYnUfVEzobgkGBY0sqpcoSCliTHBBA71GhPK0PGk2WwNcBdczcaLx0ZlouKyjlQjM0kiJ1
	hMg8iiibsOYlQHpsx3SMzoWUJegzgS8a7HwSMB7nj0iP8r9XT/7TAuiN41E+3kH5cmn1qw39MR3
	DRUP0QryWjL0JcsQNcgAE9Z5yNwZs9jjsN+Pd7ZjBu6BhaiNw6nczhmj894ERm5FC5mLAJtnNjJ
	jlNpEDKFOITLzX6Rkyn1xdh53QuJjMTr9UVHjgMEFfww==;
Received: from ip-172-26-23-225.us-east-2.compute.internal (172.26.23.225)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.240.239) 
  with ESMTP id f6a2f4527bee11f1a9d302ee81437095 for <git@vger.kernel.org>;
  Thu, 9 Jul 2026 23:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1783640169; x=1783812969;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=PAzhcmDVUIru4m7PRCLapdS/CE6F73caDRNdG+eyW9E=;
	b=D1F1ceQFKb1QLqyam5RqwaZVwUyXDjhoK2fz/NI4S4OuCATY4aJ776chg9KLViAOom8wDcT7gTc
	zOz4Eq3tYy+KpA/F6CozM0TNzUztx8xHKuCnP9R8qkeh3rzyRJ89hMYc514tY0mltIZA0A6SmzTqN
	tCgqvNqjgOh+2kODNOs=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Thu, 09 Jul 2026 23:36:09 +0000
Subject: [PATCH v1 1/3] worktree: add post-worktree-add hook
Message-Id: <4864bcf9-1018-4b36-9239-47df247b8418@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, Claude Fable 5
	<noreply@anthropic.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709233542.628628-1-domen@cachix.org>
References: <20260709233542.628628-1-domen@cachix.org>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 4864bcf9-1018-4b36-9239-47df247b8418
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.NSYs_k8hW6EmjzA0TSEk6w.zfnkPoUMPNwnhUFPr_HlET2VPgUxz6WRbyAtOE9GIR7zi5HOe0Q50pfeW7zNgILIMdoivSBvtegVmZc36s5O7lh-Jt3K3XPcPy7u4_3YYE-7i48TdPqLY6M6fSpGzXbpCGBuvU7iN4a-hdHS_qYR_EEwskUCiB7zkQaQN0LmjnwO3te31C5iCorArYjCFT8r
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-246
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tools that manage per-worktree state, such as development environment
managers or IDEs, have no way to react when a new working tree is
created. The only hook that fires during "git worktree add" is
post-checkout, which is skipped when --no-checkout or --orphan is used
and cannot be distinguished from a plain checkout.

Introduce a post-worktree-add hook that runs after the working tree
has been fully set up, including with --no-checkout and --orphan. The
hook runs inside the new working tree with GIT_DIR and GIT_WORK_TREE
cleared, mirroring the existing post-checkout invocation, and is given
the absolute path of the new working tree and its identifier as
arguments. Anything else, such as the checked-out branch, can be
queried by running git from the hook's working directory.

Like post-checkout, the hook cannot affect the outcome of the command:
a failing hook does not delete the already-created working tree, but
its exit status becomes the exit status of "git worktree add". The
hook runs after post-checkout and is skipped if that hook fails.

Documenting the new hook in githooks(5) also registers its name in the
generated hook-list.h, so "git hook run" and hook.*.event recognize it
without further changes.

Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 Documentation/githooks.adoc |  20 +++++++
 builtin/worktree.c          |  15 ++++-
 t/t2400-worktree-add.sh     | 113 ++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..2778f73f30 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -215,6 +215,26 @@ This hook can be used to perform repository validity c=
hecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+post-worktree-add
+~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-worktree[1] after `git worktree add`
+has created and set up a new working tree. The hook is given two
+parameters: the absolute path of the new working tree and its identifier
+(the name of its administrative directory in `$GIT_DIR/worktrees/`).
+
+The hook runs inside the new working tree, so further details, such as
+the checked-out branch, can be queried by running `git` from the hook's
+current directory. Unlike the `post-checkout` hook, it is also run when
+`--no-checkout` or `--orphan` is used.
+
+This hook cannot affect the outcome of `git worktree add`, other than
+that the hook's exit status becomes the exit status of the command. It
+runs after the `post-checkout` hook, and is skipped if that hook fails.
+
+This hook can be used to set up per-worktree development environments
+or to register the new working tree with external tools.
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..7b9d337234 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -605,8 +605,9 @@ static int add_worktree(const char *path, const char *r=
efname,
 	}
=20
 	/*
-	 * Hook failure does not warrant worktree deletion, so run hook after
-	 * is_junk is cleared, but do return appropriate code when hook fails.
+	 * Hook failures do not warrant worktree deletion, so run hooks after
+	 * is_junk is cleared, but do return appropriate code when a hook
+	 * fails.
 	 */
 	if (!ret && opts->checkout && !opts->orphan) {
 		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
@@ -622,6 +623,16 @@ static int add_worktree(const char *path, const char *=
refname,
 		ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
 	}
=20
+	if (!ret) {
+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args, wt->path, wt->id, NULL);
+		opt.dir =3D path;
+
+		ret =3D run_hooks_opt(the_repository, "post-worktree-add", &opt);
+	}
+
 	strvec_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 58b4445cc4..3754559a98 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1132,6 +1132,119 @@ test_expect_success '"add" in bare repo invokes pos=
t-checkout hook' '
 	test_cmp hook.expect goozy/hook.actual
 '
=20
+# Install a post-worktree-add hook and write the output expected for
+# adding worktree $1; the hook is installed in repo $2 (default ".git").
+post_worktree_add_hook () {
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook -C "$2" post-worktree-add <<-\EOF &&
+	{
+		echo $*
+		git rev-parse --git-dir --show-toplevel
+	} >hook.actual
+	EOF
+	{
+		echo $(pwd)/$1 $1 &&
+		echo $(pwd)/${2:-.git}/worktrees/$1 &&
+		echo $(pwd)/$1
+	} >hook.expect
+}
+
+test_expect_success '"add" invokes post-worktree-add hook' '
+	post_worktree_add_hook wanda &&
+	git worktree add wanda &&
+	test_cmp hook.expect wanda/hook.actual
+'
+
+test_expect_success '"add" in other worktree invokes post-worktree-add hoo=
k' '
+	post_worktree_add_hook wilbur &&
+	git -C wanda worktree add ../wilbur &&
+	test_cmp hook.expect wilbur/hook.actual
+'
+
+test_expect_success '"add --no-checkout" still invokes post-worktree-add h=
ook' '
+	post_worktree_add_hook wendy &&
+	git worktree add --no-checkout wendy &&
+	test_cmp hook.expect wendy/hook.actual
+'
+
+test_expect_success '"add --orphan" invokes post-worktree-add hook' '
+	post_worktree_add_hook winnie &&
+	git worktree add --orphan winnie &&
+	test_cmp hook.expect winnie/hook.actual
+'
+
+test_expect_success '"add" in bare repo invokes post-worktree-add hook' '
+	rm -rf bare2 &&
+	git clone --bare . bare2 &&
+	post_worktree_add_hook willow bare2 &&
+	git -C bare2 worktree add --detach ../willow &&
+	test_cmp hook.expect willow/hook.actual
+'
+
+test_expect_success '"add" runs post-worktree-add after post-checkout' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	echo post-checkout >>hooks.actual
+	EOF
+	test_hook post-worktree-add <<-\EOF &&
+	echo post-worktree-add >>hooks.actual
+	EOF
+	test_write_lines post-checkout post-worktree-add >hooks.expect &&
+	git worktree add wobble &&
+	test_cmp hooks.expect wobble/hooks.actual
+'
+
+test_expect_success 'failing post-checkout hook suppresses post-worktree-a=
dd hook' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	exit 1
+	EOF
+	test_hook post-worktree-add <<-\EOF &&
+	>post-worktree-add.ran
+	EOF
+	test_must_fail git worktree add wozzle &&
+	test_path_is_missing wozzle/post-worktree-add.ran
+'
+
+test_expect_success 'failing post-worktree-add hook leaves worktree in pla=
ce' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree-add <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git worktree add wilma &&
+	git worktree list --porcelain >out &&
+	grep -F "worktree $(pwd)/wilma" out
+'
+
+test_expect_success 'failed "add" does not invoke post-worktree-add hook' =
'
+	test_when_finished "rm -rf .git/hooks occupied" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree-add <<-\EOF &&
+	>hook.ran
+	EOF
+	mkdir occupied &&
+	: >occupied/blocker &&
+	test_must_fail git worktree add occupied &&
+	test_path_is_missing occupied/hook.ran &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'post-worktree-add hook gets absolute path with relati=
ve worktrees' '
+	test_when_finished "rm -rf relhook" &&
+	git init relhook &&
+	test_commit -C relhook base &&
+	test_hook -C relhook post-worktree-add <<-\EOF &&
+	echo $* >hook.actual
+	EOF
+	git -C relhook worktree add --relative-paths --detach wt &&
+	echo $(pwd)/relhook/wt wt >hook.expect &&
+	test_cmp hook.expect relhook/wt/hook.actual
+'
+
 test_expect_success '"add" an existing but missing worktree' '
 	git worktree add --detach pneu &&
 	test_must_fail git worktree add --detach pneu &&
--=20
2.54.0
