Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26321F424
	for <e@80x24.org>; Tue, 24 Apr 2018 04:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDXEZS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 00:25:18 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34695 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeDXEZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 00:25:17 -0400
Received: by mail-io0-f194.google.com with SMTP id d6-v6so21143081iog.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 21:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jyo3YoS3hUkmBCHwEv69uihQZ+4NA3e+Yh19SjK1QiY=;
        b=MiED61+iG94S8mtEjyeXJgyDVwvZCNMaP4Ap4BVJQbhoesgnxL+NkfGlW4npH3LCVt
         7clKLjtob2GCujfeHLALeehXXxKiNYU9VsqqkLsVLZ2tsftjbxM4Xp1AIFO8iXG8X+Hg
         PSC1NvW4mq41GA6rrL5JVE2L+RbtVKW2xwD/fyygjyZlHvDoWZB5mS2v0dfxdXIsnRxQ
         0U6uuTV9ryRmsb8eVH0pz6pGSwHYjIPCitGrAOfZrC3lsmuNCaCp2kjKWSHM+Rybsc9i
         57vKmrpWbr82zS1JyI0B7n6sBdku4g8UiRRa1xb/UKHv+t9ZSZHw+dU3N+9RPdzSxCQS
         O5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyo3YoS3hUkmBCHwEv69uihQZ+4NA3e+Yh19SjK1QiY=;
        b=Z9MzKt72Mrqm60ra4On9hn8J9kU25ElcF4UgYjNEFnC8zM6qQcLGC5j5tsRn4UiCON
         KJlDhBR7sh8B648VE7M57tfTs0Y+Pfqw6R1AMJzUZPf5uOCWfDxeIE+/xgDCZ+rdtrIT
         d/8056HMv1UcnA0jl+SxVapU5dJBUrOQttmZQsxyjlBVXb2z56KnyAXWfkpmE+bql+sO
         P10Gpq9JGRznKi9Yj8jLVF0UQNaA6Gz9+Bc3Fml6G9/m9+lgwq8MjaKxqdOkQv+zQl0L
         FCYCw3JebQCXfZlZ3LcKTXU+sTX1Cuk+y50gdsIhZBM57BMXQHwKgeb5EGy5ItTpy9eV
         9LkQ==
X-Gm-Message-State: ALQs6tAJUwj4nRvzFB8Y/OEvFLrftuAN7x/wRgZ4RH1zOvkMWVo7tLDi
        OTuEkAzvkHFZPVCgbDqynq8=
X-Google-Smtp-Source: AB8JxZprcdqA/TfNLfOL1p8AKbybIW8yk6fEGB4aWfq7zxDBXp8XItWGAc1aUzIX2NBybqI66KG36A==
X-Received: by 2002:a6b:f207:: with SMTP id q7-v6mr24221493ioh.297.1524543916531;
        Mon, 23 Apr 2018 21:25:16 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id a188-v6sm4768837itg.21.2018.04.23.21.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 21:25:15 -0700 (PDT)
Date:   Tue, 24 Apr 2018 00:25:10 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] worktree: teach "add" to check out existing
 branches
Message-ID: <20180424042510.GA8431@flurp.local>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180423193848.5159-5-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423193848.5159-5-t.gummerer@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 3:38 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the path by default.  If a branch with that name already
> exists, the command refuses to do anything, unless the '--force' option
> is given.
>
> However we can do a little better than that, and check the branch out if
> it is not checked out anywhere else.  This will help users who just want
> to check an existing branch out into a new worktree, and save a few
> keystrokes.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -356,9 +356,12 @@ static int add_worktree(const char *path, const char *refname,
>  static void print_preparing_worktree_line(int detach,
>                                           const char *branch,
>                                           const char *new_branch,
> -                                         const char *new_branch_force)
> +                                         const char *new_branch_force,
> +                                         int checkout_existing_branch)
>  {
> -       if (new_branch_force) {
> +       if (checkout_existing_branch) {
> +               printf_ln(_("Preparing worktree (checking out '%s')"), branch);

Is the new 'checkout_existing_branch' argument and this new
conditional really needed? Both 'new_branch' and 'new_branch_force'
will be NULL in the case of an existing branch, so there should be no
need for 'checkout_existing_branch' to state explicitly what is
already indicated by their NULLness. With both of them NULL, the
existing "(checking out '...')" message later in the function will
kick in, so this new condition isn't needed.

> +       } else if (new_branch_force) {
> @@ -387,11 +390,23 @@ static void print_preparing_worktree_line(int detach,
> +static const char *dwim_branch(const char *path, const char **new_branch,
> +                              int *checkout_existing_branch)
>  {
>         int n;
>         const char *s = worktree_basename(path, &n);
> -       *new_branch = xstrndup(s, n);
> +       const char *branchname = xstrndup(s, n);
> +       struct strbuf ref = STRBUF_INIT;
> +
> +       if (!strbuf_check_branch_ref(&ref, branchname) &&
> +           ref_exists(ref.buf)) {
> +               *checkout_existing_branch = 1;

See above regarding apparent lack of need for this new variable.

> +               strbuf_release(&ref);
> +               UNLEAK(branchname);
> +               return branchname;
> +       }

Taking the above observation into account, I applied, atop this patch,
the following fixup! which removes the 'checkout_existing_branch'
gunk and still get the same output:

--- >8 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -356,12 +356,9 @@ static int add_worktree(const char *path, const char *refname,
 static void print_preparing_worktree_line(int detach,
 					  const char *branch,
 					  const char *new_branch,
-					  const char *new_branch_force,
-					  int checkout_existing_branch)
+					  const char *new_branch_force)
 {
-	if (checkout_existing_branch) {
-		printf_ln(_("Preparing worktree (checking out '%s')"), branch);
-	} else if (new_branch_force) {
+	if (new_branch_force) {
 		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
 		if (!commit)
 			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
@@ -390,8 +387,7 @@ static void print_preparing_worktree_line(int detach,
 	}
 }
 
-static const char *dwim_branch(const char *path, const char **new_branch,
-			       int *checkout_existing_branch)
+static const char *dwim_branch(const char *path, const char **new_branch)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
@@ -400,7 +396,6 @@ static const char *dwim_branch(const char *path, const char **new_branch,
 
 	if (!strbuf_check_branch_ref(&ref, branchname) &&
 	    ref_exists(ref.buf)) {
-		*checkout_existing_branch = 1;
 		strbuf_release(&ref);
 		UNLEAK(branchname);
 		return branchname;
@@ -421,7 +416,6 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	char *path;
-	int checkout_existing_branch = 0;
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
@@ -469,8 +463,7 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		const char *s = dwim_branch(path, &new_branch,
-					    &checkout_existing_branch);
+		const char *s = dwim_branch(path, &new_branch);
 		if (s)
 			branch = s;
 	}
@@ -490,8 +483,7 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force,
-				      checkout_existing_branch);
+	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force);
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
--- >8 ---
