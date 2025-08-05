Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC611712
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754371875; cv=none; b=PgjweUoiYLsj0rLKK+xIzAzyi29VRzX/ZSNE8vryNpVmcsEgKNvedL+7v69t0AeNP2z8DeA/UGZOmuDTiux9+x2zTnZ2u5nSqfAQfOT0a1b2dKDFzavsfw3/TzqD40tVnis8uK/VIL8xtiE+1iSUVSDa8Z8+AWuQedOKocE6DOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754371875; c=relaxed/simple;
	bh=6Htpjik1LoEUw06OlFzp79C+1V2zEzuVH3kxmlClMLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UON6TKCUI4fME8qN/0P9E5ki4OnlZkHWJdOMW4CQcHBsJEVhFn9KpeLRoeiIzBP5RnBwbsJfOg6E+SDLm+TqzI53YpCW/j9XLwsUM5VW9c/kpgBOBNS/4D1B4B2S/T71cFX5rdIPfuR8ZTH11JmBgR46cWrh87WkFrCFhxZs0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1ZwcKj7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1ZwcKj7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bf9b25cbbso76361b3a.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754371873; x=1754976673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHdBm/WmbVf8wQmZzwGFvb4rTwBScRpLxjmDBI66/Ik=;
        b=T1ZwcKj7Xnu2YVimqKz5a/T0FEB8sJUUypuzLx/E/AglTy6QZPKP6eoPWlL+/zplwN
         KQ4XDzwr1Y4Nsntt3sK3JarHNnrH4RHqdNYcZoRG5sDzI4vYhOtdpVsxrf8Pf3qqKbpt
         U93ECnW2BjjqivU5HBw7bOgYxn4vfv1v4PYYPQUwmsA4timB9gmBEYeo74zGYfbJYoR2
         qid+o3Tdeo3ekG+ERM6eehXHOhDzqk6096/aBTt1WcjLL4hy7V1m6RI7UzHsVz1k0Cib
         RtrrWDQ84Q6DHU5lS+NSSuUCXbbMV8jo94LNHaC54PAsKj+4lpw9qIa5Ux6Q7+mPCVXA
         BVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754371873; x=1754976673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHdBm/WmbVf8wQmZzwGFvb4rTwBScRpLxjmDBI66/Ik=;
        b=KFx0l7OlaTN0n7+lJcawJjtihKA+KkRoQT+I0+54gWR7PdOVlTDJbt75qDhgUUW+sa
         3RJDIs3Q8fDUprlUmjJyrH751WlSidZdUzOSA0KLSkQdAVQsE3iHSHAT8AVr/BC4dGJg
         GSoSAQ200zbjhEnE5XVzdmhxc78Wio2Chth6Ni5+QlHdX//6e048KnOQJsz7T/hdg5G0
         /MSGe7Rb1wfHzI1oISWzdIMUPxfFbgFZkjs9bZaMQqetqerGW6qMS4dgO5hvJjcqNrMt
         q5ymxiplDwA3lJRIIT1GqYdY//gDy4a23TvYWKLsDLfQwIufwZPwNQSVjMbrocujq3sQ
         25ug==
X-Gm-Message-State: AOJu0Yw4eUWuIB4CROFPJLa/n2YYGNyFa+PIpEu79/26Ppn+zvaM63UM
	Dzhle4QF2dCil51F1MbRnxUpLHqLTfsbfl6NzzGZxwvdQNylphUlHkFiW4XyNQ==
X-Gm-Gg: ASbGnctQFvGRZUyFYfUCqYaq+O/SBUzDRSWXbieyrQeoYqKpZVMlr5vSYCagBohFqNg
	WgVde7iHKai/eiEsqP+ny8XIhapgv4Hwg/4LRzmYHnNk886IQi1K4acdQEqJ1YsWkszRQhGLCbd
	Xc2xIFrD1CET1ImdS/fJ5jepD5Dr0U53p0G9/+3rL5cZV+Y66YYy2NreIDLJ2ag32AfNYpqen8a
	tq+GC0VDeZvVLxIUxKG5NpSbvombO0G7TWzpD8z9cSIybAr95qzqhsJbJ5pmofMwkCbdghJAzWN
	GMbRu+lPnO0ZZ3RVwlTlgjMgDVvUiJCvRpd72RGJLpls+M0p5OudUw1xw4S+my2Sahbf3d7WDBC
	xGaeR/r8z6N1y+NK0Vt77GoaGniXPnA==
X-Google-Smtp-Source: AGHT+IHPsiVfxRCKg15D8ulSOWdu6ECWkzMj5aPDsqrHC9B+tMBNJAGjyWMzT+l2OUxiFyuImzAjXg==
X-Received: by 2002:a05:6a00:4b52:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-76bec2f5dd1mr6225704b3a.1.1754371872843;
        Mon, 04 Aug 2025 22:31:12 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f3d6sm11976633b3a.14.2025.08.04.22.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:31:12 -0700 (PDT)
Date: Mon, 4 Aug 2025 22:31:09 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] fix -Wmaybe-uninitialized with -Og
Message-ID: <cover.1754371649.git.liu.denton@gmail.com>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>

When compiled with -Og, the build emits -Wmaybe-uninitialized. Fix
these.

Denton Liu (1):
  t/unit-tests/clar: fix -Wmaybe-uninitialized with -Og

Jeff King (1):
  remote: bail early from set_head() if missing remote name

 builtin/remote.c         | 11 +++++++----
 t/unit-tests/clar/clar.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  d03308e947 ! 1:  458ec588b7 fix -Wmaybe-uninitialized with -Og
    @@
      ## Metadata ##
    -Author: Denton Liu <liu.denton@gmail.com>
    +Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    fix -Wmaybe-uninitialized with -Og
    +    remote: bail early from set_head() if missing remote name
     
    -    When building with -Og on gcc 15.1.1, the build produces two warnings.
    -    Even though in practice, these codepaths can't actually be hit while the
    -    variables are uninitialized, satisfy the compiler by initializing the
    -    variables.
    +    In "git remote set-head", we can take varying numbers of arguments
    +    depending on whether we saw the "-d" or "-a" options. But the first
    +    argument is always the remote name.
     
    -    This also acts as defensive programming since these codepaths are a
    -    little bit spaghetti. If someone in the future makes a mistake and
    -    causes the branch with the uninitialized variable to be hit, at least we
    -    won't experience undefined behaviour.
    +    The current code is somewhat awkward in that it conditionally handles
    +    the remote name up-front like this:
    +
    +      if (argc)
    +         remote = ...from argv[0]...
    +
    +    and then only later decides to bail if we do not have the right number
    +    of arguments for the options we saw.
    +
    +    This makes it hard to figure out if "remote" is always set when it needs
    +    to be. Both for humans, but also for compilers; with -Og, gcc complains
    +    that "remote" can be accessed without being initialized (although this
    +    is not true, as we'd always die with a usage message in that case).
    +
    +    Let's instead enforce the presence of the remote argument up front,
    +    which fixes the compiler warning and is easier to understand. It does
    +    mean duplicating the code to print a usage message, but it's a single
    +    line.
    +
    +    Noticed-by: Denton Liu <liu.denton@gmail.com>
    +    Signed-off-by: Jeff King <peff@peff.net>
     
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int set_head(int argc, const char **argv, const char *prefix,
    - 		b_local_head = STRBUF_INIT;
    - 	char *head_name = NULL;
    - 	struct ref_store *refs = get_main_ref_store(the_repository);
    --	struct remote *remote;
    -+	struct remote *remote = NULL;
    - 
    - 	struct option options[] = {
    - 		OPT_BOOL('a', "auto", &opt_a,
    -
    - ## t/unit-tests/clar/clar.c ##
    -@@ t/unit-tests/clar/clar.c: static void
    - clar_run_suite(const struct clar_suite *suite, const char *filter)
    - {
    - 	const struct clar_func *test = suite->tests;
    --	size_t i, matchlen;
    -+	size_t i, matchlen = 0;
    - 	struct clar_report *report;
    - 	int exact = 0;
    + 	};
    + 	argc = parse_options(argc, argv, prefix, options,
    + 			     builtin_remote_sethead_usage, 0);
    +-	if (argc) {
    +-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
    +-		remote = remote_get(argv[0]);
    +-	}
    ++
    ++	/* All modes require at least a remote name. */
    ++	if (!argc)
    ++		usage_with_options(builtin_remote_sethead_usage, options);
    ++
    ++	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
    ++	remote = remote_get(argv[0]);
      
    + 	if (!opt_a && !opt_d && argc == 2) {
    + 		head_name = xstrdup(argv[1]);
-:  ---------- > 2:  8ed0ac1409 t/unit-tests/clar: fix -Wmaybe-uninitialized with -Og
-- 
2.50.1

