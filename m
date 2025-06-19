Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076928DB4A
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373884; cv=none; b=XXBb42SYtEzBnlbPv2uWrKGer/qQPzivAuJ7gX9oyLID8nEN4tCb1Y0AIVoQOQku7YQZSqG9hVpeXLjgKZcCKqhV/SojUxAbLZQrgstB8TSKhpTN60Rjm0kT7B4PBM9vmDgqetaLnpBnp0ET2TflxalSf/oYJ9gK3ibJNT7eg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373884; c=relaxed/simple;
	bh=Sq1xtWbbQkHXEk/o/+EhzFU2YFA8LK9TQoL8RxtHcHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoD/pUlzCvRB0HUB7+fVCFzEyYqwRyFtN1aH23JHPruZ4junHLVmXmKkiTpSqsvsjmQDH4tGEZqmwNuXWSH7ctjvtciojDtt5e6cg75nHq4p5PjJES3ds0pZwdqcv2vdZTJzXHe0lSGxfySFh7qCkVUBdxvbJfcI7eas5lHhmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk/ahjAP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk/ahjAP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ea292956so13008235ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373881; x=1750978681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7xHTKwtR/yCOqzJmyMDLSCEwdfQS54mFMKU170eZe8=;
        b=Wk/ahjAPhWiPPbx+HOsxRCrlt6tEU3IW604NAEha28TUKP6wwPZpHWwNgrGfs276l+
         17dcbVEOaUshMIeDKim7nnqB1uozaVbRLsA86SCkWcRmsndEH9V9XpUyWKta5KJsNmdL
         RrtVLCH1HBlaDQ16byaREvO6p1KieciLGksLkytHglKyFjMAfeSmv7SDB5kU+yGYf/6O
         hEpI2gXbyxsoFg/OjgOdhfgrgq+Ds4iCpfM2ZQjhT2MBUjzj8lVXtkF9AfDLM9NBMI/D
         nkbEL3H4fsEeA3VqWVdu9zCjKIa4+xSAgwJ/H/BzJscZDHNjOrKQcwszBWTTEL+PQEWG
         chHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373881; x=1750978681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7xHTKwtR/yCOqzJmyMDLSCEwdfQS54mFMKU170eZe8=;
        b=RKef7pnOO7KY1QVMWdFmrbQ3YQkSsidYj5ad2j5LPBh6YWYz8RS0HHJjC7alJVWp97
         KvgnJvSt5/vNjQNbF4w7pgcWVd3DVQ5WhdM/6dO0dua7bl2lC9nX69AJAE+EP78pqk1N
         Pyh7NyD92xdYbPbCEU0GsGohMDyYHo+1aUQ6hsv1hLfHS8RkDxMANgWAI0AfpjAqiMZ3
         ogJ1ytd+bpVnsqcPpiuEAC3LkbtrLETEEYXF4q9S2pBhOO0LkKX/GuQHH9xNaTsI7a07
         EIz6YeXicqDGDeUMLFHMp/Gkn+GZ/C5vdbwu2s7pfomeMxs5MZQ31yqsBR6Y5zl5Mnqw
         gJIQ==
X-Gm-Message-State: AOJu0YxKBx1oxlB/sV+lZh4mfFBNubzgssxmRN47C66nAiRRnhb6Fbjl
	80NYy1bcy3vEcjvr/xnbQMeHT5JOcQi8xlxP/SkOEeUim1XwpHMzjnQfrWvajg==
X-Gm-Gg: ASbGncsmSvufAzO3uVWOTO2EprNiDaPxDVS19MJcBhIUMOIEMHM7g/HFE07hBv3AUrl
	EFhZoPC1YPrdLXoBYGi3qJ2slyiZG91/45Q57Kzp1MX+W54NCFlqPcLoLSMn+XKvz+Oe/e6pwhO
	UX1Eed+36kHuPfxkhYSxaw/9zSSHi02LEtWzLwsZIi8qH8E5C5WMFsLE8bUT0OXkcKIJAFSIw9+
	dwDHfmgP/gImQFH4I4mvP2mzZfu2NMbUfkAmHAmV1MjkfPj2YzkmQESuxrxBENVYZ+DZqDOIfZs
	B19fsQXfRQ38TQ+N+GtOCG4VwQPZU8uq71LqPqqNVQg6nk+vWmQpU2bk8LXLl2+PqmXJaoyu1zD
	mbSq9KZZtad0MFlE5PQ==
X-Google-Smtp-Source: AGHT+IGCUPEAbsHO+wi/81zAKGk0r4rhNoEIKE7iTvtjFrKEKO2iCiX8hkXFu5oUHPHbh3/6P78g5w==
X-Received: by 2002:a17:903:2306:b0:234:d7b2:2ac4 with SMTP id d9443c01a7336-237d980da56mr8989205ad.17.1750373881185;
        Thu, 19 Jun 2025 15:58:01 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.57.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:00 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving repository info
Date: Thu, 19 Jun 2025 19:57:44 -0300
Message-Id: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is the second version of the repo-info RFC, and these are the main changes
introduced since v1:

- The plaintext format now returns its fields in a key=value format

- The tests were renumbered to t1900, since it's a new command (the previous was
  t1518, following the numbering of rev-parse)

- The test function 'test_repo_info' now has a docstring, and it is more flexible
  for using more complex repository initializations

- The flag --allow-empty is now introduced in its own commit

- The plaintext and the JSON formats are now introduced in their own commits

- The JSON format tests, which depends on the Perl's JSON module, are now marked
  with the PERLJSON lazy prereq, being skipped in environments that don't have
  that module installed

Some things pointed in the last review weren't implemented as I prefer to do
them in another iteration of repo-info after having its basic functionality
working:

- Remove the dependency on 'the_repository' when calling 'is_bare_repository'

- Add a --batch-command mode, based on the --bath-command flag of cat-file,
  introduced in 440c705ea6 (cat-file: add --batch-command mode, 2022-02-18)

- Use the category as key instead of only accepting category.key. In the current
  patchset, `git repo-info layout` would equivalent to
  `git repo-info layout.bare layout.shallow`

I'm cc'ing my mentors and everyone that answered me in v1 and my GSoC blog. I'm
still open to any suggestions, requests and questions that you may have!

Here's the range-diff of this v2:

1:  20a3d131c3 ! 1:  102b5ce90a repo-info: declare the repo-info command
    @@ Commit message
         - git.c
         - .gitignore

    +    In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
    +    specify after the flags the information that they want to retrieve.
    +
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Mentored-by Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ builtin/repo-info.c (new)
     +#include "builtin.h"
     +#include "parse-options.h"
     +
    -+int cmd_repo_info(
    -+	int argc,
    -+	const char **argv,
    -+	const char *prefix,
    -+	struct repository *repo UNUSED
    -+	)
    ++int cmd_repo_info(int argc,
    ++		  const char **argv,
    ++		  const char *prefix,
    ++		  struct repository *repo UNUSED)
     +{
     +	const char *const repo_info_usage[] = {
     +		"git repo-info",
    @@ builtin/repo-info.c (new)
     +		OPT_END()
     +	};
     +
    -+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
    ++	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
    ++			     PARSE_OPT_KEEP_UNKNOWN_OPT);
     +
     +	return 0;
     +}
2:  f78058c25a < -:  ---------- repo-info: add the --format flag
3:  3b2f534a69 < -:  ---------- repo-info: add the field references.format
-:  ---------- > 2:  1cc1184663 repo-info: add the --format flag
-:  ---------- > 3:  a329825387 repo-info: add plaintext as an output format
-:  ---------- > 4:  3b6c27b68d repo-info: add the --allow-empty flag
-:  ---------- > 5:  441b010175 repo-info: add the field references.format
4:  5ad7e79f83 ! 6:  f39086ea86 repo-info: add field layout.bare
    @@ builtin/repo-info.c
     +
      #include "builtin.h"
     +#include "environment.h"
    - #include "hash.h"
    ++#include "hash.h"
      #include "json-writer.h"
      #include "parse-options.h"
    +-#include "refs.h"
    + #include "quote.h"
    ++#include "refs.h"
    +
    + enum output_format {
    + 	FORMAT_JSON,
     @@ builtin/repo-info.c: enum output_format {
      };

      enum repo_info_category {
    --	CATEGORY_REFERENCES = 1
    -+	CATEGORY_REFERENCES = 1,
    +-	CATEGORY_REFERENCES = 1 << 0
    ++	CATEGORY_REFERENCES = 1 << 0,
     +	CATEGORY_LAYOUT = 1 << 1
      };

      enum repo_info_references_field {
    - 	FIELD_REFERENCES_FORMAT = 1
    + 	FIELD_REFERENCES_FORMAT = 1 << 0
      };

    -+enum repo_info_layout_field { FIELD_LAYOUT_BARE = 1
    ++enum repo_info_layout_field {
    ++	FIELD_LAYOUT_BARE = 1 << 0
     +};
     +
      struct repo_info_field {
    @@ builtin/repo-info.c: enum output_format {
      	} field;
      };

    -@@ builtin/repo-info.c: struct repo_info {
    -
    - const char *default_fields[] = {
    - 	"references.format",
    -+	"layout.bare"
    +@@ builtin/repo-info.c: static struct repo_info_field default_fields[] = {
    + 	{
    + 		.category = CATEGORY_REFERENCES,
    + 		.field.references = FIELD_REFERENCES_FORMAT
    ++	},
    ++	{
    ++		.category = CATEGORY_LAYOUT,
    ++		.field.layout = FIELD_LAYOUT_BARE
    + 	}
      };

    - static void repo_info_init(struct repo_info *repo_info,
     @@ builtin/repo-info.c: static void repo_info_init(struct repo_info *repo_info,
    - 			field->category = CATEGORY_REFERENCES;
    - 			field->field.references = FIELD_REFERENCES_FORMAT;
    - 		}
    -+		else if (!strcmp(arg, "layout.bare")) {
    -+			field->category = CATEGORY_LAYOUT;
    -+			field->field.layout = FIELD_LAYOUT_BARE;
    -+		}
    - 		else {
    - 			die("invalid field '%s'", arg);
    - 		}
    + 			if (!strcmp(arg, "references.format")) {
    + 				field->category = CATEGORY_REFERENCES;
    + 				field->field.references = FIELD_REFERENCES_FORMAT;
    ++			} else if (!strcmp(arg, "layout.bare")) {
    ++				field->category = CATEGORY_LAYOUT;
    ++				field->field.layout = FIELD_LAYOUT_BARE;
    + 			} else {
    + 				die("invalid field '%s'", arg);
    + 			}
     @@ builtin/repo-info.c: static void repo_info_print_plaintext(struct repo_info *repo_info) {
      				break;
      			}
    @@ builtin/repo-info.c: static void repo_info_print_plaintext(struct repo_info *rep
     +		case CATEGORY_LAYOUT:
     +			switch (field->field.layout) {
     +			case FIELD_LAYOUT_BARE:
    -+				puts(is_bare_repository() ? "true" : "false");
    ++				print_key_value("layout.bare",
    ++						is_bare_repository() ?
    ++							"true" : "false");
     +				break;
     +			}
     +			break;
    @@ builtin/repo-info.c: static void repo_info_print_json(struct repo_info *repo_inf

      	puts(jw.json.buf);

    - ## t/t1518-repo-info.sh ##
    -@@ t/t1518-repo-info.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + ## t/t1900-repo-info.sh ##
    +@@ t/t1900-repo-info.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

      . ./test-lib.sh

    @@ t/t1518-repo-info.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

      parse_json () {
      	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
    -@@ t/t1518-repo-info.sh: test_repo_info () {
    - 		test_when_finished 'rm -rf repo' &&
    - 		git init $init_args repo &&
    - 		cd repo &&
    --		echo '$expected_value' >expect &&
    -+		echo '$expected_value' | sed 's/^false$/0/' | sed 's/^true$/1/' >expect &&
    - 		git repo-info '$key'| parse_json >output &&
    - 		grep -F 'row[0].$key' output | cut -d ' ' -f 2 >actual &&
    - 		test_cmp expect actual
    -@@ t/t1518-repo-info.sh: test_repo_info 'ref format reftable is retrieved correctly' \
    - 	'--ref-format=reftable' \
    - 	'references.format' 'reftable'
    +@@ t/t1900-repo-info.sh: test_repo_info 'ref format files is retrieved correctly' '
    + test_repo_info 'ref format reftable is retrieved correctly' '
    + 	git init --ref-format=reftable repo' 'references.format' 'reftable'

    -+test_repo_info 'bare repository = false is retrieved correctly' \
    -+	'' \
    -+	'layout.bare' 'false'
    ++test_repo_info 'bare repository = false is retrieved correctly' '
    ++	git init repo' 'layout.bare' 'false'
     +
    -+test_repo_info 'bare repository = true is retrieved correctly' \
    -+	'--bare' \
    -+	'layout.bare' 'true'
    ++test_repo_info 'bare repository = true is retrieved correctly' '
    ++	git init --bare repo' 'layout.bare' 'true'
     +
      test_expect_success 'plaintext: output all default fields' "
      	git repo-info --format=plaintext >actual &&
5:  0295c19951 < -:  ---------- repo-info: add field layout.shallow
-:  ---------- > 7:  219b84f032 repo-info: add field layout.shallow

Lucas Seiki Oshiro (7):
  repo-info: declare the repo-info command
  repo-info: add the --format flag
  repo-info: add plaintext as an output format
  repo-info: add the --allow-empty flag
  repo-info: add the field references.format
  repo-info: add field layout.bare
  repo-info: add field layout.shallow

 .gitignore           |   1 +
 Makefile             |   1 +
 builtin.h            |   1 +
 builtin/repo-info.c  | 244 +++++++++++++++++++++++++++++++++++++++++++
 git.c                |   1 +
 meson.build          |   1 +
 t/meson.build        |   1 +
 t/t1900-repo-info.sh | 105 +++++++++++++++++++
 8 files changed, 355 insertions(+)
 create mode 100644 builtin/repo-info.c
 create mode 100755 t/t1900-repo-info.sh

-- 
2.39.5 (Apple Git-154)

