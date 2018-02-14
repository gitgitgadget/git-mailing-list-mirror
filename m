Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70311F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162505AbeBNTBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:00 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:45609 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162500AbeBNTA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:56 -0500
Received: by mail-qt0-f201.google.com with SMTP id q3so5893430qtq.12
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ryhYyuzMzTtnyv4MtmhnuGO0FWv3w5rxwj9V9jP6MkE=;
        b=KjxW0TSxv0PtpuVUSs5VwMXdsHbEUAUbrERTzBtKzSJ1//E4fOQIdVJJhFPhQ3QK/B
         I3b1Fu+F9SGXbVUJ5O4FzCuG3viXz2BL2+s86m3+9zCTQkxz0d+06ELcHHMGFMyQSC2a
         wnqyvk7U54wfZag24WPROrn4aChNJRZGpR43Wra8uIIHCwSiQAC6/Odr09hKa3MZsOZs
         GKSjmRsr3KoLAmDGHhlqWbyjHdO+aX4Cb427XF5oCOCrMoU8Am21UI4XMjH4raZle1hH
         +cmhvuz+YOreYOrYaFgTsazUksycTdRYZ3loh6i8EW3oOvqCh4WZ8WMbFK1Fja7GxoHt
         oQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ryhYyuzMzTtnyv4MtmhnuGO0FWv3w5rxwj9V9jP6MkE=;
        b=Jn3f84uqTCkfmn8eE7eGvrGWeroj5h0Ki1WbXYxOxctevSOilRPinI91ZejWleUzOW
         kjgjJkzrgVUtayxKo5UOfzZzPM60PHES7739EQgRzO+Qyj/chFHvCgDVcCVw4aTkkRbX
         oBUKu6PPNvxfJpq93CDlYaOHsLiB+IgyQgj06wxzIQ+Diks6+OJ4H23AFpEBYEg2qBCO
         wIOsZ35Ae/Zsb94ypD/pYtvNJVW/fFDzssnWrqYSCCFHJ77HJe8E2HYEy0LgAVVOrxIh
         FHsL2dMkiJYbNFJIf34tQOJPoFNF2TsGUtJ4nMquQkivJrViYMQnaiiubenWen47ESOI
         2vdg==
X-Gm-Message-State: APf1xPAm3rp9jQ8EuqjNGvCfHeS/EyiOM0U4nEWHd1q4SX7pWe30cbuJ
        mu25A7A4b9IqwKftZW8sd0JrTs2qqN1J+z736AK4uoVuEmSSJUEJ5TGsqjjl9b8srP32ITSO6w/
        9KGAJWWmF728on6vSw6l08uG2W8lXwuEZtbQvDeRvlmASrHZ8sWTIO1U6og==
X-Google-Smtp-Source: AH8x225IXSLdoVOJWaWFi3ZKdpfhboiGfZoGMXE1xo7xx/m5OA1utzovyHpl+kMwF9cKncFytncab1KKv8o=
MIME-Version: 1.0
X-Received: by 10.55.71.79 with SMTP id u76mr54082qka.2.1518634855624; Wed, 14
 Feb 2018 11:00:55 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:27 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-6-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 05/37] rev-parse: rename 'this' variable
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/rev-parse.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74aa644cb..171c7a2b4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -243,28 +243,28 @@ static int show_file(const char *arg, int output_prefix)
 static int try_difference(const char *arg)
 {
 	char *dotdot;
-	struct object_id oid;
-	struct object_id end;
-	const char *next;
-	const char *this;
+	struct object_id start_oid;
+	struct object_id end_oid;
+	const char *end;
+	const char *start;
 	int symmetric;
 	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
-	next = dotdot + 2;
-	this = arg;
-	symmetric = (*next == '.');
+	end = dotdot + 2;
+	start = arg;
+	symmetric = (*end == '.');
 
 	*dotdot = 0;
-	next += symmetric;
+	end += symmetric;
 
-	if (!*next)
-		next = head_by_default;
+	if (!*end)
+		end = head_by_default;
 	if (dotdot == arg)
-		this = head_by_default;
+		start = head_by_default;
 
-	if (this == head_by_default && next == head_by_default &&
+	if (start == head_by_default && end == head_by_default &&
 	    !symmetric) {
 		/*
 		 * Just ".."?  That is not a range but the
@@ -274,14 +274,14 @@ static int try_difference(const char *arg)
 		return 0;
 	}
 
-	if (!get_oid_committish(this, &oid) && !get_oid_committish(next, &end)) {
-		show_rev(NORMAL, &end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, &oid, this);
+	if (!get_oid_committish(start, &start_oid) && !get_oid_committish(end, &end_oid)) {
+		show_rev(NORMAL, &end_oid, end);
+		show_rev(symmetric ? NORMAL : REVERSED, &start_oid, start);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(&oid);
-			b = lookup_commit_reference(&end);
+			a = lookup_commit_reference(&start_oid);
+			b = lookup_commit_reference(&end_oid);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
-- 
2.16.1.291.g4437f3f132-goog

