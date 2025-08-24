Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFF2DEA7E
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057396; cv=none; b=cKQohXgX5R1Qcjr82gjC15JbNY8akMqHH/W7xSYdbPqbVD7dlXF3xrWF9WZzH2vPSyYDR7/i42w+tub4R2lHKiWgSoydy9JdTGq6b/+K9o8r0kTT2A9WCFVg0hUpUEwrx5i/HOpd3iDlAKsCUgfA38blCMuddbBCkymLCjPjJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057396; c=relaxed/simple;
	bh=+zx1CLxfvItyxnN2Wnf0O94xyXpU0cYFvp+PmlZHyhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcHahEmguG/jeztcMub4ywGDj3nEnpgJKQmPlJKbvG2TDhhuH7ZfX4cM2rPUZbEe5L2rck6xe4L8HeyUcfpyYStBp1ActyOnPQQL5DyCqOSyvAz9v5yGpPpDXDJxRv4H3Sz6BLw/hD3JjRs0kGZ5Z7Kude0HD8Pmnqk51bYdAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f7zTmuV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1uKtTTv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f7zTmuV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1uKtTTv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 156077A00C3;
	Sun, 24 Aug 2025 13:43:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 24 Aug 2025 13:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057393;
	 x=1756143793; bh=LGcAHey0Bt+Na/s6mBpbw8skE1In8U7SuWlGyk/07Rg=; b=
	f7zTmuV0uYQFE7KJCX03v0EXefBBp/fFMovXbXaYWRzRgagD037vfhJ/xdCShpfc
	hpanYHgyojjy+c97UQFp1nRKSyG57/CO9jY827ruE6TCNywzdTTaE1YjZE6QglLn
	fOWJld9wqN93uwQEcAxUAYIX3b7tdovEIfyBn/Agdkl3aHMa2O9REn3KkR7BSiqx
	F+VYeRDTgW96qKim/SjNP9EE0/+v1e2eoq2gey+J/Js+pNT49R4Vgv1Tf2r4Ia7X
	T/U1wM+LPsUJyQu0wgQ9dRaZO2esT1eGQA6aKBoxzpT7eQTJa90bl7KW+HRHK+bp
	gcGQa0x1ALwhIzO9ZVo+og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057393; x=
	1756143793; bh=LGcAHey0Bt+Na/s6mBpbw8skE1In8U7SuWlGyk/07Rg=; b=k
	1uKtTTvUP+8X7CGkwTQu4iYMSOBl/wmJdM23Mb3D8IhM0PPKkb+YaznRXZCZt6Mm
	o22vIX2ttimBEJ1yYeMae57PkL1QwAhtl1yGfh8W/Fdi8vvNB9F3SbuU2Wgttz1z
	JAoQYHKe/9fjWAFBoOMF/tlaq5zHikfbHnZc/wQmRvrIkTu9Afi+D9Dy+bvyyOtI
	Il59WlWmXzlS84Ifms2TcDKOo81hOeoYCmIeOYSx8HRw9WaW+3zMS5hbPOu+EcCi
	UwYMsgRU4jx9srLTZAN5qsL8jWGQB8CGzNiwk2pzQgONKd7Z4WWZ8ovFQGp/aVCB
	UNPiOK5P8Ipxk3ancYJqw==
X-ME-Sender: <xms:MU-raHAB7kjDhETadC_L8QHE6R8cGJ1R0sNQrQZkMSOVYW47HNYEKQ>
    <xme:MU-raLEYJUG4ImGti1XVgOdDymxVgpW7m4AqNNxt9MtCsNKY2ghPnEQBIp0fXCyR5
    CMFq1sw2Ky8IrP9Ww>
X-ME-Received: <xmr:MU-raJD31eDoVZvclS4MN0YH9r1T5cfy2EGbNiojcIR48NVp_itCLDoKwO1GrDaofTo1wGwDJhLc3LV--l6MKzS7pwue6XG4WPsVEWwe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MU-raLWc-lfIpeIPJBj7sXcRztJyG94ECUy1JtkzCqx5QhRcvCW9pg>
    <xmx:MU-raNq2qF0chqCD31rKqPHfcZzQrEupE_qVMXOaZH8nMtt9lo7cHw>
    <xmx:MU-raHQS8IUMOGYrckFQjt0rVI5kgTZj7uZExtI3MKHHRNFsmwT9DQ>
    <xmx:MU-raH0OJeFzYOh-w-kMIdp8OeqhrMDYrXakGlD294FS1Z-VL1LxLQ>
    <xmx:MU-raA9jdnxABT_irbCGsRCiLO2SJT7vVVPx-MTJlwC9KO2yhNNk1wza>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71022a33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:43:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:19 +0200
Subject: [PATCH RFC v2 06/16] builtin: add new "history" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-6-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

When rewriting history via git-rebase(1) there are a couple of very
common use cases:

  - The ordering of two commits should be reversed.

  - A commit should be split up into two commits.

  - A commit should be dropped from the history completely.

  - Multiple commits should be squashed into one.

While these operations are all doable, it often feels needlessly cludgy
to do so by doing an interactive rebase, using the editor to say what
one wants, and then perform the actions. Furthermore, some operations
like splitting up a commit into two are way more involved than that and
require a whole series of commands.

Add a new "history" command to plug this gap. This command will have
several different subcommands to imperatively rewrite history for common
use cases like the above. These commands will be implemented in
subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Documentation/git-history.adoc | 45 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build      |  1 +
 Makefile                       |  1 +
 builtin.h                      |  1 +
 builtin/history.c              | 20 +++++++++++++++++++
 command-list.txt               |  1 +
 git.c                          |  1 +
 meson.build                    |  1 +
 9 files changed, 72 insertions(+)

diff --git a/.gitignore b/.gitignore
index 04c444404e..3932d4d618 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-history
 /git-hook
 /git-http-backend
 /git-http-fetch
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
new file mode 100644
index 0000000000..1537960374
--- /dev/null
+++ b/Documentation/git-history.adoc
@@ -0,0 +1,45 @@
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
+This command is similar to linkgit:git-rebase[1] and uses the same
+underlying machinery. You should use rebases if you either want to
+reapply a range of commits onto a different base, or interactive rebases
+if you want to edit a range of commits.
+
+Note that this command does not (yet) work with histories that contain
+merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
+flag instead.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+COMMANDS
+--------
+
+This command requires a subcommand. Several subcommands are available to
+rewrite history in different ways:
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
index 4404c623f0..a30b5307fd 100644
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
index e11340c1ae..bed6eda5e6 100644
--- a/Makefile
+++ b/Makefile
@@ -1261,6 +1261,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/history.o
 BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..2934f4479a 100644
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
index 0000000000..d1a40368e0
--- /dev/null
+++ b/builtin/history.c
@@ -0,0 +1,20 @@
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
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..f95f0ce926 100644
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
index 83eac0aeab..9d2cba2906 100644
--- a/git.c
+++ b/git.c
@@ -560,6 +560,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "history", cmd_history, RUN_SETUP },
 	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
diff --git a/meson.build b/meson.build
index 5dd299b496..0e40778a23 100644
--- a/meson.build
+++ b/meson.build
@@ -603,6 +603,7 @@ builtin_sources = [
   'builtin/grep.c',
   'builtin/hash-object.c',
   'builtin/help.c',
+  'builtin/history.c',
   'builtin/hook.c',
   'builtin/index-pack.c',
   'builtin/init-db.c',

-- 
2.51.0.308.g032396e0da.dirty

