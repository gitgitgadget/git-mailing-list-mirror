Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A334DCCE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950150; cv=none; b=nA+ADutneoq14V+/tXVo96hi94vNwekcQFR9F/Re/t38zMBIj5hOU1T7R869ku56XnBZ4OMvARHlTIkk2yJynC3ygJEzQUJJfQIo4citTD51bWqEgXsTetW92zd+PdTfEiDj+SJ3IpUmg8JLkl00yPadZSLB+hFtoaVMERup/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950150; c=relaxed/simple;
	bh=tads9hZU4hcqg/454eqFzae+gH2YJJGjiZPZCtkc5UU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K3FtAFQdt0qGlNwGaw3b8eCR1vy/lbGRtRmWd5QxZtCtr2SJ3ycdbJbY31JUi/IHvn04N41lV9CM8h0voH+MZG6ZJbJAQgc2DJQeWhF/aog8i3Okj6lFLKbvfjcyKMcI0flACbCE9Bg3XkmzaRZAo2Boj5wh3bKbGZcroWFnhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMBXLPXv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMBXLPXv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b62805b2a4so50155061cf.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950147; x=1758554947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKlUdZcmLEUQDoRTqNMBALF+cPEuib+sqTxdOHTwGk8=;
        b=GMBXLPXvCOiS3vA//2+uaLdTjkqMSK/xX6iDp/+a95ByjOHtN6i4mQAxHbMIEthDt0
         vhdyUDrVGIhgeBzAkpbwAahE2riLbIXHDjxb8o3MugXyduBgx+rkD4XrsVjLQuc5gQEX
         ukn5vdeiyJSPHeLgDLOxKLxzxPNCVJApDF5/h8z/FLXf19+rMxPu+w71O05rQJl7BvQl
         7Tlhmp0tcVbjnNjlLic9p9sn/ck/kkQ3pfA/YbzsMVn2Mm5YnO01/5lrrzwU9PRXaUDN
         L/ErBc0Jhkp/daEpQ8j1M9L/qmrHv4tCQVH4Wj/10nfSkMugfAhCS60VicyPBoBXBIi8
         Dc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950147; x=1758554947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKlUdZcmLEUQDoRTqNMBALF+cPEuib+sqTxdOHTwGk8=;
        b=cgNpTI/bJ1q6LOVPPHI0oJrg6RKielpoTFae9MtQFO/U0457+APqOnwhcm2R1Mli0Q
         i8FKMtDHf1v3P/EFiHktXJVWP3F68yhdI9VbTxIgXuXZ8AiyCScXoOfBg4zlg7uthKKO
         aRCen8+8vTpx40D6mYnU5C+CHURq/MC+Xj16oigkt+hoCkzXDNTbSMdvaDVB0hjEXRHz
         oImlL8ExgpUEucNd+nMHR0zTo10kEFEcJlbEU27zgIVnOuNtdJsasJL6gmTGvH0ok6KZ
         R61v/dkYL4E1LZwuN+cwACuHb5xbhtup8kcTUYfYLqfGAzda+dldDZz5WL7SeGaAuOUV
         Z+pQ==
X-Gm-Message-State: AOJu0YwM7KxEpPgCtrP/vOsqnE/nFepGZPzK8+2KqUXnlURLwT/q9f0I
	jGixuEbSK7V61d6niykYGUWTnPBbACLeJXSc6CM8mICyMgM8lxQYC2rkSxAe3g==
X-Gm-Gg: ASbGncvPiWggi6EbhXvA73BljXqXWQe0woC7XQzmFIW/7T9coGl/XeDsPsLgbXLmhDg
	uXDzRCqaxIMgsGdoagOYIWe3T5JEmpkBSk+U8Im5VjSyFz6CxJNQXGb2Pd4ur+4Pd4NORhkRVtb
	n0TxR72oZokxPhAecDtbr7wQqaE3MZL5Fn1/jShxGRl4knc7xzaPZuCiSBSZ2LiBm8W538C37Me
	Cst+SyIMUzuWJTlNygI+lzuaj5ORh/0p/Jq05A1/NLXAqM9aisSQL8yCPeSl1vEy9pZYezuvItc
	5w/+7RaFvGxHMVeGSCdeh9otUgC06on+VHMNJL3ui7H65Y7nsBi8/JbS2iiCIJc0bJoiWDhWLHC
	YYUYE/Dfm//wfPpeASzNGndp9cLV79zWNOSY=
X-Google-Smtp-Source: AGHT+IE3wYOipA0VuZhHRrGMUjNneAWsB3i6BrMJ8Qsu6jHxawLvodpB5PfVqbgMWdC7c4CwODZ9ww==
X-Received: by 2002:ac8:5896:0:b0:4b7:9506:efd1 with SMTP id d75a77b69052e-4b795070a1dmr73192201cf.15.1757950146125;
        Mon, 15 Sep 2025 08:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.95.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7a9e98f12sm13106181cf.9.2025.09.15.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:29:05 -0700 (PDT)
Message-Id: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Sep 2025 15:29:02 +0000
Subject: [PATCH v2 0/2] add -p: a couple of hunk splitting fixes
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Justin and Junio for their comments in V1. Sorry for the long
delay in re-rolling - I thought I'd sent these ages ago and then discovered
that they weren't upstream and realized I had not, in fact, sent them
after-all.

Changes since V1:

 * Patch 1: The new hunks created by splitting a hunk are now only marked as
   "undecided" when WITH_BREAKING_CHANGES is enabled.

 * Patch 2: Reworded commit message and added a space before a redirection
   in the test

V1 Cover Letter:

This series fixes a couple of infelicities when splitting hunks that have
already been selected or edited which I noticed a while ago when preparing
the test for 'pw/add-patch-with-suppress-blank-empty'.

Phillip Wood (2):
  add -p: mark split hunks as undecided
  add-patch: update hunk splitability after editing

 Documentation/BreakingChanges.adoc |  5 +++++
 add-patch.c                        | 19 +++++++++++++++-
 t/t3701-add-interactive.sh         | 36 ++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)


base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1863%2Fphillipwood%2Fadd-p-split-hunks-are-undecided-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1863/phillipwood/add-p-split-hunks-are-undecided-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1863

Range-diff vs v1:

 1:  43a0592a46 ! 1:  3e2ec7b37f add -p: mark split hunks as undecided
     @@ Metadata
       ## Commit message ##
          add -p: mark split hunks as undecided
      
     -    When a hunk is split each of the new hunks inherits whether it is
     -    selected or not from the original hunk. This means that if a selected
     -    hunk is split all of the new hunks are selected and the user is not asked
     -    whether or not they want to select the new hunks. This is unfortunate as
     -    the user is presumably splitting the original hunk because they only
     -    want to select some sub-set of it. Fix this by marking all the new hunks
     -    as "undecided" so that we prompt the user to decide whether to select
     -    them or not.
     +    When a hunk is split, each of the new hunks inherits whether it is
     +    selected or not from the original hunk. If a selected hunk is split
     +    all of the new hunks are marked as "selected" and the user is only
     +    prompted with the first of the split hunks. The user is not asked
     +    whether or not they wish to select the rest of the new hunks. This
     +    means that if they wish to deselect any of the new hunks apart from
     +    the first one they have to navigate back to the hunk they want to
     +    deselect before they can deselect it. This is unfortunate as the user
     +    is presumably splitting the original hunk because they only want to
     +    select some sub-set of it.
     +
     +    Instead mark all the new hunks as "undecided" so that the user is
     +    prompted whether they wish to select each one in turn. In the case
     +    where the user only wants to change the selection of the first of
     +    the split hunks they will now have to do more work re-selecting the
     +    remaining split hunks. However, changing the selection of any of the
     +    other newly created hunks is now much simpler as the user no-longer has
     +    to navigate back to them in order to change their selected state. Due
     +    to concerns that users may be relying on the current behaviour [1]
     +    this change is guarded by WITH_BREAKING_CHANGES.
     +
     +    [1] https://lore.kernel.org/git/xmqqjz9b6xr1.fsf@gitster.g
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     + ## Documentation/BreakingChanges.adoc ##
     +@@ Documentation/BreakingChanges.adoc: A prerequisite for this change is that the ecosystem is ready to support the
     + "reftable" format. Most importantly, alternative implementations of Git like
     + JGit, libgit2 and Gitoxide need to support it.
     + 
     ++* The behavior of "git add -p" has been changed so that splitting a
     ++  hunk that has already been marked as selected or unselected will now
     ++  prompt the user to select each of the new hunks created by the
     ++  split instead of them inheriting their state from the original hunk.
     ++
     + === Removals
     + 
     + * Support for grafting commits has long been superseded by git-replace(1).
     +
       ## add-patch.c ##
      @@ add-patch.c: static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
       			* sizeof(*hunk));
       	hunk = file_diff->hunk + hunk_index;
       	hunk->splittable_into = 1;
     ++#ifdef WITH_BREAKING_CHANGES
      +	hunk->use = UNDECIDED_HUNK;
     ++#endif
       	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
       
       	header = &hunk->header;
     @@ add-patch.c: next_hunk_line:
       
       		hunk++;
       		hunk->splittable_into = 1;
     --		hunk->use = hunk[-1].use;
     ++#ifdef WITH_BREAKING_CHANGES
      +		hunk->use = UNDECIDED_HUNK;
     ++#else
     + 		hunk->use = hunk[-1].use;
     ++#endif
       		header = &hunk->header;
       
       		header->old_count = header->new_count = context_line_count;
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
     - 	test_cmp expect actual
     - '
     +@@ t/t3701-add-interactive.sh: do
     + 	'
     + done
       
     -+test_expect_success 'splitting previous hunk marks split hunks as undecided' '
     ++test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split hunks as undecided' '
      +	test_write_lines a " " b c d e f g h i j k >file &&
      +	git add file &&
      +	test_write_lines x " " b y d e f g h i j x >file &&
 2:  35ef0ee2b9 ! 2:  3a831b1a2d add-patch: update hunk splitability after editing
     @@ Metadata
       ## Commit message ##
          add-patch: update hunk splitability after editing
      
     -    When the users edits a hunk if they change deletion lines to context
     -    lines or vice versa then the number of hunks that the edited hunk can be
     -    split into may differ from the unedited hunk and so we need to update
     -    hunk->splittable_into. In practice users are unlikely to hit this bug as
     -    it is doubtful that a user who has edited a hunk will split it
     -    afterwards.
     +    If, when the user edits a hunk, they change deletion lines into
     +    context lines or vice versa, then the number of hunks that the edited
     +    hunk can be split into may differ from the unedited hunk. This means
     +    that so we should recalculate `hunk->splittable_into` after the hunk
     +    has been edited. In practice users are unlikely to hit this bug as it
     +    is doubtful that a user who has edited a hunk will split it afterwards.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ add-patch.c: static ssize_t recount_edited_hunk(struct add_p_state *s, struct hu
       
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success 'splitting previous hunk marks split hunks as undecided' '
     +@@ t/t3701-add-interactive.sh: test_expect_success WITH_BREAKING_CHANGES 'splitting previous hunk marks split h
       	test_cmp expect actual
       '
       
     @@ t/t3701-add-interactive.sh: test_expect_success 'splitting previous hunk marks s
      +	mv "$1.tmp" "$1"
      +	EOF
      +
     -+	test_write_lines a b c d e f g h i j k l m n>file &&
     ++	test_write_lines a b c d e f g h i j k l m n >file &&
      +	git add file &&
      +	test_write_lines A b c d E f g h i j k l M n >file &&
      +	(
      +		test_set_editor "$(pwd)/fake-editor.sh" &&
     -+		test_write_lines e K s j y n y q | git add -p file
     ++		if test_have_prereq WITH_BREAKING_CHANGES
     ++		then
     ++			test_write_lines e K s j y n y q
     ++		else
     ++			test_write_lines e K s n K n y q
     ++		fi | git add -p file
      +	) &&
      +	git cat-file blob :file >actual &&
      +	test_write_lines a b d e f g h i j k l M n >expect &&

-- 
gitgitgadget
