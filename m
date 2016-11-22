Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACA31FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbcKVUOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:14:46 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35904 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbcKVUOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:14:45 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so10819483pgc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 12:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JFbrgy9rC8QsT4lL4U4xUD1gcJe9F7XExI7fklXN5UI=;
        b=FhjoXuz1tZ0Mc1LTPHAjLVBcnxCMjJBuSFkm60/AuiehwP/LsbW9GdXu/dhprdtIlp
         SViWuyiFJ1P4I+Tg65TdiDpC+CAzQNMRswwu7OqrfuV08DEjHXKRz3JC/vTLXbojMApA
         L2ieUGJva3+1fJqcyTn10BVcpaCD+ptpRcSmhx4/dWwZqlzjX4l5lLT45Ardkh2atPP7
         d+UKu4CfpLQ7G+Iqq81HjBsgkYKCRjq0lA1gyfRbusOcDzH/mskUvYkGGIhlZ4B0ZqKs
         WkyI5MNq6f+O13GHxDMKDNkOeN1cdM94UL79/iKmGGMQmzKgbjOFCL+sIt49BJpeVczI
         tEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JFbrgy9rC8QsT4lL4U4xUD1gcJe9F7XExI7fklXN5UI=;
        b=mCeRh9WVzlG1ps5O+FOxcqBgnbnAYTr7C4mlxwiIp5JHdPTO5pcY01PeTWub4Bjdf4
         s8hodC7GW9qd8wjFzq3Fs6G2FGHVBp1Qx+Y5JWzo7Bj3uiPLW+CGjomHtr2iJqAebWFq
         3Oemq0yuX1cEj3q2e3JjWLXGpE0ccsspbmRQqwzefTzyPcMJ/ea3Rau+X8mX0cNJkhyw
         lvIiLeCvwCasbH9vOnlEnRRyCUyULXUDbfcjF/U70nEen27T5iFho7dqsX0FqwHRkDq5
         AM4qNZUhumfX5lXE/94NwgCj0c8ci3AKQmYsGcCclkGljq0gFAKPyaBaKeYy9xmN3595
         lv7Q==
X-Gm-Message-State: AKaTC03005gEu2nRQ1UFU/eE9Jwc0Pldme7PiR1sERDTQccV4dd9RMyqqqect9f9JppmufOm
X-Received: by 10.84.134.3 with SMTP id 3mr3132122plg.90.1479845684450;
        Tue, 22 Nov 2016 12:14:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id t184sm29137711pgt.36.2016.11.22.12.14.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 12:14:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/3] submodule-config: clarify/cleanup docs and header
Date:   Tue, 22 Nov 2016 12:14:35 -0800
Message-Id: <20161122201438.16069-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

replacing sb/submodule-config-cleanup

v4:
* renamed commit_or_tree to treeish_name
* added a test with a tag
* "it will overwrite" (removed the spurious "be").

v3:
diff to current origin/sb/submodule-config-cleanup:
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index 1df7a827ff..e06a3fd2de 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -49,17 +49,17 @@ Functions

 `const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::

-       Lookup values for one submodule by its commit_sha1 and path.
+       Lookup values for one submodule by its commit_or_tree and path.

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
-       // todo: get the actual tree here:
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
  submodule-config: rename commit_sha1 to treeish_name
  submodule-config: clarify parsing of null_sha1 element

 Documentation/technical/api-submodule-config.txt | 14 ++++--
 submodule-config.c                               | 58 ++++++++++--------------
 submodule-config.h                               |  4 +-
 t/t7411-submodule-config.sh                      | 14 ++++++
 4 files changed, 48 insertions(+), 42 deletions(-)

-- 
2.11.0.rc2.4.g3396b6f.dirty

