Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDFC20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdFAVlv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:41:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36649 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdFAVlt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id h4so5248395lfj.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vPVK1ZtAKfXAVJ+EaOfEIkr8NSQkEsVfrZ2CBRZrydA=;
        b=qHrlN7oFqsFVLOYRqDwhUeD8K4GF7jx0tk8aaAvTOeRGsfVc/L/+B6o8La0KI4qk+P
         hABEaIEqBQ+uco25RX6wreVgA2rVHaUHKHZsgYITGKpmv3mAZ5SNcQcj9Q5LRZiVq0K3
         JdK7W0RLwaFWmBFdJuQuflqs0yngrAYe34eEgKa2/VsmgUu38eaLdb1bb7JJ5Pg7sLsd
         Hqi6b9c9+Xvr1uH9MsXUCeQhcU418NK+EX7BWqWlQWDyqVMZlA8zwr08vau6vbWn+DlQ
         jZDrSdgPZgNGXWRtAoUfRwkQ+bGYyn1H29daVWqrl/cVol2GAknF+bvatZVX4kAUEWmC
         Trkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vPVK1ZtAKfXAVJ+EaOfEIkr8NSQkEsVfrZ2CBRZrydA=;
        b=kuI/U8n334kCCPjHwxsf8UoNmk79nnXjG4/amdovu/pvNg0gaDsJU4OboA5ZkHJdRf
         I0qBHaOKFCT0lBLH6Sln4aDXFOJMDqKch61VdG4HgA2EefGJIzVd32Ftu7ytaknCQorL
         4R2Cw4rb22nrCxdVJ7lgexqod6paVN3ef/+AxenbsSvibMIGJRQ5p3t/5wUTErNK8g/7
         raDIXTqCGk2w3xEFVrcDE+mJbYf2e1SgwSiD1qOEpovxQ02wrt7SH7rw1TcLU3tVrjCT
         DehC0Nx98weS8FCvjqaqXfw+N6nTV/0hpoy7dwwmgtLhpHjjMrvVYiMNclkRi/gQ43Vj
         L/+w==
X-Gm-Message-State: AODbwcBr76S+PEdiSawrY99GAAGbQpzGFuDAs/t0xv76w7u+CjK9VeBd
        wOUuisI63rIdxhz+ZXk=
X-Received: by 10.46.84.21 with SMTP id i21mr1127328ljb.125.1496353307336;
        Thu, 01 Jun 2017 14:41:47 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:46 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/6] completion: Add git config core completions
Date:   Sat, 27 May 2017 08:25:48 +0200
Message-Id: <20170527062552.13996-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing completions for git config core:

* core.checkStat
* core.commentChar
* core.hideDotFiles
* core.hooksPath
* core.packedRefsTimeout
* core.precomposeUnicode
* core.protectHFS
* core.protectNTFS
* core.splitIndex
* core.sshCommand

Note that some configs are only used for some platforms
(hideDotFiles on Windows and precomposeUnicode on Mac).

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4e5e2eaae..de9306173 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2403,6 +2403,8 @@ _git_config ()
 		core.autocrlf
 		core.bare
 		core.bigFileThreshold
+		core.checkStat
+		core.commentChar
 		core.compression
 		core.createObject
 		core.deltaBaseCacheLimit
@@ -2412,6 +2414,8 @@ _git_config ()
 		core.fileMode
 		core.fsyncobjectfiles
 		core.gitProxy
+		core.hideDotFiles
+		core.hooksPath
 		core.ignoreStat
 		core.ignorecase
 		core.logAllRefUpdates
@@ -2419,14 +2423,20 @@ _git_config ()
 		core.notesRef
 		core.packedGitLimit
 		core.packedGitWindowSize
+		core.packedRefsTimeout
 		core.pager
+		core.precomposeUnicode
 		core.preferSymlinkRefs
 		core.preloadindex
+		core.protectHFS
+		core.protectNTFS
 		core.quotepath
 		core.repositoryFormatVersion
 		core.safecrlf
 		core.sharedRepository
 		core.sparseCheckout
+		core.splitIndex
+		core.sshCommand
 		core.symlinks
 		core.trustctime
 		core.untrackedCache
-- 
2.13.0

