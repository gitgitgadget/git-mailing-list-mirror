Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF051514F7
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972167; cv=none; b=oriUfoOD9iRT4IWd/5HsxmYGUZGTPe3v7tBSgual3PtIzELW2QGkjhvKIzUkKToNCyt8u3UyMDKQ/jYTxovlyNJdPXCckOlxYSNBWPCqsJySRg75yf0NAKWQaKITa949GPXcHULl2rYhb0KAIpTQUdiNpCCzRlGEi9I5HmGHxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972167; c=relaxed/simple;
	bh=Js0A+0x/cNcrqP4Cu5zfC1fEeElHaXcbRbkGZMd8Ys0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VMtak11wnLkcwt9O+aX9QJ7QQ29Yfx7a3670RrHshusWlnIwon7TGU7q/I+svqpt2BVTNBCCCWuzOz+ISZO+89rCtmqvivVHQ7CawCWIY/vL0/XmjmFrw5j7VYczrZr+MFtUjjciEKyMkLrj8sXkakeJiK+gq5kZdscW4i8o52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FARFHH3x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FARFHH3x"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8915bd01244so629627285a.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760972164; x=1761576964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QyM408q88cXh4kJo0XeDLy7UW4Orys/161diZuLNDfs=;
        b=FARFHH3x75pIwXZlYfXMMbkSWOKHjm6kh/kWrhpcC4685Ig52l7HTaInZg3o415Xr3
         4hhbZoe7+pzUcsCUFgdXZMj5DeAHbK2Dw3erHlc7Up6a5w1muj5rQqK6tX1uVSBouJIK
         pRNZrvV9om1cfigEV6T96NHzMO/Tv+9COPTpy5zmkKlcT03rToptk7hYCz+fIYjMelrU
         M2pp1vmW8YkeZHqqFjJmUGuT1QBA+NzZ+eWKSzivgklxqAX7lQjx6dB32ELRaHtz3HX9
         3lV/wgSh1RlOHuEUd/HjapDfaHC6zLEy/hDS3FMqdcNLkThjehreOl1wvXFWE9ONzRfM
         i1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972164; x=1761576964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyM408q88cXh4kJo0XeDLy7UW4Orys/161diZuLNDfs=;
        b=ascUk9jpN/t6sziJnpwEW0sLEdgmkhddRFyf8Q3fuOIr0eb/Au0LU0amzItR16/ShR
         DU3PDAeuYGFmSWs7H687WdzZb11Gll8wpBZzlCrjpU12vfR8xunDsNHJ+NRyQp2FsXuk
         C1ZL7/cYr5EAn9u6q9dltk7iZ50QSmOXCL2uSFANNXynwerjQCZEjIfFvTDoIJVAmm7g
         Br/MbynX5+hNs8PpKc2jTzUmFCVo6lDoQLkSzZ96pp4MpEOg98x0JE/mH6Yc/3ZW83Ot
         LWreSFzJyLiVaiYoBZ2IOiTbWArKd4CRwKOoo69t0jRRZmfoQkPdjfpUoMHP18fyIpoZ
         VhhQ==
X-Gm-Message-State: AOJu0Yz3PwNuLSxOZiqrgA6lWvqRSN+E6cDbue22LVDu8x61F13upVJT
	NjWeVO9sSZt42xcEciyqhxUVquDG/bQEwv6s3lIzFnPdtpqCz96J7dnwQ8mfaw==
X-Gm-Gg: ASbGncsVgrtEJ5O7BbhSrlbYlxiPTWtzQL9hWgjurwyRYPa9iKpsFOTGrohFTXyjF76
	CP3nZf1HhER7uKXHh7QXj+erLTUnDO8YCTyi+gxovEjvOy+aIHJSSTMxaR/AMvqAmCU58z2K4Wr
	pjwH3GByGqZJVibELSNdebeLl+xl9t4NxsIR/atdkxupTDytCkltKL6he0kqOyy9N5fS5hWXyUn
	V39OhBmrplb0K7TXBCKbuDfnGlDzgsKGwi+aMNiu7X+4ZhPkP0DEuUu4uvFwmeGXcDkIh3HxbVr
	oyMQV0u0UVnBwbcLlDh8YK6fa5WIlSDQ3WDd2I0DIUw5L0tcRfCewXMtFZQP0IN/0MMghiSAS7f
	54vMhA/p8fLMB6iTyPJP4znduHgt+moXuMDL44sb+o5tK/rUaSYVBklX/17c7H2BNz7+epGyy2T
	37cA==
X-Google-Smtp-Source: AGHT+IG/TKhTuE0JYu871WbSynh5AbSgKtpTgAbuOhHvXZ5wb35p0XEZ7phQEXXGNpIcVSeGQbmlwQ==
X-Received: by 2002:a05:620a:a1d8:10b0:891:6851:a0bf with SMTP id af79cd13be357-8916851a413mr1141655485a.21.1760972164000;
        Mon, 20 Oct 2025 07:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.165.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8924e082780sm493510485a.51.2025.10.20.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:56:03 -0700 (PDT)
Message-Id: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Oct 2025 14:56:02 +0000
Subject: [PATCH] blame: make diff algorithm configurable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

The diff algorithm used in 'git-blame(1)' can be configured using the
`--diff-algorithm` option or the `diff.algorithm` config variable.
Myers diff remains the default.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    blame: make diff algorithm configurable
    
    There has been long-standing interest in changing the default diff
    algorithm to "histogram", and Git 3.0 was floated as a possible occasion
    for that: https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/
    
    As a preparation, it is worth making sure that the diff algorithm is
    configurable where useful. It can have significant impact on the output
    of the git-blame command, so I propose to make it configurable there
    too. I have followed the convention of other commands (such as git-diff)
    to introduce a --diff-algorithm option.
    
    I understand that this command is a user-facing (porcelain) one, so I
    think making it honor the diff.algorithm UI config variable is also
    appropriate. The git-blame command has a machine-readable format that
    can be enabled with --porcelain (which should be called --plumbing if
    you ask me) so I wonder if the diff.algorithm variable should still be
    honored in this case, as there could be the desire to keep it
    independent from UI config variables (similarly to git-merge-file, a
    plumbing command which doesn't honor diff.algorithm).
    
    If the general idea of this patch is judged worthwhile, I would be happy
    to add tests to demonstrate the impact of the diff algorithm on blame
    output.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2075%2Fwetneb%2Fblame_respects_diff_algorithm-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2075/wetneb/blame_respects_diff_algorithm-v1
Pull-Request: https://github.com/git/git/pull/2075

 Documentation/git-blame.adoc | 21 ++++++++++++++++++++
 builtin/blame.c              | 38 +++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index e438d28625..4beb2df551 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -85,6 +85,27 @@ include::blame-options.adoc[]
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
+`--diff-algorithm=(patience|minimal|histogram|myers)`::
+	Choose a diff algorithm. The variants are as follows:
++
+--
+   `default`;;
+   `myers`;;
+	The basic greedy diff algorithm. Currently, this is the default.
+   `minimal`;;
+	Spend extra time to make sure the smallest possible diff is
+	produced.
+   `patience`;;
+	Use "patience diff" algorithm when generating patches.
+   `histogram`;;
+	This algorithm extends the patience algorithm to "support
+	low-occurrence common elements".
+--
++
+For instance, if you configured the `diff.algorithm` variable to a
+non-default value and want to use the default one, then you
+have to use `--diff-algorithm=default` option.
+
 --abbrev=<n>::
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <m>+1 digits, where <m> is at
diff --git a/builtin/blame.c b/builtin/blame.c
index 2703820258..177b606e81 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
 		}
 	}
 
+	if (!strcmp(var, "diff.algorithm")) {
+		long diff_algorithm;
+		if (!value)
+			return config_error_nonbool(var);
+		diff_algorithm = parse_algorithm_value(value);
+		if (diff_algorithm < 0)
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
+		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		xdl_opts |= diff_algorithm;
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 	if (userdiff_config(var, value) < 0)
@@ -824,6 +837,26 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+static int blame_diff_algorithm_callback(const struct option *option,
+					 const char *arg, int unset)
+{
+	int *opt = option->value;
+	long value = parse_algorithm_value(arg);
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (value < 0)
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	// ignore any previous --minimal setting, following git-diff's behavior
+	*opt &= ~XDF_NEED_MINIMAL;
+	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
+	*opt |= value;
+
+	return 0;
+}
+
 static int is_a_rev(const char *name)
 {
 	struct object_id oid;
@@ -908,13 +941,16 @@ int cmd_blame(int argc,
 		OPT_BIT('f', "show-name", &output_option, N_("show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
 		OPT_BIT('p', "porcelain", &output_option, N_("show in a format designed for machine consumption"), OUTPUT_PORCELAIN),
-		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
+		OPT_BIT(0, "line-porcelain", &output_option, N_("show porcelain format with per-line commit information"), OUTPUT_PORCELAIN | OUTPUT_LINE_PORCELAIN),
 		OPT_BIT('c', NULL, &output_option, N_("use the same output mode as git-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
 		OPT_BIT('t', NULL, &output_option, N_("show raw timestamp (Default: off)"), OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, N_("show long commit SHA1 (Default: off)"), OUTPUT_LONG_OBJECT_NAME),
 		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
+			       N_("choose a diff algorithm"),
+			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
 		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
 		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
 		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
