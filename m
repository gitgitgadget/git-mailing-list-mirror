Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BF30EF63
	for <git@vger.kernel.org>; Wed,  6 May 2026 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111907; cv=none; b=NJCUfzNq3gOSCOTlioJSIAr6hSnJC+vwCBE/XINsALM1h72cirrGnJf4bXR+qm2nlAvoAjcXdjmiWSucZIM2FeD9awbPmEZ6PuScFFBnIm08JGLFDnrfzP+wTCw7GcbqIE7gJLraeR9F1IKIkdr42BMLDRQ5LiOsZZAG113+aEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111907; c=relaxed/simple;
	bh=f+jehzm4k/EFMyyiXCPF9vh7lx8TOukCFJvFga8pJ0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hm9v9EwZn89zol+34FAjFwtdGZG6mPbrfGDaovqa7eZn2nD3rjU8Lfl0Y48PNNj/drbv7R78mhYlGBmu12BwnEDJbNVmCIQTS0kgsiW6NjvNRqD7RLHleoy8AjPpz22RmcRlZ3bvawff5hTxKz2+3IGz+9YJeh7N23q6ImTmh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds2ABjdV; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds2ABjdV"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so902269c88.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778111904; x=1778716704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8GxhjVgNsOZd/B8O3G73UPqgYv4LC201jQHy3f8sd4=;
        b=ds2ABjdVTM7R/aUh/8TmBpNjWLkgo4LRMiKz2lc5/IRBKxmwCYDN2eWWb2Tgrvn+XA
         wXuKNPCU17DFMq9sYTyo1gzW089zMKfR9C3zpoB1GH2/NdI2f9KoGt/amIYd0KM7SDFT
         11IdSFriMN6SQL5tsh9eESWrhzV0ySNiMLVGA83/9gtP+gtwN7hpAnA4Dj4IL/1nRw7K
         KAbY3dfUjFeQ8R/WXr/LB9VXVisKTeJbEBUS2Evdi61iA0r1u2w+8Ql9geoqFk6X0w1/
         Sc1gem6ZnICVUcoqjYhSVrIQq2wBYezj1IWCUcz0KkommXhwhaByDdOWyWJbrhcnsoyh
         r8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778111904; x=1778716704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8GxhjVgNsOZd/B8O3G73UPqgYv4LC201jQHy3f8sd4=;
        b=SDT33bzlTR5NsgHmFXPBgj9p30FU890TE7x1sk6wcygbQ38BHEGb7mouR5RXgnVxAm
         zQFgRBEQbIEjiepMQIsYm1FpaxvNl37G8/Hm8RaQUxgZPK0sPqSQCt2dF9iqijyjmJk5
         cVGxkKVaXx3OQYQ6WPg0VwNtv8Nf64tsheY0pmoUWWuSigTu1L1GwA2kUFvj7F5iK5rz
         eGwa73BQgBKq5nmCNU8CmjChv3oQClumYk4KMSGIdr7f19glMapPyLbmSNmqJrhm3uec
         0VOUZp57ONq1KhmYcF7R8nDrU+lIalJt6QM2MHd+uHTIUee3VDj3U3dAeWykD5KqqNRx
         abUw==
X-Gm-Message-State: AOJu0YxjlqKCkpKYTeFAlWEkyxBrNguGEE43dXgoWu2Xj7WeI913b3BQ
	hq61mEGYN1LtHjfHKeHNj4S9nWAdNyOddnJYGKGUGIYWLVzG/3AJiqtFZ5cd396Z
X-Gm-Gg: AeBDiesiWhNZ1FQNlAC7oQOd73+cYITSzSIS6NGAJzLxXzeGoxr/fTzw78wlAX5x8u6
	c1+gYRxk7aBMFEw7wa9GOqwrBMXxOkvahjjQ2s5HCOMWeHMViKDmocadYm5ec9H4Dmhj7BPAzrV
	XCjqujBGFyFB4Mr3J1sdY2NPXPhURJBwx+SmiM3pvIIV6miGrTuhqNeaI8YnHtyWx7twxbcbZzK
	HdS8JNKxj/t9ArzIfOfCtBoGR4s8GhPbZgYCS/KXhzUwrM9XgmlMaRYQXBHfDh9aSBoaEFopSu+
	cc6p62N1ZFo//6ZYxqYK/VihJfoFr4hHXSAAZp9AJPkEUj/VIyxvql++ka3pI5eBAm/OhebGQkc
	rbFnJPNzxCB8vCViLoFf74UV6S+iY8DDSpLgwJuUSIw2sGtgVylVkWY+qKZM5PZDXEN2kA3Z4K3
	941oYVKfTnEkqG3KsB+P3btyxOhFlp/ND3nXzEWx30bQ==
X-Received: by 2002:a05:7022:ead3:b0:12c:81b:c74b with SMTP id a92af1059eb24-1323aa56dcemr303373c88.1.1778111904100;
        Wed, 06 May 2026 16:58:24 -0700 (PDT)
Received: from NeoPC.lan ([181.28.58.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9679390sm7034290c88.2.2026.05.06.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:58:23 -0700 (PDT)
From: Javier Bassi <javierbassi@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>,
	Rene Scharfe <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Ruben Justo <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Javier Bassi <javierbassi@gmail.com>
Subject: [PATCH] add -p: introduce 'w' command to view hunk with --word-diff
Date: Wed,  6 May 2026 20:54:59 -0300
Message-Id: <20260506235459.529862-1-javierbassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using `git add --patch`, reviewing changes in long lines can be
difficult with the default line-based diff. This is particularly
noticeable in formats such as JSONP, CSV, LaTeX, Markdown, or other
plain text where small inline edits can be hard to spot.

Added `w - print the current hunk with word-diff` during hunk selection
to re-display the current hunk using `--word-diff`. This provides a
clearer inline view of changes without modifying the hunk or affecting
how patches are applied or staged.

Signed-off-by: Javier Bassi <javierbassi@gmail.com>
---
 Documentation/git-add.adoc |   1 +
 add-patch.c                | 105 ++++++++++++++++++++++++++++++++++++-
 t/t3701-add-interactive.sh |  59 +++++++++++++--------
 3 files changed, 142 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 941135dc63..d2ee1cf9a9 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -351,6 +351,7 @@ patch::
        K - go to the previous hunk, roll over at the top
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       w - print the current hunk with word-diff
        p - print the current hunk
        P - print the current hunk using the pager
        ? - print help
diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..0364f4bc97 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "config.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -1508,6 +1509,105 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
 	strbuf_complete_line(out);
 }
 
+static void trim_trailing_lf(struct strbuf *buf)
+{
+	if (buf->len && buf->buf[buf->len - 1] == '\n')
+		strbuf_setlen(buf, buf->len - 1);
+}
+
+static void add_word_diff_line(struct strbuf *old, struct strbuf *new,
+			       const char *line, size_t len, char marker)
+{
+	if (marker == '-' || marker == '+' || *line == ' ') {
+		line++;
+		len--;
+	}
+
+	if (marker != '+')
+		strbuf_add(old, line, len);
+	if (marker != '-')
+		strbuf_add(new, line, len);
+}
+
+static void build_word_diff_files(struct add_p_state *s, struct hunk *hunk,
+				  struct strbuf *old, struct strbuf *new)
+{
+	size_t i;
+	char last_marker = '\0';
+
+	for (i = hunk->start; i < hunk->end; i = find_next_line(&s->plain, i)) {
+		size_t next = find_next_line(&s->plain, i);
+		char marker = normalize_marker(s->plain.buf + i);
+
+		if (marker == '\\') {
+			if (last_marker != '+')
+				trim_trailing_lf(old);
+			if (last_marker != '-')
+				trim_trailing_lf(new);
+			continue;
+		}
+
+		if (marker != ' ' && marker != '-' && marker != '+')
+			BUG("unhandled diff marker: '%c'", marker);
+
+		add_word_diff_line(old, new, s->plain.buf + i, next - i,
+				   marker);
+		last_marker = marker;
+	}
+}
+
+static struct diff_filespec *word_diff_filespec(struct repository *r,
+						const char *name,
+						struct strbuf *buf)
+{
+	struct diff_filespec *spec = alloc_filespec(name);
+	size_t size;
+
+	fill_filespec(spec, null_oid(r->hash_algo), 0, 0100644);
+	spec->data = strbuf_detach(buf, &size);
+	spec->size = size;
+	spec->should_free = 1;
+	spec->is_stdin = 1;
+
+	return spec;
+}
+
+static void show_hunk_word_diff(struct add_p_state *s, struct hunk *hunk,
+				int colored)
+{
+	struct hunk_header *header = &hunk->header;
+	struct strbuf old = STRBUF_INIT, new = STRBUF_INIT;
+	struct diff_options opts;
+	struct diff_queue_struct queue;
+
+	if (!header->old_offset && !header->new_offset) {
+		strbuf_reset(&s->buf);
+		render_hunk(s, hunk, 0, colored, &s->buf);
+		fputs(s->buf.buf, stdout);
+		return;
+	}
+
+	build_word_diff_files(s, hunk, &old, &new);
+
+	repo_diff_setup(s->r, &opts);
+	opts.output_format = DIFF_FORMAT_PATCH;
+	opts.use_color = colored ? s->cfg.use_color_diff : GIT_COLOR_NEVER;
+	opts.word_diff = DIFF_WORDS_PLAIN;
+	opts.context = header->old_count > header->new_count ?
+		header->old_count : header->new_count;
+	opts.flags.suppress_diff_headers = 1;
+	diff_setup_done(&opts);
+
+	memcpy(&queue, &diff_queued_diff, sizeof(diff_queued_diff));
+	diff_queue_init(&diff_queued_diff);
+	diff_queue(&diff_queued_diff,
+		   word_diff_filespec(s->r, "a", &old),
+		   word_diff_filespec(s->r, "b", &new));
+	diffcore_std(&opts);
+	diff_flush(&opts);
+	memcpy(&diff_queued_diff, &queue, sizeof(diff_queued_diff));
+}
+
 #define DISPLAY_HUNKS_LINES 20
 static size_t display_hunks(struct add_p_state *s,
 			    struct file_diff *file_diff, size_t start_index)
@@ -1540,6 +1640,7 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "w - print the current hunk with word-diff\n"
    "p - print the current hunk\n"
    "P - print the current hunk using the pager\n"
    "> - go to the next file, roll over at the bottom\n"
@@ -1731,7 +1832,7 @@ static size_t patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
 				strbuf_addstr(&s->buf, ",<");
 			}
-			strbuf_addstr(&s->buf, ",p,P");
+			strbuf_addstr(&s->buf, ",w,p,P");
 		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -1953,6 +2054,8 @@ static size_t patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
+		} else if (s->answer.buf[0] == 'w') {
+			show_hunk_word_diff(s, hunk, colored);
 		} else if (ch == 'p') {
 			rendered_hunk_index = -1;
 			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..e1ce98d62b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -48,8 +48,8 @@ test_expect_success 'unknown command' '
 	git add -N command &&
 	git diff command >expect &&
 	cat >>expect <<-EOF &&
-	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
-	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]?$SP
+	(1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]?$SP
 	EOF
 	git add -p -- command <command >actual 2>&1 &&
 	test_cmp expect actual
@@ -332,9 +332,9 @@ test_expect_success 'different prompts for mode change/deleted' '
 	git -c core.filemode=true add -p >actual &&
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
-	(1/1) Stage deletion [y,n,q,a,d,p,P,?]?
-	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,P,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]?
+	(1/1) Stage deletion [y,n,q,a,d,w,p,P,?]?
+	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,w,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -521,13 +521,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk 1 with "g 1"' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,3          +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? + 1:  -1,2 +1,3          +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -550,11 +550,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
 test_expect_success 'navigate to hunk via regex /pattern' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,27 +579,42 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print hunk with word-diff' '
+	test_when_finished "rm -rf word-diff-repo" &&
+	git init word-diff-repo &&
+	(
+		cd word-diff-repo &&
+		test_write_lines "alpha old beta" context >word-diff &&
+		git add word-diff &&
+		git commit -m word-diff &&
+		test_write_lines "alpha new beta" context >word-diff &&
+		test_write_lines w n | git add -p word-diff >actual &&
+		test_grep "alpha \\[-old-\\]{+new+} beta" actual &&
+		git diff --cached --exit-code
+	)
+'
+
 test_expect_success TTY 'print again the hunk (PAGER)' '
 	test_when_finished "git reset" &&
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -796,21 +811,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,w,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
@@ -1424,9 +1439,9 @@ test_expect_success 'invalid option s is rejected' '
 	test_write_lines j s q | git add -p >out &&
 	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
 	cat >expect <<-EOF &&
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, cannot split this hunk
-	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
+	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,w,p,P,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? Sorry, cannot split this hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?
 	EOF
 	test_cmp expect actual
 '
-- 
2.54.0

