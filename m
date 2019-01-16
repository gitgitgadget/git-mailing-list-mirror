Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7665E1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbfAPNaa (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39384 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbfAPNa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so1983831wmi.4
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZWNfRTgp+m/ej482CEXCeyP8ot1hSOx4QEB+D6QxsA=;
        b=H526F/b2BkNQGpKCud7jqr45qmuYE22I3zwKF2pzIGKiOVpjToOBWxJM/qJjm/rp7B
         BOqamg6nWXyjRzuoM824dLG5IizQwm617F31SF9TMA59AZsGbdSbNouk9f34en71bpwa
         8y9Y8/0DLt++0Qea8Fojsy/pxiS5KHR3mfF0s6A+Fsg+wDCDKCs8hz77xd9hvMsm/ztg
         l6xgJeNrlWbklSXbT7V/IbP36pie4OsQltYt2QfBa2W3seZPrWCy4mFSaaMfbC23kWHv
         S+I7o55pVom+54X5l/5Zw0Wt4Ys5AjNt3mTdDo5owv1KsSGazm7g4rW8lzyduG5uwDv7
         oFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZWNfRTgp+m/ej482CEXCeyP8ot1hSOx4QEB+D6QxsA=;
        b=Yu2ACp9S4H3haqnjKaLsRmgpyTkNXhWdKOlfWZXjkjO6W4Bf5BGs2IgNbPSrLlXQ2m
         LwTzXdPa1a70T2F7gkGbHZE25oWQm+UJFhNFJBbD5xkIfoVan9tp/mWZe77/2xVmAu1N
         aLsYwnbXotxLAnk9wOOc9jLvlXl1ZHIjUkYh3/dfr4xXsVnvk3BXEdZ3Q3c+T1+lrgW8
         fER3WstZcj4c9XAiSZHdB/1+45hTX33iViaEZiqevLYThSWjjBQq/KL4xwmAb7uO4HfB
         oMOYifBZ0vI/x3Dl76NtxzuOiWzBGLeVVfUpI4VOVPpvMkmd0rvFKt5h1dnXoHLWiUhq
         L+GQ==
X-Gm-Message-State: AJcUukfMHwl9r43eVfyHc4O+S6Rxpj7kPHVR4WE/VtFfJx3GS0YhWdsi
        UOe3vIZcBu91bhvfgDPTA8pDF5qFmhc=
X-Google-Smtp-Source: ALg8bN5jBAbse1K9vjnvieaLsDkssOPbI3mfLMSQGVOGir/GJzfFUvn/ecD9xPGcWZ38IovWbLxUYg==
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr8024260wmd.68.1547645426336;
        Wed, 16 Jan 2019 05:30:26 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:25 -0800 (PST)
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
Subject: [PATCH v5 9/9] commit-graph write: emit a percentage for all progress
Date:   Wed, 16 Jan 2019 14:29:47 +0100
Message-Id: <20190116132947.26025-10-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 01ca387774 ("commit-graph: split up close_reachable()
progress output", 2018-11-19) by making the progress bars in
close_reachable() report a completion percentage. This fixes the last
occurrence where in the commit graph writing where we didn't report
that.

The change in 01ca387774 split up the 1x progress bar in
close_reachable() into 3x, but left them as dumb counters without a
percentage completion. Fixing that is easy, and the only reason it
wasn't done already is because that commit was rushed in during the
v2.20.0 RC period to fix the unrelated issue of over-reporting commit
numbers. See [1] and follow-ups for ML activity at the time and [2]
for an alternative approach where the progress bars weren't split up.

Now for e.g. linux.git we'll emit:

    $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    Finding commits for commit graph among packed objects: 100% (6529159/6529159), done.
    Expanding reachable commits in commit graph: 100% (815990/815980), done.
    Computing commit graph generation numbers: 100% (815983/815983), done.
    Writing out commit graph in 4 passes: 100% (3263932/3263932), done.

1. https://public-inbox.org/git/20181119202300.18670-1-avarab@gmail.com/
2. https://public-inbox.org/git/20181122153922.16912-11-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 60ec7c1b22..b6a074c80d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -653,15 +653,15 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
 
 static void close_reachable(struct packed_oid_list *oids, int report_progress)
 {
-	int i, j;
+	int i;
 	struct commit *commit;
 	struct progress *progress = NULL;
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Loading known commits in commit graph"), j = 0);
+			_("Loading known commits in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
@@ -675,9 +675,9 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 	 */
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Expanding reachable commits in commit graph"), j = 0);
+			_("Expanding reachable commits in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
@@ -687,9 +687,9 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Clearing commit marks in commit graph"), j = 0);
+			_("Clearing commit marks in commit graph"), oids->nr);
 	for (i = 0; i < oids->nr; i++) {
-		display_progress(progress, ++j);
+		display_progress(progress, i + 1);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit)
-- 
2.20.1.153.gd81d796ee0

