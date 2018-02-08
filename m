Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198601F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeBHQUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35400 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeBHQUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so11074871wme.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rTVBHEtL0/iF4f+MiUIvasdbqJZNh2Wac2DqwxizskM=;
        b=jtcdqgtXeFr8qtI0jcZZW1OmFYJObXbGtiRUASrZKKNjusjI5AxAzbhVI4uaEvD+1T
         r46zY8c8zm6inExavKImDoSTo2jRKJi0I/uqf5qr6zhYIc9INIsUM1hxS2TDYRrKwiRD
         r6dMq+YmfuHUU9n1qKkUSvRFK3bkkNLpxq1JPAMNHS2Oz6BXWbR5opmbm733kah1ftnT
         79UilEmE8xHLxGYurF6aneXwKFfU+RuklduHOq7bGQ3P//3Q1I4SGFk46mYRG5wGs+pq
         O42QCP8okggVqcSwu6qsYlWtKwnXdeTXARE7LDYw5zOfgFiYlu5U3kneJBRA7S7Wc8sC
         POjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rTVBHEtL0/iF4f+MiUIvasdbqJZNh2Wac2DqwxizskM=;
        b=bjPS4NQZ9YEsio/QYQ8s+QM0AiJIJ4XIotfpQ59TPKrojaG/W8WG4wBJ/fkJa5MprN
         HBjz3KxoI1BjZdmz/oca+4xvA1sZD2jNg3lu5ySNabkAg74ovoJUYZyd4MQEcqQhn+Cd
         lfbeoUL57GujrOIA+zuvDc3C7rURaeVOldYaqLXHpMCTDPKaDLnCnR0SZY40pbbzuwr8
         /OF1cp0OZLAWqgXAHWZosJT0rumRalJZnkhoLXNvCC+eLUhQUA7VoHLxHPbDVgDwtTye
         mcGYsEhju96P/PXrmJ51KGIFEKMz6gt0rn7l4cNQiMAHIaxryhzqmEndrbAVHJtKWBMT
         s51A==
X-Gm-Message-State: APf1xPAJfrHfEejIjcwqrmJU6JlXn6DUmgqSzenlh73JHAlA2XqxvybI
        94UdlZC/USHouSvLeBYxqhyMQSHb
X-Google-Smtp-Source: AH8x226+pVY/AkuRMxiZRdMAdjLhhVLffW7ZDuohuDvtUqhkaIQoBoo2lewlYoRE93Gfdl+2I8guKg==
X-Received: by 10.28.14.10 with SMTP id 10mr1665490wmo.2.1518106832077;
        Thu, 08 Feb 2018 08:20:32 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/17] fetch: make the --fetch-prune work with <url>
Date:   Thu,  8 Feb 2018 16:19:36 +0000
Message-Id: <20180208161936.8196-18-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the new --prune-tags option work properly when git-fetch is
invoked with a <url> parameter instead of a <remote name>
parameter.

This change is split off from the introduction of --prune-tags due to
the relative complexity of munging the incoming argv, which is easier
to review as a separate change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fetch.txt | 21 ++++++---------------
 builtin/fetch.c             | 17 ++++++++++++++---
 t/t5510-fetch.sh            |  6 +++---
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 574206d139..03666f6215 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -175,24 +175,15 @@ It's reasonable to e.g. configure `fetch.pruneTags=true` in
 run, without making every invocation of `git fetch` without `--prune`
 an error.
 
-Another special case of `--prune-tags` is that
-`refs/tags/*:refs/tags/*` will not be implicitly provided if an URL is
-being fetched. I.e.:
-
-------------------------------------------------
-$ git fetch <url> --prune --prune-tags
-------------------------------------------------
-
-Will prune no tags, as opposed to:
+Pruning tags with `--prune-tags` also works when fetching a URL
+instead of a named remote. These will all prune tags not found on
+origin:
 
 ------------------------------------------------
 $ git fetch origin --prune --prune-tags
-------------------------------------------------
-
-To prune tags given a URL supply the refspec explicitly:
-
-------------------------------------------------
-$ git fetch <url> --prune 'refs/tags/*:refs/tags/*'
+$ git fetch origin --prune 'refs/tags/*:refs/tags/*'
+$ git fetch <url of origin> --prune --prune-tags
+$ git fetch <url of origin> --prune 'refs/tags/*:refs/tags/*'
 ------------------------------------------------
 
 OUTPUT
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55a0fc37be..c96f17a9a3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1283,7 +1283,10 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 	static const char **refs = NULL;
 	struct refspec *refspec;
 	int ref_nr = 0;
+	int j = 0;
 	int exit_code;
+	int maybe_prune_tags;
+	int remote_via_config = remote_is_configured(remote, 0);
 
 	if (!remote)
 		die(_("No remote repository specified.  Please, specify either a URL or a\n"
@@ -1311,13 +1314,21 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 			prune_tags = PRUNE_TAGS_BY_DEFAULT;
 	}
 
-	if (prune_tags_ok && prune_tags && remote_is_configured(remote, 0))
+	maybe_prune_tags = prune_tags_ok && prune_tags;
+	if (maybe_prune_tags && remote_via_config)
 		add_prune_tags_to_fetch_refspec(remote);
 
+	if (argc > 0 || (maybe_prune_tags && !remote_via_config)) {
+		size_t nr_alloc = st_add3(argc, maybe_prune_tags, 1);
+		refs = xcalloc(nr_alloc, sizeof(const char *));
+		if (maybe_prune_tags) {
+			refs[j++] = xstrdup("refs/tags/*:refs/tags/*");
+			ref_nr++;
+		}
+	}
+
 	if (argc > 0) {
-		int j = 0;
 		int i;
-		refs = xcalloc(st_add(argc, 1), sizeof(const char *));
 		for (i = 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				i++;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6f3ab7695a..297590814d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -748,9 +748,9 @@ test_configured_prune unset unset unset true pruned  kept \
 test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "name"
 test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept   pruned "origin --prune --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "--prune --prune-tags origin" "link"
+test_configured_prune_type unset unset unset unset kept   pruned "--prune --prune-tags origin" "link"
 test_configured_prune_type unset unset true  unset pruned pruned "--prune origin" "name"
 test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
 test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
@@ -772,7 +772,7 @@ test_expect_success 'remove remote.origin.fetch "one"' '
 	)
 '
 test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept kept   "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "link"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

