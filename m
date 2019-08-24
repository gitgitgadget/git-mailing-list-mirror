Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9131F4B7
	for <e@80x24.org>; Sat, 24 Aug 2019 09:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfHXJEw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 05:04:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43438 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfHXJEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 05:04:52 -0400
Received: by mail-io1-f65.google.com with SMTP id 18so25700028ioe.10
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qjm5nI779iRcTNELSAM5LUevFq2bekvh4uXnF6z2Gm8=;
        b=uoAPkowWjGDD0n7Z8zaM1Gi/ZAka1nH+q60HeR/qD1eWjWySb/0S8LQ3w5DgEPfJF2
         i5l+E4ixJivbp9wTIYpp8hjg8fyroPZuc5n8AwSwcqj04QrfsA51nuvn+3wUDY1O0xK5
         3WyypInNiSorQd2d0jwEmU/IYz0uJ0YTBEs4gyhxRWIX0GM1CspvD9xR1R7tfcVUs3bQ
         4Pe9uWRP8/GiQzHOU0q7XsGSEl/Se3dEUZbjIueQbpe8+nUtZnOsSNebAHOoTUW7mloZ
         dgaCQ2eq70gbNAGS4YSMIpS5uit9H32TQNVeu+WNEERuw9pvJIRKZE+4d/zWVljd2Ho9
         Epxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjm5nI779iRcTNELSAM5LUevFq2bekvh4uXnF6z2Gm8=;
        b=bZJxIoTg3OV20mT8tZ0B0+smUacmF9O4umryoSyCHuRDkrQbyEbMDd9pYOXurRR1Gj
         RT3WVTl4QgvB8G8qRb/yKWVBV1aVI0EBj5iBjC24XLDL6a7sKqP0IsUQWvuz7wBBgUbN
         dRnwKQE+L9a8KwbnhFVs34s1YYr1QjL2TWqYRuDQlr3HH4/P84MJtiQ5xkDEL346IRrr
         oSDinBy14jsHRwtGJ97s0lSm53UGZt3TBcXftdZ+mhigzPXHVZ24inAyUPQUAUzAfZUA
         76xFegWU7f/EE2VsyzlZ7Lcs+76Nk1GR9p5Gz48LdyhFjg5rkGEkha76V2Ly57QT9GNv
         +uXQ==
X-Gm-Message-State: APjAAAUkFMBBZPU6tZft/pHGzrgkSM57EHZJnKom7d07OstFY3EqP2UM
        zs1D6lRJTqIe1DsSSnjt+aCHDD/U
X-Google-Smtp-Source: APXvYqwdH85BP8cHcMAG6DbIJUJQL0nBAa7xaG3W3aHFGRobSunZ1P7J19nMLV7n/tfU8L3xgPQ6Xw==
X-Received: by 2002:a5d:9487:: with SMTP id v7mr10976960ioj.230.1566637491224;
        Sat, 24 Aug 2019 02:04:51 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y19sm4859212ioj.62.2019.08.24.02.04.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 02:04:50 -0700 (PDT)
Date:   Sat, 24 Aug 2019 05:04:49 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] completion: merge options for cherry-pick and revert
Message-ID: <cdcac975548502a58234f7537a5fe11dcdb538ea.1566637431.git.liu.denton@gmail.com>
References: <cover.1566637431.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566637431.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since revert and cherry-pick share the same sequencer code, they should
both accept the same command-line options. Merge the
`__git_cherry_pick_inprogress_options` and
`__git_revert_inprogress_options` variables together into
`__git_cherry_pick_revert_inprogress_options` so that the options aren't
unnecessarily duplicated twice.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e087c4bf00..62f8ef600d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1361,13 +1361,13 @@ _git_checkout ()
 	esac
 }
 
-__git_cherry_pick_inprogress_options="--continue --quit --abort"
+__git_cherry_pick_revert_inprogress_options="--continue --quit --abort"
 
 _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "$__git_cherry_pick_inprogress_options"
+		__gitcomp "$__git_cherry_pick_revert_inprogress_options"
 		return
 	fi
 
@@ -1376,7 +1376,7 @@ _git_cherry_pick ()
 	case "$cur" in
 	--*)
 		__gitcomp_builtin cherry-pick "" \
-			"$__git_cherry_pick_inprogress_options"
+			"$__git_cherry_pick_revert_inprogress_options"
 		;;
 	*)
 		__git_complete_refs
@@ -2512,20 +2512,18 @@ _git_restore ()
 	esac
 }
 
-__git_revert_inprogress_options="--continue --quit --abort"
-
 _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "$__git_revert_inprogress_options"
+		__gitcomp "$__git_cherry_pick_revert_inprogress_options"
 		return
 	fi
 	__git_complete_strategy && return
 	case "$cur" in
 	--*)
 		__gitcomp_builtin revert "" \
-			"$__git_revert_inprogress_options"
+			"$__git_cherry_pick_revert_inprogress_options"
 		return
 		;;
 	esac
-- 
2.23.0.248.g3a9dd8fb08

