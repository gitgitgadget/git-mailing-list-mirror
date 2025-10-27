Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66082F99AE
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564857; cv=none; b=ghRdvLmzLcDnB/dMOIOMYHYLSdUf1of/Vr8tO0g5BnT3dlRYxUJxDeElQiCExM58OyDhB/4jYKUif9wXH9+WQ5fehSbhhDXJNemO4O18cGYrZYm8FYYSZjUdMvBXLjkPBT9YOrcPBfb8TMQ1uKBoHj3jEw5AQP2bQDpcjIwa64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564857; c=relaxed/simple;
	bh=1uoqK18gFFno9tTNSJhBzMzylztXjWjPYRg/JkTX4Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3gPsAaU5QajaENHqagoLo7bVe/eQ8SEFMUQ63ZVdUjZODLCu+GC+/OpIRiXj3gbHbzA+7UKG6YdJWWHAuJN7LyUrkHmeOzYOVHvX+3htCx5jWk1YP+TySbFifkyNbdKlBsH2L1tFJHZ5xdcozofTc+QHpZ4vofiM0gZ+kE/G0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a+qAPQYO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spY2e0XU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a+qAPQYO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spY2e0XU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4A3414002EA;
	Mon, 27 Oct 2025 07:34:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 07:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564854;
	 x=1761651254; bh=1khXZDySPExYfrQ3Hwlfn4kahB1D6n1zJsLmKVHzGWw=; b=
	a+qAPQYOx+7xjHokXlVDOVhk+JhHru7YKyB6k4csWoxAFYlIIH0lJFMtdjZvCbcx
	V+0Ee91XFe2mmbCm1v/jud5HOmqRwC/Q41by2JvGUUQy982+jqAJU00l4VpaNlZC
	dJ7POgNIcIiafAACmGVfEZedHTRCy2i4K54QltyqcAEwnigMKRuC2nDShGUtpVmp
	2qw0TVThzxBJOske9ba3LD0vXQ2CvgdP6WeYugI5jYrzm4/C+iD0D3amaYKXc3EM
	6mRS9oOT/dQ04RS40R0gd/wyyRDLN0+OZDZ1P0nYsiIHKdnOg8+vqemgYEqOaBzo
	+Zps4kKmSb0TURgEOzbDyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564854; x=
	1761651254; bh=1khXZDySPExYfrQ3Hwlfn4kahB1D6n1zJsLmKVHzGWw=; b=s
	pY2e0XUMlfftDHfrp9wmp5qB06hiblEfWhy9G5Qpl6CSbSveWY9LNa289Hg4gTnl
	rDhxr1Zj0w5/PqzrKVadLKGBnajvaV3C+ie3jvAFM6o+VQk1FcMJypf3h6OipTMZ
	aDCZFpeRg+k6HuJiXnPukHfm38wcEMEilbTxe6ssBqV1lzuyJCnWs6Puqv2Cnvyz
	Cdxj7Uky9qN16oew2UDykhpDDq8DpjAqnt3j5/q4990x0hRZ7FuuBzVz7QpdMrLw
	5IF8hhv0OdnBgN4+gZRs9IPUFT7SYB071cO8XqtNCiVpRjCr2gH28qZU9fbQg2dH
	zPbj8+xVJjv4YP6eZu64w==
X-ME-Sender: <xms:tlj_aOWh0NcJPnQLDieaEwVL6VI7QDXtv2_n1CnNrmmTC37llrxsEg>
    <xme:tlj_aHeBgrGO2gzeVImCXJZ76BVom7fTvtKXb2KSEVZ0osppSnfm0hTZZc7Bpkoyh
    xrW-RRLFVWMiXd4vmY9R4HI4jZD7nce9MQ4TAzHgTZlwarmpeCxow>
X-ME-Received: <xmr:tlj_aCK_Im5MEA4nMTbJSsgrJSpFJ1xlPGVdcLgXDAt9-20jZaE_F0dnclZeVePX2HWOP6zo38aIaafWtr-S8bxHdlGEqiXzqSYcRppyLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrg
    hnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:tlj_aEwdXE0MpifUDfPTAuUfs16KgQ92W22cV5Aj_XuEZYMMv8J3lg>
    <xmx:tlj_aIt3PK7YN4Q0AvH75skxkDnWejcykEs-oa4Gu2j_7u1WstzVvw>
    <xmx:tlj_aHDEUApp20n5TSGO7qEiWz4_0Ij-h7w_j_rGx1ggkF3gSfPFTw>
    <xmx:tlj_aKEq7KOdI3kK0rD2VWF3gTXOCrq5yJkaRqSTIF1HSj4hMr9JzQ>
    <xmx:tlj_aIp2GmQA6hGwmN3ulQ3en07lKMCCAjqk5ZfxWXtqrVIrCwJJDzyM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c7d7eb8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:52 +0100
Subject: [PATCH v6 04/11] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When rewriting history via git-rebase(1) there are a couple of very
common use cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

While these operations are all doable, it often feels needlessly kludgey
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Furthermore, some operations
like splitting up a commit into two are way more involved than that and
require a whole series of commands.

Add a new "history" command to plug this gap. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above. These subcommands will be implemented in
subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 44 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 22 +++++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 t/meson.build                  |  1 +
 t/t3450-history.sh             | 17 ++++++++++++++++
 11 files changed, 91 insertions(+)

diff --git a/.gitignore b/.gitignore
index 78a45cb5bec..24635cf2d6f 100644
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
index 00000000000..6bdfeb50e8b
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,44 @@
+git-history(1)
+==============
+
+NAME
+----
+git-history - EXPERIMENTAL: Rewrite history of the current branch
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
+This command is similar to linkgit:git-rebase[1] and uses the same
+underlying machinery. You should use rebases if you want to reapply a range of
+commits onto a different base, or interactive rebases if you want to edit a
+range of commits.
+
+Note that this command does not (yet) work with histories that contain
+merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
+flag instead.
+
+COMMANDS
+--------
+
+Several commands are available to rewrite history in different ways:
+
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+include::config/sequencer.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 9d24f2da544..d1f6bde7c16 100644
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
index 01c171b4f03..1380ee1e196 100644
--- a/Makefile
+++ b/Makefile
@@ -1395,6 +1395,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index 1b35565fbd9..93c91d07d4b 100644
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
index 00000000000..f6fe32610b0
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
index accd3d0c4b5..f9005cf4597 100644
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
index c5fad56813f..744cb6527e0 100644
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
index ae8d4fef059..2d789612a01 100644
--- a/meson.build
+++ b/meson.build
@@ -604,6 +604,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',
diff --git a/t/meson.build b/t/meson.build
index 401b24e50e0..019435918fa 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -384,6 +384,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
new file mode 100755
index 00000000000..417c343d43b
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
2.51.1.930.gacf6e81ea2.dirty

