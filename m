Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA0320A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeLOAKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:42 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:55079 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLOAKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:41 -0500
Received: by mail-it1-f201.google.com with SMTP id v3so7434989itf.4
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gsNcA98bV/H6Yf7PlDzny9PrakCE9G8VUa4MitNMiS8=;
        b=Q3jMdzsrb8nTxQd5AzALJdxH1wI3eaQZadjYcw7Tcc4TbU7SbSy3Toos0lkcU68clu
         1jJv2CUJZGL3iglFQMcg+2FZuCPCYmLUIIKJlsBFVPOExNLaZ+HCb/sZgJoxSpu9RS6c
         FfxHjSuWVAkcbvpPx0DVVHY4Jped0HEFK91zoWZRDYgzy9Wgz5zA3k16GxBzoav5QArF
         mTOcUFxkVN8Su1/sgIpcLaaIaFRiEpehnpQa4ya6nomnOCxumX1zw58MbRJ70pMh/GeZ
         Q3pxLgFODHngTqOdpCxVTk0pEBnbVqU7cs1mUxF+1eKdQOCJjj15PaH+qxtmId8HRl5G
         OvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gsNcA98bV/H6Yf7PlDzny9PrakCE9G8VUa4MitNMiS8=;
        b=YQeSx+cFcvkEIvkMQkbobdJOOdN24KsxOvoxrCuus1CV8oGOuoG4cSe+UZr09zcGCq
         hYaDKXcLtMMXZYRjkoHJltujSg9AHEcMOZ8mMWUsIi4rOQAfuXMXD3+azL9Bt8k3R9+8
         o1st13cOXmDoLgDwfj1orA+8lyqhpVewkES8i+ABFIS2GHB2zB91iBsPD4mKTJg/+F3h
         LBaqFpRE52alVm/htd8ZYrOzsGEKWjbHOe5QHUhpFU8A2ruUqP0LCO4u2+SI1kTSWiJl
         jLxJpaLYJHa5DmSuFi5RcUm+jSyEHOdNkxb9maPnNnFTf8UU09Tih04U64fkJl3dAb/t
         vgKw==
X-Gm-Message-State: AA+aEWbF1YuBCBaEeFqBpDEegtA4SRj585j/IGNVauwmgIGE5cE725QA
        TDPOZ5787do82+JU1lpFexi5PHHFXGnq0GND9moJ6KufeOhHmEZhQjiDaQp47CdY8Ahg4iCRfoq
        5NgDF8KnKgI5lnCZ89c2dczdiIkqS4u+Mhzg/tomzqDekf3QPqPmKP6gTA71N
X-Google-Smtp-Source: AFSGD/XSAvs2e3vDsjztyhKRfQVjxpikqSozPQXvkqRhFzYHSN0PFNvJi1JEoI9Dg7c62Zgj4lLcgJcbEWzL
X-Received: by 2002:a24:244:: with SMTP id 65mr4744988itu.3.1544832640508;
 Fri, 14 Dec 2018 16:10:40 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:42 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-24-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 23/23] t/helper/test-repository: celebrate independence from the_repository
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                    |  2 ++
 t/helper/test-repository.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index 59c8a93046..8864d7ec15 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,6 +1033,8 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
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
2.20.0.405.gbc1bbc6f85-goog

