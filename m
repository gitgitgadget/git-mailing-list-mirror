Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B21419A4
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368967; cv=none; b=DoZuMYyH0A3Rj/c5KUpvXmv3Ubk9oDLzBrp/2wxEyNq+IeyVMDLNb6S1If91y0SrMwAEvdq9iz2JnByeKU92oOyUQMyoYH8eqzROrl/Xute8ULgEarF009SRUXwKuKmytF+vK99B4tCDFVX1MWKdxiOFWu5eU7fQAzM/QbY+w1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368967; c=relaxed/simple;
	bh=l89reIoXFHugzuZm+6FzwdSUVd0/lKrfxc6slRbFh5o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rmwietUtDXpnVfmkgbKFnq6tML59STTHD1rrd1nlXk/Bpx87RRaVcOeQo3ViQh/kEVssTAtxpmO3MhsVlyTI69kCGgKpRMOrh/unNWvlxvH6cZ+t9Jj12hjGzJjD8AuqqRvHi+0pjOOTSG4Qhsi7pigsumPLJfxFN2DtZbzr5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf0uK77P; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf0uK77P"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1979910a91.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 20:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787368965; x=1787973765; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CnMSfzftZFEV2hvaQE7MgWwSEnfF7YhxrTYjLOVAtYw=;
        b=Tf0uK77Pv3oXRMKP9qB+n7ZLkxabCEP9aWq19QYrPUPmILxg1YOu8wSiyAGXZ8UOCW
         rV4xCaOqiN2/zugtZIJiFMbmflddnWXMNzjGmYa/HO+Ez5d3Z7nfTYLnW+Kveisq6l5R
         CoavhVs1R924aaGjdotBGMjV8Ou1OwgGClExKft4c7cAcLcBCI62XKnqLFPcjkh1GgTy
         gC+llpg0NqBQ3R4Rj5MzVRkikUlb/dPDCHK/XRvx5qY/eKcUNyP4h8b1BeVsYnQskfAN
         +7R+xkQS7dG8qSu2BrrbOFhtuhGyzUx9CjBwGbuK/yKmPgG2tuiNe26inMpk/aDZQkdH
         G4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787368965; x=1787973765;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnMSfzftZFEV2hvaQE7MgWwSEnfF7YhxrTYjLOVAtYw=;
        b=cgOWBrq/vmXqRFeuDS63BQkA/cKcNRrFkN41iWsh1gi1Z1tksT3AsfrE8DixVWgVPL
         3DOFW46k30cBMpcBa6TiSoXFTRGR1fonhTXm6NaCzb1ylOnB/j3N8l11nrI+zKQPGPx/
         B6WcICAcMZEtQodo83DwhzFDgRIOqMW4gi2ZPYyOmf+4tbWUAegQH35jytWdZw7HujaV
         i45LsBib+JgaGtX7q4GsD/Hs48fTzI5Hli59Q1dHJKkfeAtD5L/Bv5QtLZdJEZfaGCn8
         JtRZn6RVn90QLeT8lI9vRAgqszZG9E4im1TlGJREeBPPn7TJ16GFmIVj5FrjBkPZsPur
         Wmig==
X-Gm-Message-State: AFuF++n4zo+9fB9W2SxHGM5+IFFKyCprG4S1BRVW3/xkdczQA5ovfbEO
	VYM1+WO1T1Fq1Wt3FjDMNV8YgFNvsfh66wB8IBMcUUBHcLPYGrWtCOTZvwR8bw==
X-Gm-Gg: AR+sD12oqlQactvzASef/Bz76HSKonOY2ACPb0XIWVbYFrF8pZIQcka41VSg1OYWIdP
	gPCmdCVYFpvelX6NJ/1H9/UZXvgWHdLV/JsI66lMQRkD2JTwfy979B/KMUaaamQSXAX8g2zZn4q
	uDcOWLRpS5mIZhqXy8MqrORwOgQ+HXEi2f9+eF58PLEF8CvJX/4uoH564Io2W+lPDNMMrde3yN9
	nzk2b9QYYXUISY7IKwK0k2IOVdiid+atu+TApvtB/X07VCuZAvAjoLDKduyb3+6k8i2NHbMnC5N
	aZmCKjfyDD69Wyag0Gxxg3OLWOinl4O7nMNareOBfYPTNiR9iYhgnmD7XL4aTTObk4smI5jO8YP
	rNAm2pdFqx+8e/PdTBcv27t/1yazz3yANcc6umTKU3oAPD1pqPGesC7fXl73b+qRPdDAPJn8wI2
	GfP+X8o3HHG6EvFeCwqjKnv9vYPqZvbLipjYp9xtuaL9tVw2aLk7QiirqahZub0dTz+w==
X-Received: by 2002:a17:90b:524b:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-395deec4953mr5833427a91.5.1787368965004;
        Fri, 21 Aug 2026 20:22:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm1630523eec.7.2026.08.21.20.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 20:22:44 -0700 (PDT)
Message-Id: <pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Aug 2026 03:22:39 +0000
Subject: [PATCH v7 0/3] worktree add: improve message for ambiguous remote branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add ../foo-dir bar-topic' fails to dwim when there are
multiple remote branches with name `bar-topic'. But it doesn't display
meaningful message as 'git checkout bar-topic' does under the same
situation.

We improve this by adding advice and modify the error message for worktree
add.

By Junio's suggestion, we include matched remote names in the advice. It is
applied to checkout, too.

Changes from the previous patch:

 * fix grammatical errors in hints
 * narrow the scope of local variable oid

Yoichi NAKAYAMA (3):
  checkout: extract function to display advice for ambiguous remotes
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name

 builtin/checkout.c      | 76 +++++++++++++++++++++++++----------------
 builtin/worktree.c      | 39 ++++++++++++++++++---
 checkout.c              | 14 ++++++--
 checkout.h              |  5 ++-
 t/t2400-worktree-add.sh |  4 +--
 5 files changed, 99 insertions(+), 39 deletions(-)


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v6:

 1:  e3f7d88520 = 1:  e3f7d88520 checkout: extract function to display advice for ambiguous remotes
 2:  97e99ae31e ! 2:  89c0f4d303 checkout: improve message for ambiguous remote branch name
     @@ Metadata
       ## Commit message ##
          checkout: improve message for ambiguous remote branch name
      
     -    When the user runs 'git checkout bar-topic' command that does not
     -    exactly say which remote they want to work with, and there is no local
     -    branch named bar-topic, we try to guess which remote by passing
     -    bar-topic then create a new branch named bar-topic which tracks the
     -    remote branch.
     +    When the user runs 'git checkout bar-topic' without specifying a
     +    remote, and there is no local branch named bar-topic, we try to guess
     +    which remote branch bar-topic refers to, then create a new branch
     +    named bar-topic that tracks the remote branch.
      
          If multiple remotes have a branch named bar-topic, we cannot determine
     -    a single specific remote. Therefore, we provide information that the
     -    user can utilize to resolve the issue.
     +    a single remote.
      
     -    To make the advice more feasible, we will provide matched remote names
     -    for the specified branch name.
     +    To make it easier to resolve the ambiguity, provide the names of the
     +    matching remotes for the specified branch name.
      
     -    To achieve that, we add an optional feature to the
     -    `unique_tracking_name()` function that allows the matched remote name
     -    to be exposed to the caller.
     +    To achieve that, add an optional feature to the
     +    `unique_tracking_name()` function that allows the matching remote
     +    names to be exposed to the caller.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
     @@ builtin/checkout.c: static void advice_disambiguating_remotes(enum checkout_comm
       	}
       
      -	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
     -+	advise(_("Branches with the same name appears in multiple remotes:"));
     ++	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
      +	for_each_string_list_item(item, matched_remote_names) {
      +		advise(_("  %s"), item->string);
      +	}
 3:  dcb84a69a6 ! 3:  095a5796d4 worktree add: improve message for ambiguous remote branch name
     @@ Metadata
       ## Commit message ##
          worktree add: improve message for ambiguous remote branch name
      
     -    When the user runs 'git worktree add ../foo-dir bar-topic' command
     -    that does not exactly say which remote they want to work with, and
     -    there is no local branch named bar-topic, we try to guess which remote
     -    by passing bar-topic then create a new branch named bar-topic which
     -    tracks the remote branch.
     +    When the user runs 'git worktree add ../foo-dir bar-topic' without
     +    specifying a remote, and there is no local branch named bar-topic, we
     +    try to guess which remote branch bar-topic refers to, then create a
     +    new branch named bar-topic that tracks the remote branch.
      
     -    If there are multiple remotes that have branch named bar-topic, we
     -    silently gave up, leaving the variable 'branch' intact.  Then we
     -    entered the conditional clause 'if (!opts.orphan &&
     -    !lookup_commit_reference_by_name(branch))' and triggered "invalid
     -    reference" error.  This error message did not contain enough
     -    information to resolve the issue where the remote could not be
     -    guessed.
     +    If multiple remotes have a branch named bar-topic, we silently gave
     +    up, leaving the variable 'branch' intact.  We then entered the
     +    conditional clause 'if (!opts.orphan &&
     +    !lookup_commit_reference_by_name(branch))' and triggered an "invalid
     +    reference" error.  This error message did not provide enough
     +    information to resolve the ambiguity.
      
     -    To improve the situation, we display a hint and a descriptive error
     -    message and die immediately when multiple matching branches are found.
     +    When multiple matching branches are found, display a hint and a
     +    descriptive error message and die immediately.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
     @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
      +{
      +	struct string_list_item *item;
      +
     -+	advise(_("Branches with the same name appears in multiple remotes:"));
     ++	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
      +	for_each_string_list_item(item, matched_remote_names) {
      +		advise(_("  %s"), item->string);
      +	}
     @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
       	       struct repository *repo UNUSED)
       {
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
     + 		/* DWIM: Infer --orphan when repo has no refs. */
     + 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
       	} else if (ac == 2) {
     - 		struct object_id oid;
     +-		struct object_id oid;
       		struct commit *commit;
      -		char *remote;
       
       		commit = lookup_commit_reference_by_name(branch);
       		if (!commit) {
      -			remote = unique_tracking_name(branch, &oid, NULL, NULL);
     ++			struct object_id oid;
      +			char *remote;
      +			int num_matches = 0;
      +			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;

-- 
gitgitgadget
