Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266545A0FF
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308745; cv=none; b=dDgg/iZ8vmgiO8vJm9Ev0KDgFhY7SxwlvGG8D6DozH68RZNC7E+p/GRkLO7dMtbJ/01Mb12C8b7AyaJ8jqP0rZ3Dtu0rTfMsV/8H46cSHCWBx6Jo4X/KT0BMFsQlrM30/GDTjPqQXqp9he48qn9ZPlwuGfCAwpbx+tkhOUbpA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308745; c=relaxed/simple;
	bh=iIWLptn1y39zPd/mndnwdtXlNI251Z+LqZwYXP7m0m0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=lV2sAl9Rno3nRQq3ncqZLuJNexGSgbqNRDAmvIjRiHtlKl/pYx0S6vDE37oscZsd+RaLARnN8Wyy7c3aq7Lt+qjDqnq/w6xzPKe6DTAoo55IFuKY+3PFm2uaFULBSRWXcUbsxY1SU/WGy3n9udKPdYiQmdIRmHC+zGRGja7BlhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbnBO5bK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbnBO5bK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392d417a9fso464615f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706308740; x=1706913540; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuftQfuaOaWPOYHPAAHHpjlup/lPI20pAormoE1sGPc=;
        b=PbnBO5bKP1nJ5b826GrsmCFc/LVJiwV+mYwj4fsF0ipJQLWrch9V216rjTrUw6lSrE
         vbSYtdZziZjG+39b8vxf8VJMllFBA3HU4H/t9YkP1a2CUqmkVw+PIwLa9cP9IIpSBLjF
         ArPvZ2spO4r4trJEhI2QLwlIBlTFeOnKLmbaiqWM0ISbZzYD7CUFNe11BPM00g+DK2Sm
         EmTkB/t64yOeWgF1P3EYDFJxufj9EKrBSC/IQowd7BYXWo23XGg0xPxH01scGdEtTCXb
         2/hsR7FcXhMZRe040BtAE1yUOPesFecPzmwqhiLsVx3fBbvsTVCrgKf0eVRDXD4nIIp0
         9PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308740; x=1706913540;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuftQfuaOaWPOYHPAAHHpjlup/lPI20pAormoE1sGPc=;
        b=S1yfH9ELEtNGo02iv5aMndHEfg3x5mcZIFPtzpxmhPDdwpKaxCbtNmG6rqZ0+E4MOr
         JmT4xriB6FyLsKVrfE9nezK0qVUUH0ICarySkLBCJeLN0pOo2vf5zGLdu3A3urHXrpPr
         FfkUv7ODlfK/ilqNczgJBptZZ5SxkbaD1So3ksBjdx+Y4QYpTznfUAbSRa/wNxSs9jY0
         ggq6cdDxw8GHxllLM3PWHKxgDPDyAj2MEqDk+BYJE8UqMvRVLeCnjvgFMSuaHys3M+4I
         kqxXA/QSdrhx+gqjQ/kORCICwm8uu9AeAiDP2RWTSy7Ln1YVzGEWHl63mchdoPxw/S5A
         l55A==
X-Gm-Message-State: AOJu0Yz8Op9OpPruZ5DkZiHDOmYLCdMNH3t6wtVcaPn6FfV13QrwQmQE
	PcWFOrW85bDagmSX7Ms8i0VzF7z62iF7xmYAYkFZQrQUXFTJLK/ermn9io3s
X-Google-Smtp-Source: AGHT+IHAOWEADWoOHei+VS0LW4ikuyMQV9R/1k4Whull8u6JFzuZ7b4fwlt2WomRTwZBnFeqdjRTMA==
X-Received: by 2002:adf:ce91:0:b0:337:bfb4:346a with SMTP id r17-20020adfce91000000b00337bfb4346amr341618wrn.59.1706308739484;
        Fri, 26 Jan 2024 14:38:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d69d2000000b003393457afc2sm2101099wrw.95.2024.01.26.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:38:59 -0800 (PST)
Message-ID: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 22:38:47 +0000
Subject: [PATCH v2 00/10] Enrich Trailer API
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>

This patch series is the first 10 patches of a larger cleanup/bugfix series
(henceforth "larger series") I've been working on. The main goal of this
series is to begin the process of "libifying" the trailer API. By "API" I
mean the interface exposed in trailer.h. The larger series brings a number
of additional cleanups (exposing and fixing some bugs along the way), and
builds on top of this series.

When the larger series is merged, we will be in a good state to additionally
pursue the following goals:

 1. "API reuse inside Git": make the API expressive enough to eliminate any
    need by other parts of Git to use the interpret-trailers builtin as a
    subprocess (instead they could just use the API directly);
 2. "API stability": add unit tests to codify the expected behavior of API
    functions; and
 3. "API documentation": create developer-focused documentation to explain
    how to use the API effectively, noting any API limitations or
    anti-patterns.

The reason why the larger series itself doesn't tackle these goals directly
is because I believe that API code should be thought from the ground up with
a libification-focused perspective. Some structs and functions exposed in
the API today should probably not be libified (read: kept in trailer.h) as
is. For example, the "trailer_iterator" struct has a "private" member and it
feels wrong to allow API users to peek inside here (and take at face value
our future API users' pinky promise that they won't depend on those private
internals not meant for public consumption).

One pattern we could use here to cleanly separate "what is the API"
(publicly exposed) and "what is the implementation" (private) is the
pointer-to-implementation ("pimpl") idiom. There may be other appropriate
patterns, but I've chosen this one because it's a simple, low-level concept
(put structs in foo.c instead of foo.h), which has far-reaching high-level
consequences (API users must rely exclusively on the API to make use of such
private structs, via opaque pointers). The pimpl idiom for C comes from the
book "C Interfaces and Implementations" (see patch "trailer: make
trailer_info struct private").

The idea of turning a public struct into a private one is a fundamental
question of libification because it forces us to reconsider all of the data
structures we have and how they're actually used by already existing users.
For the trailer API, those existing users are the "interpret-trailers"
builtin command, and anything else that includes the "trailer.h" header file
(e.g., sequencer.c). One advantage of this idiom is that even the compiler
understands it --- the compiler will loudly complain if you try to access
the innards of a private struct through an opaque pointer.

Another advantage of this idiom is that it helps to reduce the probability
of breaking changes in the API. Because a private struct's members are out
of view from our users (they only know about opaque pointers to the private
struct, not its members), we are free to modify the members of the struct at
any time, as much as we like, as long as we don't break the semantics of the
exposed API functions (which is why unit-testing these API functions will be
crucial long-term).

If this pimpl idiom turns out to be a mistake, undoing it is easy --- just
move the relevant struct definition from foo.c to the header file. So it's a
great way to try things out without digging ourselves into a pit of despair
that will be difficult to get out of.

With the libification-focused goals out of the way, let's turn to this patch
series in more detail.

Currently, we have "process_trailers()" in trailer.h which does many
different things (parse command-line arguments, create temporary files, etc)
that are independent of the concept of "trailers". Keeping this function as
an API function would make unit-testing it difficult. While there is no
technical reason why we couldn't write unit tests for the smaller functions
that are called within process_trailers(), doing so would involve testing
private ("static" in trailer.c) functions instead of API functions, which
defeats the goal of "API stability" mentioned earlier above.

As an alternative to how things are done in this patch series, we could keep
trailer.h intact and decide to unit-test the existing "trailer_info_get()"
function which does most of the trailer parsing work (and is used by
sequencer.c). However this function wouldn't be easy to test either, because
the resulting "trailer_info" struct merely contains the unparsed "trailers"
lines. So the unit test (if it wants to inspect the result of parsing these
lines) would have to invoke additional parsing functions itself. And at that
point it would no longer be a unit test in the traditional sense, because it
would be invoking multiple functions at once.

In summary this series breaks up "process_trailers()" into smaller pieces,
exposing many of the parts relevant to trailer-related processing in
trailer.h. This will force us to eventually introduce unit tests for these
API functions, but that is a good thing for API stability.

In the future after libification is "complete", users external to Git will
be able to use the same trailer processing API used by the
interpret-trailers builtin. For example, a web server may want to parse
trailers the same way that Git would parse them, without having to call
interpret-trailers as a subprocess. This use case was the original
motivation behind my work in this area.

Thanks to the aggressive refactoring in this series, I've been able to
identify and fix several bugs in our existing implementation. Those fixes
build on top of this series but were not included here, in order to keep
this series small. Below is a "shortlog" of those fixes I have locally:

 * "trailer: trailer replacement should not change its position" (If we
   found a trailer we'd like to replace, preserve its position relative to
   the other trailers found in the trailer block, instead of always moving
   it to the beginning or end of the entire trailer block.)
 * "interpret-trailers: preserve trailers coming from the input" (Sometimes,
   the parsed trailers from the input will be formatted differently
   depending on whether we provide --only-trailers or not. Make the trailers
   that were not modified and which are coming directly from the input get
   formatted the same way, regardless of this flag.)
 * "interpret-trailers: do not modify the input if NOP" (Refrain from
   subtracting or adding a newline around the patch divider "---" if we are
   not adding new trailers.)
 * "trailer formatter: split up format_trailer() monolith" (Fix a bug in
   git-log where we still printed a blank newline even if we didn't want to
   format anything.)
 * "interpret-trailers: fail if given unrecognized arguments" (E.g., for
   "--where", only accept recognized WHERE_* enum values. If we get
   something unrecognized, fail with an error instead of silently doing
   nothing. Ditto for "--if-exists" and "--if-missing".)


Notable changes in v2
=====================

 * Reorder function parameters to have trailer options at the beginning (and
   out parameters toward the end)
 * "sequencer: use the trailer iterator": prefer C string instead of strbuf
   for new "raw" field
 * Patch 1 (was Patch 2) also renames ensure_configured() to
   trailer_config_init() (forgot to rename this one previously)

Linus Arver (10):
  trailer: prepare to expose functions as part of API
  trailer: move interpret_trailers() to interpret-trailers.c
  trailer: unify trailer formatting machinery
  trailer: delete obsolete formatting functions
  sequencer: use the trailer iterator
  trailer: make trailer_info struct private
  trailer: spread usage of "trailer_block" language
  trailer: prepare to move parse_trailers_from_command_line_args() to
    builtin
  trailer: move arg handling to interpret-trailers.c
  trailer: delete obsolete argument handling code from API

 builtin/interpret-trailers.c | 169 ++++++++--
 builtin/shortlog.c           |   7 +-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 sequencer.c                  |  35 +--
 trailer.c                    | 576 ++++++++++++++++-------------------
 trailer.h                    | 105 ++++---
 7 files changed, 478 insertions(+), 418 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1632

Range-diff vs v1:

  2:  5f64718abfc !  1:  e2d3ed9b5b6 trailer: include "trailer" term in API functions
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: include "trailer" term in API functions
     +    trailer: prepare to expose functions as part of API
      
     -    These functions are exposed to clients and so they should include
     -    "trailer" in their names for easier identification, just like all the
     -    other functions already exposed by trailer.h.
     +    In the next patch, we will move "process_trailers" from trailer.c to
     +    builtin/interpret-trailers.c. That move will necessitate the growth of
     +    the trailer.h API, forcing us to expose some additional functions in
     +    trailer.h.
      
     +    Rename relevant functions so that they include the term "trailer" in
     +    their name, so that clients of the API will be able to easily identify
     +    them by their "trailer" moniker, just like all the other functions
     +    already exposed by trailer.h.
     +
     +    The the opportunity to start putting trailer processions options (opts)
     +    as the first parameter. This will be the pattern going forward in this
     +    series.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     - 	struct trailer_info info;
     - 	FILE *outfile = stdout;
     - 
     --	ensure_configured();
     -+	trailer_config_init();
     - 
     - 	read_input_file(&sb, file);
     - 
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     - 		process_trailers_lists(&head, &arg_head);
     +@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     + 	if (argc) {
     + 		int i;
     + 		for (i = 0; i < argc; i++)
     +-			process_trailers(argv[i], &opts, &trailers);
     ++			interpret_trailers(&opts, &trailers, argv[i]);
     + 	} else {
     + 		if (opts.in_place)
     + 			die(_("no input file given for in-place editing"));
     +-		process_trailers(NULL, &opts, &trailers);
     ++		interpret_trailers(&opts, &trailers, NULL);
       	}
       
     --	print_all(outfile, &head, opts);
     -+	/* Print trailer block. */
     -+	format_trailers(outfile, &head, opts);
     - 
     --	free_all(&head);
     -+	free_trailers(&head);
     - 	trailer_info_release(&info);
     - 
     - 	/* Print the lines after the trailers as is */
     + 	new_trailers_clear(&trailers);
      
       ## trailer.c ##
      @@ trailer.c: static void print_tok_val(FILE *outfile, const char *tok, const char *val)
       		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
       }
       
     --void print_all(FILE *outfile, struct list_head *head,
     --	       const struct process_trailer_options *opts)
     -+void format_trailers(FILE *outfile, struct list_head *head,
     -+		     const struct process_trailer_options *opts)
     +-static void print_all(FILE *outfile, struct list_head *head,
     +-		      const struct process_trailer_options *opts)
     ++static void format_trailers(const struct process_trailer_options *opts,
     ++			    struct list_head *trailers, FILE *outfile)
       {
       	struct list_head *pos;
       	struct trailer_item *item;
     +-	list_for_each(pos, head) {
     ++	list_for_each(pos, trailers) {
     + 		item = list_entry(pos, struct trailer_item, list);
     + 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
     + 		    (!opts->only_trailers || item->token))
      @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value,
       	return 0;
       }
       
     --void ensure_configured(void)
     -+void trailer_config_init(void)
     +-static void ensure_configured(void)
     ++static void trailer_config_init(void)
       {
       	if (configured)
       		return;
     -@@ trailer.c: void parse_trailers(struct trailer_info *info,
     +@@ trailer.c: static void parse_trailers(struct trailer_info *info,
       	}
       }
       
     --void free_all(struct list_head *head)
     -+void free_trailers(struct list_head *head)
     +-static void free_all(struct list_head *head)
     ++static void free_trailers(struct list_head *trailers)
       {
       	struct list_head *pos, *p;
     - 	list_for_each_safe(pos, p, head) {
     +-	list_for_each_safe(pos, p, head) {
     ++	list_for_each_safe(pos, p, trailers) {
     + 		list_del(pos);
     + 		free_trailer_item(list_entry(pos, struct trailer_item, list));
     + 	}
     +@@ trailer.c: static FILE *create_in_place_tempfile(const char *file)
     + 	return outfile;
     + }
     + 
     +-void process_trailers(const char *file,
     +-		      const struct process_trailer_options *opts,
     +-		      struct list_head *new_trailer_head)
     ++void interpret_trailers(const struct process_trailer_options *opts,
     ++			struct list_head *new_trailer_head,
     ++			const char *file)
     + {
     + 	LIST_HEAD(head);
     + 	struct strbuf sb = STRBUF_INIT;
     + 	struct trailer_info info;
     + 	FILE *outfile = stdout;
     + 
     +-	ensure_configured();
     ++	trailer_config_init();
     + 
     + 	read_input_file(&sb, file);
     + 
     +@@ trailer.c: void process_trailers(const char *file,
     + 		process_trailers_lists(&head, &arg_head);
     + 	}
     + 
     +-	print_all(outfile, &head, opts);
     ++	format_trailers(opts, &head, outfile);
     + 
     +-	free_all(&head);
     ++	free_trailers(&head);
     + 	trailer_info_release(&info);
     + 
     + 	/* Print the lines after the trailers as is */
      @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
       	size_t nr = 0, alloc = 0;
       	char **last = NULL;
     @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
       	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
      
       ## trailer.h ##
     -@@ trailer.h: void trailer_info_get(struct trailer_info *info, const char *str,
     - 
     - void trailer_info_release(struct trailer_info *info);
     - 
     --void ensure_configured(void);
     --void print_all(FILE *outfile, struct list_head *head,
     --	       const struct process_trailer_options *opts);
     --void free_all(struct list_head *head);
     -+void trailer_config_init(void);
     -+void free_trailers(struct list_head *trailers);
     - 
     -+void format_trailers(FILE *outfile, struct list_head *head,
     -+		     const struct process_trailer_options *opts);
     - /*
     -  * Format the trailers from the commit msg "msg" into the strbuf "out".
     -  * Note two caveats about "opts":
     -@@ trailer.h: void free_all(struct list_head *head);
     -  *   - this is primarily a helper for pretty.c, and not
     -  *     all of the flags are supported.
     -  *
     -- *   - this differs from process_trailers slightly in that we always format
     -+ *   - this differs from format_trailers slightly in that we always format
     -  *     only the trailer block itself, even if the "only_trailers" option is not
     -  *     set.
     -  */
     +@@ trailer.h: struct process_trailer_options {
     + 
     + #define PROCESS_TRAILER_OPTIONS_INIT {0}
     + 
     +-void process_trailers(const char *file,
     +-		      const struct process_trailer_options *opts,
     +-		      struct list_head *new_trailer_head);
     ++void interpret_trailers(const struct process_trailer_options *opts,
     ++			struct list_head *new_trailer_head,
     ++			const char *file);
     + 
     + void trailer_info_get(struct trailer_info *info, const char *str,
     + 		      const struct process_trailer_options *opts);
  1:  2dc3279b37f !  2:  eaca39fd7ea trailer: move process_trailers() to interpret-trailers.c
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: move process_trailers() to interpret-trailers.c
     +    trailer: move interpret_trailers() to interpret-trailers.c
      
          The interpret-trailers.c builtin is the only place we need to call
     -    process_trailers(). As it stands, process_trailers() is inherently tied
     -    to how the builtin behaves, so move its definition there.
     +    interpret_trailers(), so move its definition there.
      
          Delete the corresponding declaration from trailer.h, which then forces
          us to expose the working innards of that function. This enriches
     -    trailer.h to include a more granular API, which can then be unit-tested
     -    in the future (because process_trailers() by itself does too many things
     -    to be able to be easily unit-tested).
     +    trailer.h with a more granular API, which can then be unit-tested in the
     +    future (because interpret_trailers() by itself does too many things to
     +    be able to be easily unit-tested).
      
          Take this opportunity to demote some file-handling functions out of the
          trailer API implementation, as these have nothing to do with trailers.
      
     -    While we're at it, rename process_trailers() to interpret_trailers() in
     -    the builtin for consistency with the existing cmd_interpret_trailers(),
     -    which wraps around this function.
     -
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     @@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *op
      +	}
      +}
      +
     -+static void interpret_trailers(const char *file,
     -+			       const struct process_trailer_options *opts,
     -+			       struct list_head *new_trailer_head)
     ++static void interpret_trailers(const struct process_trailer_options *opts,
     ++			       struct list_head *new_trailer_head,
     ++			       const char *file)
      +{
      +	LIST_HEAD(head);
      +	struct strbuf sb = STRBUF_INIT;
      +	struct trailer_info info;
      +	FILE *outfile = stdout;
      +
     -+	ensure_configured();
     ++	trailer_config_init();
      +
      +	read_input_file(&sb, file);
      +
      +	if (opts->in_place)
      +		outfile = create_in_place_tempfile(file);
      +
     -+	parse_trailers(&info, sb.buf, &head, opts);
     ++	parse_trailers(opts, &info, sb.buf, &head);
      +
      +	/* Print the lines before the trailers */
      +	if (!opts->only_trailers)
     @@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *op
      +		process_trailers_lists(&head, &arg_head);
      +	}
      +
     -+	print_all(outfile, &head, opts);
     ++	format_trailers(opts, &head, outfile);
      +
     -+	free_all(&head);
     ++	free_trailers(&head);
      +	trailer_info_release(&info);
      +
      +	/* Print the lines after the trailers as is */
     @@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *op
       int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
       {
       	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     -@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     - 	if (argc) {
     - 		int i;
     - 		for (i = 0; i < argc; i++)
     --			process_trailers(argv[i], &opts, &trailers);
     -+			interpret_trailers(argv[i], &opts, &trailers);
     - 	} else {
     - 		if (opts.in_place)
     - 			die(_("no input file given for in-place editing"));
     --		process_trailers(NULL, &opts, &trailers);
     -+		interpret_trailers(NULL, &opts, &trailers);
     - 	}
     - 
     - 	new_trailers_clear(&trailers);
      
       ## trailer.c ##
      @@
     @@ trailer.c: static void print_tok_val(FILE *outfile, const char *tok, const char
       		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
       }
       
     --static void print_all(FILE *outfile, struct list_head *head,
     --		      const struct process_trailer_options *opts)
     -+void print_all(FILE *outfile, struct list_head *head,
     -+	       const struct process_trailer_options *opts)
     +-static void format_trailers(const struct process_trailer_options *opts,
     +-			    struct list_head *trailers, FILE *outfile)
     ++void format_trailers(const struct process_trailer_options *opts,
     ++		     struct list_head *trailers, FILE *outfile)
       {
       	struct list_head *pos;
       	struct trailer_item *item;
     @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value
       	return 0;
       }
       
     --static void ensure_configured(void)
     -+void ensure_configured(void)
     +-static void trailer_config_init(void)
     ++void trailer_config_init(void)
       {
       	if (configured)
       		return;
     @@ trailer.c: static void unfold_value(struct strbuf *val)
      -			     const char *str,
      -			     struct list_head *head,
      -			     const struct process_trailer_options *opts)
     -+void parse_trailers(struct trailer_info *info,
     ++void parse_trailers(const struct process_trailer_options *opts,
     ++		    struct trailer_info *info,
      +		    const char *str,
     -+		    struct list_head *head,
     -+		    const struct process_trailer_options *opts)
     ++		    struct list_head *head)
       {
       	struct strbuf tok = STRBUF_INIT;
       	struct strbuf val = STRBUF_INIT;
     @@ trailer.c: static void parse_trailers(struct trailer_info *info,
       	}
       }
       
     --static void free_all(struct list_head *head)
     -+void free_all(struct list_head *head)
     +-static void free_trailers(struct list_head *trailers)
     ++void free_trailers(struct list_head *trailers)
       {
       	struct list_head *pos, *p;
     - 	list_for_each_safe(pos, p, head) {
     -@@ trailer.c: static void free_all(struct list_head *head)
     + 	list_for_each_safe(pos, p, trailers) {
     +@@ trailer.c: static void free_trailers(struct list_head *trailers)
       	}
       }
       
     @@ trailer.c: static void free_all(struct list_head *head)
      -	return outfile;
      -}
      -
     --void process_trailers(const char *file,
     --		      const struct process_trailer_options *opts,
     --		      struct list_head *new_trailer_head)
     +-void interpret_trailers(const struct process_trailer_options *opts,
     +-			struct list_head *new_trailer_head,
     +-			const char *file)
      -{
      -	LIST_HEAD(head);
      -	struct strbuf sb = STRBUF_INIT;
      -	struct trailer_info info;
      -	FILE *outfile = stdout;
      -
     --	ensure_configured();
     +-	trailer_config_init();
      -
      -	read_input_file(&sb, file);
      -
     @@ trailer.c: static void free_all(struct list_head *head)
      -		process_trailers_lists(&head, &arg_head);
      -	}
      -
     --	print_all(outfile, &head, opts);
     +-	format_trailers(opts, &head, outfile);
      -
     --	free_all(&head);
     +-	free_trailers(&head);
      -	trailer_info_release(&info);
      -
      -	/* Print the lines after the trailers as is */
     @@ trailer.h: struct process_trailer_options {
       
       #define PROCESS_TRAILER_OPTIONS_INIT {0}
       
     --void process_trailers(const char *file,
     --		      const struct process_trailer_options *opts,
     --		      struct list_head *new_trailer_head);
     +-void interpret_trailers(const struct process_trailer_options *opts,
     +-			struct list_head *new_trailer_head,
     +-			const char *file);
      +void parse_trailers_from_config(struct list_head *config_head);
      +
      +void parse_trailers_from_command_line_args(struct list_head *arg_head,
     @@ trailer.h: struct process_trailer_options {
      +void process_trailers_lists(struct list_head *head,
      +			    struct list_head *arg_head);
      +
     -+void parse_trailers(struct trailer_info *info,
     ++void parse_trailers(const struct process_trailer_options *opts,
     ++		    struct trailer_info *info,
      +		    const char *str,
     -+		    struct list_head *head,
     -+		    const struct process_trailer_options *opts);
     ++		    struct list_head *head);
       
       void trailer_info_get(struct trailer_info *info, const char *str,
       		      const struct process_trailer_options *opts);
       
       void trailer_info_release(struct trailer_info *info);
       
     -+void ensure_configured(void);
     -+void print_all(FILE *outfile, struct list_head *head,
     -+	       const struct process_trailer_options *opts);
     -+void free_all(struct list_head *head);
     ++void trailer_config_init(void);
     ++void format_trailers(const struct process_trailer_options *opts,
     ++		     struct list_head *trailers, FILE *outfile);
     ++void free_trailers(struct list_head *trailers);
      +
       /*
        * Format the trailers from the commit msg "msg" into the strbuf "out".
  3:  d3326021fb6 !  3:  9b7747d550e trailer: unify trailer formatting machinery
     @@ Commit message
          format_trailers() to process trailers with the additional
          process_trailer_options fields like opts->key_only which is only used by
          format_trailers_from_commit() and not builtin/interpret-trailers.c.
     +    While we're at it, reorder parameters to put the trailer processing
     +    options first, and the out parameter (strbuf we write into) at the end.
      
     -    This will allow us to delete the format_trailer_info() and
     +    This unification will allow us to delete the format_trailer_info() and
          print_tok_val() functions in the next patch. They are not deleted here
          in order to keep the diff small.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       {
       	LIST_HEAD(head);
       	struct strbuf sb = STRBUF_INIT;
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       	struct trailer_info info;
       	FILE *outfile = stdout;
       
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     + 		process_trailers_lists(&head, &arg_head);
       	}
       
     - 	/* Print trailer block. */
     --	format_trailers(outfile, &head, opts);
     -+	format_trailers(&head, opts, &trailer_block);
     +-	format_trailers(opts, &head, outfile);
     ++	/* Print trailer block. */
     ++	format_trailers(opts, &head, &trailer_block);
      +	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
      +	strbuf_release(&trailer_block);
       
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
       		}
       		if (*arg == ')') {
      -			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
     -+			format_trailers_from_commit(msg + c->subject_off, &opts, sb);
     ++			format_trailers_from_commit(&opts, msg + c->subject_off, sb);
       			ret = arg - placeholder + 1;
       		}
       	trailer_out:
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
       
       			/* Format the trailer info according to the trailer_opts given */
      -			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
     -+			format_trailers_from_commit(subpos, &atom->u.contents.trailer_opts, &s);
     ++			format_trailers_from_commit(&atom->u.contents.trailer_opts, subpos, &s);
       
       			v->s = strbuf_detach(&s, NULL);
       		} else if (atom->u.contents.option == C_BARE)
     @@ trailer.c: static void print_tok_val(FILE *outfile, const char *tok, const char
       		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
       }
       
     --void format_trailers(FILE *outfile, struct list_head *head,
     --		     const struct process_trailer_options *opts)
     +-void format_trailers(const struct process_trailer_options *opts,
     +-		     struct list_head *trailers, FILE *outfile)
      -{
      -	struct list_head *pos;
      -	struct trailer_item *item;
     --	list_for_each(pos, head) {
     +-	list_for_each(pos, trailers) {
      -		item = list_entry(pos, struct trailer_item, list);
      -		if ((!opts->trim_empty || strlen(item->value) > 0) &&
      -		    (!opts->only_trailers || item->token))
     @@ trailer.c: static void unfold_value(struct strbuf *val)
       	strbuf_release(&out);
       }
       
     -+void format_trailers(struct list_head *head,
     -+		     const struct process_trailer_options *opts,
     ++void format_trailers(const struct process_trailer_options *opts,
     ++		     struct list_head *trailers,
      +		     struct strbuf *out)
      +{
      +	struct list_head *pos;
      +	struct trailer_item *item;
      +	int need_separator = 0;
      +
     -+	list_for_each(pos, head) {
     ++	list_for_each(pos, trailers) {
      +		item = list_entry(pos, struct trailer_item, list);
      +		if (item->token) {
      +			char c;
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
       
      -void format_trailers_from_commit(struct strbuf *out, const char *msg,
      -				 const struct process_trailer_options *opts)
     -+void format_trailers_from_commit(const char *msg,
     -+				 const struct process_trailer_options *opts,
     ++void format_trailers_from_commit(const struct process_trailer_options *opts,
     ++				 const char *msg,
      +				 struct strbuf *out)
       {
      +	LIST_HEAD(head);
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
       
      -	trailer_info_get(&info, msg, opts);
      -	format_trailer_info(out, &info, msg, opts);
     -+	parse_trailers(&info, msg, &head, opts);
     ++	parse_trailers(opts, &info, msg, &head);
      +
      +	/* If we want the whole block untouched, we can take the fast path. */
      +	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
      +		strbuf_add(out, msg + info.trailer_block_start,
      +			   info.trailer_block_end - info.trailer_block_start);
      +	} else
     -+		format_trailers(&head, opts, out);
     ++		format_trailers(opts, &head, out);
      +
      +	free_trailers(&head);
       	trailer_info_release(&info);
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
      
       ## trailer.h ##
      @@ trailer.h: void trailer_info_release(struct trailer_info *info);
     + 
       void trailer_config_init(void);
     + void format_trailers(const struct process_trailer_options *opts,
     +-		     struct list_head *trailers, FILE *outfile);
     ++		     struct list_head *trailers,
     ++		     struct strbuf *out);
       void free_trailers(struct list_head *trailers);
       
     --void format_trailers(FILE *outfile, struct list_head *head,
     --		     const struct process_trailer_options *opts);
     -+void format_trailers(struct list_head *head,
     -+		     const struct process_trailer_options *opts,
     -+		     struct strbuf *out);
       /*
      - * Format the trailers from the commit msg "msg" into the strbuf "out".
      - * Note two caveats about "opts":
     @@ trailer.h: void trailer_info_release(struct trailer_info *info);
      - *   - this is primarily a helper for pretty.c, and not
      - *     all of the flags are supported.
      - *
     -- *   - this differs from format_trailers slightly in that we always format
     +- *   - this differs from process_trailers slightly in that we always format
      - *     only the trailer block itself, even if the "only_trailers" option is not
      - *     set.
      + * Convenience function to format the trailers from the commit msg "msg" into
     @@ trailer.h: void trailer_info_release(struct trailer_info *info);
        */
      -void format_trailers_from_commit(struct strbuf *out, const char *msg,
      -				 const struct process_trailer_options *opts);
     -+void format_trailers_from_commit(const char *msg,
     -+				 const struct process_trailer_options *opts,
     ++void format_trailers_from_commit(const struct process_trailer_options *opts,
     ++				 const char *msg,
      +				 struct strbuf *out);
       
       /*
  4:  8d864614757 !  4:  f1171f5202f trailer: delete obsolete formatting functions
     @@ trailer.c: void trailer_info_release(struct trailer_info *info)
      -
      -}
      -
     - void format_trailers_from_commit(const char *msg,
     - 				 const struct process_trailer_options *opts,
     + void format_trailers_from_commit(const struct process_trailer_options *opts,
     + 				 const char *msg,
       				 struct strbuf *out)
  5:  fd4a9d54d95 !  5:  5ba842b5005 sequencer: use the trailer iterator
     @@ sequencer.c: static const char *get_todo_path(const struct replay_opts *opts)
      +		i++;
      +		if (sob &&
      +		    iter.is_trailer &&
     -+		    !strncmp(iter.raw.buf, sob->buf, sob->len)) {
     ++		    !strncmp(iter.raw, sob->buf, sob->len)) {
      +			found_sob = i;
      +		}
      +	}
     @@ sequencer.c: static const char *get_todo_path(const struct replay_opts *opts)
      
       ## trailer.c ##
      @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
     - 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     - 	strbuf_init(&iter->key, 0);
     - 	strbuf_init(&iter->val, 0);
     -+	strbuf_init(&iter->raw, 0);
     - 	opts.no_divider = 1;
     - 	trailer_info_get(&iter->internal.info, msg, &opts);
     - 	iter->internal.cur = 0;
     -@@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
       
       int trailer_iterator_advance(struct trailer_iterator *iter)
       {
     @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char
      +		separator_pos = find_separator(line, separators);
      +		iter->is_trailer = (separator_pos > 0);
      +
     -+		strbuf_reset(&iter->raw);
     -+		strbuf_addstr(&iter->raw, line);
     ++		iter->raw = line;
       		strbuf_reset(&iter->key);
       		strbuf_reset(&iter->val);
       		parse_trailer(&iter->key, &iter->val, NULL,
     @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char
       		unfold_value(&iter->val);
       		return 1;
       	}
     -@@ trailer.c: void trailer_iterator_release(struct trailer_iterator *iter)
     - 	trailer_info_release(&iter->internal.info);
     - 	strbuf_release(&iter->val);
     - 	strbuf_release(&iter->key);
     -+	strbuf_release(&iter->raw);
     - }
      
       ## trailer.h ##
      @@ trailer.h: struct trailer_iterator {
     @@ trailer.h: struct trailer_iterator {
       
      +	/*
      +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
     -+	 * key/val pair. This field can contain non-trailer lines because it's
     -+	 * valid for a trailer block to contain such lines (i.e., we only
     -+	 * require 25% of the lines in a trailer block to be trailer lines).
     ++	 * key/val pair as part of a trailer block. A trailer block can be
     ++	 * either 100% trailer lines, or mixed in with non-trailer lines (in
     ++	 * which case at least 25% must be trailer lines).
      +	 */
     -+	struct strbuf raw;
     ++	const char *raw;
      +
      +	/*
     -+	 * 1 if the raw line was parsed as a separate key/val pair.
     ++	 * 1 if the raw line was parsed as a trailer line (key/val pair).
      +	 */
      +	int is_trailer;
      +
  6:  0cbe96421c7 !  6:  f0ac2f6c4b9 trailer: make trailer_info struct private
     @@ Commit message
          Make this struct private by putting its definition inside trailer.c.
          This has two benefits:
      
     -    (1) it makes the surface area of the public facing interface (trailer.h)
     -        smaller, and
     +      (1) it makes the surface area of the public facing
     +          interface (trailer.h) smaller, and
      
     -    (2) external API users are unable to peer inside this struct (because it
     -        is only ever exposed as an opaque pointer).
     +      (2) external API users are unable to peer inside this struct (because
     +          it is only ever exposed as an opaque pointer).
      
          This change exposes some deficiencies in the API, mainly with regard to
          information about the location of the trailer block that was parsed.
     @@ Commit message
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	LIST_HEAD(head);
       	struct strbuf sb = STRBUF_INIT;
       	struct strbuf trailer_block = STRBUF_INIT;
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       	FILE *outfile = stdout;
       
       	trailer_config_init();
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	if (opts->in_place)
       		outfile = create_in_place_tempfile(file);
       
     --	parse_trailers(&info, sb.buf, &head, opts);
     -+	info = parse_trailers(sb.buf, &head, opts);
     +-	parse_trailers(opts, &info, sb.buf, &head);
     ++	info = parse_trailers(opts, sb.buf, &head);
       
       	/* Print the lines before the trailers */
       	if (!opts->only_trailers)
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       		fprintf(outfile, "\n");
       
       
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	strbuf_release(&trailer_block);
       
       	free_trailers(&head);
     @@ trailer.c
       struct conf_info {
       	char *name;
       	char *key;
     -@@ trailer.c: void format_trailers(struct list_head *head,
     +@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
       	}
       }
       
     @@ trailer.c: void format_trailers(struct list_head *head,
      +	return info;
      +}
      +
     -+static struct trailer_info *trailer_info_get(const char *str,
     -+					     const struct process_trailer_options *opts)
     ++static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
     ++					     const char *str)
      +{
      +	struct trailer_info *info = trailer_info_new();
      +	size_t end_of_log_message = 0, trailer_block_start = 0;
     @@ trailer.c: void format_trailers(struct list_head *head,
        * Parse trailers in "str", populating the trailer info and "head"
        * linked list structure.
        */
     --void parse_trailers(struct trailer_info *info,
     +-void parse_trailers(const struct process_trailer_options *opts,
     +-		    struct trailer_info *info,
      -		    const char *str,
     --		    struct list_head *head,
     --		    const struct process_trailer_options *opts)
     -+struct trailer_info *parse_trailers(const char *str,
     -+				    struct list_head *head,
     -+				    const struct process_trailer_options *opts)
     +-		    struct list_head *head)
     ++struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     ++				    const char *str,
     ++				    struct list_head *head)
       {
      +	struct trailer_info *info;
       	struct strbuf tok = STRBUF_INIT;
     @@ trailer.c: void format_trailers(struct list_head *head,
       	size_t i;
       
      -	trailer_info_get(info, str, opts);
     -+	info = trailer_info_get(str, opts);
     ++	info = trailer_info_get(opts, str);
       
       	for (i = 0; i < info->trailer_nr; i++) {
       		int separator_pos;
     -@@ trailer.c: void parse_trailers(struct trailer_info *info,
     +@@ trailer.c: void parse_trailers(const struct process_trailer_options *opts,
       					 strbuf_detach(&val, NULL));
       		}
       	}
     @@ trailer.c: void parse_trailers(struct trailer_info *info,
      +	return info;
       }
       
     - void free_trailers(struct list_head *head)
     -@@ trailer.c: void free_trailers(struct list_head *head)
     + void free_trailers(struct list_head *trailers)
     +@@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
     @@ trailer.c: void trailer_info_release(struct trailer_info *info)
      +	free(info);
       }
       
     - void format_trailers_from_commit(const char *msg,
     -@@ trailer.c: void format_trailers_from_commit(const char *msg,
     + void format_trailers_from_commit(const struct process_trailer_options *opts,
     +@@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options *opts,
       				 struct strbuf *out)
       {
       	LIST_HEAD(head);
      -	struct trailer_info info;
      -
     --	parse_trailers(&info, msg, &head, opts);
     -+	struct trailer_info *info = parse_trailers(msg, &head, opts);
     +-	parse_trailers(opts, &info, msg, &head);
     ++	struct trailer_info *info = parse_trailers(opts, msg, &head);
       
       	/* If we want the whole block untouched, we can take the fast path. */
       	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: void format_trailers_from_commit(const char *msg,
      +		strbuf_add(out, msg + info->trailer_block_start,
      +			   info->trailer_block_end - info->trailer_block_start);
       	} else
     - 		format_trailers(&head, opts, out);
     + 		format_trailers(opts, &head, out);
       
       	free_trailers(&head);
      -	trailer_info_release(&info);
     @@ trailer.c: void format_trailers_from_commit(const char *msg,
      +	struct trailer_info *internal = trailer_info_new();
       	strbuf_init(&iter->key, 0);
       	strbuf_init(&iter->val, 0);
     - 	strbuf_init(&iter->raw, 0);
       	opts.no_divider = 1;
      -	trailer_info_get(&iter->internal.info, msg, &opts);
      +	iter->internal.info = internal;
     -+	iter->internal.info = trailer_info_get(msg, &opts);
     ++	iter->internal.info = trailer_info_get(&opts, msg);
       	iter->internal.cur = 0;
       }
       
     @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
      +	trailer_info_release(iter->internal.info);
       	strbuf_release(&iter->val);
       	strbuf_release(&iter->key);
     - 	strbuf_release(&iter->raw);
     + }
      
       ## trailer.h ##
      @@
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
       void process_trailers_lists(struct list_head *head,
       			    struct list_head *arg_head);
       
     --void parse_trailers(struct trailer_info *info,
     +-void parse_trailers(const struct process_trailer_options *opts,
     +-		    struct trailer_info *info,
      -		    const char *str,
     --		    struct list_head *head,
     --		    const struct process_trailer_options *opts);
     -+struct trailer_info *parse_trailers(const char *str,
     -+				    struct list_head *head,
     -+				    const struct process_trailer_options *opts);
     +-		    struct list_head *head);
     ++struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     ++				    const char *str,
     ++				    struct list_head *head);
       
      -void trailer_info_get(struct trailer_info *info, const char *str,
      -		      const struct process_trailer_options *opts);
  7:  9183990583f !  7:  291aa83af55 trailer: spread usage of "trailer_block" language
     @@ Commit message
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       {
       	LIST_HEAD(head);
       	struct strbuf sb = STRBUF_INIT;
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       	FILE *outfile = stdout;
       
       	trailer_config_init();
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	if (opts->in_place)
       		outfile = create_in_place_tempfile(file);
       
     --	info = parse_trailers(sb.buf, &head, opts);
     -+	trailer_block = parse_trailers(sb.buf, opts, &head);
     +-	info = parse_trailers(opts, sb.buf, &head);
     ++	trailer_block = parse_trailers(opts, sb.buf, &head);
       
      -	/* Print the lines before the trailers */
      +	/* Print the lines before the trailer block */
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       		fprintf(outfile, "\n");
       
       
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	}
       
       	/* Print trailer block. */
     --	format_trailers(&head, opts, &trailer_block);
     +-	format_trailers(opts, &head, &trailer_block);
      -	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
      -	strbuf_release(&trailer_block);
     -+	format_trailers(&head, opts, &tb);
     ++	format_trailers(opts, &head, &tb);
      +	fwrite(tb.buf, 1, tb.len, outfile);
      +	strbuf_release(&tb);
       
     @@ trailer.c
       
       	/*
       	 * Array of trailers found.
     -@@ trailer.c: void format_trailers(struct list_head *head,
     +@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
       	}
       }
       
     @@ trailer.c: void format_trailers(struct list_head *head,
      +	return trailer_block;
       }
       
     --static struct trailer_info *trailer_info_get(const char *str,
     --					     const struct process_trailer_options *opts)
     -+static struct trailer_block *trailer_block_get(const char *str,
     -+					       const struct process_trailer_options *opts)
     +-static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
     +-					     const char *str)
     ++static struct trailer_block *trailer_block_get(const struct process_trailer_options *opts,
     ++					       const char *str)
       {
      -	struct trailer_info *info = trailer_info_new();
      +	struct trailer_block *trailer_block = trailer_block_new();
       	size_t end_of_log_message = 0, trailer_block_start = 0;
       	struct strbuf **trailer_lines, **ptr;
       	char **trailer_strings = NULL;
     -@@ trailer.c: static struct trailer_info *trailer_info_get(const char *str,
     +@@ trailer.c: static struct trailer_info *trailer_info_get(const struct process_trailer_option
       	}
       	strbuf_list_free(trailer_lines);
       
     @@ trailer.c: static struct trailer_info *trailer_info_get(const char *str,
      + * Parse trailers in "str", populating the trailer_block info and "head" linked
      + * list structure.
        */
     --struct trailer_info *parse_trailers(const char *str,
     --				    struct list_head *head,
     --				    const struct process_trailer_options *opts)
     -+struct trailer_block *parse_trailers(const char *str,
     -+				     const struct process_trailer_options *opts,
     +-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     +-				    const char *str,
     +-				    struct list_head *head)
     ++struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
     ++				     const char *str,
      +				     struct list_head *head)
       {
      -	struct trailer_info *info;
     @@ trailer.c: static struct trailer_info *trailer_info_get(const char *str,
       	struct strbuf val = STRBUF_INIT;
       	size_t i;
       
     --	info = trailer_info_get(str, opts);
     -+	trailer_block = trailer_block_get(str, opts);
     +-	info = trailer_info_get(opts, str);
     ++	trailer_block = trailer_block_get(opts, str);
       
      -	for (i = 0; i < info->trailer_nr; i++) {
      +	for (i = 0; i < trailer_block->trailer_nr; i++) {
     @@ trailer.c: static struct trailer_info *trailer_info_get(const char *str,
       		if (trailer[0] == comment_line_char)
       			continue;
       		separator_pos = find_separator(trailer, separators);
     -@@ trailer.c: struct trailer_info *parse_trailers(const char *str,
     +@@ trailer.c: struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
       		}
       	}
       
     @@ trailer.c: struct trailer_info *parse_trailers(const char *str,
      +	return trailer_block;
       }
       
     - void free_trailers(struct list_head *head)
     -@@ trailer.c: void free_trailers(struct list_head *head)
     + void free_trailers(struct list_head *trailers)
     +@@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
     @@ trailer.c: void free_trailers(struct list_head *head)
      +	free(trailer_block);
       }
       
     - void format_trailers_from_commit(const char *msg,
     -@@ trailer.c: void format_trailers_from_commit(const char *msg,
     + void format_trailers_from_commit(const struct process_trailer_options *opts,
     +@@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options *opts,
       				 struct strbuf *out)
       {
       	LIST_HEAD(head);
     --	struct trailer_info *info = parse_trailers(msg, &head, opts);
     -+	struct trailer_block *trailer_block = parse_trailers(msg, opts, &head);
     +-	struct trailer_info *info = parse_trailers(opts, msg, &head);
     ++	struct trailer_block *trailer_block = parse_trailers(opts, msg, &head);
       
       	/* If we want the whole block untouched, we can take the fast path. */
       	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: void format_trailers_from_commit(const char *msg,
      +		strbuf_add(out, msg + trailer_block->start,
      +			   trailer_block->end - trailer_block->start);
       	} else
     - 		format_trailers(&head, opts, out);
     + 		format_trailers(opts, &head, out);
       
       	free_trailers(&head);
      -	trailer_info_release(info);
     @@ trailer.c: void format_trailers_from_commit(const char *msg,
      -	struct trailer_info *internal = trailer_info_new();
       	strbuf_init(&iter->key, 0);
       	strbuf_init(&iter->val, 0);
     - 	strbuf_init(&iter->raw, 0);
       	opts.no_divider = 1;
      -	iter->internal.info = internal;
     --	iter->internal.info = trailer_info_get(msg, &opts);
     -+	iter->internal.trailer_block = trailer_block_get(msg, &opts);
     +-	iter->internal.info = trailer_info_get(&opts, msg);
     ++	iter->internal.trailer_block = trailer_block_get(&opts, msg);
       	iter->internal.cur = 0;
       }
       
     @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
      +	trailer_block_release(iter->internal.trailer_block);
       	strbuf_release(&iter->val);
       	strbuf_release(&iter->key);
     - 	strbuf_release(&iter->raw);
     + }
      
       ## trailer.h ##
      @@
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
       void process_trailers_lists(struct list_head *head,
       			    struct list_head *arg_head);
       
     --struct trailer_info *parse_trailers(const char *str,
     --				    struct list_head *head,
     --				    const struct process_trailer_options *opts);
     -+struct trailer_block *parse_trailers(const char *str,
     -+				     const struct process_trailer_options *opts,
     +-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     +-				    const char *str,
     +-				    struct list_head *head);
     ++struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
     ++				     const char *str,
      +				     struct list_head *head);
       
      -size_t trailer_block_start(struct trailer_info *info);
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
      +void trailer_block_release(struct trailer_block *trailer_block);
       
       void trailer_config_init(void);
     - void free_trailers(struct list_head *trailers);
     + void format_trailers(const struct process_trailer_options *opts,
      @@ trailer.h: struct trailer_iterator {
       
       	/* private */
  8:  406725df46a !  8:  64ee07d0b53 trailer: prepare to move parse_trailers_from_command_line_args() to builtin
     @@ Commit message
              parse_trailers_from_command_line_args()
      
          to interpret-trailer.c, because the trailer API should not be concerned
     -    with command line arguments (as it has nothing to do with trailers
     -    themselves). The interpret-trailers builtin is the only user of the
     -    above function.
     +    with command line arguments (as they have nothing to do with trailers
     +    themselves). The interpret-trailers builtin is the only caller of this
     +    function.
      
     +    Also rename "conf_info" to "trailer_conf" for readability, dropping the
     +    low-value "_info" suffix as we did earlier in this series for
     +    "trailer_info" to "trailer_block".
     +
     +    Helped-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## trailer.c ##
     @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
       			add_arg_item(arg_head,
       				     strbuf_detach(&tok, NULL),
       				     strbuf_detach(&val, NULL),
     -@@ trailer.c: struct trailer_block *parse_trailers(const char *str,
     +@@ trailer.c: struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
       
       	for (i = 0; i < trailer_block->trailer_nr; i++) {
       		int separator_pos;
     @@ trailer.c: struct trailer_block *parse_trailers(const char *str,
       			add_trailer_item(head,
       					 NULL,
      @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
     - 		strbuf_addstr(&iter->raw, line);
     + 		iter->raw = line;
       		strbuf_reset(&iter->key);
       		strbuf_reset(&iter->val);
      -		parse_trailer(&iter->key, &iter->val, NULL,
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
      +		   struct strbuf *tok, struct strbuf *val,
      +		   const struct trailer_conf **conf);
      +
     - struct trailer_block *parse_trailers(const char *str,
     - 				     const struct process_trailer_options *opts,
     + struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
     + 				     const char *str,
       				     struct list_head *head);
  9:  8a99d0fca21 !  9:  1b4bdde65bc trailer: move arg handling to interpret-trailers.c
     @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct optio
       }
       
      @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
     + }
       
     - static void interpret_trailers(const char *file,
     - 			       const struct process_trailer_options *opts,
     --			       struct list_head *new_trailer_head)
     -+			       struct list_head *arg_trailers)
     + static void interpret_trailers(const struct process_trailer_options *opts,
     +-			       struct list_head *new_trailer_head,
     ++			       struct list_head *arg_trailers,
     + 			       const char *file)
       {
       	LIST_HEAD(head);
     - 	struct strbuf sb = STRBUF_INIT;
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       	struct trailer_block *trailer_block;
       	FILE *outfile = stdout;
       
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       	read_input_file(&sb, file);
       
       	if (opts->in_place)
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       
       
       	if (!opts->only_input) {
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
       	}
       
       	/* Print trailer block. */
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const char *file,
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
       {
       	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **
       	if (argc) {
       		int i;
       		for (i = 0; i < argc; i++)
     --			interpret_trailers(argv[i], &opts, &trailers);
     -+			interpret_trailers(argv[i], &opts, &arg_trailers);
     +-			interpret_trailers(&opts, &trailers, argv[i]);
     ++			interpret_trailers(&opts, &arg_trailers, argv[i]);
       	} else {
       		if (opts.in_place)
       			die(_("no input file given for in-place editing"));
     --		interpret_trailers(NULL, &opts, &trailers);
     -+		interpret_trailers(NULL, &opts, &arg_trailers);
     +-		interpret_trailers(&opts, &trailers, NULL);
     ++		interpret_trailers(&opts, &arg_trailers, NULL);
       	}
       
      -	new_trailers_clear(&trailers);
     @@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head
       		}
       	}
       
     -@@ trailer.c: void free_trailers(struct list_head *head)
     +@@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
     @@ trailer.h: struct new_trailer_item {
       struct process_trailer_options {
       	int in_place;
       	int trim_empty;
     -@@ trailer.h: void trailer_block_release(struct trailer_block *trailer_block);
     - 
     - void trailer_config_init(void);
     +@@ trailer.h: void format_trailers(const struct process_trailer_options *opts,
     + 		     struct list_head *trailers,
     + 		     struct strbuf *out);
       void free_trailers(struct list_head *trailers);
     -+void new_trailers_clear(struct list_head *trailers);
     - 
     - void format_trailers(struct list_head *head,
     - 		     const struct process_trailer_options *opts,
     +-
     ++void new_trailers_clear(struct list_head *new_trailers);
     + /*
     +  * Convenience function to format the trailers from the commit msg "msg" into
     +  * the strbuf "out". Reuses format_trailers internally.
 10:  243eee730e4 = 10:  ed67ebf8647 trailer: delete obsolete argument handling code from API

-- 
gitgitgadget
