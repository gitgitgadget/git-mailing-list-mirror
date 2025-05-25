Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A547263B
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748203949; cv=none; b=IL0x14ATzmYGZLLP4jZy5skn+tcwUrbq+YCrDBV/34noQ+AyHenvT6LjrajGldedJdeJgMHB2HYr1k0/5NhuhnkUgIfj4X5Ql8HjV2ZAE/kvfMBFXLS+hm52usf0PUCyINFHFSsznWEOINUme4L56BkF3Im5q17xWm+yZfpWSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748203949; c=relaxed/simple;
	bh=F/NCyYTHWRiYqhzmBc21K2jsiwDw/zIzk8Ccn3/hHIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk1ltsAxJwafetzFALTH/RdwHhBPAkNMyhqYOyhha053C/r0mooHoYGeBw1w6JuOTZSCC5Q/iLofY2cppwTSGk3aHYT/yKdBhmT/GSe1VDqd3tPEfDdMik06arB3451HYvVK9sTUiQLU6X2z+4CSr2362/m4EvDsnckuqNx0IeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNco3I/W; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNco3I/W"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2c754af3cso1359485fac.3
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748203946; x=1748808746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pRFHkGUyoafswvKbdibbpkbzNa7myhY7zs48E7BQtvo=;
        b=YNco3I/W/LxFmzaFHCQJsdUgG7Wtz7Sn/Y00Chql7CBP6DBUsL84IR88DbrzVob/Ee
         h3erUDw5JJt/1b6S/nnj5HIcQGLzmvEaGsy2rbet08NcR42i6ynGktRycquAvrGxpwcU
         dW+1OPn/yuvPmwqi+xiynUgTpp9UQRr6WzQ6oUe2XeJ+MHcp1GwU0tdM+lXA8Yp3LZOz
         cvDU+dtWM2ypOEqJEsANz1HsUMqEhLpx0Gktog2rkVXFsYgRnHVfFS15b8Q3rGXal78U
         8kHNIawi7ULTdHt98XCmbUPmYCzO7mX1SXjGcjazSOFUqzhoRPmq0Wt9k6yOArYdzlq+
         j+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748203946; x=1748808746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRFHkGUyoafswvKbdibbpkbzNa7myhY7zs48E7BQtvo=;
        b=Sjpeud/8YBPYzHL5hmXQtxcR27byBJ60IxKCh+jhCiro5hIfqQH0evcoiZJO4hpyJX
         6CyxzA1yKkvISxWeUkkM3TvMhQ9oH2/W1Tbx0F4PhqsLPx/hVDzQt2C+S6Me8aTBQzuX
         TS+sb+awn7Uf/nPeNiqPbBSB4vl+KAYuPCvtaGxflOJc7LX03/G42opULQpgo5hyJIR4
         2Xy+Asx1C0I65T7KIpplpWch+4oRSj2iaZXXOy26XTKZVWSMhgwMDgP+xTdSHlKiy4Ru
         phB24cpq0UyaTUlQuwvVEFqUb7jL4eH1v9YT/FkpXYaDR5+d4njy6R8E1jqc+CIc9XIu
         /yuA==
X-Gm-Message-State: AOJu0YxdcqnQMpZqWv6HO1F/bAesTuHvkTN8f3rUquYT70pey8qxT/io
	yS7ptUwKcjyMeoL1Eacoo5UjOGhc+PwwXgBVjq0xydRZGnQTRddPeKkiEmNi63xG
X-Gm-Gg: ASbGncuF6uls/ZL6kdrrnnR7GsAPBck83o6FLjgc3Ev169yCI0SRDcjsYvSEnV+bIIY
	C1gs1mPz8OD4KK67uRf/7N8HksU+s0k03Ai/5e5lUN+IeZNA7+f1KJaJn+Y7vOq1bKC4KwIn6Pn
	3x9iCcFKUdotTLMkxFuWDVcrYOYsYU86YVOR0Av6O8CtB/VuNSsmUP7VPmWG73cgNDHHhyTtJon
	/MwqT/qPehSRdxqk8zs5UMf0tKuf+BP7tq8NEOFSU0yLSc/LTCQy/Gw+aclU9E7G3/LdUTs4sj8
	v3ozs8VJMLpb0zDinX5Ge36NZ+FCIiNSP/2z/Xm1Ll+r
X-Google-Smtp-Source: AGHT+IFsiPUMaKZyjrD4x2Q6Phic2ZvNawrRLHiqsL4CEzFNYb/tSZhjazBVNP1nG44Y3CC91zo2+Q==
X-Received: by 2002:a05:6870:9c8e:b0:2c2:561c:47e3 with SMTP id 586e51a60fabf-2e862011d2bmr3344378fac.21.1748203946279;
        Sun, 25 May 2025 13:12:26 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2e3c077f805sm4503006fac.27.2025.05.25.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:12:25 -0700 (PDT)
Date: Sun, 25 May 2025 15:07:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 1/5] last-modified: new subcommand to show when
 files were last modified
Message-ID: <zz2xv667flcb46gp4scqu4wmrxviiecqz2ru35glalbsaluc3p@kmymzn5lxapk>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>

On 25/05/23 11:33AM, Toon Claes wrote:
> Similar to git-blame(1), introduce a new subcommand
> git-last-modified(1). This command shows the most recent modification to
> paths in a tree. It does so by expanding the tree at a given commit,
> taking note of the current state of each path, and then walking
> backwards through history looking for commits where each path changed
> into its final commit ID.

Just a thought, but it might be nice to include in a commit message why
this operation is useful.

> Based-on-patch-by: Jeff King <peff@peff.net>
> Improved-by: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  .gitignore                           |   1 +
>  Documentation/git-last-modified.adoc |  49 ++++++++
>  Documentation/meson.build            |   1 +
>  Makefile                             |   2 +
>  builtin.h                            |   1 +
>  builtin/last-modified.c              |  43 +++++++
>  command-list.txt                     |   1 +
>  git.c                                |   1 +
>  last-modified.c                      | 213 +++++++++++++++++++++++++++++++++++
>  last-modified.h                      |  27 +++++
>  meson.build                          |   2 +
>  t/meson.build                        |   1 +
>  t/t8020-last-modified.sh             | 194 +++++++++++++++++++++++++++++++
>  13 files changed, 536 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..a36ee94443 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -87,6 +87,7 @@
>  /git-init-db
>  /git-interpret-trailers
>  /git-instaweb
> +/git-last-modified
>  /git-log
>  /git-ls-files
>  /git-ls-remote
> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> new file mode 100644
> index 0000000000..1af38f402e
> --- /dev/null
> +++ b/Documentation/git-last-modified.adoc
> @@ -0,0 +1,49 @@
> +git-last-modified(1)
> +====================
> +
> +NAME
> +----
> +git-last-modified - EXPERIMENTAL: Show when files were last modified
> +
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git last-modified [-r] [<revision-range>] [[--] <path>...]
> +
> +DESCRIPTION
> +-----------
> +
> +Shows which commit last modified each of the relevant files and subdirectories.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +OPTIONS
> +-------
> +
> +-r::
> +	Recurse into subtrees.
> +
> +-t::
> +	Show tree entry itself as well as subtrees.  Implies `-r`.

This left me wondering about the default behavior regarding displaying
trees when neither `-t` and `-r` are specified. If we omit showing when
a tree was last mostified?

> +
> +<revision-range>::
> +	Only traverse commits in the specified revision range. When no
> +	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
> +	history leading to the current commit). For a complete list of ways to
> +	spell `<revision-range>`, see the 'Specifying Ranges' section of
> +	linkgit:gitrevisions[7].
> +
> +[--] <path>...::
> +	For each _<path>_ given, the commit which last modified it is returned.
> +	Without an optional path parameter, all files and subdirectories
> +	of the current working directory are included in the

are include in the? I assume you meant to say the search/operation.

> +
> +SEE ALSO
> +--------
> +linkgit:git-blame[1],
> +linkgit:git-log[1].
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 1433acfd31..fa93cec5c3 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -74,6 +74,7 @@ manpages = {
>    'git-init.adoc' : 1,
>    'git-instaweb.adoc' : 1,
>    'git-interpret-trailers.adoc' : 1,
> +  'git-last-modified.adoc' : 1,
>    'git-log.adoc' : 1,
>    'git-ls-files.adoc' : 1,
>    'git-ls-remote.adoc' : 1,
> diff --git a/Makefile b/Makefile
> index ecd590a643..40bc24c704 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1051,6 +1051,7 @@ LIB_OBJS += hook.o
>  LIB_OBJS += ident.o
>  LIB_OBJS += json-writer.o
>  LIB_OBJS += kwset.o
> +LIB_OBJS += last-modified.o
>  LIB_OBJS += levenshtein.o
>  LIB_OBJS += line-log.o
>  LIB_OBJS += line-range.o
> @@ -1266,6 +1267,7 @@ BUILTIN_OBJS += builtin/hook.o
>  BUILTIN_OBJS += builtin/index-pack.o
>  BUILTIN_OBJS += builtin/init-db.o
>  BUILTIN_OBJS += builtin/interpret-trailers.o
> +BUILTIN_OBJS += builtin/last-modified.o
>  BUILTIN_OBJS += builtin/log.o
>  BUILTIN_OBJS += builtin/ls-files.o
>  BUILTIN_OBJS += builtin/ls-remote.o
> diff --git a/builtin.h b/builtin.h
> index bff13e3069..6ed6759ec4 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -176,6 +176,7 @@ int cmd_hook(int argc, const char **argv, const char *prefix, struct repository
>  int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
> +int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
>  int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> new file mode 100644
> index 0000000000..0d4733f666
> --- /dev/null
> +++ b/builtin/last-modified.c
> @@ -0,0 +1,43 @@
> +#include "git-compat-util.h"
> +#include "last-modified.h"
> +#include "hex.h"
> +#include "quote.h"
> +#include "config.h"
> +#include "object-name.h"
> +#include "parse-options.h"
> +#include "builtin.h"

For builtins, "builtin.h" should be included at the top and
"git-compat-util.h" should be omitted.

> +
> +static void show_entry(const char *path, const struct commit *commit, void *d)
> +{
> +	struct last_modified *lm = d;
> +
> +	if (commit->object.flags & BOUNDARY)
> +		putchar('^');
> +	printf("%s\t", oid_to_hex(&commit->object.oid));
> +
> +	if (lm->rev.diffopt.line_termination)
> +		write_name_quoted(path, stdout, '\n');
> +	else
> +		printf("%s%c", path, '\0');
> +
> +	fflush(stdout);
> +}
> +
> +int cmd_last_modified(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo)
> +{
> +	int ret = 0;
> +	struct last_modified lm;
> +
> +	repo_config(repo, git_default_config, NULL);
> +
> +	last_modified_init(&lm, repo, prefix, argc, argv);
> +	if (last_modified_run(&lm, show_entry, &lm) < 0)
> +		die(_("error running last-modified traversal"));
> +
> +	last_modified_release(&lm);
> +
> +	return ret;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index b7ade3ab9f..b715777b24 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -124,6 +124,7 @@ git-index-pack                          plumbingmanipulators
>  git-init                                mainporcelain           init
>  git-instaweb                            ancillaryinterrogators          complete
>  git-interpret-trailers                  purehelpers
> +git-last-modified                       plumbinginterrogators
>  git-log                                 mainporcelain           info
>  git-ls-files                            plumbinginterrogators
>  git-ls-remote                           plumbinginterrogators
> diff --git a/git.c b/git.c
> index 77c4359522..65afc0d0e7 100644
> --- a/git.c
> +++ b/git.c
> @@ -565,6 +565,7 @@ static struct cmd_struct commands[] = {
>  	{ "init", cmd_init_db },
>  	{ "init-db", cmd_init_db },
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
> +	{ "last-modified", cmd_last_modified, RUN_SETUP },
>  	{ "log", cmd_log, RUN_SETUP },
>  	{ "ls-files", cmd_ls_files, RUN_SETUP },
>  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
> diff --git a/last-modified.c b/last-modified.c
> new file mode 100644
> index 0000000000..9283f8fcae
> --- /dev/null
> +++ b/last-modified.c
> @@ -0,0 +1,213 @@
> +#include "git-compat-util.h"
> +#include "last-modified.h"
> +#include "commit.h"
> +#include "diffcore.h"
> +#include "diff.h"
> +#include "object.h"
> +#include "revision.h"
> +#include "repository.h"
> +#include "log-tree.h"
> +
> +struct last_modified_entry {
> +	struct hashmap_entry hashent;
> +	struct object_id oid;
> +	struct commit *commit;
> +	const char path[FLEX_ARRAY];
> +};
> +
> +static void add_from_diff(struct diff_queue_struct *q,
> +			  struct diff_options *opt UNUSED,
> +			  void *data)
> +{
> +	struct last_modified *lm = data;
> +
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		struct last_modified_entry *ent;
> +		const char *path = p->two->path;
> +
> +		FLEX_ALLOC_STR(ent, path, path);
> +		oidcpy(&ent->oid, &p->two->oid);
> +		hashmap_entry_init(&ent->hashent, strhash(ent->path));
> +		hashmap_add(&lm->paths, &ent->hashent);
> +	}
> +}
> +
> +static int add_from_revs(struct last_modified *lm)
> +{
> +	size_t count = 0;
> +	struct diff_options diffopt;
> +
> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	diffopt.format_callback = add_from_diff;
> +	diffopt.format_callback_data = lm;
> +
> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
> +
> +		if (obj->item->flags & UNINTERESTING)
> +			continue;
> +
> +		if (count++)
> +			return error(_("can only get last-modified one tree at a time"));
> +
> +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
> +			      &obj->item->oid, "", &diffopt);
> +		diff_flush(&diffopt);
> +	}
> +	clear_pathspec(&diffopt.pathspec);
> +
> +	return 0;
> +}
> +
> +static int last_modified_entry_hashcmp(const void *unused UNUSED,
> +				    const struct hashmap_entry *hent1,
> +				    const struct hashmap_entry *hent2,
> +				    const void *path)
> +{
> +	const struct last_modified_entry *ent1 =
> +		container_of(hent1, const struct last_modified_entry, hashent);
> +	const struct last_modified_entry *ent2 =
> +		container_of(hent2, const struct last_modified_entry, hashent);
> +	return strcmp(ent1->path, path ? path : ent2->path);
> +}
> +
> +void last_modified_init(struct last_modified *lm,
> +		     struct repository *r,
> +		     const char *prefix,
> +		     int argc, const char **argv)
> +{
> +	memset(lm, 0, sizeof(*lm));
> +	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
> +
> +	repo_init_revisions(r, &lm->rev, prefix);
> +	lm->rev.def = "HEAD";
> +	lm->rev.combine_merges = 1;
> +	lm->rev.show_root_diff = 1;
> +	lm->rev.boundary = 1;
> +	lm->rev.no_commit_id = 1;
> +	lm->rev.diff = 1;
> +	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
> +		die(_("unknown last-modified argument: %s"), argv[1]);
> +
> +	if (add_from_revs(lm) < 0)
> +		die(_("unable to setup last-modified"));
> +}
> +
> +void last_modified_release(struct last_modified *lm)
> +{
> +	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
> +	release_revisions(&lm->rev);
> +}
> +
> +struct last_modified_callback_data {
> +	struct commit *commit;
> +	struct hashmap *paths;
> +
> +	last_modified_callback callback;
> +	void *callback_data;
> +};
> +
> +static void mark_path(const char *path, const struct object_id *oid,
> +		      struct last_modified_callback_data *data)
> +{
> +	struct last_modified_entry *ent;
> +
> +	/* Is it even a path that we are interested in? */
> +	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
> +					  struct last_modified_entry, hashent);
> +	if (!ent)
> +		return;
> +
> +	/* Have we already found a commit? */
> +	if (ent->commit)
> +		return;
> +
> +	/*
> +	 * Is it arriving at a version of interest, or is it from a side branch
> +	 * which did not contribute to the final state?
> +	 */
> +	if (!oideq(oid, &ent->oid))
> +		return;
> +
> +	ent->commit = data->commit;
> +	if (data->callback)
> +		data->callback(path, data->commit, data->callback_data);
> +
> +	hashmap_remove(data->paths, &ent->hashent, path);
> +	free(ent);
> +}
> +
> +static void last_modified_diff(struct diff_queue_struct *q,
> +		       struct diff_options *opt UNUSED, void *cbdata)
> +{
> +	struct last_modified_callback_data *data = cbdata;
> +
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		switch (p->status) {
> +		case DIFF_STATUS_DELETED:
> +			/*
> +			 * There's no point in feeding a deletion, as it could
> +			 * not have resulted in our current state, which
> +			 * actually has the file.
> +			 */
> +			break;
> +
> +		default:
> +			/*
> +			 * Otherwise, we care only that we somehow arrived at
> +			 * a final path/sha1 state. Note that this covers some
> +			 * potentially controversial areas, including:
> +			 *
> +			 *  1. A rename or copy will be found, as it is the
> +			 *     first time the content has arrived at the given
> +			 *     path.
> +			 *
> +			 *  2. Even a non-content modification like a mode or
> +			 *     type change will trigger it.
> +			 *
> +			 * We take the inclusive approach for now, and find
> +			 * anything which impacts the path. Options to tweak
> +			 * the behavior (e.g., to "--follow" the content across
> +			 * renames) can come later.
> +			 */
> +			mark_path(p->two->path, &p->two->oid, data);
> +			break;
> +		}
> +	}
> +}
> +
> +int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
> +{
> +	struct last_modified_callback_data data;
> +
> +	data.paths = &lm->paths;
> +	data.callback = cb;
> +	data.callback_data = cbdata;
> +
> +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	lm->rev.diffopt.format_callback = last_modified_diff;
> +	lm->rev.diffopt.format_callback_data = &data;
> +
> +	prepare_revision_walk(&lm->rev);
> +
> +	while (hashmap_get_size(&lm->paths)) {
> +		data.commit = get_revision(&lm->rev);
> +		if (!data.commit)
> +			break;
> +
> +		if (data.commit->object.flags & BOUNDARY) {
> +			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
> +				       &data.commit->object.oid,
> +				       "", &lm->rev.diffopt);
> +			diff_flush(&lm->rev.diffopt);
> +		} else {
> +			log_tree_commit(&lm->rev, data.commit);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/last-modified.h b/last-modified.h
> new file mode 100644
> index 0000000000..42a819d979
> --- /dev/null
> +++ b/last-modified.h

Any reason this code doesn't just live with the builtin? Is there intent
for it to be used elsewhere?

> @@ -0,0 +1,27 @@
> +#ifndef LAST_MODIFIED_H
> +#define LAST_MODIFIED_H
> +
> +#include "commit.h"
> +#include "revision.h"
> +#include "hashmap.h"
> +
> +struct last_modified {
> +	struct hashmap paths;
> +	struct rev_info rev;
> +};

It might be nice to leave some comments to document the types and
functions here.

> +
> +void last_modified_init(struct last_modified *lm,
> +		     struct repository *r,
> +		     const char *prefix,
> +		     int argc, const char **argv);

Being that `last_modified_init()` handles argument parsing for the
builtin, I somewhat question that value of having it outside the
builtin.

> +
> +void last_modified_release(struct last_modified *);
> +
> +typedef void (*last_modified_callback)(const char *path,
> +				    const struct commit *commit,
> +				    void *data);
> +int last_modified_run(struct last_modified *lm,
> +		   last_modified_callback cb,
> +		   void *cbdata);
> +
> +#endif /* LAST_MODIFIED_H */
> diff --git a/meson.build b/meson.build
> index a1476e5b32..bdd9ed2c4c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -365,6 +365,7 @@ libgit_sources = [
>    'ident.c',
>    'json-writer.c',
>    'kwset.c',
> +  'last-modified.c',
>    'levenshtein.c',
>    'line-log.c',
>    'line-range.c',
> @@ -609,6 +610,7 @@ builtin_sources = [
>    'builtin/index-pack.c',
>    'builtin/init-db.c',
>    'builtin/interpret-trailers.c',
> +  'builtin/last-modified.c',
>    'builtin/log.c',
>    'builtin/ls-files.c',
>    'builtin/ls-remote.c',
> diff --git a/t/meson.build b/t/meson.build
> index fcfc1c2c2b..be5a711375 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -962,6 +962,7 @@ integration_tests = [
>    't8012-blame-colors.sh',
>    't8013-blame-ignore-revs.sh',
>    't8014-blame-ignore-fuzzy.sh',
> +  't8020-last-modified.sh',
>    't9001-send-email.sh',
>    't9002-column.sh',
>    't9003-help-autocorrect.sh',
> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> new file mode 100755
> index 0000000000..0c4a19c029
> --- /dev/null
> +++ b/t/t8020-last-modified.sh
> @@ -0,0 +1,194 @@
> +#!/bin/sh
> +
> +test_description='last-modified tests'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit 1 file &&
> +	mkdir a &&
> +	test_commit 2 a/file &&
> +	mkdir a/b &&
> +	test_commit 3 a/b/file
> +'
> +
> +test_expect_success 'cannot run last-modified on two trees' '
> +	test_must_fail git last-modified HEAD HEAD~1
> +'
> +
> +check_last_modified() {
> +	local indir= &&
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		-C)
> +			indir="$2"
> +			shift
> +			;;
> +		*)
> +			break
> +			;;
> +		esac &&
> +		shift
> +	done &&
> +
> +	cat >expect &&
> +	test_when_finished "rm -f tmp.*" &&
> +	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
> +	git name-rev --annotate-stdin --name-only --tags \
> +		<tmp.1 >tmp.2 &&
> +	tr '\t' ' ' <tmp.2 >tmp.3 &&
> +	sort tmp.3 >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'last-modified non-recursive' '
> +	check_last_modified <<-\EOF
> +	1 file
> +	3 a
> +	EOF
> +'
> +
> +test_expect_success 'last-modified recursive' '
> +	check_last_modified -r <<-\EOF
> +	1 file
> +	2 a/file
> +	3 a/b/file
> +	EOF
> +'
> +
> +test_expect_success 'last-modified subdir' '
> +	check_last_modified a <<-\EOF
> +	3 a
> +	EOF
> +'
> +
> +test_expect_success 'last-modified subdir recursive' '
> +	check_last_modified -r a <<-\EOF
> +	2 a/file
> +	3 a/b/file
> +	EOF
> +'
> +
> +test_expect_success 'last-modified from non-HEAD commit' '
> +	check_last_modified HEAD^ <<-\EOF
> +	1 file
> +	2 a
> +	EOF
> +'
> +
> +test_expect_success 'last-modified from subdir defaults to root' '
> +	check_last_modified -C a <<-\EOF
> +	1 file
> +	3 a
> +	EOF
> +'
> +
> +test_expect_success 'last-modified from subdir uses relative pathspecs' '
> +	check_last_modified -C a -r b <<-\EOF
> +	3 a/b/file
> +	EOF
> +'
> +
> +test_expect_success 'limit last-modified traversal by count' '
> +	check_last_modified -1 <<-\EOF
> +	3 a
> +	^2 file
> +	EOF
> +'
> +
> +test_expect_success 'limit last-modified traversal by commit' '
> +	check_last_modified HEAD~2..HEAD <<-\EOF
> +	3 a
> +	^1 file
> +	EOF
> +'
> +
> +test_expect_success 'only last-modified files in the current tree' '
> +	git rm -rf a &&
> +	git commit -m "remove a" &&
> +	check_last_modified <<-\EOF
> +	1 file
> +	EOF
> +'
> +
> +test_expect_success 'cross merge boundaries in blaming' '
> +	git checkout HEAD^0 &&
> +	git rm -rf . &&
> +	test_commit m1 &&
> +	git checkout HEAD^ &&
> +	git rm -rf . &&
> +	test_commit m2 &&
> +	git merge m1 &&
> +	check_last_modified <<-\EOF
> +	m1 m1.t
> +	m2 m2.t
> +	EOF
> +'
> +
> +test_expect_success 'last-modified merge for resolved conflicts' '
> +	git checkout HEAD^0 &&
> +	git rm -rf . &&
> +	test_commit c1 conflict &&
> +	git checkout HEAD^ &&
> +	git rm -rf . &&
> +	test_commit c2 conflict &&
> +	test_must_fail git merge c1 &&
> +	test_commit resolved conflict &&
> +	check_last_modified conflict <<-\EOF
> +	resolved conflict
> +	EOF
> +'
> +
> +
> +# Consider `file` with this content through history:
> +#
> +# A---B---B-------B---B
> +#          \     /
> +#           C---D
> +test_expect_success 'last-modified merge ignores content from branch' '
> +	git checkout HEAD^0 &&
> +	git rm -rf . &&
> +	test_commit a1 file A &&
> +	test_commit a2 file B &&
> +	test_commit a3 file C &&
> +	test_commit a4 file D &&
> +	git checkout a2 &&
> +	git merge --no-commit --no-ff a4 &&
> +	git checkout a2 -- file &&
> +	git merge --continue &&
> +	check_last_modified <<-\EOF
> +	a2 file
> +	EOF
> +'
> +
> +# Consider `file` with this content through history:
> +#
> +#  A---B---B---C---D---B---B
> +#           \         /
> +#            B-------B
> +test_expect_success 'last-modified merge undoes changes' '
> +	git checkout HEAD^0 &&
> +	git rm -rf . &&
> +	test_commit b1 file A &&
> +	test_commit b2 file B &&
> +	test_commit b3 file C &&
> +	test_commit b4 file D &&
> +	git checkout b2 &&
> +	test_commit b5 file2 2 &&
> +	git checkout b4 &&
> +	git merge --no-commit --no-ff b5 &&
> +	git checkout b2 -- file &&
> +	git merge --continue &&
> +	check_last_modified <<-\EOF
> +	b2 file
> +	b5 file2
> +	EOF
> +'
> +
> +test_expect_success 'last-modified complains about unknown arguments' '
> +	test_must_fail git last-modified --foo 2>err &&
> +	grep "unknown last-modified argument: --foo" err
> +'
> +
> +test_done
> 
> -- 
> 2.49.0
> 
> 
