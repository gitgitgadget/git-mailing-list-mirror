Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AC61F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbeKTGs2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:48:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55852 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTGs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:48:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so1728wmc.5
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f34/RYpTO5cdolY7KcoVY9SKG5/K3R6sZAEG5jpAe8g=;
        b=Ph2ox7/lte9qRuya8E1PYodyxNa71xU1kCn4HqB2oc1EcDThYOW0pudfwt0iCdZJF2
         WwUMmxIubjU2Zx/ZMT6j2aS0QkMKXQYOJrrEYysmC7LaIKJosE+xuASOwcNDKSIFExLz
         IgtUaxOrcfIny/0qGWcvvSCfY+3lTDcNRBkfHGJNmCVGSs1REk6OilJUCiCUw4vabohR
         nhKy+cWNEPxFkG8/bOiExma/Ni1y3jp+FTXZ/xx+fD/SvSD3uTHuWFP/3BU+DTeGRkcH
         HSYOzOS2ICB30vLZYAxoir1BYNfPiUmH4yQ8BeX/tOT1BqvYZghdhvIysueadg+kTeGx
         A2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f34/RYpTO5cdolY7KcoVY9SKG5/K3R6sZAEG5jpAe8g=;
        b=uELlyjRNqX3aZ5zSiR5WtCc/BNn77H+I+uGymQTmrwuN0dKc3B3PkQ0R6RwpYbLl9G
         FjZpfCTZ+1nzFMXxTDXc7IPJVdkAAfbmYZyVBph75rbla8k4cUfehD9Od4eURraNFwVg
         9mK0h1O9JXFEJfazh5TgXQ/s8eUDEbD8N8C8PQHDtcueQ1poaB4tKs1sTwD0D8ubsbFK
         vyH4J0ji7VWlzhrT20Qyio0TZF9Iim9wiNAmsNK8i5EfUHj4x4XIzK2H6s80K0pSQ6zI
         Y1idhuGTQ0yvqXbwQtjujnIK6QXqckZxxrydQgYtlHMZ1lipY4fBI+ZgqD9E8rIamaXx
         oMvA==
X-Gm-Message-State: AGRZ1gKo0bQpx6QFDqKWwhfvNfrM3GbYAuyuPedAd+V110XnfA/Gzb0Q
        VIhNmK7H9zl56FtJi6pfAQzQRXkn
X-Google-Smtp-Source: AJdET5cdn9RUTSzJ2epC1rV/0PcDU0jYMOIJjRXVz3Oy28J+NIBURpOZE9e7xpY9UWZRi+h/GZYehA==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr8448778wmf.130.1542658988530;
        Mon, 19 Nov 2018 12:23:08 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w9sm13356832wme.47.2018.11.19.12.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:23:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] commit-graph: split up close_reachable() progress output
Date:   Mon, 19 Nov 2018 20:23:00 +0000
Message-Id: <20181119202300.18670-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181119160207.GU30222@szeder.dev>
References: <20181119160207.GU30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the progress output added in 7b0f229222 ("commit-graph write:
add progress output", 2018-09-17) so that the total numbers it reports
aren't higher than the total number of commits anymore. See [1] for a
bug report pointing that out.

When I added this I wasn't intending to provide an accurate count, but
just have some progress output to show the user the command wasn't
hanging[2]. But since we are showing numbers, let's make them
accurate. The progress descriptions were suggested by Derrick Stolee
in [3].

As noted in [2] we are unlikely to show anything except the "Expanding
reachable..." message even on fairly large repositories such as
linux.git. On a test repository I have with north of 7 million commits
all of these are displayed. Two of them don't show up for long, but as
noted in [5] future-proofing this for if the loops become more
expensive in the future makes sense.

1. https://public-inbox.org/git/20181010203738.GE23446@szeder.dev/
2. https://public-inbox.org/git/87pnwhea8y.fsf@evledraar.gmail.com/
3. https://public-inbox.org/git/f7a0cbee-863c-61d3-4959-5cec8b43c705@gmail.com/
4. https://public-inbox.org/git/20181015160545.GG19800@szeder.dev/
5. https://public-inbox.org/git/87murle8da.fsf@evledraar.gmail.com/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Nov 19 2018, SZEDER Gábor wrote:

> Ping?
>
> We are at -rc0, this progress output is a new feature since v2.19.0,
> and the numbers shown are still way off.

I was under the impression after your
https://public-inbox.org/git/20181015160545.GG19800@szeder.dev/ that
you were going to do some more digging & report back, so I put it on
my "waiting for feedback" list and then forgot about it.

But here's a patch that should address the issue you pointed out, but
I don't know if it fixes whatever you were alluding to in the linked
E-Mail above.

 commit-graph.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..9c0d6914be 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -641,26 +641,29 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
 
 static void close_reachable(struct packed_oid_list *oids, int report_progress)
 {
-	int i;
+	int i, j;
 	struct commit *commit;
 	struct progress *progress = NULL;
-	int j = 0;
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commits in commit graph"), 0);
+			_("Loading known commits in commit graph"), j = 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
 	}
+	stop_progress(&progress);
 
 	/*
 	 * As this loop runs, oids->nr may grow, but not more
 	 * than the number of missing commits in the reachable
 	 * closure.
 	 */
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Expanding reachable commits in commit graph"), j = 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
@@ -668,7 +671,11 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 		if (commit && !parse_commit(commit))
 			add_missing_parents(oids, commit);
 	}
+	stop_progress(&progress);
 
+	if (report_progress)
+		progress = start_delayed_progress(
+			_("Clearing commit marks in commit graph"), j = 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.19.1.1182.g4ecb1133ce

