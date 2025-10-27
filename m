Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C212FA0CC
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564869; cv=none; b=ELz9POyytIGCkLmGQ8ku1wQd0O7+lHh7x9nzpouk05XW52wZmn7wSo6wwsgaWE/DHgq48IgZ2eV6TZgdQPG2kimKjPEfwqL3EhoJFeD8v+xQPiH5iQ4ytKutY4MylI2hTXnCrKx20EYNX4GCwDfKlNQ1Tv/+TiJOQ+M+nqiCBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564869; c=relaxed/simple;
	bh=HEzybZYoLgmhxZV2ZlwwYBySoaB6XpwcYK4eMGekOCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVpwSahqydaR2IObbO/VZL6nlcfqahq6vBfKedHuSph1+ZH5wEsXnK3eRVkS8g9/IzL/8LFJhS+80021Dmr67ksy+QvHR6PgRSpKHyJ2KiueTl8v4gOlvCRBu215opCNv42ccXWqPQHqzOt3MM4Cs1hGcq3CZOyCny4hUWYIF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k7bqjxCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibIa9V5t; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k7bqjxCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibIa9V5t"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EBB9DEC0329;
	Mon, 27 Oct 2025 07:34:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 07:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564866;
	 x=1761651266; bh=b0c11NRrstUa/gyZ5o9a5jJYc5LXsGmTH1lgkxzhsVM=; b=
	k7bqjxCrmjNjdp8CAjbxl4r0sPDvCAya6ShI94OfPcTXTGAbDcHJ76hSdGLWblMl
	F/l3zSW9thekv7VoejiZbf8n+qfVwPUdQz8FgoPnZUsIlH5HWeE5zL7jr4Kg/CH3
	lyg7QLjxSkRTHwFKfBMqD9hCbbfGqXtVhFGO53XPmkwSr4khQuktWqkdNgSbBvby
	R4omL2dTGYQ7AbAyH5FRDxGyeG1uZBnkPBCleaLMeZM+DrgMeppyfmAX7PEjPy34
	yNm/Zy0+ybtUHSz4/x7YyKWZEE4yyalGv6jOzIALZJEmbFsk8/MfOR/4TPRzIbmb
	ouWUD3llIdOfAgSoqXZU4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564866; x=
	1761651266; bh=b0c11NRrstUa/gyZ5o9a5jJYc5LXsGmTH1lgkxzhsVM=; b=i
	bIa9V5txBkn98Mzx6tAz0J33Gy5qOWfpsroHH0rsomvGwJmd5S2f5hjqpyfkT6+P
	uiD1yRq+tVZAxqBw5/I23X4KE3l5j0eaYBuS8BVnR7oc50oGg0hWDQvcWXUco/Da
	DDowiQr3dl+R8PR3t4k6MeZvMYO+ixgb9GhDV0bo4qWA30l3gzh1805OpAHrbnxA
	zblns9mTsO0JfWDWX+49dZVH6NxJYOkFqQbc8w6Ex/A21cmVlvEmH5MHg7s2RQTN
	5LQNN8/dF5+rhXjfCrnpEkcn3M94/GWuicfq2M/rNa6p93bkaiOqdgj+QRO/HVuQ
	122VAOmbYOmr6dG+7U1XA==
X-ME-Sender: <xms:wlj_aJunvaHResXa7BuRadQftBNG1a3JiFunoCSHGwpfxbsSrytNIw>
    <xme:wlj_aFB_7WHNcFQqpW5ogETbemz5FPdQC9NDlxlsWD2hkIXewPsGGoKsd2SoPniDu
    gd1WwQwvJyWFJy0vVlRJfh6vzpLdq1nj5O8mWH05hlB6aHgM5Jn7w>
X-ME-Received: <xmr:wlj_aAbqXlf9XSonq0_LU9RkdAGacQeE7n3h6Wn75SwO-cAmupSbz0EhC2c5eOTkFx8wwITKjx0wMV-ZPn3iQWewbVlwpKteLZyyWLNM6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefghfdtvedvkeetgeeutedvlefggfejtdekgfeutdevheehvefhteeigffgleevieen
    ucffohhmrghinheptghfghdrhhgvlhhpnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wlj_aAW-v3huub9JwDX7iI_PZ_NRmdo3t7ZVG15sKwhQuD2aQH0DSA>
    <xmx:wlj_aPOVeLJVqr3Fe0StwsOeeB3ilZYA0UknxbJqz6pF06rxGTGjCg>
    <xmx:wlj_aKbgtVsk81lFRae7vguyAnDFe2ECNjPXKI9G5TfYq-kUwUnKBQ>
    <xmx:wlj_aO_GVEqd57nFCJsuqSuP28Cg9qAd3ANUOOW3Or0dBiQ7R24p5Q>
    <xmx:wlj_aF57AvB-GqrPADOKWRMULUw_GTTxVHz3aJNpjfLjavsozoep4B7p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96f792a3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:56 +0100
Subject: [PATCH v6 08/11] add-patch: remove dependency on "add-interactive"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-8-407dd3f57ad3@pks.im>
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

With the preceding commit we have split out interactive configuration
that is used by both "git add -p" and "git add -i". But we still
initialize that configuration in the "add -p" subsystem by calling
`init_add_i_state()`, even though we only do so to initialize the
interactive configuration as well as a repository pointer.

Stop doing so and instead store and initialize the interactive
configuration in `struct add_p_state` directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c | 70 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 5c6969927a..790c848e79 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -2,7 +2,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "add-interactive.h"
 #include "add-patch.h"
 #include "advice.h"
 #include "config.h"
@@ -263,7 +262,8 @@ struct hunk {
 };
 
 struct add_p_state {
-	struct add_i_state s;
+	struct repository *r;
+	struct interactive_config cfg;
 	struct strbuf answer, buf;
 
 	/* parsed diff */
@@ -408,7 +408,7 @@ static void add_p_state_clear(struct add_p_state *s)
 	for (i = 0; i < s->file_diff_nr; i++)
 		free(s->file_diff[i].hunk);
 	free(s->file_diff);
-	clear_add_i_state(&s->s);
+	interactive_config_clear(&s->cfg);
 }
 
 __attribute__((format (printf, 2, 3)))
@@ -417,9 +417,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.cfg.error_color, stdout);
+	fputs(s->cfg.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.cfg.reset_color_interactive);
+	puts(s->cfg.reset_color_interactive);
 	va_end(args);
 }
 
@@ -437,7 +437,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env,
-		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
 }
 
 static int parse_range(const char **p,
@@ -542,12 +542,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
-	if (s->s.cfg.context != -1)
-		strvec_pushf(&args, "--unified=%i", s->s.cfg.context);
-	if (s->s.cfg.interhunkcontext != -1)
-		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.cfg.interhunkcontext);
-	if (s->s.cfg.interactive_diff_algorithm)
-		strvec_pushf(&args, "--diff-algorithm=%s", s->s.cfg.interactive_diff_algorithm);
+	if (s->cfg.context != -1)
+		strvec_pushf(&args, "--unified=%i", s->cfg.context);
+	if (s->cfg.interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", s->cfg.interhunkcontext);
+	if (s->cfg.interactive_diff_algorithm)
+		strvec_pushf(&args, "--diff-algorithm=%s", s->cfg.interactive_diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
@@ -576,9 +576,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	strbuf_complete_line(plain);
 
-	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
+	if (want_color_fd(1, s->cfg.use_color_diff)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
-		const char *diff_filter = s->s.cfg.interactive_diff_filter;
+		const char *diff_filter = s->cfg.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
 		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
@@ -811,7 +811,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 				   hunk->colored_end - hunk->colored_start);
 			return;
 		} else {
-			strbuf_addstr(out, s->s.cfg.fraginfo_color);
+			strbuf_addstr(out, s->cfg.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
@@ -833,7 +833,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
+			strbuf_addf(out, "%s\n", s->cfg.reset_color_diff);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1222,12 +1222,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 
 		strbuf_addstr(&s->colored,
 			      plain[current] == '-' ?
-			      s->s.cfg.file_old_color :
+			      s->cfg.file_old_color :
 			      plain[current] == '+' ?
-			      s->s.cfg.file_new_color :
-			      s->s.cfg.context_color);
+			      s->cfg.file_new_color :
+			      s->cfg.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
+		strbuf_addstr(&s->colored, s->cfg.reset_color_diff);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
@@ -1356,7 +1356,7 @@ static int run_apply_check(struct add_p_state *s,
 
 static int read_single_character(struct add_p_state *s)
 {
-	if (s->s.cfg.use_single_key) {
+	if (s->cfg.use_single_key) {
 		int res = read_key_without_echo(&s->answer);
 		printf("%s\n", res == EOF ? "" : s->answer.buf);
 		return res;
@@ -1370,7 +1370,7 @@ static int read_single_character(struct add_p_state *s)
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
-		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
+		color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt));
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			return -1;
@@ -1678,15 +1678,15 @@ static int patch_update_file(struct add_p_state *s,
 		else
 			prompt_mode_type = PROMPT_HUNK;
 
-		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_color,
+		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->cfg.prompt_color,
 			      (uintmax_t)hunk_index + 1,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
-		if (*s->s.cfg.reset_color_interactive)
-			fputs(s->s.cfg.reset_color_interactive, stdout);
+		if (*s->cfg.reset_color_interactive)
+			fputs(s->cfg.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			break;
@@ -1848,7 +1848,7 @@ static int patch_update_file(struct add_p_state *s,
 				err(s, _("Sorry, cannot split this hunk"));
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
-				color_fprintf_ln(stdout, s->s.cfg.header_color,
+				color_fprintf_ln(stdout, s->cfg.header_color,
 						 _("Split into %d hunks."),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
@@ -1866,7 +1866,7 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
-			color_fprintf(stdout, s->s.cfg.help_color, "%s",
+			color_fprintf(stdout, s->cfg.help_color, "%s",
 				      _(s->mode->help_patch_text));
 
 			/*
@@ -1884,7 +1884,7 @@ static int patch_update_file(struct add_p_state *s,
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
-				color_fprintf_ln(stdout, s->s.cfg.help_color,
+				color_fprintf_ln(stdout, s->cfg.help_color,
 						 "%.*s", (int)(eol - p), p);
 			}
 		} else {
@@ -1904,7 +1904,7 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		reassemble_patch(s, file_diff, 0, &s->buf);
 
-		discard_index(s->s.r->index);
+		discard_index(s->r->index);
 		if (s->mode->apply_for_checkout)
 			apply_for_checkout(s, &s->buf,
 					   s->mode->is_reverse);
@@ -1915,8 +1915,8 @@ static int patch_update_file(struct add_p_state *s,
 					 NULL, 0, NULL, 0))
 				error(_("'git apply' failed"));
 		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+		if (repo_read_index(s->r) >= 0)
+			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
 						     1, NULL, NULL, NULL);
 	}
 
@@ -1929,11 +1929,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	      const struct pathspec *ps)
 {
 	struct add_p_state s = {
-		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+		.r = r,
+		.answer = STRBUF_INIT,
+		.buf = STRBUF_INIT,
+		.plain = STRBUF_INIT,
+		.colored = STRBUF_INIT,
 	};
 	size_t i, binary_count = 0;
 
-	init_add_i_state(&s.s, r, opts);
+	interactive_config_init(&s.cfg, r, opts);
 
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;

-- 
2.51.1.930.gacf6e81ea2.dirty

