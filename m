Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DA33EC
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132888; cv=none; b=Eh8b+EsoEq+rzlFUC0yqPEeUMU87peKx48p649F0F0xdjpf5fOvqwOVzpQ+UUhlDijhszYEbIkHs7dOUm4/FcXKs8dY+a3gMh1MESfyqXYZ9kIfzy16SnIlIyEnXkuvCT69btYnak+8Uc9hbOC7rStHSptePzt0fhnqcIgEA2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132888; c=relaxed/simple;
	bh=kdZQf9nfkLdUj02N6UNQHgIyoVIpwvxLcLi8T3eDHng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itdwwm47koAfJCurlPEY+ok8PqellfX3V28eCsDaGC3ze1pqLGWsoE1kWVPLytbs21WKaUu3jNoIly4Whn3dpDkqBXj/AlrZLjtxkE1+TVEpvFPkM9WsaUpYAC7h7aTtsHv6p29HsfMGqDkb+iAdM+C3dn1CmB+w3SuPCrcwFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGFEWle4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGFEWle4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so780005e9.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758132884; x=1758737684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J32ivZA5xup+d/5HIIFMLDDdhlMTbf0zM1vtyJ7aa8=;
        b=gGFEWle4+icYG9Z6m7pZQAsuD8tMEqWglbO3tfasZC27gH5rpOIWLL8mGU6q2OBaI1
         xBjn++cXWpmYh2bo6+HmZvkMBi+bob1g13g7dY2xTFWWliTfEHCIS0MVGVsN14oUuAOc
         UNtDhSWANtb9v+tX6scqGgYvqy2QU846pt+5J8OQVuIYVldfu1+NpzrBtArMfOrOgbmU
         Bwvp04Kb+ITs/PY2dkVYhGFzXCWy6ExkIyORLH6CG6rWMP6hK+VVQiFEFs3c7KjLL2PV
         wO6PFD01uufHB/S0xpWtAj5GhTz6ZQqjGnHfZ5WbhPPrRnmoyT1nI92fkiU7gEKbLSC4
         aUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132884; x=1758737684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J32ivZA5xup+d/5HIIFMLDDdhlMTbf0zM1vtyJ7aa8=;
        b=ULDU/S7tBY5PRLaKOUKmvD/6sQjMNeDeiWmrg8fPUlKQofftbO5EdGo9DlwSOPA1lh
         IPICGCHDvhKua7ZDlzGhrupk6u2DI9tuGu/TvVyJEOQZoC+J4ePDPEavjoq80/pxdULQ
         t82ciD1dkl6fj4Z41WVFTUJ+aItKanrVY0MV2lAQFRJTPAJQ2fYPpUN/56ZZ4z+43iCn
         G+95nW3gILm8jG6GMJC4wCq3GZRqU+gTlvWIPAuxZ0gYF/eBhAM+hCNVjQwzs9yl+pPL
         w+lSLIvD5mHJe+3WXmelrg6PgUtZe6wYNgcMRc5PA0tD5CIuph5ICTN2i1MaLXdSUinL
         poFw==
X-Gm-Message-State: AOJu0Yzm3EKjMXA1Ah0B6Uc17og6wzx5XgXu3lhPSMNzn9SYpgL7TxhO
	/taMH1BXXTcOinhysGmKadoJ0Yhw3Zd5rh4xxSi20lIkHPR/A7TXsznl2mg9cw==
X-Gm-Gg: ASbGncuRHky6XVcIyUjvZ8T+pX5R/gX4KeIWPFlWt9F1TvY/WUZ1QPG02ieL7BZLgZ3
	5rtcSezvb/ZtK0+sVt8Q7FXs2RjybrjZMrtLATyhKlyVfjwrsxG44KBGtrOjYcpaiHMejbkfMe3
	nRXOhsqOWP0CVQQWohK0iJgYbz0jMdLLm4LjnL98euZNmYyR6H0Sxsx3jV03awr5MR0GirFNpSB
	pqnM/pb9IerL0CS1yDTVdzW8ddyJaUG164VNParaBLe3kJU/ywr82zZmHUOgimk3TYhiqg5+nef
	N+6PUH1wu3YodVaNlyf3wja5HmsdyCEbsjilNjK7ardmgTuoEr5pDfGBq862tupAMviXcfvKpH8
	XSZ6xt4boZQPcx4Gr1J8F03Tusc5YKX6syeYl+3WgHJoI/z1RcS/j2MwwaQ7IU9RBQryCBdD3Ja
	HIWqeI+JnJQ4DhlfA=
X-Google-Smtp-Source: AGHT+IEByOFvw1Esm4sEvRBavoyzWWXJ6QbbNEVphYm4BIHDMRTajd14yHYR1Y+Esokzyq8HNF7nDA==
X-Received: by 2002:a05:600c:474d:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-46202a0e6dfmr30274035e9.12.1758132883646;
        Wed, 17 Sep 2025 11:14:43 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm6956915e9.0.2025.09.17.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:14:43 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/2] fast-import: start controlling how commit signatures are handled
Date: Wed, 17 Sep 2025 20:14:25 +0200
Message-ID: <20250917181427.3193500-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.195.ge34f015aea.dirty
In-Reply-To: <20250912124042.2523683-1-christian.couder@gmail.com>
References: <20250912124042.2523683-1-christian.couder@gmail.com>
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

Changes since v2:
=================

Thanks to Junio and Patrick for reviewing previous versions.

In patch 2/2:

  - The commit message has been improved to explain why new functions
    are added and how the 'strip' and 'warn-strip' modes are handled.

  - The code responsible for consuming a signature has been refactored
    into two new functions: import_one_signature() and
    discard_one_signature() functions. This makes it easier to follow
    the logic and add new modes in the future.

  - The SIGN_ABORT case is not handled separately from the other cases
    anymore.

  - Code comments have been added to the
    `switch (signed_commit_mode) { ... }` that handles the different
    cases, and a `default: ...` case that calls BUG() has been added
    to it.

CI tests:
=========

They have all passed. See:

https://github.com/chriscool/git/actions/runs/17804251337

Range-diff vs V2:
=================

1:  87149ae92d = 1:  87149ae92d gpg-interface: refactor 'enum sign_mode' parsing
2:  e34f015aea ! 2:  cf6ce66e1d fast-import: add '--signed-commits=<mode>' option
    @@ Commit message
         For now the supported <mode>s are the same as those supported by
         `git fast-export`.
     
    +    The code responsible for consuming a signature is refactored into
    +    the import_one_signature() and discard_one_signature() functions,
    +    which makes it easier to follow the logic and add new modes in the
    +    future.
    +
    +    In the 'strip' and 'warn-strip' modes, we deliberately use
    +    discard_one_signature() to discard the signature without parsing it.
    +    This ensures that even malformed signatures, which would cause the
    +    parser to fail, can be successfully stripped from a commit.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-fast-import.adoc ##
    @@ builtin/fast-import.c: static int global_argc;
      /* Memory pools */
      static struct mem_pool fi_mem_pool = {
      	.block_alloc = 2*1024*1024 - sizeof(struct mp_block),
    +@@ builtin/fast-import.c: static void parse_one_signature(struct signature_data *sig, const char *v)
    + 	parse_data(&sig->data, 0, NULL);
    + }
    + 
    ++static void discard_one_signature(void)
    ++{
    ++	struct strbuf data = STRBUF_INIT;
    ++
    ++	read_next_command();
    ++	parse_data(&data, 0, NULL);
    ++	strbuf_release(&data);
    ++}
    ++
    + static void add_gpgsig_to_commit(struct strbuf *commit_data,
    + 				 const char *header,
    + 				 struct signature_data *sig)
    +@@ builtin/fast-import.c: static void store_signature(struct signature_data *stored_sig,
    + 	}
    + }
    + 
    ++static void import_one_signature(struct signature_data *sig_sha1,
    ++				 struct signature_data *sig_sha256,
    ++				 const char *v)
    ++{
    ++	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    ++
    ++	parse_one_signature(&sig, v);
    ++
    ++	if (!strcmp(sig.hash_algo, "sha1"))
    ++		store_signature(sig_sha1, &sig, "SHA-1");
    ++	else if (!strcmp(sig.hash_algo, "sha256"))
    ++		store_signature(sig_sha256, &sig, "SHA-256");
    ++	else
    ++		die(_("parse_one_signature() returned unknown hash algo"));
    ++}
    ++
    + static void parse_new_commit(const char *arg)
    + {
    + 	static struct strbuf msg = STRBUF_INIT;
     @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
      	if (!committer)
      		die("Expected committer but didn't get one");
      
     -	/* Process signatures (up to 2: one "sha1" and one "sha256") */
      	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
    - 		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    - 
    +-		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
    +-
     -		parse_one_signature(&sig, v);
    -+		if (signed_commit_mode == SIGN_ABORT)
    -+			die(_("encountered signed commit; use "
    -+			      "--signed-commits=<mode> to handle it"));
    ++		switch (signed_commit_mode) {
    ++
    ++		/* First, modes that don't need the signature to be parsed */
    ++		case SIGN_ABORT:
    ++			die("encountered signed commit; use "
    ++			    "--signed-commits=<mode> to handle it");
    ++		case SIGN_WARN_STRIP:
    ++			warning(_("stripping a commit signature"));
    ++			/* fallthru */
    ++		case SIGN_STRIP:
    ++			discard_one_signature();
    ++			break;
      
     -		if (!strcmp(sig.hash_algo, "sha1"))
     -			store_signature(&sig_sha1, &sig, "SHA-1");
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
     -			store_signature(&sig_sha256, &sig, "SHA-256");
     -		else
     -			BUG("parse_one_signature() returned unknown hash algo");
    -+		parse_one_signature(&sig, v);
    - 
    -+		switch (signed_commit_mode) {
    -+		case SIGN_ABORT:
    -+			BUG("SIGN_ABORT should be handled before calling parse_one_signature()");
    -+			break;
    ++		/* Second, modes that parse the signature */
     +		case SIGN_WARN_VERBATIM:
     +			warning(_("importing a commit signature verbatim"));
     +			/* fallthru */
     +		case SIGN_VERBATIM:
    -+			if (!strcmp(sig.hash_algo, "sha1"))
    -+				store_signature(&sig_sha1, &sig, "SHA-1");
    -+			else if (!strcmp(sig.hash_algo, "sha256"))
    -+				store_signature(&sig_sha256, &sig, "SHA-256");
    -+			else
    -+				die(_("parse_one_signature() returned unknown hash algo"));
    -+			break;
    -+		case SIGN_WARN_STRIP:
    -+			warning(_("stripping a commit signature"));
    -+			/* fallthru */
    -+		case SIGN_STRIP:
    -+			/* Just discard signature data */
    -+			strbuf_release(&sig.data);
    -+			free(sig.hash_algo);
    ++			import_one_signature(&sig_sha1, &sig_sha256, v);
     +			break;
    + 
    ++		/* Third, BUG */
    ++		default:
    ++			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
     +		}
      		read_next_command();
      	}


Christian Couder (2):
  gpg-interface: refactor 'enum sign_mode' parsing
  fast-import: add '--signed-commits=<mode>' option

 Documentation/git-fast-import.adoc |   5 ++
 builtin/fast-export.c              |  19 ++----
 builtin/fast-import.c              |  63 ++++++++++++++---
 gpg-interface.c                    |  17 +++++
 gpg-interface.h                    |  15 ++++
 t/meson.build                      |   1 +
 t/t9305-fast-import-signatures.sh  | 106 +++++++++++++++++++++++++++++
 7 files changed, 202 insertions(+), 24 deletions(-)
 create mode 100755 t/t9305-fast-import-signatures.sh

-- 
2.51.0.195.ge34f015aea.dirty

