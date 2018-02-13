Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D31C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966171AbeBMXeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 18:34:00 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:59106 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966169AbeBMXd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 18:33:57 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52070 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elk5E-000525-Vf
        for git@vger.kernel.org; Tue, 13 Feb 2018 18:33:57 -0500
Date:   Tue, 13 Feb 2018 18:33:54 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Correct mispellings of ".gitmodule" to ".gitmodules"
Message-ID: <alpine.LFD.2.21.1802131831410.16573@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


There are a small number of misspellings, ".gitmodule", scattered
throughout the code base, correct them ... no apparent functional
changes.

 Documentation/technical/api-submodule-config.txt | 2 +-
 contrib/subtree/git-subtree.txt                  | 2 +-
 submodule-config.c                               | 4 ++--
 t/t5526-fetch-submodules.sh                      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

---

  fairly brainless correction of what appear to be minor misspellings.

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 3dce003fd..ee907c4a8 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -4,7 +4,7 @@ submodule config cache API
 The submodule config cache API allows to read submodule
 configurations/information from specified revisions. Internally
 information is lazily read into a cache that is used to avoid
-unnecessary parsing of the same .gitmodule files. Lookups can be done by
+unnecessary parsing of the same .gitmodules files. Lookups can be done by
 submodule path or name.

 Usage
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 60d76cddd..352deda69 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -28,7 +28,7 @@ as a subdirectory of your application.

 Subtrees are not to be confused with submodules, which are meant for
 the same task. Unlike submodules, subtrees do not need any special
-constructions (like .gitmodule files or gitlinks) be present in
+constructions (like .gitmodules files or gitlinks) be present in
 your repository, and do not force end-users of your
 repository to do anything special or to understand how subtrees
 work. A subtree is just a subdirectory that can be
diff --git a/submodule-config.c b/submodule-config.c
index 2aa8a1747..602ba8ca8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -9,7 +9,7 @@
 /*
  * submodule cache lookup structure
  * There is one shared set of 'struct submodule' entries which can be
- * looked up by their sha1 blob id of the .gitmodule file and either
+ * looked up by their sha1 blob id of the .gitmodules file and either
  * using path or name as key.
  * for_path stores submodule entries with path as key
  * for_name stores submodule entries with name as key
@@ -91,7 +91,7 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 	/*
 	 * We iterate over the name hash here to be symmetric with the
 	 * allocation of struct submodule entries. Each is allocated by
-	 * their .gitmodule blob sha1 and submodule name.
+	 * their .gitmodules blob sha1 and submodule name.
 	 */
 	hashmap_iter_init(&cache->for_name, &iter);
 	while ((entry = hashmap_iter_next(&iter)))
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a552ad4ea..74486c73b 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -485,7 +485,7 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	)
 '

-test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodule entry" '
+test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .gitmodules entry" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
