Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4B31283B
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780635; cv=none; b=Lgjqh7FAe922Oj8X3r/m/a2FVZN8+DHQzF8xpKdOeTqtl8+G8aqIiXo9eHarn+cAJ+d4RgxfVagVm/mLcGVFcDMOTYSxbfpjnMu/ddGbqiJPIN+GTCvcGqfPsohGZgkkmNkzQRpIiPuocpBncQhQMtccg2HIHLSzouNBknQLE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780635; c=relaxed/simple;
	bh=YR2PAvQMR++i7VfmSgDIBwcYfc0OElNikVVvBLHRIDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjwoCCefI2nfyiVD/tSNMOittWli4on+ZKx/6R2gYFklxeLJHVDCy5e652oGq6yyjS9dlWb6eTxeQetEugzW9w6rNcCnXPl0ZXJpYUUDG0TS6GZSrbjzmYhe0ex3Rf13hRFEuiV0l6b/eQw+uDJNp+HY4rP/Xj8IIMx7SwAVZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bhw5cfoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1uS9l9Q; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bhw5cfoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1uS9l9Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EEFADEC0243;
	Wed,  7 Jan 2026 05:10:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780632;
	 x=1767867032; bh=LPCPElZszsYb4YA47nu8dcyMQn8GXqniw9CUgc6a5WA=; b=
	Bhw5cfoBwmyhedbu0Q6iYaAaxOXQgJGymTWes+Byrl4SSlQb12aX0IMEoGi39rRg
	d0yNGyZZnLkjw/duQqZWhc7KdQfP4TLs8CJ6VYCBBI6UHKKHKrq2itozUWP+TToc
	lVpubKYrt5R0egnt2xMCcQmAdKJrO70NR2ACx/fvJde/FGVIUDeFWNkicyjh4p4T
	+GnGTxLBAQBdMKo9V14Wc/QCsmLdccSvTp+7TxyeKHezURbH0QhYKKCp1KKuK6g5
	ap/w1ZCKeDABT0Yzhc7+zcK43x/dD7ZNU/PGC0fNvoJIM7UhhPFbzADDNvbd/Kml
	xcf1wOl0x6LyLJ8f/rWDmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780632; x=
	1767867032; bh=LPCPElZszsYb4YA47nu8dcyMQn8GXqniw9CUgc6a5WA=; b=s
	1uS9l9Qul1nvWpgm3jERaGnhCXpYw987rUwAtxyMzegcsSzK2GqydarHzJntA7m4
	W56o+6bFLtP8ItQBfghvX9fjIeLZWuaBNUWV+hWL3kiW/D69jCFR6GekRTg+Fnwv
	DXCqpjBht31EW/Zhx4xC0bpW2Mtq52UKbE43ttlL+bsa6+Vppm9mpgUwRi5UabT1
	4E8jOXia30/hCdt+eQoYd6/j2CpnjZb62yCcAhma58fQrce4DYUJ6kuvdai2EE8N
	4LhxVtGp0zt2uTWBRYq70tXLM23yCm/tuxFhncvs2PbAo1ActjrmZlGDxcsX/EWV
	p1s0KVQs7FMLO0DLP7ncg==
X-ME-Sender: <xms:GDFeaVWif33hI5b8kqnQPKyHqTmoBJju02EjR-oE8CUrtqJK54wheQ>
    <xme:GDFeaRbnvTSPB3PHWHLZ1_iEEtf0EYqPEw-ZkAny2suiVsMv-7O_CF8DnSqddvhGo
    ENQu3yzs1OTiixhdSg3vLl4eyHbxikRy0K_a1I6Vx0nNqOEktq_>
X-ME-Received: <xmr:GDFeacxhEvdUFtSP9Zx1CWK6hokHfsRaEUzlSQZaz1jmWaK0kWVcrCrbXYhGUudtB8UzxCo7zDGq3QfThS9wr3rgWccn5XI4r0nUD68wReM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlsegs
    vgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GDFeaR0pb_mSa2u7g7X0-Y8lNZp2EYciJIt-6UlN9XoJFwHA7QQdSw>
    <xmx:GDFeadkli2Y22_wypud3NI-2Jbf--iJFU52YXKIV0-lVAgLp7iBQhQ>
    <xmx:GDFeaQ_lSuoUlh1t6_LnZDLy0GisORtF1K0hENc_mfmue4nCySpYKQ>
    <xmx:GDFeaTIPHAGGQ2wJZZ4QqdYQ6pd4BiUDsf6j4HnN8q9ioh65FA872Q>
    <xmx:GDFeaUVXj7iGnyedna1qcsZqVnN-PEzrm7vT957meggPZEN9ztnAC52l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f472b50e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:14 +0100
Subject: [PATCH v8 6/7] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-6-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

When rewriting history via git-rebase(1) there are a few very common use
cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

  - Editing an existing commit that is not the tip of the current
    branch.

While these operations are all doable, it often feels needlessly kludgey
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Also, some operations like
splitting up a commit into two are way more involved than that and
require a whole series of commands.

Another problem that rebases have is that dependent branches are not
being updated. The use of stacked branches has grown quite common with
competiting version control systems like Jujutsu though, so it clearly
is a need that users have. While rebases _can_ serve this use case if
one always works on the latest stacked branch, it is somewhat awkward
and very easy to get wrong.

Add a new "history" command to plug these gaps. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 56 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 22 +++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  1 +
 t/t3450-history.sh             | 17 +++++++++++++
 11 files changed, 103 insertions(+)

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..24635cf2d6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,6 +79,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-history
 /git-hook
 /git-http-backend
 /git-http-fetch
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
new file mode 100644
index 0000000000..5a9d931efc
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,56 @@
+git-history(1)
+==============
+
+NAME
+----
+git-history - EXPERIMENTAL: Rewrite history
+
+SYNOPSIS
+--------
+[synopsis]
+git history [<options>]
+
+DESCRIPTION
+-----------
+
+Rewrite history by rearranging or modifying specific commits in the
+history.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+This command is related to linkgit:git-rebase[1] in that both commands can be
+used to rewrite history. There are a couple of major differences though:
+
+* linkgit:git-history[1] can work in a bare repository as it does not need to
+  touch either the index or the worktree.
+* linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
+  current point in time. This may change in the future.
+* linkgit:git-history[1] by default updates all branches that are descendants
+  of the original commit to point to the rewritten commit.
+
+Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
+your commit history that is simpler to use compared to linkgit:git-rebase[1] in
+general.
+
+If you want to reapply a range of commits onto a different base, or interactive
+rebases if you want to edit a range of commits.
+
+LIMITATIONS
+-----------
+
+This command does not (yet) work with histories that contain merges. You
+should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
+
+Furthermore, the command does not support operations that can result in merge
+conflicts. This limitation is by design as history rewrites are not intended to
+be stateful operations. The limitation can be lifted once (if) Git learns about
+first-class conflicts.
+
+COMMANDS
+--------
+
+Several commands are available to rewrite history in different ways:
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f02dbc20cb..fd2e8cc02d 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -64,6 +64,7 @@ manpages = {
   'git-gui.adoc' : 1,
   'git-hash-object.adoc' : 1,
   'git-help.adoc' : 1,
+  'git-history.adoc' : 1,
   'git-hook.adoc' : 1,
   'git-http-backend.adoc' : 1,
   'git-http-fetch.adoc' : 1,
diff --git a/Makefile b/Makefile
index 1c64a5d2ae..c0569ed8e4 100644
--- a/Makefile
+++ b/Makefile
@@ -1418,6 +1418,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index 1b35565fbd..93c91d07d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -172,6 +172,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix, struc
 int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_history(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/history.c b/builtin/history.c
new file mode 100644
index 0000000000..f6fe32610b
--- /dev/null
+++ b/builtin/history.c
@@ -0,0 +1,22 @@
+#include "builtin.h"
+#include "gettext.h"
+#include "parse-options.h"
+
+int cmd_history(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
+{
+	const char * const usage[] = {
+		N_("git history [<options>]"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc)
+		usagef("unrecognized argument: %s", argv[0]);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index accd3d0c4b..f9005cf459 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -115,6 +115,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-history                             mainporcelain           history
 git-hook                                purehelpers
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
diff --git a/git.c b/git.c
index c5fad56813..744cb6527e 100644
--- a/git.c
+++ b/git.c
@@ -586,6 +586,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
diff --git a/meson.build b/meson.build
index a5a4e99b25..3a1d12caa4 100644
--- a/meson.build
+++ b/meson.build
@@ -610,6 +610,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..73006b095a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -387,6 +387,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 0000000000..417c343d43
--- /dev/null
+++ b/t/t3450-history.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='tests for git-history command'
+
+. ./test-lib.sh
+
+test_expect_success 'does nothing without any arguments' '
+	git history >out 2>&1 &&
+	test_must_be_empty out
+'
+
+test_expect_success 'raises an error with unknown argument' '
+	test_must_fail git history garbage 2>err &&
+	test_grep "unrecognized argument: garbage" err
+'
+
+test_done

-- 
2.52.0.542.g9473a8513b.dirty

