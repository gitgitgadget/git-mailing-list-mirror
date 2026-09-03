Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BB4BB810
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446412; cv=none; b=MkoHYyu2MWsjqPJDgI2L7sVrHu5rxl/7UCqUzpVZwfOApjyQoRiHjzputmkf/HkP2fPfFUlkmOKeuJLiH1ogCGj3Qxo2pjHDj3ouuRPnVZAo3SCR8EU3iwhA4piPE8ubWniqvB2/c6lmdLSWnQmlLICvsO/M2XQf6GHDm0+9jp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446412; c=relaxed/simple;
	bh=jRXRRIrRl0WBfCBV/G1jwKIXYvx3Vqbu5tWuW0vffkE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e1nj8XF3dZShZKKEb2R7A4sKoZZPJLiJHKe5jVJA+duNhK4oCBVeVyYBj/OVGADm7VjQbB5hRygUwpa1e9BEeiFKT/vW6rnZXXYvndi3Y2GJfbBlleF/5p06wNCvu0JFLs0hbCHNHHswO4TIPqWKZkeK1aexjtQyEEshE+6WC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL/S7ClO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL/S7ClO"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b60bc6b4eeso1540110e87.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446403; x=1789051203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jk4yy/583nTgRSd5TzkSzIlTri9h6v4Ik8GJi4I3/Zc=;
        b=CL/S7ClOPLEc5BNvYOX1LOAt2ltNEvAz2tPPa+9PkmKUDKwwRWsvcoYNysPODCH1h8
         H2kLWpm0y2olbWOFYXIpemKmXMXtljn7gCia+nsEfvj+7d+Hu5FAa4gF5Yyle7q75jpm
         IrHc8/i3NhFQMzmb/L/o/VtE6vdQKL8rcwnJXEHOuauLbV6zwTGOBaaq1K5m5jTjboOS
         kvwWVA1tdzVyF6eDaqjTg1j+kLpwoC9leFxpEirQjPIhxOC2vlVS50YABPmreth75WCZ
         utodOYEuLWWKq4xPMg2z3e1qeGMhTXU1H0BZCjc40kiotuATJty6Tjiy6fisJFN6hc7h
         hi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446403; x=1789051203;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jk4yy/583nTgRSd5TzkSzIlTri9h6v4Ik8GJi4I3/Zc=;
        b=Flq657r/+Hhy0tD5a92FmKJFtbpf+pdObda+Wir+YvWrnZJ0brlD0jDKfgDQIDSJBV
         v4dlBskmT9cDZww+mK8n+7w5eyw26kxOthr4QkL8Bdt9DJ2V4uKu3rWMcxxEjltaAxl0
         OU9v9sh7DvAspn3UATdYFKt3KqyV+J3J/SkxUxhF/twl+UZK6prvm+5YRGJj3smLh/an
         9p74yogyXRtawl2R+XtCkHXeZ+WA6YjxsJd5QEaUBuSg6HWtQNDalTCSNyPmZw/ugTnv
         Z7Du9s1gfhWUjOtzFR8iO2gf9Cuzdp/0kxShE7CrRBJtdrWgd3pWzGcrSZ2CHHoklr2P
         BUYQ==
X-Gm-Message-State: AFuF++ld2xwjbEWJL7sTt8axom3TXGpzhcwbjntplTQJPxk34YzTSwen
	FbFOmwp2BaqgIcJQM71LC80P3AG9DnyZNWceLpj4H+6h0UQCVArRF0foKqFACfod
X-Gm-Gg: AYBFou2bJy3chaJre9ORCe2sEXZGSj3JNdEHH0gTRLMiWLTOIW3l0klTrjiiRsASm58
	A+SRQQQc9OnsmKOte/vNJHV+BP0F+d/tL6ved0WFjGLFLq34GfX+COui7tkIb3OZ5zo5msZ9ihh
	G939qHwpPyL8oMrUfb6dwArP07VTBnTh9rbv9b8UtGPVfeqqxXX8Hj56AgW+XXYZA2/KAJpt4Dg
	op4Utr5gqvd6jexe1uojF5Kg9cIDWqsti32bXXuN+ra9RcctmH4osLQWxdYKQQ1uOGdC9EnXoeU
	xo5wHluurW3phuQgdGUEukD+/whkrpkweUZnD13KQncslckPpY4mQRPiyzskNQ4uRyOM2YSEHmg
	hAJduPbtXq+YPp/CT09PNmA94Fl6nClBChkVbDrKkmVa1mpnx/tvVNCzwbJIUTLcKZ+GKHP25yQ
	0Rwk/2FueCmP3Oj3p+/NeyVr+rBdcJ/lnWAYEYeHH/TmuCHeZEqIoZHa90lCY5fLnNOQ==
X-Received: by 2002:a05:6512:3984:b0:5b1:5ab5:ea09 with SMTP id 2adb3069b0e04-5b6080d1d4bmr4090977e87.0.1788446402460;
        Thu, 03 Sep 2026 07:40:02 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.215.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b606b1cbe6sm1375704e87.20.2026.09.03.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:39:59 -0700 (PDT)
Message-Id: <pull.2364.v5.git.git.1788446398.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 14:39:56 +0000
Subject: [PATCH v5 0/2] checkout -m: refine autostash fallback
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoiding checkout -m autostash retries when no tracked local changes exist
and visually separating autostash conflict advice from the subsequent
branch-switch message. Addresses #leftoverbits from here:
https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/

Changes in v5:

 * Improve commit messages.
 * Create helper do_stash_apply.

Changes in v4:

 * Conflicts now exit with status 1 like merge-tree, other failures exit 128
   so exit 1 unambiguously means conflicts. Stash changes split into their
   own commit.
 * The autostash apply helpers use the return value (enum
   stash_apply_result) instead of an out-parameter, and only claim conflicts
   when git stash apply actually reported them.

Changes in v3:

 * Use enum for git stash return values, to separate conflict from generic
   error.

Changes in v2:

 * Simplify logic and combine to one commit.
 * Test full output with test_cmp.

Harald Nordgren (2):
  stash: reserve exit status 1 for conflicts
  checkout: separate autostash conflict advice from branch-switch
    message

 Documentation/git-stash.adoc |   9 +++
 builtin/checkout.c           |  15 +++--
 builtin/stash.c              |  33 +++++++---
 sequencer.c                  | 113 ++++++++++++++++++++++-------------
 sequencer.h                  |  19 +++---
 stash.h                      |  21 +++++++
 t/t3903-stash.sh             |  25 +++++++-
 t/t7201-co.sh                |  16 +++--
 8 files changed, 181 insertions(+), 70 deletions(-)
 create mode 100644 stash.h


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v5
Pull-Request: https://github.com/git/git/pull/2364

Range-diff vs v4:

 1:  ff43221802 ! 1:  fe22b1bfa6 stash: reserve exit status 1 for conflicts
     @@ Commit message
          status die() uses, when they fail for other reasons.  Document the
          exit statuses.
      
     -    cmd_stash() used to collapse the return values of the subcommand
     -    implementations to a boolean.  It now maps negative values, which
     -    signal a failure, to 128 and passes everything else through as-is.
     -    The only implementations that return a positive value are "apply",
     -    "pop" and "branch", which return the value of do_apply_stash():
     -    "apply" returns it directly, and "pop" and "branch" drop the stash
     -    entry, via do_drop_stash(), which always returns 0, only when the
     -    application succeeded.  The positive value is always 1, as
     -    do_apply_stash() only returns a positive value when the three-way
     -    merge was unclean.
     -
     -    Make the convention explicit by introducing enum stash_apply_result
     -    with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
     -    STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
     -    too.  They spawn "git stash apply" and can now tell conflicts apart
     -    from other failures, e.g. a crash or death by signal of the child,
     -    which map to exit statuses above 1.  Since we know the stash entry
     -    was saved, tell users so in the error message instead of leaving them
     -    wondering what happened to their stashed changes.
     +    The only subcommand implementations that can return a positive value
     +    are "apply", "pop" and "branch", which return the value of
     +    do_apply_stash(): "apply" returns it directly, and "pop" and "branch"
     +    drop the stash entry, via do_drop_stash(), which always returns 0,
     +    only when the application succeeded.  do_apply_stash() only returns a
     +    positive value when the three-way merge was unclean.  cmd_stash() now
     +    maps negative values to 128 and passes positive values through as the
     +    exit status, so exit status 1 unambiguously indicates conflicts.
     +    enum stash_apply_result makes the convention explicit, and the
     +    autostash helpers use it to tell users that their stashed changes
     +    were saved when applying them fails.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/stash.c: int cmd_stash(int argc,
      +		if (ret < 0)
      +			return 128;
      +		return ret;
     -+	} else if (!argc)
     ++	} else if (!argc) {
       		return !!push_stash_unassumed(0, NULL, prefix, repo);
     ++	}
       
       	/* Assume 'stash push' */
     + 	strvec_push(&args, "push");
      
       ## sequencer.c ##
      @@
     @@ sequencer.c: void create_autostash_ref(struct repository *r, const char *refname
      -				    const char *label_ours, const char *label_theirs,
      -				    const char *label_base,
      -				    const char *stash_msg)
     ++static enum stash_apply_result do_stash_apply(const char *stash_oid,
     ++					      const char *label_ours,
     ++					      const char *label_theirs,
     ++					      const char *label_base)
     + {
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +-	int ret = 0;
     + 
     +-	if (attempt_apply) {
     +-		child.git_cmd = 1;
     +-		child.no_stdout = 1;
     +-		child.no_stderr = 1;
     +-		strvec_push(&child.args, "stash");
     +-		strvec_push(&child.args, "apply");
     +-		if (label_ours)
     +-			strvec_pushf(&child.args, "--label-ours=%s", label_ours);
     +-		if (label_theirs)
     +-			strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
     +-		if (label_base)
     +-			strvec_pushf(&child.args, "--label-base=%s", label_base);
     +-		strvec_push(&child.args, stash_oid);
     +-		ret = run_command(&child);
     +-	}
     +-
     +-	if (attempt_apply && !ret)
     ++	child.git_cmd = 1;
     ++	child.no_stdout = 1;
     ++	child.no_stderr = 1;
     ++	strvec_push(&child.args, "stash");
     ++	strvec_push(&child.args, "apply");
     ++	if (label_ours)
     ++		strvec_pushf(&child.args, "--label-ours=%s", label_ours);
     ++	if (label_theirs)
     ++		strvec_pushf(&child.args, "--label-theirs=%s", label_theirs);
     ++	if (label_base)
     ++		strvec_pushf(&child.args, "--label-base=%s", label_base);
     ++	strvec_push(&child.args, stash_oid);
     ++
     ++	switch (run_command(&child)) {
     ++	case 0:
     ++		return STASH_APPLY_CLEAN;
     ++	case STASH_APPLY_CONFLICT:
     ++		return STASH_APPLY_CONFLICT;
     ++	default:
     ++		return STASH_APPLY_ERROR;
     ++	}
     ++}
     ++
      +static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
      +							int attempt_apply,
      +							const char *label_ours,
      +							const char *label_theirs,
      +							const char *label_base,
      +							const char *stash_msg)
     - {
     - 	struct child_process child = CHILD_PROCESS_INIT;
     --	int ret = 0;
     ++{
      +	enum stash_apply_result ret = STASH_APPLY_CLEAN;
     - 
     - 	if (attempt_apply) {
     - 		child.git_cmd = 1;
     -@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     - 			strvec_pushf(&child.args, "--label-base=%s", label_base);
     - 		strvec_push(&child.args, stash_oid);
     - 		ret = run_command(&child);
     -+		if (ret > 1)
     -+			ret = STASH_APPLY_ERROR;
     - 	}
     - 
     --	if (attempt_apply && !ret)
     ++
     ++	if (attempt_apply)
     ++		ret = do_stash_apply(stash_oid, label_ours, label_theirs,
     ++				     label_base);
     ++
      +	if (attempt_apply && ret == STASH_APPLY_CLEAN)
       		fprintf(stderr, _("Applied autostash.\n"));
       	else {
 2:  935fa0a9ae = 2:  d18ff3ea9a checkout: separate autostash conflict advice from branch-switch message

-- 
gitgitgadget
