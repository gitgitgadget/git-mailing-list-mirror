Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543561;
	b=Rka5Z7ElSqyD0If1ttXTmF84kZDHsG8IpqUtD/O36YWspq94plG+Lp4JHteYNpisMcg5
	 bRuDrEAoGWKVDUGGC8MzvkkpX4+lK3tvsERv1nve7qpUJkQdyWD03iZvumM8vbe1z3C+w
	 hs5AVlgxndVdiq3H47awDVZDMc2e7my1h+3gnBCG0tzOh29pB02pcY9xJqTIwTNx7gZZc
	 94AOjR0ba/3uiUCahxJfvtwOvNGEQU5P1klvjnT5IQ/QkmihDQublsZrSWq3i5Uuu3IaU
	 uq9ozOOtaLQ6cNHtEEKgUY46Hi54n3GuvBQbDqnA/zB4jASZf65MBXO+GzzlzczxpTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VToQ3tfS5wjZVOD1ewxXitSXbw7ms4n6OeCPwNoc0xE=;
	b=Fz8ZEb5io5/+bNkgC+YdHrEKSNIhkBmopqosysVfNiLU5qX9D2R0jy3B1zHqaU5v84sn
	 Snf1/vp4QaF6WT73bmfltcG4Rh7Il16td14nEuAB0HIAjdEV+04qx8Qv+g3iFRNvd703r
	 klCLhl7GoRp5kzuY4M/vWP9igKWqRTG9i3utYzf3c4fJ0q2nTBplLxc/P9Ti7afEnVCDu
	 7ToBSYfDlM4xeDWHTENBXU+O08iogj1tlmt6EVxE+bm/2fYyFwD0VYrzbH0KI6EGRnX8n
	 gcK3whVMVgDi8Fp+IbgX/kaTeumOPGo0Ax2tWIJIyPNNDyDln0AKPMGYLwK4Xo9M9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZAn0LGWt;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CB606A699
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482CB606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZAn0LGWt
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a68703d177so2292276f8f.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543557; x=1796148357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VToQ3tfS5wjZVOD1ewxXitSXbw7ms4n6OeCPwNoc0xE=;
        b=ZAn0LGWt3TEqq04eAaKLIcyJA3a5bf7E6ujeooIcuBWDCgqFI92jAbQyJlkmSfpqap
         xdIzhboqO4u2CcACwi/+WT/Qn+ZOHacUP3Ojw7I9lEBYO5bJX/irMsU6l/V6HskWLpN+
         NhV2bskVRU61KLS2dKbXNdQghB89eQ6Ust3m0+UM5+8i4//Atnlfpc4xh18vFmLvj7an
         Iip0U2iM0iuWzGs6f9u5FCHx4qTLtvw+wZ4y0Lq0Ej03bA/r4CzSZze0OgU2QDWO2CcD
         AlA+rSZRi2hTqGUPmOtezJaM0SJEDEgphnpIybxeXk9d35nOaPliMDlhWHim2Yqk+0ln
         UlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543557; x=1796148357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VToQ3tfS5wjZVOD1ewxXitSXbw7ms4n6OeCPwNoc0xE=;
        b=RO/0dUNNDyKNeVGzaGkXskkChN+5JOl/QrQNQ8xd35T6F2ZRQy0GrBKFjml4qAtZPP
         0fdpjPeYTNJ2MliHsRgLB8FiDRKI+XCfc2DIjhqGbhtYHTvFCKtPLIHLV8MYR3w/4vFJ
         6QGxjld23nOINEQgNalSNwFzjaKAqKt/S8M9SxsLX6isHY2RHlYEX1HqoL7/wkzIt40o
         mqvKYSwqnfaGl1zf7oqocBhXJ1jIhgsLQcAaSLs+DR0KtQCnLfpNRBojbXA442ugaADX
         4JLwHWJ2heMYGrYccP6qvV1CN63edUtLR7g5xzI3jfyf1aAIdAQ2j/3l/IScpigNcJz2
         DHAw==
X-Gm-Message-State: APuU4Z9uTpPhucdBtDgiPRFr1G/oWlCcsVmhKxQnJ6FO2BLrL/Cl4i2l
	4h0wl/Hy5UED7F2E4ylecaC69mE35Vfk7Y8S9fIEr6l70l7Ix8ARzMR1jhaIbitFu/mBg0iO/tg
	+DX9vOQI1wGGJfjXZ4HU7Op89q+nzL5oBQPMUNRlpA54WpAB2jpqfqX4hH111j9RcSoP2nFGULj
	Zc028Sr8YKOX/gsagVXwslgg==
X-Received: from wrnk5.prod.google.com ([2002:adf:e8c5:0:b0:49e:12c6:13bc])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:47d4:b0:493:8c32:94
 with SMTP id ffacd0b85a97d-4abb400ae31mr19752948f8f.38.1795543557121; Tue, 24
 Nov 2026 10:05:57 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:56 +0000
In-Reply-To: <20261119192307.2683812-1-dmnk@google.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192307.2683812-1-dmnk@google.com>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <20261124180556.69724-1-dmnk@google.com>
Subject: [PATCH v2] config: skip continued lines when matching section
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

repo_config_copy_or_rename_section_in_file() scans the config file line
by line and treats any line whose first non-whitespace character is '['
as the start of a new section, without tracking backslash-continued
values across lines, unlike git_parse_source().

When a value in the target section spans multiple lines via a trailing
backslash and a continuation line begins with '[other]', removing,
renaming, or copying the section mishandles '[other]' and can leave the
remainder of the continued value behind as an unquoted '[other]'
section.

Track backslash value continuations (matching git_parse_source() on
quoted subsections, quote state across continued lines, CRLF line
endings, and bare carriage returns inside subsections or values), only
treat '[' as a section header at the start of a logical line, and copy
any inline entry following a copied section header.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
Changes in v2:
- Move was_continued declaration to the top of the loop block to fix
  -Wdeclaration-after-statement, and trim the Cc list (Junio).
- Treat bare '\r' as a regular character rather than a line break so
  subsections and values containing '\r' follow git_parse_source(), while
  still handling CRLF line continuations (Phillip Wood).
- Reject empty '[]' section headers and preserve inline entries after a
  copied section header so 'git branch -c' handles continued inline
  entries as well.

 config.c          | 146 +++++++++++++++++++++++++++++++++++++++++++++-
 t/t1300-config.sh |  77 ++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 275e709f06..cbdf3431f3 100644
--- a/config.c
+++ b/config.c
@@ -3428,6 +3428,140 @@ static int section_name_is_ok(const char *name)
 
 #define GIT_CONFIG_MAX_LINE_LEN (512 * 1024)
 
+static int is_config_eol(const char *p, const char *end)
+{
+	return p >= end || *p == '\n' ||
+	       (*p == '\r' && p + 1 < end && p[1] == '\n');
+}
+
+static const char *skip_section_header(const char *p, const char *end)
+{
+	const char *start;
+
+	if (is_config_eol(p, end) || *p != '[')
+		return NULL;
+	for (start = ++p; !is_config_eol(p, end); p++) {
+		if (*p == ']')
+			return p > start ? p + 1 : NULL;
+		if (isspace(*p)) {
+			while (!is_config_eol(p, end) && isspace(*p))
+				p++;
+			if (is_config_eol(p, end) || *p != '"')
+				return NULL;
+			for (p++; !is_config_eol(p, end); p++) {
+				if (*p == '\\') {
+					p++;
+					if (is_config_eol(p, end))
+						return NULL;
+					continue;
+				}
+				if (*p == '"') {
+					p++;
+					return (!is_config_eol(p, end) &&
+						*p == ']') ? p + 1 : NULL;
+				}
+			}
+			return NULL;
+		}
+		if (!iskeychar(*p) && *p != '.')
+			return NULL;
+	}
+	return NULL;
+}
+
+static void update_line_continuation(const char *p, const char *end,
+				     int is_first_line, int *continued,
+				     int *in_quote)
+{
+	int in_value = *continued;
+
+	if (is_first_line) {
+		size_t rem = end - p;
+		skip_prefix_mem(p, rem, utf8_bom, &p, &rem);
+	}
+
+	if (!in_value) {
+		while (!is_config_eol(p, end)) {
+			if (isspace(*p)) {
+				p++;
+				continue;
+			}
+			if (*p == '#' || *p == ';') {
+				*continued = 0;
+				*in_quote = 0;
+				return;
+			}
+			if (*p == '[') {
+				p = skip_section_header(p, end);
+				if (!p) {
+					*continued = 0;
+					*in_quote = 0;
+					return;
+				}
+				continue;
+			}
+			if (!isalpha(*p)) {
+				*continued = 0;
+				*in_quote = 0;
+				return;
+			}
+			for (p++; !is_config_eol(p, end) && iskeychar(*p); p++)
+				; /* skip key name */
+			while (!is_config_eol(p, end) &&
+			       (*p == ' ' || *p == '\t'))
+				p++;
+			if (!is_config_eol(p, end) && *p == '=') {
+				p++;
+				in_value = 1;
+				break;
+			}
+			*continued = 0;
+			*in_quote = 0;
+			return;
+		}
+		if (!in_value) {
+			*continued = 0;
+			*in_quote = 0;
+			return;
+		}
+	}
+
+	for (; !is_config_eol(p, end); p++) {
+		if (!*in_quote && (*p == '#' || *p == ';')) {
+			*continued = 0;
+			return;
+		}
+		if (*p == '"') {
+			*in_quote = !*in_quote;
+			continue;
+		}
+		if (*p == '\\') {
+			p++;
+			if (is_config_eol(p, end)) {
+				*continued = (p < end);
+				if (!*continued)
+					*in_quote = 0;
+				return;
+			}
+			switch (*p) {
+			case 't':
+			case 'b':
+			case 'n':
+			case '\\':
+			case '"':
+				break;
+			default:
+				*continued = 0;
+				*in_quote = 0;
+				return;
+			}
+		}
+	}
+
+	*continued = 0;
+	*in_quote = 0;
+}
+
 /* if new_name == NULL, the section is removed instead */
 static int repo_config_copy_or_rename_section_in_file(
 	struct repository *r,
@@ -3435,7 +3569,7 @@ static int repo_config_copy_or_rename_section_in_file(
 	const char *old_name,
 	const char *new_name, int copy)
 {
-	int ret = 0, remove = 0;
+	int ret = 0, remove = 0, continued = 0, in_quote = 0;
 	char *filename_buf = NULL;
 	struct lock_file lock = LOCK_INIT;
 	int out_fd;
@@ -3485,7 +3619,7 @@ static int repo_config_copy_or_rename_section_in_file(
 
 	while (!strbuf_getwholeline(&buf, config_file, '\n')) {
 		size_t i, length;
-		int is_section = 0;
+		int is_section = 0, was_continued = continued;
 		char *output = buf.buf;
 
 		line_nr++;
@@ -3499,7 +3633,9 @@ static int repo_config_copy_or_rename_section_in_file(
 
 		for (i = 0; buf.buf[i] && isspace(buf.buf[i]); i++)
 			; /* do nothing */
-		if (buf.buf[i] == '[') {
+		update_line_continuation(buf.buf, buf.buf + buf.len,
+					 line_nr == 1, &continued, &in_quote);
+		if (!was_continued && buf.buf[i] == '[') {
 			/* it's a section */
 			size_t offset;
 			is_section = 1;
@@ -3550,6 +3686,10 @@ static int repo_config_copy_or_rename_section_in_file(
 				} else {
 					strbuf_release(&copystr);
 					copystr = store_create_section(new_name, &store);
+					if (output[offset + i]) {
+						strbuf_addch(&copystr, '\t');
+						strbuf_addstr(&copystr, output + offset + i);
+					}
 				}
 			}
 			remove = 0;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 16bb396b63..b5b6fc2acc 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -3081,4 +3081,81 @@ test_expect_success POSIXPERM 'refuse to "overwrite" a read-only file' '
 	)
 '
 
+test_expect_success 'remove-section and rename-section ignore bracketed continuation lines' '
+	test_when_finished "rm -f multiline.cfg rename.cfg subbracket.cfg cr.cfg crlf.cfg emptysec.cfg raw actual expect" &&
+	cat >multiline.cfg <<-\EOF &&
+	[old]
+		key = "first \
+	[smuggled] \
+	# quoted hash \
+		evil = yes" ; comment \
+	[keep]
+		ok = true
+	EOF
+	cp multiline.cfg rename.cfg &&
+
+	git config --file=multiline.cfg --remove-section old &&
+	test_must_fail git config --file=multiline.cfg --get smuggled.evil &&
+	test "$(git config --file=multiline.cfg --get keep.ok)" = true &&
+
+	git config --file=rename.cfg --rename-section old renamed &&
+	test_must_fail git config --file=rename.cfg --get smuggled.evil &&
+	git config --file=rename.cfg --get renamed.key >actual &&
+	test_grep "\[smuggled\]" actual &&
+	test "$(git config --file=rename.cfg --get keep.ok)" = true &&
+
+	cat >subbracket.cfg <<-\EOF &&
+	[keep "a] = \""] k = v ; \
+	[old]
+		secret = should_be_removed
+	EOF
+	git config --file=subbracket.cfg --remove-section old &&
+	test_must_fail git config --file=subbracket.cfg --get old.secret &&
+	test "$(git config --file=subbracket.cfg --get "keep.a] = \".k")" = v &&
+
+	printf "[a \"b\rc\"]\rkey=\rv\ralue\\\\\n[smuggled]\n\tevil = yes\n[keep]\n\tok = true\n" >cr.cfg &&
+	git config --file=cr.cfg --rename-section "$(printf "a.b\rc")" renamed &&
+	test_must_fail git config --file=cr.cfg --get smuggled.evil &&
+	git config --file=cr.cfg --get renamed.key >raw &&
+	tr "\r" Q <raw >actual &&
+	echo "vQalue[smuggled]" >expect &&
+	test_cmp expect actual &&
+	git config --file=cr.cfg --remove-section renamed &&
+	test_must_fail git config --file=cr.cfg --get smuggled.evil &&
+	test "$(git config --file=cr.cfg --get keep.ok)" = true &&
+
+	printf "[old]\r\n\tkey = first \\\\\r\n[smuggled]\r\n\tevil = yes\r\n[keep]\r\n\tok = true\r\n" >crlf.cfg &&
+	git config --file=crlf.cfg --remove-section old &&
+	test_must_fail git config --file=crlf.cfg --get smuggled.evil &&
+	test "$(git config --file=crlf.cfg --get keep.ok)" = true &&
+
+	cat >emptysec.cfg <<-\EOF &&
+	[] k = v \
+	[old]
+		secret = gone
+	EOF
+	git config --file=emptysec.cfg --remove-section old &&
+	test_grep ! "secret" emptysec.cfg &&
+
+	test_when_finished "rm -rf copy-repo" &&
+	git init copy-repo &&
+	(
+		cd copy-repo &&
+		test_commit init &&
+		git branch src &&
+		cat >>.git/config <<-\EOF &&
+		[branch "src"] note = first \
+		[smuggled]
+			evil = yes
+		[keep]
+			ok = true
+		EOF
+		git branch -c src dst &&
+		test_must_fail git config --get smuggled.evil &&
+		test "$(git config --get branch.dst.note)" = "first [smuggled]" &&
+		test "$(git config --get branch.dst.evil)" = yes &&
+		test "$(git config --get keep.ok)" = true
+	)
+'
+
 test_done

Range-diff against v1:
1:  8f0e9e660a ! 1:  8047ce90c2 config: skip continued lines when matching section
    @@ Commit message
         repo_config_copy_or_rename_section_in_file() scans the config file line
         by line and treats any line whose first non-whitespace character is '['
         as the start of a new section, without tracking backslash-continued
    -    values across lines.
    +    values across lines, unlike git_parse_source().
     
         When a value in the target section spans multiple lines via a trailing
    -    backslash and a continuation line begins with '[other]', removing or
    -    renaming the section stops early at '[other]' and leaves the remainder
    -    of the continued value behind as an unquoted '[other]' section.
    +    backslash and a continuation line begins with '[other]', removing,
    +    renaming, or copying the section mishandles '[other]' and can leave the
    +    remainder of the continued value behind as an unquoted '[other]'
    +    section.
     
    -    Track backslash value continuations (including quoted subsections and
    -    quote state across continued lines so '#' or ';' inside quotes are not
    -    mistaken for comments) and only treat '[' as a section header at the
    -    start of a logical line.
    +    Track backslash value continuations (matching git_parse_source() on
    +    quoted subsections, quote state across continued lines, CRLF line
    +    endings, and bare carriage returns inside subsections or values), only
    +    treat '[' as a section header at the start of a logical line, and copy
    +    any inline entry following a copied section header.
     
         Signed-off-by: Dominik Maier <dmnk@google.com>
     
    @@ config.c: static int section_name_is_ok(const char *name)
      
      #define GIT_CONFIG_MAX_LINE_LEN (512 * 1024)
      
    -+static const char *skip_section_header(const char *line)
    ++static int is_config_eol(const char *p, const char *end)
     +{
    -+	const char *p = line;
    ++	return p >= end || *p == '\n' ||
    ++	       (*p == '\r' && p + 1 < end && p[1] == '\n');
    ++}
    ++
    ++static const char *skip_section_header(const char *p, const char *end)
    ++{
    ++	const char *start;
     +
    -+	if (*p != '[')
    -+		return line;
    -+	for (p++; *p && *p != '\r' && *p != '\n'; p++) {
    ++	if (is_config_eol(p, end) || *p != '[')
    ++		return NULL;
    ++	for (start = ++p; !is_config_eol(p, end); p++) {
     +		if (*p == ']')
    -+			return p + 1;
    -+		if (*p == ' ' || *p == '\t') {
    -+			while (*p == ' ' || *p == '\t')
    ++			return p > start ? p + 1 : NULL;
    ++		if (isspace(*p)) {
    ++			while (!is_config_eol(p, end) && isspace(*p))
     +				p++;
    -+			if (*p != '"')
    ++			if (is_config_eol(p, end) || *p != '"')
     +				return NULL;
    -+			for (p++; *p && *p != '\r' && *p != '\n'; p++) {
    ++			for (p++; !is_config_eol(p, end); p++) {
     +				if (*p == '\\') {
     +					p++;
    -+					if (!*p || *p == '\r' || *p == '\n')
    ++					if (is_config_eol(p, end))
     +						return NULL;
     +					continue;
     +				}
     +				if (*p == '"') {
    -+					for (p++; *p == ' ' || *p == '\t'; p++)
    -+						; /* skip trailing space before ']' */
    -+					return (*p == ']') ? p + 1 : NULL;
    ++					p++;
    ++					return (!is_config_eol(p, end) &&
    ++						*p == ']') ? p + 1 : NULL;
     +				}
     +			}
     +			return NULL;
     +		}
    ++		if (!iskeychar(*p) && *p != '.')
    ++			return NULL;
     +	}
     +	return NULL;
     +}
     +
    -+static void update_line_continuation(const char *p, int *continued,
    ++static void update_line_continuation(const char *p, const char *end,
    ++				     int is_first_line, int *continued,
     +				     int *in_quote)
     +{
     +	int in_value = *continued;
     +
    ++	if (is_first_line) {
    ++		size_t rem = end - p;
    ++		skip_prefix_mem(p, rem, utf8_bom, &p, &rem);
    ++	}
    ++
     +	if (!in_value) {
    -+		while (isspace(*p))
    -+			p++;
    -+		if (*p == '[') {
    -+			p = skip_section_header(p);
    -+			if (!p) {
    ++		while (!is_config_eol(p, end)) {
    ++			if (isspace(*p)) {
    ++				p++;
    ++				continue;
    ++			}
    ++			if (*p == '#' || *p == ';') {
     +				*continued = 0;
     +				*in_quote = 0;
     +				return;
     +			}
    -+		}
    -+		for (; *p && *p != '\r' && *p != '\n'; p++) {
    -+			if (*p == '#' || *p == ';') {
    ++			if (*p == '[') {
    ++				p = skip_section_header(p, end);
    ++				if (!p) {
    ++					*continued = 0;
    ++					*in_quote = 0;
    ++					return;
    ++				}
    ++				continue;
    ++			}
    ++			if (!isalpha(*p)) {
     +				*continued = 0;
     +				*in_quote = 0;
     +				return;
     +			}
    -+			if (*p == '=') {
    ++			for (p++; !is_config_eol(p, end) && iskeychar(*p); p++)
    ++				; /* skip key name */
    ++			while (!is_config_eol(p, end) &&
    ++			       (*p == ' ' || *p == '\t'))
    ++				p++;
    ++			if (!is_config_eol(p, end) && *p == '=') {
     +				p++;
     +				in_value = 1;
     +				break;
     +			}
    ++			*continued = 0;
    ++			*in_quote = 0;
    ++			return;
     +		}
     +		if (!in_value) {
     +			*continued = 0;
    @@ config.c: static int section_name_is_ok(const char *name)
     +		}
     +	}
     +
    -+	for (; *p && *p != '\r' && *p != '\n'; p++) {
    ++	for (; !is_config_eol(p, end); p++) {
     +		if (!*in_quote && (*p == '#' || *p == ';')) {
     +			*continued = 0;
     +			return;
    @@ config.c: static int section_name_is_ok(const char *name)
     +			continue;
     +		}
     +		if (*p == '\\') {
    -+			if (!p[1] || p[1] == '\n' ||
    -+			    (p[1] == '\r' && (!p[2] || p[2] == '\n'))) {
    -+				*continued = 1;
    ++			p++;
    ++			if (is_config_eol(p, end)) {
    ++				*continued = (p < end);
    ++				if (!*continued)
    ++					*in_quote = 0;
    ++				return;
    ++			}
    ++			switch (*p) {
    ++			case 't':
    ++			case 'b':
    ++			case 'n':
    ++			case '\\':
    ++			case '"':
    ++				break;
    ++			default:
    ++				*continued = 0;
    ++				*in_quote = 0;
     +				return;
     +			}
    -+			p++;
     +		}
     +	}
     +
    @@ config.c: static int repo_config_copy_or_rename_section_in_file(
      	struct lock_file lock = LOCK_INIT;
      	int out_fd;
     @@ config.c: static int repo_config_copy_or_rename_section_in_file(
    - 			goto out;
    - 		}
      
    -+		int was_continued = continued;
    -+
    + 	while (!strbuf_getwholeline(&buf, config_file, '\n')) {
    + 		size_t i, length;
    +-		int is_section = 0;
    ++		int is_section = 0, was_continued = continued;
    + 		char *output = buf.buf;
    + 
    + 		line_nr++;
    +@@ config.c: static int repo_config_copy_or_rename_section_in_file(
    + 
      		for (i = 0; buf.buf[i] && isspace(buf.buf[i]); i++)
      			; /* do nothing */
     -		if (buf.buf[i] == '[') {
    -+		update_line_continuation(buf.buf, &continued, &in_quote);
    ++		update_line_continuation(buf.buf, buf.buf + buf.len,
    ++					 line_nr == 1, &continued, &in_quote);
     +		if (!was_continued && buf.buf[i] == '[') {
      			/* it's a section */
      			size_t offset;
      			is_section = 1;
     @@ config.c: static int repo_config_copy_or_rename_section_in_file(
    + 				} else {
      					strbuf_release(&copystr);
      					copystr = store_create_section(new_name, &store);
    ++					if (output[offset + i]) {
    ++						strbuf_addch(&copystr, '\t');
    ++						strbuf_addstr(&copystr, output + offset + i);
    ++					}
      				}
    -+			} else {
    -+				remove = 0;
      			}
    --			remove = 0;
    - 		}
    - 		if (remove)
    - 			continue;
    + 			remove = 0;
     
      ## t/t1300-config.sh ##
     @@ t/t1300-config.sh: test_expect_success POSIXPERM 'refuse to "overwrite" a read-only file' '
    @@ t/t1300-config.sh: test_expect_success POSIXPERM 'refuse to "overwrite" a read-o
      '
      
     +test_expect_success 'remove-section and rename-section ignore bracketed continuation lines' '
    -+	test_when_finished "rm -f multiline.cfg rename.cfg subbracket.cfg" &&
    ++	test_when_finished "rm -f multiline.cfg rename.cfg subbracket.cfg cr.cfg crlf.cfg emptysec.cfg raw actual expect" &&
     +	cat >multiline.cfg <<-\EOF &&
     +	[old]
     +		key = "first \
     +	[smuggled] \
     +	# quoted hash \
    -+		evil = yes"
    ++		evil = yes" ; comment \
     +	[keep]
     +		ok = true
     +	EOF
    @@ t/t1300-config.sh: test_expect_success POSIXPERM 'refuse to "overwrite" a read-o
     +	git config --file=rename.cfg --rename-section old renamed &&
     +	test_must_fail git config --file=rename.cfg --get smuggled.evil &&
     +	git config --file=rename.cfg --get renamed.key >actual &&
    -+	grep "\[smuggled\]" actual &&
    ++	test_grep "\[smuggled\]" actual &&
     +	test "$(git config --file=rename.cfg --get keep.ok)" = true &&
     +
     +	cat >subbracket.cfg <<-\EOF &&
    @@ t/t1300-config.sh: test_expect_success POSIXPERM 'refuse to "overwrite" a read-o
     +	EOF
     +	git config --file=subbracket.cfg --remove-section old &&
     +	test_must_fail git config --file=subbracket.cfg --get old.secret &&
    -+	test "$(git config --file=subbracket.cfg --get "keep.a] = \".k")" = v
    ++	test "$(git config --file=subbracket.cfg --get "keep.a] = \".k")" = v &&
    ++
    ++	printf "[a \"b\rc\"]\rkey=\rv\ralue\\\\\n[smuggled]\n\tevil = yes\n[keep]\n\tok = true\n" >cr.cfg &&
    ++	git config --file=cr.cfg --rename-section "$(printf "a.b\rc")" renamed &&
    ++	test_must_fail git config --file=cr.cfg --get smuggled.evil &&
    ++	git config --file=cr.cfg --get renamed.key >raw &&
    ++	tr "\r" Q <raw >actual &&
    ++	echo "vQalue[smuggled]" >expect &&
    ++	test_cmp expect actual &&
    ++	git config --file=cr.cfg --remove-section renamed &&
    ++	test_must_fail git config --file=cr.cfg --get smuggled.evil &&
    ++	test "$(git config --file=cr.cfg --get keep.ok)" = true &&
    ++
    ++	printf "[old]\r\n\tkey = first \\\\\r\n[smuggled]\r\n\tevil = yes\r\n[keep]\r\n\tok = true\r\n" >crlf.cfg &&
    ++	git config --file=crlf.cfg --remove-section old &&
    ++	test_must_fail git config --file=crlf.cfg --get smuggled.evil &&
    ++	test "$(git config --file=crlf.cfg --get keep.ok)" = true &&
    ++
    ++	cat >emptysec.cfg <<-\EOF &&
    ++	[] k = v \
    ++	[old]
    ++		secret = gone
    ++	EOF
    ++	git config --file=emptysec.cfg --remove-section old &&
    ++	test_grep ! "secret" emptysec.cfg &&
    ++
    ++	test_when_finished "rm -rf copy-repo" &&
    ++	git init copy-repo &&
    ++	(
    ++		cd copy-repo &&
    ++		test_commit init &&
    ++		git branch src &&
    ++		cat >>.git/config <<-\EOF &&
    ++		[branch "src"] note = first \
    ++		[smuggled]
    ++			evil = yes
    ++		[keep]
    ++			ok = true
    ++		EOF
    ++		git branch -c src dst &&
    ++		test_must_fail git config --get smuggled.evil &&
    ++		test "$(git config --get branch.dst.note)" = "first [smuggled]" &&
    ++		test "$(git config --get branch.dst.evil)" = yes &&
    ++		test "$(git config --get keep.ok)" = true
    ++	)
     +'
     +
      test_done
-- 
2.56.1.831.g720f3f5937-goog

