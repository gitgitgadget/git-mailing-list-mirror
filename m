Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E39A1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 01:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbcKVBgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 20:36:00 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35487 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbcKVBf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 20:35:59 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so1489196pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J9TqMOd8dzht73R7YKB8//LsITZ884IvYJMJhh26H90=;
        b=oTwBNbGggy5wXqRLLKm/g9cqMhGKsknX7ov/cX9Fl+2MNfaPVN2naiKT9oganLqNmj
         C0twc2ysYd7CoMwK9XkAfgyhk8JVwFrTkvNUCw68EWdKVvKB+De/jpfyQMgYb1+r1IUh
         oXWKy4UhZSnv2Nta/cl5DdZaK/L+VJxZ/GrdNsDpcCnzpaXOqFd2mfxQJ9CdY0KVqkYd
         aHM6NvVr0+5Au2O5dJoqwJev9QDWWsIzA8DhZr77F1G7GehwBWcbr5tXuklnKyMNNx6l
         KyLGAFek9YoTHHAKQ2jUwaRVPzc6lNWm3dvsYgRolZuMlDTb9Xxtbm57afGxyk6wBk1b
         MYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J9TqMOd8dzht73R7YKB8//LsITZ884IvYJMJhh26H90=;
        b=TyiAMYj4uqF13u+RUbomExv6UJvmfs9cA7UDRwUchtlx6RwMEOVqlpFWT6GBHHJaMb
         oqWtx0qP9vbefDZ+B1tSbLwKvv+kEfBK8dtffxC943oWqVqVrgmhRo2w0M44l9xTjRK+
         /wsr/zNwgm8lmT5iPndvVCNICrCc1aaZgG3u0w8K8L+pBLZwTXUGorCNoOhf8neGtwJj
         5GJMWbaltKujs7EuX/DTZhj+HNgmo3dFPiJ89/VivVel3rbRdL+qI/TO/obXbETp4bg3
         LJk4IjI1ykHS/m7u3VgVk+e9eQadpaf+q2zXmQCnQxaMTi3knGcqlAcZsH67JPAzSjyP
         ti6Q==
X-Gm-Message-State: AKaTC00NeIrMoPCT3FpgY3fYXODj7NIyY2VmVLMVwmtlVNPYrQ9+raV9L5BOpiFp+CtrryLj
X-Received: by 10.99.209.5 with SMTP id k5mr37873456pgg.13.1479778558648;
        Mon, 21 Nov 2016 17:35:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id o1sm22206023pgf.35.2016.11.21.17.35.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 17:35:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/3]  submodule-config: clarify/cleanup docs and header
Date:   Mon, 21 Nov 2016 17:35:47 -0800
Message-Id: <20161122013550.1800-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

replacing sb/submodule-config-cleanup

v3:
diff to current origin/sb/submodule-config-cleanup:
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 1df7a827ff..e06a3fd2de 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -49,17 +49,17 @@ Functions
 
 `const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::
 
-	Lookup values for one submodule by its commit_sha1 and path.
+	Lookup values for one submodule by its commit_or_tree and path.
 
 `const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::
 
 	The same as above but lookup by name.
 
 Whenever a submodule configuration is parsed in `parse_submodule_config_option`
-via e.g. `gitmodules_config()`, it will be overwrite the entry with the sha1
-zeroed out.  So in the normal case, when HEAD:.gitmodules is parsed first and
-then overlayed with the repository configuration, the null_sha1 entry contains
-the local configuration of a submodule (e.g. consolidated values from local git
+via e.g. `gitmodules_config()`, it will be overwrite the null_sha1 entry.
+So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
+with the repository configuration, the null_sha1 entry contains the local
+configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
 
 For an example usage see test-submodule-config.c.
diff --git a/submodule-config.c b/submodule-config.c
index 4c5f5d074b..d88a746c56 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -448,7 +448,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 
 	/* fill the submodule config into the cache */
 	parameter.cache = cache;
-	// todo: get the actual tree here:
 	parameter.commit_or_tree = commit_or_tree;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
        
v2:
addressed Jacobs concerns in patch2, fixing all occurrences of commit_sha1.

Thanks,
Stefan

interdiff to v1:
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 1df7a827ff..a91c1f085e 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -49,7 +49,7 @@ Functions

 `const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::

-       Lookup values for one submodule by its commit_sha1 and path.
+       Lookup values for one submodule by its commit_or_tree and path.

 `const struct submodule *submodule_from_name(const unsigned char *commit_or_tree, const char *name)`::


v1:
A small series that would have helped me understand the submodule config
once again.

Thanks,
Stefan

Stefan Beller (3):
  submodule config: inline config_from_{name, path}
  submodule-config: rename commit_sha1 to commit_or_tree
  submodule-config: clarify parsing of null_sha1 element

 Documentation/technical/api-submodule-config.txt | 13 ++++--
 submodule-config.c                               | 58 ++++++++++--------------
 submodule-config.h                               |  4 +-
 t/t7411-submodule-config.sh                      | 11 +++++
 4 files changed, 44 insertions(+), 42 deletions(-)

-- 
2.11.0.rc2.18.g0126045.dirty

