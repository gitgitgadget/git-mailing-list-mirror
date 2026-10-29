Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267844;
	b=EJ+JGLgGbbQJvi0PE6pzveAtrEOrtnyQhKo6AzGHASM2q2h8SoyoPwyIceXd8IE5cMkl
	 FhCmE/y4cS+UpV6+z9RIFdx6GANv7RkrzDhOIXrpyOo5KJAoE9PcLN7iyKimCnrPqB0Lo
	 6XccVuGfUiXnybUFuCrwsCP99MIr8iSrcaqvB6QG1xpioGfgsoLLENfoXJmVBp9DCFldY
	 Gq6RXH+tYooT7PLOQ/D5IRc8qcV/DtjeArlA7W453ecSXez8hvoFSxNS4/gwjR5OaN5SJ
	 cAoTCD6ziObXSPS7/M4lq07hypDnz+oATFVkfCOLL0chW/eZflRmheOAoU6pKBjdiuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267844;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=1azIuux2ULt1US0u+LkE6NgEJCCklL77OecWeG5X8rE=;
	b=VVzl1V7itNS3sOiJdSBmYcf3yUmgVCqiB2Q1zWbNKB5Bmn8bObiRorwk9npFP5q95r6T
	 nTw0FHl31o3GS3RjwOTnGMZ9Gkt4jUMWcP84sAWsycUiZ0RouGOlCD0pCqbq7EpcZxuyD
	 zm5pR8xGPZJ84Y/7AQYVtX099YpHu8fVwM81SJLCFcjN7EJlZbXph1twRvaLmCssSdFGr
	 FmwH3z1cDeHiPW9jJRxXVmmPcG8KwQgI8GrRvNwRef1F2CFK+a24R8eM0M0XvHubbyjn4
	 NJF6Jh8JzqxZ0PB/zH+0GtZhXY1G/9+4rq29mG+rLpY2hmewXnZjx4XY/j6s1l0XN8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="c/3yVV26";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Vr+XE8cX;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EF606A329
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2EF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=c/3yVV26;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Vr+XE8cX
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CCB41D0008D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Oct 2026 05:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267842;
	 x=1793354242; bh=1azIuux2ULt1US0u+LkE6NgEJCCklL77OecWeG5X8rE=; b=
	c/3yVV26u80k04Qq5G+MWlo4VIOdkgjsw4stnDFhD+tHS2DerNzlQp2j8HOPQ3MV
	f9z7kqb0N7raXV2dvoRPy0dlKzYXkz1nFNB/9YwVDKG3Q64TqG96wMShGrOsh1Zd
	wtcFY/5NPwAU1W4C03zo4u6n0dmTVa5ElRheDTq47zabjIHrvHFWvMsEn4wnrsNw
	YUY1O3srQ2MdOVrSrgVA9y7s67mCUOFEl48EhOlYAp2Y6I2rDzBO5wQxYC3YDlmX
	pkakyUWdYLQnh2cgVwO+eSPjs8jN47GeRLpjTZBTfcvFjhKMed2olo6uIeFOk/Vg
	udXXozfQl5ZClk2mNu6DCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267842; x=
	1793354242; bh=1azIuux2ULt1US0u+LkE6NgEJCCklL77OecWeG5X8rE=; b=V
	r+XE8cXSAjzMXPIhy4zTvxb9RW0jKCYMt/CVgMc0z1AWMtIG4mEQTk6X0HhlyoTz
	mrBDyd99SRAtEmHiSxAQ18AG0MCqSYPuoNMBaXWw0pI61f2BQ6bV5nkUP2xQxY0i
	y/yOiDpsHMTZ312zcRdcBho4PxLeA8BmPPpOpNK50ZZafzre7XdzH62TuOCflt60
	dVut3LK194NoC42e1R3c7uhAWNE9BR4cq4UxN7xBOpdzEO/2NvWK5jlKMnC6TFHN
	HmaBfILTNURqiya9HOset/UfLUyHcIStZUBv9PY6SwLxSNOEAWc69ZeOu0BdI1v1
	TaEvjaDd9uzD2j6YVflVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267842; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Su5BvLc/pFftgVdRXnurV+hifOhbkF/YBI88cy1iSORIiHL
	3lQGSfT2hqTVA66byO27dWU9ZFQwkzgLn+pf96G55jeWULF/sbeSKX1MEM2yTbX6
	NjhVzl4FjiJ0uel7h4CP31KotCtXpepE3onCBfl/NSikpWBmGsrHfqclzU800Rp5
	OH4eHmXg/C3Zg2CeusL3EitbbiV0dL/jz+S7iFU2/BFW9j+sA5E5++WyNBwVgSjf
	Fm8903DT3iBONEhreVGSN6sPFzri3iTx8K32Rjwc1gk2PViBJufPs6W60JXXvgE6
	I3/NzfDREHvZqBTwV4qoCle9IWwh01Ol+MfmAog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ow+bRX1V/L+stknFxkhQ8WwCPaqNQy5b7LjviuD62SA=:lxG3fv1Avu4iN86b/P5REab/oLB576PIdojT/VzOjQQ=;
X-ME-Sender: <xms:ghjjaoaHsN6ewIFiTx6GlVsefVJCRvLae6yWSSG0b5F6Xd5RUCqBhw>
    <xme:ghjjaq0PRkB8QqyUp-tQc9LPu_feDhXMtvK3ukURWG_rsYtQ5Lu9GzDTYjd-dQoTS
    NyoFQj4z8Pp2Fb0NLKfl7Q38E1-yC1m9pyEo2zbWKC5SN8_SEmE-k8>
X-ME-Received: <xmr:ghjjagUj5P2EuCGlnB6wSQDnPsxUHLcCunjLw9_2tFDj0l51qGUm6g>
X-ME-Proxy-Cause: dmFkZTER1zSBqmN/xgY9T062HZWxwIaPIhTvREW3YcrfL1SSJIiJGYPd3z1eug288FP2Fx
    09pVlj0hrB5XTzZx4OMsYtqexN4TermKL3PTTzSGHxaQSWKf+uzrNRDoWE8D5pplDjBO3C
    2RAp0At6FP9DRxNLtvB8fHYi67dmi7oHMHH13bRuBAy0Ss3Ig7exrXi/ZGg5HfLVuIDNur
    V2Kn/q1ydq+SEAKgZpfdhAffgOKEfIxfJiUE8uer9olQvFzY/eFyifjTykKnjQJFI5fX42
    yHL1uuDws2coq9A23E3hrmZNwnI4691AmVrn2DLDpqTPnLHNB4RCsHNPoti35eXi6Y7nSb
    U6PapH9CVbfi5DY10BGC2iUUDt2ZgpycAhLLO79ZmSnv4mp3OoaMxM8hPPSkcSfWJ/AMUH
    eavlo6PQvxj2j7MBluqA5CQlzgLb6w9foJogr05+MH1kxE7Dlfi86HMK68pHUIGC2/cRMZ
    Ix/X0I5O/XMWmzRiBHTboJBkhMx5A6NvJ7YHoYl+VD6OFz5BUs038qdL6T7qanP/bu/MQG
    TYlg4qGnTH0OEDTOY5OatneTryFOT0sWBpzfh4qjA3kkHAgKeG4/gHXMoxgGScRFPHAIor
    A4i+145CJHiCtDeEsLPWF2653q6x+zgn+sgqH8W2UmQ0bclIhFpSWd+Fb/hA
X-ME-Proxy: <xmx:ghjjasXq_5g18tkYjzg6uL7kOPDlrgezozHRkK1G2O7VER7ZOLpRrw>
    <xmx:ghjjandv4b-ev2zocwTJRP2Z5dlAZsjjHC8tbx-LtkfS2yrBvbv0QQ>
    <xmx:ghjjatXgZjsWPNQhaVh_lwlV1SP8tbEnaLiT-h2fuoEtRschnbMDOQ>
    <xmx:ghjjaoci_CDNWfNtp3iSZhS6zS3T9SpNYFP0fG4k035SKhbrHPuqLA>
    <xmx:ghjjai_Y64X-qYDQ9VxelTmBP62DApBL5RGZRnnLl8BiVw6GUVN5A5x2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65f548a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] builtin/rerere: convert to use subcommands
Date: Thu, 29 Oct 2026 10:57:09 +0100
Message-Id: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CQBBEr0J6bZv5ABJX3MOwwJlWWsMn00g0h
 Ls7gwcw3ZuXvKpaQSgwCZyzFQItLDwOEcwhA9e1w52QfWQwypRamRNOT8FA6VBeVzf2fTt4Qas
 rn+uisLmtIIanQDd+78WX5sdRf5CbU1syOpZ5DJ99edHJ+zuyaFToK1u6+KRcUUfxyD0027Z9A
 dDjaqrLAAAA
X-Change-ID: 20261027-pks-rerere-subcommands-318d41553438
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

while reviewing some patch series around git-rerere(1) recently I was a
bit appalled by our custom subcommand parsing that we do here. This
patch series here thus cleans up and modernizes that part a bit so that
git-rerere(1) behaves like every other Git command that happens to have
subcommands.

This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
rerere cache state, 2026-10-23) merged into it.

Changes in v2:
  - Document rerere flags.
  - Rename `rerere_record()` to just `rerere()`.
  - Link to v1: https://patch.msgid.link/20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      rerere: rename `repo_rerere()`
      rerere: convert flags into an enum
      builtin/rerere: drop `the_repository`
      builtin/rerere: stop passing flags to subcommands that ignore them
      builtin/rerere: turn "forget" into a proper subcommand
      builtin/rerere: turn "clear" into a proper subcommand
      builtin/rerere: turn "status" into a proper subcommand
      builtin/rerere: turn "remaining" into a proper subcommand
      builtin/rerere: turn "diff" into a proper subcommand
      builtin/rerere: turn "gc" into a proper subcommand
      builtin/rerere: use `OPT_SUBCOMMAND()`
      builtin/rerere: introduce proper usage strings for subcommands

 Documentation/git-rerere.adoc |   8 +-
 apply.c                       |   2 +-
 builtin/am.c                  |   4 +-
 builtin/commit.c              |   2 +-
 builtin/merge.c               |   2 +-
 builtin/rerere.c              | 319 ++++++++++++++++++++++++++++++++----------
 builtin/stash.c               |   2 +-
 rerere.c                      |  12 +-
 rerere.h                      |  37 +++--
 sequencer.c                   |   4 +-
 t/t4200-rerere.sh             |   5 -
 11 files changed, 291 insertions(+), 106 deletions(-)

Range-diff versus v1:

 1:  ce75cde848d !  1:  1f3fbbad575 rerere: rename `repo_rerere()`
    @@ Commit message
         repository as first parameter, that's not a good-enough reason to give
         it a `repo_` prefix.
     
    -    Rename the function to `rerere_record()` to be consistent with all the
    -    other functions.
    +    Rename the function to just `rerere()`. Move around and extend
    +    documentation of this function to better explain what it does.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ apply.c: static int write_out_results(struct apply_state *state, struct patch *l
      		 */
      		if (!state->cached)
     -			repo_rerere(state->repo, 0);
    -+			rerere_record(state->repo, 0);
    ++			rerere(state->repo, 0);
      	}
      
      	return errs;
    @@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const
      
      	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
     -		repo_rerere(the_repository, state->allow_rerere_autoupdate);
    -+		rerere_record(the_repository, state->allow_rerere_autoupdate);
    ++		rerere(the_repository, state->allow_rerere_autoupdate);
      		free(their_tree_name);
      		return error(_("Failed to merge in the changes."));
      	}
    @@ builtin/am.c: static void am_resolve(struct am_state *state, int allow_empty)
      	}
      
     -	repo_rerere(the_repository, 0);
    -+	rerere_record(the_repository, 0);
    ++	rerere(the_repository, 0);
      
      	do_commit(state);
      
    @@ builtin/commit.c: int cmd_commit(int argc,
      	git_test_write_commit_graph_or_die(the_repository);
      
     -	repo_rerere(the_repository, 0);
    -+	rerere_record(the_repository, 0);
    ++	rerere(the_repository, 0);
      	run_auto_maintenance(the_repository, quiet);
      	run_commit_hook(use_editor, repo_get_index_file(the_repository),
      			NULL, "post-commit", NULL);
    @@ builtin/merge.c: static int suggest_conflicts(void)
      	strbuf_release(&msgbuf);
      	fclose(fp);
     -	repo_rerere(the_repository, allow_rerere_auto);
    -+	rerere_record(the_repository, allow_rerere_auto);
    ++	rerere(the_repository, allow_rerere_auto);
      	printf(_("Automatic merge failed; "
      			"fix conflicts and then commit the result.\n"));
      	return 1;
    @@ builtin/rerere.c: int cmd_rerere(int argc,
      
      	if (argc < 1)
     -		return repo_rerere(the_repository, flags);
    -+		return rerere_record(the_repository, flags);
    ++		return rerere(the_repository, flags);
      
      	if (!strcmp(argv[0], "forget")) {
      		struct pathspec pathspec;
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
      
      	if (ret) {
     -		repo_rerere(the_repository, 0);
    -+		rerere_record(the_repository, 0);
    ++		rerere(the_repository, 0);
      
      		if (index)
      			fprintf_ln(stderr, _("Index was not unstashed."));
     
      ## rerere.c ##
     @@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
    -  * perform mergy operations, possibly leaving conflicted index entries
    -  * and working tree files.
    -  */
    + 	return fd;
    + }
    + 
    +-/*
    +- * The main entry point that is called internally from codepaths that
    +- * perform mergy operations, possibly leaving conflicted index entries
    +- * and working tree files.
    +- */
     -int repo_rerere(struct repository *r, int flags)
    -+int rerere_record(struct repository *r, int flags)
    ++int rerere(struct repository *r, int flags)
      {
      	struct string_list merge_rr = STRING_LIST_INIT_DUP;
      	struct rerere_cache cache;
    @@ rerere.h: int rerere_cache_setup(struct rerere_cache *cache,
      void rerere_cache_release(struct rerere_cache *cache);
      
     -int repo_rerere(struct repository *, int);
    -+int rerere_record(struct repository *, int);
    ++/*
    ++ * The main entry point that is called internally from codepaths that
    ++ * perform mergy operations, possibly leaving conflicted index entries
    ++ * and working tree files. It records (and optionally updates) resolved
    ++ * conflicts and reuses recorded resolutions for unresolved conflicts.
    ++ */
    ++int rerere(struct repository *r, int flags);
    ++
      /*
       * Given the conflict ID and the name of a "file" used for replaying
       * the recorded resolution (e.g. "preimage", "postimage"), return the
    @@ sequencer.c: static enum pick_result do_pick_commit(struct repository *r,
      		      short_commit_name(r, commit), msg.subject);
      		print_advice(r, res == 1, opts);
     -		repo_rerere(r, opts->allow_rerere_auto);
    -+		rerere_record(r, opts->allow_rerere_auto);
    ++		rerere(r, opts->allow_rerere_auto);
      		goto leave;
      	}
      
    @@ sequencer.c: static int do_merge(struct repository *r,
      	rollback_lock_file(&lock);
      	if (ret)
     -		repo_rerere(r, opts->allow_rerere_auto);
    -+		rerere_record(r, opts->allow_rerere_auto);
    ++		rerere(r, opts->allow_rerere_auto);
      	else
      		/*
      		 * In case of problems, we now want to return a positive
 2:  18259e1556a !  2:  e910458a47c rerere: convert flags into an enum
    @@ Commit message
     
         Our modern coding guidelines say that flags should typically be passed
         around as enums so that it becomes trivial to see what kind of flags are
    -    expected. Adapt the rerere flags accordingly.
    +    expected. Adapt the rerere flags accordingly and document them.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ rerere.c: static int is_rerere_enabled(struct repository *r)
      	int lock_timeout_ms = 1000;
      	int fd;
     @@ rerere.c: int rerere_cache_setup(struct rerere_cache *cache,
    -  * perform mergy operations, possibly leaving conflicted index entries
    -  * and working tree files.
    -  */
    --int rerere_record(struct repository *r, int flags)
    -+int rerere_record(struct repository *r, enum rerere_flags flags)
    + 	return fd;
    + }
    + 
    +-int rerere(struct repository *r, int flags)
    ++int rerere(struct repository *r, enum rerere_flags flags)
      {
      	struct string_list merge_rr = STRING_LIST_INIT_DUP;
      	struct rerere_cache cache;
    @@ rerere.h: struct rerere_id {
      };
      
     +enum rerere_flags {
    ++	/*
    ++	 * Auto-update the index with previously recorded resolutions. This can
    ++	 * be used to explicitly override "rerere.autoUpdate".
    ++	 */
     +	RERERE_AUTOUPDATE = (1 << 0),
    ++
    ++	/* Reverse of RERERE_AUTOUPDATE. */
     +	RERERE_NOAUTOUPDATE = (1 << 1),
    ++
    ++	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
     +	RERERE_READONLY = (1 << 2),
    -+	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
    ++
    ++	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
     +	RERERE_NOWAIT = (1 << 3),
     +};
     +
    @@ rerere.h: struct rerere_id {
     +		       enum rerere_flags flags);
      void rerere_cache_release(struct rerere_cache *cache);
      
    --int rerere_record(struct repository *, int);
    -+int rerere_record(struct repository *r, enum rerere_flags flags);
    + /*
    +@@ rerere.h: void rerere_cache_release(struct rerere_cache *cache);
    +  * and working tree files. It records (and optionally updates) resolved
    +  * conflicts and reuses recorded resolutions for unresolved conflicts.
    +  */
    +-int rerere(struct repository *r, int flags);
    ++int rerere(struct repository *r, enum rerere_flags flags);
    + 
      /*
       * Given the conflict ID and the name of a "file" used for replaying
    -  * the recorded resolution (e.g. "preimage", "postimage"), return the
     @@ rerere.h: const char *rerere_path(struct repository *,
      int rerere_forget(struct repository *, struct pathspec *);
      int rerere_remaining(struct repository *, struct string_list *);
 3:  89ae664d90d !  3:  5254d1ac3ba builtin/rerere: drop `the_repository`
    @@ builtin/rerere.c: int cmd_rerere(int argc,
      		flags = RERERE_NOAUTOUPDATE;
      
      	if (argc < 1)
    --		return rerere_record(the_repository, flags);
    -+		return rerere_record(repo, flags);
    +-		return rerere(the_repository, flags);
    ++		return rerere(repo, flags);
      
      	if (!strcmp(argv[0], "forget")) {
      		struct pathspec pathspec;
 4:  5eff73de7bc =  4:  8b24e253e6b builtin/rerere: stop passing flags to subcommands that ignore them
 5:  621c5f6ab1b !  5:  43dde532e63 builtin/rerere: turn "forget" into a proper subcommand
    @@ builtin/rerere.c: static int diff_two(const char *file1, const char *label1,
      	       const char *prefix,
     @@ builtin/rerere.c: int cmd_rerere(int argc,
      	if (argc < 1)
    - 		return rerere_record(repo, flags);
    + 		return rerere(repo, flags);
      
     -	if (!strcmp(argv[0], "forget")) {
     -		struct pathspec pathspec;
 6:  d01fa02064c =  6:  13fd07a2f53 builtin/rerere: turn "clear" into a proper subcommand
 7:  2bebea6449e =  7:  c5d48081cc9 builtin/rerere: turn "status" into a proper subcommand
 8:  5594019f31f =  8:  5c6891f6a48 builtin/rerere: turn "remaining" into a proper subcommand
 9:  e8a2f8ce209 =  9:  b7ed9ef810b builtin/rerere: turn "diff" into a proper subcommand
10:  deebcee0379 = 10:  0ceff6d241b builtin/rerere: turn "gc" into a proper subcommand
11:  56037e9a761 ! 11:  3b8b4b65a53 builtin/rerere: use `OPT_SUBCOMMAND()`
    @@ builtin/rerere.c: static int cmd_rerere_gc(int argc,
      	return 0;
      }
      
    -+static int cmd_rerere_record(int argc,
    -+			     const char **argv,
    -+			     const char *prefix,
    -+			     struct repository *repo)
    ++static int cmd_rerere_perform(int argc,
    ++			      const char **argv,
    ++			      const char *prefix,
    ++			      struct repository *repo)
     +{
     +	int autoupdate = -1;
     +	struct option options[] = {
    @@ builtin/rerere.c: static int cmd_rerere_gc(int argc,
     +	if (autoupdate == 0)
     +		flags = RERERE_NOAUTOUPDATE;
     +
    -+	return rerere_record(repo, flags);
    ++	return rerere(repo, flags);
     +}
     +
      static int cmd_rerere_remaining(int argc,
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     +		int ret;
      
     -	if (argc < 1)
    --		return rerere_record(repo, flags);
    +-		return rerere(repo, flags);
     -
     -	if (!strcmp(argv[0], "forget"))
     -		return cmd_rerere_forget(argc, argv, prefix, repo);
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     -		return cmd_rerere_diff(argc, argv, prefix, repo);
     -	else
     -		usage_with_options(rerere_usage, options);
    -+		strvec_push(&args, "record");
    ++		strvec_push(&args, "perform");
     +		strvec_pushv(&args, argv);
      
     -	return 0;
    @@ builtin/rerere.c: int cmd_rerere(int argc,
     +		CALLOC_ARRAY(args_copy, args.nr);
     +		COPY_ARRAY(args_copy, args.v, args.nr);
     +
    -+		ret = cmd_rerere_record(args.nr, args_copy, prefix, repo);
    ++		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
     +
     +		strvec_clear(&args);
     +		free(args_copy);
12:  102223da27b ! 12:  05adadc9dd8 builtin/rerere: introduce proper usage strings for subcommands
    @@ builtin/rerere.c: static int cmd_rerere_gc(int argc,
      	if (argc)
      		usage(_("too many arguments"));
      
    -@@ builtin/rerere.c: static int cmd_rerere_record(int argc,
    +@@ builtin/rerere.c: static int cmd_rerere_perform(int argc,
      			N_("register clean resolutions in index"), 1),
      		OPT_END(),
      	};

---
base-commit: 710910c03a22ac663885049213b9fef5853ea8e0
change-id: 20261027-pks-rerere-subcommands-318d41553438

