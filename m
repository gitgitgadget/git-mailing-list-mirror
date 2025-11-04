Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F1163
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222516; cv=none; b=gwT7SQ/P2g66MybL5VuRvH7Vwac3V63tmUrYEY/g1dfNCOVfpcIE0GemfUsGkNrzX6hkSodZpaHAKCweCiH+Rv9nbHz0xqEX9R2UveWE0G4z+IaMGS6ih6irnsTQwNtIbCvfxtHVCn4pe1W8wAgsSRd6asdRTEFhallBS2nee7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222516; c=relaxed/simple;
	bh=d6TWHrFEp8mAxjtUvBxYvBkmSYxe1w8aeHhfwhAq/dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqGTqANvSDJX84WhfijQnFolk3Imo75cowRBmEAgMWPcgCY7KScDaVyC44WtdQjE0eGPjNmA+8gkxESozPiPiUaaEfnQq6drcsdhZYGlM37kUjRFJdksrZk4RM3Y7AWnShygjEG23D2w6xnqXTj8Tf71vqEKMETO5C3KwGO5+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB6GhE9+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB6GhE9+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c681a8aecdso3110883a34.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762222514; x=1762827314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpx+NIQSJAC4/VbHqfVLgVEYwyD8wjgXWrOK6nFPMBc=;
        b=NB6GhE9+U7HBxPL545KK5OQLOEf78Y4xNcC9xJl9ImzFhT3I2aqNu7VWIycqZjKg6s
         HU+p/tuizPEYVsk1hHrerdDe85NTkcd2+J836duILMBTrpKjTaZAZ2CTjS1XvE81Jxq5
         tnEUHgCZ4oVFrOslEQ/8+ChYYuEJCqU5BywmZqLxf++FJY9xvhT0bIMjdXJ2T/T6/x3o
         Zs7qcGOnycCmfj4e+UXFZYCAZqVP7m5qu8/nLlwgV+PumahDyknoByzCTf2IReJNCfXB
         P+DHICqQon702yP+Za5g2KEchM80udzZIB1JjsNxBL/u0/oeB7M51fMDC4EYm3ISa/1q
         ptjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762222514; x=1762827314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpx+NIQSJAC4/VbHqfVLgVEYwyD8wjgXWrOK6nFPMBc=;
        b=GVJoHx4ezUK1eFXAId7wCzPhUxLarAQ3rgopLRJdr5S3185PngQsY/68oEwCRB5Rfp
         UojuX1btiq+Y5e1akXYjttBFpBTe6kgxBZW/HHVed7GwXAhTmJy7fMVy+CqgLkTUVlLu
         lU6AV9iLJ8vdNRxmWWRsEOdfSutvJWaRY4rkz1o8lylPSXFFcCy4jwsjRLu5KcBXZJ0V
         va84bz5eNG+Fv7+cXWd3h9oPxtrPZ20mmx1os7gdVYn+vilJ8O8BslJidprqWUXvz21n
         Lte5Jp/VtNGuR8Ngi7hKrri4+51p0l03TTJZFUqdMiDOUO/NuvIOl5FkzACd+gWsF92c
         AElQ==
X-Gm-Message-State: AOJu0YyjQvSS3vtdXbBTZOy7QelGBAcF6hS21xxZZKdGQ7orQOrXf0Rt
	/OFTFu49UF/dYSOBs9Sz5g/fXxeVsInVebh/Uo4q9StkJQik78L5BPVsVfLaTQ==
X-Gm-Gg: ASbGncuR8eC+eFyv2WGjdcHG7jHyjx1jFl/r33y0r+sqywtlyalDkrQ0fEilyVeHL7t
	XniCHefEZojGlXMfqoOZMG9irArIefOSaWadAwHlW+6jUHBFQ7XUOjjdOloCm4DhzgRk7Qhm8lJ
	vwBxg/bFzkD8BLYOQt/LU1XneE8IoyAa4OOnwN5LdytltokLCmRjuUMXxMyb1fZurjF1BPkthm0
	NqueDWq01K+2HvvgAqJpQE2RhHO7VAHcxsVUPW+cLFW6WWxP4UdOHjWwg7f8ahjE5k6KJDfWtJu
	rIf84qNYuHL/cUi/X4pFY5RhaBEp73E0q4ZMBGxLLOgrRcF+DyDrxBC6iiuiIoK4yZL0ftGmU7T
	YlSzd+mH60BRy9nnKpD8CkT02UBZ14oWsCcfW9RdZpAM53gX4CgofQWL9nXClViwnsZcZGegDIW
	aa6e+yxk71
X-Google-Smtp-Source: AGHT+IG9bkl99djOv8Cmj6L6ouEKqzfPqhel2GGVrVITdB/AM+UpH5vM0gNtILHOndZylfd8IYui2g==
X-Received: by 2002:a05:6830:6e1a:b0:7c6:9d7b:b033 with SMTP id 46e09a7af769-7c69d7bb21fmr5548990a34.22.1762222513868;
        Mon, 03 Nov 2025 18:15:13 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6caef5187sm19410a34.8.2025.11.03.18.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 18:15:13 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [RFC PATCH] diff: add option to report binary files in raw diffs
Date: Mon,  3 Nov 2025 20:14:55 -0600
Message-ID: <20251104021455.379807-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When generating patch diff output, if either side of a filepair is
detected as binary, Git omits the diff content and instead prints a
"Binary files differ" message. From this message it is known that at
least one of the files in the pair is considered binary, but not exactly
which ones.

Add a --report-binary-files diff option that, when enabled, extends the
raw diff output format to explicitly indicate for each file whether it
was considered binary or not.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

I have a usecase where I would like to know exactly which files in a
diff pair are considered binary by Git when computing diffs. When
computing patch diff output, Git already omits filepair diffs where at
least one side is considered binary and prints a "binary files differ"
message instead. From this message we cannot discern exactly which files
were considered binary by Git though.

In this patch, the raw diff format is extended with a
`--report-binary-files` option to explicitly specify which files in the
diff pair were considered binary. The output in this form looks
something like this:

        $ git diff-tree --abbrev=8 --report-binary-files HEAD~ HEAD
        :100644 100644 a1961526 e231acb1 bt M	foo
        :100644 100644 31eedd5c 402a70d7 bb M	bar

With this format, there is a new column before the status that specifies
the binary status for each file. 'b' indicates binary and 't' is used
otherwise.

In an earlier iteration of this patch, I originally extended the patch
output "binary files differ" message to indicate the binary status for
each file in the diff pair, but felt it wasn't the best place to do so
since I also want it to be machine friendly. So I ended up extending the
raw diff format instead.

I'm not entirely sure the current implementation is most ideal format
here so I'm very open to feedback. :)

-Justin

---
 Documentation/diff-format.adoc  | 12 ++++++++++++
 Documentation/diff-options.adoc |  4 ++++
 diff.c                          |  9 +++++++++
 diff.h                          |  6 ++++++
 t/t4012-diff-binary.sh          | 29 +++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 9f7e988241..74c0a064ad 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -83,6 +83,18 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+With the `--report-binary-files` option, a new column is added prior to the
+status indicating for each file if Git considered it binary or not. If
+considered binary, a file is denoted with `b`. Otherwise, `t` is used. This
+column is followed by a space character. Combined diffs do not report binary
+file info.
+
+Example:
+
+------------------------------------------------
+:100644 100644 5be4a4a cc95eb0 bt M file.c
+------------------------------------------------
+
 diff format for merges
 ----------------------
 
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index ae31520f7f..54eb48c067 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -544,6 +544,10 @@ ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
 
+`--report-binary-files`::
+	Adds a column to raw diff output to report for each file in the pair
+	whether it was considered binary by Git.
+
 `--abbrev[=<n>]`::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
diff --git a/diff.c b/diff.c
index a1961526c0..e231acb1a9 100644
--- a/diff.c
+++ b/diff.c
@@ -5747,6 +5747,8 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "binary", options, NULL,
 			       N_("output a binary diff that can be applied"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
+		OPT_BOOL(0, "report-binary-files", &options->report_binary_files,
+			 N_("report if pre- and post-image blobs are binary")),
 		OPT_BOOL(0, "full-index", &options->flags.full_index,
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_COLOR_FLAG(0, "color", &options->use_color,
@@ -6111,6 +6113,13 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 		fprintf(opt->file, "%s ",
 			diff_aligned_abbrev(&p->two->oid, opt->abbrev));
 	}
+
+	if (opt->report_binary_files) {
+		char one = diff_filespec_is_binary(opt->repo, p->one) ? 'b' : 't';
+		char two = diff_filespec_is_binary(opt->repo, p->two) ? 'b' : 't';
+		fprintf(opt->file, "%c%c ", one, two);
+	}
+
 	if (p->score) {
 		fprintf(opt->file, "%c%03d%c", p->status, similarity_index(p),
 			inter_name_termination);
diff --git a/diff.h b/diff.h
index 31eedd5c0c..402a70d7ad 100644
--- a/diff.h
+++ b/diff.h
@@ -369,6 +369,12 @@ struct diff_options {
 	 */
 	int skip_resolving_statuses;
 
+	/*
+	 * When generating raw diff output, report for each file whether it was
+	 * considered binary.
+	 */
+	int report_binary_files;
+
 	/* Callback which allows tweaking the options in diff_setup_done(). */
 	void (*set_default)(struct diff_options *);
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index d1d30ac2a9..e026e1d3a4 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -130,4 +130,33 @@ test_expect_success 'diff --stat with binary files and big change count' '
 	test_cmp expect actual
 '
 
+test_expect_success SHA1 'diff --report-binary-files' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo foo >foo &&
+		printf "\0bar\0" >bar &&
+		echo baz >baz &&
+		git add foo bar baz &&
+		git commit -m foo &&
+
+		printf "\0foo\0" >foo &&
+		printf "\0bar2\0" >bar &&
+		echo baz2 >baz &&
+		git commit -am "binary foo" &&
+
+		cat >expect <<-\EOF &&
+		:100644 100644 e02d9a3a8aeb904ccc3bb9ed0600f2e963ba1a10 884a24af772a87733e911a3491c0ab576d34c06c bb M	bar
+		:100644 100644 76018072e09c5d31c8c6e3113b8aa0fe625195ca 3414c84ca6b7ca9cbbe40dd44f4d0715c1464f6e tt M	baz
+		:100644 100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 a60073ceafeca287824d7b9ac3eebef233b72fce tb M	foo
+		EOF
+
+		git diff-tree --report-binary-files HEAD~ HEAD >out &&
+
+		test_cmp expect out
+	)
+'
+
 test_done

base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
-- 
2.51.0.193.g4975ec3473b

