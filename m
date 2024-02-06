Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3043745D1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196358; cv=none; b=FkbMkvH1e3RJ/LUS0jpprDho7umnxJxr7avStTtVUjvfC7FFwrsYsTS4EktwFjimusEUrpxDyS8UlagPzAR34N08e/E2ZROXd0NSrfS4mTCXKmtjKYbQThS5xIbEdu6uGUDb8s9chIV4mUcriVo+iEM28A/ifDaHr7SB05xuRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196358; c=relaxed/simple;
	bh=ieJrPuXcNIFkXYY3fxpu1xuEY/mEr20cJUY8Hm131FM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DZxqru+m0k9cmd4yDaWsKzsqEsY/i4A+qBp5dM1B6sqoT1J91tG1egO333w0EbP7qm6LP+oH+LIDn45Y1vS/JZbhIsKLioBtNzu0qvjkhXnBeczCt5DlNz9c0lDMySdWrxnOSpKjecJNRaaseaEU3bPoZmMPWk4a5PyzmcKd5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I520MD9Z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I520MD9Z"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so34057775e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196351; x=1707801151; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2wnVGjpzp7dkg1cA82l9xgYZE14cfP32neRQqqrgpU=;
        b=I520MD9ZFoTk7Elyh4HOKjWh37vMyc5V7EPAVdNAIx443Aecn0HpVcNNaguMHu2D3a
         vo3wRKTT3WJjG4J09ssSV22f7+i5cevlhXUwlySYjZEspswS3p3ynuHr1xuhiMJUrSyR
         pKmmvwb4eN3u6BRFUjjhc9PqVz6RTuYhwJ86paOBhZebkY/WWfSZvXxYHe8TSdD3QD04
         Fc4n4jBwNSW8fnNFrRNWToW3iwMDSXQS1t3eNcUdz60KULmiA/vSOSk/Jcu48d0tWoa5
         xcnbyclxzSVHJp9ugDa29wjm1KeKZwKRAIXJKkr7n6fnpfaxvTGO9R0AsMYc0MCmCFPH
         k+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196351; x=1707801151;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2wnVGjpzp7dkg1cA82l9xgYZE14cfP32neRQqqrgpU=;
        b=KjakIUqZjVGhHPZe4GK2pUBbyiN3oNg9PbtopREu3t3JdzSRowpGaQ3P+IzsHeEux4
         ARWOwl/ogJfNUTkjNkhSVfQBNZgiR1EbsetkuRzNPEimr+BpGbKKIzFIC8it3CXgdp/K
         JqWpHjwjTte8D5LFcEO5ysG2arDXc5Eoic+y8s1jN1ov4xLS5kzyAAn9n0j+3yyY+ElC
         J5SREydwadOtA8HGLg857lFmJ67b6R2rEe98vakrDjoQaAZ8a4Ix+yxulqHCdFRpEP+U
         plppmKnbzA1WRWt0B5iD1sPjfZSSMoEQqHnNvZ48xIxRxfvhNVMXoNi2MuEh/917PlfB
         u4FA==
X-Gm-Message-State: AOJu0YzBCCCCPH5bpKWkYtXgp/7we+CUNtAOtPhKemLhEx9a5QkvhpGK
	PNRv6ONOlPColQi35CycJhCbsyR7OvFXjXT+W2NmjWIW1u9xLFCd8s0PIH2b
X-Google-Smtp-Source: AGHT+IGNONYeIdyD6vsyaqFCyCulmgDAXF0nVft+ZIfFzUnJdkY9rBwOF99mheSWa/QNcCxEh2Yp/A==
X-Received: by 2002:a05:600c:b8f:b0:40f:d0f1:23cc with SMTP id fl15-20020a05600c0b8f00b0040fd0f123ccmr833206wmb.34.1707196350232;
        Mon, 05 Feb 2024 21:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1tQX122rUsGswMcP000J0NlJ4HbDaTV5EpWQ91AP02DslQv3aD65dtRgeJTfza7FPiD7hENDDEbJ+sqYFvQCkYo4JVdHZ0lypYncfQVnKGiQLlTnGMijCEyqcB3WCOUM0JCoqMTZE1Rx7Z0s0Nw3FUKf9byKl+3ZIfgK2zv51OEvkWcYg3XZodok9dv7mBImAXGBzH6rFag==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c19d400b0040fddd8de88sm649208wmq.15.2024.02.05.21.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:29 -0800 (PST)
Message-ID: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:00 +0000
Subject: [PATCH v4 00/28] Enrich Trailer API
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


Notable changes in v4
=====================

 * Patches 3, 4, 5, and 8 have been broken up into smaller steps. There are
   28 instead of 10 patches now, but these 28 should be much easier to
   review than the (previously condensed) 10.
 * NEW Patch 1: "trailer: free trailer_info after all related usage" fixes
   awkward use-after-free coding style
 * NEW Patch 2: "shortlog: add test for de-duplicating folded trailers"
   increases test coverage related to trailer iterators and "unfold_value()"
 * NEW Patch 27: "trailer_set_*(): put out parameter at the end" is a small
   refactor to reorder parameters.
 * Patches 5-16: These smaller patches make up Patch 3 from v3.
 * Patches 17-18: These smaller patches make up Patch 4 from v3.
 * Patches 19-20: These smaller patches make up Patch 5 from v3.
 * Patches 23-26: These smaller patches make up Patch 8 from v3.
 * Anonymize unambiguous parameters in <trailer.h>.


Notable changes in v3
=====================

 * Squashed Patch 4 into Patch 3 ("trailer: unify trailer formatting
   machinery"), to avoid breaking the build ("-Werror=unused-function"
   violations)
 * NEW (Patch 10): Introduce "trailer template" terminology for readability
   (no behavioral change)
 * (API function) Rename default_separators() to
   trailer_default_separators()
 * (API function) Rename new_trailers_clear() to free_trailer_templates()
 * trailer.h: for single-parameter functions, anonymize the parameter name
   to reduce verbosity


Notable changes in v2
=====================

 * (cover letter) Discuss goals of the larger series in more detail,
   especially the pimpl idiom
 * (cover letter) List bug fixes pending in the larger series that depend on
   this series
 * Reorder function parameters to have trailer options at the beginning (and
   out parameters toward the end)
 * "sequencer: use the trailer iterator": prefer C string instead of strbuf
   for new "raw" field
 * Patch 1 (was Patch 2) also renames ensure_configured() to
   trailer_config_init() (forgot to rename this one previously)

Linus Arver (28):
  trailer: free trailer_info _after_ all related usage
  shortlog: add test for de-duplicating folded trailers
  trailer: prepare to expose functions as part of API
  trailer: move interpret_trailers() to interpret-trailers.c
  trailer: start preparing for formatting unification
  trailer_info_get(): reorder parameters
  format_trailers(): use strbuf instead of FILE
  format_trailer_info(): move "fast path" to caller
  format_trailers_from_commit(): indirectly call trailer_info_get()
  format_trailer_info(): use trailer_item objects
  format_trailer_info(): drop redundant unfold_value()
  format_trailer_info(): append newline for non-trailer lines
  trailer: begin formatting unification
  format_trailer_info(): teach it about opts->trim_empty
  format_trailer_info(): avoid double-printing the separator
  trailer: finish formatting unification
  trailer: teach iterator about non-trailer lines
  sequencer: use the trailer iterator
  trailer: make trailer_info struct private
  trailer: retire trailer_info_get() from API
  trailer: spread usage of "trailer_block" language
  trailer: prepare to delete "parse_trailers_from_command_line_args()"
  trailer: add new helper functions to API
  trailer_add_arg_item(): drop new_trailer_item usage
  trailer: deprecate "new_trailer_item" struct from API
  trailer: unify "--trailer ..." arg handling
  trailer_set_*(): put out parameter at the end
  trailer: introduce "template" term for readability

 builtin/interpret-trailers.c | 189 ++++++--
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 sequencer.c                  |  27 +-
 t/t4201-shortlog.sh          |  32 ++
 trailer.c                    | 811 +++++++++++++++++------------------
 trailer.h                    | 109 ++---
 7 files changed, 642 insertions(+), 530 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1632

Range-diff vs v3:

  -:  ----------- >  1:  652df25f30e trailer: free trailer_info _after_ all related usage
  -:  ----------- >  2:  fdccaca2ba0 shortlog: add test for de-duplicating folded trailers
  1:  72cc12a3066 !  3:  4372af244f0 trailer: prepare to expose functions as part of API
     @@ Commit message
          them by their "trailer" moniker, just like all the other functions
          already exposed by trailer.h.
      
     -    Take the opportunity to start putting trailer processions options (opts)
     +    Take the opportunity to start putting trailer processing options (opts)
          as the first parameter. This will be the pattern going forward in this
          series.
      
     @@ trailer.c: void process_trailers(const char *file,
       	}
       
      -	print_all(outfile, &head, opts);
     -+	format_trailers(opts, &head, outfile);
     - 
      -	free_all(&head);
     ++	format_trailers(opts, &head, outfile);
      +	free_trailers(&head);
     - 	trailer_info_release(&info);
       
       	/* Print the lines after the trailers as is */
     + 	if (!opts->only_trailers)
      @@ trailer.c: void trailer_info_get(struct trailer_info *info, const char *str,
       	size_t nr = 0, alloc = 0;
       	char **last = NULL;
  2:  cafa39d1048 !  4:  4073b8eb510 trailer: move interpret_trailers() to interpret-trailers.c
     @@ Commit message
          trailer: move interpret_trailers() to interpret-trailers.c
      
          The interpret-trailers.c builtin is the only place we need to call
     -    interpret_trailers(), so move its definition there.
     +    interpret_trailers(), so move its definition there (together with a few
     +    helper functions called only by it) and remove its external declaration
     +    from <trailer.h>.
      
     -    Delete the corresponding declaration from trailer.h, which then forces
     -    us to expose the working innards of that function. This enriches
     -    trailer.h with a more granular API, which can then be unit-tested in the
     -    future (because interpret_trailers() by itself does too many things to
     -    be able to be easily unit-tested).
     +    Several helper functions that are called by interpret_trailers() remain
     +    in trailer.c because other callers in the same file still call them.
     +    Declare them in <trailer.h> so that interpret_trailers() (now in
     +    builtin/interpret-trailers.c) can continue calling them as a trailer API
     +    user.
     +
     +    This enriches <trailer.h> with a more granular API, which can then be
     +    unit-tested in the future (because interpret_trailers() by itself does
     +    too many things to be able to be easily unit-tested).
      
          Take this opportunity to demote some file-handling functions out of the
          trailer API implementation, as these have nothing to do with trailers.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     @@ builtin/interpret-trailers.c: static int parse_opt_parse(const struct option *op
      +	}
      +
      +	format_trailers(opts, &head, outfile);
     -+
      +	free_trailers(&head);
     -+	trailer_info_release(&info);
      +
      +	/* Print the lines after the trailers as is */
      +	if (!opts->only_trailers)
      +		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
     ++	trailer_info_release(&info);
      +
      +	if (opts->in_place)
      +		if (rename_tempfile(&trailers_tempfile, file))
     @@ trailer.c: static void free_trailers(struct list_head *trailers)
      -	}
      -
      -	format_trailers(opts, &head, outfile);
     --
      -	free_trailers(&head);
     --	trailer_info_release(&info);
      -
      -	/* Print the lines after the trailers as is */
      -	if (!opts->only_trailers)
      -		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
     +-	trailer_info_release(&info);
      -
      -	if (opts->in_place)
      -		if (rename_tempfile(&trailers_tempfile, file))
     @@ trailer.h: struct process_trailer_options {
      +void process_trailers_lists(struct list_head *head,
      +			    struct list_head *arg_head);
      +
     -+void parse_trailers(const struct process_trailer_options *opts,
     -+		    struct trailer_info *info,
     ++void parse_trailers(const struct process_trailer_options *,
     ++		    struct trailer_info *,
      +		    const char *str,
      +		    struct list_head *head);
       
     @@ trailer.h: struct process_trailer_options {
       void trailer_info_release(struct trailer_info *info);
       
      +void trailer_config_init(void);
     -+void format_trailers(const struct process_trailer_options *opts,
     ++void format_trailers(const struct process_trailer_options *,
      +		     struct list_head *trailers, FILE *outfile);
      +void free_trailers(struct list_head *);
      +
  3:  5c7a2354df0 !  5:  b2a0f7829a1 trailer: unify trailer formatting machinery
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: unify trailer formatting machinery
     +    trailer: start preparing for formatting unification
      
     -    Currently have two functions for formatting trailers exposed in
     -    trailer.h:
     +    Currently there are two functions for formatting trailers in
     +    <trailer.h>:
      
     -        void format_trailers(FILE *outfile, struct list_head *head,
     -                            const struct process_trailer_options *opts);
     +        void format_trailers(const struct process_trailer_options *,
     +                             struct list_head *trailers, FILE *outfile);
      
              void format_trailers_from_commit(struct strbuf *out, const char *msg,
     -                                        const struct process_trailer_options *opts);
     +                                         const struct process_trailer_options *opts);
      
     -    and previously these functions, although similar enough (even taking the
     -    same process_trailer_options struct pointer), did not build on each
     -    other.
     +    and although they are similar enough (even taking the same
     +    process_trailer_options struct pointer) they are used quite differently.
     +    One might intuitively think that format_trailers_from_commit() builds on
     +    top of format_trailers(), but this is not the case. Instead
     +    format_trailers_from_commit() calls format_trailer_info() and
     +    format_trailers() is never called in that codepath.
      
     -    Make format_trailers_from_commit() rely on format_trailers(). Teach
     -    format_trailers() to process trailers with the additional
     -    process_trailer_options fields like opts->key_only which is only used by
     -    format_trailers_from_commit() and not builtin/interpret-trailers.c.
     -    While we're at it, reorder parameters to put the trailer processing
     -    options first, and the out parameter (strbuf we write into) at the end.
     +    This is a preparatory refactor to help us deprecate format_trailers() in
     +    favor of format_trailer_info() (at which point we can rename the latter
     +    to the former). When the deprecation is complete, both
     +    format_trailers_from_commit(), and the interpret-trailers builtin will
     +    be able to call into the same helper function (instead of
     +    format_trailers() and format_trailer_info(), respectively). Unifying the
     +    formatters is desirable because it simplifies the API.
      
     -    This unification will allow us to delete the format_trailer_info() and
     -    print_tok_val() functions in the next patch. They are not deleted here
     -    in order to keep the diff small.
     +    Reorder parameters for format_trailers_from_commit() to prefer
      
     -    Helped-by: Junio C Hamano <gitster@pobox.com>
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +        const struct process_trailer_options *opts
      
     - ## builtin/interpret-trailers.c ##
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - {
     - 	LIST_HEAD(head);
     - 	struct strbuf sb = STRBUF_INIT;
     -+	struct strbuf trailer_block = STRBUF_INIT;
     - 	struct trailer_info info;
     - 	FILE *outfile = stdout;
     - 
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - 		process_trailers_lists(&head, &arg_head);
     - 	}
     - 
     --	format_trailers(opts, &head, outfile);
     -+	/* Print trailer block. */
     -+	format_trailers(opts, &head, &trailer_block);
     -+	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
     -+	strbuf_release(&trailer_block);
     - 
     - 	free_trailers(&head);
     - 	trailer_info_release(&info);
     +    as the first parameter, because these options are intimately tied to
     +    formatting trailers. And take
     +
     +        struct strbuf *out
     +
     +    last, because it's an "out parameter" (something that the caller wants
     +    to use as the output of this function).
     +
     +    Signed-off-by: Linus Arver <linusa@google.com>
      
       ## pretty.c ##
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
       		} else if (atom->u.contents.option == C_BARE)
      
       ## trailer.c ##
     -@@ trailer.c: static char last_non_space_char(const char *s)
     - 	return '\0';
     - }
     - 
     --static void print_tok_val(FILE *outfile, const char *tok, const char *val)
     --{
     --	char c;
     --
     --	if (!tok) {
     --		fprintf(outfile, "%s\n", val);
     --		return;
     --	}
     --
     --	c = last_non_space_char(tok);
     --	if (!c)
     --		return;
     --	if (strchr(separators, c))
     --		fprintf(outfile, "%s%s\n", tok, val);
     --	else
     --		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
     --}
     --
     --void format_trailers(const struct process_trailer_options *opts,
     --		     struct list_head *trailers, FILE *outfile)
     --{
     --	struct list_head *pos;
     --	struct trailer_item *item;
     --	list_for_each(pos, trailers) {
     --		item = list_entry(pos, struct trailer_item, list);
     --		if ((!opts->trim_empty || strlen(item->value) > 0) &&
     --		    (!opts->only_trailers || item->token))
     --			print_tok_val(outfile, item->token, item->value);
     --	}
     --}
     --
     - static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
     - {
     - 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
     -@@ trailer.c: static void unfold_value(struct strbuf *val)
     - 	strbuf_release(&out);
     - }
     - 
     -+void format_trailers(const struct process_trailer_options *opts,
     -+		     struct list_head *trailers,
     -+		     struct strbuf *out)
     -+{
     -+	struct list_head *pos;
     -+	struct trailer_item *item;
     -+	int need_separator = 0;
     -+
     -+	list_for_each(pos, trailers) {
     -+		item = list_entry(pos, struct trailer_item, list);
     -+		if (item->token) {
     -+			char c;
     -+
     -+			struct strbuf tok = STRBUF_INIT;
     -+			struct strbuf val = STRBUF_INIT;
     -+			strbuf_addstr(&tok, item->token);
     -+			strbuf_addstr(&val, item->value);
     -+
     -+			/*
     -+			 * Skip key/value pairs where the value was empty. This
     -+			 * can happen from trailers specified without a
     -+			 * separator, like `--trailer "Reviewed-by"` (no
     -+			 * corresponding value).
     -+			 */
     -+			if (opts->trim_empty && !strlen(item->value))
     -+				continue;
     -+
     -+			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
     -+				if (opts->unfold)
     -+					unfold_value(&val);
     -+
     -+				if (opts->separator && need_separator)
     -+					strbuf_addbuf(out, opts->separator);
     -+				if (!opts->value_only)
     -+					strbuf_addbuf(out, &tok);
     -+				if (!opts->key_only && !opts->value_only) {
     -+					if (opts->key_value_separator)
     -+						strbuf_addbuf(out, opts->key_value_separator);
     -+					else {
     -+						c = last_non_space_char(tok.buf);
     -+						if (c) {
     -+							if (!strchr(separators, c))
     -+								strbuf_addf(out, "%c ", separators[0]);
     -+						}
     -+					}
     -+				}
     -+				if (!opts->key_only)
     -+					strbuf_addbuf(out, &val);
     -+				if (!opts->separator)
     -+					strbuf_addch(out, '\n');
     -+
     -+				need_separator = 1;
     -+			}
     -+
     -+			strbuf_release(&tok);
     -+			strbuf_release(&val);
     -+		} else if (!opts->only_trailers) {
     -+			if (opts->separator && need_separator) {
     -+				strbuf_addbuf(out, opts->separator);
     -+			}
     -+			strbuf_addstr(out, item->value);
     -+			if (opts->separator)
     -+				strbuf_rtrim(out);
     -+			else
     -+				strbuf_addch(out, '\n');
     -+
     -+			need_separator = 1;
     -+		}
     -+
     -+	}
     -+}
     -+
     - /*
     -  * Parse trailers in "str", populating the trailer info and "head"
     -  * linked list structure.
      @@ trailer.c: void trailer_info_release(struct trailer_info *info)
       	free(info->trailers);
       }
       
      -static void format_trailer_info(struct strbuf *out,
     --				const struct trailer_info *info,
     --				const char *msg,
     ++static void format_trailer_info(const struct process_trailer_options *opts,
     + 				const struct trailer_info *info,
     + 				const char *msg,
      -				const struct process_trailer_options *opts)
     -+void format_trailers_from_commit(const struct process_trailer_options *opts,
     -+				 const char *msg,
     -+				 struct strbuf *out)
     ++				struct strbuf *out)
       {
     --	size_t origlen = out->len;
     --	size_t i;
     -+	LIST_HEAD(head);
     -+	struct trailer_info info;
     -+
     -+	parse_trailers(opts, &info, msg, &head);
     + 	size_t origlen = out->len;
     + 	size_t i;
     +@@ trailer.c: static void format_trailer_info(struct strbuf *out,
     + 
     + }
       
     - 	/* If we want the whole block untouched, we can take the fast path. */
     - 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     - 	    !opts->separator && !opts->key_only && !opts->value_only &&
     - 	    !opts->key_value_separator) {
     --		strbuf_add(out, msg + info->trailer_block_start,
     --			   info->trailer_block_end - info->trailer_block_start);
     --		return;
     --	}
     --
     --	for (i = 0; i < info->trailer_nr; i++) {
     --		char *trailer = info->trailers[i];
     --		ssize_t separator_pos = find_separator(trailer, separators);
     --
     --		if (separator_pos >= 1) {
     --			struct strbuf tok = STRBUF_INIT;
     --			struct strbuf val = STRBUF_INIT;
     --
     --			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
     --			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
     --				if (opts->unfold)
     --					unfold_value(&val);
     --
     --				if (opts->separator && out->len != origlen)
     --					strbuf_addbuf(out, opts->separator);
     --				if (!opts->value_only)
     --					strbuf_addbuf(out, &tok);
     --				if (!opts->key_only && !opts->value_only) {
     --					if (opts->key_value_separator)
     --						strbuf_addbuf(out, opts->key_value_separator);
     --					else
     --						strbuf_addstr(out, ": ");
     --				}
     --				if (!opts->key_only)
     --					strbuf_addbuf(out, &val);
     --				if (!opts->separator)
     --					strbuf_addch(out, '\n');
     --			}
     --			strbuf_release(&tok);
     --			strbuf_release(&val);
     --
     --		} else if (!opts->only_trailers) {
     --			if (opts->separator && out->len != origlen) {
     --				strbuf_addbuf(out, opts->separator);
     --			}
     --			strbuf_addstr(out, trailer);
     --			if (opts->separator) {
     --				strbuf_rtrim(out);
     --			}
     --		}
     --	}
     --
     --}
     --
      -void format_trailers_from_commit(struct strbuf *out, const char *msg,
      -				 const struct process_trailer_options *opts)
     --{
     --	struct trailer_info info;
     -+		strbuf_add(out, msg + info.trailer_block_start,
     -+			   info.trailer_block_end - info.trailer_block_start);
     -+	} else
     -+		format_trailers(opts, &head, out);
     ++void format_trailers_from_commit(const struct process_trailer_options *opts,
     ++				 const char *msg,
     ++				 struct strbuf *out)
     + {
     + 	struct trailer_info info;
       
     --	trailer_info_get(&info, msg, opts);
     + 	trailer_info_get(&info, msg, opts);
      -	format_trailer_info(out, &info, msg, opts);
     -+	free_trailers(&head);
     ++	format_trailer_info(opts, &info, msg, out);
       	trailer_info_release(&info);
       }
       
      
       ## trailer.h ##
     -@@ trailer.h: void trailer_info_release(struct trailer_info *info);
     - 
     - void trailer_config_init(void);
     - void format_trailers(const struct process_trailer_options *opts,
     --		     struct list_head *trailers, FILE *outfile);
     -+		     struct list_head *trailers,
     -+		     struct strbuf *out);
     - void free_trailers(struct list_head *);
     - 
     - /*
     -- * Format the trailers from the commit msg "msg" into the strbuf "out".
     -- * Note two caveats about "opts":
     -- *
     -- *   - this is primarily a helper for pretty.c, and not
     -- *     all of the flags are supported.
     -- *
     -- *   - this differs from process_trailers slightly in that we always format
     -- *     only the trailer block itself, even if the "only_trailers" option is not
     -- *     set.
     -+ * Convenience function to format the trailers from the commit msg "msg" into
     -+ * the strbuf "out". Reuses format_trailers internally.
     +@@ trailer.h: void free_trailers(struct list_head *);
     +  *     only the trailer block itself, even if the "only_trailers" option is not
     +  *     set.
        */
      -void format_trailers_from_commit(struct strbuf *out, const char *msg,
      -				 const struct process_trailer_options *opts);
  -:  ----------- >  6:  c1760f80356 trailer_info_get(): reorder parameters
  -:  ----------- >  7:  9dc912b5bc5 format_trailers(): use strbuf instead of FILE
  -:  ----------- >  8:  b97c06d8bc3 format_trailer_info(): move "fast path" to caller
  -:  ----------- >  9:  6906910417a format_trailers_from_commit(): indirectly call trailer_info_get()
  -:  ----------- > 10:  f5b7ba08aa7 format_trailer_info(): use trailer_item objects
  -:  ----------- > 11:  457f2a839d5 format_trailer_info(): drop redundant unfold_value()
  -:  ----------- > 12:  a72eca301f7 format_trailer_info(): append newline for non-trailer lines
  -:  ----------- > 13:  ad77c33e457 trailer: begin formatting unification
  -:  ----------- > 14:  11f854399db format_trailer_info(): teach it about opts->trim_empty
  -:  ----------- > 15:  ba1f387747b format_trailer_info(): avoid double-printing the separator
  -:  ----------- > 16:  31725832224 trailer: finish formatting unification
  4:  bf2b8e1a3c4 ! 17:  6f17c022b15 sequencer: use the trailer iterator
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    sequencer: use the trailer iterator
     +    trailer: teach iterator about non-trailer lines
      
     -    This patch allows for the removal of "trailer_info_get()" from the
     -    trailer.h API, which will be in the next patch.
     +    Previously the iterator did not iterate over non-trailer lines. This was
     +    somewhat unfortunate, because trailer blocks could have non-trailer
     +    lines in them since 146245063e (trailer: allow non-trailers in trailer
     +    block, 2016-10-21), which was before the iterator was created in
     +    f0939a0eb1 (trailer: add interface for iterating over commit trailers,
     +    2020-09-27).
      
     -    Instead of calling "trailer_info_get()", which is a low-level function
     -    in the trailers implementation (trailer.c), call
     -    trailer_iterator_advance(), which was specifically designed for public
     -    consumption in f0939a0eb1 (trailer: add interface for iterating over
     -    commit trailers, 2020-09-27).
     +    So if trailer API users wanted to iterate over all lines in a trailer
     +    block (including non-trailer lines), they could not use the iterator and
     +    were forced to use the lower-level trailer_info struct directly (which
     +    provides a raw string array that includes all lines in the trailer
     +    block).
      
     -    Avoiding "trailer_info_get()" means we don't have to worry about options
     -    like "no_divider" (relevant for parsing trailers). We also don't have to
     -    check for things like "info.trailer_start == info.trailer_end" to see
     -    whether there were any trailers (instead we can just check to see
     -    whether the iterator advanced at all).
     +    Change the iterator's behavior so that we also iterate over non-trailer
     +    lines, instead of skipping over them. The new "raw" member of the
     +    iterator allows API users to access previously inaccessible non-trailer
     +    lines. Reword the variable "trailer" to just "line" because this
     +    variable can now hold both trailer lines _and_ non-trailer lines.
      
     -    Also, teach the iterator about non-trailer lines, by adding a new field
     -    called "raw" to hold both trailer and non-trailer lines. This is
     -    necessary because a "trailer block" is a list of trailer lines of at
     -    least 25% trailers (see 146245063e (trailer: allow non-trailers in
     -    trailer block, 2016-10-21)), such that it may hold non-trailer lines.
     +    The new "raw" member is important because anyone currently not using the
     +    iterator is using trailer_info's raw string array directly to access
     +    lines to check what the combined key + value looks like. If we didn't
     +    provide a "raw" member here, iterator users would have to re-construct
     +    the unparsed line by concatenating the key and value back together again
     +    --- which places an undue burden for iterator users.
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    The next patch demonstrates the use of the iterator in sequencer.c as an
     +    example of where "raw" will be useful, so that it can start using the
     +    iterator.
      
     - ## builtin/shortlog.c ##
     -@@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *log,
     - 					 const char *oneline)
     - {
     - 	struct trailer_iterator iter;
     --	const char *commit_buffer, *body;
     -+	const char *commit_buffer, *body, *value;
     - 	struct strbuf ident = STRBUF_INIT;
     - 
     - 	if (!log->trailers.nr)
     -@@ builtin/shortlog.c: static void insert_records_from_trailers(struct shortlog *log,
     - 
     - 	trailer_iterator_init(&iter, body);
     - 	while (trailer_iterator_advance(&iter)) {
     --		const char *value = iter.val.buf;
     -+		if (!iter.is_trailer)
     -+			continue;
     -+
     -+		value = iter.val.buf;
     - 
     - 		if (!string_list_has_string(&log->trailers, iter.key.buf))
     - 			continue;
     +    For the existing use of the iterator in builtin/shortlog.c, we don't
     +    have to change the code there because that code does
      
     - ## sequencer.c ##
     -@@ sequencer.c: static const char *get_todo_path(const struct replay_opts *opts)
     - static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
     - 	size_t ignore_footer)
     - {
     --	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     --	struct trailer_info info;
     --	size_t i;
     --	int found_sob = 0, found_sob_last = 0;
     --	char saved_char;
     --
     --	opts.no_divider = 1;
     -+	struct trailer_iterator iter;
     -+	size_t i = 0, found_sob = 0;
     -+	char saved_char = sb->buf[sb->len - ignore_footer];
     - 
     - 	if (ignore_footer) {
     --		saved_char = sb->buf[sb->len - ignore_footer];
     - 		sb->buf[sb->len - ignore_footer] = '\0';
     - 	}
     - 
     --	trailer_info_get(&info, sb->buf, &opts);
     -+	trailer_iterator_init(&iter, sb->buf);
     -+	while (trailer_iterator_advance(&iter)) {
     -+		i++;
     -+		if (sob &&
     -+		    iter.is_trailer &&
     -+		    !strncmp(iter.raw, sob->buf, sob->len)) {
     -+			found_sob = i;
     -+		}
     -+	}
     -+	trailer_iterator_release(&iter);
     - 
     - 	if (ignore_footer)
     - 		sb->buf[sb->len - ignore_footer] = saved_char;
     - 
     --	if (info.trailer_block_start == info.trailer_block_end)
     -+	if (!i)
     - 		return 0;
     - 
     --	for (i = 0; i < info.trailer_nr; i++)
     --		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
     --			found_sob = 1;
     --			if (i == info.trailer_nr - 1)
     --				found_sob_last = 1;
     --		}
     --
     --	trailer_info_release(&info);
     --
     --	if (found_sob_last)
     -+	if (found_sob == i)
     - 		return 3;
     - 	if (found_sob)
     - 		return 2;
     +        trailer_iterator_init(&iter, body);
     +        while (trailer_iterator_advance(&iter)) {
     +            const char *value = iter.val.buf;
     +
     +            if (!string_list_has_string(&log->trailers, iter.key.buf))
     +                continue;
     +
     +            ...
     +
     +    and the
     +
     +            if (!string_list_has_string(&log->trailers, iter.key.buf))
     +
     +    condition already skips over non-trailer lines (iter.key.buf is empty
     +    for non-trailer lines, making the comparison still work unmodified even
     +    with this patch).
     +
     +    Signed-off-by: Linus Arver <linusa@google.com>
      
       ## trailer.c ##
      @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
     @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char
      -
      -		if (separator_pos < 1)
      -			continue; /* not a real trailer */
     --
     -+	char *line;
     -+	int separator_pos;
      +	if (iter->internal.cur < iter->internal.info.trailer_nr) {
     -+		line = iter->internal.info.trailers[iter->internal.cur++];
     -+		separator_pos = find_separator(line, separators);
     -+		iter->is_trailer = (separator_pos > 0);
     -+
     ++		char *line = iter->internal.info.trailers[iter->internal.cur++];
     ++		int separator_pos = find_separator(line, separators);
     + 
      +		iter->raw = line;
       		strbuf_reset(&iter->key);
       		strbuf_reset(&iter->val);
       		parse_trailer(&iter->key, &iter->val, NULL,
      -			      trailer, separator_pos);
      +			      line, separator_pos);
     + 		/* Always unfold values during iteration. */
       		unfold_value(&iter->val);
       		return 1;
     - 	}
      
       ## trailer.h ##
     -@@ trailer.h: struct trailer_iterator {
     - 	struct strbuf key;
     - 	struct strbuf val;
     - 
     +@@ trailer.h: void format_trailers_from_commit(const struct process_trailer_options *,
     +  *   trailer_iterator_release(&iter);
     +  */
     + struct trailer_iterator {
      +	/*
      +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
      +	 * key/val pair as part of a trailer block. A trailer block can be
     @@ trailer.h: struct trailer_iterator {
      +	 */
      +	const char *raw;
      +
     -+	/*
     -+	 * 1 if the raw line was parsed as a trailer line (key/val pair).
     -+	 */
     -+	int is_trailer;
     -+
     - 	/* private */
     - 	struct {
     - 		struct trailer_info info;
     + 	struct strbuf key;
     + 	struct strbuf val;
     + 
  -:  ----------- > 18:  cc92dfb0bda sequencer: use the trailer iterator
  5:  c19c1dcc592 ! 19:  f5f0d06613f trailer: make trailer_info struct private
     @@ Commit message
            (2) external API users are unable to peer inside this struct (because
                it is only ever exposed as an opaque pointer).
      
     -    This change exposes some deficiencies in the API, mainly with regard to
     -    information about the location of the trailer block that was parsed.
     -    Expose new API functions to access this information (needed by
     -    builtin/interpret-trailers.c).
     +    There are a couple disadvantages:
     +
     +      (A) every time the member of the struct is accessed an extra pointer
     +          dereference must be done, and
     +
     +      (B) for users of trailer_info outside trailer.c, this struct can no
     +          longer be allocated on the stack and may only be allocated on the
     +          heap (because its definition is hidden away in trailer.c) and
     +          appropriately deallocated by the user.
     +
     +    This patch believes that the benefits outweight the advantages for
     +    designing APIs, as explained below.
     +
     +    Making trailer_info private exposes existing deficiencies in the API.
     +    This is because users of this struct had full access to its internals,
     +    so there wasn't much need to actually design it to be "complete" in the
     +    sense that API users only needed to use what was provided by the API.
     +    For example, the location of the trailer block (start/end offsets
     +    relative to the start of the input text) was accessible by looking at
     +    these struct members directly. Now that the struct is private, we have
     +    to expose new API functions to allow clients to access this
     +    information (see builtin/interpret-trailers.c).
      
          The idea in this patch to hide implementation details behind an "opaque
          pointer" is also known as the "pimpl" (pointer to implementation) idiom
     @@ Commit message
      
          In our case, "struct trailer_info" is now hidden from clients, and the
          ways in which this opaque pointer can be used is limited to the richness
     -    of the trailer.h file. In other words, trailer.h exclusively controls
     -    exactly how "trailer_info" pointers are to be used.
     +    of <trailer.h>. In other words, <trailer.h> exclusively controls exactly
     +    how "trailer_info" pointers are to be used.
      
          [1] Hanson, David R. "C Interfaces and Implementations: Techniques for
              Creating Reusable Software". Addison Wesley, 1997. p. 22
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct proces
       
       
      @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - 	strbuf_release(&trailer_block);
     - 
     - 	free_trailers(&head);
     --	trailer_info_release(&info);
       
       	/* Print the lines after the trailers as is */
       	if (!opts->only_trailers)
      -		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
     +-	trailer_info_release(&info);
      +		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
     -+
      +	trailer_info_release(info);
       
       	if (opts->in_place)
     @@ trailer.c
       struct conf_info {
       	char *name;
       	char *key;
     -@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
     - 	}
     +@@ trailer.c: static void unfold_value(struct strbuf *val)
     + 	strbuf_release(&out);
       }
       
      +static struct trailer_info *trailer_info_new(void)
     @@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
      +	struct trailer_info *info = xcalloc(1, sizeof(*info));
      +	return info;
      +}
     -+
     -+static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
     -+					     const char *str)
     -+{
     -+	struct trailer_info *info = trailer_info_new();
     -+	size_t end_of_log_message = 0, trailer_block_start = 0;
     -+	struct strbuf **trailer_lines, **ptr;
     -+	char **trailer_strings = NULL;
     -+	size_t nr = 0, alloc = 0;
     -+	char **last = NULL;
     -+
     -+	trailer_config_init();
     -+
     -+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
     -+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
     -+
     -+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
     -+					 end_of_log_message - trailer_block_start,
     -+					 '\n',
     -+					 0);
     -+	for (ptr = trailer_lines; *ptr; ptr++) {
     -+		if (last && isspace((*ptr)->buf[0])) {
     -+			struct strbuf sb = STRBUF_INIT;
     -+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
     -+			strbuf_addbuf(&sb, *ptr);
     -+			*last = strbuf_detach(&sb, NULL);
     -+			continue;
     -+		}
     -+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
     -+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
     -+		last = find_separator(trailer_strings[nr], separators) >= 1
     -+			? &trailer_strings[nr]
     -+			: NULL;
     -+		nr++;
     -+	}
     -+	strbuf_list_free(trailer_lines);
     -+
     -+	info->blank_line_before_trailer = ends_with_blank_line(str,
     -+							       trailer_block_start);
     -+	info->trailer_block_start = trailer_block_start;
     -+	info->trailer_block_end = end_of_log_message;
     -+	info->trailers = trailer_strings;
     -+	info->trailer_nr = nr;
     -+
     -+	return info;
     -+}
      +
       /*
        * Parse trailers in "str", populating the trailer info and "head"
     @@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
       	struct strbuf val = STRBUF_INIT;
       	size_t i;
       
     --	trailer_info_get(info, str, opts);
     +-	trailer_info_get(opts, str, info);
      +	info = trailer_info_get(opts, str);
       
       	for (i = 0; i < info->trailer_nr; i++) {
     @@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
     --void trailer_info_get(struct trailer_info *info, const char *str,
     --		      const struct process_trailer_options *opts)
     +-void trailer_info_get(const struct process_trailer_options *opts,
     +-		      const char *str,
     +-		      struct trailer_info *info)
      +size_t trailer_block_start(struct trailer_info *info)
     - {
     --	size_t end_of_log_message = 0, trailer_block_start = 0;
     --	struct strbuf **trailer_lines, **ptr;
     --	char **trailer_strings = NULL;
     --	size_t nr = 0, alloc = 0;
     --	char **last = NULL;
     --
     --	trailer_config_init();
     --
     --	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
     --	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
     ++{
      +	return info->trailer_block_start;
      +}
     - 
     --	trailer_lines = strbuf_split_buf(str + trailer_block_start,
     --					 end_of_log_message - trailer_block_start,
     --					 '\n',
     --					 0);
     --	for (ptr = trailer_lines; *ptr; ptr++) {
     --		if (last && isspace((*ptr)->buf[0])) {
     --			struct strbuf sb = STRBUF_INIT;
     --			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
     --			strbuf_addbuf(&sb, *ptr);
     --			*last = strbuf_detach(&sb, NULL);
     --			continue;
     --		}
     --		ALLOC_GROW(trailer_strings, nr + 1, alloc);
     --		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
     --		last = find_separator(trailer_strings[nr], separators) >= 1
     --			? &trailer_strings[nr]
     --			: NULL;
     --		nr++;
     --	}
     --	strbuf_list_free(trailer_lines);
     ++
      +size_t trailer_block_end(struct trailer_info *info)
      +{
      +	return info->trailer_block_end;
      +}
     - 
     --	info->blank_line_before_trailer = ends_with_blank_line(str,
     --							       trailer_block_start);
     --	info->trailer_block_start = trailer_block_start;
     --	info->trailer_block_end = end_of_log_message;
     --	info->trailers = trailer_strings;
     --	info->trailer_nr = nr;
     ++
      +int blank_line_before_trailer_block(struct trailer_info *info)
      +{
      +	return info->blank_line_before_trailer;
     ++}
     ++
     ++struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
     ++				      const char *str)
     + {
     ++	struct trailer_info *info = trailer_info_new();
     + 	size_t end_of_log_message = 0, trailer_block_start = 0;
     + 	struct strbuf **trailer_lines, **ptr;
     + 	char **trailer_strings = NULL;
     +@@ trailer.c: void trailer_info_get(const struct process_trailer_options *opts,
     + 	info->trailer_block_end = end_of_log_message;
     + 	info->trailers = trailer_strings;
     + 	info->trailer_nr = nr;
     ++
     ++	return info;
       }
       
       void trailer_info_release(struct trailer_info *info)
     @@ trailer.c: void trailer_info_release(struct trailer_info *info)
      +	free(info);
       }
       
     - void format_trailers_from_commit(const struct process_trailer_options *opts,
     + void format_trailers(const struct process_trailer_options *opts,
      @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options *opts,
       				 struct strbuf *out)
       {
     - 	LIST_HEAD(head);
     + 	LIST_HEAD(trailers);
      -	struct trailer_info info;
      -
     --	parse_trailers(opts, &info, msg, &head);
     -+	struct trailer_info *info = parse_trailers(opts, msg, &head);
     +-	parse_trailers(opts, &info, msg, &trailers);
     ++	struct trailer_info *info = parse_trailers(opts, msg, &trailers);
       
       	/* If we want the whole block untouched, we can take the fast path. */
       	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options
      +		strbuf_add(out, msg + info->trailer_block_start,
      +			   info->trailer_block_end - info->trailer_block_start);
       	} else
     - 		format_trailers(opts, &head, out);
     + 		format_trailers(opts, &trailers, out);
       
     - 	free_trailers(&head);
     + 	free_trailers(&trailers);
      -	trailer_info_release(&info);
      +	trailer_info_release(info);
       }
       
       void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
     - {
     - 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     -+	struct trailer_info *internal = trailer_info_new();
     +@@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
       	strbuf_init(&iter->key, 0);
       	strbuf_init(&iter->val, 0);
       	opts.no_divider = 1;
     --	trailer_info_get(&iter->internal.info, msg, &opts);
     -+	iter->internal.info = internal;
     +-	trailer_info_get(&opts, msg, &iter->internal.info);
      +	iter->internal.info = trailer_info_get(&opts, msg);
       	iter->internal.cur = 0;
       }
       
     -@@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
     + int trailer_iterator_advance(struct trailer_iterator *iter)
       {
     - 	char *line;
     - 	int separator_pos;
      -	if (iter->internal.cur < iter->internal.info.trailer_nr) {
     --		line = iter->internal.info.trailers[iter->internal.cur++];
     +-		char *line = iter->internal.info.trailers[iter->internal.cur++];
      +	if (iter->internal.cur < iter->internal.info->trailer_nr) {
     -+		line = iter->internal.info->trailers[iter->internal.cur++];
     - 		separator_pos = find_separator(line, separators);
     - 		iter->is_trailer = (separator_pos > 0);
     ++		char *line = iter->internal.info->trailers[iter->internal.cur++];
     + 		int separator_pos = find_separator(line, separators);
       
     + 		iter->raw = line;
      @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
       
       void trailer_iterator_release(struct trailer_iterator *iter)
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
       void process_trailers_lists(struct list_head *head,
       			    struct list_head *arg_head);
       
     --void parse_trailers(const struct process_trailer_options *opts,
     --		    struct trailer_info *info,
     +-void parse_trailers(const struct process_trailer_options *,
     +-		    struct trailer_info *,
      -		    const char *str,
      -		    struct list_head *head);
     -+struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     ++struct trailer_info *parse_trailers(const struct process_trailer_options *,
      +				    const char *str,
      +				    struct list_head *head);
     - 
     --void trailer_info_get(struct trailer_info *info, const char *str,
     --		      const struct process_trailer_options *opts);
     -+size_t trailer_block_start(struct trailer_info *info);
     -+size_t trailer_block_end(struct trailer_info *info);
     -+int blank_line_before_trailer_block(struct trailer_info *info);
     ++struct trailer_info *trailer_info_get(const struct process_trailer_options *,
     ++				      const char *str);
     + 
     +-void trailer_info_get(const struct process_trailer_options *,
     +-		      const char *str,
     +-		      struct trailer_info *);
     ++size_t trailer_block_start(struct trailer_info *);
     ++size_t trailer_block_end(struct trailer_info *);
     ++int blank_line_before_trailer_block(struct trailer_info *);
       
       void trailer_info_release(struct trailer_info *info);
       
  -:  ----------- > 20:  607ae7a90cd trailer: retire trailer_info_get() from API
  6:  0a9a7438c3f ! 21:  38f4b4c4135 trailer: spread usage of "trailer_block" language
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct proces
       
       	/* Print trailer block. */
      -	format_trailers(opts, &head, &trailer_block);
     ++	format_trailers(opts, &head, &tb);
     + 	free_trailers(&head);
      -	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
      -	strbuf_release(&trailer_block);
     -+	format_trailers(opts, &head, &tb);
      +	fwrite(tb.buf, 1, tb.len, outfile);
      +	strbuf_release(&tb);
       
     - 	free_trailers(&head);
     - 
      -	/* Print the lines after the trailers as is */
     -+	/* Print the lines after the trailer block as is */
     ++	/* Print the lines after the trailer block as is. */
       	if (!opts->only_trailers)
      -		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
     --
      -	trailer_info_release(info);
     -+		fwrite(sb.buf + trailer_block_end(trailer_block),
     -+		       1, sb.len - trailer_block_end(trailer_block), outfile);
     ++		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
     ++		       sb.len - trailer_block_end(trailer_block), outfile);
      +	trailer_block_release(trailer_block);
       
       	if (opts->in_place)
     @@ trailer.c
       
       	/*
       	 * Array of trailers found.
     -@@ trailer.c: void format_trailers(const struct process_trailer_options *opts,
     - 	}
     +@@ trailer.c: static void unfold_value(struct strbuf *val)
     + 	strbuf_release(&out);
       }
       
      -static struct trailer_info *trailer_info_new(void)
     @@ trailer.c: void free_trailers(struct list_head *trailers)
      +	free(trailer_block);
       }
       
     - void format_trailers_from_commit(const struct process_trailer_options *opts,
     + void format_trailers(const struct process_trailer_options *opts,
      @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options *opts,
       				 struct strbuf *out)
       {
     - 	LIST_HEAD(head);
     --	struct trailer_info *info = parse_trailers(opts, msg, &head);
     -+	struct trailer_block *trailer_block = parse_trailers(opts, msg, &head);
     + 	LIST_HEAD(trailers);
     +-	struct trailer_info *info = parse_trailers(opts, msg, &trailers);
     ++	struct trailer_block *trailer_block = parse_trailers(opts, msg, &trailers);
       
       	/* If we want the whole block untouched, we can take the fast path. */
       	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options
      +		strbuf_add(out, msg + trailer_block->start,
      +			   trailer_block->end - trailer_block->start);
       	} else
     - 		format_trailers(opts, &head, out);
     + 		format_trailers(opts, &trailers, out);
       
     - 	free_trailers(&head);
     + 	free_trailers(&trailers);
      -	trailer_info_release(info);
      +	trailer_block_release(trailer_block);
       }
       
       void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
     - {
     - 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     --	struct trailer_info *internal = trailer_info_new();
     +@@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
       	strbuf_init(&iter->key, 0);
       	strbuf_init(&iter->val, 0);
       	opts.no_divider = 1;
     --	iter->internal.info = internal;
      -	iter->internal.info = trailer_info_get(&opts, msg);
      +	iter->internal.trailer_block = trailer_block_get(&opts, msg);
       	iter->internal.cur = 0;
       }
       
     -@@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
     + int trailer_iterator_advance(struct trailer_iterator *iter)
       {
     - 	char *line;
     - 	int separator_pos;
      -	if (iter->internal.cur < iter->internal.info->trailer_nr) {
     --		line = iter->internal.info->trailers[iter->internal.cur++];
     +-		char *line = iter->internal.info->trailers[iter->internal.cur++];
      +	if (iter->internal.cur < iter->internal.trailer_block->trailer_nr) {
     -+		line = iter->internal.trailer_block->trailers[iter->internal.cur++];
     - 		separator_pos = find_separator(line, separators);
     - 		iter->is_trailer = (separator_pos > 0);
     ++		char *line = iter->internal.trailer_block->trailers[iter->internal.cur++];
     + 		int separator_pos = find_separator(line, separators);
       
     + 		iter->raw = line;
      @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
       
       void trailer_iterator_release(struct trailer_iterator *iter)
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
       void process_trailers_lists(struct list_head *head,
       			    struct list_head *arg_head);
       
     --struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
     +-struct trailer_info *parse_trailers(const struct process_trailer_options *,
      -				    const char *str,
      -				    struct list_head *head);
     -+struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
     ++struct trailer_block *parse_trailers(const struct process_trailer_options *,
      +				     const char *str,
      +				     struct list_head *head);
       
     --size_t trailer_block_start(struct trailer_info *info);
     --size_t trailer_block_end(struct trailer_info *info);
     --int blank_line_before_trailer_block(struct trailer_info *info);
     -+size_t trailer_block_start(struct trailer_block *trailer_block);
     -+size_t trailer_block_end(struct trailer_block *trailer_block);
     -+int blank_line_before_trailer_block(struct trailer_block *trailer_block);
     +-size_t trailer_block_start(struct trailer_info *);
     +-size_t trailer_block_end(struct trailer_info *);
     +-int blank_line_before_trailer_block(struct trailer_info *);
     ++size_t trailer_block_start(struct trailer_block *);
     ++size_t trailer_block_end(struct trailer_block *);
     ++int blank_line_before_trailer_block(struct trailer_block *);
       
      -void trailer_info_release(struct trailer_info *info);
     -+void trailer_block_release(struct trailer_block *trailer_block);
     ++void trailer_block_release(struct trailer_block *);
       
       void trailer_config_init(void);
     - void format_trailers(const struct process_trailer_options *opts,
     + void format_trailers(const struct process_trailer_options *,
      @@ trailer.h: struct trailer_iterator {
       
       	/* private */
  7:  97e5d86ddf0 ! 22:  94bf182e3ff trailer: prepare to move parse_trailers_from_command_line_args() to builtin
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: prepare to move parse_trailers_from_command_line_args() to builtin
     +    trailer: prepare to delete "parse_trailers_from_command_line_args()"
      
     -    Expose more functions in the trailer.h API, in preparation for moving
     -    out
     +    Expose more functions in the trailer.h API, in preparation for deleting
      
              parse_trailers_from_command_line_args()
      
     -    to interpret-trailer.c, because the trailer API should not be concerned
     +    from the trailers implementation, because it should not be concerned
          with command line arguments (as they have nothing to do with trailers
     -    themselves). The interpret-trailers builtin is the only caller of this
     -    function.
     +    themselves). Indeed, the interpret-trailers builtin is the only caller
     +    of this function inside Git.
      
     -    Rename add_arg_item() to trailer_add_arg_item() because it will have to
     -    be exposed as an API function in the next patch. Rename
     -    new_trailers_clear() to free_new_trailers() because it will be promoted
     -    into an API function; the API already has free_trailers(), so using the
     -    "free_*" naming style will keep it consistent. Also rename "conf_info"
     -    to "trailer_conf" for readability, dropping the low-value "_info" suffix
     -    as we did earlier in this series for "trailer_info" to "trailer_block".
     +    Rename add_arg_item() to trailer_add_arg_item() to expose it as an API
     +    function. Rename new_trailers_clear() to free_new_trailers() because it
     +    will be promoted into an API function; the API already has
     +    free_trailers(), so using the "free_*" naming style will keep it
     +    consistent. Also rename "conf_info" to "trailer_conf" for readability,
     +    dropping the low-value "_info" suffix as we did earlier in this series
     +    for "trailer_info" to "trailer_block".
      
          Helped-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Linus Arver <linusa@google.com>
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
      -static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
      -			 const struct conf_info *conf,
      -			 const struct new_trailer_item *new_trailer_item)
     -+static void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     -+				 const struct trailer_conf *conf,
     -+				 const struct new_trailer_item *new_trailer_item)
     ++void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     ++			  const struct trailer_conf *conf,
     ++			  const struct new_trailer_item *new_trailer_item)
       {
       	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
       	new_item->token = tok;
     @@ trailer.c: int trailer_iterator_advance(struct trailer_iterator *iter)
      -		parse_trailer(&iter->key, &iter->val, NULL,
      -			      line, separator_pos);
      +		parse_trailer(line, separator_pos, &iter->key, &iter->val, NULL);
     + 		/* Always unfold values during iteration. */
       		unfold_value(&iter->val);
       		return 1;
     - 	}
      
       ## trailer.h ##
      @@
     @@ trailer.h: struct new_trailer_item {
       
      +void duplicate_trailer_conf(struct trailer_conf *dst,
      +			    const struct trailer_conf *src);
     ++void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     ++			  const struct trailer_conf *conf,
     ++			  const struct new_trailer_item *new_trailer_item);
      +
       struct process_trailer_options {
       	int in_place;
     @@ trailer.h: void parse_trailers_from_command_line_args(struct list_head *arg_head
      +
      +void parse_trailer(const char *line, ssize_t separator_pos,
      +		   struct strbuf *tok, struct strbuf *val,
     -+		   const struct trailer_conf **conf);
     ++		   const struct trailer_conf **);
      +
     - struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
     + struct trailer_block *parse_trailers(const struct process_trailer_options *,
       				     const char *str,
       				     struct list_head *head);
  8:  465dc51cdcb ! 23:  3bfe4809ecb trailer: move arg handling to interpret-trailers.c
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: move arg handling to interpret-trailers.c
     +    trailer: add new helper functions to API
      
     -    We don't move the "arg_item" struct to interpret-trailers.c, because it
     -    is now a struct that contains information about trailers that could be
     -    added into the input text's own trailers. This is a generic concept that
     -    extends beyond trailers defined as CLI arguments (it applies to trailers
     -    defined in configuration as well). We will rename "arg_item" to
     -    "trailer_template" in a follow-up patch to keep the diff here small.
     +    This is a preparatory refactor for deprecating "new_trailer_item" from
     +    the API (which will let us deprecate
     +    parse_trailers_from_command_line_args()).
     +
     +    Expose new helper functions from the API, because we'll be calling them
     +    from interpret-trailers.c soon when we move
     +    parse_trailers_from_command_line_args() there.
     +
     +    Move free_new_trailers() from the builtin to trailer.c because later on
     +    we will adjust it to free arg_item structs, which are private to
     +    trailer.c.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct op
      -		free(item);
      -	}
      -}
     -+static char *cl_separators;
     - 
     +-
       static int option_parse_trailer(const struct option *opt,
       				   const char *arg, int unset)
       {
     - 	struct list_head *trailers = opt->value;
     --	struct new_trailer_item *item;
     -+	struct strbuf tok = STRBUF_INIT;
     -+	struct strbuf val = STRBUF_INIT;
     -+	const struct trailer_conf *conf;
     -+	struct trailer_conf *conf_current = new_trailer_conf();
     -+	ssize_t separator_pos;
     - 
     - 	if (unset) {
     - 		free_new_trailers(trailers);
     -@@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     - 	if (!arg)
     - 		return -1;
     - 
     --	item = xmalloc(sizeof(*item));
     --	item->text = arg;
     --	item->where = where;
     --	item->if_exists = if_exists;
     --	item->if_missing = if_missing;
     --	list_add_tail(&item->list, trailers);
     -+	separator_pos = find_separator(arg, cl_separators);
     -+	if (separator_pos) {
     -+		parse_trailer(arg, separator_pos, &tok, &val, &conf);
     -+		duplicate_trailer_conf(conf_current, conf);
     -+
     -+		/*
     -+		 * Override conf_current with settings specified via CLI flags.
     -+		 */
     -+		trailer_conf_set(where, if_exists, if_missing, conf_current);
     -+
     -+		trailer_add_arg_item(strbuf_detach(&tok, NULL),
     -+				     strbuf_detach(&val, NULL),
     -+				     conf_current,
     -+				     trailers);
     -+	} else {
     -+		struct strbuf sb = STRBUF_INIT;
     -+		strbuf_addstr(&sb, arg);
     -+		strbuf_trim(&sb);
     -+		error(_("empty trailer token in trailer '%.*s'"),
     -+			(int) sb.len, sb.buf);
     -+		strbuf_release(&sb);
     -+	}
     -+
     -+	free(conf_current);
     -+
     - 	return 0;
     - }
     - 
     -@@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
     - }
     - 
     - static void interpret_trailers(const struct process_trailer_options *opts,
     --			       struct list_head *new_trailer_head,
     -+			       struct list_head *arg_trailers,
     - 			       const char *file)
     - {
     - 	LIST_HEAD(head);
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - 	struct trailer_block *trailer_block;
     - 	FILE *outfile = stdout;
     - 
     --	trailer_config_init();
     --
     - 	read_input_file(&sb, file);
     - 
     - 	if (opts->in_place)
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - 
     - 
     - 	if (!opts->only_input) {
     --		LIST_HEAD(config_head);
     --		LIST_HEAD(arg_head);
     --		parse_trailers_from_config(&config_head);
     --		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
     --		list_splice(&config_head, &arg_head);
     --		process_trailers_lists(&head, &arg_head);
     -+		process_trailers_lists(&head, arg_trailers);
     - 	}
     - 
     - 	/* Print trailer block. */
     -@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     - int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     - {
     - 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     --	LIST_HEAD(trailers);
     -+	LIST_HEAD(configured_trailers);
     -+	LIST_HEAD(arg_trailers);
     - 
     - 	struct option options[] = {
     - 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
     -@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     - 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
     - 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
     - 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
     --		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
     -+		OPT_CALLBACK(0, "trailer", &arg_trailers, N_("trailer"),
     - 				N_("trailer(s) to add"), option_parse_trailer),
     - 		OPT_END()
     - 	};
     - 
     - 	git_config(git_default_config, NULL);
     -+	trailer_config_init();
     -+
     -+	if (!opts.only_input) {
     -+		parse_trailers_from_config(&configured_trailers);
     -+	}
     -+
     -+	/*
     -+	* In command-line arguments, '=' is accepted (in addition to the
     -+	* separators that are defined).
     -+	*/
     -+	cl_separators = xstrfmt("=%s", trailer_default_separators());
     - 
     - 	argc = parse_options(argc, argv, prefix, options,
     - 			     git_interpret_trailers_usage, 0);
     - 
     --	if (opts.only_input && !list_empty(&trailers))
     -+	free(cl_separators);
     -+
     -+	if (opts.only_input && !list_empty(&arg_trailers))
     - 		usage_msg_opt(
     - 			_("--trailer with --only-input does not make sense"),
     - 			git_interpret_trailers_usage,
     - 			options);
     - 
     -+	list_splice(&configured_trailers, &arg_trailers);
     -+
     - 	if (argc) {
     - 		int i;
     - 		for (i = 0; i < argc; i++)
     --			interpret_trailers(&opts, &trailers, argv[i]);
     -+			interpret_trailers(&opts, &arg_trailers, argv[i]);
     - 	} else {
     - 		if (opts.in_place)
     - 			die(_("no input file given for in-place editing"));
     --		interpret_trailers(&opts, &trailers, NULL);
     -+		interpret_trailers(&opts, &arg_trailers, NULL);
     - 	}
     - 
     --	free_new_trailers(&trailers);
     -+	free_new_trailers(&arg_trailers);
     - 
     - 	return 0;
     - }
      
       ## trailer.c ##
      @@ trailer.c: static LIST_HEAD(conf_head);
     @@ trailer.c: int trailer_set_if_missing(enum trailer_if_missing *item, const char
       	return 0;
       }
       
     -+void trailer_conf_set(enum trailer_where where,
     -+		      enum trailer_if_exists if_exists,
     -+		      enum trailer_if_missing if_missing,
     -+		      struct trailer_conf *conf)
     ++void trailer_set_conf_where(enum trailer_where where,
     ++			    struct trailer_conf *conf)
     ++{
     ++	conf->where = where;
     ++}
     ++
     ++void trailer_set_conf_if_exists(enum trailer_if_exists if_exists,
     ++				struct trailer_conf *conf)
     ++{
     ++	conf->if_exists = if_exists;
     ++}
     ++
     ++void trailer_set_conf_if_missing(enum trailer_if_missing if_missing,
     ++				 struct trailer_conf *conf)
      +{
     -+	if (where != WHERE_DEFAULT)
     -+		conf->where = where;
     -+	if (if_exists != EXISTS_DEFAULT)
     -+		conf->if_exists = if_exists;
     -+	if (if_missing != MISSING_DEFAULT)
     -+		conf->if_missing = if_missing;
     ++	conf->if_missing = if_missing;
      +}
      +
      +struct trailer_conf *new_trailer_conf(void)
      +{
     -+	struct trailer_conf *new = xcalloc(1, sizeof(*new));
     -+	return new;
     ++	 return xcalloc(1, sizeof(struct trailer_conf));
      +}
      +
       void duplicate_trailer_conf(struct trailer_conf *dst,
       			    const struct trailer_conf *src)
       {
     -@@ trailer.c: ssize_t find_separator(const char *line, const char *separators)
     - /*
     -  * Obtain the token, value, and conf from the given trailer.
     -  *
     -+ * The conf needs special handling. We first read hardcoded defaults, and
     -+ * override them if we find a matching trailer configuration.
     -+ *
     -  * separator_pos must not be 0, since the token cannot be an empty string.
     -  *
     -  * If separator_pos is -1, interpret the whole trailer as a token.
     -@@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
     - 	return new_item;
     +@@ trailer.c: void duplicate_trailer_conf(struct trailer_conf *dst,
     + 	dst->cmd = xstrdup_or_null(src->cmd);
       }
       
     --static void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     --				 const struct trailer_conf *conf,
     --				 const struct new_trailer_item *new_trailer_item)
     -+void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     -+			  struct list_head *arg_head)
     ++void free_trailer_conf(struct trailer_conf *conf)
     ++{
     ++	free(conf->name);
     ++	free(conf->key);
     ++	free(conf->command);
     ++	free(conf->cmd);
     ++	free(conf);
     ++}
     ++
     + static struct arg_item *get_conf_item(const char *name)
       {
     - 	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
     - 	new_item->token = tok;
     - 	new_item->value = val;
     - 	duplicate_trailer_conf(&new_item->conf, conf);
     --	if (new_trailer_item) {
     --		if (new_trailer_item->where != WHERE_DEFAULT)
     --			new_item->conf.where = new_trailer_item->where;
     --		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
     --			new_item->conf.if_exists = new_trailer_item->if_exists;
     --		if (new_trailer_item->if_missing != MISSING_DEFAULT)
     --			new_item->conf.if_missing = new_trailer_item->if_missing;
     --	}
     - 	list_add_tail(&new_item->list, arg_head);
     - }
     - 
     -@@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
     - 	list_for_each(pos, &conf_head) {
     - 		item = list_entry(pos, struct arg_item, list);
     - 		if (item->conf.command)
     --			trailer_add_arg_item(config_head,
     --					     xstrdup(token_from_item(item, NULL)),
     -+			trailer_add_arg_item(xstrdup(token_from_item(item, NULL)),
     - 					     xstrdup(""),
     --					     &item->conf, NULL);
     -+					     &item->conf,
     -+					     config_head);
     - 	}
     - }
     - 
     -@@ trailer.c: void parse_trailers_from_command_line_args(struct list_head *arg_head,
     - 			strbuf_release(&sb);
     - 		} else {
     - 			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
     --			trailer_add_arg_item(arg_head,
     --					     strbuf_detach(&tok, NULL),
     -+			trailer_add_arg_item(strbuf_detach(&tok, NULL),
     - 					     strbuf_detach(&val, NULL),
     --					     conf, tr);
     -+					     conf,
     -+					     arg_head);
     - 		}
     - 	}
     - 
     + 	struct list_head *pos;
      @@ trailer.c: void free_trailers(struct list_head *trailers)
       	}
       }
       
      +void free_new_trailers(struct list_head *trailers)
      +{
     -+	struct list_head *pos, *p;
     ++	struct list_head *pos, *tmp;
     ++	struct new_trailer_item *item;
      +
     -+	list_for_each_safe(pos, p, trailers) {
     ++	list_for_each_safe(pos, tmp, trailers) {
     ++		item = list_entry(pos, struct new_trailer_item, list);
      +		list_del(pos);
     -+		free_arg_item(list_entry(pos, struct arg_item, list));
     ++		free(item);
      +	}
      +}
      +
     @@ trailer.h: struct new_trailer_item {
       	enum trailer_if_missing if_missing;
       };
       
     -+void trailer_conf_set(enum trailer_where where,
     -+		      enum trailer_if_exists if_exists,
     -+		      enum trailer_if_missing if_missing,
     -+		      struct trailer_conf *conf);
     ++void trailer_set_conf_where(enum trailer_where, struct trailer_conf *);
     ++void trailer_set_conf_if_exists(enum trailer_if_exists, struct trailer_conf *);
     ++void trailer_set_conf_if_missing(enum trailer_if_missing, struct trailer_conf *);
      +
      +struct trailer_conf *new_trailer_conf(void);
       void duplicate_trailer_conf(struct trailer_conf *dst,
       			    const struct trailer_conf *src);
     - 
      +const char *trailer_default_separators(void);
     -+
     -+void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     -+			  struct list_head *arg_head);
     -+
     - struct process_trailer_options {
     - 	int in_place;
     - 	int trim_empty;
     -@@ trailer.h: void format_trailers(const struct process_trailer_options *opts,
     + void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     + 			  const struct trailer_conf *conf,
     + 			  const struct new_trailer_item *new_trailer_item);
     +@@ trailer.h: void format_trailers(const struct process_trailer_options *,
       		     struct list_head *trailers,
       		     struct strbuf *out);
       void free_trailers(struct list_head *);
      +void free_new_trailers(struct list_head *);
     ++void free_trailer_conf(struct trailer_conf *);
       
       /*
        * Convenience function to format the trailers from the commit msg "msg" into
  -:  ----------- > 24:  80e1958bb8d trailer_add_arg_item(): drop new_trailer_item usage
  9:  885ac87a544 ! 25:  a9080597a28 trailer: delete obsolete argument handling code from API
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: delete obsolete argument handling code from API
     +    trailer: deprecate "new_trailer_item" struct from API
      
     -    This commit was not squashed with its parent in order to keep the diff
     -    separate (to make the additive changes in the parent easier to read).
     +    Previously, the "new_trailer_item" struct served only one purpose --- to
     +    capture the unparsed raw string <RAW> in "--trailer <RAW>", as well as
     +    the current state of the "where", "if_exists", and "if_missing" global
     +    variables at the time that the "--trailer <RAW>" CLI argument was
     +    encountered.
      
     -    Note that we remove the "new_trailer_item" struct, because it has some
     -    overlap with "arg_item" struct that also deals with trailers coming from
     -    the command line. The latter will be renamed to "trailer_template" in
     -    the next patch.
     +    In addition, the previous CLI argument handling behavior was to capture
     +    the <RAW> string in all "--trailer <RAW>" arguments and to collect
     +    them (via option_parse_trailer()) into the "new_trailer_head" list. We
     +    would then iterate over this list again in
     +    parse_trailers_from_command_line_args() and convert these
     +    "new_trailer_item" objects into "arg_item" objects.
     +
     +    Skip this intermediate storage of "new_trailer_item" objects in favor of
     +    just storing "arg_item" objects. Remove the looping behavior of
     +    parse_trailers_from_command_line_args() so that it parses a single
     +    "--trailer ..." argument at a time. Rename it to
     +    parse_trailer_from_command_line_arg() to reflect this new behavior of
     +    only looking at one string (not multiple strings) at a time. Make
     +    option_parse_trailer() call parse_trailer_from_command_line_arg() so
     +    that the CLI arguments it sees are parsed immediately without the need
     +    for intermediate storage.
     +
     +    Delete "new_trailer_item", because we don't need it any more.
     +
     +    In the next patch we will retire parse_trailer_from_command_line_arg()
     +    as well, combining it with option_parse_trailer().
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     + ## builtin/interpret-trailers.c ##
     +@@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     + 				   const char *arg, int unset)
     + {
     + 	struct list_head *trailers = opt->value;
     +-	struct new_trailer_item *item;
     + 
     + 	if (unset) {
     + 		free_new_trailers(trailers);
     +@@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     + 	if (!arg)
     + 		return -1;
     + 
     +-	item = xmalloc(sizeof(*item));
     +-	item->text = arg;
     +-	item->where = where;
     +-	item->if_exists = if_exists;
     +-	item->if_missing = if_missing;
     +-	list_add_tail(&item->list, trailers);
     ++	parse_trailer_from_command_line_arg(arg, where, if_exists, if_missing, trailers);
     ++
     + 	return 0;
     + }
     + 
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     + 	struct trailer_block *trailer_block;
     + 	FILE *outfile = stdout;
     + 
     +-	trailer_config_init();
     +-
     + 	read_input_file(&sb, file);
     + 
     + 	if (opts->in_place)
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     + 	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
     + 		fprintf(outfile, "\n");
     + 
     +-
     +-	if (!opts->only_input) {
     +-		LIST_HEAD(config_head);
     +-		LIST_HEAD(arg_head);
     +-		parse_trailers_from_config(&config_head);
     +-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
     +-		list_splice(&config_head, &arg_head);
     +-		process_trailers_lists(&head, &arg_head);
     +-	}
     ++	if (!opts->only_input)
     ++		process_trailers_lists(&head, new_trailer_head);
     + 
     + 	/* Print trailer block. */
     + 	format_trailers(opts, &head, &tb);
     +@@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     + int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     + {
     + 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
     ++	LIST_HEAD(configured_trailers);
     + 	LIST_HEAD(trailers);
     + 
     + 	struct option options[] = {
     +@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     + 	};
     + 
     + 	git_config(git_default_config, NULL);
     ++	trailer_config_init();
     ++
     ++	if (!opts.only_input)
     ++		parse_trailers_from_config(&configured_trailers);
     + 
     + 	argc = parse_options(argc, argv, prefix, options,
     + 			     git_interpret_trailers_usage, 0);
     +@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     + 			git_interpret_trailers_usage,
     + 			options);
     + 
     ++	list_splice(&configured_trailers, &trailers);
     ++
     + 	if (argc) {
     + 		int i;
     + 		for (i = 0; i < argc; i++)
     +
       ## trailer.c ##
      @@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
       	}
     @@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
       
      -void parse_trailers_from_command_line_args(struct list_head *arg_head,
      -					   struct list_head *new_trailer_head)
     --{
     --	struct strbuf tok = STRBUF_INIT;
     --	struct strbuf val = STRBUF_INIT;
     --	const struct trailer_conf *conf;
     ++void parse_trailer_from_command_line_arg(const char *line,
     ++					 enum trailer_where where,
     ++					 enum trailer_if_exists if_exists,
     ++					 enum trailer_if_missing if_missing,
     ++					 struct list_head *arg_head)
     + {
     + 	struct strbuf tok = STRBUF_INIT;
     + 	struct strbuf val = STRBUF_INIT;
     + 	const struct trailer_conf *conf;
      -	struct list_head *pos;
     --
     --	/*
     --	 * In command-line arguments, '=' is accepted (in addition to the
     --	 * separators that are defined).
     --	 */
     + 
     + 	/*
     + 	 * In command-line arguments, '=' is accepted (in addition to the
     + 	 * separators that are defined).
     + 	 */
      -	char *cl_separators = xstrfmt("=%s", separators);
     --
     ++	char *cl_separators = xstrfmt("=%s", trailer_default_separators());
     + 
      -	/* Add an arg item for each trailer on the command line */
      -	list_for_each(pos, new_trailer_head) {
      -		struct new_trailer_item *tr =
      -			list_entry(pos, struct new_trailer_item, list);
      -		ssize_t separator_pos = find_separator(tr->text, cl_separators);
     --
     ++	/* Add an arg item for a trailer from the command line */
     ++	ssize_t separator_pos = find_separator(line, cl_separators);
     ++	free(cl_separators);
     + 
      -		if (separator_pos == 0) {
      -			struct strbuf sb = STRBUF_INIT;
      -			strbuf_addstr(&sb, tr->text);
     @@ trailer.c: void parse_trailers_from_config(struct list_head *config_head)
      -			      (int) sb.len, sb.buf);
      -			strbuf_release(&sb);
      -		} else {
     +-			struct trailer_conf *conf_current = new_trailer_conf();
      -			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
     --			trailer_add_arg_item(strbuf_detach(&tok, NULL),
     +-			duplicate_trailer_conf(conf_current, conf);
     ++	if (separator_pos == 0) {
     ++		struct strbuf sb = STRBUF_INIT;
     ++		strbuf_addstr(&sb, line);
     ++		strbuf_trim(&sb);
     ++		error(_("empty trailer token in trailer '%.*s'"),
     ++		      (int) sb.len, sb.buf);
     ++		strbuf_release(&sb);
     ++	} else {
     ++		struct trailer_conf *conf_current = new_trailer_conf();
     ++		parse_trailer(line, separator_pos, &tok, &val, &conf);
     ++		duplicate_trailer_conf(conf_current, conf);
     + 
     +-			/*
     +-			 * Override conf_current with settings specified via CLI flags.
     +-			 */
     +-			if (tr->where != WHERE_DEFAULT)
     +-				trailer_set_conf_where(tr->where, conf_current);
     +-			if (tr->if_exists != EXISTS_DEFAULT)
     +-				trailer_set_conf_if_exists(tr->if_exists, conf_current);
     +-			if (tr->if_missing != MISSING_DEFAULT)
     +-				trailer_set_conf_if_missing(tr->if_missing, conf_current);
     +-
     +-			trailer_add_arg_item(arg_head,
     +-					     strbuf_detach(&tok, NULL),
      -					     strbuf_detach(&val, NULL),
     --					     conf,
     --					     arg_head);
     +-					     conf_current);
     +-			free_trailer_conf(conf_current);
      -		}
     --	}
     ++		/*
     ++		 * Override conf_current with settings specified via CLI flags.
     ++		 */
     ++		if (where != WHERE_DEFAULT)
     ++			trailer_set_conf_where(where, conf_current);
     ++		if (if_exists != EXISTS_DEFAULT)
     ++			trailer_set_conf_if_exists(if_exists, conf_current);
     ++		if (if_missing != MISSING_DEFAULT)
     ++			trailer_set_conf_if_missing(if_missing, conf_current);
     ++
     ++		trailer_add_arg_item(arg_head,
     ++				     strbuf_detach(&tok, NULL),
     ++				     strbuf_detach(&val, NULL),
     ++				     conf_current);
     ++		free_trailer_conf(conf_current);
     + 	}
      -
      -	free(cl_separators);
     --}
     --
     + }
     + 
       static const char *next_line(const char *str)
     +@@ trailer.c: void free_trailers(struct list_head *trailers)
     + 
     + void free_new_trailers(struct list_head *trailers)
       {
     - 	const char *nl = strchrnul(str, '\n');
     +-	struct list_head *pos, *tmp;
     +-	struct new_trailer_item *item;
     ++	struct list_head *pos, *p;
     + 
     +-	list_for_each_safe(pos, tmp, trailers) {
     +-		item = list_entry(pos, struct new_trailer_item, list);
     ++	list_for_each_safe(pos, p, trailers) {
     + 		list_del(pos);
     +-		free(item);
     ++		free_arg_item(list_entry(pos, struct arg_item, list));
     + 	}
     + }
     + 
      
       ## trailer.h ##
      @@ trailer.h: int trailer_set_where(enum trailer_where *item, const char *value);
     @@ trailer.h: int trailer_set_where(enum trailer_where *item, const char *value);
      -	enum trailer_if_missing if_missing;
      -};
      -
     - void trailer_conf_set(enum trailer_where where,
     - 		      enum trailer_if_exists if_exists,
     - 		      enum trailer_if_missing if_missing,
     + void trailer_set_conf_where(enum trailer_where, struct trailer_conf *);
     + void trailer_set_conf_if_exists(enum trailer_if_exists, struct trailer_conf *);
     + void trailer_set_conf_if_missing(enum trailer_if_missing, struct trailer_conf *);
      @@ trailer.h: struct process_trailer_options {
       
       void parse_trailers_from_config(struct list_head *config_head);
       
      -void parse_trailers_from_command_line_args(struct list_head *arg_head,
      -					   struct list_head *new_trailer_head);
     --
     ++void parse_trailer_from_command_line_arg(const char *line,
     ++					 enum trailer_where where,
     ++					 enum trailer_if_exists if_exists,
     ++					 enum trailer_if_missing if_missing,
     ++					 struct list_head *arg_head);
     + 
       void process_trailers_lists(struct list_head *head,
       			    struct list_head *arg_head);
     - 
  -:  ----------- > 26:  9720526dd8a trailer: unify "--trailer ..." arg handling
  -:  ----------- > 27:  26df2514acb trailer_set_*(): put out parameter at the end
 10:  bcd3fc9660e ! 28:  14927038d85 trailer: introduce "template" term for readability
     @@ Commit message
            - [*] check_if_different()         (reorder parameters only)
            - [*] find_same_and_apply_arg()    (reorder parameters only)
      
     -    Reorder parameters where appropriate; these functions have been marked
     -    with an asterisk ([*]).
     +    Reorder parameters to prefer input parameters toward the beginning and
     +    out parameters at the end; these functions have been marked with an
     +    asterisk ([*]).
      
          This removes the "arg" terminology (standing for "CLI arguments") from
          the trailer implementation, which makes sense because trailers
     @@ Commit message
          block) and trailer templates that are defined as CLI args or
          configurations. Some functions implied a single action when they could
          do two different things, so introduce words like "maybe" and "or" to
     -    unmask their behavior.
     +    make their behavior more explicit.
      
          In summary this patch renames and reorders parameters for readability,
          without any behavioral change. We don't rename
     -    find_same_and_apply_arg(), because it will be refactored soon. As an
     -    added benefit, we no longer use the term "arg" to mean "CLI arguments"
     -    in the trailer implementation, because trailers themselves should not be
     -    concerned about CLI arguments (this is the domain of the
     -    interpret-trailers builtin).
     +    find_same_and_apply_arg(), because it will be refactored soon.
      
          For parse_trailers_from_config() (renamed to
          parse_trailer_templates_from_config()), add a NEEDSWORK discussion about
          how the deprecated trailer.*.command configuration option is oddly more
          featureful than trailer.*.cmd (if we were to remove support for
          trailer.*.command, users would not be able to replicate the behavior
     -    with trailer.*.cmd and lose out on functionality).
     +    with trailer.*.cmd and would lose out on functionality).
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
      @@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct option *opt,
     - 
     - static char *cl_separators;
     + 	return trailer_set_if_missing(arg, opt->value);
     + }
       
      -static int option_parse_trailer(const struct option *opt,
      -				   const char *arg, int unset)
     @@ builtin/interpret-trailers.c: static int option_parse_if_missing(const struct op
       	struct strbuf val = STRBUF_INIT;
       	const struct trailer_conf *conf;
      @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     - 	ssize_t separator_pos;
     + 	static char *cl_separators;
       
       	if (unset) {
      -		free_new_trailers(trailers);
     @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct optio
       	}
       
      @@ builtin/interpret-trailers.c: static int option_parse_trailer(const struct option *opt,
     - 		 */
     - 		trailer_conf_set(where, if_exists, if_missing, conf_current);
     + 		if (if_missing != MISSING_DEFAULT)
     + 			trailer_set_conf_if_missing(if_missing, conf_current);
       
     --		trailer_add_arg_item(strbuf_detach(&tok, NULL),
     +-		trailer_add_arg_item(trailers,
     +-				     strbuf_detach(&tok, NULL),
      +		add_trailer_template(strbuf_detach(&tok, NULL),
       				     strbuf_detach(&val, NULL),
     - 				     conf_current,
     --				     trailers);
     +-				     conf_current);
     ++				     conf_current,
      +				     templates);
     - 	} else {
     - 		struct strbuf sb = STRBUF_INIT;
     - 		strbuf_addstr(&sb, arg);
     + 		free_trailer_conf(conf_current);
     + 	}
     + 
      @@ builtin/interpret-trailers.c: static void read_input_file(struct strbuf *sb, const char *file)
       }
       
       static void interpret_trailers(const struct process_trailer_options *opts,
     --			       struct list_head *arg_trailers,
     +-			       struct list_head *new_trailer_head,
      +			       struct list_head *templates,
       			       const char *file)
       {
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct proces
       	/* Print the lines before the trailer block */
       	if (!opts->only_trailers)
      @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
     + 		fprintf(outfile, "\n");
       
     - 
     - 	if (!opts->only_input) {
     --		process_trailers_lists(&head, arg_trailers);
     + 	if (!opts->only_input)
     +-		process_trailers_lists(&head, new_trailer_head);
      +		apply_trailer_templates(templates, &trailers_from_sb);
     - 	}
       
       	/* Print trailer block. */
      -	format_trailers(opts, &head, &tb);
     +-	free_trailers(&head);
      +	format_trailers(opts, &trailers_from_sb, &tb);
     ++	free_trailers(&trailers_from_sb);
       	fwrite(tb.buf, 1, tb.len, outfile);
       	strbuf_release(&tb);
       
     --	free_trailers(&head);
     -+	free_trailers(&trailers_from_sb);
     - 
     - 	/* Print the lines after the trailer block as is */
     - 	if (!opts->only_trailers)
      @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
       int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
       {
       	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
      -	LIST_HEAD(configured_trailers);
     --	LIST_HEAD(arg_trailers);
     +-	LIST_HEAD(trailers);
      +	LIST_HEAD(configured_templates);
      +	LIST_HEAD(templates);
       
     @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **
       		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
       			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
       		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
     --		OPT_CALLBACK(0, "trailer", &arg_trailers, N_("trailer"),
     +-		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
      -				N_("trailer(s) to add"), option_parse_trailer),
      +		OPT_CALLBACK(0, "trailer", &templates, N_("trailer"),
      +				N_("trailer(s) to add"), option_parse_trailer_template),
     @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **
      @@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
       	trailer_config_init();
       
     - 	if (!opts.only_input) {
     + 	if (!opts.only_input)
      -		parse_trailers_from_config(&configured_trailers);
      +		parse_trailer_templates_from_config(&configured_templates);
     - 	}
     - 
     - 	/*
     -@@ builtin/interpret-trailers.c: int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
       
     - 	free(cl_separators);
     + 	argc = parse_options(argc, argv, prefix, options,
     + 			     git_interpret_trailers_usage, 0);
       
     --	if (opts.only_input && !list_empty(&arg_trailers))
     +-	if (opts.only_input && !list_empty(&trailers))
      +	if (opts.only_input && !list_empty(&templates))
       		usage_msg_opt(
       			_("--trailer with --only-input does not make sense"),
       			git_interpret_trailers_usage,
       			options);
       
     --	list_splice(&configured_trailers, &arg_trailers);
     +-	list_splice(&configured_trailers, &trailers);
      +	list_splice(&configured_templates, &templates);
       
       	if (argc) {
       		int i;
       		for (i = 0; i < argc; i++)
     --			interpret_trailers(&opts, &arg_trailers, argv[i]);
     +-			interpret_trailers(&opts, &trailers, argv[i]);
      +			interpret_trailers(&opts, &templates, argv[i]);
       	} else {
       		if (opts.in_place)
       			die(_("no input file given for in-place editing"));
     --		interpret_trailers(&opts, &arg_trailers, NULL);
     +-		interpret_trailers(&opts, &trailers, NULL);
      +		interpret_trailers(&opts, &templates, NULL);
       	}
       
     --	free_new_trailers(&arg_trailers);
     +-	free_new_trailers(&trailers);
      +	free_trailer_templates(&templates);
       
       	return 0;
     @@ trailer.c: static char *apply_command(struct trailer_conf *conf, const char *arg
       	}
       }
       
     -@@ trailer.c: void duplicate_trailer_conf(struct trailer_conf *dst,
     - 	dst->cmd = xstrdup_or_null(src->cmd);
     +@@ trailer.c: void free_trailer_conf(struct trailer_conf *conf)
     + 	free(conf);
       }
       
      -static struct arg_item *get_conf_item(const char *name)
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
       	return new_item;
       }
       
     --void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     --			  struct list_head *arg_head)
     +-void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     +-			  const struct trailer_conf *conf)
      +void add_trailer_template(char *tok, char *val, const struct trailer_conf *conf,
      +			  struct list_head *templates)
       {
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
      -	list_for_each(pos, &conf_head) {
      -		item = list_entry(pos, struct arg_item, list);
      -		if (item->conf.command)
     --			trailer_add_arg_item(xstrdup(token_from_item(item, NULL)),
     +-			trailer_add_arg_item(config_head,
     +-					     xstrdup(token_from_item(item, NULL)),
      -					     xstrdup(""),
     --					     &item->conf,
     --					     config_head);
     +-					     &item->conf);
      +	/*
      +	 * Get configured templates with a ".command" option.
      +	 *
     @@ trailer.c: static struct trailer_item *add_trailer_item(struct list_head *head,
       	}
       }
       
     -@@ trailer.c: static size_t find_trailer_block_start(const char *buf, size_t len)
     - 	 * Get the start of the trailers by looking starting from the end for a
     - 	 * blank line before a set of non-blank lines that (i) are all
     - 	 * trailers, or (ii) contains at least one Git-generated trailer and
     --	 * consists of at least 25% trailers.
     -+	 * consists of at least 25% configured trailers.
     - 	 */
     - 	for (l = last_line(buf, len);
     - 	     l >= end_of_title;
      @@ trailer.c: static size_t find_trailer_block_start(const char *buf, size_t len)
       			possible_continuation_lines = 0;
       			if (recognized_prefix)
     @@ trailer.c: void free_trailers(struct list_head *trailers)
       
      
       ## trailer.h ##
     -@@ trailer.h: void duplicate_trailer_conf(struct trailer_conf *dst,
     - 
     +@@ trailer.h: struct trailer_conf *new_trailer_conf(void);
     + void duplicate_trailer_conf(struct trailer_conf *dst,
     + 			    const struct trailer_conf *src);
       const char *trailer_default_separators(void);
     - 
     --void trailer_add_arg_item(char *tok, char *val, const struct trailer_conf *conf,
     --			  struct list_head *arg_head);
     -+void add_trailer_template(char *tok, char *val, const struct trailer_conf *conf,
     +-void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
     +-			  const struct trailer_conf *conf);
     ++void add_trailer_template(char *tok, char *val, const struct trailer_conf *,
      +			  struct list_head *templates);
       
       struct process_trailer_options {
     @@ trailer.h: struct process_trailer_options {
       
      -void process_trailers_lists(struct list_head *head,
      -			    struct list_head *arg_head);
     -+void apply_trailer_templates(struct list_head *templates, struct list_head *trailers_head);
     ++void apply_trailer_templates(struct list_head *templates,
     ++			     struct list_head *trailers_head);
       
       ssize_t find_separator(const char *line, const char *separators);
       
     -@@ trailer.h: void format_trailers(const struct process_trailer_options *opts,
     +@@ trailer.h: void format_trailers(const struct process_trailer_options *,
       		     struct list_head *trailers,
       		     struct strbuf *out);
       void free_trailers(struct list_head *);
      -void free_new_trailers(struct list_head *);
     + void free_trailer_conf(struct trailer_conf *);
      +void free_trailer_templates(struct list_head *);
       
       /*

-- 
gitgitgadget
