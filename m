Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9622202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 15:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdKTP2T (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 10:28:19 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdKTP2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 10:28:18 -0500
Received: by mail-pf0-f193.google.com with SMTP id r62so7528093pfd.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 07:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=etuqHSHOflUFxyTIu0VU8G1WKKuJn1Db5oKfLuHDAzg=;
        b=uGdmOs5q7UacbHGxdIAkYiriudOaLxpQF3yxmIxITqW3mbcBI5dL9mnYGBWmB1Ppot
         JGR1uOvb19gaKlgEXl4UZvTJZ/4o6whukASB2rF+CyqnAs3x++YbzMcuea+tNmHaq4WB
         Twn10n9oX045cKFrG3Y1SSEtFMZxckOkHGdCC7+OlkEQs7kHK40vCZe4Y5qUz/vk/JqV
         S5eOOyMSzWljmHn2su3AhaIwmWmVos/quRYzu9O1whsWdU3+C9dBZ2Ncktoo1aUmrFAa
         LbqdD0p5czaK7eeKD1nT+dU44ZHBwhG/qsA0wRAL5Rut45Q4Y89NYo9XcB4NrCmDyxZP
         LMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=etuqHSHOflUFxyTIu0VU8G1WKKuJn1Db5oKfLuHDAzg=;
        b=scGkzgcOAtU79xRtp7n6+yFQyfZjvJeuVWjRGk/vrjFs1nHsQn5vANpbFWtCrRC7NF
         aXxeNzclmH/RA8xAAQvrKCwpkoG2qzN3lcYS+OLzrvLE5cUQtphP4DjF4W1ZlGi3G0i2
         UsEWnRo2Oa0VxfdbOXrcQvgSBEI5b7plzsn8IzDDBhoJDo2trQGhoDfqU4KeW3BaWYto
         f4sYExzDaYeSwgSMx3JNMXCvGMtHjEST2YhBwITvXuBAJPazagQiZKUFYESoO1Vsvs2q
         q5isLIAxwFAmZhYhrgJNPOc5qIDmiL+Xq+gUs3X7B33Tv/3FPSaC5LJaSL8lz/WxfCyZ
         zjDQ==
X-Gm-Message-State: AJaThX5O5UJ+Y50G3HPuTXaF6cQsAvZ0q/u/HnSqxBQxgg3AOFqp96aB
        ryRrJQK7oRfnFcaqIaZMzkP3n/tp
X-Google-Smtp-Source: AGs4zMa5u4mjuu7NpNyxp+GcpO8uexIA4BLUIpyAa+ecjMeMjqDypfyjR3G9UkS+Ir4d6l0nAMM8QA==
X-Received: by 10.159.246.20 with SMTP id b20mr13982154pls.95.1511191698159;
        Mon, 20 Nov 2017 07:28:18 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73ca:5b3a:a0bc:36c6:4f00:c705])
        by smtp.gmail.com with ESMTPSA id y5sm20854493pfa.128.2017.11.20.07.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 07:28:17 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] git-rebase: clean up dashed-usages in messages
Date:   Mon, 20 Nov 2017 20:56:52 +0530
Message-Id: <20171120152652.9413-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
In-Reply-To: <xmqqmv3hokvx.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv3hokvx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6344e8d5e..2f5d138a0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -9,7 +9,7 @@ OPTIONS_STUCKLONG=t
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase --continue | --abort | --skip | --edit-todo
+git rebase --continue | --abort | --skip | --edit-todo
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
@@ -216,7 +216,7 @@ run_pre_rebase_hook () {
 }
 
 test -f "$apply_dir"/applying &&
-	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
+	die "$(gettext "It looks like 'git am' is in progress. Cannot rebase.")"
 
 if test -d "$apply_dir"
 then
-- 
2.15.0.291.g0d8980c5d

