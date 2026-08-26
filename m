Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFDD346E44
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741116; cv=none; b=My1A+Ftei+ISdxEkqkLzn/s63x7TVQeus8NqhMCVR0f9YK8y5T4ijHxZNrXL0fP3zul9HvT/dKe0eJplo9WqXUt0Hd2ONDSqizrQft2RK6Q4Zd6zyow+2IVmXFFyB1Jdndqdstj5IGR3kh97QL/yQzY4ikXlvGlrtldZYDguSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741116; c=relaxed/simple;
	bh=Mo6k8k3U7woCE01SUkpdcmyFPllNFVgkiQ2bcpWDkFc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JNBu8ih+XKE1EJ8r7KNSWmrd+rDIprkH9AM623QFh4oz/BJ9Uq1JjqwSAl5K5d9un5mDWHiEMunFeKgIOXz51DosU/HKMmy7YAg2xp6bGp3jv2VjVD3H6uai1ATKgfEFi21UHlhE1e6CHrGptnFpCE7IrVxrXmLdnXbBP+YSJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hby/1qtN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hby/1qtN"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-45eb2e6402aso711132fac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741113; x=1788345913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zZnVAm44NUBPTWrYj5KYLyRgqY75Weygye8GZw6P5ZM=;
        b=hby/1qtN61ctNi3xrjRsDl5Dj9zS7qJD8z2hoTHYgJ8gwvzuqd4nvkQ8Tie5xR9wfQ
         NengRalpZJLzR4AJhQH121dkBXASsTYzA6a4VhqwKd8eTeE04dXbhtzZ48U78TJT5vBd
         S2NtEg9yc5ef90+LXKEVLIizo4D/j6Zo7EJEqWsqHT6ppJb5vWNPb3fJQcVUpPnTsGsH
         648FR7xFAlZfrB7otPV4ryWqquVMXQoLkP5uSutDMGr/NDceJ6wgDsB3vm2Es2h6Mlzj
         A2uPrxz1fvpcpLfuWxgr2YXcSxG5UqmBs9TFfIEp5Vq1AJF+TwOS1p3jSwJITkO78zig
         pFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741113; x=1788345913;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZnVAm44NUBPTWrYj5KYLyRgqY75Weygye8GZw6P5ZM=;
        b=EB8ruf5Hzt/vYX7KR7JvkJTITpSCCNnqTiQknQ62FOw7NtMrt4H3EEiQqi0het+0vP
         3dleUpQqbsBkbP0rxAJsa1V+TxjPrBENBvTCde6pz6zzYiN4w1YBM1lgAdVQ9LvwPg8S
         obqhCUf732lePRuLoyM8DYWYDQIQ+HTjEdOTkOPAtAA2tmQCDzn5h532Z9e5fvq9MjUY
         i6E8gYY7+rvJ0mn7s7jfGxaIjdFXr5K058kTWmyLN9O4dIrz+7WpWPa/NKwlcjN4jtRu
         MWe2YNlkLQeUU05E8w31sy/sNjzid34LVHusNeWUetU3lAJY843m1v3t7idOS1gzv5j7
         mU8Q==
X-Gm-Message-State: AFuF++nXj2dqhkYMXwauNyqjisUMA50vgAMQ619IH9ZUTdKMoD1WrvMK
	A2zOe7tWmbulzMDDEtcBoXTkn6C13BWdkxIj5IJdnLyGIl5zZH0+5vKQUP7310fN
X-Gm-Gg: AR+sD10/v6GyS/Rv9zhvcUB9UlsmE+K1BgUitnPQckdZHm+RBNJqWpcgS6ltbm9nX8P
	3Hto9Y0742Qri1xDRlpD6xm8O24TixISlIQV4fBlZi7JgM8sq6qmTin8+1pC2yM3K9N/H3aukOr
	T7ddw9xpVBZ2kvcnlXGisrv302ptiyJueI2p67btV1OBQMWtI12gPgVmlacIRwIVaxz9fxjqXK6
	s9GNHe6GivlR6Z/LTeMHBTqw/D3Z3yxc5KM5xqJo3ousYk87y6JegI40nJcKOWjmXStHLmNIlqR
	0NEXpH+5JSi9Fzdb/KNDSx6TOMNY9UOpw2E3kG2NA5Hv0jJ8dRWcWiJ3IKrdFtFbMsrUTD7mH7r
	6+BWfBTExGmXA6opsBpIS7OGRc8AZqrsaNfzCANesL1ZWtdt5VCocCb1Gr9OQqZsDGpJzZY135P
	jYVjlYLyn47wTt9IwxC56EC8WfH7XlUIXay3C9j9S72snHhFT5K20leNRLSnhKIYs=
X-Received: by 2002:a05:6820:f02f:b0:6aa:d13c:a709 with SMTP id 006d021491bc7-6b1a051cd62mr4597019eaf.31.1787741113217;
        Wed, 26 Aug 2026 03:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.19.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465afa1f389sm1761485fac.10.2026.08.26.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:45:11 -0700 (PDT)
Message-Id: <pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 10:45:06 +0000
Subject: [PATCH v9 0/4] worktree add: improve message for ambiguous remote branch name
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

 * move advise_disambiguating_remotes() definition upper in the 3rd commit

Yoichi NAKAYAMA (4):
  checkout: extract function to display advice for ambiguous remotes
  checkout: improve message for ambiguous remote branch name
  worktree add: improve message for ambiguous remote branch name
  worktree add: treat multiple matches with --guess-remote as an error

 Documentation/config/worktree.adoc |  5 +-
 Documentation/git-worktree.adoc    |  4 +-
 builtin/checkout.c                 | 76 ++++++++++++++++++------------
 builtin/worktree.c                 | 57 +++++++++++++++++++---
 checkout.c                         | 14 +++++-
 checkout.h                         |  5 +-
 t/t2400-worktree-add.sh            | 17 ++++++-
 7 files changed, 134 insertions(+), 44 deletions(-)


base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v8:

 1:  e3f7d88520 = 1:  e3f7d88520 checkout: extract function to display advice for ambiguous remotes
 2:  89c0f4d303 = 2:  89c0f4d303 checkout: improve message for ambiguous remote branch name
 3:  095a5796d4 ! 3:  1010ac3295 worktree add: improve message for ambiguous remote branch name
     @@ Commit message
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## builtin/worktree.c ##
     -@@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch)
     - 	return NULL;
     +@@ builtin/worktree.c: static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
     + 	return 1;
       }
       
      +static void advise_disambiguating_remotes(const char *path, const char *branch,
     @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
      +	       branch, path, branch);
      +}
      +
     - static int add(int ac, const char **av, const char *prefix,
     - 	       struct repository *repo UNUSED)
     + static char *dwim_branch(const char *path, char **new_branch)
       {
     + 	int n;
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
       		/* DWIM: Infer --orphan when repo has no refs. */
       		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 4:  927856e0a0 ! 4:  edb88b658a worktree add: treat multiple matches with --guess-remote as an error
     @@ Documentation/git-worktree.adoc: To remove a locked worktree, specify `--force`
       `worktree.guessRemote` config option.
      
       ## builtin/worktree.c ##
     -@@ builtin/worktree.c: static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
     - 	return 1;
     +@@ builtin/worktree.c: static void advise_disambiguating_remotes(const char *path, const char *branch,
     + 	       branch, path, branch);
       }
       
      -static char *dwim_branch(const char *path, char **new_branch)
     -+static void advise_disambiguating_remotes(const char *path, const char *branch,
     -+					  const struct string_list *matched_remote_names)
     -+{
     -+	struct string_list_item *item;
     -+
     -+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
     -+	for_each_string_list_item(item, matched_remote_names) {
     -+		advise(_("  %s"), item->string);
     -+	}
     -+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
     -+		 "<remote>, you can do so by:\n"
     -+		 "\n"
     -+		 "    git worktree add -b %s %s <remote>/%s\n"
     -+		 "\n"
     -+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
     -+		 "consider setting checkout.defaultRemote=origin in your config."),
     -+	       branch, path, branch);
     -+}
     -+
      +static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
       {
       	int n;
     @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
       		return remote;
       	}
       	return NULL;
     - }
     - 
     --static void advise_disambiguating_remotes(const char *path, const char *branch,
     --					  const struct string_list *matched_remote_names)
     --{
     --	struct string_list_item *item;
     --
     --	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
     --	for_each_string_list_item(item, matched_remote_names) {
     --		advise(_("  %s"), item->string);
     --	}
     --	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
     --		 "<remote>, you can do so by:\n"
     --		 "\n"
     --		 "    git worktree add -b %s %s <remote>/%s\n"
     --		 "\n"
     --		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
     --		 "consider setting checkout.defaultRemote=origin in your config."),
     --	       branch, path, branch);
     --}
     --
     - static int add(int ac, const char **av, const char *prefix,
     - 	       struct repository *repo UNUSED)
     - {
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
       		opts.orphan = dwim_orphan(&opts, !!opt_track, 0);
       	} else if (ac < 2) {

-- 
gitgitgadget
