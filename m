Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D4120248
	for <e@80x24.org>; Sun,  7 Apr 2019 10:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfDGKTp (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 06:19:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34982 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfDGKTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 06:19:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so5603511pgf.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsfkry5OoTB5RsFg2h6NsRNSLaA/XW+zTOCJMf8mtJM=;
        b=YsFsMFOIvX7msRbg2CiAyhi2VpCbnzGo4iEgBuv2/FovuP6oPGje0NlAIRidjys5tv
         oGj05Or5nUJeAcVddz2cjoEd++UizwozVQzXey1UUGz2JCcdST63q2kolQLKQlVk6WO4
         Rl+plwNnJodRq6ML1qkHpCwJBaS/4aH1mXnT0jzHXmLv8f2UyImeSQYwDC7bBzlf4C5O
         QT/TSZfzfwLS3pn29w49PHjj2B8cgBMv3tp+ovvRyZV26rOMVn2s6euKDlBJCpB8Rx+R
         hX6n2VyhQV3PM0fIGRcgpBTdmVZwcHOLj59GY5HKtHnCTu8m3AGbJ5snVbUgEUseLVAJ
         Rn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsfkry5OoTB5RsFg2h6NsRNSLaA/XW+zTOCJMf8mtJM=;
        b=rMnImYNya+biTcTR/AWvv5zdXR57JMoiFt31phBX7YidDIl67DNHuImaxNUOO9TfzI
         KqdNkYMJ2AvslLOFZ7NkLGhzxBuLU1OxlQurqllvBKpfEstlyp6DkTDsEY2nua+x0YvR
         bzIwXlj9RyvCSwelIYJA7VOczzqLtdX858ue3nLbnmnqPU3HTCZF7UhczcoXZe83nMhY
         uSG1Mhe/DVrnLXYHXtcj0XCju/ulRHosAd8iTli233wDLo3pidQ1rA+mfbdwlPxOKNO+
         YT1OnDzrZsi9N88ovLGlKNdmTy983mFDTo1RYVpAZfOCp0zfXy6zi8HCArPe9uslpBS0
         ygRQ==
X-Gm-Message-State: APjAAAV08GBjH0GYSsif2cCPP2LvYbUCIkIqIOPXDaqaDM5G+2PcF3Ok
        E/Ft7gnP6lWtH87zzY5jR9c=
X-Google-Smtp-Source: APXvYqysWBNuSFoiL3gaPGKTzd+shvzw1qsUIxH4n0NAFED8AdOnjoaykDa5nuNwYumFDMPLPuPvPw==
X-Received: by 2002:a65:625a:: with SMTP id q26mr22600282pgv.68.1554632384099;
        Sun, 07 Apr 2019 03:19:44 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id x8sm17984991pgp.48.2019.04.07.03.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 03:19:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 07 Apr 2019 17:19:38 +0700
Date:   Sun, 7 Apr 2019 17:19:38 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com
Subject: Re: [PATCH][RFC] read-cache: read_index_from() accepts repo as arg
Message-ID: <20190407101938.GA24126@ash>
References: <20190407073712.1642-1-jkapil.cs@gmail.com>
 <20190407100010.GA23427@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407100010.GA23427@ash>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 07, 2019 at 05:00:11PM +0700, Duy Nguyen wrote:
> So, with something like a patch below (not tested), you should be able
> to write
> 
> 	worktrees = repo_get_worktrees(revs->repo, 0);
> 	...
> 		struct repository *r = repo_worktree_init(wt);
> 		if (read_index_from(&istate, r->index_file, r) > 0)
> 			do_add_index_objects_to_pending(revs, &istate, flags);
> 		repo_clear(r);

Actually it gets better. You can just use repo_read_index()

diff --git a/revision.c b/revision.c
index eb8e51bc63..93fe8bbbfe 100644
--- a/revision.c
+++ b/revision.c
@@ -1546,19 +1546,18 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	if (revs->single_worktree)
 		return;
 
-	worktrees = get_worktrees(0);
+	worktrees = repo_get_worktrees(revs->repo);
 	for (p = worktrees; *p; p++) {
+		struct repository repo;
 		struct worktree *wt = *p;
-		struct index_state istate = { NULL };
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
 
-		if (read_index_from(&istate,
-				    worktree_git_path(wt, "index"),
-				    get_worktree_git_dir(wt)) > 0)
-			do_add_index_objects_to_pending(revs, &istate, flags);
-		discard_index(&istate);
+		repo_worktree_init(repo, revs->repo, wt);
+		if (repo_read_index(repo) > 0)
+			do_add_index_objects_to_pending(revs, repo->index, flags);
+		repo_clear(&repo);
 	}
 	free_worktrees(worktrees);
 }
--
Duy
