Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4161F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJaHEr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:47 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:42203 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbeJaHEr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:47 -0400
Received: by mail-it1-f201.google.com with SMTP id v125-v6so15004305ita.7
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oCFpG/Wk+VMsIjbN9prN7LaRV6lmcmh4LeWkH2+hnFA=;
        b=KLdtE5pMDZg/2Xp52JudCrZ8qx2Ok7uqvWsBtUcr9OZc69IHzrEC+NudF3mKw11TxO
         fFPaHJV2SODMSZiG6V5vaY9ESMpLC+cMSNdFGkuZUudIabPd6tA7+opNolkSrCpN993S
         +4X3md7O1nNgyX/wYaqLsPgyXG1XyhUcm6YZnSY320HUkKk3DL0cQYz7hSggdH4NwvOv
         dELkiM2ABS6CXRpN6An/b93ABQF+Wm+MQQrFT+y6+8mhWuXSsmngqvkloBefXCeEDq3q
         szqoidmsMQA8MLcs/ZRg7HtquZDjBn52pgf1SvljrkpByq+FaKKzlXItl204fTaMcTxW
         /w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oCFpG/Wk+VMsIjbN9prN7LaRV6lmcmh4LeWkH2+hnFA=;
        b=fPx242nrMHSTKvgpXDtlZcSg34JC6LiG1+VRdHjv6RgAl+2xrrLOd0QWryUokUyr5/
         k0Abgsxku862VYdSILq/74Xmvc9NTJDS09Uy/YK/oYl1Api+UiIS29IA6O7Q895gpSMe
         bZbr+jxITB2X8tJrccFEa64+sZPkut0MLK8fZryRZzVEw18dmJgzrJUBCPkKr/pInF17
         WVtgrTKttNkehttjGzEPgiSMYlGT2vfeZC9vVAltR7GoTFvHtFWrHScRTWCT8H+pule3
         MGk5HcFJU3u8D/4UByNH1cvB1Ylo5dmIud4cXZd/wg74jW/Umr/iMF6NfhGoz67s0wbF
         dYcQ==
X-Gm-Message-State: AGRZ1gK/sBVUMCqADMgyKEkJ5941gZMf47jo2tkXwaSe4N04HboyVUHS
        /qR3Z5XWKHL6teyEMC+URFxAFHaF0B4fyZYRGWbdN2dIn3sNOFOFB9vBRsKoI42mN2LI+VyXmiW
        d87f8XlGCffYMWksngV+M32taoBGDApyMf+l7fv23MjTCVo4GyuB1r51TRjvl
X-Google-Smtp-Source: AJdET5eMNwamD/gyKDgHK6zIEYjuukyzhkh3XHzIno2CdjDTElStZm1yFezzc6LKvttYaUH+jtY8QbbxK/Vq
X-Received: by 2002:a24:1d0b:: with SMTP id 11-v6mr315075itj.11.1540937371924;
 Tue, 30 Oct 2018 15:09:31 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:17 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-25-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 24/24] t/helper/test-repository: celebrate independence from the_repository
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dade47c06c (commit-graph: add repo arg to graph readers, 2018-07-11)
brought more independence from the_repository to the commit graph, however
it was not completely independent of the_repository, as the previous
patches show.

To ensure we're not accessing the_repository by accident, we'd ideally
assign NULL to the_repository to trigger a segfault on access.

We currently have a temporary hack in cache.h, which relies on
the_hash_algo (which is a short form of the_repository->hash_algo) to
be set, so we cannot do that. The next best thing is to set all fields of
the_repository to 0, so any accidental access is more likely to be found.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h                    |  2 ++
 t/helper/test-repository.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index f7fabdde8f..9f535040af 100644
--- a/cache.h
+++ b/cache.h
@@ -1035,6 +1035,8 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 	 *
 	 * This will need to be extended or ripped out when we learn about
 	 * hashes of different sizes.
+	 *
+	 * When ripping this out, see TODO in test-repository.c.
 	 */
 	if (the_hash_algo->rawsz != 20)
 		BUG("hash size not yet supported by hashcmp");
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 6a84a53efb..f7f8618445 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -17,6 +17,11 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	setup_git_env(gitdir);
 
+	memset(the_repository, 0, sizeof(*the_repository));
+
+	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
@@ -43,6 +48,11 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 	setup_git_env(gitdir);
 
+	memset(the_repository, 0, sizeof(*the_repository));
+
+	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
-- 
2.19.1.930.g4563a0d9d0-goog

