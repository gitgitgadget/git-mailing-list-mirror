Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BFB61F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbfJWUjC (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 16:39:02 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40273 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405522AbfJWUjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 16:39:00 -0400
Received: by mail-wm1-f51.google.com with SMTP id b24so292252wmj.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iiHG0bAdCt5r4BN5/Zj/jbA/xKnBZ5t8na8H+mTk9+s=;
        b=NULTVX5zNcp8+fFdLKsrmIWOX2i4AimtKRTGrVSUbUlbeUdagbHFFHVM5kMFwOnECp
         rFnNhI7bXu6SFKrxBy8tO0CxiGepc1mWTRZGcxsCE+4oD0e+OO/gVDNqYtju19FhM2/v
         WF4tXYxNtcRT23CeqS6RkkoAilfu2kCpzawSf3yZREuF2SFZWR+acWcg/P96U0mz37f2
         7JeuAaW2iQXswtMQzXTdTuOqw6HRPkpfEl/jGDc9CdippXH/q0iWDp4gp3NVcwo/JugE
         W07ju/PsS6whGZXYjeOBJ6K2jjAMgL6Ihcp+mdMFDHF/UGTU7lD8fC/bX3YDfP/c5FGY
         68ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iiHG0bAdCt5r4BN5/Zj/jbA/xKnBZ5t8na8H+mTk9+s=;
        b=Rfe6Hi5NPXHV7l5ek38/dMhPEIh5/Qf0o+/Ccau6jLXCbSM8L44b9Grs0QjxAAE/gC
         PjdvKFAYzJGZ8oDjaN4e4j0PIj5/OjeRqfoqpnSc05bfFm3ehzz69rZlFe+gxEOXOg/g
         UfKGo6jumsRjq87YV97z8iS09sxX/t2aILryrBy0F/U/rc8mQXNGJOM563c/gQ2xM/QW
         1n6lEmo61IZw/gF94kZd23+6NQX6e0RJBCi7BSidtAi5GavFyU6Iow8VnmbkCDgW3hjf
         GzDHxnsfhw9z1MXWO1D2g9v8VNLKP0j3E1peUcjIsqGjDdczP9Ez7C1OxW2Akej4o0BG
         F08w==
X-Gm-Message-State: APjAAAVD+MsAWX5dOdMxyPHtLbdz3A4WRVBzztdgMUDXOuP46Wxirnv6
        LymLwFKsErvmOyO4wXJTUF8TUQJa
X-Google-Smtp-Source: APXvYqy+0F90IniN9gOQ5AJgKZT9XG5vV0Rd72vp1vDjjIsPnpOpHCNxZkMMkGGmoWDMjkXhMdLIcA==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr1567033wmi.56.1571863138966;
        Wed, 23 Oct 2019 13:38:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62sm7709219wre.38.2019.10.23.13.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:38:58 -0700 (PDT)
Message-Id: <095b43f606a352527c9e0551adbd8a6af2061176.1571863137.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.420.git.1571863137.gitgitgadget@gmail.com>
References: <pull.420.git.1571863137.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 20:38:57 +0000
Subject: [PATCH 1/1] repo-settings: read an int for index.version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Several config options were combined into a repo_settings struct in
ds/feature-macros, including a move of the "index.version" config
setting in 7211b9e (repo-settings: consolidate some config settings,
2019-08-13).

Unfortunately, that file looked like a lot of boilerplate and what is
clearly a factor of copy-paste overload, the config setting is parsed
with repo_config_ge_bool() instead of repo_config_get_int(). This means
that a setting "index.version=4" would not register correctly and would
revert to the default version of 3.

I caught this while incorporating v2.24.0-rc0 into the VFS for Git
codebase, where we really care that the index is in version 4.

This was not caught by the codebase because the version checks placed
in t1600-index.sh did not test the "basic" scenario enough. Here, we
modify the test to include these normal settings to not be overridden by
features.manyFiles or GIT_INDEX_VERSION. While the "default" version is
3, this is demoted to version 2 in do_write_index() when not necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 repo-settings.c  | 2 +-
 t/t1600-index.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/repo-settings.c b/repo-settings.c
index 05546db98e..a703e407a3 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -22,7 +22,7 @@ void prepare_repo_settings(struct repository *r)
 	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
-	if (!repo_config_get_bool(r, "index.version", &value))
+	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version = value;
 	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
 		if (value == 0)
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index c77721b580..b7c31aa86a 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -87,6 +87,10 @@ test_index_version () {
 }
 
 test_expect_success 'index version config precedence' '
+	test_index_version 0 false 0 2 &&
+	test_index_version 2 false 0 2 &&
+	test_index_version 3 false 0 2 &&
+	test_index_version 4 false 0 4 &&
 	test_index_version 2 false 4 4 &&
 	test_index_version 2 true 0 2 &&
 	test_index_version 0 true 0 4 &&
-- 
gitgitgadget
