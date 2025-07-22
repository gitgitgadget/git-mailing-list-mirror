Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B13596A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144154; cv=none; b=Q2emv1fRg0uBRSyWRXhJuOotiOZx3Ik44ugTHo1EpKW4lUvQPj1Nb/lbUaht0AeIyhgtXSiYYwhst+N6U+htltNJRsHcUCNIq2u8NpEX8gOkgRhGMykcDyGItA+5CoF/AawFgktz4FFrp6ZP+fOMR3yb9GnSIVW/yHxLGvEOrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144154; c=relaxed/simple;
	bh=jhDF2vQX5hskYt90ix4aqDWxbd/XPJl2uU8Zu6q0IDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHZVfNEZLy+dUcoghhjWn93RM1GMBXZ71mtEXVf1UpvbKLD9d7qWeLhLP7soYcr9pPD0rtwREzVAproOYTRi8wywqGRZkTTQcUyzfIBOybgWkrtt3Rzb2tWrUNDv9WAVvcXQXafR4j/wVacbytNqKKmXu+3rMgmJylYJV8CtVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9VEE/ZN; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9VEE/ZN"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f234ba1abso3096726241.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144151; x=1753748951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y75G3hf7DXKq1K/XOMaUCSjJpuKDeXh9OUjc4l29Fyc=;
        b=e9VEE/ZNhB48MWrXn9Vss5MJFXBC24veL+u9qh9y4+CiAXV9RlWawkygsJKkrJf3Dd
         Vk0GnQiJpJTSe//O/d5uGEujYwsNFr4FTSOpAf3o3PrUn0C+vdKTGA3Bjmfz97h836xi
         Mdl2lcOy9+/lbJf2/k4sKKIiwjtVrrNNN0LC8iDzCrNXNux5w5ZRPzCn8c59eMoozwbn
         86psejEnZMDc50B1CdwKU9fovpC/oaBChXYAo50Xcr4ojiHYAunsE5khvc+EwTxe7MJf
         22i3w4b+ss+Xil46cy6VIaGTJobHdDKBvGXoxkwLVpv/R5I86wkyLAF4y3hYHV5Y4nsF
         INIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144151; x=1753748951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y75G3hf7DXKq1K/XOMaUCSjJpuKDeXh9OUjc4l29Fyc=;
        b=ccmWGKxFB7b9eWWQlxvM2t/09PiqNxmTLN5mQk0vqixv2iP4lvv1DRPKOqfUpFDPPr
         UD4M9lT5ESzE60HCvGvKGc132KFGf5LGgS3xgx7ibKqzKAzv/FPFbH5v8WOXteZRHsxe
         eZVfeNbTu0SfVMttgB+8xawbxMZ1aoCCkM7NNAtt0VdmEcJz5fyp7iPMtBdnbC8JP/wR
         ijKs+DOxjky9aVdBjHc7j2gooQurWE7jHAEc4XI9zsnhsfov95u5WtTIm/cUfV1k/sW2
         j4xEugehDlGww4EQwl+jrlWeDpYFoGc8PvJ2OagAYcaSa8+f4HFkgUxy8xMZQOqp/muE
         seyg==
X-Gm-Message-State: AOJu0YwXizp1U+L2gExAR3SM2hb1cSgrCqpCyR1PoD2ElVRyTtY2clfR
	hE5bWsF/pimerOBetJ/5hA8sWW3Pm9DnARMYa1opK4NPfs3EftiTQls/zErbBw==
X-Gm-Gg: ASbGncs2YeJWrorvbeIhBXdE8S6hM/j9FrEUwdeQXQnqFnVxU7aPI/ja2yIFpfzJexG
	crtatgzAnQRX5EHA1ZAFAg7Iu8kiOCv47xBzDDTOsCVW/dhMMU16gz9ZtqNxFhbdRbBOo+yQ+PD
	ZpDeZrYcEDaN9rz6IZuN9IpwD09hoCQ6MSFdTD0LeTlBLaDbi/JDpQTLxOI8ncFYnkCzDTZ8C8F
	LzxeMKLLCst+nI3VC1ZcOcWYfxB3m941IXrxQCT8LJ1RFlwsgw0Jz0Qis/eV58puOUtQ0BXrMLh
	rO4/6yyadYNVsSVBOQu4dXK7Mzlu9nnge8me6vZnowwsR62kYWlUpX2ruMnlj7mGcoSMJ/6IC5g
	1OmOWGeZEMuD5bS1uBWnqqLZr8CSAbgSAd38vrzCEaRo+zfmWKoKJEB4=
X-Google-Smtp-Source: AGHT+IFLtbYn1++Jna4PSOk5ZAwEsfSZOEhvqnoHk7lVOpXglga6PPyXyZgzF7Vx/C5F4eKE2uBdyw==
X-Received: by 2002:a05:6102:3f01:b0:4e9:bae0:7f9a with SMTP id ada2fe7eead31-4f95f3ccfcfmr12259744137.12.1753144150921;
        Mon, 21 Jul 2025 17:29:10 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:10 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 0/5] repo: add new command for retrieving repository info
Date: Mon, 21 Jul 2025 21:28:30 -0300
Message-Id: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
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

This fifth version addresses the issues from v4.

The major changes are:

- A new output format was added: key=value<LF>. This is the default format.

- The values are printed right after their retrieval, this way, I dropped the
  use of strbuf.

- The callbacks now return strings instead of filling the strbuf.

Things that didn't change:

- After the previous discussions (and the internal discussion with my mentors),
  I'll still keep the name `git repo`.

Future work:

- The current callback format works for the current values, but won't work for
  other fields that may require dynamically allocated strings (e.g. numbers and
  paths). I'm thinking about changing the callbacks to return strbufs instead
  of strings, but I'm open for suggestions.

- Add `-z` and/or `--null` as alias for `--format=null`.

Here's the rangediff from v4 to v5:

1:  c5f08d4342 ! 1:  396cfc256a repo: declare the repo command
    @@ Commit message
         repo: declare the repo command

         Currently, `git rev-parse` covers a wide range of functionality not
    -    directly related to parsing revisions, as its name says. Over time,
    +    directly related to parsing revisions, as its name suggests. Over time,
         many features like parsing datestrings, options, paths, and others
    -    were added to it because there wasn't a more appropriated command
    +    were added to it because there wasn't a more appropriate command
         to place them.

         Create a new Git command called `repo`. `git repo` will be the main
    @@ Commit message
         will bring the functionality of retrieving repository-related
         information currently returned by `rev-parse`.

    -    Also add entries for this new command in:
    -
    -    - the build files (Makefile, meson.build, Documentation/meson.build)
    -    - builtin.h
    -    - git.c
    -    - .gitignore
    -    - command-list.txt
    -    - Documentation
    +    Add the required tests, documentation and build changes to enable
    +    usage of this subcommand.

         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    @@ Documentation/git-repo.adoc (new)
     +
     +DESCRIPTION
     +-----------
    -+Retrieve information about the current repository in a machine-readable format.
    -+
    -+`git repo` will be the primary tool to query repository-specific information,
    -+such as metadata that currently can also be done by calling `git rev-parse` (see
    -+linkgit:git-rev-parse[1]). `git repo` doesn't query information unrelated to the
    -+current repository or that is already retrieved by a specialized command, for
    -+example, `git config` (see linkgit:git-config[1]) or `git var` (see
    -+linkgit:git-var[1]).
    ++This command retrieve repository level information.
     +
    -+This command returns the retrieved data following a null-terminated format with
    -+this syntax:
    -++
    -+----------------
    -+key1<LF>value1<NUL>
    -+key2<LF>value2<NUL>
    -+...
    -+----------------
    -++
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
     +COMMANDS
    @@ builtin/repo.c (new)
     +#include "builtin.h"
     +#include "parse-options.h"
     +
    -+static int repo_info(int argc UNUSED,
    -+		     const char **argv UNUSED,
    -+		     const char *prefix UNUSED,
    -+		     struct repository *repo UNUSED)
    ++static int repo_info(int argc UNUSED, const char **argv UNUSED,
    ++		     const char *prefix UNUSED, struct repository *repo UNUSED)
     +{
     +	return 0;
     +}
     +
    -+int cmd_repo(int argc,
    -+	     const char **argv,
    -+	     const char *prefix,
    ++int cmd_repo(int argc, const char **argv, const char *prefix,
     +	     struct repository *repo)
     +{
     +	parse_opt_subcommand_fn *fn = NULL;
     +	const char *const repo_usage[] = {
    -+		"git repo info",
    ++		"git repo info [<key>...]",
     +		NULL
     +	};
     +	struct option options[] = {
    @@ builtin/repo.c (new)
     +
     +	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
     +
    -+	if (fn) {
    -+		return fn(argc, argv, prefix, repo);
    -+	} else {
    -+		if (argc) {
    -+			error(_("unknown subcommand: `%s'"), argv[0]);
    -+			usage_with_options(repo_usage, options);
    -+		}
    -+		return 1;
    -+	}
    ++	return fn(argc, argv, prefix, repo);
     +}

      ## command-list.txt ##
2:  60494d5a17 ! 2:  28f4c21a96 repo: add the field references.format
    @@ Metadata
      ## Commit message ##
         repo: add the field references.format

    -    This commit is part of the series that introduce the new subcommand
    +    This commit is part of the series that introduces the new subcommand
         git-repo-info.

         The flag `--show-ref-format` from git-rev-parse is used for retrieving
    @@ Documentation/git-repo.adoc: INFO KEYS

     +`references`::
     +Reference-related data:
    -+* `format`: the reference storage format, either `files` or `reftable`.
    ++* `format`: the reference storage format
     +
      SEE ALSO
      --------
    @@ builtin/repo.c
     @@
      #include "builtin.h"
      #include "parse-options.h"
    -+#include "strbuf.h"
     +#include "refs.h"

    --static int repo_info(int argc UNUSED,
    --		     const char **argv UNUSED,
    -+typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
    +-static int repo_info(int argc UNUSED, const char **argv UNUSED,
    +-		     const char *prefix UNUSED, struct repository *repo UNUSED)
    ++typedef const char *get_value_fn(struct repository *repo);
     +
     +struct field {
     +	const char *key;
    -+	add_field_fn *add_field_callback;
    ++	get_value_fn *add_field_callback;
     +};
     +
    -+static void add_string(struct strbuf *buf,
    -+		       const char *key, const char *value)
    ++static const char *get_references_format(struct repository *repo)
     +{
    -+	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
    ++	return ref_storage_format_to_name(repo->ref_storage_format);
     +}
     +
    -+static void add_references_format(struct strbuf *buf,
    -+				  struct repository *repo)
    -+{
    -+	add_string(buf, "references.format",
    -+		   ref_storage_format_to_name(repo->ref_storage_format));
    -+}
    -+
    -+// repo_info_fields keys should be in lexicographical order
    ++/* repo_info_fields keys should be in lexicographical order */
     +static const struct field repo_info_fields[] = {
    -+	{"references.format", add_references_format},
    ++	{ "references.format", get_references_format },
     +};
     +
     +static int repo_info_fields_cmp(const void *va, const void *vb)
    @@ builtin/repo.c
     +	return strcmp(a->key, b->key);
     +}
     +
    -+static add_field_fn *get_append_callback(const char *key) {
    -+	const struct field search_key = {key, NULL};
    ++static get_value_fn *get_value_callback(const char *key)
    + {
    ++	const struct field search_key = { key, NULL };
     +	const struct field *found = bsearch(&search_key, repo_info_fields,
     +					    ARRAY_SIZE(repo_info_fields),
     +					    sizeof(struct field),
    @@ builtin/repo.c
     +	return strcmp(a, b);
     +}
     +
    -+static void print_fields(int argc, const char **argv, struct repository *repo) {
    ++static int print_fields(int argc, const char **argv, struct repository *repo)
    ++{
     +	const char *last = "";
    -+	struct strbuf buf;
    -+	strbuf_init(&buf, 256);
     +
     +	QSORT(argv, argc, qsort_strcmp);
     +
     +	for (int i = 0; i < argc; i++) {
    -+		add_field_fn *callback;
    ++		get_value_fn *callback;
     +		const char *key = argv[i];
    ++		const char *value;
     +
     +		if (!strcmp(key, last))
     +			continue;
     +
    -+		callback = get_append_callback(key);
    ++		callback = get_value_callback(key);
     +
    -+		if (!callback) {
    -+			error("key %s not found", key);
    -+			strbuf_release(&buf);
    -+			exit(1);
    -+		}
    ++		if (!callback)
    ++			return error("key %s not found", key);
     +
    -+		callback(&buf, repo);
    ++		value = callback(repo);
    ++		printf("%s=%s\n", key, value);
     +		last = key;
     +	}
     +
    -+	fwrite(buf.buf, 1, buf.len, stdout);
    -+	strbuf_release(&buf);
    -+}
    -+
    -+static int repo_info(int argc,
    -+		     const char **argv,
    - 		     const char *prefix UNUSED,
    --		     struct repository *repo UNUSED)
    -+		     struct repository *repo)
    - {
    -+
    -+	print_fields(argc - 1 , argv + 1, repo);
      	return 0;
      }

    -@@ builtin/repo.c: int cmd_repo(int argc,
    ++static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
    ++		     struct repository *repo)
    ++{
    ++	return print_fields(argc - 1, argv + 1, repo);
    ++}
    ++
    + int cmd_repo(int argc, const char **argv, const char *prefix,
    + 	     struct repository *repo)
      {
    - 	parse_opt_subcommand_fn *fn = NULL;
    - 	const char *const repo_usage[] = {
    --		"git repo info",
    -+		"git repo info [<key>...]",
    - 		NULL
    - 	};
    - 	struct option options[] = {

      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/t1900-repo.sh (new)
     +	test_expect_success "$label" '
     +		test_when_finished "rm -rf repo" &&
     +		eval "$init_command" &&
    -+		echo "$expected_value" | lf_to_nul >expected &&
    ++		echo "$expected_value" >expected &&
     +		git -C repo repo info "$key" >output &&
    -+		tail -n 1 output >actual &&
    ++		cut -d "=" -f 2 <output >actual &&
     +		test_cmp expected actual
     +	'
     +}
    @@ t/t1900-repo.sh (new)
     +	git init --ref-format=reftable repo' 'references.format' 'reftable'
     +
     +test_expect_success "only one value is returned if the same key is requested twice" '
    -+	echo "references.format" > expected &&
    -+	git rev-parse --show-ref-format > ref-format &&
    -+	lf_to_nul <ref-format >>expected &&
    -+	git repo info references.format references.format > actual &&
    -+	test_cmp expected actual
    ++	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    ++	echo "references.format" >expected_key &&
    ++	git rev-parse --show-ref-format >expected_value &&
    ++	git repo info references.format references.format >output &&
    ++	cut -d "=" -f 1 <output >actual_key &&
    ++	cut -d "=" -f 2 <output >actual_value &&
    ++        test_cmp expected_key actual_key &&
    ++        test_cmp expected_value actual_value
     +'
     +
     +test_done
3:  f0a318c3a7 ! 3:  b8001ae87e repo: add field layout.bare
    @@ Commit message
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: categories:
      Reference-related data:
    - * `format`: the reference storage format, either `files` or `reftable`.
    + * `format`: the reference storage format

     +`layout`::
     +Information about the how the current repository is represented:
    @@ builtin/repo.c
     +
      #include "builtin.h"
      #include "parse-options.h"
    - #include "strbuf.h"
      #include "refs.h"
     +#include "environment.h"

    - typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
    + typedef const char *get_value_fn(struct repository *repo);

    -@@ builtin/repo.c: static void add_string(struct strbuf *buf,
    - 	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
    - }
    +@@ builtin/repo.c: struct field {
    + 	get_value_fn *add_field_callback;
    + };

    -+static void add_bool(struct strbuf *buf,
    -+		     const char *key, const int value)
    ++static const char *get_layout_bare(struct repository *repo UNUSED)
     +{
    -+	const char *output_value = value ? "true" : "false";
    -+	strbuf_addf(buf, "%s\n%s%c", key, output_value, '\0');
    ++	return is_bare_repository() ? "true" : "false";
     +}
     +
    - static void add_references_format(struct strbuf *buf,
    - 				  struct repository *repo)
    + static const char *get_references_format(struct repository *repo)
      {
    -@@ builtin/repo.c: static void add_references_format(struct strbuf *buf,
    - 		   ref_storage_format_to_name(repo->ref_storage_format));
    - }
    + 	return ref_storage_format_to_name(repo->ref_storage_format);
    +@@ builtin/repo.c: static const char *get_references_format(struct repository *repo)

    -+
    -+static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
    -+{
    -+	add_bool(buf, "layout.bare", is_bare_repository());
    -+}
    -+
    - // repo_info_fields keys should be in lexicographical order
    + /* repo_info_fields keys should be in lexicographical order */
      static const struct field repo_info_fields[] = {
    -+	{"layout.bare", add_layout_bare},
    - 	{"references.format", add_references_format},
    ++	{ "layout.bare", get_layout_bare },
    + 	{ "references.format", get_references_format },
      };


    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
     +	git init --bare repo' 'layout.bare' 'true'
     +
      test_expect_success "only one value is returned if the same key is requested twice" '
    - 	echo "references.format" > expected &&
    - 	git rev-parse --show-ref-format > ref-format &&
    + 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    + 	echo "references.format" >expected_key &&
4:  220a3e6ca7 ! 4:  bceba54e8b repo: add field layout.shallow
    @@ Documentation/git-repo.adoc: Reference-related data:

      ## builtin/repo.c ##
     @@
    - #include "strbuf.h"
    + #include "parse-options.h"
      #include "refs.h"
      #include "environment.h"
     +#include "shallow.h"

    - typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
    + typedef const char *get_value_fn(struct repository *repo);

    -@@ builtin/repo.c: static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
    - 	add_bool(buf, "layout.bare", is_bare_repository());
    +@@ builtin/repo.c: static const char *get_layout_bare(struct repository *repo UNUSED)
    + 	return is_bare_repository() ? "true" : "false";
      }

    -+static void add_layout_shallow(struct strbuf *buf, struct repository *repo)
    ++static const char *get_layout_shallow(struct repository *repo)
     +{
    -+	add_bool(buf, "layout.shallow", is_repository_shallow(repo));
    ++	return is_repository_shallow(repo) ? "true" : "false";
     +}
     +
    - // repo_info_fields keys should be in lexicographical order
    + static const char *get_references_format(struct repository *repo)
    + {
    + 	return ref_storage_format_to_name(repo->ref_storage_format);
    +@@ builtin/repo.c: static const char *get_references_format(struct repository *repo)
    + /* repo_info_fields keys should be in lexicographical order */
      static const struct field repo_info_fields[] = {
    - 	{"layout.bare", add_layout_bare},
    -+	{"layout.shallow", add_layout_shallow},
    - 	{"references.format", add_references_format},
    + 	{ "layout.bare", get_layout_bare },
    ++	{ "layout.shallow", get_layout_shallow },
    + 	{ "references.format", get_references_format },
      };


    @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly'
     +	' 'layout.shallow' 'true'
     +
      test_expect_success "only one value is returned if the same key is requested twice" '
    - 	echo "references.format" > expected &&
    - 	git rev-parse --show-ref-format > ref-format &&
    + 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
    + 	echo "references.format" >expected_key &&
     @@ t/t1900-repo.sh: test_expect_success "only one value is returned if the same key is requested twi
    - 	test_cmp expected actual
    +         test_cmp expected_value actual_value
      '

     +test_expect_success 'output is returned correctly when two keys are requested' '
     +	test_when_finished "rm -f expect" &&
    -+	printf "layout.bare\nfalseQlayout.shallow\nfalseQ" >expect &&
    -+	git repo info layout.shallow layout.bare >output &&
    -+	nul_to_q <output >actual &&
    ++	printf "layout.bare=false\nlayout.shallow=false\n" >expect &&
    ++	git repo info layout.shallow layout.bare >actual &&
     +	test_cmp expect actual
     +'
     +
-:  ---------- > 5:  f4a2b0a04e repo: add the --format flag

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add field layout.bare
  repo: add field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  58 ++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 154 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             |  86 ++++++++++++++++++++
 11 files changed, 306 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

