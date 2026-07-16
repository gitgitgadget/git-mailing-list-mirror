Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846D433BC9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220962; cv=none; b=ZAkvydAlvJv78+1VoBPUarsz0BjbLJyo5B/u7+7iB/2oPtUFltZ+OvG7BOAriSmvxz7HazfxuCckh58Q0XGr3Xs5BAdeamGBXAewQvEtmvkvtUQdxHgBaXi7uPx4rM5jsunjPT5FpCxcenBCuaNtecg0gv+EKXzE61Qw8UaJfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220962; c=relaxed/simple;
	bh=+AuvpAnR1p/EibWJ4EDqtRiIA262YPVPonEXYZAChHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EITGSNFp8bI/Ao1HhpqOuY2k2TZ2d08v/A+4qe/4CmFXJCatoMk81MRcyS90UQJHw+To5IqaUSQnf5W58t8uAs7IyCCdw0FY1FxmpJ5POUQWnM0SWt7SaLo1FMqZbJiKl3e8CTYPJyN9gPEdgVQa+gZ4kmALYKViTt0LdpbGpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjFWZsHC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjFWZsHC"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso9442130a12.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220956; x=1784825756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLOKo0RVRNnWCufoTtTaPDxjN6Tn3ZuTuiD02rZB+Pk=;
        b=DjFWZsHCONDiu7ix5yJEjAY1TjuL55VpijZLEj1EgKSjeXsBZw2KSCUcr18Ful9TWt
         LIdysHQW8YBC5MCRnZGnZZMMX7YPAfNBQ5CS1jGALA2mmwEq7FiXm8aiTLzgZ1ujduGD
         NAlkcu1/7+RZ/n6PTEydhhq9UuD5wzX5Qujac+YftVWNPkijrOqWnupJL9dnPewgpj+q
         IgVpBMcNLrVKKavxp7/7zy76FV1oEssgRmKrF8dM8+WxM3oPKnRW0WlUw2FSEBDNj+26
         tQ1ihL6MB6OpL+XSfYopZj9KGGn2072UCprh/8VwVNi6mKJHwkA4hbtNFmzmHLObHl+7
         ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220956; x=1784825756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLOKo0RVRNnWCufoTtTaPDxjN6Tn3ZuTuiD02rZB+Pk=;
        b=TFx6AHBnaUVuzkP8MFJod6P0apkZXjmiGkkIFwQhPN50/mNfGPjs2TrYqo9hdrj0jA
         q6DSKyQzPDYhhN+QEHxkAI+3pRQ/clcM8zv15NAs8PJ+Btm3HyZuLsnFmJtIZ6jqJt1c
         bdpMEdxXnR5QxQjfx02pVb3PnbbhZzymaSXs33jIo5Nn6u7bEmkbc9Fr/ma9fwNjDwka
         bAUKFgm1GVZ4+HiY9REvNeGQjddBgD0MaTCAPiPtP6mHcUJQoYBG7g7jLqt2Xt0A9jJ+
         EV/agNdXPw2/jAglstWXKEiYWFxdZzsPxGajOrSVk4jET4h8DABd5nT4wP8WOm+1k36X
         Pkiw==
X-Gm-Message-State: AOJu0Yzwjam7ZUbve19q3e5eQ3Zn5WbECBh9Rx3BBhomVJhkePqTz03x
	Qu23DSZFrpm8NKTZcGOfJmni5W3Ljy/W5RV/23GFGD8BI8j1YzBs1aGJN9XvqI8xmFw=
X-Gm-Gg: AfdE7ckI/XrXWDXoe7C6/oqXuqjToIZDHiQ8ny5RlOHkWnVHvpVbTypqbmVbLT9JVqP
	IUU7QHZ3G8i8PI1Fc1weqmVmf6mBYj93wrI4LVtVbL7hj8y0zr8UTY/dbsmnpFNYMTAZ+XUZt0+
	bACNUB2GIQOO/1aalpdjpnWh8Of9CHV/rmlKbrc2EVS5l9fVVz67OaNz1TIhDqL7nUlkWVyYFeW
	5OkXyFq7iB0l22roqJnRXljZK23La46TP+tKCXvoH2uQ+ByAuSCmRh8Zs8F+6atKcQ1DrNHvAY/
	89o5yoxq93iIM3sQj0J8h28PyPJsu6MJtTdTfKCo1ySeAXqEmpLXcYNE2Vy1l9TT7osItfslTiH
	VtN4NFL2Iw5KJyqHH+RMtlhNd6f2Safe5xlkZ9YHLwP3yYpSqdf6/0myQmvu3+ODvan119IPr5S
	5A0tPboidyp6p1DD+VvLrX3xRkvx0PtpEDVNFvW8AygkMIu32lDAntx4sVWAP2jo1YRhN5dETPV
	M2cjRsZHqGtaoJC1Q==
X-Received: by 2002:a05:6402:e08:b0:69a:a81d:d454 with SMTP id 4fb4d7f45d1cf-69e1966b38amr4002136a12.7.1784220955719;
        Thu, 16 Jul 2026 09:55:55 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2937527sm5017149a12.20.2026.07.16.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:53 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] fast-import: move command state globals into 'struct fast_import_state'
Date: Thu, 16 Jul 2026 18:55:16 +0200
Message-ID: <20260716165517.433849-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.185.g9120d2b5c0
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d20353679a..53f5d39173 100644
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
@@ -1876,7 +1876,7 @@ static int read_next_command(struct fast_import_state *state)
 			if (stdin_eof)
 				return EOF;
 
-			if (!seen_data_command
+			if (!state->seen_data_command
 				&& !starts_with(command_buf.buf, "feature ")
 				&& !starts_with(command_buf.buf, "option ")) {
 				parse_argv(state);
@@ -3809,9 +3809,9 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(struct fast_import_state *state UNUSED, const char *feature, int from_stream)
+static void check_unsafe_feature(struct fast_import_state *state, const char *feature, int from_stream)
 {
-	if (from_stream && !allow_unsafe_features)
+	if (from_stream && !state->allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
@@ -3860,7 +3860,7 @@ static int parse_one_feature(struct fast_import_state *state, const char *featur
 
 static void parse_feature(struct fast_import_state *state, const char *feature)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
 	if (parse_one_feature(state, feature, 1))
@@ -3871,7 +3871,7 @@ static void parse_feature(struct fast_import_state *state, const char *feature)
 
 static void parse_option(struct fast_import_state *state, const char *option)
 {
-	if (seen_data_command)
+	if (state->seen_data_command)
 		die(_("got option command '%s' after data command"), option);
 
 	if (parse_one_option(state, option))
@@ -3939,7 +3939,7 @@ static void parse_argv(struct fast_import_state *state)
 	if (i != state->argc)
 		usage(fast_import_usage);
 
-	seen_data_command = 1;
+	state->seen_data_command = 1;
 	if (import_marks_file)
 		read_marks();
 	build_mark_map(&sub_marks_from, &sub_marks_to);
@@ -3954,6 +3954,8 @@ int cmd_fast_import(int argc,
 
 	show_usage_if_asked(argc, argv, fast_import_usage);
 
+	fast_import_state_init(&state, argc, argv, prefix);
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
 
@@ -3977,11 +3979,9 @@ int cmd_fast_import(int argc,
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
@@ -4028,7 +4028,7 @@ int cmd_fast_import(int argc,
 	}
 
 	/* argv hasn't been parsed yet, do so */
-	if (!seen_data_command)
+	if (!state.seen_data_command)
 		parse_argv(&state);
 
 	if (require_explicit_termination && feof(stdin))
-- 
2.55.0.185.g9120d2b5c0

