Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA71380FD8
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411929; cv=none; b=AsJkBtfcoT0CvqA5FQyt0N9L0XrOp30Hl0+sdnXGve8xe+N0XlL/4PGVsmLunD29zSPSPWEZTxkxBs4VwiEsxlb/juyHO+y4OR6dusV2vaGiZram+BPrPcpjYcWWihjuL77OyTr3vmGcmWpBF+9L1vDJJsG8yodkVVVqyLej5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411929; c=relaxed/simple;
	bh=csVCiG2WdVhNx/LmoHIhVtZvflMvujlSbQnYNaRK4ZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gMcfSMrGTKnxU/oby+lbc6e6Y1DnSqoc63TCRKvT7sTuDYx4dwqz0FmGI4xOQe1Lo6aCr5H90U6XYXuBOH/tPxSa6PQNgmy0jGH0icWRm3EoANBdvm0GNFUC0FZ952mu93ZfVBnMeUPJ9hQG4H67lhMAeHgoyTlPraIl7ZkCBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKibPjSN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKibPjSN"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936e393176fso159354085a.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411923; x=1789016723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tkpRAaD0rHCfmDN8jgGDcYdYNB5IyoybNibHqZUj9IU=;
        b=EKibPjSNSD4RzWTyTyZpOj2PT2XZE6W/tCU7F394gfnyqENOvGddgsqtDuGyT9mvUy
         i71VXcpFTgjHaP9yySPwmZCz9OYyManYROp5RhZD2raPevxVDUwkGfMSjouyBbnF8dW7
         aKrUT6itQr4dnPb7eIzo5FM5/ALfGaXczc904F5TR1WWy9rYTHITmzRI2c3HFoDwxf6m
         aa+59KzjiSIqvMfRRtHBpbaouAzaxfs15S/bzZ5wpwjjhrd6PZ8gtEInXNMgY9Ef4TqA
         amNbsJePSHfZlqIHQs/QAq704x+VwmXJxR68e9ySae93E4BA6Mgz9L5gpoDBuFpOJsjU
         /VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411923; x=1789016723;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkpRAaD0rHCfmDN8jgGDcYdYNB5IyoybNibHqZUj9IU=;
        b=tHgZQY9N/hFRYh92b4ijqzc2DKPV0MAGuXzgTCqPQUg0UZlPm6pEWNbqksokjru7yo
         ugECl+o14vPbpSYtUKFsq6n6DTzpyh5d6reltQZJjUBF9IZT6cs1Y+/pV3St1MG2MwyV
         o9RWpP6qlX1xJfniEdMT3F1OUotC7LyObeYgHF7GoSO1Q8TV/9XEzyvbs+0d48IYurUj
         L8N4KEaGRxPPkA5FSBXH5rwulU/R6aWTggkc7LgJIUvffwGB2g++znTLGjCp9JrLkRVv
         Vcacw0TkLwmhyzPSb5In/a1OBIRZtdbSEVIQd/QTqrYbQz0zFKyFWD+UxKo4MAqS3Jds
         FVTQ==
X-Gm-Message-State: AFuF++njZUloHZtBHcbQxOxE+K5Gkt8wy+IG3/c/JTACY1XdAboTYIsm
	oqDVwfZrK9j8z2yW9cT8r7gU61LyDSdW50X259/jD88VHEKOE0LNmZ/mMVEG31MD
X-Gm-Gg: AYBFou0SaCa1JPiHQ040gHsOyGFwcIVcZzuj0ESiRQuK1VdhS7H9UvxJRhxhprjP4+V
	KVP3/cRAU6Vnf4TZ/isOO+0jXZqrmY7+yr/wLUemA4qgqch0FR7kBq1Nudzi17ZSqLFOyN8My/0
	DKu9lopClEWs2kLAO2PdtVaFjXKjGEY8Kr+OpLzV9hr8s+KVmVVJStH200ZC+vwRJvrB9e/lTSa
	MlQGRbM/rJJ2JvtlSS2n6wGt4EfASGM5m3wXb6IARekgwKJBpT1LVnu3XZ1NWff+30T33pxQSLl
	fr2sbqqrDof0bq2A4QPfPxhbV0XEXB1Qd4IC2JiRk48FDVZ7jsFia1Ma283ut2qDDv/aYNoM0z4
	wDM7aI33NIGGvzJ4v0blyYbwSwUrw/GjZoFNce0iGtO5U3alJ2REefMLxFQ7Hp38flPIKwsbTGu
	m+EvEmjQasztg8b1QqIR/6vsDqT3GwtMVwYCNwXmAity1Y3lPml2pQVpz/7tXRlkKc
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id af79cd13be357-93960ccd7b1mr1221521885a.8.1788411921362;
        Wed, 02 Sep 2026 22:05:21 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm409179585a.16.2026.09.02.22.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:20 -0700 (PDT)
Message-Id: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:12 +0000
Subject: [PATCH v3 0/7] line-log: scope stat, check, and -G to -L line ranges
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

Teach -L to work with the --stat family of options and --check. Also, teach
-G to search within the line ranges specified by -L. This series continues
the previous work[1][2] extending -L to work with more diff options, and,
for example, enables:

Reviewing the --stat history of a single function:

$ git log --oneline -L:strbuf_grow:strbuf.c --stat
c13d0f7bd4 strbuf: use st_add3() in strbuf_grow()
 strbuf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
...
b449f4cfc9 Rework strbuf API and semantics.
 strbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)


Finding where a pattern changed inside one function with -G, while ignoring
matches elsewhere in the file:

$ git log --oneline -L:run_builtin:git.c -G RUN_SETUP
e5b17bda8b git: ensure correct git directory setup with -h
27bd38d4e5 git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive
...
47d0b4ff57 Clean up internal command handling


The first 4 commits are preparatory cleanup for the main feature changes and
could potentially be separated. The last 3 commits implement the new
features.

Patches:

 1. Rename line_range_callback to line_range_filter to more accurately
    reflect its role as a general filter for other diff features. Also,
    replace verbose comments with descriptive field and variable names.
 2. Simplify line-range filtering logic, which fixes a bug as a result.
 3. Make -L diff hunk header format consistent with default mode's header
    format for all cases by exposing xdiff's header generating function.
 4. Extract a line-range diff helper so the --stat, --check, and -G support
    can reuse it.
 5. Enable support for --stat family of options.
 6. Enable support for --check.
 7. Teach -G to search within -L line ranges.

Changes since v2:

 * Rewrite all prose in series from scratch to remove significant verbosity
   and extraneous detail that makes the series hard to reason about. Replace
   block comments with descriptive field and variable names.
 * Pare down and simplify some test implementations.
 * No other logical behavior changes.

[1]
https://lore.kernel.org/git/pull.2094.v3.git.1780001267.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.2099.git.1777230630020.gitgitgadget@gmail.com/

Cc: "D. Ben Knoble" ben.knoble@gmail.com

Michael Montalbo (7):
  diff: rename line-range filter struct and clarify fields
  diff: simplify the line-range filter by classifying removals
    immediately
  diff: emit -L hunk headers via xdiff's formatter
  diff: extract a line-range diff helper for reuse
  diff: support stat formats with -L
  diff: support --check with -L line ranges
  diffcore-pickaxe: limit -G to the -L tracked range

 Documentation/line-range-options.adoc    |  15 +-
 diff.c                                   | 422 +++++++++++------------
 diffcore-pickaxe.c                       |  30 +-
 revision.c                               |   6 +-
 t/t4211-line-log.sh                      | 325 +++++++++++++++--
 t/t4211/sha1/expect.no-assertion-error   |   2 +-
 t/t4211/sha1/expect.vanishes-early       |   6 +-
 t/t4211/sha256/expect.no-assertion-error |   2 +-
 t/t4211/sha256/expect.vanishes-early     |   6 +-
 xdiff-interface.c                        |  19 +
 xdiff-interface.h                        |  23 ++
 11 files changed, 588 insertions(+), 268 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2152%2Fmmontalbo%2Fmm%2Fline-log-stat-formats-followup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2152/mmontalbo/mm/line-log-stat-formats-followup-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2152

Range-diff vs v2:

 1:  6cfaccab92 ! 1:  331c6c92f3 diff: rename and group the line-range filter for clarity
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    diff: rename and group the line-range filter for clarity
     +    diff: rename line-range filter struct and clarify fields
      
     -    The line-range filter that mm/line-log-cleanup added uses names that
     -    obscure its model.  The cursors lno_post/lno_pre and the index lno_0
     -    share an lno_ prefix but conflate the pre/post-image axis with the
     -    0-based/1-based axis, the hunk state is a flat set of rhunk_* fields,
     -    and the filter-state pointer is just s.
     +    diff's line-range filtering logic uses the line_range_callback
     +    struct to represent filtering state. However, this name does not
     +    clearly reflect the role it plays. This is especially relevant as
     +    we expand diff's line-range filtering to work with more options,
     +    including --stat and -G.
      
     -    The filter bridges two layers of diff.c, and its fields already used
     -    each layer's vocabulary, but in cryptic abbreviations.  Spell them out
     -    to the form the rest of the file uses, so that the patches that follow
     -    can simplify and fix it with those clearer names in place:
     +    Also, line_range_callback's fields are terse, while the comment
     +    explaining line_range_callback is verbose and out of place compared to
     +    its surroundings.
      
     -      - lno_post/lno_pre -> lno_in_postimage/lno_in_preimage, the
     -        line-number cursors, matching the counters in struct emit_callback
     -      - lno_0 -> idx_in_postimage, the 0-based range index
     -      - the hunk-header geometry stays old/new (old_begin, new_begin, and
     -        counts) to match the xdiff_emit_hunk_fn callback and the
     -        "@@ -<old> +<new> @@" header it feeds, but moves from flat rhunk_*
     -        fields into a "hunk" sub-struct, so accesses read
     -        filter->hunk.old_begin
     -      - flush_rhunk -> flush_range_hunk
     -      - the filter-state pointer in each callback: s -> filter
     +    Rename line_range_callback to line_range_filter, and replace the verbose
     +    comment with a concise one, instead preferring descriptive field and
     +    variable names that are self-explanatory over comments.
      
     -    Also rename the struct line_range_callback to line_range_filter: it is
     -    a filter over xdiff output, not merely a callback.
     -
     -    No behavior change.
     +    No logical behavior change. Some fields are grouped under a new struct
     +    in the newly renamed line_range_filter. Everything else is just a
     +    rename.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## diff.c ##
      @@ diff.c: struct emit_callback {
     -  * reveals whether they precede an in-range line (flush into range hunk) or
     -  * an out-of-range line (discard).
     + };
     + 
     + /*
     +- * State for the line-range callback wrappers that sit between
     +- * xdi_diff_outf() and fn_out_consume().  xdiff produces a normal,
     +- * unfiltered diff; the wrappers intercept each hunk header and line,
     +- * track post-image position, and forward only lines that fall within
     +- * the requested ranges.  Contiguous in-range lines are collected into
     +- * range hunks and flushed with a synthetic @@ header so that
     +- * fn_out_consume() sees well-formed unified-diff fragments.
     +- *
     +- * Removal lines ('-') cannot be classified by post-image position, so
     +- * they are buffered in pending_rm until the next '+' or ' ' line
     +- * reveals whether they precede an in-range line (flush into range hunk) or
     +- * an out-of-range line (discard).
     ++ * Filter the line ranges that are emitted by diff.
        */
      -struct line_range_callback {
      +struct line_range_filter {
       	xdiff_emit_line_fn orig_line_fn;
       	void *orig_cb_data;
     - 	const struct range_set *ranges;	/* 0-based [start, end) */
     - 	unsigned int cur_range;		/* index into the range_set */
     - 
     - 	/* Post/pre-image line counters (1-based, set from hunk headers) */
     +-	const struct range_set *ranges;	/* 0-based [start, end) */
     +-	unsigned int cur_range;		/* index into the range_set */
     +-
     +-	/* Post/pre-image line counters (1-based, set from hunk headers) */
      -	long lno_post;
      -	long lno_pre;
     -+	long lno_in_postimage;
     -+	long lno_in_preimage;
     - 
     - 	/*
     - 	 * Function name from most recent xdiff hunk header;
     -@@ diff.c: struct line_range_callback {
     - 	char func[80];
     - 	long funclen;
     - 
     ++	const struct range_set *range_sets_to_filter_by;
     ++	unsigned int range_set_idx;
     ++
     ++	struct {
     ++		char func_name[80];
     ++		long func_name_len;
     ++		long old_begin, old_count;
     ++		long new_begin, new_count;
     ++		long lno_in_preimage;
     ++		long lno_in_postimage;
     ++		struct strbuf lines;
     ++		int active;
     ++		int has_changes;
     ++	} accumulating_hunk;
     + 
     +-	/*
     +-	 * Function name from most recent xdiff hunk header;
     +-	 * size matches struct func_line.buf in xdiff/xemit.c.
     +-	 */
     +-	char func[80];
     +-	long funclen;
     +-
      -	/* Range hunk being accumulated for the current range */
      -	struct strbuf rhunk;
      -	long rhunk_old_begin, rhunk_old_count;
      -	long rhunk_new_begin, rhunk_new_count;
      -	int rhunk_active;
      -	int rhunk_has_changes;		/* any '+' or '-' lines? */
     -+	/* The range hunk being accumulated for the current range. */
     -+	struct {
     -+		struct strbuf lines;	/* buffered in-range diff lines */
     -+		long old_begin, old_count;
     -+		long new_begin, new_count;
     -+		int active;
     -+		int has_changes;	/* any '+' or '-' line? */
     -+	} hunk;
     - 
     - 	/* Removal lines not yet known to be in-range */
     +-
     +-	/* Removal lines not yet known to be in-range */
       	struct strbuf pending_rm;
     + 	int pending_rm_count;
     +-	long pending_rm_pre_begin;	/* pre-image line of first pending */
     ++	long pending_rm_pre_begin;
     + 
     +-	int ret;			/* latched error from orig_line_fn */
     ++	int ret;
     + };
     + 
     + static int count_lines(const char *data, int size)
      @@ diff.c: static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
       	return 1;
       }
     @@ diff.c: static int quick_consume(void *priv, char *line UNUSED, unsigned long le
      +static void flush_range_hunk(struct line_range_filter *filter)
       {
       	struct strbuf hdr = STRBUF_INIT;
     - 	const char *p, *end;
     +-	const char *p, *end;
     ++	const char *line_buf, *line_buf_end;
       
      -	if (!s->rhunk_active || s->ret)
     -+	if (!filter->hunk.active || filter->ret)
     ++	if (!filter->accumulating_hunk.active || filter->ret)
       		return;
       
     - 	/* Drain any pending removal lines into the range hunk */
     +-	/* Drain any pending removal lines into the range hunk */
      -	if (s->pending_rm_count) {
      -		strbuf_addbuf(&s->rhunk, &s->pending_rm);
      -		s->rhunk_old_count += s->pending_rm_count;
      -		s->rhunk_has_changes = 1;
      -		discard_pending_rm(s);
      +	if (filter->pending_rm_count) {
     -+		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
     -+		filter->hunk.old_count += filter->pending_rm_count;
     -+		filter->hunk.has_changes = 1;
     ++		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
     ++		filter->accumulating_hunk.old_count += filter->pending_rm_count;
     ++		filter->accumulating_hunk.has_changes = 1;
      +		discard_pending_rm(filter);
       	}
       
     - 	/*
     -@@ diff.c: static void flush_rhunk(struct line_range_callback *s)
     - 	 * ctxlen causes xdiff to emit context covering a range that
     - 	 * has no changes in this commit.
     - 	 */
     +-	/*
     +-	 * Suppress context-only hunks: they contain no actual changes
     +-	 * and would just be noise.  This can happen when the inflated
     +-	 * ctxlen causes xdiff to emit context covering a range that
     +-	 * has no changes in this commit.
     +-	 */
      -	if (!s->rhunk_has_changes) {
      -		s->rhunk_active = 0;
      -		strbuf_reset(&s->rhunk);
     -+	if (!filter->hunk.has_changes) {
     -+		filter->hunk.active = 0;
     -+		strbuf_reset(&filter->hunk.lines);
     ++	if (!filter->accumulating_hunk.has_changes) {
     ++		filter->accumulating_hunk.active = 0;
     ++		strbuf_reset(&filter->accumulating_hunk.lines);
       		return;
       	}
       
     @@ diff.c: static void flush_rhunk(struct line_range_callback *s)
      -		    s->rhunk_old_begin, s->rhunk_old_count,
      -		    s->rhunk_new_begin, s->rhunk_new_count);
      -	if (s->funclen > 0) {
     -+		    filter->hunk.old_begin, filter->hunk.old_count,
     -+		    filter->hunk.new_begin, filter->hunk.new_count);
     -+	if (filter->funclen > 0) {
     ++		    filter->accumulating_hunk.old_begin, filter->accumulating_hunk.old_count,
     ++		    filter->accumulating_hunk.new_begin, filter->accumulating_hunk.new_count);
     ++	if (filter->accumulating_hunk.func_name_len > 0) {
       		strbuf_addch(&hdr, ' ');
      -		strbuf_add(&hdr, s->func, s->funclen);
     -+		strbuf_add(&hdr, filter->func, filter->funclen);
     ++		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
     ++	     filter->accumulating_hunk.func_name_len);
       	}
       	strbuf_addch(&hdr, '\n');
       
     @@ diff.c: static void flush_rhunk(struct line_range_callback *s)
      +	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
       	strbuf_release(&hdr);
       
     - 	/*
     -@@ diff.c: static void flush_rhunk(struct line_range_callback *s)
     - 	 * The cast discards const because xdiff_emit_line_fn takes
     - 	 * char *, though fn_out_consume does not modify the buffer.
     - 	 */
     +-	/*
     +-	 * Replay buffered lines one at a time through fn_out_consume.
     +-	 * The cast discards const because xdiff_emit_line_fn takes
     +-	 * char *, though fn_out_consume does not modify the buffer.
     +-	 */
      -	p = s->rhunk.buf;
      -	end = p + s->rhunk.len;
      -	while (!s->ret && p < end) {
     -+	p = filter->hunk.lines.buf;
     -+	end = p + filter->hunk.lines.len;
     -+	while (!filter->ret && p < end) {
     - 		const char *eol = memchr(p, '\n', end - p);
     - 		unsigned long line_len = eol ? (unsigned long)(eol - p + 1)
     - 					     : (unsigned long)(end - p);
     +-		const char *eol = memchr(p, '\n', end - p);
     +-		unsigned long line_len = eol ? (unsigned long)(eol - p + 1)
     +-					     : (unsigned long)(end - p);
      -		s->ret = s->orig_line_fn(s->orig_cb_data, (char *)p, line_len);
     -+		filter->ret = filter->orig_line_fn(filter->orig_cb_data, (char *)p, line_len);
     - 		p += line_len;
     +-		p += line_len;
     ++	line_buf = filter->accumulating_hunk.lines.buf;
     ++	line_buf_end = line_buf + filter->accumulating_hunk.lines.len;
     ++	while (!filter->ret && line_buf < line_buf_end) {
     ++		const char *eol = memchr(line_buf, '\n', line_buf_end - line_buf);
     ++		unsigned long line_len = eol ? (unsigned long)(eol - line_buf + 1)
     ++					     : (unsigned long)(line_buf_end - line_buf);
     ++		filter->ret = filter->orig_line_fn(filter->orig_cb_data,
     ++				     (char *)line_buf, line_len);
     ++		line_buf += line_len;
       	}
       
      -	s->rhunk_active = 0;
      -	strbuf_reset(&s->rhunk);
     -+	filter->hunk.active = 0;
     -+	strbuf_reset(&filter->hunk.lines);
     ++	filter->accumulating_hunk.active = 0;
     ++	strbuf_reset(&filter->accumulating_hunk.lines);
       }
       
       static void line_range_hunk_fn(void *data,
     @@ diff.c: static void line_range_hunk_fn(void *data,
      -	struct line_range_callback *s = data;
      +	struct line_range_filter *filter = data;
       
     - 	/*
     - 	 * When count > 0, begin is 1-based.  When count == 0, begin is
     -@@ diff.c: static void line_range_hunk_fn(void *data,
     - 	 * flush or discard them when the next content line reveals
     - 	 * whether the removals precede in-range content.
     - 	 */
     +-	/*
     +-	 * When count > 0, begin is 1-based.  When count == 0, begin is
     +-	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
     +-	 * that type will arrive, so the value is unused.
     +-	 *
     +-	 * Any pending removal lines from the previous xdiff hunk are
     +-	 * intentionally left in pending_rm: the line callback will
     +-	 * flush or discard them when the next content line reveals
     +-	 * whether the removals precede in-range content.
     +-	 */
      -	s->lno_post = new_begin;
      -	s->lno_pre = old_begin;
     -+	filter->lno_in_postimage = new_begin;
     -+	filter->lno_in_preimage = old_begin;
     ++	filter->accumulating_hunk.lno_in_postimage = new_begin;
     ++	filter->accumulating_hunk.lno_in_preimage = old_begin;
       
       	if (funclen > 0) {
      -		if (funclen > (long)sizeof(s->func))
      -			funclen = sizeof(s->func);
      -		memcpy(s->func, func, funclen);
     -+		if (funclen > (long)sizeof(filter->func))
     -+			funclen = sizeof(filter->func);
     -+		memcpy(filter->func, func, funclen);
     ++		if (funclen > (long)sizeof(filter->accumulating_hunk.func_name))
     ++			funclen = sizeof(filter->accumulating_hunk.func_name);
     ++		memcpy(filter->accumulating_hunk.func_name, func, funclen);
       	}
      -	s->funclen = funclen;
     -+	filter->funclen = funclen;
     ++	filter->accumulating_hunk.func_name_len = funclen;
       }
       
       static int line_range_line_fn(void *priv, char *line, unsigned long len)
     @@ diff.c: static void line_range_hunk_fn(void *data,
      -		s->pending_rm_count++;
      -		return s->ret;
      +		if (!filter->pending_rm_count)
     -+			filter->pending_rm_pre_begin = filter->lno_in_preimage;
     -+		filter->lno_in_preimage++;
     ++			filter->pending_rm_pre_begin =
     ++				filter->accumulating_hunk.lno_in_preimage;
     ++		filter->accumulating_hunk.lno_in_preimage++;
      +		strbuf_add(&filter->pending_rm, line, len);
      +		filter->pending_rm_count++;
      +		return filter->ret;
     @@ diff.c: static void line_range_hunk_fn(void *data,
      -			strbuf_add(&s->pending_rm, line, len);
      -		else if (s->rhunk_active)
      -			strbuf_add(&s->rhunk, line, len);
     +-		/* otherwise outside tracked range; drop silently */
     +-		return s->ret;
      +		if (filter->pending_rm_count)
      +			strbuf_add(&filter->pending_rm, line, len);
     -+		else if (filter->hunk.active)
     -+			strbuf_add(&filter->hunk.lines, line, len);
     - 		/* otherwise outside tracked range; drop silently */
     --		return s->ret;
     ++		else if (filter->accumulating_hunk.active)
     ++			strbuf_add(&filter->accumulating_hunk.lines, line, len);
      +		return filter->ret;
       	}
       
     @@ diff.c: static void line_range_hunk_fn(void *data,
      -	lno_0 = s->lno_post - 1;
      -	cur_pre = s->lno_pre;	/* save before advancing for context lines */
      -	s->lno_post++;
     -+	idx_in_postimage = filter->lno_in_postimage - 1;
     -+	cur_pre = filter->lno_in_preimage;	/* save before advancing for context lines */
     -+	filter->lno_in_postimage++;
     ++	idx_in_postimage = filter->accumulating_hunk.lno_in_postimage - 1;
     ++	cur_pre = filter->accumulating_hunk.lno_in_preimage;
     ++	filter->accumulating_hunk.lno_in_postimage++;
       	if (line[0] == ' ')
      -		s->lno_pre++;
     -+		filter->lno_in_preimage++;
     ++		filter->accumulating_hunk.lno_in_preimage++;
       
     - 	/* Advance past ranges we've passed */
     +-	/* Advance past ranges we've passed */
      -	while (s->cur_range < s->ranges->nr &&
      -	       lno_0 >= s->ranges->ranges[s->cur_range].end) {
      -		if (s->rhunk_active)
      -			flush_rhunk(s);
      -		discard_pending_rm(s);
      -		s->cur_range++;
     -+	while (filter->cur_range < filter->ranges->nr &&
     -+	       idx_in_postimage >= filter->ranges->ranges[filter->cur_range].end) {
     -+		if (filter->hunk.active)
     ++	while (filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
     ++	       idx_in_postimage >=
     ++		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end) {
     ++		if (filter->accumulating_hunk.active)
      +			flush_range_hunk(filter);
      +		discard_pending_rm(filter);
     -+		filter->cur_range++;
     ++		filter->range_set_idx++;
       	}
       
     - 	/* Past all ranges */
     +-	/* Past all ranges */
      -	if (s->cur_range >= s->ranges->nr) {
      -		discard_pending_rm(s);
      -		return s->ret;
     -+	if (filter->cur_range >= filter->ranges->nr) {
     ++	if (filter->range_set_idx >= filter->range_sets_to_filter_by->nr) {
      +		discard_pending_rm(filter);
      +		return filter->ret;
       	}
       
      -	cur = &s->ranges->ranges[s->cur_range];
     -+	cur = &filter->ranges->ranges[filter->cur_range];
     ++	cur = &filter->range_sets_to_filter_by->ranges[filter->range_set_idx];
       
     - 	/* Before current range */
     +-	/* Before current range */
      -	if (lno_0 < cur->start) {
      -		discard_pending_rm(s);
      -		return s->ret;
     @@ diff.c: static void line_range_hunk_fn(void *data,
      +		return filter->ret;
       	}
       
     - 	/* In range so start a new range hunk if needed */
     +-	/* In range so start a new range hunk if needed */
      -	if (!s->rhunk_active) {
      -		s->rhunk_active = 1;
      -		s->rhunk_has_changes = 0;
     @@ diff.c: static void line_range_hunk_fn(void *data,
      -		s->rhunk_old_count = 0;
      -		s->rhunk_new_count = 0;
      -		strbuf_reset(&s->rhunk);
     -+	if (!filter->hunk.active) {
     -+		filter->hunk.active = 1;
     -+		filter->hunk.has_changes = 0;
     -+		filter->hunk.new_begin = idx_in_postimage + 1;
     -+		filter->hunk.old_begin = filter->pending_rm_count
     ++	if (!filter->accumulating_hunk.active) {
     ++		filter->accumulating_hunk.active = 1;
     ++		filter->accumulating_hunk.has_changes = 0;
     ++		filter->accumulating_hunk.new_begin = idx_in_postimage + 1;
     ++		filter->accumulating_hunk.old_begin = filter->pending_rm_count
      +			? filter->pending_rm_pre_begin : cur_pre;
     -+		filter->hunk.old_count = 0;
     -+		filter->hunk.new_count = 0;
     -+		strbuf_reset(&filter->hunk.lines);
     ++		filter->accumulating_hunk.old_count = 0;
     ++		filter->accumulating_hunk.new_count = 0;
     ++		strbuf_reset(&filter->accumulating_hunk.lines);
       	}
       
     - 	/* Flush pending removals into range hunk */
     +-	/* Flush pending removals into range hunk */
      -	if (s->pending_rm_count) {
      -		strbuf_addbuf(&s->rhunk, &s->pending_rm);
      -		s->rhunk_old_count += s->pending_rm_count;
      -		s->rhunk_has_changes = 1;
      -		discard_pending_rm(s);
      +	if (filter->pending_rm_count) {
     -+		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
     -+		filter->hunk.old_count += filter->pending_rm_count;
     -+		filter->hunk.has_changes = 1;
     ++		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
     ++		filter->accumulating_hunk.old_count += filter->pending_rm_count;
     ++		filter->accumulating_hunk.has_changes = 1;
      +		discard_pending_rm(filter);
       	}
       
      -	strbuf_add(&s->rhunk, line, len);
      -	s->rhunk_new_count++;
     -+	strbuf_add(&filter->hunk.lines, line, len);
     -+	filter->hunk.new_count++;
     ++	strbuf_add(&filter->accumulating_hunk.lines, line, len);
     ++	filter->accumulating_hunk.new_count++;
       	if (line[0] == '+')
      -		s->rhunk_has_changes = 1;
     -+		filter->hunk.has_changes = 1;
     ++		filter->accumulating_hunk.has_changes = 1;
       	else
      -		s->rhunk_old_count++;
     -+		filter->hunk.old_count++;
     ++		filter->accumulating_hunk.old_count++;
       
      -	return s->ret;
      +	return filter->ret;
     @@ diff.c: static void builtin_diff(const char *name_a,
       			unsigned int i;
       			long max_span = 0;
       
     -@@ diff.c: static void builtin_diff(const char *name_a,
     + 			memset(&lr_state, 0, sizeof(lr_state));
       			lr_state.orig_line_fn = fn_out_consume;
       			lr_state.orig_cb_data = &ecbdata;
     - 			lr_state.ranges = line_ranges;
     +-			lr_state.ranges = line_ranges;
      -			strbuf_init(&lr_state.rhunk, 0);
     -+			strbuf_init(&lr_state.hunk.lines, 0);
     ++			lr_state.range_sets_to_filter_by = line_ranges;
     ++			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
       			strbuf_init(&lr_state.pending_rm, 0);
       
       			/*
     @@ diff.c: static void builtin_diff(const char *name_a,
       				die("unable to generate diff for %s",
       				    one->path);
      -			strbuf_release(&lr_state.rhunk);
     -+			strbuf_release(&lr_state.hunk.lines);
     ++			strbuf_release(&lr_state.accumulating_hunk.lines);
       			strbuf_release(&lr_state.pending_rm);
       		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
       					 &ecbdata, &xpp, &xecfg))
 2:  5602b7976a ! 2:  020e07c0ea diff: simplify the line-range filter by classifying removals immediately
     @@ Metadata
       ## Commit message ##
          diff: simplify the line-range filter by classifying removals immediately
      
     -    The filter buffered '-' lines in a pending_rm strbuf, deferring their
     -    classification until a '+' or ' ' line revealed the post-image
     -    position.  That buffering is unnecessary: a removal occupies no
     -    post-image line, so it does not advance lno_in_postimage, and xdiff
     -    emits removals before additions within a change.  A '-' therefore
     -    arrives while lno_in_postimage already holds the index the following
     -    '+'/' ' will occupy, and can be classified against the ranges as it
     -    arrives.
     +    Currently, the diff line-range filter buffers preimage removal lines
     +    until a postimage line arrives. That line's number confirms whether the
     +    preimage line falls in a relevant range. However, storing preimage
     +    lines in a separate buffer is unnecessary. Worse, the logic has a bug:
     +    a preimage line outside the target range is included when it
     +    immediately follows an in-range postimage line.
      
     -    The buffering also hid a bug: flush_range_hunk() drained pending_rm into
     -    the range hunk whenever the hunk was active, even after lno_in_postimage
     -    had advanced past the tracked range, so a deletion just after the
     -    tracked function leaked into the patch.  Classifying each line as it
     -    arrives removes the pending_rm buffer, the discard_pending_rm() helper,
     -    three struct fields, and makes that bug impossible by construction.
     +    Preimage lines will always precede their postimage counterpart both in
     +    content line number and emission order from xdiff's line callback
     +    function. So preimage lines can share the postimage buffer. The filter
     +    flushes them based on whether the postimage lines fall within the
     +    target range.
      
     -    With every line classified on arrival, the buffered lines are the
     -    hunk's single source of truth, so the old/new counts need not be kept
     -    alongside them: flush_range_hunk() derives the counts (and whether the
     -    hunk holds any change) from the buffer when it builds the header.  Drop
     -    the per-line counting and the old_count, new_count, and has_changes
     -    fields; there is no longer a second tally that could fall out of sync
     -    with the buffer.
     +    Remove logic related to storing preimage lines in a separate "removal"
     +    buffer and prepending them to the accumulating_hunk's line buffer.
     +    Instead, store those lines in the accumulating_hunk's line_buffer
     +    immediately and flush everything as appropriate based on postimage
     +    line numbers that arrive. This resolves the bug by construction.
      
     -    Add begin_range_hunk() to open the accumulator at the first in-range
     -    line, seeding both begins from the live image cursors, as the
     -    counterpart to flush_range_hunk().  With the counting gone too,
     -    line_range_line_fn() now only appends an in-range line.
     +    Also, calculate the old and new line counts for the diff hunk header
     +    when flushing rather than storing counters in line_range_filter to
     +    simplify state management further.
      
     -    Document the coordinate model: a block comment on struct
     -    line_range_filter states it (the pre/post-image cursors, the 0-based
     -    idx_in_postimage, removals classified by the following line) with a
     -    worked example.
     -
     -    Add tests for the leaked trailing deletion this fixes, the symmetric
     -    leading-deletion case, and the filter's range boundaries (a change at
     -    the first and last line of a range, and a pure in-range deletion).
     +    Add a test to t/t4211-line-log.sh that verifies the preimage line
     +    emission bug is fixed.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## diff.c ##
     -@@ diff.c: struct emit_callback {
     - };
     - 
     - /*
     -- * State for the line-range callback wrappers that sit between
     -- * xdi_diff_outf() and fn_out_consume().  xdiff produces a normal,
     -- * unfiltered diff; the wrappers intercept each hunk header and line,
     -- * track post-image position, and forward only lines that fall within
     -- * the requested ranges.  Contiguous in-range lines are collected into
     -- * range hunks and flushed with a synthetic @@ header so that
     -- * fn_out_consume() sees well-formed unified-diff fragments.
     -+ * Line-range filter: scopes "git log -L" output to the tracked ranges.
     -  *
     -- * Removal lines ('-') cannot be classified by post-image position, so
     -- * they are buffered in pending_rm until the next '+' or ' ' line
     -- * reveals whether they precede an in-range line (flush into range hunk) or
     -- * an out-of-range line (discard).
     -+ * It sits between xdi_diff_outf() and an output callback (fn_out_consume,
     -+ * diffstat_consume, checkdiff_consume).  xdiff produces a normal diff; the
     -+ * filter forwards only the lines inside the requested ranges, collecting
     -+ * contiguous in-range lines into a "range hunk" emitted with a synthetic
     -+ * @@ header so the callback sees well-formed unified-diff fragments.
     -+ *
     -+ * A diff describes the change from a pre-image to a post-image.  Each
     -+ * line is context (' ', in both), a removal ('-', pre-image only), or
     -+ * an addition ('+', post-image only).  -L tracks ranges in the
     -+ * post-image, so a line is in range by its post-image position.
     -+ *
     -+ * Two 1-based cursors track the next line in each image, named as in
     -+ * struct emit_callback and seeded from the xdiff hunk header:
     -+ *
     -+ *	lno_in_postimage  advances on '+' and ' '   (lines in the post-image)
     -+ *	lno_in_preimage   advances on '-' and ' '   (lines in the pre-image)
     -+ *
     -+ * Ranges are 0-based half-open [start, end), so a line is tested at the
     -+ * 0-based index idx_in_postimage = lno_in_postimage - 1.
     -+ *
     -+ * A '-' is not present in the post-image, so it has no post-image line
     -+ * number of its own.  Since it does not advance lno_in_postimage, it is
     -+ * classified at the idx_in_postimage that the following '+'/' ' will
     -+ * occupy.  xdiff emits a change's removals before its additions, so that
     -+ * index is already known when the '-' arrives.
     -+ *
     -+ * The synthetic "@@ -<old> +<new> @@" header has two sides, old (the
     -+ * pre-image) and new (the post-image), matching the xdiff_emit_hunk_fn
     -+ * callback; the hunk.old_begin / hunk.new_begin fields below hold those
     -+ * begins, and flush_range_hunk() derives the counts from the buffered
     -+ * lines.
     -+ *
     -+ * Example, tracking post-image line 2 (range [1, 2)) of:
     -+ *
     -+ *	pre-image  post-image
     -+ *	1 a        1 a
     -+ *	2 b        2 X      (b -> X)
     -+ *	3 c        3 c
     -+ *
     -+ *	classify each line by idx_in_postimage.  The pre and post columns
     -+ *	are each cursor's value while that line is classified, i.e. before
     -+ *	the line advances them (pre = lno_in_preimage,
     -+ *	post = lno_in_postimage, idx = idx_in_postimage):
     -+ *	' a'  pre 1  post 1  idx 0  ->  before start, skip
     -+ *	'-b'  pre 2  post 2  idx 1  ->  keep (removal)
     -+ *	'+X'  pre 3  post 2  idx 1  ->  keep (addition)
     -+ *	' c'  pre 3  post 3  idx 2  ->  past end, flush
     -+ *
     -+ * -b and +X share idx = 1 because -b did not advance lno_in_postimage;
     -+ * both land in the range hunk, flushed when ' c' crosses the range end.
     -  */
     - struct line_range_filter {
     - 	xdiff_emit_line_fn orig_line_fn;
      @@ diff.c: struct line_range_filter {
     - 	char func[80];
     - 	long funclen;
     - 
     --	/* The range hunk being accumulated for the current range. */
     -+	/*
     -+	 * The range hunk being accumulated.  At most one is live at a time:
     -+	 * it is flushed and reset as the cursor leaves each range (and once
     -+	 * more at end of diff), then reused for the next range.
     -+	 */
       	struct {
     - 		struct strbuf lines;	/* buffered in-range diff lines */
     + 		char func_name[80];
     + 		long func_name_len;
      -		long old_begin, old_count;
      -		long new_begin, new_count;
      +		long old_begin;
      +		long new_begin;
     + 		long lno_in_preimage;
     + 		long lno_in_postimage;
     + 		struct strbuf lines;
       		int active;
     --		int has_changes;	/* any '+' or '-' line? */
     - 	} hunk;
     +-		int has_changes;
     + 	} accumulating_hunk;
       
     --	/* Removal lines not yet known to be in-range */
      -	struct strbuf pending_rm;
      -	int pending_rm_count;
     --	long pending_rm_pre_begin;	/* pre-image line of first pending */
     +-	long pending_rm_pre_begin;
      -
     - 	int ret;			/* latched error from orig_line_fn */
     + 	int ret;
       };
       
      @@ diff.c: static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
     @@ diff.c: static int quick_consume(void *priv, char *line UNUSED, unsigned long le
       }
       
      -static void discard_pending_rm(struct line_range_filter *filter)
     -+/*
     -+ * Begin a range hunk at the first in-range line.  Its position fixes the
     -+ * hunk's begins, taken from the two image cursors before they advance:
     -+ * new_begin from the post-image, old_begin from the pre-image.  The line
     -+ * counts are not tracked here; flush_range_hunk() derives them from the
     -+ * buffered lines.
     -+ */
      +static void begin_range_hunk(struct line_range_filter *filter)
       {
      -	strbuf_reset(&filter->pending_rm);
      -	filter->pending_rm_count = 0;
     -+	filter->hunk.active = 1;
     -+	filter->hunk.new_begin = filter->lno_in_postimage;
     -+	filter->hunk.old_begin = filter->lno_in_preimage;
     -+	strbuf_reset(&filter->hunk.lines);
     ++	filter->accumulating_hunk.active = 1;
     ++	filter->accumulating_hunk.new_begin = filter->accumulating_hunk.lno_in_postimage;
     ++	filter->accumulating_hunk.old_begin = filter->accumulating_hunk.lno_in_preimage;
     ++	strbuf_reset(&filter->accumulating_hunk.lines);
       }
       
       static void flush_range_hunk(struct line_range_filter *filter)
       {
       	struct strbuf hdr = STRBUF_INIT;
     - 	const char *p, *end;
     + 	const char *line_buf, *line_buf_end;
      +	long old_count = 0, new_count = 0;
      +	int has_changes = 0;
       
     - 	if (!filter->hunk.active || filter->ret)
     + 	if (!filter->accumulating_hunk.active || filter->ret)
       		return;
       
     --	/* Drain any pending removal lines into the range hunk */
      -	if (filter->pending_rm_count) {
     --		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
     --		filter->hunk.old_count += filter->pending_rm_count;
     --		filter->hunk.has_changes = 1;
     +-		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
     +-		filter->accumulating_hunk.old_count += filter->pending_rm_count;
     +-		filter->accumulating_hunk.has_changes = 1;
      -		discard_pending_rm(filter);
     -+	/*
     -+	 * Derive the hunk's geometry from the buffered lines: a ' '
     -+	 * counts on both sides, a '-' on the old side, a '+' on the new.
     -+	 * A '-' or '+' marks a real change; the "\ No newline at end of
     -+	 * file" marker (line[0] == '\\') counts on neither side.
     -+	 */
     -+	p = filter->hunk.lines.buf;
     -+	end = p + filter->hunk.lines.len;
     -+	while (p < end) {
     -+		const char *eol = memchr(p, '\n', end - p);
     -+		if (*p == ' ' || *p == '-')
     ++	line_buf = filter->accumulating_hunk.lines.buf;
     ++	line_buf_end = line_buf + filter->accumulating_hunk.lines.len;
     ++	while (line_buf < line_buf_end) {
     ++		const char *eol = memchr(line_buf, '\n', line_buf_end - line_buf);
     ++		if (*line_buf == ' ') {
      +			old_count++;
     -+		if (*p == ' ' || *p == '+')
      +			new_count++;
     -+		if (*p == '-' || *p == '+')
     ++		}
     ++		else if (*line_buf == '-') {
     ++			old_count++;
      +			has_changes = 1;
     -+		p = eol ? eol + 1 : end;
     ++		}
     ++		else if (*line_buf == '+') {
     ++			new_count++;
     ++			has_changes = 1;
     ++		}
     ++		line_buf = eol ? eol + 1 : line_buf_end;
       	}
       
     - 	/*
     -@@ diff.c: static void flush_range_hunk(struct line_range_filter *filter)
     - 	 * ctxlen causes xdiff to emit context covering a range that
     - 	 * has no changes in this commit.
     - 	 */
     --	if (!filter->hunk.has_changes) {
     +-	if (!filter->accumulating_hunk.has_changes) {
      +	if (!has_changes) {
     - 		filter->hunk.active = 0;
     - 		strbuf_reset(&filter->hunk.lines);
     + 		filter->accumulating_hunk.active = 0;
     + 		strbuf_reset(&filter->accumulating_hunk.lines);
       		return;
       	}
       
       	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
     --		    filter->hunk.old_begin, filter->hunk.old_count,
     --		    filter->hunk.new_begin, filter->hunk.new_count);
     -+		    filter->hunk.old_begin, old_count,
     -+		    filter->hunk.new_begin, new_count);
     - 	if (filter->funclen > 0) {
     +-		    filter->accumulating_hunk.old_begin, filter->accumulating_hunk.old_count,
     +-		    filter->accumulating_hunk.new_begin, filter->accumulating_hunk.new_count);
     ++		    filter->accumulating_hunk.old_begin, old_count,
     ++		    filter->accumulating_hunk.new_begin, new_count);
     + 	if (filter->accumulating_hunk.func_name_len > 0) {
       		strbuf_addch(&hdr, ' ');
     - 		strbuf_add(&hdr, filter->func, filter->funclen);
     -@@ diff.c: static void line_range_hunk_fn(void *data,
     - 	 * When count > 0, begin is 1-based.  When count == 0, begin is
     - 	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
     - 	 * that type will arrive, so the value is unused.
     --	 *
     --	 * Any pending removal lines from the previous xdiff hunk are
     --	 * intentionally left in pending_rm: the line callback will
     --	 * flush or discard them when the next content line reveals
     --	 * whether the removals precede in-range content.
     - 	 */
     - 	filter->lno_in_postimage = new_begin;
     - 	filter->lno_in_preimage = old_begin;
     + 		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
     +-	     filter->accumulating_hunk.func_name_len);
     ++			   filter->accumulating_hunk.func_name_len);
     + 	}
     + 	strbuf_addch(&hdr, '\n');
     + 
      @@ diff.c: static void line_range_hunk_fn(void *data,
       static int line_range_line_fn(void *priv, char *line, unsigned long len)
       {
     @@ diff.c: static void line_range_hunk_fn(void *data,
       
      -	if (line[0] == '-') {
      -		if (!filter->pending_rm_count)
     --			filter->pending_rm_pre_begin = filter->lno_in_preimage;
     --		filter->lno_in_preimage++;
     +-			filter->pending_rm_pre_begin =
     +-				filter->accumulating_hunk.lno_in_preimage;
     +-		filter->accumulating_hunk.lno_in_preimage++;
      -		strbuf_add(&filter->pending_rm, line, len);
      -		filter->pending_rm_count++;
      -		return filter->ret;
     @@ diff.c: static void line_range_hunk_fn(void *data,
       	if (line[0] == '\\') {
      -		if (filter->pending_rm_count)
      -			strbuf_add(&filter->pending_rm, line, len);
     --		else if (filter->hunk.active)
     -+		if (filter->hunk.active)
     - 			strbuf_add(&filter->hunk.lines, line, len);
     --		/* otherwise outside tracked range; drop silently */
     +-		else if (filter->accumulating_hunk.active)
     ++		if (filter->accumulating_hunk.active)
     + 			strbuf_add(&filter->accumulating_hunk.lines, line, len);
       		return filter->ret;
       	}
       
     @@ diff.c: static void line_range_hunk_fn(void *data,
      +	if (line[0] != '+' && line[0] != ' ' && line[0] != '-')
       		BUG("unexpected diff line type '%c'", line[0]);
       
     -+	/*
     -+	 * idx_in_postimage is this line's 0-based post-image index (see the model on
     -+	 * struct line_range_filter).  The cursors are advanced only after
     -+	 * the line is classified, so a '-' is tested at the same idx_in_postimage as
     -+	 * the '+'/' ' that follows it.
     -+	 */
     - 	idx_in_postimage = filter->lno_in_postimage - 1;
     --	cur_pre = filter->lno_in_preimage;	/* save before advancing for context lines */
     --	filter->lno_in_postimage++;
     + 	idx_in_postimage = filter->accumulating_hunk.lno_in_postimage - 1;
     +-	cur_pre = filter->accumulating_hunk.lno_in_preimage;
     +-	filter->accumulating_hunk.lno_in_postimage++;
      -	if (line[0] == ' ')
     --		filter->lno_in_preimage++;
     +-		filter->accumulating_hunk.lno_in_preimage++;
       
     --	/* Advance past ranges we've passed */
     -+	/* Retire ranges we have passed, flushing the one we leave. */
     - 	while (filter->cur_range < filter->ranges->nr &&
     - 	       idx_in_postimage >= filter->ranges->ranges[filter->cur_range].end) {
     - 		if (filter->hunk.active)
     + 	while (filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
     + 	       idx_in_postimage >=
     + 		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end) {
     + 		if (filter->accumulating_hunk.active)
       			flush_range_hunk(filter);
      -		discard_pending_rm(filter);
     - 		filter->cur_range++;
     + 		filter->range_set_idx++;
       	}
       
     --	/* Past all ranges */
     --	if (filter->cur_range >= filter->ranges->nr) {
     +-	if (filter->range_set_idx >= filter->range_sets_to_filter_by->nr) {
      -		discard_pending_rm(filter);
      -		return filter->ret;
      -	}
     -+	in_range = filter->cur_range < filter->ranges->nr &&
     -+		   idx_in_postimage >= filter->ranges->ranges[filter->cur_range].start &&
     -+		   idx_in_postimage < filter->ranges->ranges[filter->cur_range].end;
     - 
     --	cur = &filter->ranges->ranges[filter->cur_range];
     -+	if (in_range) {
     -+		if (!filter->hunk.active)
     -+			begin_range_hunk(filter);
     - 
     --	/* Before current range */
     +-
     +-	cur = &filter->range_sets_to_filter_by->ranges[filter->range_set_idx];
     +-
      -	if (idx_in_postimage < cur->start) {
      -		discard_pending_rm(filter);
      -		return filter->ret;
     -+		strbuf_add(&filter->hunk.lines, line, len);
     - 	}
     +-	}
     ++	in_range = filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
     ++		   idx_in_postimage >=
     ++		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].start &&
     ++		   idx_in_postimage <
     ++		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end;
       
     --	/* In range so start a new range hunk if needed */
     --	if (!filter->hunk.active) {
     --		filter->hunk.active = 1;
     --		filter->hunk.has_changes = 0;
     --		filter->hunk.new_begin = idx_in_postimage + 1;
     --		filter->hunk.old_begin = filter->pending_rm_count
     +-	if (!filter->accumulating_hunk.active) {
     +-		filter->accumulating_hunk.active = 1;
     +-		filter->accumulating_hunk.has_changes = 0;
     +-		filter->accumulating_hunk.new_begin = idx_in_postimage + 1;
     +-		filter->accumulating_hunk.old_begin = filter->pending_rm_count
      -			? filter->pending_rm_pre_begin : cur_pre;
     --		filter->hunk.old_count = 0;
     --		filter->hunk.new_count = 0;
     --		strbuf_reset(&filter->hunk.lines);
     +-		filter->accumulating_hunk.old_count = 0;
     +-		filter->accumulating_hunk.new_count = 0;
     +-		strbuf_reset(&filter->accumulating_hunk.lines);
      -	}
     --
     --	/* Flush pending removals into range hunk */
     ++	if (in_range) {
     ++		if (!filter->accumulating_hunk.active)
     ++			begin_range_hunk(filter);
     + 
      -	if (filter->pending_rm_count) {
     --		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
     --		filter->hunk.old_count += filter->pending_rm_count;
     --		filter->hunk.has_changes = 1;
     +-		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
     +-		filter->accumulating_hunk.old_count += filter->pending_rm_count;
     +-		filter->accumulating_hunk.has_changes = 1;
      -		discard_pending_rm(filter);
     --	}
     --
     --	strbuf_add(&filter->hunk.lines, line, len);
     --	filter->hunk.new_count++;
     ++		strbuf_add(&filter->accumulating_hunk.lines, line, len);
     + 	}
     + 
     +-	strbuf_add(&filter->accumulating_hunk.lines, line, len);
     +-	filter->accumulating_hunk.new_count++;
      -	if (line[0] == '+')
     --		filter->hunk.has_changes = 1;
     +-		filter->accumulating_hunk.has_changes = 1;
      -	else
     --		filter->hunk.old_count++;
     -+	/*
     -+	 * Advance each image's cursor: a line present in that image (see
     -+	 * the model) consumes one of its line numbers.
     -+	 */
     -+	if (line[0] != '-')
     -+		filter->lno_in_postimage++;
     -+	if (line[0] != '+')
     -+		filter->lno_in_preimage++;
     +-		filter->accumulating_hunk.old_count++;
     ++	if (line[0] == ' ' || line[0] == '+')
     ++		filter->accumulating_hunk.lno_in_postimage++;
     ++	if (line[0] == ' ' || line[0] == '-')
     ++		filter->accumulating_hunk.lno_in_preimage++;
       
       	return filter->ret;
       }
      @@ diff.c: static void builtin_diff(const char *name_a,
       			lr_state.orig_cb_data = &ecbdata;
     - 			lr_state.ranges = line_ranges;
     - 			strbuf_init(&lr_state.hunk.lines, 0);
     + 			lr_state.range_sets_to_filter_by = line_ranges;
     + 			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
      -			strbuf_init(&lr_state.pending_rm, 0);
       
       			/*
     @@ diff.c: static void builtin_diff(const char *name_a,
      @@ diff.c: static void builtin_diff(const char *name_a,
       				die("unable to generate diff for %s",
       				    one->path);
     - 			strbuf_release(&lr_state.hunk.lines);
     + 			strbuf_release(&lr_state.accumulating_hunk.lines);
      -			strbuf_release(&lr_state.pending_rm);
       		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
       					 &ecbdata, &xpp, &xecfg))
     @@ diff.c: static void builtin_diff(const char *name_a,
      
       ## t/t4211-line-log.sh ##
      @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to diff-text matches' '
     - 	grep "F2 + 2" actual
     + 	test_grep "F2 + 2" actual
       '
       
      +test_expect_success 'setup for trailing deletion test' '
     @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to diff-text matche
      +	{
      +	    return 1;
      +	}
     -+	// trailing comment
     ++	// trailing comment outside tracked range
      +	EOF
      +	git add file.c &&
      +	test_tick &&
      +	git commit -m "add file with trailing comment" &&
     -+	# Modify tracked() AND delete the trailing comment in
     -+	# one commit, so the commit touches the tracked range
     -+	# and is not filtered out by the revision walker.
     ++	# Remove the trailing comment AND modify tracked() so there
     ++	# is a modification to the line range we track and a
     ++	# modification to the following line, which we do not track.
      +	cat >file.c <<-\EOF &&
      +	void tracked()
      +	{
     @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to diff-text matche
      +
      +test_expect_success '-L does not include deletions past end of tracked range' '
      +	git log -L:tracked:file.c --format= -1 -p >actual &&
     -+	# The trailing comment deletion is outside the tracked
     -+	# range and should not appear in the patch output.
      +	test_grep "return 2" actual &&
      +	test_grep ! "trailing comment" actual
      +'
     -+
     -+test_expect_success '-L includes leading deletions resolved by in-range line' '
     -+	git checkout --orphan leading-del &&
     -+	git reset --hard &&
     -+	cat >file.c <<-\EOF &&
     -+	// leading comment
     -+	void tracked()
     -+	{
     -+	    return 1;
     -+	}
     -+	EOF
     -+	git add file.c &&
     -+	test_tick &&
     -+	git commit -m "add file with leading comment" &&
     -+	cat >file.c <<-\EOF &&
     -+	void tracked()
     -+	{
     -+	    return 2;
     -+	}
     -+	EOF
     -+	git commit -a -m "modify tracked and delete leading comment" &&
     -+	git log -L:tracked:file.c --format= -1 -p >actual &&
     -+	# The leading comment deletion is resolved by the next
     -+	# non-removal line (void tracked), which is in range: a
     -+	# removal is classified by the position of the following
     -+	# line, so it joins the range that line falls in.
     -+	test_grep "return 2" actual &&
     -+	test_grep "leading comment" actual
     -+'
     -+
     -+test_expect_success 'setup for line-range filter edge cases' '
     -+	git checkout --orphan filter-edge &&
     -+	git reset --hard &&
     -+	cat >file.c <<-\EOF &&
     -+	void before()
     -+	{
     -+	    return 0;
     -+	}
     -+
     -+	void tracked()
     -+	{
     -+	    int a = 1;
     -+	    int b = 2;
     -+	    int c = 3;
     -+	    return a + b + c;
     -+	}
     -+
     -+	void after()
     -+	{
     -+	    return 9;
     -+	}
     -+	EOF
     -+	git add file.c &&
     -+	test_tick &&
     -+	git commit -m "initial"
     -+'
     -+
     -+test_expect_success '-L change at exact first line of range' '
     -+	git checkout filter-edge &&
     -+	# Change the function signature (first line of range)
     -+	sed "s/void tracked/int tracked/" file.c >tmp &&
     -+	mv tmp file.c &&
     -+	git commit -a -m "change first line" &&
     -+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
     -+	test_grep "change first line" actual &&
     -+	test_grep "+int tracked" actual &&
     -+	test_grep "\\-void tracked" actual
     -+'
     -+
     -+test_expect_success '-L change at exact last line of range' '
     -+	git checkout filter-edge &&
     -+	git reset --hard HEAD~1 &&
     -+	# Change the closing brace line (last line of range)
     -+	sed "s/^}$/} \/\/ end tracked/" file.c >tmp &&
     -+	mv tmp file.c &&
     -+	git commit -a -m "change last line" &&
     -+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
     -+	test_grep "change last line" actual &&
     -+	test_grep "end tracked" actual
     -+'
     -+
     -+test_expect_success '-L pure deletion in range (no additions)' '
     -+	git checkout filter-edge &&
     -+	git reset --hard HEAD~1 &&
     -+	# Delete a line inside tracked() without adding anything
     -+	sed "/int c/d" file.c >tmp &&
     -+	mv tmp file.c &&
     -+	git commit -a -m "pure deletion" &&
     -+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
     -+	test_grep "pure deletion" actual &&
     -+	test_grep "\\-.*int c" actual
     -+'
      +
       test_expect_success '-L with --diff-filter=M excludes root commit' '
       	git checkout parent-oids &&
 3:  d211c82e40 ! 3:  2081d5d257 diff: emit -L hunk headers via xdiff's formatter
     @@ Metadata
       ## Commit message ##
          diff: emit -L hunk headers via xdiff's formatter
      
     -    The line-range filter builds its own "@@ -<old> +<new> @@" header for
     -    each range hunk.  For a side with no lines (count 0, such as the old
     -    side of a pure insertion), the begin should be the number of the line
     -    before the change, per the convention git diff and xdl_emit_hunk_hdr()
     -    follow.  The hand-rolled code's begin was one too high; in t4211 this
     -    produced
     +    Currently, diff's line-range filter implements its own method for
     +    emitting diff hunk headers. This mostly matches what xdiff itself
     +    outputs, but there is a discrepancy for postimage or preimage sides
     +    with 0 line changes. For a side with no lines (count 0), the begin is
     +    the line before the change. The header omits the line count of 1.
      
     -            @@ -25,0 +18,9 @@
     +    Rather than fix this case in the line-range implementation, expose the
     +    function xdiff uses to emit its headers. Reusing it keeps the header
     +    format consistent with and without -L.
      
     -    an old begin of 25 in a 24-line file, where git diff would give 24.
     -
     -    Stop hand-rolling the header.  flush_range_hunk() now formats it through
     -    xdiff's own emitter: a new xdiff_emit_hunk_header() helper wraps
     -    xdl_emit_hunk_hdr(), the function that produces every other diff's hunk
     -    headers.  The count-0 begin is then correct by construction, and as a
     -    side effect -L headers match git diff exactly, including its omission of
     -    a count of 1 ("@@ -22 +22 @@" rather than "@@ -22,1 +22,1 @@").
     -
     -    xdiff's hunk callback already hands line_range_hunk_fn() a count-0 begin
     -    decremented, so undo that when seeding the cursors and let the formatter
     -    re-apply the convention once, at emit time.
     -
     -    The off-by-one predates this series, and the two regenerated fixtures
     -    reach it from different origins: no-assertion-error has carried it since
     -    its test was added in ab60c693a2 (line-log: fix assertion error,
     -    2025-08-18), while vanishes-early acquired it when 86e986f166 (line-log:
     -    route -L output through the standard diff pipeline) reshaped its tracked
     -    line into a pure insertion.  vanishes-early also drops its count-1
     -    counts.
     +    Update test scenarios and fixtures to reflect the now consistent header
     +    format.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ diff.c: static void flush_range_hunk(struct line_range_filter *filter)
       	}
       
      -	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
     --		    filter->hunk.old_begin, old_count,
     --		    filter->hunk.new_begin, new_count);
     --	if (filter->funclen > 0) {
     +-		    filter->accumulating_hunk.old_begin, old_count,
     +-		    filter->accumulating_hunk.new_begin, new_count);
     +-	if (filter->accumulating_hunk.func_name_len > 0) {
      -		strbuf_addch(&hdr, ' ');
     --		strbuf_add(&hdr, filter->func, filter->funclen);
     +-		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
     +-			   filter->accumulating_hunk.func_name_len);
      -	}
      -	strbuf_addch(&hdr, '\n');
     -+	xdiff_emit_hunk_header(&hdr, filter->hunk.old_begin, old_count,
     -+			       filter->hunk.new_begin, new_count,
     -+			       filter->func, filter->funclen);
     ++	xdiff_emit_hunk_header(&hdr, filter->accumulating_hunk.old_begin, old_count,
     ++			       filter->accumulating_hunk.new_begin, new_count,
     ++			       filter->accumulating_hunk.func_name,
     ++			filter->accumulating_hunk.func_name_len);
       
       	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
       	strbuf_release(&hdr);
     @@ diff.c: static void flush_range_hunk(struct line_range_filter *filter)
       {
       	struct line_range_filter *filter = data;
       
     - 	/*
     --	 * When count > 0, begin is 1-based.  When count == 0, begin is
     --	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
     --	 * that type will arrive, so the value is unused.
     -+	 * Seed the per-image line cursors from the hunk header's begins.  For
     -+	 * a side with no lines (count 0), xdiff's callback has already moved
     -+	 * its begin to the line before the change, so add one back to recover
     -+	 * the true 1-based start.  xdiff_emit_hunk_header() reapplies that -1
     -+	 * when the clipped hunk is emitted.
     - 	 */
     --	filter->lno_in_postimage = new_begin;
     --	filter->lno_in_preimage = old_begin;
     -+	filter->lno_in_postimage = new_nr ? new_begin : new_begin + 1;
     -+	filter->lno_in_preimage = old_nr ? old_begin : old_begin + 1;
     +-	filter->accumulating_hunk.lno_in_postimage = new_begin;
     +-	filter->accumulating_hunk.lno_in_preimage = old_begin;
     ++	filter->accumulating_hunk.lno_in_postimage = new_nr ? new_begin : new_begin + 1;
     ++	filter->accumulating_hunk.lno_in_preimage = old_nr ? old_begin : old_begin + 1;
       
       	if (funclen > 0) {
     - 		if (funclen > (long)sizeof(filter->func))
     + 		if (funclen > (long)sizeof(filter->accumulating_hunk.func_name))
      
       ## t/t4211/sha1/expect.no-assertion-error ##
      @@ t/t4211/sha1/expect.no-assertion-error: diff --git a/b.c b/b.c
     @@ xdiff-interface.h: int xdiff_compare_lines(const char *l1, long s1,
      +
      +/*
      + * Append a unified-diff hunk header to `out`, e.g.
     -+ * "@@ -<old> +<new> @@ func\n".  The header comes from wrapping xdiff's
     ++ * "@@ -<old> +<new> @@ func\n". The header comes from wrapping xdiff's
      + * own hunk-header emitter, so it matches what a normal diff would
     -+ * produce for these begins and counts.  For a side with no lines
     -+ * (count 0) the begin is the line before the change, and a count of 1
     -+ * is omitted.
     ++ * produce for the given line number begins and line counts.
      + */
      +void xdiff_emit_hunk_header(struct strbuf *out,
     -+			    long old_begin, long old_count,
     -+			    long new_begin, long new_count,
     ++			    long old_begin, long old_nr,
     ++			    long new_begin, long new_nr,
      +			    const char *func, long funclen);
      +
       #endif
 4:  b82a997359 ! 4:  6b13c13ae7 diff: extract a line-range diff helper for reuse
     @@ Metadata
       ## Commit message ##
          diff: extract a line-range diff helper for reuse
      
     -    builtin_diff() open-codes the line-range filter setup and teardown
     -    around its xdi_diff_outf() call: zero the struct, point it at the
     -    output callback, inflate ctxlen to the largest range span so each range
     -    yields a single xdiff hunk, run the diff, flush the trailing range
     -    hunk, and release the buffer.  The upcoming -L stat and check formats
     -    need the same sequence.
     +    Extract logic for initializing the line-range filter and running a diff
     +    for a specific line range. This logic is needed for any diff that
     +    targets a line range independent of the current patch display path.
      
     -    Extract line_range_filter_init() for the setup and a
     -    line_range_filter_diff() helper that prepares the xdiff config the
     -    filter needs, runs an initialized filter through xdi_diff_outf(),
     -    flushes the final range hunk, and releases it, returning the latched
     -    error.  The helper inflates ctxlen to the largest range span so each
     -    range yields a single xdiff hunk, and clears XDL_EMIT_NO_HUNK_HDR so
     -    the hunk headers the filter seeds its position from are always emitted.
     -    Folding both into the helper keeps these invariants, which the filter's
     -    position tracking relies on, in a single place for every consumer.
     -    builtin_diff() now does init + line_range_filter_diff(); the next two
     -    patches reuse them in builtin_diffstat() and builtin_checkdiff()
     -    instead of repeating the boilerplate.
     +    The subsequent commits use this logic to enable additional line range
     +    targeted diff modes.
      
     -    No behavior change: builtin_diff() leaves XDL_EMIT_NO_HUNK_HDR unset,
     -    so clearing it is a no-op until the suppressing consumers arrive.
     +    No logical behavior change.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ diff.c: static int quick_consume(void *priv, char *line UNUSED, unsigned long le
      +	memset(filter, 0, sizeof(*filter));
      +	filter->orig_line_fn = line_fn;
      +	filter->orig_cb_data = cb_data;
     -+	filter->ranges = ranges;
     -+	strbuf_init(&filter->hunk.lines, 0);
     ++	filter->range_sets_to_filter_by = ranges;
     ++	strbuf_init(&filter->accumulating_hunk.lines, 0);
      +}
      +
     - /*
     -  * Begin a range hunk at the first in-range line.  Its position fixes the
     -  * hunk's begins, taken from the two image cursors before they advance:
     + static void begin_range_hunk(struct line_range_filter *filter)
     + {
     + 	filter->accumulating_hunk.active = 1;
      @@ diff.c: static int line_range_line_fn(void *priv, char *line, unsigned long len)
       	return filter->ret;
       }
       
     -+/*
     -+ * Run an xdiff pass through an initialized line-range filter, flush the
     -+ * final range hunk, and release the filter.  Inflates ctxlen to the largest
     -+ * range span first, so that every change within a single range lands in one
     -+ * xdiff hunk and the inter-change context is emitted; the filter then clips
     -+ * back to range boundaries.  The optimal ctxlen depends on where changes fall
     -+ * within the range, which is only known after xdiff runs, so the max span is
     -+ * the upper bound that guarantees correctness in a single pass.  Every
     -+ * consumer (patch, diffstat, check) relies on one xdiff hunk per range, so
     -+ * this lives here rather than at each call site.  Also clears
     -+ * XDL_EMIT_NO_HUNK_HDR: the filter seeds its per-image position from the hunk
     -+ * headers, so a consumer that otherwise suppresses them (diffstat) still gets
     -+ * them here.  Returns non-zero if xdiff or any forwarded callback failed.
     -+ */
     ++
      +static int line_range_filter_diff(struct line_range_filter *filter,
      +				  mmfile_t *mf1, mmfile_t *mf2,
      +				  xpparam_t *xpp, xdemitconf_t *xecfg)
      +{
     -+	const struct range_set *ranges = filter->ranges;
     ++	const struct range_set *ranges = filter->range_sets_to_filter_by;
      +	long max_span = 0;
      +	unsigned int i;
      +	int ret;
     @@ diff.c: static int line_range_line_fn(void *priv, char *line, unsigned long len)
      +		flush_range_hunk(filter);
      +		ret = filter->ret;
      +	}
     -+	strbuf_release(&filter->hunk.lines);
     ++	strbuf_release(&filter->accumulating_hunk.lines);
      +	return ret;
      +}
      +
     @@ diff.c: static void builtin_diff(const char *name_a,
      -			memset(&lr_state, 0, sizeof(lr_state));
      -			lr_state.orig_line_fn = fn_out_consume;
      -			lr_state.orig_cb_data = &ecbdata;
     --			lr_state.ranges = line_ranges;
     --			strbuf_init(&lr_state.hunk.lines, 0);
     +-			lr_state.range_sets_to_filter_by = line_ranges;
     +-			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
      -
      -			/*
      -			 * Inflate ctxlen so that all changes within
     @@ diff.c: static void builtin_diff(const char *name_a,
      +						   &xpp, &xecfg))
       				die("unable to generate diff for %s",
       				    one->path);
     --			strbuf_release(&lr_state.hunk.lines);
     +-			strbuf_release(&lr_state.accumulating_hunk.lines);
       		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
       					 &ecbdata, &xpp, &xecfg))
       			die("unable to generate diff for %s", one->path);
 5:  3d0091b549 ! 5:  f12b61b9a4 line-log: support diff stat formats with -L
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    line-log: support diff stat formats with -L
     +    diff: support stat formats with -L
      
     -    Reuse the line_range_filter in builtin_diffstat() so the stat formats
     -    count only the lines within the tracked range.  When a filepair carries
     -    line_ranges, the filter wraps diffstat_consume() as its output callback,
     -    forwarding only the lines inside the range for counting.
     -    flush_range_hunk() replays buffered content through diffstat_consume(),
     -    which ignores synthetic @@ headers since it only counts '+' and '-'
     -    lines.
     +    Reuse the line_range_filter in builtin_diffstat() so -L supports
     +    the stat formats and add tests verifying the new behavior.
      
     -    Expand the output format allowlist in setup_revisions() to accept
     -    --stat, --numstat, and --shortstat with -L.
     -
     -    Leave --dirstat out of the allowlist so it is rejected like any other
     -    unsupported format.  Its default mode counts each file's whole-file
     -    byte damage via diffcore_count_changes(), outside the line-based
     -    pipeline that the -L filter scopes, so bare --dirstat cannot honor the
     -    tracked range.  The --dirstat=lines mode could: it aggregates the same
     -    per-file line counts as --numstat, which -L already scopes.  But
     -    accepting only that sub-mode while bare --dirstat keeps erroring is a
     -    confusing split, so the whole format is deferred to a follow-up;
     -    --numstat already reports the exact per-file counts within the tracked
     -    range.
     -
     -    Also drop "yet" from the generic -L rejection message ("does not
     -    yet support the requested diff format").  Some rejected formats do
     -    not fit a line range at all, so "yet" wrongly implied they are all
     -    just awaiting support.
     +    Ungate the newly enabled options and drop "yet" from the generic
     +    -L rejection message ("does not yet support the requested diff
     +    format"). Some rejected formats do not fit -L at all, so "yet"
     +    wrongly implies they are all awaiting support.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/line-range-options.adoc
      -	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
      -	currently implemented.
      +	The following non-patch diff formats are supported: `--raw`,
     -+	`--name-only`, `--name-status`, `--summary`,
     -+	`--stat`, `--numstat`, and `--shortstat`.
     -+	The stat formats count only lines within the tracked range.
     -+	`--dirstat` is not supported
     -+	with `-L`: it summarizes change as each directory's share of
     -+	the total churn, not as counts for the tracked lines.  Use
     -+	`--numstat` for exact per-file counts within the range.
     ++	`--name-only`, `--name-status`, `--summary`, `--stat`, `--numstat`,
     ++	and `--shortstat`. The stat formats count only lines within the tracked
     ++	range. `--dirstat` is not supported with `-L`: it summarizes change as each
     ++	directory's share of the total churn, not as counts for the tracked lines.
     ++	Use `--numstat` for exact per-file counts within the range.
       +
       Patch formatting options such as `--word-diff`, `--color-moved`,
       `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
     @@ t/t4211-line-log.sh: test_expect_success '--name-status shows status and path' '
      -
      -test_expect_success '--dirstat is not yet supported with -L' '
      +test_expect_success '--dirstat is not supported with -L' '
     -+	# --dirstat is not supported with -L: its default mode measures
     -+	# whole-file change, not the tracked lines, and the
     -+	# --dirstat=lines variant is deferred too, so both forms are
     -+	# rejected like any other unsupported format.
       	test_must_fail git log -L1,24:b.c --dirstat 2>err &&
      -	test_grep "does not yet support" err
     -+	test_grep "does not support" err &&
     -+	test_must_fail git log -L1,24:b.c --dirstat=lines 2>err &&
      +	test_grep "does not support" err
       '
       
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
       	test_grep "^diff --git" line2
       '
       
     -+test_expect_success 'setup for stat range-scoping tests' '
     -+	git checkout --orphan stat-scoping &&
     ++test_expect_success 'setup for -L stat tests' '
     ++	git checkout --orphan stat-range &&
      +	git reset --hard &&
      +	cat >file.c <<-\EOF &&
      +	int func1()
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +	    return F1;
      +	}
      +
     -+	int func2()
     ++	int tracked_fn()
      +	{
      +	    return F2;
      +	}
      +	EOF
      +	git add file.c &&
      +	test_tick &&
     -+	git commit -m "Add func1() and func2()" &&
     ++	git commit -m "Add func1() and tracked_fn()" &&
      +
     -+	# Modify both functions in a single commit so that
     -+	# whole-file stats differ from the counts for the tracked range.
     ++	# Modify both functions so whole-file stats (2 added, 2 deleted)
     ++	# differ from the tracked range of tracked_fn (1 and 1).
      +	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" file.c >tmp &&
      +	mv tmp file.c &&
      +	git commit -a -m "Modify both functions"
      +'
      +
     -+test_expect_success '--numstat counts only lines in tracked range' '
     -+	# "Modify both functions" changes one line in func1 and one in
     -+	# func2.  Whole-file numstat would show 2 added, 2 deleted.
     -+	# numstat for func2 within the tracked range should show only 1 and 1.
     -+	git log -L:func2:file.c --numstat --format=%s -1 >actual &&
     -+	test_grep "Modify both functions" actual &&
     -+	test_grep "^1	1	file.c$" actual &&
     -+	test_grep ! "^diff --git" actual
     -+'
     ++test_expect_success '-L --numstat limits counts to the tracked range' '
     ++	git log -L:tracked_fn:file.c --numstat --format=%s >actual &&
     ++	cat >expect <<-\EOF &&
     ++	Modify both functions
      +
     -+test_expect_success '--numstat counts only additions for root commit' '
     -+	# Root commit creates both func1 (4 lines) and func2 (4 lines).
     -+	# Whole-file numstat would show 9 lines added.  numstat for func2
     -+	# within the tracked range should show only 4.
     -+	git log -L:func2:file.c --numstat --format=%s >actual &&
     -+	test_grep "Add func1() and func2()" actual &&
     -+	test_grep "^4	0	file.c$" actual &&
     -+	test_grep ! "^diff --git" actual
     -+'
     ++	1	1	file.c
     ++	Add func1() and tracked_fn()
      +
     -+test_expect_success '--stat counts only lines in tracked range' '
     -+	git log -L:func2:file.c --stat --format=%s -1 >actual &&
     -+	test_grep "Modify both functions" actual &&
     -+	test_grep "file.c |" actual &&
     -+	test_grep "1 insertion" actual &&
     -+	test_grep "1 deletion" actual &&
     -+	test_grep ! "^diff --git" actual
     ++	4	0	file.c
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success '--shortstat counts only lines in tracked range' '
     -+	# --shortstat prints only the summary line: no per-file "file.c |"
     -+	# line.  Counts cover only the tracked range, as for --numstat above.
     -+	git log -L:func2:file.c --shortstat --format=%s -1 >actual &&
     -+	test_grep "Modify both functions" actual &&
     -+	test_grep "1 insertion" actual &&
     -+	test_grep "1 deletion" actual &&
     -+	test_grep ! "file.c |" actual &&
     -+	test_grep ! "^diff --git" actual
     ++test_expect_success '-L --stat and --shortstat limit counts to the tracked range' '
     ++	git log -L:tracked_fn:file.c --stat --format=%s -1 >actual &&
     ++	cat >expect <<-\EOF &&
     ++	Modify both functions
     ++
     ++	 file.c | 2 +-
     ++	 1 file changed, 1 insertion(+), 1 deletion(-)
     ++	EOF
     ++	test_cmp expect actual &&
     ++
     ++	git log -L:tracked_fn:file.c --shortstat --format=%s -1 >actual &&
     ++	cat >expect <<-\EOF &&
     ++	Modify both functions
     ++
     ++	 1 file changed, 1 insertion(+), 1 deletion(-)
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success '--numstat across renames and multiple commits' '
      +	# parallel-change carries the tracked function f across an a.c -> b.c
     -+	# rename and a merge of two parallel histories.  With -M, --numstat
     -+	# follows the rename and reports added/removed counts for f within
     -+	# the tracked range (not whole-file) per commit; the file column flips from
     -+	# b.c to a.c at the rename as the walk goes back in time.  Commits
     -+	# that do not change the range of f emit no row (the merge and the
     -+	# pure file-move produce nothing), so there are fewer rows than
     -+	# commits.
     ++	# rename and a merge of two parallel histories.
      +	git checkout parallel-change &&
      +	git log -M -L ":f:b.c" --format= --numstat >actual &&
      +	cat >expect <<-\EOF &&
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +	git checkout --orphan multi-range &&
      +	git reset --hard &&
      +	cat >m.c <<-\EOF &&
     -+	int func1()
     ++	int tracked_func1()
      +	{
      +	    return F1;
      +	}
      +
     -+	int func2()
     ++	int tracked_func2()
      +	{
      +	    return F2;
      +	}
     @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line b
      +	git add m.c &&
      +	test_tick &&
      +	git commit -m "add m.c" &&
     -+	# Change all three functions but track only func1 and func2.
     -+	# Whole-file numstat would be 3 3; a 2 2 result proves the
     -+	# untracked func3 change is excluded and the two ranges just sum.
      +	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" -e "s/F3/F3 + 3/" m.c >tmp &&
      +	mv tmp m.c &&
      +	git commit -a -m "Modify all three functions" &&
     -+	git log -L:func1:m.c -L:func2:m.c --numstat --format=%s -1 >actual &&
     -+	test_grep "Modify all three functions" actual &&
     -+	test_grep "^2	2	m.c$" actual &&
     -+	test_grep ! "^3	3	m.c$" actual
     ++	git log -L:tracked_func1:m.c -L:tracked_func2:m.c --numstat --format=%s -1 >actual &&
     ++	cat >expect <<-\EOF &&
     ++	Modify all three functions
     ++
     ++	2	2	m.c
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
       test_expect_success '--summary shows new file on root commit' '
 6:  36ed52d831 ! 6:  f1f5af8f77 diff: support --check with -L line ranges
     @@ Metadata
       ## Commit message ##
          diff: support --check with -L line ranges
      
     -    builtin_checkdiff() runs its own xdiff pass to detect whitespace
     -    errors in newly added lines.  When -L is active, the check should
     -    be scoped to the tracked line ranges rather than the whole file.
     +    Reuse the line_range_filter in builtin_checkdiff() so -L supports
     +    the --check option.
      
     -    Reuse the line_range_filter to wrap checkdiff_consume(), the same
     -    pattern already used for patch output and diffstat.  The filter
     -    forwards only in-range lines for whitespace checking.
     +    Add orig_hunk_fn field similar to orig_line_fn that forwards
     +    xdiff_emit_hunk_fn calls when we flush filtered hunks. This is necessary
     +    because --check relies on receiving calls to its checkdiff_consume_hunk
     +    function for managing state.
      
     -    checkdiff reports the file line number of each error, which it
     -    normally learns from the hunk header via checkdiff_consume_hunk().
     -    The filter synthesizes its own hunk headers, so give it an optional
     -    hunk callback and route checkdiff_consume_hunk() through it; this
     -    sets the post-image position before the in-range lines are replayed.
     -    Without it the reported line numbers would count from the start of
     -    the range hunk rather than the start of the file.
     -
     -    The trailing blank-at-eof check is a second pass that scans the whole
     -    file via check_blank_at_eof(), so gate its report on the tracked
     -    ranges as well; otherwise a blank line added at end of file is
     -    reported even when it lies outside the range.
     -
     -    Add DIFF_FORMAT_CHECKDIFF to the -L output format allowlist in
     -    setup_revisions() so that -L --check is accepted, and list --check
     -    among the supported formats in the documentation.  Add tests covering
     -    that whitespace errors are reported, scoped to the tracked range, and
     -    labeled with the correct file line number, including when two errors
     -    in one range are separated by a gap that would otherwise split into
     -    multiple xdiff hunks.
     +    Document and ungate the newly enabled option, and add tests verifying
     +    the new behavior.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/line-range-options.adoc
       	You can specify this option more than once. Implies `--patch`.
       	Patch output can be suppressed using `--no-patch`.
       	The following non-patch diff formats are supported: `--raw`,
     --	`--name-only`, `--name-status`, `--summary`,
     -+	`--name-only`, `--name-status`, `--summary`, `--check`,
     - 	`--stat`, `--numstat`, and `--shortstat`.
     - 	The stat formats count only lines within the tracked range.
     - 	`--dirstat` is not supported
     +-	`--name-only`, `--name-status`, `--summary`, `--stat`, `--numstat`,
     +-	and `--shortstat`. The stat formats count only lines within the tracked
     +-	range. `--dirstat` is not supported with `-L`: it summarizes change as each
     +-	directory's share of the total churn, not as counts for the tracked lines.
     +-	Use `--numstat` for exact per-file counts within the range.
     ++	`--name-only`, `--name-status`, `--summary`, `--check`, `--stat`,
     ++	`--numstat`, and `--shortstat`. The stat formats count only lines
     ++	within the tracked range. `--dirstat` is not supported with `-L`: it
     ++	reports how change is distributed across directories over whole files,
     ++	which is not meaningful for line ranges within a file. Use `--numstat`
     ++	for exact per-file counts within the range.
     + +
     + Patch formatting options such as `--word-diff`, `--color-moved`,
     + `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
      
       ## diff.c ##
      @@ diff.c: struct emit_callback {
        */
       struct line_range_filter {
       	xdiff_emit_line_fn orig_line_fn;
     -+	/*
     -+	 * Optional; consumers that report file line numbers (e.g.
     -+	 * checkdiff) need the synthetic hunk header to set their
     -+	 * post-image position before in-range lines are replayed.
     -+	 */
      +	xdiff_emit_hunk_fn orig_hunk_fn;
       	void *orig_cb_data;
     - 	const struct range_set *ranges;	/* 0-based [start, end) */
     - 	unsigned int cur_range;		/* index into the range_set */
     + 	const struct range_set *range_sets_to_filter_by;
     + 	unsigned int range_set_idx;
      @@ diff.c: static void flush_range_hunk(struct line_range_filter *filter)
     - 			       filter->hunk.new_begin, new_count,
     - 			       filter->func, filter->funclen);
     + 			       filter->accumulating_hunk.func_name,
     + 			filter->accumulating_hunk.func_name_len);
       
     -+	/*
     -+	 * Inform a line-numbering consumer of the post-image position
     -+	 * before replaying lines, mirroring the hunk callback xdiff
     -+	 * would have issued for a non-scoped diff.
     -+	 */
      +	if (filter->orig_hunk_fn)
      +		filter->orig_hunk_fn(filter->orig_cb_data,
     -+				filter->hunk.old_begin, old_count,
     -+				filter->hunk.new_begin, new_count,
     -+				filter->func, filter->funclen);
     ++				filter->accumulating_hunk.old_begin, old_count,
     ++				filter->accumulating_hunk.new_begin, new_count,
     ++				filter->accumulating_hunk.func_name,
     ++		       filter->accumulating_hunk.func_name_len);
      +
       	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
       	strbuf_release(&hdr);
     @@ diff.c: static void builtin_diffstat(const char *name_a, const char *name_b,
       	diff_free_filespec_data(two);
       }
       
     -+/*
     -+ * Is the 0-based line index within any of the tracked ranges?
     -+ * (range_set ranges are 0-based, half-open [start, end).)  This is a
     -+ * one-shot query for a single line and scans; the streaming filter
     -+ * (line_range_line_fn) uses a forward cursor instead.
     -+ */
      +static int idx_in_ranges(const struct range_set *ranges, long idx)
      +{
      +	unsigned int i;
     @@ diff.c: static void builtin_checkdiff(const char *name_a, const char *name_b,
       			check_blank_at_eof(&mf1, &mf2, &ecbdata);
       			blank_at_eof = ecbdata.blank_at_eof_in_postimage;
       
     -+			/*
     -+			 * check_blank_at_eof() scans the whole file; with -L,
     -+			 * keep the report only when its line is in a tracked
     -+			 * range.  The error's location is the first trailing
     -+			 * blank line (blank_at_eof, 1-based; ranges 0-based), so
     -+			 * we scope by that line.
     -+			 */
      +			if (blank_at_eof && line_ranges &&
      +			    !idx_in_ranges(line_ranges, blank_at_eof - 1))
      +				blank_at_eof = 0;
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
       	if (revs->expand_tabs_in_log < 0)
      
       ## t/t4211-line-log.sh ##
     -@@ t/t4211-line-log.sh: test_expect_success '--summary shows new file on root commit' '
     - 	test_grep "create mode 100644 file.c" actual
     +@@ t/t4211-line-log.sh: test_expect_success 'get_commit_action() does not mutate a not-yet-walked commit
     + 	)
       '
       
      +test_expect_success 'setup for --check test' '
     @@ t/t4211-line-log.sh: test_expect_success '--summary shows new file on root commi
      +	git add check.c &&
      +	test_tick &&
      +	git commit -m "add check.c" &&
     -+	# Introduce trailing whitespace errors in both functions
      +	sed "s/return;/return; /" check.c >check.c.tmp &&
      +	mv check.c.tmp check.c &&
      +	git commit -a -m "introduce trailing whitespace"
      +'
      +
     -+test_expect_success '--check scoped to tracked range with correct file line' '
     -+	# tracked() trailing whitespace is at check.c:3; report it with the
     -+	# real file line number, not a count from the start of the range
     -+	# hunk.  other() at check.c:8 is outside the range and is excluded.
     -+	test_must_fail git log -L:tracked:check.c --check --format= >actual &&
     -+	test_grep "check.c:3: trailing whitespace" actual &&
     -+	test_grep ! "check.c:8:" actual
     -+'
     ++test_expect_success '--check is limited to tracked ranges and reports real file line numbers' '
     ++	test_must_fail git log -L:tracked:check.c --check --format= >raw &&
     ++	grep -E ":[0-9]+:" raw >actual &&
     ++	echo "check.c:3: trailing whitespace." >expect &&
     ++	test_cmp expect actual &&
      +
     -+test_expect_success '--check reports each of several tracked ranges' '
     -+	# Track both functions as separate ranges.  Each range is flushed
     -+	# as its own hunk, so the second error must report its real file
     -+	# line (check.c:8), not continue the numbering from the first
     -+	# range (check.c:3).
      +	test_must_fail git log -L:tracked:check.c -L:other:check.c \
     -+		--check --format= >actual &&
     -+	test_grep "check.c:3: trailing whitespace" actual &&
     -+	test_grep "check.c:8: trailing whitespace" actual
     ++		--check --format= >raw &&
     ++	grep -E ":[0-9]+:" raw >actual &&
     ++	cat >expect <<-\EOF &&
     ++	check.c:3: trailing whitespace.
     ++	check.c:8: trailing whitespace.
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success '--check line numbers stay correct across a gap in one range' '
     ++test_expect_success '--check reports each error at its real line across a gap in one range' '
      +	git checkout --orphan check-gap &&
      +	git reset --hard &&
      +	cat >gap.c <<-\EOF &&
     @@ t/t4211-line-log.sh: test_expect_success '--summary shows new file on root commi
      +	git add gap.c &&
      +	test_tick &&
      +	git commit -m "add gap.c" &&
     -+	# Two trailing-whitespace errors within one tracked range,
     -+	# separated by clean lines.  ctxlen is inflated to the range span,
     -+	# so they land in a single xdiff hunk with the gap as context;
     -+	# both must report their real file line number, with the context
     -+	# lines between them counted.
      +	sed -e "s/int a = 1;/int a = 1; /" -e "s/int g = 7;/int g = 7; /" gap.c >tmp &&
      +	mv tmp gap.c &&
      +	git commit -a -m "ws errors with a gap" &&
     -+	test_must_fail git log -L:tracked:gap.c --check --format= >actual &&
     -+	test_grep "gap.c:3: trailing whitespace" actual &&
     -+	test_grep "gap.c:8: trailing whitespace" actual
     ++	test_must_fail git log -L:tracked:gap.c --check --format= >raw &&
     ++	grep -E ":[0-9]+:" raw >actual &&
     ++	cat >expect <<-\EOF &&
     ++	gap.c:3: trailing whitespace.
     ++	gap.c:8: trailing whitespace.
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success '--check does not report blank-at-eof outside the range' '
     @@ t/t4211-line-log.sh: test_expect_success '--summary shows new file on root commi
      +	git add eof.c &&
      +	test_tick &&
      +	git commit -m "add eof.c" &&
     -+	# One commit introduces a trailing-whitespace error inside tracked()
     -+	# (line 3) and a blank line at end of file (line 7, outside the
     -+	# range).  The blank-at-eof check scans the whole file, so it must be
     -+	# scoped: report the in-range error, not the out-of-range EOF blank.
      +	printf "void tracked()\n{\n    return; \n}\n\nint tail = 1;\n\n" >eof.c &&
      +	git commit -a -m "ws in range, blank at eof out of range" &&
     -+	test_must_fail git log -L:tracked:eof.c --check --format= >actual &&
     -+	test_grep "eof.c:3: trailing whitespace" actual &&
     -+	test_grep ! "blank line at EOF" actual
     ++	test_must_fail git log -L:tracked:eof.c --check --format= >raw &&
     ++	grep -E ":[0-9]+:" raw >actual &&
     ++	echo "eof.c:3: trailing whitespace." >expect &&
     ++	test_cmp expect actual
      +'
      +
       test_done
 7:  df83e6275b ! 7:  cff5c124ec diffcore-pickaxe: scope -G to the -L tracked range
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    diffcore-pickaxe: scope -G to the -L tracked range
     +    diffcore-pickaxe: limit -G to the -L tracked range
      
     -    git log -L scopes its diff output to the tracked range, but pickaxe
     -    (-S, -G) still runs in diffcore over the whole-file change, so -L -G
     -    selects a commit whenever the pattern appears in any added or removed
     -    line of the file, even outside the tracked range.
     +    Teach -G to only search the line ranges specified by -L.
     +    Teaching -S is left as future work, so it still matches the entire
     +    file even if -L is specified.
      
     -    Teach -G to honor the range.  diff_grep() already runs an xdiff pass
     -    and greps the +/- lines; route that pass through the line-range filter
     -    so only the tracked range's lines are grepped.  Expose the filter as
     -    diff_emit_line_ranges(), an xdi_diff_outf() that emits only the tracked
     -    range's lines, thread the filepair's line_ranges through the pickaxe
     -    callback, and pass it from pickaxe_match().  Skip scoping under
     -    textconv, whose output is not in the original file's line coordinates.
     +    Rather than being part of diff.c's builtin implementations, the
     +    diffcore-pickaxe functionality interacts with xdiff-interface as a
     +    separate component. Add a sibling to xdi_diff_outf(), called
     +    diff_emit_line_ranges(), that limits emitted lines to the given line
     +    ranges.
      
     -    -G needs only a hit/no-hit answer, so the line-number concerns the
     -    filter handles for patch and check output do not apply here.
     +    Use diff_emit_line_ranges() when searching text if line ranges have
     +    been specified. If textconv is enabled, use normal diffing instead of
     +    diff_emit_line_ranges() since line range tracking relies on the line
     +    coordinates of the original, pre-textconv file.
      
     -    -S is left matching the whole file: it counts needle occurrences per
     -    blob rather than grepping the diff, so scoping it needs a different
     -    approach, left to a follow-up.  has_changes() takes the range parameter
     -    but ignores it for now.
     -
     -    Document the resulting -L pickaxe scoping: -G is scoped to the tracked
     -    range, while -S still matches the whole file.
     +    Update documentation and add tests accordingly.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/line-range-options.adoc
       Patch formatting options such as `--word-diff`, `--color-moved`,
       `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
      -as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
     -+as are pickaxe options (`-S`, `-G`) and `--diff-filter`.  `-G` is
     -+scoped to the tracked range; `-S` is still evaluated over the whole
     -+file, so an `-S` query may select a commit for a change outside the
     -+range.
     ++as are pickaxe options (`-S`, `-G`) and `--diff-filter`. `-G` is
     ++limited to the tracked range. In contrast, `-S` is evaluated over the whole
     ++file and may select a commit with a change outside the tracked range.
       +
       include::line-range-format.adoc[]
      
     @@ diff.c: static int line_range_filter_diff(struct line_range_filter *filter,
       	return ret;
       }
       
     -+/*
     -+ * Expose the in-file line-range filter to callers outside diff.c (e.g.
     -+ * pickaxe -G); see xdiff-interface.h for the contract.
     -+ */
      +int diff_emit_line_ranges(mmfile_t *one, mmfile_t *two,
      +			  const struct range_set *ranges,
      +			  xdiff_emit_line_fn line_fn, void *cb_data,
     @@ diffcore-pickaxe.c: static int diffgrep_consume(void *priv, char *line, unsigned
       {
       	struct diffgrep_cb ecbdata;
       	xpparam_t xpp;
     -@@ diffcore-pickaxe.c: static int diff_grep(mmfile_t *one, mmfile_t *two,
     - 	int ret;
     - 
     - 	/*
     --	 * We have both sides; need to run textual diff and see if
     --	 * the pattern appears on added/deleted lines.
     -+	 * We have both sides; need to run textual diff and see if the
     -+	 * pattern appears on added/deleted lines.  Under -L (ranges set),
     -+	 * forward only the tracked range's lines so the match is scoped.
     -+	 * -G needs only a hit/no-hit answer, so the line-number bookkeeping
     -+	 * the filter does for -L patch and check output is irrelevant here.
     - 	 */
     - 	memset(&xpp, 0, sizeof(xpp));
     - 	memset(&xecfg, 0, sizeof(xecfg));
      @@ diffcore-pickaxe.c: static int diff_grep(mmfile_t *one, mmfile_t *two,
       	 * An xdiff error might be our "data->hit" from above. See the
       	 * comment for xdiff_emit_line_fn in xdiff-interface.h
     @@ diffcore-pickaxe.c: static unsigned int contains(mmfile_t *mf, regex_t *regexp,
      +		       const struct range_set *ranges UNUSED)
       {
      +	/*
     -+	 * -S counts needle occurrences in each whole blob.  Scoping this to
     -+	 * a -L range is left to a follow-up; for now -S ignores the range.
     ++	 * -S counts needle occurrences in each whole blob. Limiting this to
     ++	 * an -L range is left as a follow-up; for now -S ignores the range.
      +	 */
       	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
       	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
     @@ diffcore-pickaxe.c: static int pickaxe_match(struct diff_filepair *p, struct dif
       
      -	ret = fn(&mf1, &mf2, o, regexp, kws);
      +	/*
     -+	 * -L scopes the search to the tracked range, but the range is in
     -+	 * original-file line coordinates that do not map onto textconv
     -+	 * output, so search the whole file when textconv is in play.
     ++	 * -L limits the search to the tracked range, but the range is in
     ++	 * pre-textconv line coordinates that do not map onto textconv
     ++	 * output, so search the whole file when textconv is enabled.
      +	 */
      +	ranges = (textconv_one || textconv_two) ? NULL : p->line_ranges;
      +	ret = fn(&mf1, &mf2, o, regexp, kws, ranges);
     @@ diffcore-pickaxe.c: static int pickaxe_match(struct diff_filepair *p, struct dif
       		free(mf1.ptr);
      
       ## t/t4211-line-log.sh ##
     -@@ t/t4211-line-log.sh: test_expect_success '-L with -S filters to string-count changes' '
     - test_expect_success '-L with -G filters to diff-text matches' '
     +@@ t/t4211-line-log.sh: test_expect_success '-L suppresses deletions outside tracked range' '
     + 	test $(grep -c "^diff --git" actual) = 1
     + '
     + 
     +-test_expect_success '-L with -S filters to string-count changes' '
     ++test_expect_success '-L with -S selects only the matching commit' '
     + 	git checkout parent-oids &&
     +-	git log -L:func2:file.c -S "F2 + 2" --format= >actual &&
     +-	# -S searches the whole file, not just the tracked range;
     +-	# combined with the -L range walk, this selects commits that
     +-	# both touch func2 and change the count of "F2 + 2" in the file.
     +-	test $(grep -c "^diff --git" actual) = 1 &&
     +-	test_grep "F2 + 2" actual
     ++	git log -L:func2:file.c -S "F2 + 2" --format=%s --no-patch >actual &&
     ++	echo "Modify func2() in file.c" >expect &&
     ++	test_cmp expect actual
     + '
     + 
     +-test_expect_success '-L with -G filters to diff-text matches' '
     ++test_expect_success '-L with -G selects only the matching commit' '
       	git checkout parent-oids &&
     - 	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
     +-	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
      -	# -G greps the whole-file diff text, not just the tracked range;
      -	# combined with -L, this selects commits that both touch func2
      -	# and have "F2 + 2" in their diff.
     -+	# -G greps the diff text, and under -L only the lines in the
     -+	# tracked range (unlike -S above, which searches the whole file);
     -+	# this selects commits whose change to func2 contains "F2 + 2".
     - 	test $(grep -c "^diff --git" actual) = 1 &&
     - 	grep "F2 + 2" actual
     +-	test $(grep -c "^diff --git" actual) = 1 &&
     +-	test_grep "F2 + 2" actual
     ++	git log -L:func2:file.c -G "F2 [+] 2" --format=%s --no-patch >actual &&
     ++	echo "Modify func2() in file.c" >expect &&
     ++	test_cmp expect actual
       '
     + 
     + test_expect_success 'setup for trailing deletion test' '
      @@ t/t4211-line-log.sh: test_expect_success '--check does not report blank-at-eof outside the range' '
     - 	test_grep ! "blank line at EOF" actual
     + 	test_cmp expect actual
       '
       
     -+test_expect_success '-L -G is scoped to the tracked range' '
     -+	git checkout --orphan grep-scope &&
     ++test_expect_success '-L -G is limited to the tracked range' '
     ++	git checkout --orphan grep-range &&
      +	git reset --hard &&
      +	cat >gp.c <<-\EOF &&
      +	int func1()
     @@ t/t4211-line-log.sh: test_expect_success '--check does not report blank-at-eof o
      +	sed -e "s/ALPHA/ALPHA2/" -e "s/BETA/BETA2/" gp.c >tmp &&
      +	mv tmp gp.c &&
      +	git commit -a -m "touch both functions" &&
     -+	# The commit changes ALPHA (func1) and BETA (func2).  Tracking func2,
     -+	# -G BETA matches its in-range change; -G ALPHA must not, since ALPHA
     -+	# changes only outside the tracked range.
     -+	git log -L:func2:gp.c -G BETA --format=%s >actual &&
     -+	test_grep "touch both functions" actual &&
     -+	git log -L:func2:gp.c -G ALPHA --format=%s >actual &&
     -+	test_grep ! "touch both functions" actual
     ++	git log -L:func2:gp.c -G BETA --format=%s --no-patch >actual &&
     ++	cat >expect <<-\EOF &&
     ++	touch both functions
     ++	add gp.c
     ++	EOF
     ++	test_cmp expect actual &&
     ++	git log -L:func2:gp.c -G ALPHA --format=%s --no-patch >actual &&
     ++	test_must_be_empty actual
      +'
      +
      +test_expect_success '-L -G searches the whole file under textconv' '
     @@ t/t4211-line-log.sh: test_expect_success '--check does not report blank-at-eof o
      +	git add tc.c &&
      +	test_tick &&
      +	git commit -m "add tc.c" &&
     -+	# One commit changes func1 and func2; MAGIC lands only in the
     -+	# func2 change, outside func1.
     -+	sed -e "s/F1/F1 + 1/" -e "s/return F2/return MAGIC/" tc.c >tmp &&
     ++	sed -e "s/F1/F1 + 1/" -e "s/return F2/return FINDME/" tc.c >tmp &&
      +	mv tmp tc.c &&
      +	git commit -a -m "change both funcs" &&
      +	echo "tc.c diff=tc" >.gitattributes &&
     -+
     -+	# Without a textconv driver, -G is scoped to func1, so MAGIC (only
     -+	# in the func2 change) does not select the commit.
     -+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
     ++	git log -L:func1:tc.c -G FINDME --format=%s --no-patch >actual &&
      +	test_must_be_empty actual &&
     -+
     -+	# A textconv driver makes the range (original-file line numbers)
     -+	# meaningless against the driver output, so -G falls back to the
     -+	# whole file and MAGIC now selects the commit.
      +	git config diff.tc.textconv cat &&
     -+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
     -+	test_grep "change both funcs" actual
     ++	git log -L:func1:tc.c -G FINDME --format=%s --no-patch >actual &&
     ++	echo "change both funcs" >expect &&
     ++	test_cmp expect actual
      +'
      +
       test_done
     @@ xdiff-interface.h: int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
      +struct range_set;
      +/*
      + * Like xdi_diff_outf(), but forwards only the lines within the given
     -+ * (post-image) line ranges to line_fn, as "git log -L" scopes its output.
     -+ * Returns line_fn's latched return value (so a consumer can signal a hit
     -+ * with a non-zero return), or non-zero on xdiff failure.  Defined in
     -+ * diff.c (it reuses the line-range filter there).
     ++ * postimage line ranges to line_fn.
      + */
      +int diff_emit_line_ranges(mmfile_t *mf1, mmfile_t *mf2,
      +			  const struct range_set *ranges,

-- 
gitgitgadget
