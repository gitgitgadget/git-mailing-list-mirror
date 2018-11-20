Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 142AD1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeKUGVb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeKUGVa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so3279077wrw.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7/012vgfZU58ex+5EZrccnyYPYhhrrQXZinDbn9r2w=;
        b=p2Pcw7OfZarDmeNH8wLjHCqNsalf2nk3QEt8+WbwMWL5sDdtJLbcTiGpt7VQAB5ToT
         SNW5Qi4trb6zQQgWX8bVxXPbKJvBP6J4eJN/LB6dNY/B4kI4YfwVw5X6e7WHY6bd1fZV
         yBXS6q8F+UJ4Sg22/7VT1IFLo6t087Ij6hf3KbH6VmS94pY+PBzM0UfRzeSWJJY44ozP
         3aOEVPVcCbxolNI6yHVl7KXrnqAf7Pp0pqkUvwUjzLLQN1edsynL48KzgzJFOB6F7Mo6
         nj8NAMQlzSNw06fhyOlutJgjDF67NcLMoTrxuK8pFyCvyByrMXoDiJsNfE7bhWSrynH2
         8ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7/012vgfZU58ex+5EZrccnyYPYhhrrQXZinDbn9r2w=;
        b=MsTOtZKAz6HJ3LJIn3kiKOcKiXYs7RsA9byvHLuE6646F/aWt1P4jnpCPGnlCc+Uax
         xrBvwzJHKBQq+oyz6rrSXGUVYroHFZLN59NwgyaPfe8TQEH12AQvzG5kUMqmOLSQYsb8
         GB90/7nonlT3vmTcup0nimAy2Vi5CMZJ5qxhPtbcjfXsijDvWqsoMkf5s6hrejYwweTR
         jfM/+gjIAQG3bOgD4XqfVU7rXNQBa6QHMNyMV6xe1sr0rmfUF5+qQSSocwxRepE1f9et
         KWXno4+gcijZ7VGt+/CqnRs/BAyobUakGgQFRWi/8NKiHcSOQxkFAxLyvtuJFYFaQEx7
         ZZRQ==
X-Gm-Message-State: AA+aEWYSwENU/r/yMrfFGtzp0k3eFG4rpPxcTrixwevzikJY7/AjGadk
        AN4zHWMOl8FPvDVSUYTVLC410pnp/KE=
X-Google-Smtp-Source: AFSGD/UhE8EbLoOelD00xlLR5pXIvtzXrpkupCO7dh/2BB4Vv/O2He7Ut0IBeDvsOtNNItlV55t1Ag==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr3096577wrv.147.1542743438881;
        Tue, 20 Nov 2018 11:50:38 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] commit-graph write: rephrase confusing progress output
Date:   Tue, 20 Nov 2018 19:50:22 +0000
Message-Id: <20181120195027.3260-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rephrase the title shown for the progress output emitted by
close_reachable(). The message I added in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) gave the impression that it
would count up to the number of commit objects.

But that's not what the number means. It just represents the work
we're doing in several for-loops to do various work before the graph
is written out. So let's just say "Annotating commit graph", that
title makes no such promises, and we can add other loops here in the
future and still consistently show progress output.

See [1] for the initial bug report & subsequent discussion about other
approaching to solving this.

1. https://public-inbox.org/git/20181015165447.GH19800@szeder.dev/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..e6d0d7722b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -648,7 +648,7 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commits in commit graph"), 0);
+			_("Annotating commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

