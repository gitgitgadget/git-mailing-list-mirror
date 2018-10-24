Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B241F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeJXOYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 10:24:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44710 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXOYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 10:24:53 -0400
Received: by mail-io1-f65.google.com with SMTP id c6-v6so1692464iob.11
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=YkNmMi97CEjJRQYei+9Wf/jTrMHWxOtXQd+PyTrPPhhEstpVOMLUd/dVmbtFmYFk8U
         gCbX1+sFN1DXtGEEpW3g16jVi30fzsjGd1rpzO+RHTAPcmqjxzbOvb797UqlK6tXkXQ+
         wDYZ4gxViBM/+AALmc2kQ37zqM1zCMHWNnREa/QPRR2xzk3q05HNLn6Ze6zpxH///DFr
         oZT0pqKXdxE1hIw4cE67xvmi/A4+UITc7akroCC+E7KY/O3ysoX/Em5ddgLEQw9IkNu9
         3yfKuD6VPFHE6Mw1vYPB4m4C66T/JxqPmZAyBhxQhLFomHW2KrKI7EGEeeD8RhSnAARk
         SKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=GNd5U7EUPVD+zB/hu97uFgdxV2Mw2bPPLAAYxx2hJEKFAStpYyHYCqqc1ZsnmSMt3h
         GxfNuK8DggHkVhSgeNymS10P3Wtl3Rawzb0I+b+KtONA/8G8KJOf08gWVka5zGZ7PITC
         WUbIZVrYs07SIqY5QJ5k6kcA7hayvjZ931wD3740T4ULZgxTtH25NcY2klf+oJ6/ku1V
         eNS7MAV24CWUpGzQhqB2Ioot9p5DB8/odNOOTOQUdISxiaKJ8Anu85zTPZGVpmAZ3gdt
         BsejCU6ugduQrxGYoTSWXVbIZtqBnPuerd2fy+ZuOC/lRGm8RwOZ7q1F37Nq2pfJ2C1p
         kwBg==
X-Gm-Message-State: AGRZ1gKqQvqxs9Sw8/SYJn5wzgs1SbYOf7NSG6vLDgqyhmhnINVDD8fZ
        BF1ZhHXAw1M89r3ZeNLDUJCtFEmu
X-Google-Smtp-Source: AJdET5dGetzkSK7dG1zV5ClT7053w3zESCrIT5mxScXo3TGeN9/FfBNh3y/1q1d2kubtPj08aq3+5A==
X-Received: by 2002:a6b:bf43:: with SMTP id p64-v6mr12373018iof.41.1540360696339;
        Tue, 23 Oct 2018 22:58:16 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id x21-v6sm1824062ita.6.2018.10.23.22.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:58:15 -0700 (PDT)
Date:   Wed, 24 Oct 2018 01:58:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 2/2] completion: support `git mergetool --[no-]gui`
Message-ID: <e0b0585a17bb0b3f43fd930b449b9bc631d58f0f.1540360514.git.liu.denton@gmail.com>
References: <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3aond55.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Anmol Mago <anmolmago@gmail.com>
Signed-off-by: Brian Ho <briankyho@gmail.com>
Signed-off-by: David Lu <david.lu97@outlook.com>
Signed-off-by: Ryan Wang <shirui.wang@hotmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6..a45b4a050 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1833,7 +1833,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
2.19.1

