Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879D453A45
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841726; cv=none; b=A0yhJOoNv3jkn9Rrb8+9OtcyyYA/ipgk23N1hcHK754suhQxdlDnumR4WRW1OGMuok+DCFYW7j8BYtKVImHp6V21vWE987VaShxzUJNksfHN0CS2Hr+DSms8VzYCzgdhDbuQNqCsRb4j7IsTq/ahuOQrP0UsTCH6NAasNAZ/Zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841726; c=relaxed/simple;
	bh=YJR7ImD51dSaDWxmc/wFFyogsJ/KQ3vf63my864uvLQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L1cfPzT/d0OkBSIR4RNw5FlyKBegwlY6Q01P94nPDhFV5RwrEOgZfAgC9FbwelsJ+1rxpf03bHdTZk6U5rZHGHB+RSgU3nhZICek4x3Kiz+GxyRXJfBfxz+oxnYgiNd4RGk7AED8t6dGDyH3crXiuYWV/fVKTmWF6a4CNG25gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyr6QgHZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyr6QgHZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-529a1ee0e62so5378231cf.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841718; x=1788446518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HyK7kjf3mdb0HwxJC23v1DrXuB5Q8AzL+hKVFbHrxS4=;
        b=Cyr6QgHZb91J9RjtGt0czI+wjp/nVfi0ydYV2yde3o9cDU07Wa5P1+zsaR7Ua2lu/A
         m2tA9zHuEzFkTuLP06hjAxQFiTE6ySjklotU/NQLUY932j+IX0Vi5qkhpI4P1Yzwqy5h
         zFeh3qL4e57EKv2I/zPsbslsCgSb46RZ5X3FXTp11kk39MO48UOCwTy6wmIa9lUi3jw+
         pNX0RY5PNokwkNB4vScXrPRn69ajh2c5rvSOjHXIhwKasJ7bqXsOgIDe4OGV72lWM+4/
         cPffRuF65GzSoM6vjLQ3mOysLdEXVqNWTDPOYUqjnz1FgpCV9em0Tz6O9RDytwuPHDvv
         ZYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841718; x=1788446518;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HyK7kjf3mdb0HwxJC23v1DrXuB5Q8AzL+hKVFbHrxS4=;
        b=es0S6QhEUQeYxystfyyfrH1okgrZjUmWH5tG6eEk0parbATqFY1dI60DgEwpZnQ2+I
         rBF2yGcKpsIVvjLLxnDFdvKOrGJLp7MaGtj1UPIWmkEF06EkhALOIOdI0WL4Dakp+7Gk
         ChI2ygn2/v90XKd/mzWyiLnML/FoHlbqji3gJODXcNpbotCcw32o1VRdUBSPZSac0jRz
         R0j0tiSuCaUM13lrg82f4i21UT39hQ4qN+J2/vZeGZn8tA/hHLvH0Du2E1K3ONgFCLnV
         3idhaHZ1X0D79duW6Kb96xjxGpHMYwOnowVsj1/vaUb/nxOUsnFYcwk2ybFFn8HjdHDY
         mUaw==
X-Gm-Message-State: AFuF++nRz4Tq7SWWzaCsEmW8diPFt9n4RYOqoZZ7dv4X6UP9DMh1+4iC
	yZTSDIRmUeFGybftTfqciaNp/LnffJnI5XowDkUuamIxl8EZ1X0TIppVI1lXBw==
X-Gm-Gg: AR+sD13EJl1j9UHDGvyR0QasRpn0TIN0EO4VWHzxNa+pL9AAmpXPpfIeRaAIYJa3UTC
	PVEiJTCnkBQJ+Q/bK6SzomSCNQuVioFaapi67pJckDASnMRc4gAQSqWRTttZXpP7bmLNzfZaZHy
	p4PaxDJONeTH0s0g4mGh4DMFpegD1qEr/v3lBdkmB/BzYvNN3Jcs45fBBa3++3EBJ7EpKHgYWdk
	fVR1E1P8VOi2NxvKozkIUoGNdlabAKbcBEpXnJJl9YMubuoXaIXph1aN3JYEZ3RP0gfHg5ApzDb
	9qZJeTZBrKxdKBJtsRG++rYBIx+7qkvU5IMjeL6v0eUkZ/zEUEOixbAppp7rsyQOAWViG7EEPEe
	uD+B6RG5OJ1goSjMkS1n9SW/XDYnKfDnoWq1OJOkEI0yU1dnrXY5PlJc1Pj5PkDssK4Zt6q0jEa
	ogJfl+oI0pf/TqY8dnDnNsM6o5/5VNSVar10XXNMqdfq1in4aB8sGcNdtYVy+sTIDtrN3PUdYiy
	Q4=
X-Received: by 2002:a05:620a:1352:b0:938:fdde:b578 with SMTP id af79cd13be357-938fdded9d3mr762474985a.6.1787841718305;
        Thu, 27 Aug 2026 07:41:58 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377f0ab844sm445785285a.45.2026.08.27.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:41:57 -0700 (PDT)
Message-Id: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 14:41:53 +0000
Subject: [PATCH v10 0/4] worktree add: improve message for ambiguous remote branch name
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

We also fix the behavior of --guess-remote when there are multiple matches.

Changes from the previous patch:

 * [1/4] fix the function name and add detailed commit message
 * [2/4] change type of tracking_name_data.remote_names

Yoichi NAKAYAMA (4):
  checkout: extract function to display advice for ambiguous remotes
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name
  worktree add: treat multiple matches with --guess-remote as an error

 Documentation/config/worktree.adoc |  5 +-
 Documentation/git-worktree.adoc    |  4 +-
 builtin/checkout.c                 | 76 ++++++++++++++++++------------
 builtin/worktree.c                 | 57 +++++++++++++++++++---
 checkout.c                         | 13 ++++-
 checkout.h                         |  5 +-
 t/t2400-worktree-add.sh            | 17 ++++++-
 7 files changed, 133 insertions(+), 44 deletions(-)


base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v9:

 1:  e3f7d88520 ! 1:  7650c38d6b checkout: extract function to display advice for ambiguous remotes
     @@ Metadata
       ## Commit message ##
          checkout: extract function to display advice for ambiguous remotes
      
     +    Fix incorrect indentation and reduce nesting. We are going to extend
     +    this function in subsequent commits.
     +
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## builtin/checkout.c ##
     @@ builtin/checkout.c: enum checkout_command {
       	CHECKOUT_RESTORE = 3,
       };
       
     -+static void advice_disambiguating_remotes(enum checkout_command which_command)
     ++static void advise_disambiguating_remotes(enum checkout_command which_command)
      +{
      +	const char *cmdname;
      +
     @@ builtin/checkout.c: enum checkout_command {
      +		cmdname = "switch";
      +		break;
      +	default:
     -+		BUG("command <%d> should not reach parse_remote_branch",
     ++		BUG("command <%d> should not reach advise_disambiguating_remotes",
      +		    which_command);
      +		break;
      +	}
     @@ builtin/checkout.c: static char *parse_remote_branch(const char *arg,
      -	    die(_("'%s' matched multiple (%d) remote tracking branches"),
      -		arg, num_matches);
      +		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     -+			advice_disambiguating_remotes(which_command);
     ++			advise_disambiguating_remotes(which_command);
      +
      +		die(_("'%s' matched multiple (%d) remote tracking branches"),
      +		    arg, num_matches);
 2:  89c0f4d303 ! 2:  c37c9c237a checkout: improve message for ambiguous remote branch name
     @@ builtin/checkout.c: enum checkout_command {
       	CHECKOUT_RESTORE = 3,
       };
       
     --static void advice_disambiguating_remotes(enum checkout_command which_command)
     +-static void advise_disambiguating_remotes(enum checkout_command which_command)
      +static void advise_disambiguating_remotes(enum checkout_command which_command,
      +					  const char *branch,
      +					  const struct string_list *matched_remote_names)
     @@ builtin/checkout.c: enum checkout_command {
       
       	switch (which_command) {
       	case CHECKOUT_CHECKOUT:
     -@@ builtin/checkout.c: static void advice_disambiguating_remotes(enum checkout_command which_command)
     +@@ builtin/checkout.c: static void advise_disambiguating_remotes(enum checkout_command which_command)
       		break;
       	}
       
     @@ builtin/checkout.c: static char *parse_remote_branch(const char *arg,
       
       	if (!remote && num_matches > 1) {
       		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     --			advice_disambiguating_remotes(which_command);
     +-			advise_disambiguating_remotes(which_command);
      -
      +			advise_disambiguating_remotes(which_command, arg,
      +						      &matched_remote_names);
     @@ checkout.c: struct tracking_name_data {
       	const char *default_remote;
       	char *default_dst_ref;
       	struct object_id *default_dst_oid;
     -+	struct string_list **remote_names;
     ++	struct string_list *remote_names;
       };
       
       #define TRACKING_NAME_DATA_INIT { 0 }
     @@ checkout.c: static int check_tracking_name(struct remote *remote, void *cb_data)
       		cb->default_dst_oid = dst;
       	}
      +	if (cb->remote_names)
     -+		string_list_append(*cb->remote_names, remote->name);
     ++		string_list_append(cb->remote_names, remote->name);
       	if (cb->dst_ref) {
       		free(query.dst);
       		return 0;
     @@ checkout.c: static int check_tracking_name(struct remote *remote, void *cb_data)
       		cb_data.default_remote = default_remote;
       	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
       	cb_data.dst_oid = oid;
     -+	if (dwim_remote_names)
     -+		cb_data.remote_names = &dwim_remote_names;
     ++	cb_data.remote_names = dwim_remote_names;
       	for_each_remote(check_tracking_name, &cb_data);
       	if (dwim_remotes_matched)
       		*dwim_remotes_matched = cb_data.num_matches;
 3:  1010ac3295 = 3:  35814b47a4 worktree add: improve message for ambiguous remote branch name
 4:  edb88b658a = 4:  407c53b33c worktree add: treat multiple matches with --guess-remote as an error

-- 
gitgitgadget
