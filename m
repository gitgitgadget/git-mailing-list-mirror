Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3353644DA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849620; cv=none; b=epBX+Fb1eNZbM+I/mp5aliSTE0+2NVvWtI+QJ650qOLRuI4R2E9uOyoCZlEOm7ooEkzM8wyFAHLFYbPmzJyDdt6MHLy4KmzBcR1h7n+MRhECRqH4ljzH/1XlwxXuSlhv+R/tgpwgwOTDsiOXEy0hi8Ya08opDENlK/kl9J7aA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849620; c=relaxed/simple;
	bh=qCrUJ4JY4LZbcuE45E4ZJK0ml62AHuY5nYFfTcnuWUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jR9xUYh6x4uS4toIeaAIRfMMMvJr/OjEMIM1BPt2JPH4JEKSJ40AhAwZk+HJXUL/OgcirDLtYcEDqKqocQoo5G9hlRJN1aMWRpFlDSPVpvkb6DelO4FPuC5xekYMZXTDImiFv/5HIvviRfmfWE00FllmQBSZZZLnQClK87riJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2Hu0Cig; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Hu0Cig"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7950881727cso28913737b3.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849617; x=1772454417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QLw6jLkWUn/H+mw0VnaPy+pnEeXgKwW70LoerIQYBg=;
        b=Z2Hu0CigBfxk1pp0GB/oBffquBtd2rzlMi4wk9XK6Y4mG8HDdmOUUeSCdczLhaNY0O
         +/S+JVgBEtYFHMil8UghbZYjmBgYiiLxqe1pOI1RuI57dl7WQgvOohWhJYp4fHaY3Uhx
         hX6jIEdGc3lNvA4OuLLSWHewFe91zH0VLCsKxHI6nS8ECj512Ki68BMihtLUj3vI4qjX
         YMimylmhSElkIffuHiAKQ4hdYipc7YTmv4wlbqyf2TzbKkpzJXm9CbDOGOx2QHcGIj7v
         qQQmGh+GeBDDiFWr+e8HlFqWm+cZ5kJUFwBmXujRrTBYct0cI7UYHwsaJU+X4VLwaH6Q
         8ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849617; x=1772454417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QLw6jLkWUn/H+mw0VnaPy+pnEeXgKwW70LoerIQYBg=;
        b=RGs4+/6Bfe7YEjhmt7IM327e6bYmYppdCQUoUSPgyQYwLTEF4YhEnDgER58rgKSc4R
         O9JVuaTYIy/dW1bnbQnwQDMffKDW3DOw9ckpnVVSLkvLo+gduMr2Xu5wyGKRa29q3QU7
         yEovp9nR0qwh1jM4HQ8OIinQcmC3T9lzU/W5zlMtnzJrNXV0yAU7DXVKYJ6wNe19Vp0x
         tTvmqi8eVlkO+zs6QWGBeomdnSLZ7Mf8WNhNGrdKazvBLQxpxmXn7Q6IU401M6DDycqg
         FW1+WtJA37kzLiXAuM2XpKZSxSWGyq1QGeLJ+UcWfublGBrQaP4HnNx6A2n8ppXxk6Is
         s0hg==
X-Gm-Message-State: AOJu0Ywk0aEURhZA7eEL5d85V/7gr4XcI5QttF6C9eU7qQv19KIhLo32
	FqsDEj4INdotDIn79UIGAxk+Yv8bJkq4kcQgynALqsqDRqcY2Ep8YcDQ/uKlJg==
X-Gm-Gg: ATEYQzwjTpywoEbr4cjTanhcAnZ08bxarTbGWNNdNsRvuep+HFqtn/iFvDsDlNFzKEk
	SEJntdoMBK234alOKxUu0j2JzT1pBxgd5XSKDAA1wqR8kLeBDx3R7LkdhT5MV/La4sG0s3JfVwA
	C1XY8iq4juI0z+2th/3WH5Zgp/p/zc/gRFaQ4DgE60bv0eKuR3IIkUTdflpaYkmnGPkXT2ZGVr6
	ft5iD0+J15Imi0/ON0EO+SYiEA4U6/7WccVob05G7qCjWnt9xCuumWojH/RoB0OcQcdmKKdfS2y
	h1TezeT3pSNlH1OeAtcZG0VfkOAb2zYhX/44mk4DPgh5nBXI9oBh8teisgtUMphtrABEBLJHXhZ
	v8xZFQTjwDM9uU7epwTh2m7nGTUeUfAowdy1gmy74JcI6p8ep/QCx+tlkFsVnA+8Eza/X7I75U3
	3ya+kot9mixfafoM727C0pb0O33A==
X-Received: by 2002:a05:690c:c4f1:b0:796:8274:8c91 with SMTP id 00721157ae682-79829191b0dmr69427407b3.65.1771849616580;
        Mon, 23 Feb 2026 04:26:56 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddd5096sm30934697b3.45.2026.02.23.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:26:56 -0800 (PST)
Message-Id: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:42 +0000
Subject: [PATCH v3 00/13] Make 'git config list --type=' parse and filter types
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

I started down this road based on feedback on my 'git config-batch' RFC [1].

[1]
https://lore.kernel.org/git/pull.2033.git.1770214803.gitgitgadget@gmail.com/

I had described my intention to use 'git config-batch' as a single process
to load multiple config values one-by-one. Brian mentioned that 'git config
list -z' would probably suffice, so I started experimenting in that
direction [2].

[2]
https://github.com/git-ecosystem/git-credential-manager/compare/main...derrickstolee:config-list

However, I ran into a problem: the most critical performance bottleneck is
related to path-formatted config values that are queried with 'git config
get --type=path -z'. It wasn't hard to update things to lazily load the full
list of config values by type [3], but I then noticed a big problem!

[3]
https://github.com/git-ecosystem/git-credential-manager/commit/d403c8e24ce6f37da920cce23842dd5a6cf6481d

Problem: 'git config list' doesn't respect --type=<X>!

This boils down to the fact that the iterator function show_all_config()
doesn't call format_config(), which includes the type-parsing code.

This wasn't super trivial to update:

 1. format_config() uses git_config_parse_*() methods, which die() on a bad
    parse.
 2. The path parsing code didn't have a gentle version.
 3. The two paths ('git config list' and 'git config --list') needed to
    standardize their display options to work with format_config().
 4. Finally, we need to filter out key-value pairs that don't match the
    given type.


Updates in v2
=============

Based on the positive feedback in round one, this is no longer an RFC.

 * format_config() now uses a 'gently' parameter instead of 'die_on_parse'
   (flipped).
 * format_config() is more carefully updated with helper methods and a
   global refactor.
 * New gentle parsing code is introduced right before the format_config()
   helper is created to use it.
 * I squashed the change that updates the display_opts initial state into
   the patch that uses format_config() for the 'list' command. The initial
   state change on its own leads to test failures, so I am making a slightly
   bigger patch to keep things passing tests at every change.
 * More tests for 'git config list --type=<X>' are added.
 * I rearranged things so the 'git config list --type' integration follows
   the format_config() update immediately. The tests at that time show what
   such a trivial implementation would do, including failing on bool parsing
   and having several error messages for color and expiry-date parsing. The
   tests modify as these issues are fixed with gentle parsers.
 * I have a prototype implementation of GCM using this option in [4] and it
   gets the performance improvements I was hoping for. It requires polish
   and a compatibility check that uses the Git version to guarantee that
   this --type behavior change is recognized.

[4] https://github.com/git-ecosystem/git-credential-manager/pull/2268


Updates in V3
=============

 * Expanded the commit message of patch 3 to include reasoning for the
   filter.
 * Expanded the commit message of patch 3 to specify that tests are added
   demonstrating problematic behavior before they are fixed in later
   patches.
 * New test cases are added for ':(optional)' macros and int parsing.
 * The uses of git_parse_int64() and git_parse_int() were incorrect. These
   are fixed after being revealed by new tests.
 * The git_parse_maybe_pathname() was removed after realizing it did not
   contribute to a behavior change. Path parsing was already gentle, it just
   needed assistance with ':(optional)' macros for nonexistent paths.
 * A distinction is made between parsing 'gently' (do not die()) and
   'quietly' (do not error()). Neither cause the command to fail or emit to
   stderr, but the distinction is made by what the original parsing behavior
   did.
 * The conversion of the format_config() logic into a switch() is made more
   complete by adding a BUG() statement for the default case.
 * The options for the config type are now converted into an enum to make
   such switch() statements easier to validate as being complete.

Thanks for any and all feedback, -Stolee

Derrick Stolee (13):
  config: move show_all_config()
  config: add 'gently' parameter to format_config()
  config: make 'git config list --type=<X>' work
  config: format int64s gently
  config: format bools gently
  config: format bools or ints gently
  config: format bools or strings in helper
  config: format paths gently
  config: format expiry dates quietly
  color: add color_parse_quietly()
  config: format colors quietly
  config: restructure format_config()
  config: use an enum for type

 Documentation/git-config.adoc |   3 +
 builtin/config.c              | 306 +++++++++++++++++++++++++---------
 color.c                       |  25 ++-
 color.h                       |   1 +
 t/t1300-config.sh             |  84 +++++++++-
 5 files changed, 331 insertions(+), 88 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2044%2Fderrickstolee%2Fconfig-list-type-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2044/derrickstolee/config-list-type-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2044

Range-diff vs v2:

  1:  bca83d8ca8 =  1:  bca83d8ca8 config: move show_all_config()
  2:  93c94a1b25 =  2:  93c94a1b25 config: add 'gently' parameter to format_config()
  3:  6d2a48a3b7 !  3:  2b2a325b55 config: make 'git config list --type=<X>' work
     @@ Commit message
          be shown and also add the default delimiters as they were unset in some
          cases.
      
     -    If there is an error in parsing, then the row is not output.
     +    Our intention is that if there is an error in parsing, then the row is
     +    not output. This is necessary to avoid the caller needing to build their
     +    own validator to understand the difference between valid, canonicalized
     +    types and other raw string values. The raw values will always be
     +    available to the user if they do not specify the --type=<X> option.
     +
     +    The current behavior is more complicated, including error messages on
     +    bad parsing or potentially complete failure of the command.  We add
     +    tests at this point that demonstrate the current behavior so we can
     +    witness the fix in future changes that parse these values quietly and
     +    gently.
      
          This is a change in behavior! We are starting to respect an option that
          was previously ignored, leading to potential user confusion. This is
     @@ t/t1300-config.sh: done
      +red = red
      +blue = Blue
      +date = Fri Jun 4 15:46:55 2010
     ++missing=:(optional)no-such-path
     ++exists=:(optional)expect
       EOF
       
       test_expect_success 'identical modern --type specifiers are allowed' '
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
       	test_cmp_config 1048576 --type=bool --no-type --type=int section.big
       '
       
     ++test_expect_success 'list --type=int shows only canonicalizable int values' '
     ++	cat >expect <<-EOF &&
     ++	section.number=10
     ++	section.big=1048576
     ++	EOF
     ++
     ++	test_must_fail git config ${mode_prefix}list --type=int
     ++'
     ++
      +test_expect_success 'list --type=bool shows only canonicalizable bool values' '
      +	cat >expect <<-EOF &&
      +	section.foo=true
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	test_must_fail git config ${mode_prefix}list --type=bool
      +'
      +
     ++test_expect_success 'list --type=bool-or-int shows only canonicalizable values' '
     ++	cat >expect <<-EOF &&
     ++	section.foo=true
     ++	section.number=10
     ++	section.big=1048576
     ++	EOF
     ++
     ++	test_must_fail git config ${mode_prefix}list --type=bool-or-int
     ++'
     ++
      +test_expect_success 'list --type=path shows only canonicalizable path values' '
     ++	# TODO: handling of missing path is incorrect here.
      +	cat >expect <<-EOF &&
      +	section.foo=True
      +	section.number=10
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	section.red=red
      +	section.blue=Blue
      +	section.date=Fri Jun 4 15:46:55 2010
     ++	section.missing=section.exists=expect
      +	EOF
      +
      +	git config ${mode_prefix}list --type=path >actual 2>err &&
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
      +	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
      +	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
     ++	error: '\'':(optional)no-such-path'\'' for '\''section.missing'\'' is not a valid timestamp
     ++	error: '\'':(optional)expect'\'' for '\''section.exists'\'' is not a valid timestamp
      +	EOF
      +
      +	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	error: invalid color value: 1M
      +	error: invalid color value: ~/dir
      +	error: invalid color value: Fri Jun 4 15:46:55 2010
     ++	error: invalid color value: :(optional)no-such-path
     ++	error: invalid color value: :(optional)expect
      +	EOF
      +
      +	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
  4:  2bca4d2316 !  4:  4835ee5180 config: format int64s gently
     @@ builtin/config.c: struct strbuf_list {
      +{
      +	int64_t v = 0;
      +	if (gently) {
     -+		if (git_parse_int64(value_, &v))
     ++		if (!git_parse_int64(value_, &v))
      +			return -1;
      +	} else {
      +		/* may die() */
     @@ builtin/config.c: static int format_config(const struct config_display_options *
       }
       
       static int show_all_config(const char *key_, const char *value_,
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'list --type=int shows only canonicalizable int values' '
     + 	section.big=1048576
     + 	EOF
     + 
     +-	test_must_fail git config ${mode_prefix}list --type=int
     ++	git config ${mode_prefix}list --type=int >actual 2>err &&
     ++	test_cmp expect actual &&
     ++	test_must_be_empty err
     + '
     + 
     + test_expect_success 'list --type=bool shows only canonicalizable bool values' '
  5:  f8e0b8304f !  5:  24eb757a40 config: format bools gently
     @@ t/t1300-config.sh: test_expect_success 'list --type=bool shows only canonicaliza
      +	test_must_be_empty err
       '
       
     - test_expect_success 'list --type=path shows only canonicalizable path values' '
     + test_expect_success 'list --type=bool-or-int shows only canonicalizable values' '
  6:  0a428d2ffe !  6:  02849ca621 config: format bools or ints gently
     @@ builtin/config.c: static int format_config_bool(struct strbuf *buf,
      +
      +		if (v >= 0)
      +			is_bool = 1;
     -+		else if (git_parse_int(value_, &v))
     ++		else if (!git_parse_int(value_, &v))
      +			return -1;
      +	} else {
      +		v = git_config_bool_or_int(key_, value_, kvi,
     @@ builtin/config.c: static int format_config(const struct config_display_options *
       			int v = git_parse_maybe_bool(value_);
       			if (v < 0)
       				strbuf_addstr(buf, value_);
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'list --type=bool-or-int shows only canonicalizable values'
     + 	section.big=1048576
     + 	EOF
     + 
     +-	test_must_fail git config ${mode_prefix}list --type=bool-or-int
     ++	git config ${mode_prefix}list --type=bool-or-int >actual 2>err &&
     ++	test_cmp expect actual &&
     ++	test_must_be_empty err
     + '
     + 
     + test_expect_success 'list --type=path shows only canonicalizable path values' '
  7:  3fec3abbd6 =  7:  9f06db29b9 config: format bools or strings in helper
  8:  fafafc5465 <  -:  ---------- parse: add git_parse_maybe_pathname()
  9:  d1cfa0c5e1 !  8:  d198c238e9 config: format paths gently
     @@ Commit message
          Move the logic for formatting path config values into a helper method
          and use gentle parsing when needed.
      
     +    We need to be careful about how to handle the ':(optional)' macro, which
     +    as tested in t1311-config-optional.sh must allow for ignoring a missing
     +    path when other multiple values exist, but cause 'git config get' to
     +    fail if it is the only possible value and thus no result is output.
     +
     +    In the case of our list, we need to omit those values silently. This
     +    necessitates the use of the 'gently' parameter here.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/config.c ##
     @@ builtin/config.c: static int format_config_bool_or_str(struct strbuf *buf,
      +			      int gently)
      +{
      +	char *v;
     -+	if (gently) {
     -+		if (git_parse_maybe_pathname(value_, &v) < 0)
     -+			return -1;
     -+	} else if (git_config_pathname(&v, key_, value_) < 0) {
     ++
     ++	if (git_config_pathname(&v, key_, value_) < 0)
      +		return -1;
     -+	}
      +
      +	if (v)
      +		strbuf_addstr(buf, v);
      +	else
     -+		return 1; /* :(optional)no-such-file */
     ++		return gently ? -1 : 1; /* :(optional)no-such-file */
      +
      +	free(v);
      +	return 0;
     @@ builtin/config.c: static int format_config(const struct config_display_options *
       			timestamp_t t;
       			if (git_config_expiry_date(&t, key_, value_) < 0)
       				return -1;
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'list --type=bool-or-int shows only canonicalizable values'
     + '
     + 
     + test_expect_success 'list --type=path shows only canonicalizable path values' '
     +-	# TODO: handling of missing path is incorrect here.
     + 	cat >expect <<-EOF &&
     + 	section.foo=True
     + 	section.number=10
     +@@ t/t1300-config.sh: test_expect_success 'list --type=path shows only canonicalizable path values' '
     + 	section.red=red
     + 	section.blue=Blue
     + 	section.date=Fri Jun 4 15:46:55 2010
     +-	section.missing=section.exists=expect
     ++	section.exists=expect
     + 	EOF
     + 
     + 	git config ${mode_prefix}list --type=path >actual 2>err &&
 10:  9221ca2352 !  9:  7568a0bc34 config: format expiry dates gently
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    config: format expiry dates gently
     +    config: format expiry dates quietly
      
          Move the logic for formatting expiry date config values into a helper
     -    method and use gentle parsing when needed.
     +    method and use quiet parsing when needed.
     +
     +    Note that git_config_expiry_date() will show an error on a bad parse and
     +    not die() like most other git_config...() parsers. Thus, we use
     +    'quietly' here instead of 'gently'.
      
          There is an unfortunate asymmetry in these two parsing methods, but we
          need to treat a positive response from parse_expiry_date() as an error
     @@ builtin/config.c: static int format_config_path(struct strbuf *buf,
      +static int format_config_expiry_date(struct strbuf *buf,
      +				     const char *key_,
      +				     const char *value_,
     -+				     int gently)
     ++				     int quietly)
      +{
      +	timestamp_t t;
     -+	if (gently) {
     ++	if (quietly) {
      +		if (parse_expiry_date(value_, &t))
      +			return -1;
      +	} else if (git_config_expiry_date(&t, key_, value_) < 0) {
     @@ t/t1300-config.sh: test_expect_success 'list --type=path shows only canonicaliza
      -	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
      -	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
      -	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
     +-	error: '\'':(optional)no-such-path'\'' for '\''section.missing'\'' is not a valid timestamp
     +-	error: '\'':(optional)expect'\'' for '\''section.exists'\'' is not a valid timestamp
      -	EOF
      -
       	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
 11:  ddf6131ac9 ! 10:  d98966f53a color: add color_parse_gently()
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    color: add color_parse_gently()
     +    color: add color_parse_quietly()
      
          When parsing colors, a failed parse leads to an error message due to the
          result returning error(). To allow for quiet parsing, create
     -    color_parse_gently().
     +    color_parse_quietly(). This is in contrast to an ..._gently() version
     +    because the original does not die(), so both options are technically
     +    'gentle'.
      
          To accomplish this, convert the implementation of color_parse_mem() into
     -    a static color_parse_mem_1() helper that adds a 'gently' parameter. The
     -    color_parse_gently() method can then use this. Since it is a near
     +    a static color_parse_mem_1() helper that adds a 'quiet' parameter. The
     +    color_parse_quietly() method can then use this. Since it is a near
          equivalent to color_parse(), move that method down in the file so they
          can be nearby while also appearing after color_parse_mem_1().
      
     @@ color.c: static int color_empty(const struct color *c)
       
      -int color_parse_mem(const char *value, int value_len, char *dst)
      +static int color_parse_mem_1(const char *value, int value_len,
     -+			     char *dst, int gently)
     ++			     char *dst, int quiet)
       {
       	const char *ptr = value;
       	int len = value_len;
     @@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
       	return 0;
       bad:
      -	return error(_("invalid color value: %.*s"), value_len, value);
     -+	return gently ? -1 : error(_("invalid color value: %.*s"), value_len, value);
     ++	return quiet ? -1 : error(_("invalid color value: %.*s"), value_len, value);
       #undef OUT
       }
       
     @@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
      +	return color_parse_mem(value, strlen(value), dst);
      +}
      +
     -+int color_parse_gently(const char *value, char *dst)
     ++int color_parse_quietly(const char *value, char *dst)
      +{
      +	return color_parse_mem_1(value, strlen(value), dst, 1);
      +}
     @@ color.h: bool want_color_fd(int fd, enum git_colorbool var);
        * terminal.
        */
       int color_parse(const char *value, char *dst);
     -+int color_parse_gently(const char *value, char *dst);
     ++int color_parse_quietly(const char *value, char *dst);
       int color_parse_mem(const char *value, int len, char *dst);
       
       /*
 12:  d14937e6d1 ! 11:  078065cff0 config: format colors gently
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    config: format colors gently
     +    config: format colors quietly
      
          Move the logic for formatting color config value into a helper method
     -    and use gentle parsing when needed.
     +    and use quiet parsing when needed.
      
          This removes error messages when parsing a list of config values that do
          not match color formats.
     @@ builtin/config.c: static int format_config_expiry_date(struct strbuf *buf,
      +	char v[COLOR_MAXLEN];
      +
      +	if (gently) {
     -+		if (color_parse_gently(value_, v) < 0)
     ++		if (color_parse_quietly(value_, v) < 0)
      +			return -1;
      +	} else if (git_config_color(v, key_, value_) < 0) {
      +		return -1;
     @@ t/t1300-config.sh: test_expect_success 'list --type=color shows only canonicaliz
      -	error: invalid color value: 1M
      -	error: invalid color value: ~/dir
      -	error: invalid color value: Fri Jun 4 15:46:55 2010
     +-	error: invalid color value: :(optional)no-such-path
     +-	error: invalid color value: :(optional)expect
      -	EOF
      -
       	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
 13:  48fc882785 ! 12:  76fc7670fc config: restructure format_config()
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/config.c ##
     +@@ builtin/config.c: struct config_display_options {
     + 	.key_delim = ' ', \
     + }
     + 
     ++#define TYPE_NONE		0
     + #define TYPE_BOOL		1
     + #define TYPE_INT		2
     + #define TYPE_BOOL_OR_INT	3
      @@ builtin/config.c: static int format_config(const struct config_display_options *opts,
       		show_config_origin(opts, kvi, buf);
       	if (opts->show_keys)
     @@ builtin/config.c: static int format_config(const struct config_display_options *
      +		res = format_config_color(buf, key_, value_, gently);
      +		break;
      +
     -+	default:
     ++	case TYPE_NONE:
      +		if (value_) {
       			strbuf_addstr(buf, value_);
       		} else {
       			/* Just show the key name; back out delimiter */
     -@@ builtin/config.c: static int format_config(const struct config_display_options *opts,
     + 			if (opts->show_keys)
       				strbuf_setlen(buf, buf->len - 1);
       		}
     ++		break;
     ++
     ++	default:
     ++		BUG("undefined type %d", opts->type);
       	}
      +
      +terminator:
  -:  ---------- > 13:  3c32c037bc config: use an enum for type

-- 
gitgitgadget
