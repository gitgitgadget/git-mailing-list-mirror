Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0A01F404
	for <e@80x24.org>; Thu, 19 Apr 2018 23:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeDSXZY (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 19:25:24 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46615 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbeDSXZU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 19:25:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id d1-v6so18203422wrj.13
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RPNBI6vCpCusR2o0k1Yurfj87bW0Tc3uNxWDMs/Kwg=;
        b=Qk38sbwPkIJNeG2pHDSQi/fWcSaHgxelN1/GoYCDZDZoGpUr2JGQ+V8tA2wIFdJ4b6
         FYNCsxvam/eIZhMYVyPXehj/nMfPpvTOVgKafDFbmdalxsE8FMqKuYYsW+2+9OrR47JI
         UraAFdicPHmd297dsYDOXjzP4qeYfTY55ii/sg3bi7FyNjJNsUUWyRgW9Q8C49y5U4AP
         nKLoPJRWCCauB9DhKJF57qHhVtxjJAsCfOCW7Yg91B/XvjKTxrOtG5Oa4EGEgpwkJzeQ
         su4pS2RxQcEopVugE0YaiN6/gA5lj8t06n5bhqp5WJPaq47SBrPg9JctbtbLs5osXtcv
         b2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RPNBI6vCpCusR2o0k1Yurfj87bW0Tc3uNxWDMs/Kwg=;
        b=k7hFAfpGLHeQ4oKmw9NMMylB8sTilrHwb12adzWs2u43m4EmpMoiRv7IeAe2MQkgAH
         YwaQYfAjHdvxvofDM4DkJ3OpeR3fKJ1p1a5TcvdV4NhRnfkMgEAM5YTR8HujTiJaee69
         32yO7VWzrb5NPoq1UraFXpRLaZVdu4870KwSHvp0etmG2vm/n5JmzPmfD2csDP75H7Ym
         jURvVE2dY1EmMvH/rh8iai0Us0uq9D60C9VLWkDsmiCZHoUHvUeX2jzg8ix273to3QV5
         hvwc3RAs12PHm+2lkW3995brxfCgoPc2miOfYBfnoaI95F0u2Nx56DlkPlk7rM3QhDxq
         GShg==
X-Gm-Message-State: ALQs6tD4akXkVu0n8eocN8LoaaXx4WVxg+zouaC7yVGvlQ8+v2yQLf0A
        SPL2NxyOOZoTaVEtWDHtjG0Iwiji
X-Google-Smtp-Source: AIpwx4+HC/p1VEKqdLI0s9ctJ+z1po0g9zImLJ4+1HlumTykUu2DVZMk21VzFxscmEBTA13GRFvyVw==
X-Received: by 2002:adf:b067:: with SMTP id g36-v6mr6334258wra.128.1524180318837;
        Thu, 19 Apr 2018 16:25:18 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b18-v6sm1815445wrb.55.2018.04.19.16.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 16:25:18 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] completion: make stash -p and alias for stash push -p
Date:   Fri, 20 Apr 2018 00:25:14 +0100
Message-Id: <20180419232514.16572-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180419232514.16572-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
 <20180419232514.16572-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We define 'git stash -p' as an alias for 'git stash push -p' in the
manpage.  Do the same in the completion script, so all options that
can be given to 'git stash push' are being completed when the user is
using 'git stash -p --<tab>'.  Currently the only additional option
the user will get is '--message', but there may be more in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9a95b3b7b1..adb6516b6d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2776,6 +2776,9 @@ _git_stash ()
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	if [ -n "$(__git_find_on_cmdline "-p")" ]; then
+		subcommand="push"
+	fi
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-- 
2.17.0.252.gfe0a9eaf31

