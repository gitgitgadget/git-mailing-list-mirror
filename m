Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CF418360
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437229; cv=none; b=deJfzSWBdXNW6TbYaKyP4jqvMnu1KRWh/3B0fEAiQzEjc0TjgeRLkJr9rw8dnIR+bQOadKT1YdJI6lfXJvuvquJAngtdCQZwZissi5/gppboGArK19C1MpDiFv9NyP/2ZLI72Z891tzSPBK+PLxpjOmveuNbDw2GECmYxmwNuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437229; c=relaxed/simple;
	bh=ngnGymzBj12gMzlPAQpO9J4zvWEPKbhq5iynZrQj5Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bcyikapl+zLvJnKHWigQf3tMpJdw72FWxLme0B9qg6DphY/wVtAEhT9UQ4wcvWd7egu+nFxQMbOe8Vt6HpxVwy8hweBpWz5MPBOeEifJ/fBzGcAVBj35pQd+ztAYGXnoDrQ6KneGtINjfp5q0dMWv11Pee+IVn7V1XyBzUqU2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjqlN7Fh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjqlN7Fh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso26376695e9.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437226; x=1787042026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ENRKkHBwbGaeZ9/7ePyYz0Or9dxF2rRWizOkoMAE2k=;
        b=mjqlN7FhHrtM8tJKg8aO5bf89Pf/rTmTtfVLyrj0tbCzEZXkcbyzjVWcWGRJBthbNq
         GW4q9rNtPvTktQ85NMRVqLHYcgU33MuUXOYARfY0WUJLd0AX0dWB2uQusQE9VP9fdDa9
         Fci65lKLvV3rpkp0QPWdfxtOIOyQnevqp8s+Ml5emyzu0rIf8BU9NKvVxv8cCcByrjNK
         I9kYz2HwMe778lL5JkSMXxmoLnesrFoAjBo/7Fsz2kmENdV2ii79Oq3jEmesOPHNsHqa
         GV1bEQXOcfcZcqOf+GT+Xdfrsj2oeyYTR8ZfnPODorccNw8O9CVaVhrHgbkXwgM8znhe
         LDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437226; x=1787042026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ENRKkHBwbGaeZ9/7ePyYz0Or9dxF2rRWizOkoMAE2k=;
        b=egOsSHnRQerLaa0MlAcoSO6ar1aNMxGpjs0YvklLrFj6Jm0wXoQgC6BPXna/bPDyfP
         DUgAawiwW7OZIdHVyJ8Gm53PyTYpKicskVt1xnDGmSI0bPXQn+n0N1FnwK+AdvkChTzt
         emFyG/iudsqj1dHRfmW5W7xfjHhh9SRGW+pv/wXX1hjqFPPUqjQTLT+QumXQCLF5MqDc
         t3wktfZMmW2qfIuVYBJZX5Zw+kyas3ip/THz7NeJJKquFi42zsfBHF4N3eD5MaOp1GNY
         lTu1/1F5moMTPQdQoK9V/4LpDQeLg9DUYGL5PsExc2RuglDLQimHuojkja28BaJI291b
         R4FA==
X-Gm-Message-State: AOJu0YxH2pIdBIdEhh0EPMsNRCghBwUWvzcbxthMg/RRIpVOKijGDiYO
	sH5ro2TLSX0M4BYPz6VTl/tV36tt+15YPh2pd4mAgLhcuZmXX/w0YvMhK9YClQ==
X-Gm-Gg: AR+sD12gWpULyTaRuiRUmJ3BXaO1kr1RhTv4OosnQ6XFcIY0lDplxwvg85FLMKgPpx7
	2WKNBSav3OucWEawrZuMcSC5O1rP/agMkAG4UFlMXIOAxG0KmlKw1w1x5W7vwp98ZqHcf1v2ovO
	ar2ckga3c/S++VWAJBPLam7o+3LDr7Evblvm1uHHnsNn+KqIP/if7e65mNbZ/A6BcHN4JyJxVDJ
	8O8ERQ6yBHNSGzdLLq9DmH9ApMW7jIAXUAW/k3QXSXnEZiqc54piniSWijmVE5BOk7EqkFTL+UO
	8vzAoZv9iE75YqQyGL0HnyXm3U9e1ip+s1zUoeggXpmNjZf6JgL8AGcvFB61IoRPxqPTpD00jfB
	DULfOXKWbubLYrHDKILaQFVNHoGfC137YbtHC4ag0vpyppo+xfMTolbS1xtiQ9bl6w/sHLesrZo
	GdUtMKi1iAHQWNYTZ4CXdzvVyz1ZwPU4EFTFquSOlZmpDE9M58aDR/Eyx7upXV2Us6f7iOUpOx/
	qieDPoQCKUF6FGYeAS9PErrn9FV5GopGxBv9v+BZPNvWzNkePTmWIh/idIqzd0MReeTHm1fyVUi
	ifc3qjDaIVYutg==
X-Received: by 2002:a05:600c:8595:b0:499:4d4d:822a with SMTP id 5b1f17b1804b1-4997847d2dcmr25757945e9.17.1786437226149;
        Tue, 11 Aug 2026 01:33:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 08/12] fast-import: move command state globals into 'struct fast_import_state'
Date: Tue, 11 Aug 2026 10:33:10 +0200
Message-ID: <20260811083314.2023489-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit introduced 'struct fast_import_state' to hold some
command state, and reduce the need for global variables.

Let's continue in the same direction and move two more global variables
that describe the command state into it: 'seen_data_command' and
'allow_unsafe_features'.

All the sites accessing these variables are already in functions that
receive the 'state' parameter (or in cmd_fast_import() which owns the
struct), so no additional threading is needed.

As 'state->allow_unsafe_features' is now dereferenced in
check_unsafe_feature(), its 'state' parameter is no longer unused, so
the UNUSED marker is removed.

The fast_import_state_init() call is moved up before the early
command-line scan for '--allow-unsafe-features', so that this option
can be recorded directly into the struct without being clobbered by
the memset() in fast_import_state_init().

This is a mechanical refactoring with no intended behavior change.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f838d8488..52da29c1bd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -257,9 +257,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
-static int seen_data_command;
 static int require_explicit_termination;
-static int allow_unsafe_features;
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
@@ -277,6 +275,8 @@ struct fast_import_state {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	int seen_data_command;
+	int allow_unsafe_features;
 };
 
 static void fast_import_state_init(struct fast_import_state *state,
@@ -1879,7 +1879,7 @@ static int read_next_command(struct fast_import_state *state)
 			if (stdin_eof)
 				return EOF;
 
-			if (!seen_data_command
+			if (!state->seen_data_command
 				&& !starts_with(command_buf.buf, "feature ")
 				&& !starts_with(command_buf.buf, "option ")) {
 				parse_argv(state);
@@ -3863,11 +3863,11 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(struct fast_import_state *state UNUSED,
+static void check_unsafe_feature(struct fast_import_state *state,
 				 const char *feature,
 				 int from_stream)
 {
-	if (from_stream && !allow_unsafe_features)
+	if (from_stream && !state->allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
@@ -3918,7 +3918,7 @@ static int parse_one_feature(struct fast_import_state *state,
 
 static void parse_feature(struct fast_import_state *state, const char *feature)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
 	if (parse_one_feature(state, feature, 1))
@@ -3929,7 +3929,7 @@ static void parse_feature(struct fast_import_state *state, const char *feature)
 
 static void parse_option(struct fast_import_state *state, const char *option)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got option command '%s' after data command"), option);
 
 	if (parse_one_option(state, option))
@@ -3997,7 +3997,7 @@ static void parse_argv(struct fast_import_state *state)
 	if (i != state->argc)
 		usage(fast_import_usage);
 
-	seen_data_command = 1;
+	state->seen_data_command = 1;
 	if (import_marks_file)
 		read_marks();
 	build_mark_map(&sub_marks_from, &sub_marks_to);
@@ -4012,6 +4012,8 @@ int cmd_fast_import(int argc,
 
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
+	fast_import_state_init(&state, argc, argv, prefix);
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
 
@@ -4035,11 +4037,9 @@ int cmd_fast_import(int argc,
 		if (*arg != '-' || !strcmp(arg, "--"))
 			break;
 		if (!strcmp(arg, "--allow-unsafe-features"))
-			allow_unsafe_features = 1;
+			state.allow_unsafe_features = 1;
 	}
 
-	fast_import_state_init(&state, argc, argv, prefix);
-
 	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (unsigned int i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
@@ -4086,7 +4086,7 @@ int cmd_fast_import(int argc,
 	}
 
 	/* argv hasn't been parsed yet, do so */
-	if (!seen_data_command)
+	if (!state.seen_data_command)
 		parse_argv(&state);
 
 	if (require_explicit_termination && feof(stdin))
-- 
2.55.0.530.gdb3615d990.dirty

