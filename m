Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9444A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbeDQV37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:29:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36075 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeDQV35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:29:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id q13so35912050wre.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ho45byr4QbAzVc+Qw6795DMpHVb+xi+NjXegct4jXqM=;
        b=Aq+9oQ9W2yPlll1q/7Dp+UaALJCeztMaJzVw3hK2A40f3WICfuvCvSHLHd5/Kds0Aw
         Q4+HIy/gvzhOP1mF7ThDIH6+R8PQO7h7vjCDa6Zss0rGJ7Hy++/BuMiOkd5QnfBXETJ2
         WfogF4g9qbiPOwGll0bvxEh41+ZU/mx7wt+jgPuYhekwDYfXKRxtZ1hEpowHo+r/ATSS
         CWpXM9m6WoNUmolKH/0Z4RlfbHwvcNJuUBuEC/CtjHm7inHPMWnyV+i931JFU0u9TlR0
         lpGvOgK05Ykn3sSMU/Vz+Lx17cQR/3gv0AXybYTJ1ESe1u1Uooh8ctexypYxXlewCAFk
         MNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ho45byr4QbAzVc+Qw6795DMpHVb+xi+NjXegct4jXqM=;
        b=OMaP8bNWj/XDEvGKZFHK+8tcbZLgoDbffONKmUeZ3q3lDDDrcQxp95Dxac2uKyEGQs
         PNZJC2Nk1f2qkmTUn4h1YOmdj6r6x423DUNVi8I5tmYUeMl8PPKkV1rsMI8+UsVrLGoK
         lUF7gmcVMEL2MOd0zJxSOJ1Bw+r019ux52mR19I77S1NdZd6k4Umozcz348pahNZAfJ0
         gRSCtmJqeaYwkP+ZKA9bMvqaXg+pQf62Sx3N9yl61uTO+rFukGY6clgEPdKicN8a8Cvp
         hSf5+cm1fLo4wkAsaPkUdg32frlDHP0KAdojLU5zss7h2xSpa7LuTBX+IB1dSe/2D4DK
         t54w==
X-Gm-Message-State: ALQs6tDut71jixhHUqGgK6EFsEzbpT4DRlun4AZ32FVz12g7uI0b4syK
        VmBw820X/B/TUR+rpBL20KXeik/U
X-Google-Smtp-Source: AIpwx4/1ugrSBTdyUJhFQgoZbbxlkqnTYg3U3QfQGve+wAjibhBu2GVztINWCF9tN9t2B/Ps8XjeGQ==
X-Received: by 10.28.9.81 with SMTP id 78mr2224542wmj.52.1524000595836;
        Tue, 17 Apr 2018 14:29:55 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r8sm16599975wmg.44.2018.04.17.14.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:29:55 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] completion: rename save_opts to default_opts for stash
Date:   Tue, 17 Apr 2018 22:29:43 +0100
Message-Id: <20180417212945.24002-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180417212945.24002-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git stash save' is deprecated, but we still call the options for
completion 'save_opts'.  Simply renaming them to 'push_opts' is not
ideal because for example '--message foo' can't be passed directly to
'git stash', as non-option arguments are not allowed, and foo would be
treated as one.

Completing '--message' in 'git stash --<tab>' would end up being quite
confusing for the user.  Therefore name them 'default_opts', and keep
treating --message specially for 'git stash push'.

The ulterior motive for renaming 'save_opts' is that in the next
commit we're going to stop completing 'git stash save', so 'save_opts'
would be the only remaining thing referring to 'git stash save', which
would probably be confusing for future readers of this code.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..39c123926c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2773,16 +2773,16 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
+	local default_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "$save_opts"
+			__gitcomp "$default_opts"
 			;;
 		*)
-			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
+			if [ -z "$(__git_find_on_cmdline "$default_opts")" ]; then
 				__gitcomp "$subcommands"
 			fi
 			;;
@@ -2790,10 +2790,10 @@ _git_stash ()
 	else
 		case "$subcommand,$cur" in
 		push,--*)
-			__gitcomp "$save_opts --message"
+			__gitcomp "$default_opts --message"
 			;;
 		save,--*)
-			__gitcomp "$save_opts"
+			__gitcomp "$default_opts"
 			;;
 		apply,--*|pop,--*)
 			__gitcomp "--index --quiet"
-- 
2.17.0.252.gfe0a9eaf31

