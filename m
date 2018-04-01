Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2421F404
	for <e@80x24.org>; Sun,  1 Apr 2018 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDANIN (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 09:08:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDANIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 09:08:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id x82so23046364wmg.1
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+MlbQEFlvXbKu89OxeRa0ZG/w3OZxPuLKmhYmSiPFw=;
        b=a7wAl+C88MPfvkXPs1QTWztOOe6SYaXQadxPfBGEf5DckcRkV36P72wz9HBnY/j9/k
         90pNvn0Alm4XiOIujzKKbsLyYfLgII40YaeWT0mDDiosJwElq3GB0FG7mTqql20RMXbm
         7NruITPEygjHwKGTTwlMzgtG8ToCxWSqQ0vPybKgiMLXfz1aqKf+B7Gt3DaNeccyjutk
         +3zvTI/jH3BG+vkzEKMWN2lJVvbeHRIF04djVIMaRHxdmCCELQFkmr2emLD0JUyR99pE
         SmDF1G3YyeUqr4QF8XaP+4JyBT156ealDDNpejt/6lZy7md8AsvxIv7SyOFHZOxPCHBV
         PCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+MlbQEFlvXbKu89OxeRa0ZG/w3OZxPuLKmhYmSiPFw=;
        b=OetIRvarM09n9y2JjRi5k1cWbAl9BpS6NXZ43mjBanaA6JYscZFGBRN3On0ujkkL8G
         JX00lQ8a1YziXauzpsKVQ7XonES7Hoba030BWSFblwDsMseu0AgMfimvaXi0vFoD8yOL
         gl/qczSbbBQpDKyOms7kjaEsIdJT60n+xz+m1TIPCMDaaRVCWdMjBSnJtWyT33SLjWG7
         Ew4KL9MlgPCKniXaEePOp2SLFDtdFSRQ6qD4FjfNysGmXRAfF2dnNgzPsDoclTQ+C7hL
         Xguu5O+y8ps/6dph7E//MaPpnS/T2Nc8IGu/W0gvcwW5k1cqU5Go0nrND0BoOx27Tf5o
         606A==
X-Gm-Message-State: AElRT7Gn7kwQ/Lvv8L0R5dQ6SGRhWcZ1ZraD7gcROJFwz5SNL7ZIEbxt
        39FONzr61V9vykqX8aCbC39OI+uj
X-Google-Smtp-Source: AIpwx4/aJtcHXr6cVg0N28IO/xwxA9obhsPUuZvu0wR9X+IcVDmPkDh5U3N/68BwYophJuAc04h/1Q==
X-Received: by 10.28.184.21 with SMTP id i21mr7148602wmf.94.1522588090598;
        Sun, 01 Apr 2018 06:08:10 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p14sm28780456wrc.30.2018.04.01.06.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 06:08:09 -0700 (PDT)
Date:   Sun, 1 Apr 2018 14:11:38 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 6.5/6] fixup! worktree: teach "add" to check out existing
 branches
Message-ID: <20180401131138.GE2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331151804.30380-7-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

So while playing with it a bit more I found one case where the new UI
is not ideal and a bit confusing.  Namely when the new check out dwim
kicks in, but there is already a file/directory at the path we're
giving to 'git worktree add'.

In that case something like the following would be printed:

    $ g worktree add ../next
    Checking out branch 'next'
    fatal: '../next' already exists

Instead I think we'd just want the error without the "Checking out
branch" message, which is what this fixup here does.

One thing that gets a bit strange is that the "Checking out branch"
message and the "Creating branch" messages are printed from different
places.  But without doing quite some refactoring I don't think
there's a good way to do that, and I think having the UI do the right
thing is more important.

One thing I also noticed is that if a branch is created by 'git
worktree add', but we fail, we never clean up that branch again, which
I'm not sure is ideal.  As a pre-existing problem I'd like to keep
fixing that out of the scope of this series though (at least after
this series the user would get some output showing that this happened,
even when the branch is not set up to track a remote), so I'd like to
keep fixing that out of the scope of this series.

Junio: could you please squash this in in 6/6 while queuing?  I'd
prefer not to re-send the whole series just for fixing this up, but
obviously can if that makes your life easier :)

Thanks!

 builtin/worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 511d0aa370..ccc2e63e0f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,6 +27,7 @@ struct add_opts {
 	int detach;
 	int checkout;
 	int keep_locked;
+	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -316,6 +317,8 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	if (opts->checkout_existing_branch)
+		  fprintf_ln(stderr, _("Checking out branch '%s'"), refname);
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
@@ -397,7 +400,6 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
-	int checkout_existing_branch = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &new_branch, N_("branch"),
@@ -443,7 +445,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	if (ac < 2 && !new_branch && !opts.detach) {
 		const char *s = dwim_branch(path, &new_branch,
-					    &checkout_existing_branch);
+					    &opts.checkout_existing_branch);
 		if (s)
 			branch = s;
 	}
@@ -478,8 +480,6 @@ static int add(int ac, const char **av, const char *prefix)
 		if (run_command(&cp))
 			return -1;
 		branch = new_branch;
-	} else if (checkout_existing_branch) {
-		  fprintf_ln(stderr, _("Checking out branch '%s'"), branch);
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
-- 
2.16.1.78.g71f731ae26.dirty

