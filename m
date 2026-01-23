Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D4283FC3
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186957; cv=none; b=WJrhlySiQx8Xrbm2rODg4eMjWFQ0eqa2yIIF/Yx9iX+b5n/iybVRnqWPK2j9pwxQ5P0oAq/rVKOXdf3nyWyYWk/3iffRp7uJ4hdd4KRpp2oljHq21kx0b6QSmykt+ItZdrMZca34TjEENCw63utEagI294G4RwaHNLKRbOzHkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186957; c=relaxed/simple;
	bh=/vOX4D0oGrCYsJXNgsP5QgYdgDNhKpjmbGdczUanOiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opRPZ5wymkkfS9qecDpztSMt/aizVNpwH1wjRpy5HKvgokBlBBtKuh57emxAOIIEFXwoj+NwsPUNX7Yuf9TXq1vx1j9swaoXO+4eJV3jSvzwcPAnNVfowxBMMk0UqZpO89o6QHeEJ2tkk8iBVO3EIc1vPC0VCcuiur8CIFX3Qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1d6q10Q; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1d6q10Q"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11f36012fb2so3854815c88.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769186955; x=1769791755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCoVdHE5Vt3pHN0IigEx2F+2rniqYkTridZis4vTAsA=;
        b=R1d6q10Qzt9byJRouGys8DGsN/UoE1N/FEDPrWwm/XdZvBBNZ0LbMEkDPpcU0qSxxN
         fMfVcVD5klexNVTgbryWw10YFQE/06JQWW6uHpa+7R1no/bI9VIkt5KaMoqDYcMp+FmO
         YbrhTzJ2QnlxEh1lOtGpUNqBqQYqP7LFSPj14qAx332KqZqoKbbcVybMrN5tA0xrus+E
         zIa0DurPfWOjrtBUNvqTz1AUriHK50hoPTfzScAY86AK+IdeK1JBI2ky8de+XMz+H4Kh
         USP9dTqPwqRq/jEY+nHqSRPx61P15Wpx5QagEXWIr7FD5pbKXo8KcVvsPOdeUNNJpN5T
         IMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186955; x=1769791755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCoVdHE5Vt3pHN0IigEx2F+2rniqYkTridZis4vTAsA=;
        b=ZIzZpC5ecTd3TE5AIAoccP4168jR2Y/uCX4H03Qtx+VQ07eA78AGCzCn3MUbONbAnd
         Q5zisnDAu+Fo8UZNwX3PRGk2MM6Xu3YAclRipA+yOvTkQs7T9SwhDMFR8ZPLijF8bG1o
         ioNzZdgrlaknoSYzMvwbkEv+Vi6XOFxLFNDl1dioChtYvGiBcyXj54qRJRDd4BPpm/OL
         IUU/Nd+sB8WUCwwr0P+5z+QVfh3bHtr7hXkQfGt1V9ZKrzh3am9MWGmY3LCpVTWAzAFv
         8iHZBGhlhxZclrCaWBQs/rSHGCS/LgrqSJKeNxBBp/35AYxSVCGf5kdQdxzwPTP2WyHX
         JXYA==
X-Gm-Message-State: AOJu0YwchLB3okWxnMEmYHrU5Z4d0C7E4xFaLRTI60yB1rMA0X1EwMDZ
	Sir4fSHXeAq59ebMjrWmeaCHsvTN04YUuAsP6P3oxN7S3Txh2m3WMAar4AR81g==
X-Gm-Gg: AZuq6aJEMUb0otfgck64TCLmaQmrK6MdzLNxqNAFmUcham9UD1Vs5bsTieLqnPPGnz7
	I6xUEUVxlb1EoOIIUuIxgc0O46d12JTQcFR1Rpx0Anj3RMBlAgwW4I+s+e/oeqj7LYt0dI907dI
	Cz6/PEZTEVzkiCTrz+g6Lcpc5BEiPvLmMRzq1O+89tA8OwpkXKsB99mRizNBLXR9gmE8a+IslJ6
	atD0b9AomjEAC2MuyotzJGE+JrvvJXPlfRTqipb1x8r4wvL+hKfcOz93SfKb+dG9th6YkeYH+0K
	zMmbnxisvBy37i7QLMISreJjSygHqI98mT0vvdcRU5ywyrbB+fkrHoNafIr5VPq9VVASUdGEde4
	jx0joRYcWReD7SyWt8HvOIHOowpklJfp5tB/IM8DQZB4UF14ZHTzpd5LXmNx2es0gsjxGZbxIi0
	ScVIhrEFtXpvMz9GOPyNxl29eoJRcv8aSlhkKa7OY1qnjdzYE=
X-Received: by 2002:a05:7022:4184:b0:11b:c1fb:89a with SMTP id a92af1059eb24-1247dbf817bmr1799338c88.32.1769186954422;
        Fri, 23 Jan 2026 08:49:14 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a3f22sm5522640c88.13.2026.01.23.08.49.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jan 2026 08:49:13 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 0/2] repo: add --keys and rename "keyvalue" to "lines"
Date: Fri, 23 Jan 2026 13:34:52 -0300
Message-ID: <20260123164900.35092-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

There are two main changes in this v5:

- the "keyvalue" output format of git-repo-info and git-repo-structure were
  both renamed by "lines"
- the "default" output format was dropped

This way:

- `git repo info` accepts --format=lines and --format=nul
- `git repo info --keys` accepts --format=lines and --format=nul
- `git repo structure` accepts --format=table, --format=lines and --format=nul

Lucas Seiki Oshiro (2):
  repo: rename "keyvalue" to "lines"
  repo: add new flag --keys to git-repo-info

 Documentation/git-repo.adoc | 32 +++++++++++++++--------
 builtin/repo.c              | 51 ++++++++++++++++++++++++++++++-------
 t/t1900-repo.sh             | 44 ++++++++++++++++++++++----------
 t/t1901-repo-structure.sh   |  4 +--
 4 files changed, 97 insertions(+), 34 deletions(-)

Range-diff against v4:
1:  7dabd62250 < -:  ---------- repo: add a default output format to enum output_format
-:  ---------- > 1:  f5448ce915 repo: rename "keyvalue" to "lines"
2:  fba621fc4f ! 2:  16bc72afe1 repo: add new flag --keys to git-repo-info
    @@ Documentation/git-repo.adoc
     @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
    - git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
    -+git repo info --keys [--format=(default|lines|nul) | -z]
    - git repo structure [--format=(default|table|keyvalue|nul) | -z]
    + git repo info [--format=(lines|nul) | -z] [--all | <key>...]
    ++git repo info --keys [--format=(lines|nul) | -z]
    + git repo structure [--format=(table|lines|nul) | -z]

      DESCRIPTION
     @@ Documentation/git-repo.adoc: supported:
      +
      `-z` is an alias for `--format=nul`.

    -+`info --keys [--format=(default|lines|nul) | -z]`::
    ++`info --keys [--format=(lines|nul) | -z]`::
     +	List all the available keys, one per line. The output format can be chosen
     +	through the flag `--format`. The following formats are supported:
     ++
    -+`default`:::
    -+	synonym for `lines`.
    -+
     +`lines`:::
    -+	output the keys one per line.
    ++	output the keys one per line. This is the default.
     +
     +`nul`:::
    -+	similar to `default`, but using a _NUL_ character after each value.
    ++	similar to `lines`, but using a _NUL_ character after each value.
     +
    - `structure [--format=(default|table|keyvalue|nul) | -z]`::
    + `structure [--format=(table|lines|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
      	following kinds of information are reported:

    @@ builtin/repo.c
     @@

      static const char *const repo_usage[] = {
    - 	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
    -+	"git repo info --keys [--format=(default|lines|nul) | -z]",
    - 	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
    + 	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
    ++	"git repo info --keys [--format=(lines|nul) | -z]",
    + 	"git repo structure [--format=(table|lines|nul) | -z]",
      	NULL
      };
    -@@ builtin/repo.c: enum output_format {
    - 	FORMAT_TABLE,
    - 	FORMAT_KEYVALUE,
    - 	FORMAT_NUL_TERMINATED,
    -+	FORMAT_LINES
    - };
    -
    - struct field {
     @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      	return 0;
      }
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
     +{
     +	char sep;
     +
    -+	if (format == FORMAT_DEFAULT)
    -+		format = FORMAT_LINES;
    -+
     +	switch (format) {
     +	case FORMAT_LINES:
     +		sep = '\n';
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
     +		sep = '\0';
     +		break;
     +	default:
    -+		die(_("--keys can only be used with --format=default or --format=nul"));
    ++		die(_("--keys can only be used with --format=lines or --format=nul"));
     +	}
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      static int parse_format_cb(const struct option *opt,
      			   const char *arg, int unset UNUSED)
      {
    -@@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
    - 		*format = FORMAT_KEYVALUE;
    - 	else if (!strcmp(arg, "table"))
    - 		*format = FORMAT_TABLE;
    -+	else if (!strcmp(arg, "lines"))
    -+		*format = FORMAT_LINES;
    - 	else if (!strcmp(arg, "default"))
    - 		*format = FORMAT_DEFAULT;
    - 	else
     @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
      {
    - 	enum output_format format = FORMAT_DEFAULT;
    + 	enum output_format format = FORMAT_LINES;
      	int all_keys = 0;
     +	int show_keys = 0;
      	struct option options[] = {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	if (show_keys)
     +		return print_keys(format);
     +
    - 	if (format == FORMAT_DEFAULT)
    - 		format = FORMAT_KEYVALUE;
    + 	if (format != FORMAT_LINES && format != FORMAT_NUL_TERMINATED)
    + 		die(_("unsupported output format"));


      ## t/t1900-repo.sh ##
    @@ t/t1900-repo.sh: test_expect_success 'git repo info uses the last requested form
      	git repo info --all >actual &&
      	test_cmp expect actual
      '
    -@@ t/t1900-repo.sh: test_expect_success '--format=default resets the format' '
    +@@ t/t1900-repo.sh: test_expect_success 'git repo info --all <key> aborts' '
      	test_cmp expect actual
      '

     +test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
    -+	git repo info --keys --format=default >default &&
    -+	lf_to_nul <default >expect &&
    ++	git repo info --keys --format=lines >lines &&
    ++	lf_to_nul <lines >expect &&
     +	git repo info --keys --format=nul >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'git repo info --keys aborts when using --format other than default or nul' '
    -+	echo "fatal: --keys can only be used with --format=default or --format=nul" >expect &&
    -+	test_must_fail git repo info --keys --format=keyvalue 2>actual &&
    ++test_expect_success 'git repo info --keys aborts when using --format other than lines or nul' '
    ++	echo "fatal: --keys can only be used with --format=lines or --format=nul" >expect &&
    ++	test_must_fail git repo info --keys --format=table 2>actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t1900-repo.sh: test_expect_success '--format=default resets the format' '
     +
     +test_expect_success 'git repo info --keys uses lines as its default output format' '
     +	git repo info --keys --format=lines >expect &&
    -+	git repo info --keys --format=default >actual_explicit &&
    -+	git repo info --keys >actual_implicit &&
    -+	test_cmp expect actual_explicit &&
    -+	test_cmp expect actual_implicit
    ++	git repo info --keys >actual &&
    ++	test_cmp expect actual
     +'
     +
      test_done
-- 
2.50.1 (Apple Git-155)

