Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FD71FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbdBEU0d (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33788 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753023AbdBEU0a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so17856712wmv.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4RO0Pby+c+e4O7A5i8qSXXzmomh1u0IWdPQIbMMRayE=;
        b=jDpkz7X0WYqwA8SV+dkXX1WHbtE0edqYeFSmNlftzkA/IPIpW86xWrfty7cKlddvcL
         Kx3IGzl3NAYelzEUJcF0H6F6qyBPI3RwVu0lMw5/WmjUCuMhB+mfQcWtv8Ug/DH7OJJa
         qQEkfPfhj0TBsodhP+2hs8f68CFFhnVoqp9l4O3aw+ONoyKrJwYf7RyeBczaSpQ3ueC2
         vtCrRTtmwyd35ci81a3Ys2kK/xRPPxBkqetQAY7Jxv4WoqjXnRuEU5/TeDZiY4he3nKU
         uWpmkkaX/ellS6NIuqgHuH+Pa42OvSxREbOv0cKS1aq71aeuOCUHj85fok1WTecDDfxv
         edEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4RO0Pby+c+e4O7A5i8qSXXzmomh1u0IWdPQIbMMRayE=;
        b=kdaeZZM1WR0lZRUqXMc1j7cDDlY+fksa5ifQsZyypORTpzTLIyNazzfCiF/4LsF1P/
         8vOYUVEJAqxk/eJ+nmnJJg81Sx+3s5px/laQLshmmRzTkYTSdoyq+aVd9taJHmWzL0dr
         ozTDTvQyvybOJmm6YuhODxjd/fxjWTlShx6n/l8Mdm3qeQ5JCZtqe1qwWE+hPeW3+K6A
         h4iOp2aeaeHjN09PY/cbbBvTU6yB096nnc0lGvhyrij2Oy/1B7cUIkDB85DoAR1nv7iW
         ClAyJfOdjBjY9WB7Xyiwf3nEt9PgLXYRFdzk4YCddkmHek6mf+6CzH9OeOk0huAMQaDz
         ucxw==
X-Gm-Message-State: AMke39mU7bymLEx8TQzqfJUawXSMI0uhJ9SR59Lw9bAO3GRot2TN8IeJ2g6KSb9hJlaItw==
X-Received: by 10.28.23.70 with SMTP id 67mr5526982wmx.23.1486326378935;
        Sun, 05 Feb 2017 12:26:18 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id v128sm9037458wmv.2.2017.02.05.12.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:18 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/5] Documentation/stash: remove mention of git reset --hard
Date:   Sun,  5 Feb 2017 20:26:38 +0000
Message-Id: <20170205202642.14216-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't mention git reset --hard in the documentation for git stash save.
It's an implementation detail that doesn't matter to the end user and
thus shouldn't be exposed to them.  In addition it's not quite true for
git stash -p, and will not be true when a filename argument to limit the
stash to a few files is introduced.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e6..2e9e344cd7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -47,8 +47,9 @@ OPTIONS
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	Save your local modifications to a new 'stash', and run `git reset
-	--hard` to revert them.  The <message> part is optional and gives
+	Save your local modifications to a new 'stash' and roll them
+	back to HEAD (in the working tree and in the index).
+	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
-- 
2.12.0.rc0.208.g81c5d00b20.dirty

