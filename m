Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679131F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeFQF7H (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37217 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeFQF7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so12207293oib.4
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HgBTT9gguC4iDl/55ulJx9JuzObpN50XxIfoTk0OamE=;
        b=monKeI0uWLZD2sqx0afbLmql20SdeC6a8a9o7WdX6+1MPKTDbx1S0ixyrYNwe862ET
         cG7ixxvWUQaOPSPTKaptFoFF3o7MpYMT8+AJmuzI7dC6T0oHt/iaIUn0LMpVb3NBvj4t
         xmVB06IyblECJRnvgxjbWfNUhboZCyQzMfme7VfOmX/5zqBn/vBCpC3bvEbpfYGxwPTn
         sy30HzmaRz3pARlEVxVdaXX5ZwYHe1mHG83/p7lNna3uNWCmbmpQii3AC7DbAdBBv2eM
         /2rQP/7q+8awAyYL4boK/DkSfriNiA99cYMStz43b/bmY5I6n4J2d4zAU5mX1cGjSY+2
         FuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HgBTT9gguC4iDl/55ulJx9JuzObpN50XxIfoTk0OamE=;
        b=hLDBFd0T1k19vs1wKIh5xYWpH4cud00kLFHAppXfOCaJJ1UUnITrpPX0Vsj2icVN8T
         5Kawp7GxnTatPvUe9ShedOzCiT15N6HdxnP4BdgmYMkgvdUzt6m1gbBMAU3gaKUwenfI
         Chjhlg8KH62V4nKBG5W2aEgBmqU9dxYDvNJExZwoPZxigapIweGtS5caTFV3MWwT8e6o
         itjXiP6aYQFo/tqlt3/aHSDe9jGXHMdas6GFGUnrqugpnCxWAiVUgNTWRvbMWvHNtBrB
         Meg6Wgvdo+pGtxn7hszrjnywPX5hRkRABeQeyWFu8S9eyuSB0P47AIkW/n8dbcfhqN6Q
         Cvvw==
X-Gm-Message-State: APt69E1AUO0dOPwgb6PtaUPfwapFxLRZo0y/cDR1vGo+/DXOU3r496sv
        IgL1RhSpwfKsRemcNzk9my26XA==
X-Google-Smtp-Source: ADUXVKIqJ3YFOEMIBQvUsEdrrr0cNF8NbEjLpcq5HoI/oEjW6BAi21JdP/wJlO+QU/f1b7+/tqfZOw==
X-Received: by 2002:aca:ab15:: with SMTP id u21-v6mr4549349oie.272.1529215145695;
        Sat, 16 Jun 2018 22:59:05 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 2/7] git-rebase.sh: update help messages a bit
Date:   Sat, 16 Jun 2018 22:58:51 -0700
Message-Id: <20180617055856.22838-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

signoff is not specific to the am-backend.  Also, re-order a few options
to make like things (e.g. strategy and strategy-option) be near each
other.
---
 git-rebase.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc4..bf71b7fa20 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -20,23 +20,23 @@ onto=!             rebase onto given branch instead of upstream
 r,rebase-merges?   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
+X,strategy-option=! pass the argument through to the merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
+f,force-rebase!    cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
 allow-empty-message allow rebasing commits with empty messages
-f,force-rebase!    force rebase even if branch is up to date
-X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
 n,no-stat!         do not show diffstat of what changed upstream
 verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflicts
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
+signoff            add a Signed-off-by: line to each commit
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
-signoff            passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
-- 
2.18.0.rc2.1.g5453d3f70b.dirty

