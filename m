Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611D3D3CE5
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705867; cv=none; b=MfKyioIZGbiQmG/5XB/rN6F1DgFZBocfXA+KTZ/V4LWBYKK0B53/P4ILgadhtkxMhjaEQgiC6pAcPcjC4/jfxS0mSBs3VMPC4AQVJkDqE6DjZWF4OAX8CTABfb7M99eNMsvI3VekTdOcxoTd+OFQfc7U6Ymni9acpt1xpxNSh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705867; c=relaxed/simple;
	bh=ufGLXhaP7z3T5+2Jxx0KOZtCp61w7r3TduaNG0g6NoU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=egBJuM6/HTPps+vq8COitgCFBPUYEOgVFlfGNMQYaQ1/89yA6TJJcwg8Tv65IeLJ7om//NX5INhoVMzcp7CQeGELfZPWDCzoCVDkBNp3IQPSehfY+uRNw1k2Kyymiuq3WJl9JRxy5NU7o1JHKAvxuPija3N1fAVUALeQxI3R+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFNCxwsQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFNCxwsQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e53581361so136582685a.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705863; x=1786310663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lhs6DTwAg1sVReyLqmtp/LQJpsJa6FbkJFvBiiEYUjo=;
        b=OFNCxwsQbMaT8UAepxKyNG3LthY/J4n3SM0fjTuPieGV7vzLfau/3KKof0wqWRvqpN
         Z3lTV+UsqL6A5fNB8ZbpLK5QAuMlDfgs8FRRPx3KwHZvRzwD/Cw4w4dnUXGR83K7zCsT
         IsgMvQL76tr0890ulogCPpWglS8yaTZKjgG62OhsHzwLdVU7/qAXs3nLV3CotwAPs9ax
         b6RA6Fy3xP285xcT5dDTe8fAn+55bpTezHa7LF+eORtUVoNCo+Rc/SP+Hw29NT8Kmhe7
         daxv+ksOb1gXpVh/fgyM9C2iJFv8fDUQAUyPStcdQDLT+uvCHudYxeS8WsB8NDIf9o44
         Ec5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705863; x=1786310663;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lhs6DTwAg1sVReyLqmtp/LQJpsJa6FbkJFvBiiEYUjo=;
        b=jWhiuhBY2tYaXXwlb0hbv0kRMSDeS5bm8SRBtEGxCDVsou068GAl+vU1CT8MbfLwPq
         fSHusb0XjEFsEoHY/fvb/BL/R9XfaANa398XzByDK4/dvVoLKaP1YVlBkSDXBmw86pR2
         sB6OIPX68EZokEvemscArTNP7C3nVgSVSGP7L3fx8cX1phKRVQwq/FM0jIy6K5+IiRex
         e+smZD7irOopf3k80o1D5rYYBULzye0dxdc5kvh2xbsPOgUSqvlQTRT4yD0muA+dxf0n
         eVjy4LbhkCTeOXqwKr5Q72W8JU7N3KSy1YMBGRsAwnJWk3ix/CLar2Dun1yzcpU1QPo6
         n/UQ==
X-Gm-Message-State: AOJu0Ywb7IFzNBLKc8RK8TI/p9TMtT1UXbRxbzXRCo8ErYWOiZeqm9g1
	ouBRTPR1zHssPqUK2kJxbKrFeHeAS0L5QOhcujLFP6DmG+DyoMQ/7Jx8Z/7NWw==
X-Gm-Gg: AR+sD13XhtZUaLsBfqupokmz6cbfZkpJ0QTEy3lTdW1uZY+o2FEk195alYyTD7QgeuD
	H02U7wYuMb7Jlrl8lRh4Vm+9behuy8Q39VwKhQlYpzDf7vdfeZgaq8bCvAAOGrpgKAjLppiRlv3
	y81/fg76hEUZQs/AnHmNBBIGCraYahaEHdbH5RHfnbn+Ml3VQ6PLZiPjutqMa0sUGbLWr7jpACS
	UB9w9lkVcVSu2/I9JRTVpQT8lFuZUIr6wJSn1xQESMBnrL8JiMY09+pRng1JBRZVaQj9YnyK3uh
	mCjip3XHgpWfnSfyIhZOi4dakYBRsiZqsMUsQpyQ1WqOVLiuhepARhdnfiK7OEg+4nVOgLvApqc
	hCd0Y+/YGjltPL3fdl2Mz8oa+270F5jC1TUy7f+TfdihRKZ1cFp8qcbM/a2e2PFxwDTRs+dFeAG
	HEkcBrLYqadcpEbODYi1mdaJ23WAvNMCLPW2TiAmqRnhrWHM30bb4F04S2GiPYZeM=
X-Received: by 2002:a05:620a:8010:b0:92b:4ce5:6390 with SMTP id af79cd13be357-934a0939829mr1574904885a.25.1785705863012;
        Sun, 02 Aug 2026 14:24:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6086sm60569806d6.29.2026.08.02.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:24:21 -0700 (PDT)
Message-Id: <pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 21:24:18 +0000
Subject: [PATCH v6 0/2] bisect: add --reset-when-found to leave when done
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

Add a --reset-when-found option to git bisect that resets the bisect session
when culprit is found.

Changes in v6:

 * Reuse the existing bad bisect ref instead of propagating the culprit OID
   through bisect_next_all().
 * Remove the redundant reset_when_found_arg_seen flag and use
   RESET_WHEN_FOUND_NONE to detect whether the option was given.

Changes in v5:

 * Move automatic reset handling to cmd_bisect() after subcommand resources
   are closed.
 * Propagate the first-bad commit OID from bisect_next_all() and remove
   defer_reset plumbing.
 * Separate checkout from state cleanup in bisect_reset(), and use bool for
   its quiet flag.

Changes in v4:

 * Simplify translation calls.
 * Avoid git subshell calls in tests, that can bury errors.

Changes in v3:

 * Rename --auto-reset to --reset-when-found, including internal names.
 * Defer git bisect run cleanup until captured output is printed and
   BISECT_RUN is closed. Drop the open-descriptor preparatory change,
   retaining the existing filename-based output handling.

Changes in v2:

 * Add option --auto-reset[=<where>] with option to go to final commit as
   well as original.
 * Refactored tests.

Harald Nordgren (2):
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --reset-when-found to leave when done

 Documentation/git-bisect.adoc |  14 ++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 162 +++++++++++++++++++++++++++++++---
 t/t6030-bisect-porcelain.sh   | 121 +++++++++++++++++++++++++
 4 files changed, 285 insertions(+), 14 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v6
Pull-Request: https://github.com/git/git/pull/2335

Range-diff vs v5:

 1:  b6ab87fd29 = 1:  b6ab87fd29 bisect: let bisect_reset() optionally check out quietly
 2:  ec362f3b82 ! 2:  97a4da5537 bisect: add --reset-when-found to leave when done
     @@ Commit message
          Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
          and perform the reset quietly.
      
     -    Propagate the internal first-bad result and its commit to
     -    cmd_bisect(), which performs the reset after the subcommand has
     -    returned. For "git bisect run", this means BISECT_RUN has been printed
     -    and closed before cleanup, which also works on systems that cannot
     -    unlink an open file.
     +    Let the internal first-bad result propagate to cmd_bisect(), which
     +    performs the reset using the existing bad bisect ref after the
     +    subcommand has returned. For "git bisect run", this means BISECT_RUN
     +    has been printed and closed before cleanup, which also works on systems
     +    that cannot unlink an open file.
      
          Reject this option together with "--no-checkout", since that mode must
          not check out either target.
     @@ bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       
       static void read_bisect_paths(struct strvec *array)
       {
     -@@ bisect.c: void read_bisect_terms(char **read_bad, char **read_good)
     -  * the end of bisect_helper::cmd_bisect__helper() helps bypassing
     -  * all the code related to finding a commit to test.
     -  */
     --enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
     -+enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
     -+				  struct object_id *first_bad)
     - {
     - 	struct strvec rev_argv = STRVEC_INIT;
     - 	struct rev_info revs = REV_INFO_INIT;
     -@@ bisect.c: enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
     - 		res = error_if_skipped_commits(tried, current_bad_oid);
     - 		if (res)
     - 			goto cleanup;
     -+		oidcpy(first_bad, bisect_rev);
     - 		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
     - 			term_bad);
     - 
      @@ bisect.c: int bisect_clean_state(void)
       	unlink_or_warn(git_path_bisect_run());
       	unlink_or_warn(git_path_bisect_terms());
     @@ bisect.c: int bisect_clean_state(void)
       	 * Cleanup BISECT_START last to support the --no-checkout option
       	 * introduced in the commit 4796e823a.
      
     - ## bisect.h ##
     -@@ bisect.h: struct bisect_state {
     - 	unsigned int nr_bad;
     - };
     - 
     --enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
     -+enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
     -+				  struct object_id *first_bad);
     - 
     - int estimate_bisect_steps(int all);
     - 
     -
       ## builtin/bisect.c ##
      @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
     @@ builtin/bisect.c: static const char * const git_bisect_usage[] = {
       struct add_bisect_ref_data {
       	struct rev_info *revs;
       	unsigned int object_flags;
     -@@ builtin/bisect.c: struct bisect_terms {
     - 	char *term_bad;
     - };
     - 
     -+static struct object_id first_bad_oid;
     -+
     - static void free_terms(struct bisect_terms *terms)
     - {
     - 	FREE_AND_NULL(terms->term_good);
      @@ builtin/bisect.c: static int bisect_reset(const char *commit, bool quiet)
       	}
       
     @@ builtin/bisect.c: static int bisect_reset(const char *commit, bool quiet)
      +
      +static int bisect_reset_when_found(enum reset_when_found_mode mode)
      +{
     -+	char first_bad_hex[GIT_MAX_HEXSZ + 1];
     -+	const char *commit = NULL;
     ++	struct bisect_terms terms = { 0 };
     ++	char *commit = NULL;
      +	int res;
      +
     -+	if (mode == RESET_WHEN_FOUND_TO_FOUND)
     -+		commit = oid_to_hex_r(first_bad_hex, &first_bad_oid);
     -+	else if (mode == RESET_WHEN_FOUND_NONE)
     ++	if (mode == RESET_WHEN_FOUND_TO_FOUND) {
     ++		read_bisect_terms(&terms.term_bad, &terms.term_good);
     ++		commit = xstrfmt("refs/bisect/%s", terms.term_bad);
     ++	} else if (mode == RESET_WHEN_FOUND_NONE) {
      +		BUG("automatic reset requested without a reset mode");
     ++	}
      +
      +	res = bisect_reset(commit, true);
      +	if (!res)
      +		res = bisect_clean_state();
      +
     ++	free(commit);
     ++	free_terms(&terms);
      +	return res;
       }
       
     @@ builtin/bisect.c: static int bisect_successful(struct bisect_terms *terms)
       {
       	enum bisect_error res;
       
     -@@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
     - 		return BISECT_FAILED;
     - 
     - 	/* Perform all bisection computation */
     --	res = bisect_next_all(the_repository, prefix);
     -+	res = bisect_next_all(the_repository, prefix, &first_bad_oid);
     - 
     - 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
     - 		res = bisect_successful(terms);
      @@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
       	return res;
       }
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       	int temporary_stdout_fd, saved_stdout;
       	int is_first_run = 1;
      +	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
     -+	bool reset_when_found_arg_seen = false;
       
       	if (bisect_next_check(terms, NULL))
       		return BISECT_FAILED;
       
      +	if (argc && !strcmp(argv[0], "--reset-when-found")) {
      +		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
     -+		reset_when_found_arg_seen = true;
      +	} else if (argc && skip_prefix(argv[0], "--reset-when-found=",
      +				    &reset_when_found_arg)) {
      +		if (parse_reset_when_found(reset_when_found_arg,
      +					   &reset_when_found))
      +			return BISECT_FAILED;
     -+		reset_when_found_arg_seen = true;
      +	}
      +
      +	if (reset_when_found != RESET_WHEN_FOUND_NONE &&
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
      +		return error(_("options '%s' and '%s' cannot be used together"),
      +			     "--reset-when-found", "--no-checkout");
      +
     -+	if (reset_when_found_arg_seen) {
     ++	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
      +		write_file(git_path_bisect_reset_when_found(), "%s\n",
      +			   reset_when_found_mode_name(reset_when_found));
      +		argc--;

-- 
gitgitgadget
