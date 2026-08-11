Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177B418377
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437214; cv=none; b=DDhbFTCU2fPpeMV4PgYwpNCktIJFQ8F7t+JlYOVQIPS4jE97D66fFhMNm9yC6D2w/YtWv8zEY33452S5kYcQAOIzLMIG155yxWmZQVERZ78nihJv2+mMRuvtdeCeeO0wq3W2P+jmwJPaiQ2rjspQhmxt7d2IEPhCCQfKef5mQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437214; c=relaxed/simple;
	bh=Yfn+t+TYayor27A95fiU+WSWG3MeIaURZfe7iLGf3ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGW4iCuh0saGGcTuEzb2nIJ4PW9MVWlc5OT5Zp5X1DM/wRhNEv3aYXF1nmVm7ZPWFdol/Vcv9ymFKTdfZi6m75YUjZTWcNdgho/L0vpl0W6WlZu4npJHCNFulM6Vns/Ia4WGKqWPqAClZ63ApbUwtMz0v/EFjy30YtZ/yrHy+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biW4MgKW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biW4MgKW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso20539015e9.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437210; x=1787042010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcRlhjqRjBiCeRUivl9EzQNf5dvz/s6LsaHwOzvhN48=;
        b=biW4MgKWHIui36PfWgPonynkPF3/eSza6UgzWrBEEMXcErslMsMmtscGsOoWAxF+ZT
         OpTMh9TGpuQlPTOzaCE8IeZw+tBz3Dbokmjg0OYXOJnkw5UdEgVGAGE6mjZtAnVcwj44
         De9mf4UIQbxNZ07JjlzOe74WrIuB5mFFrQBth/KnY2LNcR09d1hIC/DfHSOXP2D2OVWh
         INmnX5EMpxG6IHbzi8uxHTU0tci8x0C2cxX+L6AT5lahjhSg825lcDf08+Y2TfffZ0Sn
         lXZ9HPT/RX9IY9jwWuttlB/S9fEFEZZoNPpiZV8NIaCT9PgQQFisbSq3i7XE2e4pfsLn
         oUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437210; x=1787042010;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcRlhjqRjBiCeRUivl9EzQNf5dvz/s6LsaHwOzvhN48=;
        b=aUdYGXcj5kwiBtTjMvyfNwleOZyYp3EYJBZIU5NRz/c7Ko8W/fh6FQxpiRCYC35THm
         QJiJYFyyO0qPLsaFrarXeNLo8Q1M/3OXt6vcRt40wywC7xkwxsnlNhSU/nv+wvwOOrNu
         4LOv20GnBXaAziEjocTV0JiEenmGjHctAD8EUOFgq2SzG93K6DDwGRbWKAiHmjICoLwK
         zK0ZgumWa3YHFu66wtH+X8Rya/NeOLmLyrOPOGxTCWdWjMf7C9K3vFP0JOp6+dfIN5Ap
         XBy1+IHOFNUCtF9U1i9DlfQw4TTThmOX0Cz2M41a1FX7qrFO3/ZHEifBMMJSWg2Yfsfe
         ORFg==
X-Gm-Message-State: AOJu0YzW1HcD7fWMqAf+vo1AxTqxaztFDg1J4Z+NOFrTe5ZX1DBKzCRH
	Us0UfKDsxCxnYytHfAh69Kb7b6ip3GOhWp5RBbgdAC/fXTbsd0XmoEFes5KrwQ==
X-Gm-Gg: AR+sD12z0t91/lYeEGuKxu40wrp4ic7RO8+k7tBL9dQ5uaU4AuOb945JyNbad8dcuxS
	pMlY9I1MKTC9XY46tv2P+O2uldij5xN5ggMXuk/TRGdoYXRcXDwL8nJzU3vVxK2w9+49juPAWpW
	aSZ/nDyHRMB1+qpigCIFBmiEFokgRSqhvcPrAExmG0TSmW89t1RnpOIRR0GFAP0DILHUzTGU+ln
	kX1NbZ3eXRmvgfnFXuVaq6jeybwbeJ9a5gUhcNP8mS2g/rSajjhHOFtdukMTXV0DiVmYZrSKvqa
	iDyrkMO06S911CkGaiWyEYIAQ0wK2IqLsZIlbD4dr4zJyaPOCBUb9uB/GOs91TSNKPNbSb0IB5L
	1KJOU5ThOwfsVq3uCQzBE24DWKIaiiBYIxK9fif6bRumEwUIv8QazPPeq4Nmk8Gi737zFK/8bVo
	3uEZfDaC+yD6tfyGqZJsyRinfhhlSTLwjWFzA5Dc80b+mG/5vBLGWYMD52ScpinHuHBYjwXP1gf
	vAN3sLkm9xsGrz9KYi2kewPGOXoP1ALOvFWDkfxatOfZV6aPWy4Z81kNFTApQOt67wQ81scsONt
	nEM=
X-Received: by 2002:a05:600c:3589:b0:499:5e9e:1f50 with SMTP id 5b1f17b1804b1-4997842aa62mr29565815e9.4.1786437208984;
        Tue, 11 Aug 2026 01:33:28 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:28 -0700 (PDT)
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
Subject: [PATCH v3 00/12] fast-import: standardize usage string and SYNOPSIS
Date: Tue, 11 Aug 2026 10:33:02 +0200
Message-ID: <20260811083314.2023489-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The goal of this series is to improve on `git fast-import`'s usage
string as it is obsolete in many ways.

As it appeared that a good way to reach that goal was to make
`git fast-import` use the parse-options API, this series also achieves
this secondary goal.

Along the way it modernizes "builtin/fast-import.c" mostly by using
`struct option`, by starting to remove global variables and libify
that command, and by introducing a new `OPT_HIDDEN_GROUP` macro.

There are still many global variables left, so it's left to future
work to finish on that direction.

Anyway the usage string is standardized and consistent with the
SYNOPSIS in the docs, so that the command can be removed from
"t/t0450/adoc-help-mismatches".

Using the parse-options API also enabled some code standardization and
simplification.

Overview of the patches
=======================

  - Patch 1/12: Introduces OPT_HIDDEN_GROUP and improves on the hidden
    option tests.

  - Patches 2/12 and 3/12: Improve on the parse-options API docs.

  - Patch 4/12: Cleans up an 'i' loop counter variable in
    cmd_fast_import().

  - Patches 5/12 and 6/12: Prepare for using the parse-option API to
    parse command line options.

  - Patches 7/12 and 8/12: Start libifying "builtin/fast-import.c" by
    introducing a 'struct fast_import_state' and using it to store
    some global variables.

  - Patch 9/12: Improves the usage string and SYNOPSIS by introducing
    `struct option`.

  - Patch 10/12: Further prepares for using the parse-option API to
    actually parse command line options by using OPT_CALLBACK.

  - Patch 11/12: Actually parses the command line options using the
    parse-option API.

  - Patch 12/12: Performs a cleanup of some functions arguments allowed
    by the previous commit.

Changes since v2
================

Thanks to Elijah for reviewing v2 and Junio for reviewing v1.

The series has been rebased on top of recent master at 010afd3166 (The
12th batch, 2026-08-07).

  - Patch 2/12 now describes `PARSE_OPT_LASTARG_DEFAULT` the way Elijah
    suggested, which matches what "parse-options.h" says, and mentions
    that it should not be combined with `PARSE_OPT_OPTARG`.

  - Patch 7/12 now wraps the function signatures that grew too long
    when they gained a 'struct fast_import_state *state' argument, with
    one parameter per line. Patches 8/12 and 12/12 have been adjusted
    accordingly, as they touch two of these signatures again.

  - Patch 11/12 now also lists two other behavior changes that Elijah
    spotted: value-taking options accept the space-separated
    `--opt value` form, and a bare or trailing `--` is now accepted.

  - Patch 11/12 also documents, both in a NEEDSWORK code comment and
    in "Documentation/git-fast-import.adoc", the third behavior change
    Elijah spotted about `--allow-unsafe-features`: as the early scan
    for that option only matches its exact spelling and stops at the
    first non-option argument, it disagrees with parse_options() for
    command lines like `--allow-unsafe` or
    `--depth 5 --allow-unsafe-features`. This errs on the safe side,
    as unsafe `feature` commands from the stream are refused in that
    case.

    I plan to work on a follow-up series that will improve on this by
    teaching the early scan about the options that take a value. It
    looks like the parse-options API could provide some helpers for
    this, which might benefit other commands like `git` itself (see
    handle_options() in "git.c") that need to look at some options
    before the actual option parsing.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/31469672131

Christian Couder (12):
  parse-options: introduce OPT_HIDDEN_GROUP
  api-parse-options.adoc: document per-option flags
  api-parse-options.adoc: document hidden and OPT_*_F option macros
  fast-import: localize 'i' into the 'for' loops using it
  fast-import: use int for some bool flags
  fast-import: factor out option_*() functions
  fast-import: introduce 'struct fast_import_state'
  fast-import: move command state globals into 'struct
    fast_import_state'
  fast-import: use struct option for usage string
  fast-import: use callbacks to parse some options
  fast-import: use parse_options() for command line options
  fast-import: remove useless from_stream argument

 Documentation/git-fast-import.adoc            |   9 +-
 .../technical/api-parse-options.adoc          |  80 +++
 builtin/fast-import.c                         | 617 ++++++++++++------
 parse-options.c                               |   4 +-
 parse-options.h                               |   5 +
 t/helper/test-parse-options.c                 |   4 +
 t/t0040-parse-options.sh                      |  25 +-
 t/t0450/adoc-help-mismatches                  |   1 -
 t/t9300-fast-import.sh                        |   7 +
 9 files changed, 564 insertions(+), 188 deletions(-)

Range-diff against v2:
 1:  b09d727e71 =  1:  06e37fe78b parse-options: introduce OPT_HIDDEN_GROUP
 2:  fe21471420 !  2:  184837437c api-parse-options.adoc: document per-option flags
    @@ Documentation/technical/api-parse-options.adoc: Data Structure
     +	deprecated, advanced or otherwise uncommon options.
     +
     +`PARSE_OPT_LASTARG_DEFAULT`::
    -+	Use the default value (`defval`) when the option is used
    -+	without an argument, even for an option that normally requires
    -+	one. Only the last argument on the command line takes effect.
    ++	The no-argument form is only accepted when the option is the
    ++	last token on the command line; used earlier, it still
    ++	requires an argument. Should not be combined with
    ++	`PARSE_OPT_OPTARG`.
     +
     +`PARSE_OPT_NODASH`::
     +	The option is a single character without a leading dash, such
 3:  f43d4cefa4 =  3:  3e3655c6d8 api-parse-options.adoc: document hidden and OPT_*_F option macros
 4:  3eb8106ed6 =  4:  bb0dc9b12e fast-import: localize 'i' into the 'for' loops using it
 5:  34514eb2ac =  5:  e653d2a43f fast-import: use int for some bool flags
 6:  336395c70a =  6:  2f809b3a01 fast-import: factor out option_*() functions
 7:  45cc2107e2 !  7:  3c913f0034 fast-import: introduce 'struct fast_import_state'
    @@ builtin/fast-import.c: static kh_oid_map_t *sub_oid_map;
     +static void parse_argv(struct fast_import_state *state);
     +static void parse_get_mark(struct fast_import_state *state, const char *p);
     +static void parse_cat_blob(struct fast_import_state *state, const char *p);
    -+static void parse_ls(struct fast_import_state *state, const char *p, struct branch *b);
    ++static void parse_ls(struct fast_import_state *state,
    ++		     const char *p,
    ++		     struct branch *b);
      
      static void for_each_mark(struct mark_set *m, uintmax_t base, each_mark_fn_t callback, void *p)
      {
    @@ builtin/fast-import.c: static void parse_path_space(struct strbuf *sb, const cha
      }
      
     -static void file_change_m(const char *p, struct branch *b)
    -+static void file_change_m(struct fast_import_state *state, const char *p, struct branch *b)
    ++static void file_change_m(struct fast_import_state *state,
    ++			  const char *p,
    ++			  struct branch *b)
      {
      	static struct strbuf path = STRBUF_INIT;
      	struct object_entry *oe;
    @@ builtin/fast-import.c: static void file_change_cr(const char *p, struct branch *
      }
      
     -static void note_change_n(const char *p, struct branch *b, unsigned char *old_fanout)
    -+static void note_change_n(struct fast_import_state *state, const char *p, struct branch *b, unsigned char *old_fanout)
    ++static void note_change_n(struct fast_import_state *state,
    ++			  const char *p,
    ++			  struct branch *b,
    ++			  unsigned char *old_fanout)
      {
      	struct object_entry *oe;
      	struct branch *s;
    @@ builtin/fast-import.c: static void parse_from_existing(struct branch *b)
      }
      
     -static int parse_objectish(struct branch *b, const char *objectish)
    -+static int parse_objectish(struct fast_import_state *state, struct branch *b, const char *objectish)
    ++static int parse_objectish(struct fast_import_state *state,
    ++			   struct branch *b,
    ++			   const char *objectish)
      {
      	struct branch *s;
      	struct object_id oid;
    @@ builtin/fast-import.c: static int parse_objectish(struct branch *b, const char *
      }
      
     -static int parse_objectish_with_prefix(struct branch *b, const char *prefix)
    -+static int parse_objectish_with_prefix(struct fast_import_state *state, struct branch *b, const char *prefix)
    ++static int parse_objectish_with_prefix(struct fast_import_state *state,
    ++				       struct branch *b,
    ++				       const char *prefix)
      {
      	const char *base;
      
    @@ builtin/fast-import.c: static int parse_objectish(struct branch *b, const char *
      }
      
     -static struct hash_list *parse_merge(unsigned int *count)
    -+static struct hash_list *parse_merge(struct fast_import_state *state, unsigned int *count)
    ++static struct hash_list *parse_merge(struct fast_import_state *state,
    ++				     unsigned int *count)
      {
      	struct hash_list *list = NULL, **tail = &list, *n;
      	const char *from;
    @@ builtin/fast-import.c: struct signature_data {
      };
      
     -static void parse_one_signature(struct signature_data *sig, const char *v)
    -+static void parse_one_signature(struct fast_import_state *state, struct signature_data *sig, const char *v)
    ++static void parse_one_signature(struct fast_import_state *state,
    ++				struct signature_data *sig,
    ++				const char *v)
      {
      	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
      	char *space = strchr(args, ' ');
    @@ builtin/fast-import.c: static void cat_blob(struct object_entry *oe, struct obje
      }
      
     -static void parse_get_mark(const char *p)
    -+static void parse_get_mark(struct fast_import_state *state UNUSED, const char *p)
    ++static void parse_get_mark(struct fast_import_state *state UNUSED,
    ++			   const char *p)
      {
      	struct object_entry *oe;
      	char output[GIT_MAX_HEXSZ + 2];
    @@ builtin/fast-import.c: static void parse_get_mark(const char *p)
      }
      
     -static void parse_cat_blob(const char *p)
    -+static void parse_cat_blob(struct fast_import_state *state UNUSED, const char *p)
    ++static void parse_cat_blob(struct fast_import_state *state UNUSED,
    ++			   const char *p)
      {
      	struct object_entry *oe;
      	struct object_id oid;
    @@ builtin/fast-import.c: static void print_ls(int mode, const unsigned char *hash,
      }
      
     -static void parse_ls(const char *p, struct branch *b)
    -+static void parse_ls(struct fast_import_state *state UNUSED, const char *p, struct branch *b)
    ++static void parse_ls(struct fast_import_state *state UNUSED,
    ++		     const char *p,
    ++		     struct branch *b)
      {
      	static struct strbuf path = STRBUF_INIT;
      	struct tree_entry *root = NULL;
    @@ builtin/fast-import.c: static void parse_progress(void)
      }
      
     -static char* make_fast_import_path(const char *path)
    -+static char* make_fast_import_path(struct fast_import_state *state, const char *path)
    ++static char* make_fast_import_path(struct fast_import_state *state,
    ++				   const char *path)
      {
      	if (!relative_marks_paths || is_absolute_path(path))
     -		return prefix_filename(global_prefix, path);
    @@ builtin/fast-import.c: static void parse_progress(void)
      }
      
     -static void option_import_marks(const char *marks,
    -+static void option_import_marks(struct fast_import_state *state, const char *marks,
    - 					int from_stream, int ignore_missing)
    +-					int from_stream, int ignore_missing)
    ++static void option_import_marks(struct fast_import_state *state,
    ++				const char *marks,
    ++				int from_stream,
    ++				int ignore_missing)
      {
      	if (import_marks_file) {
    + 		if (from_stream)
     @@ builtin/fast-import.c: static void option_import_marks(const char *marks,
      	}
      
    @@ builtin/fast-import.c: static void option_active_branches(const char *branches)
      }
      
     -static void option_export_marks(const char *marks)
    -+static void option_export_marks(struct fast_import_state *state, const char *marks)
    ++static void option_export_marks(struct fast_import_state *state,
    ++				const char *marks)
      {
      	free(export_marks_file);
     -	export_marks_file = make_fast_import_path(marks);
    @@ builtin/fast-import.c: static void option_active_branches(const char *branches)
      }
      
     -static void option_cat_blob_fd(const char *fd)
    -+static void option_cat_blob_fd(struct fast_import_state *state UNUSED, const char *fd)
    ++static void option_cat_blob_fd(struct fast_import_state *state UNUSED,
    ++			       const char *fd)
      {
      	unsigned long n = ulong_arg("--cat-blob-fd", fd);
      	if (n > (unsigned long) INT_MAX)
    @@ builtin/fast-import.c: static void option_cat_blob_fd(const char *fd)
      }
      
     -static void option_export_pack_edges(const char *edges)
    -+static void option_export_pack_edges(struct fast_import_state *state, const char *edges)
    ++static void option_export_pack_edges(struct fast_import_state *state,
    ++				     const char *edges)
      {
     -	char *fn = prefix_filename(global_prefix, edges);
     +	char *fn = prefix_filename(state->prefix, edges);
    @@ builtin/fast-import.c: static void option_cat_blob_fd(const char *fd)
      }
      
     -static void option_rewrite_submodules(const char *arg, struct string_list *list)
    -+static void option_rewrite_submodules(struct fast_import_state *state, const char *arg, struct string_list *list)
    ++static void option_rewrite_submodules(struct fast_import_state *state,
    ++				      const char *arg,
    ++				      struct string_list *list)
      {
      	struct mark_set *ms;
      	FILE *fp;
    @@ builtin/fast-import.c: static int parse_one_option(const char *option)
      }
      
     -static void check_unsafe_feature(const char *feature, int from_stream)
    -+static void check_unsafe_feature(struct fast_import_state *state UNUSED, const char *feature, int from_stream)
    ++static void check_unsafe_feature(struct fast_import_state *state UNUSED,
    ++				 const char *feature,
    ++				 int from_stream)
      {
      	if (from_stream && !allow_unsafe_features)
      		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
    @@ builtin/fast-import.c: static int parse_one_option(const char *option)
      }
      
     -static int parse_one_feature(const char *feature, int from_stream)
    -+static int parse_one_feature(struct fast_import_state *state, const char *feature, int from_stream)
    ++static int parse_one_feature(struct fast_import_state *state,
    ++			     const char *feature,
    ++			     int from_stream)
      {
      	const char *arg;
      
 8:  7f068facc2 !  8:  5d0b07148e fast-import: move command state globals into 'struct fast_import_state'
    @@ builtin/fast-import.c: static int parse_one_option(struct fast_import_state *sta
      	return 1;
      }
      
    --static void check_unsafe_feature(struct fast_import_state *state UNUSED, const char *feature, int from_stream)
    -+static void check_unsafe_feature(struct fast_import_state *state, const char *feature, int from_stream)
    +-static void check_unsafe_feature(struct fast_import_state *state UNUSED,
    ++static void check_unsafe_feature(struct fast_import_state *state,
    + 				 const char *feature,
    + 				 int from_stream)
      {
     -	if (from_stream && !allow_unsafe_features)
     +	if (from_stream && !state->allow_unsafe_features)
      		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
      		    feature);
      }
    -@@ builtin/fast-import.c: static int parse_one_feature(struct fast_import_state *state, const char *featur
    +@@ builtin/fast-import.c: static int parse_one_feature(struct fast_import_state *state,
      
      static void parse_feature(struct fast_import_state *state, const char *feature)
      {
 9:  3d6ab86518 =  9:  efcd1b9ac4 fast-import: use struct option for usage string
10:  3208937f13 = 10:  d109b8c622 fast-import: use callbacks to parse some options
11:  202a50beec ! 11:  95919e8319 fast-import: use parse_options() for command line options
    @@ Commit message
             requires a value" unlike the other four options that are not
             accepted anymore on the command line (see above).
     
    +      - Value-taking options now also accept the space-separated
    +        `--opt value` form, like `--depth 5`, in addition to the
    +        `--opt=value` form.
    +
    +      - A bare or trailing `--` is now accepted and the stream is read
    +        normally, while it used to be a usage error.
    +
           - The error messages for some options might differ a bit.
     
           - The code is shorter and more standard.
    @@ Commit message
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    + ## Documentation/git-fast-import.adoc ##
    +@@ Documentation/git-fast-import.adoc: Only enable this option if you trust the program generating the
    + fast-import stream! This option is enabled automatically for
    + remote-helpers that use the `import` capability, as they are
    + already trusted to run their own code.
    +++
    ++Note that this option has to be spelled in full, and has to appear
    ++before any option whose value is separated from it by a space, for
    ++the unsafe `feature` commands in the stream to be allowed. So
    ++`--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
    ++them, while `--allow-unsafe-features --depth 5` and
    ++`--depth=5 --allow-unsafe-features` allow them.
    + 
    + `--signed-tags=<mode>`::
    + 	Specify how to handle signed tags. Behaves in the same way as
    +
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static const char *const fast_import_usage[] = {
      
    @@ builtin/fast-import.c: static const char *const fast_import_usage[] = {
     -
     -		if (*a != '-' || !strcmp(a, "--"))
     -			break;
    -+	int argc = parse_options(state->argc, state->argv, state->prefix,
    -+				 state->option, fast_import_usage,
    -+				 PARSE_OPT_KEEP_ARGV0);
    - 
    +-
     -		if (!skip_prefix(a, "--", &a))
     -			die(_("unknown option %s"), a);
     -
    @@ builtin/fast-import.c: static const char *const fast_import_usage[] = {
     -			option_cat_blob_fd(state, a);
     -			continue;
     -		}
    --
    ++	int argc = parse_options(state->argc, state->argv, state->prefix,
    ++				 state->option, fast_import_usage,
    ++				 PARSE_OPT_KEEP_ARGV0);
    + 
     -		die(_("unknown option --%s"), a);
     -	}
     -	if (i != state->argc)
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      	struct option fast_import_options[] = {
      		OPT_GROUP(N_("Common")),
      		OPT_CALLBACK_F(0, "date-format", NULL, N_("fmt"),
    +@@ builtin/fast-import.c: int cmd_fast_import(int argc,
    + 	 * "feature" lines at the start of the stream (which allows the command
    + 	 * line to override stream data). But we must do an early parse of any
    + 	 * command-line options that impact how we interpret the feature lines.
    ++	 *
    ++	 * NEEDSWORK: This scan only matches the exact "--allow-unsafe-features"
    ++	 * spelling and stops at the first argument that doesn't start with a
    ++	 * dash. As parse_options() below also accepts unambiguous abbreviations
    ++	 * and values separated by a space from their option, the two disagree
    ++	 * for command lines like "--allow-unsafe" or "--depth 5
    ++	 * --allow-unsafe-features": parse_options() accepts the option, but
    ++	 * this scan doesn't see it, so unsafe features from the stream are
    ++	 * still refused. This errs on the safe side, but should be fixed by
    ++	 * teaching this scan about the options that take a value.
    + 	 */
    + 	for (int i = 1; i < argc; i++) {
    + 		const char *arg = argv[i];
     
      ## t/t9300-fast-import.sh ##
     @@ t/t9300-fast-import.sh: test_expect_success 'R: unknown commandline options are rejected' '\
12:  99ff791a62 ! 12:  96f17c83d2 fast-import: remove useless from_stream argument
    @@ Commit message
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static int parse_one_option(struct fast_import_state *state, const char *option)
    - 	return 1;
      }
      
    --static void check_unsafe_feature(struct fast_import_state *state, const char *feature, int from_stream)
    -+static void check_unsafe_feature(struct fast_import_state *state, const char *feature)
    + static void check_unsafe_feature(struct fast_import_state *state,
    +-				 const char *feature,
    +-				 int from_stream)
    ++				 const char *feature)
      {
     -	if (from_stream && !state->allow_unsafe_features)
     +	if (!state->allow_unsafe_features)
    @@ builtin/fast-import.c: static int parse_one_option(struct fast_import_state *sta
      		    feature);
      }
      
    --static int parse_one_feature(struct fast_import_state *state, const char *feature, int from_stream)
    -+static int parse_one_feature(struct fast_import_state *state, const char *feature)
    + static int parse_one_feature(struct fast_import_state *state,
    +-			     const char *feature,
    +-			     int from_stream)
    ++			     const char *feature)
      {
      	const char *arg;
      
-- 
2.55.0.530.gdb3615d990.dirty

