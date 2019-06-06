Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB0E1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 02:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFFC2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 22:28:06 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36494 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFFC2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 22:28:06 -0400
Received: by mail-oi1-f172.google.com with SMTP id w7so525038oic.3
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiCEwMiQ3mKlCsayBwZv7G4yYca4dtsdyw95Ja/lIQg=;
        b=BDkxmWmX+ZkFNUvaO42bO1nnV06eBCxr7QA6HbsXdBHd667XIh4YnmsoOw+FLwSUQt
         txoxVaqG2f/D9IJ8RQD8fbouvvDyPPYBwEzSVVcnLXx4e/3/J7Lz6cz2itHcbcLEjMPy
         dek7L/czMErRvNpVHurN347wFhuFL6ydLc053XoE0guZxosKYzHI8nFl08ao0XgsH48o
         o4h1F3bfNg+Nacim9pHFwEBUynh0Dlnz5DqXTYO688nfkd/7l7M1Mwg24LoCGLHuK+2G
         IwBspKEvdpeNwVvXcDmx/yafZthh5LlNLvE3BjM5YYzJhJaLUeIS2g4uHunB+8j2nIIS
         JD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiCEwMiQ3mKlCsayBwZv7G4yYca4dtsdyw95Ja/lIQg=;
        b=VDCjqcE3wTxWR20c/HFCccGColQa4pQprVVQ00NEEAMi8RF30y/E2WmRnpSUl1Q1VG
         IHOrSZyXtK3RztLsXrU8kNcA/sI4eAAGgNBMUbHKVR413zpypt4Q1S9XsbYEfaO6Eh5W
         nIdAVF186FofWcb32KnYZLQTYL/gY3tbgwYJsAw+I4/RmXnIzHugUU2gKozz99SB4Jhq
         pQCflkPCyS9tV4gpoK+iXeukNWbwlj40V2PbtJhCpH0HOIXqmMDRXO4RFwhlwPWkGGfQ
         PlXLM3uDXsuEoxH89rlsiBGNBRCeRk6XBvHMBy2ui/DToJV52cZb7aBVqDEMaSZtGl0j
         JZHQ==
X-Gm-Message-State: APjAAAWqa5gZ56/InC3auRUxO+c2QJv1R7aA6iFA4jSVuIPtyv+mPRxQ
        lvjTwhmRsvxLIjplCOQvJYXKH/wSb/4=
X-Google-Smtp-Source: APXvYqwHDJX2jZyJBaLOJvm0PVUl/a2LHmOchcVtIk80AvIRX9XawbCk91oQ5V7H01IM0FsWYQlZcw==
X-Received: by 2002:a05:6808:28f:: with SMTP id z15mr1382092oic.32.1559788085147;
        Wed, 05 Jun 2019 19:28:05 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id c204sm260413oih.19.2019.06.05.19.28.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 19:28:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCHt2] completion: prompt: fix for Zsh
Date:   Wed,  5 Jun 2019 21:28:03 -0500
Message-Id: <20190606022803.3222-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can add colour in Zsh without the need of pcmode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 983e419d2b..fd2b049dbd 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -506,9 +506,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.21.0

