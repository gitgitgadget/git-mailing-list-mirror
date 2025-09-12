Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916F2EC0B9
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680863; cv=none; b=axfSc5yY2WCRmvrssM4cRMjhOzWB5qfQFp5kJ1ogH7TlrrmDVL5DmZNLT2UKaKS/y83iNe2mCWMsKkQP/7UcFNG6YL2Auuj+et5sjeY01MbJBu4qZfl231GTUEQJJKMt0ohcj/uCCtcaT5OSSDV5uvVNIwcjPwgOj460uxWhNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680863; c=relaxed/simple;
	bh=KCQHCUD/wJgZAIlGHSrwvQoAu3OsqRDBkZnVBmmzpl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTo+dgqUh1a+nsTjM+rbc6liGVStDD0BCHVIg//PjFn/UDh+9ud3edwWq/G5BTkbrVia2PkVjmh/uDyO3jDZCkNNcQFJzWHNmZt5pT+Sws7mkTXM+2BWZr0VnygwQsOIvuf5EVCFrYU0hmsqkKHZxxxS9M6YKZpfE7TPCgys80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv0IpUvL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv0IpUvL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso18469125e9.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680859; x=1758285659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dT7c9AQLVsT1dCklTNqX2pYkWgQivA5cAsfO7h2u+wk=;
        b=Gv0IpUvLz8tIIEc4AFEC3QQuggIT2h/385zfyf6A4nFUUOmlzJx203y0K8+ysFkcJ7
         U2ZZykxkq5S51XNATVBLZYvbDfsGS+2PWRxxTHR4n4+bzkYmz+w/+oYcPkFAYULCsHtQ
         4EsS+dZ5/RpyxrKHNfWB3B48uMYouZb9S1pheCuRrypFMG0+vTHKDBaZT+0YvYt/aKPo
         AeMu634D5nrl9VxYkieLehjkpH/Yvmdj5aFn60AnL04jclT6mc5IRUOY6vMWYPg+MWdm
         Hr6CQJ+fKa8D7A/z7uVxituUfEzeOTx+Ir7G8kwsUbBWEKubR0aue8HFW9Xn/lukTKpA
         F2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680859; x=1758285659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT7c9AQLVsT1dCklTNqX2pYkWgQivA5cAsfO7h2u+wk=;
        b=BgOWgOjnf3OzKHrzwoh55TDoFunHvc+b7wYx9+avyfg0QVUVo2r/9F4Brqxq9yB7Yd
         3RY/Zx4+YhJLo5pZBEkCCH0CN7BFV0WWQwDeTpw6hP8c68BzwVyv1RpveejnkOz10WVG
         hFEVxT/95QE9sHH7obLrXGeNyrzBG29RJdll3xTzzEfhnkNezD2fobXT6ip/UJgDAW7S
         X3rmLM2nVkZFueQPsbY3St/kGm2hGpbLs1HJ2LufzyJuReB8FlFzkLYcJLeDCoGqTRwE
         4DLaSAhG4nuLV30dOoGM5WYdZKLrIsLocFnRNjN3fC8RlOrpbd89sH89GEWDv4l5eKdz
         LXcQ==
X-Gm-Message-State: AOJu0YzhY0hCpMNenObGyz4WnWpSPcsCbhROUMGEP8Oq7bjBLkRDGwaX
	4c/RybU82HSGYKGdrkfZpnaCnYimVxjIj2yGzxiHkQPWFFByPTgchqHs4PQTCQ==
X-Gm-Gg: ASbGnctPXV5TtmjF/7ohKu0WCcRyB3X9qn4yoOCx0ow8Oun2n0ZQVelFaP6Ap8u7FVO
	MevxSU4Oni17yqgthSqFX7G55+DymZluntYz89xEyMIG2p/OWH0bQnGcMRu6tZNLL94Sb9OBlrM
	lREEkIuxOSOm5BgjJbxKdsqtNKtYYqb2Iw40v4FQmPPjqDaQlag8FEM9tMPeBijIXncGoheci3V
	aOLHsrsAyM17UnK83uTLXbzKjfGj0Ed1GpdRAwx9UebKXGH1escO1B7TDZzn4eVWktYmZ+HEfAv
	wcGGbHUqog9cfhVmcvfV8N1HZNjmUE31cmSVdOqzvLbCB1QHinBOKsmhYTwzvN68llvIUFmMiQF
	5qqvwcQpNHQXhfkIqrX3FUuV+FGDrTDIKKiugmuCvN6mOiZXzRwYA463s421fwv2IcLoS7Upsp5
	gKTq0/GJrEWR/RTjo=
X-Google-Smtp-Source: AGHT+IHv/ZNWh4bt6UWitDfDYBaADm1+pMuze+jrJLyK3vR3wGcnHQWut1odwe3ESQwMmKx7FcAPvQ==
X-Received: by 2002:a05:6000:22c5:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-3e7659f3385mr2138048f8f.18.1757680858551;
        Fri, 12 Sep 2025 05:40:58 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7ff9sm6374075f8f.51.2025.09.12.05.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:40:57 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/2] fast-import: start controlling how commit signatures are handled
Date: Fri, 12 Sep 2025 14:40:40 +0200
Message-ID: <20250912124042.2523683-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.gf8f8f06677
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tools like `git-filter-repo` should be able to control how commit
signatures are handled when regenerating repository content after it
has been filtered (see
https://github.com/newren/git-filter-repo/issues/139). For this
purpose, they need a way for `git fast-import` to control how commit
signatures are handled.

This small patch series starts to implement such a way by adding a new
`--signed-commits=<mode>` option to `git fast-import`.

For now this new option behaves in a very similar way as the option
with the same name that already exists in `git fast-export`.
Especially it supports exactly the same <mode>s and the same aliases
for these modes. For example "ignore" is a synonym for "verbatim".

In the future I want to implement new <mode>s like "strip-if-invalid",
"re-sign", "re-sign-if-invalid" that might be a bit more complex for
this option. But for now I prefer to start with the simple modes to
validate the general design of the new option.

In the future I also plan to add a similar `--signed-tags=<mode>` so
that the import of tags can also be controlled. But I prefer to
validate the general design of a single new option first.

In particular, I am interested in feedback about the following:

  - Should we keep "ignore" as a synonym for "verbatim" and "warn" as
    a synonym for "warn-verbatim"? My opinion is that they might be
    confusing, so we might want to remove them for `git fast-import`
    even if we keep them for `git fast-export`. The parsing code might
    be a bit more complex if we do that though, so for now I have kept
    the synonyms.

  - Are we still fine with most <mode>s having a "warn-*" variant
    (like the "warn-strip" variant of "strip" for example)? Or should
    we have a separate `--verbose` or maybe `--signed-commits-verbose`
    option dedicated to switching warnings on/off? I think it's good
    to decide about this before the number of <mode>s increases a lot
    with new <mode>s like "strip-if-invalid", "re-sign",
    "re-sign-if-invalid" and possibly others.

Changes since v1:
=================

Thanks to Junio and Patrick for reviewing V1.

In patch 1/2:

  - the commit message now says that a single option will be added in
    the following commit

  - instead of returning success in the `!parse_sign_mode(arg, val)`
    case, we return error in the `parse_sign_mode(arg, val)` case,

  - a '.' has been added at the end of a code comment.

In patch 2/2:

  - the import_signature() function has been removed and we just call
    parse_one_signature() in all cases except `SIGN_ABORT`, before
    handling the signature according to `signed_commit_mode`,

  - we now mark for translation all new strings that could be
    displayed to users,

  - usagef() is used instead of die() when the mode is unknown,

  - the warning for `warn-verbatim` has been improved,

  - the tests have been improved by using more idiomatic and
    simplified commands

CI tests:
=========

They have all passed. See:

https://github.com/chriscool/git/actions/runs/17672015528

range-diff vs V1:
=================

1:  7c8216a701 ! 1:  87149ae92d gpg-interface: refactor 'enum sign_mode' parsing
    @@ Commit message
         only command with '--signed-tags=<mode>' or '--signed-commits=<mode>'
         options.
     
    -    In a following commit, we are going to add such options to `git
    +    In a following commit, we are going to add a similar option to `git
         fast-import`, which will be simpler, easier and cleaner if we can reuse
         the 'enum sign_mode' defintion and parsing code.
     
    @@ builtin/fast-export.c: static struct hashmap anonymized_seeds;
     -	else if (!strcmp(arg, "strip"))
     -		*val = SIGN_STRIP;
     -	else
    --		return error("Unknown %s mode: %s", opt->long_name, arg);
    --	return 0;
     +
    -+	if (!parse_sign_mode(arg, val))
    -+		return 0;
    ++	if (parse_sign_mode(arg, val))
    + 		return error("Unknown %s mode: %s", opt->long_name, arg);
     +
    -+	return error("Unknown %s mode: %s", opt->long_name, arg);
    + 	return 0;
      }
      
    - static int parse_opt_tag_of_filtered_mode(const struct option *opt,
     
      ## gpg-interface.c ##
     @@ gpg-interface.c: static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
    @@ gpg-interface.h: int check_signature(struct signature_check *sigc,
      void print_signature_buffer(const struct signature_check *sigc,
      			    unsigned flags);
      
    -+/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options */
    ++/* Modes for --signed-tags=<mode> and --signed-commits=<mode> options. */
     +enum sign_mode {
     +	SIGN_ABORT,
     +	SIGN_WARN_VERBATIM,
2:  0294f05ae6 ! 2:  e34f015aea fast-import: add '--signed-commits=<mode>' option
    @@ builtin/fast-import.c: static int global_argc;
      /* Memory pools */
      static struct mem_pool fi_mem_pool = {
      	.block_alloc = 2*1024*1024 - sizeof(struct mp_block),
    -@@ builtin/fast-import.c: static void store_signature(struct signature_data *stored_sig,
    - 	}
    - }
    - 
    -+/* Process signatures (up to 2: one "sha1" and one "sha256") */
    -+static void import_signature(struct signature_data *sig_sha1,
    -+			     struct signature_data *sig_sha256,
    -+			     const char *v)
    -+{
    -+	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    -+
    -+	parse_one_signature(&sig, v);
    -+
    -+	if (!strcmp(sig.hash_algo, "sha1"))
    -+		store_signature(sig_sha1, &sig, "SHA-1");
    -+	else if (!strcmp(sig.hash_algo, "sha256"))
    -+		store_signature(sig_sha256, &sig, "SHA-256");
    -+	else
    -+		BUG("parse_one_signature() returned unknown hash algo");
    -+}
    -+
    - static void parse_new_commit(const char *arg)
    - {
    - 	static struct strbuf msg = STRBUF_INIT;
     @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      	if (!committer)
      		die("Expected committer but didn't get one");
      
     -	/* Process signatures (up to 2: one "sha1" and one "sha256") */
      	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
    --		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    --
    + 		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    + 
     -		parse_one_signature(&sig, v);
    --
    ++		if (signed_commit_mode == SIGN_ABORT)
    ++			die(_("encountered signed commit; use "
    ++			      "--signed-commits=<mode> to handle it"));
    + 
     -		if (!strcmp(sig.hash_algo, "sha1"))
     -			store_signature(&sig_sha1, &sig, "SHA-1");
     -		else if (!strcmp(sig.hash_algo, "sha256"))
     -			store_signature(&sig_sha256, &sig, "SHA-256");
     -		else
     -			BUG("parse_one_signature() returned unknown hash algo");
    --
    -+		struct strbuf data = STRBUF_INIT;
    ++		parse_one_signature(&sig, v);
    + 
     +		switch (signed_commit_mode) {
     +		case SIGN_ABORT:
    -+			die("encountered signed commit; use "
    -+			    "--signed-commits=<mode> to handle it");
    ++			BUG("SIGN_ABORT should be handled before calling parse_one_signature()");
    ++			break;
     +		case SIGN_WARN_VERBATIM:
    -+			warning("importing a commit signature");
    ++			warning(_("importing a commit signature verbatim"));
     +			/* fallthru */
     +		case SIGN_VERBATIM:
    -+			import_signature(&sig_sha1, &sig_sha256, v);
    ++			if (!strcmp(sig.hash_algo, "sha1"))
    ++				store_signature(&sig_sha1, &sig, "SHA-1");
    ++			else if (!strcmp(sig.hash_algo, "sha256"))
    ++				store_signature(&sig_sha256, &sig, "SHA-256");
    ++			else
    ++				die(_("parse_one_signature() returned unknown hash algo"));
     +			break;
     +		case SIGN_WARN_STRIP:
    -+			warning("stripping a commit signature");
    ++			warning(_("stripping a commit signature"));
     +			/* fallthru */
     +		case SIGN_STRIP:
    -+			/* Read signature data and discard it */
    -+			read_next_command();
    -+			parse_data(&data, 0, NULL);
    -+			strbuf_release(&data);
    ++			/* Just discard signature data */
    ++			strbuf_release(&sig.data);
    ++			free(sig.hash_algo);
     +			break;
     +		}
      		read_next_command();
    @@ builtin/fast-import.c: static int parse_one_option(const char *option)
      		option_export_pack_edges(option);
     +	} else if (skip_prefix(option, "signed-commits=", &option)) {
     +		if (parse_sign_mode(option, &signed_commit_mode))
    -+			die("unknown --signed-commits mode '%s'", option);
    ++			usagef(_("unknown --signed-commits mode '%s'"), option);
      	} else if (!strcmp(option, "quiet")) {
      		show_stats = 0;
      		quiet = 1;
    @@ t/t9305-fast-import-signatures.sh (new)
     +test_description='git fast-import --signed-commits=<mode>'
     +
     +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +
     +. ./test-lib.sh
     +. "$TEST_DIRECTORY/lib-gpg.sh"
     +
     +test_expect_success 'set up unsigned initial commit and import repo' '
     +	test_commit first &&
    -+	mkdir new &&
    -+	git --git-dir=new/.git init
    ++	git init new
     +'
     +
     +test_expect_success GPG 'set up OpenPGP signed commit' '
    @@ t/t9305-fast-import-signatures.sh (new)
     +	SHA1_B=$(git -C explicit-sha256 rev-parse --output-object-format=sha1 dual-signed) &&
     +
     +	# Check that the resulting SHA-1 commit has both signatures
    -+	echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&
    ++	git -C explicit-sha256 cat-file -p $SHA1_B >out &&
     +	test_grep -E "^gpgsig " out &&
     +	test_grep -E "^gpgsig-sha256 " out
     +'


Christian Couder (2):
  gpg-interface: refactor 'enum sign_mode' parsing
  fast-import: add '--signed-commits=<mode>' option

 Documentation/git-fast-import.adoc |   5 ++
 builtin/fast-export.c              |  19 ++----
 builtin/fast-import.c              |  41 ++++++++---
 gpg-interface.c                    |  17 +++++
 gpg-interface.h                    |  15 ++++
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 106 +++++++++++++++++++++++++++++
 7 files changed, 182 insertions(+), 22 deletions(-)
 create mode 100755 t/t9305-fast-import-signatures.sh

-- 
2.51.0.195.gf8f8f06677

