Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD1C1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfFMVwB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:52:01 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40593 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:52:01 -0400
Received: by mail-qk1-f202.google.com with SMTP id n5so298607qkf.7
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1HAU9irqmcoJvqFrQM02IGEwrKl5+FnF6F8lxBjn018=;
        b=CnmV6x9SAJYs6pYuVyhyJISdzmOIjbC0wQOgmPwrReLZfywX3dkIu8SDs14ov/eqY7
         bv7WcsROuNt9o20BJBYXNVhV9pAcTroCDutg3IFNTultam8ZuaGsYvDMBcPk8BUVSYo0
         EsdiJsygUGIImlp0akFaD4NCTUw2R86/1n1pej6vKA4rdTD4ljLOn8C9UGQa5LIjSGds
         P2Jvy8zJEyKjPm3ItnOTA+hVTevBK/b66IOaq/QWjetM1ZJED1gwGRwhsU3tTBxS4Qtg
         sEktPn+nCr5I8LxoT/L42z7MHFdNCkkjXJ4eKsl9yUnGkWoNDMvOgVgkWRK7IHaYY051
         MSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1HAU9irqmcoJvqFrQM02IGEwrKl5+FnF6F8lxBjn018=;
        b=a0SEW0ztobe3l96yDEZaz7jmJel6XCOFWGhvTrQKQL62WkGV8FRVzPmZy97Uo3A4r6
         RQEoWKKKR4dVVVCdn+QVH4TloHACyRG/kVhjFVuBYZ6CkkprLPV3cOS6UdMiOPtkNyDk
         SCPchClMVZuL4Jl07pmILzJEG8yTU6+raNy7G37/BKArq9y/kA16h2gY77wG4p0046bz
         IXmUbKO3cjQPrreXR7G+UhbficdkhGAOgX48Yh0+L64JlFEmFlj44yEwfNmVbMdnDlTB
         UnV8lPvvZnMvMoRYPh1htDss2kO2n/+spkC4CEBFK39n2HSdC9GXWhriFxtJlaIXDSvi
         OT8g==
X-Gm-Message-State: APjAAAUyDGga/7+o1MfQ+/c6B3a66jPWCZx3/SeEIIJBR+Aj1/NRoD1k
        qPHh1ZqDFZT1am0zO0QotNF7KXNuA3Xn8YLQMcb2Jy/6VK8br1TwzdFs3LJXPhtcUaacG78JEGX
        kJ1ZBn8uqaJx3O3Mdq9mLn4Lc5yNEhXf01u78V5/lkypA+6ZeVNLYIUTXgM4=
X-Google-Smtp-Source: APXvYqzBb3566pHPD/XS5wL1JhXWBI9Ymq6xopZwey3tJTjmULwXBGgrP50WZ2o3/o8y1N1jD2gemoPEscLc
X-Received: by 2002:a0c:96c4:: with SMTP id b4mr5106454qvd.2.1560462719561;
 Thu, 13 Jun 2019 14:51:59 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:31 -0700
In-Reply-To: <cover.1560462201.git.matvore@google.com>
Message-Id: <cc59be1cefae7a90a3a093105d09a3f253b5459e.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560462201.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 08/10] list-objects-filter-options: allow mult. --filter
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow combining of multiple filters by simply repeating the --filter
flag. Before this patch, the user had to combine them in a single flag
somewhat awkwardly (e.g. --filter=combine:FOO+BAR), including
URL-encoding the individual filters.

To make this work, in the --filter flag parsing callback, rather than
error out when we detect that the filter_options struct is already
populated, we modify it in-place to contain the added sub-filter. The
existing sub-filter becomes the lhs of the combined filter, and the
next sub-filter becomes the rhs. We also have to URL-encode the LHS and
RHS sub-filters.

We can simplify the operation if the LHS is already a combine: filter.
In that case, we just append the URL-encoded RHS sub-filter to the LHS
spec to get the new spec.

Helped-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt  | 16 ++++++
 list-objects-filter-options.c       | 88 +++++++++++++++++++++++++++--
 list-objects-filter-options.h       | 11 ++++
 t/t5616-partial-clone.sh            | 19 +++++++
 t/t6112-rev-list-filters-objects.sh | 46 +++++++++++++--
 transport.c                         |  1 +
 upload-pack.c                       |  2 +
 7 files changed, 173 insertions(+), 10 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ddbc1de43f..7b4116f279 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -730,20 +730,36 @@ specification contained in <path>.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
 any trees or blobs unless included explicitly in the command-line (or
 standard input when --stdin is used). <depth>=1 will include only the
 tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
++
+Multiple '--filter=' flags can be specified to combine filters. Only
+objects which are accepted by every filter are included.
++
+The form '--filter=combine:<filter1>+<filter2>+...<filterN>' can also be
+used to combined several filters, but this is harder than just repeating
+the '--filter' flag and is usually not necessary. Filters are joined by
+'{plus}' and individual filters are %-encoded (i.e. URL-encoded).
+Besides the '{plus}' and '%' characters, the following characters are
+reserved and also must be encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+
+as well as all characters with ASCII code &lt;= `0x20`, which includes
+space and newline.
++
+Other arbitrary characters can also be encoded. For instance,
+'combine:tree:3+blob:none' and 'combine:tree%3A3+blob%3Anone' are
+equivalent.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
 
 --filter-print-omitted::
 	Only useful with `--filter=`; prints a list of the objects omitted
 	by the filter.  Object IDs are prefixed with a ``~'' character.
 
 --missing=<missing-action>::
 	A debug option to help with future "partial clone" development.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c9dd41cd06..ce274b1f35 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,18 +1,19 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
 #include "argv-array.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "trace.h"
 #include "url.h"
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf);
 
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
@@ -168,29 +169,106 @@ static int parse_combine_filter(
 
 cleanup:
 	strbuf_list_free(subspecs);
 	if (result) {
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
-int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
-			      const char *arg)
+static int allow_unencoded(char ch)
+{
+	if (ch <= ' ' || ch == '%' || ch == '+')
+		return 0;
+	return !strchr(RESERVED_NON_WS, ch);
+}
+
+static void filter_spec_append_urlencode(
+	struct list_objects_filter_options *filter, const char *raw)
 {
 	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr_urlencode(&buf, raw, allow_unencoded);
+	trace_printf("Add to combine filter-spec: %s\n", buf.buf);
+	string_list_append(&filter->filter_spec, strbuf_detach(&buf, NULL));
+}
+
+/*
+ * Changes filter_options into an equivalent LOFC_COMBINE filter options
+ * instance. Does not do anything if filter_options is already LOFC_COMBINE.
+ */
+static void transform_to_combine_type(
+	struct list_objects_filter_options *filter_options)
+{
+	assert(filter_options->choice);
+	if (filter_options->choice == LOFC_COMBINE)
+		return;
+	{
+		const int initial_sub_alloc = 2;
+		struct list_objects_filter_options *sub_array =
+			xcalloc(initial_sub_alloc, sizeof(*sub_array));
+		sub_array[0] = *filter_options;
+		memset(filter_options, 0, sizeof(*filter_options));
+		filter_options->sub = sub_array;
+		filter_options->sub_alloc = initial_sub_alloc;
+	}
+	filter_options->sub_nr = 1;
+	filter_options->choice = LOFC_COMBINE;
+	string_list_append(&filter_options->filter_spec, xstrdup("combine:"));
+	filter_spec_append_urlencode(
+		filter_options,
+		list_objects_filter_spec(&filter_options->sub[0]));
+	/*
+	 * We don't need the filter_spec strings for subfilter specs, only the
+	 * top level.
+	 */
+	string_list_clear(&filter_options->sub[0].filter_spec, /*free_util=*/0);
+}
+
+void list_objects_filter_die_if_populated(
+	struct list_objects_filter_options *filter_options)
+{
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
-	string_list_append(&filter_options->filter_spec, xstrdup(arg));
-	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
-		die("%s", buf.buf);
+}
+
+int parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg)
+{
+	struct strbuf errbuf = STRBUF_INIT;
+	int parse_error;
+
+	if (!filter_options->choice) {
+		string_list_append(&filter_options->filter_spec, xstrdup(arg));
+
+		parse_error = gently_parse_list_objects_filter(
+			filter_options, arg, &errbuf);
+	} else {
+		/*
+		 * Make filter_options an LOFC_COMBINE spec so we can trivially
+		 * add subspecs to it.
+		 */
+		transform_to_combine_type(filter_options);
+
+		string_list_append(&filter_options->filter_spec, xstrdup("+"));
+		filter_spec_append_urlencode(filter_options, arg);
+		ALLOC_GROW(filter_options->sub, filter_options->sub_nr + 1,
+			   filter_options->sub_alloc);
+		filter_options = &filter_options->sub[filter_options->sub_nr++];
+		memset(filter_options, 0, sizeof(*filter_options));
+
+		parse_error = gently_parse_list_objects_filter(
+			filter_options, arg, &errbuf);
+	}
+	if (parse_error)
+		die("%s", errbuf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
 	if (unset || !arg) {
 		list_objects_filter_set_no_filter(filter_options);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 1786c80eb4..fe2e4d5649 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -58,20 +58,31 @@ struct list_objects_filter_options {
 	struct list_objects_filter_options *sub;
 
 	/*
 	 * END choice-specific parsed values.
 	 */
 };
 
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
+void list_objects_filter_die_if_populated(
+	struct list_objects_filter_options *filter_options);
+
+/*
+ * Parses the filter spec string given by arg and either (1) simply places the
+ * result in filter_options if it is not yet populated or (2) combines it with
+ * the filter already in filter_options if it is already populated. In the case
+ * of (2), the filter specs are combined as if specified with 'combine:'.
+ *
+ * Dies and prints a user-facing message if an error occurs.
+ */
 int parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9a8f9886b3..11536f4028 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -201,20 +201,39 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	test_line_count = 70 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
 
 	sort -u fetched_types >unique_types.observed &&
 	test_write_lines blob commit tree >unique_types.expected &&
 	test_cmp unique_types.expected unique_types.observed
 '
 
+test_expect_success 'implicitly construct combine: filter with repeated flags' '
+	GIT_TRACE=$(pwd)/trace git clone --bare \
+		--filter=blob:none --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc2 &&
+	grep "trace:.* git pack-objects .*--filter=combine:blob:none+tree:1" \
+		trace &&
+	git -C pc2 rev-list --objects --missing=allow-any HEAD >objects &&
+
+	# We should have gotten some root trees.
+	grep " $" objects &&
+	# Should not have gotten any non-root trees or blobs.
+	! grep " ." objects &&
+
+	xargs -n 1 git -C pc2 cat-file -t <objects >types &&
+	sort -u types >unique_types.actual &&
+	test_write_lines commit tree >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.actual
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
 	test_commit -C src x &&
 	test_config -C src uploadpack.allowfilter 1 &&
 	test_config -C src uploadpack.allowanysha1inwant 1 &&
 
 	# Create a tag pointing to a blob.
 	BLOB=$(echo blob-contents | git -C src hash-object --stdin -w) &&
 	git -C src tag myblob "$BLOB" &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 4523c8f066..fd8aec4b4f 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -357,21 +357,30 @@ test_expect_success 'verify tree:3 includes everything expected' '
 
 test_expect_success 'combine:... for a simple combination' '
 	git -C r3 rev-list --objects --filter=combine:tree:2+blob:none HEAD \
 		>actual &&
 
 	expect_has HEAD "" &&
 	expect_has HEAD~1 "" &&
 	expect_has HEAD dir1 &&
 
 	# There are also 2 commit objects
-	test_line_count = 5 actual
+	test_line_count = 5 actual &&
+
+	cp actual expected &&
+
+	# Try again using repeated --filter - this is equivalent to a manual
+	# combine with "combine:...+..."
+	git -C r3 rev-list --objects --filter=combine:tree:2 \
+		--filter=blob:none HEAD >actual &&
+
+	test_cmp expected actual
 '
 
 test_expect_success 'combine:... with URL encoding' '
 	git -C r3 rev-list --objects \
 		--filter=combine:tree%3a2+blob:%6Eon%65 HEAD >actual &&
 
 	expect_has HEAD "" &&
 	expect_has HEAD~1 "" &&
 	expect_has HEAD dir1 &&
 
@@ -423,24 +432,26 @@ test_expect_success 'combine:... with edge-case hex digits: Ff Aa 0 9' '
 	git -C r3 rev-list --objects --filter="combine:tree%3A2+blob%3anone" \
 		HEAD >actual &&
 	test_line_count = 5 actual &&
 	git -C r3 rev-list --objects --filter="combine:tree:%30" HEAD >actual &&
 	test_line_count = 2 actual &&
 	git -C r3 rev-list --objects --filter="combine:tree:%39+blob:none" \
 		HEAD >actual &&
 	test_line_count = 5 actual
 '
 
-test_expect_success 'add a sparse pattern blob whose path has reserved chars' '
+test_expect_success 'add sparse pattern blobs whose paths have reserved chars' '
 	cp r3/pattern r3/pattern1+renamed% &&
-	git -C r3 add pattern1+renamed% &&
-	git -C r3 commit -m "add sparse pattern file with reserved chars"
+	cp r3/pattern "r3/p;at%ter+n" &&
+	cp r3/pattern r3/^~pattern &&
+	git -C r3 add pattern1+renamed% "p;at%ter+n" ^~pattern &&
+	git -C r3 commit -m "add sparse pattern files with reserved chars"
 '
 
 test_expect_success 'combine:... with more than two sub-filters' '
 	git -C r3 rev-list --objects \
 		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern \
 		HEAD >actual &&
 
 	expect_has HEAD "" &&
 	expect_has HEAD~1 "" &&
 	expect_has HEAD~2 "" &&
@@ -451,21 +462,46 @@ test_expect_success 'combine:... with more than two sub-filters' '
 	# Should also have 3 commits
 	test_line_count = 9 actual &&
 
 	# Try again, this time making sure the last sub-filter is only
 	# URL-decoded once.
 	cp actual expect &&
 
 	git -C r3 rev-list --objects \
 		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern1%2brenamed%25 \
 		HEAD >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	# Use the same composite filter again, but with a pattern file name that
+	# requires encoding multiple characters, and use implicit filter
+	# combining.
+	test_when_finished "rm -f trace1" &&
+	GIT_TRACE=$(pwd)/trace1 git -C r3 rev-list --objects \
+		--filter=tree:3 --filter=blob:limit=40 \
+		--filter=sparse:oid="master:p;at%ter+n" \
+		HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "Add to combine filter-spec: sparse:oid=master:p%3bat%25ter%2bn" \
+		trace1 &&
+
+	# Repeat the above test, but this time, the characters to encode are in
+	# the LHS of the combined filter.
+	test_when_finished "rm -f trace2" &&
+	GIT_TRACE=$(pwd)/trace2 git -C r3 rev-list --objects \
+		--filter=sparse:oid=master:^~pattern \
+		--filter=tree:3 --filter=blob:limit=40 \
+		HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "Add to combine filter-spec: sparse:oid=master:%5e%7epattern" \
+		trace2
 '
 
 # Test provisional omit collection logic with a repo that has objects appearing
 # at multiple depths - first deeper than the filter's threshold, then shallow.
 
 test_expect_success 'setup r4' '
 	git init r4 &&
 
 	echo foo > r4/foo &&
 	mkdir r4/subdir &&
diff --git a/transport.c b/transport.c
index f1fcd2c4b0..ee7dd1c062 100644
--- a/transport.c
+++ b/transport.c
@@ -217,20 +217,21 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
 		opts->from_promisor = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
 		opts->no_dependents = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_LIST_OBJECTS_FILTER)) {
+		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
 	}
 	return 1;
 }
 
 static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
diff --git a/upload-pack.c b/upload-pack.c
index a74d293fef..dda2ac6f44 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -876,20 +876,21 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 		if (process_deepen(reader->line, &depth))
 			continue;
 		if (process_deepen_since(reader->line, &deepen_since, &deepen_rev_list))
 			continue;
 		if (process_deepen_not(reader->line, &deepen_not, &deepen_rev_list))
 			continue;
 
 		if (skip_prefix(reader->line, "filter ", &arg)) {
 			if (!filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
+			list_objects_filter_die_if_populated(&filter_options);
 			parse_list_objects_filter(&filter_options, arg);
 			continue;
 		}
 
 		if (!skip_prefix(reader->line, "want ", &arg) ||
 		    parse_oid_hex(arg, &oid_buf, &features))
 			die("git upload-pack: protocol error, "
 			    "expected to get object ID, not '%s'", reader->line);
 
 		if (parse_feature_request(features, "deepen-relative"))
@@ -1297,20 +1298,21 @@ static void process_args(struct packet_reader *request,
 			continue;
 		if (process_deepen_not(arg, &data->deepen_not,
 				       &data->deepen_rev_list))
 			continue;
 		if (!strcmp(arg, "deepen-relative")) {
 			data->deepen_relative = 1;
 			continue;
 		}
 
 		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
+			list_objects_filter_die_if_populated(&filter_options);
 			parse_list_objects_filter(&filter_options, p);
 			continue;
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
 		     allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
 		}
-- 
2.21.0

