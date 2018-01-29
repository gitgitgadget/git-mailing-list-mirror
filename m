Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57FC1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeA2WjA (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:00 -0500
Received: from mail-qt0-f202.google.com ([209.85.216.202]:51707 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeA2Wi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:58 -0500
Received: by mail-qt0-f202.google.com with SMTP id j23so9470470qtn.18
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=y+EDoYT84qfpOiAge8YI79nmvFhg1YGNyHlMddC6Pn0=;
        b=t20nxE0SegneEHRtudkzk7+F2RZBBw8Ehd3XGpwdiX/f/igticc84vCX2awuCGFsIv
         3Ehil1GYd9gKlBRKKAnDyj+2C97rBckDPgch+BvLjRxtN5oh6F6dynMkjIrAbnQJsv2C
         NhEun8QDK4WO+coAJRsAKHoBSN0t7KWk6+H/7Dzm5zKMvEpuLOKZeKXaWH9CWm6PH5aN
         8LlaRt0EVMudbCdcSE8saOvoFvYyDHlRyqriM/cWNJicaosT+W0Uh6FIr4ksI4uBtwia
         7egKAfHDUZ1J39ITjJ2SjkxEPvL0mEK+C72pHFafP5jgjmatJzZdROGYzayTsCGvgj9q
         vPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=y+EDoYT84qfpOiAge8YI79nmvFhg1YGNyHlMddC6Pn0=;
        b=ayMrN9hfvMBYUEK66UVPKpn3EvoUvCcb/4AQcaLAdbLs9OwerznaUJOgZNmoV10bzL
         5tot5YShTASPMf+HyiuBXAsfSiNIT35WrfRQ8BWCTEa9hm0VkxWTvrH/imn6VFd6EVVN
         UxbdXf9Y/RxovR8LtfLQa7Q5gPluMI6gZmMovpS+lEtzxwQSqhtepOZBefkd25eEbww+
         OnUfGw9KCl1k2SvNFfci74Rs3AdKmMiKx8gGbt/AzisE8V7xkRyRyL/euozQzZ7K0jC/
         L446Xk2t2rPP1CmHvWKzypDD0CT0zSTDsB3mDJIHqJfMxUSW2PwpOWaXBfWB1lRw4sSn
         ayww==
X-Gm-Message-State: AKwxyteFwxu7vRiTcrEZTeW+ZA5xWZuAoN4ORqSR/pEWEIh4fzRltXVe
        LYvXnGn2oFIT7EuMfo/b7x0CRwBDAKzwSXJ2Pn2hvSzEkUOMIGS+6PpDg8LEiaHH4bUhHg3M/Xu
        NHFPH8f05Cy0vduIW5vLRSAAIwCpwR1xXPMQzHxHiJjo3hrtzNynL/XiBOA==
X-Google-Smtp-Source: AH8x2249ziy5RrTxjERyU6o1Ra+5SoxHUezDoeO/yqSmYvUju715PIi/HLulJA1mrkhyPaNe3c8KPJ740hs=
MIME-Version: 1.0
X-Received: by 10.237.60.248 with SMTP id e53mr17966062qtf.38.1517265538057;
 Mon, 29 Jan 2018 14:38:58 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:24 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-34-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 33/37] environment: rename 'namespace' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index 98f77ea95..270ba98b5 100644
--- a/environment.c
+++ b/environment.c
@@ -98,7 +98,7 @@ int ignore_untracked_cache_config;
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
-static char *namespace;
+static char *git_namespace;
 
 static const char *super_prefix;
 
@@ -156,8 +156,8 @@ void setup_git_env(void)
 	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
-	free(namespace);
-	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
+	free(git_namespace);
+	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(shallow_file, 0);
@@ -191,9 +191,9 @@ const char *get_git_common_dir(void)
 
 const char *get_git_namespace(void)
 {
-	if (!namespace)
+	if (!git_namespace)
 		BUG("git environment hasn't been setup");
-	return namespace;
+	return git_namespace;
 }
 
 const char *strip_namespace(const char *namespaced_ref)
-- 
2.16.0.rc1.238.g530d649a79-goog

