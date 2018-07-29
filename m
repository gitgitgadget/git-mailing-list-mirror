Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74869208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 18:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeG2UHz (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 16:07:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55743 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeG2UHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 16:07:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so10683370wmc.5
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8ik/zLWM9/Bo31ie3VpOqzTXeFd22F81ophnbC8R6k=;
        b=gqcgrrNktVpnJDdOg5HVboNLe088J9HMNFsc9ZXLTBfPlwS39LKTuHHI2iME/GgZ0V
         IwUxatvaQdhyziCz6Awmx135P+Vaqz4qRn1OP7ZF6yaKCsXoaBu9K2BZ09Ravvtc3oNz
         T0rtMT+Mane3xOKSQ6+gL0FGAbXjL0qM3IfvxXTeMz+ydV4WxxDirz+pxxjgW0qQVy8y
         nUwf24ilMPg6bzjCUHaRFdsiql2jE+aMDH5Ga8ufM+m0xvLn5oga8lsaQtOhbFgOmoFi
         Z9d5bVLlApQUHCCdXYLO93epWAVfouhg80Lv/Dz5w8vHjTnnyyhthjvyDLXq40zmrY9U
         abHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8ik/zLWM9/Bo31ie3VpOqzTXeFd22F81ophnbC8R6k=;
        b=kj3nCR4AkJiXjbNlgx59zNQgq/UZP/MU56tWJ/9ADTNMYPBz+MYrmt929vPSGq1s1a
         OHyc0igjz6iEZscUwDZSMeoVJOAbOl2iKRH2/gFVXYhX3eSLV85Ob1DdrO8KsoaaJ5FQ
         K4eBj7LF/xRAjgIXMSTgaYIsUpNPE+Nx0b2wpC5o4nMDNmP15eQfzaH4AaX29EwOyBuW
         0WSsICOi5m9egDJ05/rnakYQgYwBRre2xIbH1Avsfubddx3QK6qPKjJ6kNoqYS03/H2M
         bDPUqoKmCu4LuRC0JqnYKwowQjb832gABQxDF7dSHBgXj3ezP5Y6B/KHYjP4W6+sTBsI
         f+0g==
X-Gm-Message-State: AOUpUlGsSxl3y0HTu1K1AfAZcxDYLsEhd5vNm9kNvyhHoEG0THktWjQL
        S9ui7kSgicNdaavvJgRfvnY=
X-Google-Smtp-Source: AAOMgpf42N7q08Ai0/kAPtX5jHOO1jlmUtKvSV6gYQOKIUabJeajvj6fcP34P2P6PbxtsCig0sHI+g==
X-Received: by 2002:a1c:3543:: with SMTP id c64-v6mr11686830wma.62.1532889391466;
        Sun, 29 Jul 2018 11:36:31 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id g17-v6sm10141874wmh.19.2018.07.29.11.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 11:36:30 -0700 (PDT)
Date:   Sun, 29 Jul 2018 19:36:29 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 03/21] range-diff: first rudimentary implementation
Message-ID: <20180729183629.GC2734@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <4e3fb47a1dcef96780bd536032b81dd99387f2db.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3fb47a1dcef96780bd536032b81dd99387f2db.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> At this stage, `git range-diff` can determine corresponding commits
> of two related commit ranges. This makes use of the recently introduced
> implementation of the linear assignment algorithm.
> 
> The core of this patch is a straight port of the ideas of tbdiff, the
> apparently dormant project at https://github.com/trast/tbdiff.
> 
> The output does not at all match `tbdiff`'s output yet, as this patch
> really concentrates on getting the patch matching part right.
> 
> Note: due to differences in the diff algorithm (`tbdiff` uses the Python
> module `difflib`, Git uses its xdiff fork), the cost matrix calculated
> by `range-diff` is different (but very similar) to the one calculated
> by `tbdiff`. Therefore, it is possible that they find different matching
> commits in corner cases (e.g. when a patch was split into two patches of
> roughly equal length).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile             |   1 +
>  builtin/range-diff.c |  43 +++++-
>  range-diff.c         | 311 +++++++++++++++++++++++++++++++++++++++++++
>  range-diff.h         |   7 +
>  4 files changed, 361 insertions(+), 1 deletion(-)
>  create mode 100644 range-diff.c
>  create mode 100644 range-diff.h
>
> [...]
> 
> diff --git a/range-diff.c b/range-diff.c
> new file mode 100644
> index 000000000..15d418afa
> --- /dev/null
> +++ b/range-diff.c
> @@ -0,0 +1,311 @@
> +#include "cache.h"
> +#include "range-diff.h"
> +#include "string-list.h"
> +#include "run-command.h"
> +#include "argv-array.h"
> +#include "hashmap.h"
> +#include "xdiff-interface.h"
> +#include "linear-assignment.h"
> +
> +struct patch_util {
> +	/* For the search for an exact match */
> +	struct hashmap_entry e;
> +	const char *diff, *patch;
> +
> +	int i;
> +	int diffsize;
> +	size_t diff_offset;
> +	/* the index of the matching item in the other branch, or -1 */
> +	int matching;
> +	struct object_id oid;
> +};
> +
> +/*
> + * Reads the patches into a string list, with the `util` field being populated
> + * as struct object_id (will need to be free()d).
> + */
> +static int read_patches(const char *range, struct string_list *list)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	FILE *in;
> +	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> +	struct patch_util *util = NULL;
> +	int in_header = 1;
> +
> +	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> +			"--reverse", "--date-order", "--decorate=no",
> +			"--no-abbrev-commit", range,
> +			NULL);

Compared to tbdiff, add "--decorate=no", and "--no-abbrev-commit".  I
see we're abbreviating the commit hashes later.  We don't want ref
names here, so "--decorate=no" makes sense as well.

> +	cp.out = -1;
> +	cp.no_stdin = 1;
> +	cp.git_cmd = 1;
> +
> +	if (start_command(&cp))
> +		return error_errno(_("could not start `log`"));
> +	in = fdopen(cp.out, "r");
> +	if (!in) {
> +		error_errno(_("could not read `log` output"));
> +		finish_command(&cp);
> +		return -1;
> +	}
> +
> +	while (strbuf_getline(&line, in) != EOF) {
> +		const char *p;
> +
> +		if (skip_prefix(line.buf, "commit ", &p)) {
> +			if (util) {
> +				string_list_append(list, buf.buf)->util = util;
> +				strbuf_reset(&buf);
> +			}
> +			util = xcalloc(sizeof(*util), 1);
> +			if (get_oid(p, &util->oid)) {
> +				error(_("could not parse commit '%s'"), p);
> +				free(util);
> +				string_list_clear(list, 1);
> +				strbuf_release(&buf);
> +				strbuf_release(&line);
> +				fclose(in);
> +				finish_command(&cp);
> +				return -1;
> +			}
> +			util->matching = -1;
> +			in_header = 1;
> +			continue;
> +		}
> +
> +		if (starts_with(line.buf, "diff --git")) {
> +			in_header = 0;
> +			strbuf_addch(&buf, '\n');
> +			if (!util->diff_offset)
> +				util->diff_offset = buf.len;
> +			strbuf_addbuf(&buf, &line);
> +		} else if (in_header) {
> +			if (starts_with(line.buf, "Author: ")) {
> +				strbuf_addbuf(&buf, &line);
> +				strbuf_addstr(&buf, "\n\n");
> +			} else if (starts_with(line.buf, "    ")) {
> +				strbuf_addbuf(&buf, &line);
> +				strbuf_addch(&buf, '\n');
> +			}
> +			continue;
> +		} else if (starts_with(line.buf, "@@ "))
> +			strbuf_addstr(&buf, "@@");
> +		else if (!line.buf[0] || starts_with(line.buf, "index "))
> +			/*
> +			 * A completely blank (not ' \n', which is context)
> +			 * line is not valid in a diff.  We skip it
> +			 * silently, because this neatly handles the blank
> +			 * separator line between commits in git-log
> +			 * output.
> +			 *
> +			 * We also want to ignore the diff's `index` lines
> +			 * because they contain exact blob hashes in which
> +			 * we are not interested.
> +			 */
> +			continue;
> +		else
> +			strbuf_addbuf(&buf, &line);
> +
> +		strbuf_addch(&buf, '\n');
> +		util->diffsize++;
> +	}

This seems to differ from tbdiff in the number of newlines we're
adding in various places, however I think as long as it's consistent
in itself, and with the way we're printing the output the differences
shouldn't matter.

> +	fclose(in);
> +	strbuf_release(&line);
> +
> +	if (util)
> +		string_list_append(list, buf.buf)->util = util;
> +	strbuf_release(&buf);
> +
> +	if (finish_command(&cp))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int patch_util_cmp(const void *dummy, const struct patch_util *a,
> +		     const struct patch_util *b, const char *keydata)
> +{
> +	return strcmp(a->diff, keydata ? keydata : b->diff);
> +}
> +
> +static void find_exact_matches(struct string_list *a, struct string_list *b)
> +{
> +	struct hashmap map;
> +	int i;
> +
> +	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
> +
> +	/* First, add the patches of a to a hash map */
> +	for (i = 0; i < a->nr; i++) {
> +		struct patch_util *util = a->items[i].util;
> +
> +		util->i = i;
> +		util->patch = a->items[i].string;
> +		util->diff = util->patch + util->diff_offset;
> +		hashmap_entry_init(util, strhash(util->diff));
> +		hashmap_add(&map, util);
> +	}
> +
> +	/* Now try to find exact matches in b */
> +	for (i = 0; i < b->nr; i++) {
> +		struct patch_util *util = b->items[i].util, *other;
> +
> +		util->i = i;
> +		util->patch = b->items[i].string;
> +		util->diff = util->patch + util->diff_offset;
> +		hashmap_entry_init(util, strhash(util->diff));
> +		other = hashmap_remove(&map, util, NULL);
> +		if (other) {
> +			if (other->matching >= 0)
> +				BUG("already assigned!");
> +
> +			other->matching = i;
> +			util->matching = other->i;
> +		}
> +	}

One possibly interesting corner case here is what happens when there
are two patches that have the exact same diff, for example in the
pathological case of commit A doing something, commit B reverting
commit A, and then commit C reverting commit B, so it ends up with the
same diff.

Having those same commits unchanged in both ranges (e.g. if a commit
earlier in the range has been changed, and range B has been rebased on
top of that), we'd get the following mapping from range A to range B
for the commits in question:

A -> C
B -> B
C -> A

Which is not quite what I would expect as the user (even though it is
a valid mapping, and it probably doesn't matter too much for the end
result of the range diff, as nothing has changed between the commits
anyway).  So I'm not sure it's worth fixing this, as it is a
pathological case, and nothing really breaks.

> +
> +	hashmap_free(&map, 0);
> +}
> +
> +static void diffsize_consume(void *data, char *line, unsigned long len)
> +{
> +	(*(int *)data)++;
> +}
> +
> +static int diffsize(const char *a, const char *b)
> +{
> +	xpparam_t pp = { 0 };
> +	xdemitconf_t cfg = { 0 };
> +	mmfile_t mf1, mf2;
> +	int count = 0;
> +
> +	mf1.ptr = (char *)a;
> +	mf1.size = strlen(a);
> +	mf2.ptr = (char *)b;
> +	mf2.size = strlen(b);
> +
> +	cfg.ctxlen = 3;
> +	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
> +		return count;
> +
> +	error(_("failed to generate diff"));
> +	return COST_MAX;
> +}
> +
> +static void get_correspondences(struct string_list *a, struct string_list *b,
> +				int creation_factor)
> +{
> +	int n = a->nr + b->nr;
> +	int *cost, c, *a2b, *b2a;
> +	int i, j;
> +
> +	ALLOC_ARRAY(cost, st_mult(n, n));
> +	ALLOC_ARRAY(a2b, n);
> +	ALLOC_ARRAY(b2a, n);
> +
> +	for (i = 0; i < a->nr; i++) {
> +		struct patch_util *a_util = a->items[i].util;
> +
> +		for (j = 0; j < b->nr; j++) {
> +			struct patch_util *b_util = b->items[j].util;
> +
> +			if (a_util->matching == j)
> +				c = 0;
> +			else if (a_util->matching < 0 && b_util->matching < 0)
> +				c = diffsize(a_util->diff, b_util->diff);
> +			else
> +				c = COST_MAX;
> +			cost[i + n * j] = c;
> +		}
> +
> +		c = a_util->matching < 0 ?
> +			a_util->diffsize * creation_factor / 100 : COST_MAX;
> +		for (j = b->nr; j < n; j++)
> +			cost[i + n * j] = c;
> +	}
> +
> +	for (j = 0; j < b->nr; j++) {
> +		struct patch_util *util = b->items[j].util;
> +
> +		c = util->matching < 0 ?
> +			util->diffsize * creation_factor / 100 : COST_MAX;
> +		for (i = a->nr; i < n; i++)
> +			cost[i + n * j] = c;
> +	}
> +
> +	for (i = a->nr; i < n; i++)
> +		for (j = b->nr; j < n; j++)
> +			cost[i + n * j] = 0;
> +
> +	compute_assignment(n, n, cost, a2b, b2a);
> +
> +	for (i = 0; i < a->nr; i++)
> +		if (a2b[i] >= 0 && a2b[i] < b->nr) {
> +			struct patch_util *a_util = a->items[i].util;
> +			struct patch_util *b_util = b->items[a2b[i]].util;
> +
> +			a_util->matching = a2b[i];
> +			b_util->matching = i;

So here we re-assign 'matching' in the struct regardless of whether it
was assigned before while searching for exact matches or not.

Shouldn't diffsize for matching patches also be 0?  So are we doing
the 'find_exact_matches()' bit only as an optimization, or am I
missing some other reason why that is beneficial?

> +		}
> +
> +	free(cost);
> +	free(a2b);
> +	free(b2a);
> +}
> +
> +static const char *short_oid(struct patch_util *util)
> +{
> +	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> +}
> +
> +static void output(struct string_list *a, struct string_list *b)
> +{
> +	int i;
> +
> +	for (i = 0; i < b->nr; i++) {
> +		struct patch_util *util = b->items[i].util, *prev;
> +
> +		if (util->matching < 0)
> +			printf("-: -------- > %d: %s\n",
> +					i + 1, short_oid(util));
> +		else {
> +			prev = a->items[util->matching].util;
> +			printf("%d: %s ! %d: %s\n",
> +			       util->matching + 1, short_oid(prev),
> +			       i + 1, short_oid(util));
> +		}
> +	}
> +
> +	for (i = 0; i < a->nr; i++) {
> +		struct patch_util *util = a->items[i].util;
> +
> +		if (util->matching < 0)
> +			printf("%d: %s < -: --------\n",
> +			       i + 1, short_oid(util));
> +	}
> +}
> +
> +int show_range_diff(const char *range1, const char *range2,
> +		    int creation_factor)
> +{
> +	int res = 0;
> +
> +	struct string_list branch1 = STRING_LIST_INIT_DUP;
> +	struct string_list branch2 = STRING_LIST_INIT_DUP;
> +
> +	if (read_patches(range1, &branch1))
> +		res = error(_("could not parse log for '%s'"), range1);
> +	if (!res && read_patches(range2, &branch2))
> +		res = error(_("could not parse log for '%s'"), range2);
> +
> +	if (!res) {
> +		find_exact_matches(&branch1, &branch2);

Note to self: here we assign the matching member of struct patch_util
for each patch in both ranges to a patch number in the other range if
it is an exact match.

We also assign the patch and diff members, and number the patches
using the 'i' member of struct patch_util.  Let's see if that
numbering is still useful later.

> +		get_correspondences(&branch1, &branch2, creation_factor);

And here we use the linear assignment algorithm to match the rest of
the commits.

> +		output(&branch1, &branch2);

And finally we print the output.  We don't seem to use the util->i
that's assigned for range b (or range 2) anywhere at the moment, which
I was wondering about earlier, so I assume it's there mainly for
symmetry, but it doesn't really hurt other than me wondering what it
was for.

> +	}
> +
> +	string_list_clear(&branch1, 1);
> +	string_list_clear(&branch2, 1);
> +
> +	return res;
> +}
> diff --git a/range-diff.h b/range-diff.h
> new file mode 100644
> index 000000000..dd30449c4
> --- /dev/null
> +++ b/range-diff.h
> @@ -0,0 +1,7 @@
> +#ifndef BRANCH_DIFF_H
> +#define BRANCH_DIFF_H

s/BRANCH/RANGE/ above?

> +int show_range_diff(const char *range1, const char *range2,
> +		    int creation_factor);
> +
> +#endif
> -- 
> gitgitgadget
> 
