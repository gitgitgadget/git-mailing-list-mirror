Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFB82092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbdAVW56 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:58 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36561 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdAVW5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so22107965wmr.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YMTylKXuKD1dpZk6TqONAA81GePHxdQa425SWQUpqI=;
        b=cDX0ypfLUsr1uKM2NpdJiYvBwn/aRFqkqXvccRdcdOjOxsmH64Q3Ss+d517xPDme1h
         av2CTfmuEcpJcsaNYGp0Ac1kbDlYLBJaYDYOjglUvUkF+gHXjSzs8Dn/KvUZm593POz2
         woExKz3Vyvogrt4oCMrH/dxRSVEF6vwKOBkDHBBEHABTO40Hfv3pEW+8+X9ET5EPFV81
         F5t8jby1V7YViw4T6pF8o/Wm6i5XN4AalYZ7qo86WqiwKGb4Bl7PM+mp5VU1mRg5nKDs
         LYGR/FwJ/XGAhyG8otZFEa2AnfbAJ70eFvjS0ssdsLYC4eTbUBVpfvE5EbLiKP/qWL/D
         3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YMTylKXuKD1dpZk6TqONAA81GePHxdQa425SWQUpqI=;
        b=aqEpEBKQZNER0jDEiofWNXR/8CIdjYe0Ls62MtweqRM0K3yR+auZStp+7arWXUqT6b
         VomkBpLTmq5t8CAUkygwaqsawH3AYsWbSEIN+fk4tRmyTaOE6LwZkYitC0gtWSDTAtnq
         iN0lBS5vGZb8BRbSFFQlRPbZmhsOX6dydv11aJdU010AnTWlx620SVnVmwm0gyG8P9GO
         m2bzomzD26TUgV+I4Y/BWMer+76slFAlURpLjB4UfD0LFZEP6TtZMKVaZxUWeDClWgE+
         v/3wMoQrLJWZPOz+XhKoymrd4ZwQJP/evZkSA7Ol14+JPbsnB0kDpCNL1sMpaHS6QeQX
         56GQ==
X-Gm-Message-State: AIkVDXKQ/qffaci7e+hsZAO04gEEm+g0DZRegpsBWMqGErYL09IJdeRnX7v4RNc+qtVUUQ==
X-Received: by 10.28.111.75 with SMTP id k72mr11018847wmc.39.1485125870210;
        Sun, 22 Jan 2017 14:57:50 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:49 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 3/7] completion: improve bash completion for git-add
Date:   Sun, 22 Jan 2017 23:57:20 +0100
Message-Id: <20170122225724.19360-4-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Add some long-options for git-add and improve path completion when the
--update flag is given.
---
 contrib/completion/git-completion.bash | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8329f09..652c7e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -947,13 +947,17 @@ _git_add ()
 	--*)
 		__gitcomp "
 			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add
+			--ignore-errors --intent-to-add --force --edit --chmod=
 			"
 		return
 	esac
 
-	# XXX should we check for --update and --all options ?
-	__git_complete_index_file "--others --modified --directory --no-empty-directory"
+	local complete_opt="--others --modified --directory --no-empty-directory"
+	if test -n "$(__git_find_on_cmdline "-u --update")"
+	then
+		complete_opt="--modified"
+	fi
+	__git_complete_index_file "$complete_opt"
 }
 
 _git_archive ()
-- 
2.10.2

