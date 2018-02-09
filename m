Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF291F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeBIUdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:33:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35747 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeBIUdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:33:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so18539901wme.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AKorwx9KBX13vlQZkNVWWmU+cDdbjdfD30t9lrGXwnE=;
        b=qMWgiKoNsrFk6o1Ex0kYuH8C8stbmC7U5Aer+ro6bvlcpF1oZNdUTmJjGM0+JfnW47
         8+aICgX0Z2QyDb+gFSdULTH/DqNCEsH2j8ZDZj5QrcM+yorVVS5XDu6EICjEAXgYxVmF
         FweICw7FyWZdjX8tDmzt9oSx/oZoAbqXsTBOyXppBhYX+aazHuK/x5c3N8Nvm5SX2/K3
         +sFDPRDZFHM7kgKFgmr+0pnAXP2r5WIqfGXGyMjMjbrMB1JU1CDy8Z9QxCSqIRSocT6O
         Nue+jNkUYfbM/n3m1yP29jxCRN5J1/wBCpOIqeNTTF3bu3LAcq0EcRNwwhryIQdYlnwG
         sQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AKorwx9KBX13vlQZkNVWWmU+cDdbjdfD30t9lrGXwnE=;
        b=WzePJKwMxFcLCd2E3Zdj1gXMmSOQhf58MOEVybBpDIUA3aF4FKbQjY0A5FgZSKop4H
         Xyjt7VEGkvA9VaVB6xbgW/9Glo9th0vaS3i+NcAoT5FRuXycxpMW+T4JCWFgyHo88r+t
         BEeGhjr69v2JxMmqN+fAFWw4ujVu8kXGRLpLCnwC/HAjJGJ3+i1GgSImkgLNt7N9Y43N
         Q0q8sbz6D8LK+rKvjVxNwdevV4b1w4AL+C03w8rN1dcC0EgbfQf1hBQ5jRh2PN+Ra/oX
         kXcTRYxJuFaxYbl56N9/y27RqHa63SF0fx7A96UjJ42KOdbf6HAppeSShpMG5871P9se
         PJ9A==
X-Gm-Message-State: APf1xPAfhT3Kq+2gcTk/0abyHU34iNNEltC0Eqn66UBYTk9/uDuL6eTV
        9tNy/o+joxsZqNF+usfylX+dwla+
X-Google-Smtp-Source: AH8x227n5Z/O/qGBVq+eo/hLKNAgJsCy19mKYsVujc7VCMTWFVtvlN0ccWPvn2aL0/3cKTbF5tAkVg==
X-Received: by 10.28.235.6 with SMTP id j6mr2762090wmh.22.1518208398600;
        Fri, 09 Feb 2018 12:33:18 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:33:17 -0800 (PST)
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
Subject: [PATCH v5 17/17] fetch: make the --prune-tags work with <url>
Date:   Fri,  9 Feb 2018 20:32:16 +0000
Message-Id: <20180209203216.11560-18-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
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
 t/t5510-fetch.sh            | 16 +++++++---------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index af12310f75..e319935597 100644
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
index 227dd70b7b..dce2371302 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -738,18 +738,15 @@ test_configured_prune unset unset unset true pruned  kept \
 	"--prune origin +refs/heads/*:refs/remotes/origin/*"
 
 # Pruning that also takes place if a file:// url replaces a named
-# remote, with the exception of --prune-tags on the command-line
-# (arbitrary limitation).
-#
-# However, because there's no implicit
+# remote. However, because there's no implicit
 # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
 # command-line negates --prune-tags, the branches will not be pruned.
 test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
 test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept   pruned "origin --prune --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "--prune --prune-tags origin" "link"
+test_configured_prune_type unset unset unset unset kept   pruned "--prune --prune-tags origin" "link"
 test_configured_prune_type unset unset true  unset pruned pruned "--prune origin" "name"
 test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
 test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
@@ -761,8 +758,9 @@ test_configured_prune_type unset  true true  unset kept   pruned "origin" "link"
 test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
 test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
 
-# Interaction between --prune-tags and no "fetch" config in the remote
-# at all.
+# When all remote.origin.fetch settings are deleted a --prune
+# --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
+# tags, but not tracking branches, will be deleted.
 test_expect_success 'remove remote.origin.fetch "one"' '
 	(
 		cd one &&
@@ -770,7 +768,7 @@ test_expect_success 'remove remote.origin.fetch "one"' '
 	)
 '
 test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept kept   "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "link"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

