Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A8F1FAE2
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162587AbeBNTCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:13 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:53850 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162565AbeBNTCL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:11 -0500
Received: by mail-ot0-f202.google.com with SMTP id z15so13301789otz.20
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=MhQ7PSBWJvMEHnNIPIUhj/HoYWrkxH9qQD5sUbq7r74=;
        b=A5FupcurGs2r20O1vKUGvieaGculxMFxjzKwQYh1rHh23GFNe4xWYDf2mvqPDoMO62
         9LWUPXFFJJvQD4vFNHzlxJwPj2NJ4glvNiKOLUL/EccMxF/gQmlP/NavEpAt9x6zY5D6
         62e3BoaDDyMuxMpYI+nHdduqHmNi+N21B4snWkPPk2y4lrZkcZlZF6WOaGo8LxTPSlIx
         P96QhizPic5aN37dqUuiJMUYIGCP42eIM9T6CRRqyy+nnjH465bhGpWdkcB+EOg6hZfp
         iHW5w8sSpmD1NU14zkmSI8JfjpO/mFxJElBQxAEPk+jN1koN3ks9Xr2jAEUnfOsLx6by
         ad2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=MhQ7PSBWJvMEHnNIPIUhj/HoYWrkxH9qQD5sUbq7r74=;
        b=NbCPbgLGactABSJiNWgxEKOtIdjAkCA9LuEQ5e3xT+p4HKWMEvt49SKOYT+OK5mHRI
         1pDZOJMRuXolnEdNS+XZwOS+3zLlb7yIwljdET6hrHdbTC9XUoMyZnNlMZOaiWVbtgxZ
         Ia+JOPX1UsBh1YQTCTtg9nDkM7ccWU5nvoSlRChap+YEmayER0r/JFXDf8gnQV2QSl/l
         0Rs3J0HlOHQ+bNNonPqKbODJpOTOIJ4AlWMLezgy3UzE1pp7vobWSwQ5QkDL55jBzrVg
         e6uAgnEvmwvO1m+0d5l+9NsVk9wRP4KaG7u8poJWea6L3d3QZuuyxxHlZxW7B4/dJqwt
         tN7A==
X-Gm-Message-State: APf1xPCEGN71qb+aohcJiDosrRqiofTuBAEEWZG6XJNCC7CB9f5e0b3R
        ljRoL/iNXq6PAQo5GnOEzRjT4mTQDVjeqrU05PaddB5+h7kfEH8USeByjz6o1fh2IlDTOafY/Y7
        id3GWD7xzIUTcXkzIV7iFWFRwrN4JNxZBI3nM8177q+KXTBlhA1Xdrn2W1A==
X-Google-Smtp-Source: AH8x224DRJ/sHrBlxDjgHhR/maRS7Gpj+ZatlOnSUO9+xl8F9ZTjFtYZmKqpde4sWAOIIYm9VlV+7UdCJMs=
MIME-Version: 1.0
X-Received: by 10.157.70.5 with SMTP id y5mr26219ote.74.1518634930973; Wed, 14
 Feb 2018 11:02:10 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:55 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-34-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 33/37] environment: rename 'namespace' variables
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
2.16.1.291.g4437f3f132-goog

